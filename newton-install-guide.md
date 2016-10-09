##### 控制节点
###### 配置网络接口
1. 将第一个接口作为管理接口  
	ip地址：10.0.0.11  
	子网掩码：255.255.255.0（或/24）  
	默认网关：10.0.0.1  
2. 将第二个接口作为提供者接口  
	不分配ip地址，修改`/etc/sysconfig/network-scripts/ifcfg-INTERFACE_NAME`文件：  
	```
	DEVICE=INTERFACE_NAME  
	TYPE=Ethernet  
	ONBOOT="yes"  
	BOOTPROTO="none"  
	```  
    HWADDR和UUID保持不变  
3. 重启系统  

###### 配置名称解析
1. 设置节点的hostname为controller  
2. 编辑/etc/hosts文件：
	```
    # controller
    10.0.0.11 controller
    # compute1
    10.0.0.31 compute1
    # block1
    10.0.0.41 block1
    # object1
    10.0.0.51 object1
    # object2
    10.0.0.52 object2
    ```
