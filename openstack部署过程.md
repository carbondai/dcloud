#一、硬件平台  
4台FT1500A服务器  
#二、安装操作系统  
操作系统为濮约刚修改过的centos7，使其能运行在国产化FT处理器上，安装过程如下：     
1. 从U盘启动后，按ctrl+alt+F2进入终端界面安装  
2. 输入`parted`命令，进入交互后输入`mklabel msdos`创建硬盘标签  
3. 输入`fdisk /dev/sda`将硬盘分为2个区，/dev/sda1为boot分区，一般500M足	够，`/dev/sda2`为主分区，自由设置或者为剩余所有空间  
4. 进行格式化、分区挂载、拷贝安装脚本和yum配置文件、使用yum源安装操作系统等操作，安装脚本为anzhuang.sh，yum配置文件为centos7.repo  
5. `chroot /mnt/sysimage`切换根目录，修改root用户密码`passwd root`  
6. 安装新内核  
`yum install kernel.aarch64`  
7. 重新生成initramfs.img文件  
`` dracut -f initramfs.img `uname -r` ``  
8. 使用麒麟liveos重新格式化/dev/sda1  
`mkfs.ext4 /dev/sda1`
#三、配置网络
设定为1台控制节点、2台计算节点、1台网络节点  
IP设置方案见“云方案.odt”  
更改/etc/hosts文件：以“ip 主机名”的形式写入文件，如192.168.100.11 controller  
`hostnamectl set-hostname xxx`  
更改/etc/resolv.conf，写入nameserver 192.168.100.11  
同步时间，方法见“记录.odt”  
#四、安装openstack
在控制节点上使用`packstack --answer-file=packstack-answers-pyg.txt`
#五、更改相关配置
- 上传镜像后，需要将镜像的元数据定义更新：
hw_firmware_type uefi
hw_video_model virtio
- 在2个计算节点上操作
- 安装qemu-system-aarch64和qemu-system-x86
- 进入目录/usr/libexec建立软链接
`ln -sf /usr/bin/qemu-system-aarch64 qemu-kvm`
- 修改/etc/libvirt/qemu.conf
添加
```
nvram=[ 
	"/usr/share/edk2/aarch64/QEMU_EFI.img:/usr/share/edk2/aarch64/VARS_QEMU_EFI.img"
    ]
```
- 下载 QEMU_EFI.img  VARS_QEMU_EFI.img两个文件到/usr/share/edk2/aarch64目录下
