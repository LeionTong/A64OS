dd if=/dev/zero of=FloppyDisk.img bs=1510400 count=1


qemu-img create -f qcow2 -o size=1.44M FloppyDisk.img

mkfs.vfat -F12 -S512 -s1 FloppyDisk.img

yasm boot.asm -o boot.bin
dd if=boot.bin of=FloppyDisk.img bs=512 count=1 conv=notrunc

yasm loader.asm -o loader.bin
sudo mount FloppyDisk.img /run/media/ -t vfat -o loop
sudo cp loader.bin /run/media/
sync
sudo umount /run/media/

qemu-system-x86_64 -fda FloppyDisk.img
