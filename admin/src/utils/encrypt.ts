import md5 from 'js-md5'
import sha1 from 'sha1'
import qs from 'qs'

/**
 * 数据加密
 * @param {*} obj 加密对象
 * @param {*} signKey 加密盐值
 */
export function getEncrypt(obj:any, signKey:any) {
  let arr = []
  const keys = []
  for (const i in obj) {
    if ( i !== 'signature' && i !== 'content') {
      keys.push(i)
    }
  }
  keys.sort()
  for (const i in keys) {
    arr[keys[i]] = obj[keys[i]]
  }
  const arr_str = qs.stringify(arr)

  let arr_sha1 = sha1(arr_str)
  arr_sha1 = arr_sha1 + signKey
  return md5(arr_sha1)
}
