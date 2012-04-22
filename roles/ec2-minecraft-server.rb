name "ec2-minecraft-server"
description "Minecraft Server on EC2"
run_list('role[minecraft-server]')

default_attributes(
                   :minecraft => {
                     :memory => { :max => '2400M'},
                     :message => 'FruityCraft Minecraft Server!',
                     :ops => [
                              'philloop',
                              'insane_creepah',
                              'stooferus'
                             ],
                     :whitelist => [
                                    'stooferus',
                                    'philloop',
                                    'insane_creepah',
                                    'Tobsy4inc',
                                    'Ties100100',
                                    'jamibo12',
                                    'jayx12',
                                    'minecrafterzrule'
                                   ],
                     :users => {
                       'stooferus' => { 'groups' => ['owner']},
                       'insane_creepah' => { 'groups' => ['crazy wolf']},
                       'philloop' => { 'groups' => ['turtley awesome']},
                       'jayx12' => { 'groups' => ['moderator']},
                       'minecrafterzrule' => { 'groups' => ['builder']},
                     }
                   })           
