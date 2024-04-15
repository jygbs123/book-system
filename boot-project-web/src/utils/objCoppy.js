//把obj1的数据复制到obj2
export default async function objCoppy(obj1,obj2){
    Object.keys(obj2).forEach(key =>{
        obj2[key] = obj1[key]
    })
}