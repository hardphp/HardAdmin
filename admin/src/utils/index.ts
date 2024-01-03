import { ElMessage } from 'element-plus';
import { useRoutesList } from './../stores/routesList';
import { useRouter } from 'vue-router';
import { getEncrypt } from '/@/utils/encrypt';

// 回显数据字典
export function selectDictLabel(datas: any, value: any) {
    var actions = [] as any;
    Object.keys(datas).some((key) => {
        if (datas[key].dictValue == ('' + value)) {
            actions.push(datas[key].dictLabel);
            return true;
        }
    })
    return actions.join('');
}


/**
 * 模板字符串解析，如：template = 'hahaha{name}_{id}' ,param = {name: 'hh', id: 1}
 * 解析后为 hahahahh_1
 * @param template 模板字符串
 * @param param   参数占位符
 * @returns
 */
 export function templateResolve(template: string, param: any) {
    return template.replace(/\{\w+\}/g, (word) => {
        const key = word.substring(1, word.length - 1);
        const value = param[key];
        if (value != null || value != undefined) {
            return value;
        }
        return "";
    });
}

// 首字符头像
export function letterAvatar(name: string, size = 60, color = '') {
    name = name || '';
    size = size || 60;
    var colours = [
            "#1abc9c", "#2ecc71", "#3498db", "#9b59b6", "#34495e", "#16a085", "#27ae60", "#2980b9", "#8e44ad", "#2c3e50",
            "#f1c40f", "#e67e22", "#e74c3c", "#00bcd4", "#95a5a6", "#f39c12", "#d35400", "#c0392b", "#bdc3c7", "#7f8c8d"
        ],
        nameSplit = String(name).split(' '),
        initials, charIndex, colourIndex, canvas, context, dataURI;

    if (nameSplit.length == 1) {
        initials = nameSplit[0] ? nameSplit[0].charAt(0) : '?';
    } else {
        initials = nameSplit[0].charAt(0) + nameSplit[1].charAt(0);
    }
    if (window.devicePixelRatio) {
        size = (size * window.devicePixelRatio);
    }
    initials = initials.toLocaleUpperCase()
    charIndex = (initials == '?' ? 72 : initials.charCodeAt(0)) - 64;
    colourIndex = charIndex % 20;
    canvas = document.createElement('canvas');
    canvas.width = size;
    canvas.height = size;
    context = canvas.getContext("2d") as any;

    context.fillStyle = color ? color : colours[colourIndex - 1];
    context.fillRect(0, 0, canvas.width, canvas.height);
    context.font = Math.round(canvas.width / 2) + "px 'Microsoft Yahei'";
    context.textAlign = "center";
    context.fillStyle = "#FFF";
    context.fillText(initials, size / 2, size / 1.5);
    dataURI = canvas.toDataURL();
    canvas = null;
    return dataURI;
}


/**
 * 构造树型结构数据
 * @param {*} data 数据源
 * @param {*} id id字段 默认 'id'
 * @param {*} parentId 父节点字段 默认 'parentId'
 * @param {*} children 孩子节点字段 默认 'children'
 */
 export function handleTree(data: any, id:string, parentId:string, children:string) {
	let config = {
		id: id || 'id',
		parentId: parentId || 'parentId',
		childrenList: children || 'children'
	};

	var childrenListMap:any = {};
	var nodeIds:any = {};
	var tree = [];

	for (let d of data) {
		let parentId = d[config.parentId];
		if (childrenListMap[parentId] == null) {
			childrenListMap[parentId] = [];
		}
		nodeIds[d[config.id]] = d;
		childrenListMap[parentId].push(d);
	}

	for (let d of data) {
		let parentId = d[config.parentId];
		if (nodeIds[parentId] == null) {
			tree.push(d);
		}
	}

	for (let t of tree) {
		adaptToChildrenList(t);
	}

	function adaptToChildrenList(o:any) {
		if (childrenListMap[o[config.id]] !== null) {
			o[config.childrenList] = childrenListMap[o[config.id]];
		}
		if (o[config.childrenList]) {
			for (let c of o[config.childrenList]) {
				adaptToChildrenList(c);
			}
		}
	}
	return tree;
}

export function navigeteTo(e:any){
    const router = useRouter()
    let dataset = e.currentTarget ? e.currentTarget.dataset : e;
	let { type } = dataset;
    if (type == 'page' || type == 'inner' || type == 'href') {
        router.push({
            path:dataset.url
        })
    }else{
        ElMessage.error('待实现点击事件');
    }

}


/**
 * 数据签名
 * @param {*} obj
 */
export function getSignature(obj:any) {
    let encrypt = {};
    if (obj) {
      encrypt = obj
    }
    // 签名
    const signature = getEncrypt(encrypt, '21232f297a57a5a743894a0e4a801fc')
    encrypt.signature = signature
    return encrypt
  }