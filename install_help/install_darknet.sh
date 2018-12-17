mkdir ~/darknet && cd ~/darknet && git init
git remote add gh git@github.com:benjaminabruzzo/darknet.git && git pull gh master && make


mkdir -p ~/ros/src/darknet_ros && cd ~/ros/src/darknet_ros && git init
git remote add gh git@github.com:benjaminabruzzo/darknet_ros.git && git pull gh master
echo "export DARKNET_PATH=~/ros/src/darknet_ros/darknet" >> ~/.bashrc

cp ~/ros/src/darknet_ros/darknet_ros/build_darknet.bash ~/ros/

