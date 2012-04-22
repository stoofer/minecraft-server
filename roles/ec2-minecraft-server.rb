name "ec2-minecraft-server"
description "Minecraft Server on EC2"
run_list('role[minecraft-server]')

default_attributes(
                   :minecraft => {
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
                       'stooferus' => { 'groups' => ['Owner']},
                       'insane_creepah' => { 'groups' => ['Admin']},
                       'philloop' => { 'groups' => ['Owner']},
                       'jayx12' => { 'groups' => ['Moderator']},
                       'minecrafterzrule' => { 'groups' => ['Builder']},
                     }
                   })           
