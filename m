Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7027A68FA
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 14:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfICMwH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 08:52:07 -0400
Received: from comms.puri.sm ([159.203.221.185]:47436 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfICMwG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Sep 2019 08:52:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 3E9BAE02E8;
        Tue,  3 Sep 2019 05:52:04 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sy00K6phQEhF; Tue,  3 Sep 2019 05:52:02 -0700 (PDT)
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: replace underscore with hyphen in
 device name
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20190903051802.22716-1-martin.kepplinger@puri.sm>
 <20190903134303.000008be@huawei.com>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Openpgp: preference=signencrypt
Autocrypt: addr=martin.kepplinger@puri.sm; keydata=
 mQINBFULfZABEADRxJqDOYAHfrp1w8Egcv88qoru37k1x0Ugy8S6qYtKLAAt7boZW+q5gPv3
 Sj2KjfkWA7gotXpASN21OIfE/puKGwhDLAySY1DGNMQ0gIVakUO0ji5GJPjeB9JlmN5hbA87
 Si9k3yKQQfv7Cf9Lr1iZaV4A4yjLP/JQMImaCVdC5KyqJ98Luwci1GbsLIGX3EEjfg1+MceO
 dnJTKZpBAKd1J7S2Ib3dRwvALdiD7zqMGqkw5xrtwasatS7pc6o/BFgA9GxbeIzKmvW/hc3Q
 amS/sB12BojyzdUJ3TnIoAqvwKTGcv5VYo2Z+3FV+/MJVXPo8cj2vmfxQx1WG4n6X0pK4X8A
 BkCKw2N/evMZblNqAzzGVtoJvqQYkzQ20Fm+d3wFl6lS1db4MB+kU13G8kEIE22Q3i6kx4NA
 N49FLlPeDabGfJUyDaZp5pmKdcd7/FIGH/HjShjx7g+LKSwWNMkDygr4WARAP4h8zYDZuNqe
 ofPvMLqJxHeexBPIGF/+OwMyTvM7otP5ODuFmq6OqjNPf1irJmkiFv3yEa+Ip0vZzwl4XvrZ
 U0IKjSy2rbRLg22NsJT0XVZJbutIXYSvIHGqSxzzfiOOLnRjR++fbeEoVlRJ4NZHDKCh3pJv
 LNd+j03jXr4Rm058YLgO7164yr7FhMZniBJw6z648rk8/8gGPQARAQABtC1NYXJ0aW4gS2Vw
 cGxpbmdlciA8bWFydGluLmtlcHBsaW5nZXJAcHVyaS5zbT6JAk4EEwEIADgWIQTyCCuID55C
 OTRobj9QA5jfWrOH0wUCXPSlkwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRBQA5jf
 WrOH06/FEACC/GTz88DOdWR5JgghjtOhaW+EfpFMquJaZwhsaVips7ttkTKbf95rzunhkf2e
 8YSalWfmyDzZlf/LKUTcmJZHeU7GAj/hBmxeKxo8yPWIQRQE74OEx5MrwPzL6X7LKzWYt4PT
 66bCD7896lhmsMP/Fih2SLKUtL0q41J2Ju/gFwQ6s7klxqZkgTJChKp4GfQrBSChVyYxSyYG
 UtjS4fTFQYfDKTqwXIZQgIt9tHz4gthJk4a6ZX/b68mRd11GAmFln8yA1WLYCQCYw+wsvCZ0
 Ua7gr6YANkMY91JChnezfHW/u/xZ1cCjNP2wpTf4eTMsV1kxW6lkoJRQv643PqzRR2rJPEaS
 biyg7AFZWza/z7rMB5m7r3wN7BKKAj7Lvt+xoLcncx4jLjgSlROtyRTrctBFXT7cIhcGWHw+
 Ib42JF0u96OlPYhRsaIVS3KaD40jMrXf6IEsQw3g6DnuRb2t5p61OX/d9AIcExyYwbdStENN
 gW9RurhmvW3z9gxvFEByjRE+uVoVuVPsZXwAZqFMi/iK4zRfnjdINYMcxKpjhj8vUdBDtZH3
 IpgcI8NemE3B3w/7d3aPjIBz3Igo5SJ3x9XX4hfiWXMU3cT7b5kPcqEN0uAW5RmTA/REC956
 rzZYU7WnSgkM8E8xetz5YuqpNeAmi4aeTPiKDo6By8vfJbkCDQRVC32QARAAxTazPZ9jfp6u
 C+BSiItjwkrFllNEVKptum98JJovWp1kibM+phl6iVo+wKFesNsm568viM2CAzezVlMr7F0u
 6NQNK6pu084W9yHSUKROFFr83Uin6t04U88tcCiBYLQ5G+TrVuGX/5qY1erVWI4ycdkqQzb8
 APbMFrW/sRb781f8wGXWhDs6Bd4PNYKHv7C0r8XYo77PeSqGSV/55lpSsmoE2+zR3MW5TVoa
 E83ZxhfqgtTIWMf88mg/20EIhYCRG0iOmjXytWf++xLm9xpMeKnKfWXQxRbfvKg3+KzF30A0
 hO3YByKENYnwtSBz8od32N7onG5++azxfuhYZG5MkaNeJPLKPQpyGMc2Ponp0BhCZTvxIbI8
 1ZeX6TC+OZbeW+03iGnC7Eo4yJ93QUkzWFOhGGEx0FHj+qBkDQLsREEYwsdxqqr9k1KUD1GF
 VDl0gzuKqiV4YjlJiFfHh9fbTDztr3Nl/raWNNxA3MtX9nstOr7b+PoA4gH1GXL9YSlXdfBP
 VnrhgpuuJYcqLy02i3/90Ukii990nmi5CzzhBVFwNjsZTXw7NRStIrPtKCa+eWRCOzfaOqBU
 KfmzXEHgMl4esqkyFu2MSvbR6clIVajkBmc4+dEgv13RJ9VWW6qNdQw7qTbDJafgQUbmOUMI
 ygDRjCAL2st/LiAi2MWgl80AEQEAAYkCHwQYAQIACQUCVQt9kAIbDAAKCRBQA5jfWrOH0wSZ
 EACpfQPYFL4Ii4IpSujqEfb1/nL+Mi+3NLrm8Hp3i/mVgMrUwBd4x0+nDxc7+Kw/IiXNcoQB
 Q3NC1vsssJ6D+06JOnGJWB9QwoyELGdQ7tSWna405rwDxcsynNnXDT0d39QwFN2nXCyys+7+
 Pri5gTyOByJ+E52F27bX29L05iVSRREVe1zLLjYkFQ4LDNStUp/camD6FOfb+9uVczsMoTZ1
 do2QtjJMlRlhShGz3GYUw52haWKfN3tsvrIHjZf2F5AYy5zOEgrf8O3jm2LDNidin830+UHb
 aoJVibCTJvdbVqp/BlA1IKp1s/Y88ylSgxDFwFuXUElJA9GlmNHAzZBarPEJVkYBTHpRtIKp
 wqmUTH/yH0pzdt8hitI+RBDYynYn0nUxiLZUPAeM5wRLt1XaQ2QDc0QJR8VwBCVSe8+35gEP
 dO/QmrleN5iA3qOHMW8XwXJokd7MaS6FJKGdFjjZPDMR4Qi8PTn2Lm1NkDHpEtaEjjKmdrt/
 4OpE6fV4iKtC1kcvOtvqxNXzmFn9yabHVlbMwTY2TxF8ImfZvr/1Sdzbs6yziasNRfxTGmmY
 G2rmB/XO6AMdal5ewWDFfVmIiRoiVdMSuVM6QxrDnyCfP7W8D0rOqTWQwCWrWv///vz8vfTb
 WlN21GIcpbgBmf9lB8oBpLsmZyXNplhQVmFlorkCDQRbvdF5ARAAzYhp6DzSTOdbx5KEeYTh
 bRrNEwt1gzCboIRHKn67DZBMV+aS93HvZjV7x1xNvN7CztGQIc4TEoYP8+462cl/MzXmCXVI
 bXkqhx+U4R5Mv8RqaJb+nBPjvISgwo5noM85Rj4Y4swgmYpQphodoakKoHKQMO4+6HRH/jzk
 UqoMg2eiA3Zu62xy48tBrvuT5RLlKMkWKUt1LsPgymVF2lQ2usFWGEJ7pTAU8rnBBVP0iaIz
 oMb/FH1ox73DrpgPtsbJfAF4AeCjol4bhj3jGQNQYOYhTMmYV08cMj1SJfNcYLpzuzeaqcYf
 nOgNrZvovvP56m4XScIvvKgTjHpm/Chy5wn45OVip/dmng2wmw/tMHx0rFKmBPxeO1RQurBH
 XVb7l4mBKehwY4Lb3wBFHiXCGsalctP8aJ0cfR7CJZYzb2na5NE/g1+FM+uc927jknVOnjgG
 xqRuDBRhHLnn9rkQc3dwJW1YPQx+H6Xd5I1Ukeanq3twHq9a/uNJBa4TmaQbSPc4OTnmu6eD
 LphTT0RvvTAsgICwNYhqGmXDeoC3Kxk2GffEgAQySVqHOz5B7MSdJRgJ1oNdn2IoUROTR2C3
 sHZWnDZISlBzHhIr/c11GXZ0QREis542X9vs+sXK3PyFDx/SjS/+dzcX+NahMN4nebCgOHn9
 fkmqR2oiZtEj9L0AEQEAAYkEcgQYAQgAJhYhBPIIK4gPnkI5NGhuP1ADmN9as4fTBQJbvdF5
 AhsCBQkB4TOAAkAJEFADmN9as4fTwXQgBBkBCAAdFiEEzJLeujcTOJ3UPmd3iS4ZqamTwskF
 Alu90XkACgkQiS4ZqamTwsl7nxAAxmdU9eb2wgFcVH+eB9R5tj0YN86cqWvWmw0nl7SqfXsg
 A4tzu1gf4cJE2qT/5YpZgrP0QWeoSZvq3vuUIcACHeWlWHeV2KxUUeSDLvAeIWp136LNoM4w
 73zy0UrHFKPk4xC4MtI0egc+P0V6Kcng7mDh76elkNGcsl1RKkZn4oCzEQMtrWSm/XdaL48U
 GRJAy6ZiUze8qd9rV+HCNApHFM5B5kYb80N1XbTMaNkD8yhye5NMNsWxqZgoU9vqE39N4NN3
 idki5qmEyDK6rjLT3oz7pDwTqZzTNCvGs97IcLjGCy1j2G3fFdh5KKUPvF8lfVj66rlUlqGM
 T0c7T8bDXmlRkZX8fQnct/FLH9XYVCdzlrtSyWHiAG8ZFV98/TBO+yYPXR8XQ0+/a9F/QLjy
 SdLyjFKxqyLIlswF0ybnUelTl0l23PhzfqJves40FF3+jsA/jfHuPS/JJQyvjsqcl0MLdK44
 msRfqLYE2XIQgQzKnxP9CCHEKJmAqQKja55ApnFbJoqzeYV3nUjdrczJsXjwRbE366v7HT/4
 SXkzFHMJ/5ZwuQ4MoJ11Okms6EvnvJUxm+CSeUO+Fykuyzg6bt3gubon5wsaujOQmEDloA/W
 hnVhBhFYiHCZ3cwvof/tqZUrxskSYCaI/qW4glIGEro1NBx/IF1QGw/taTYH10oOIQ/+KjRb
 /dRvBLdg04bq+MGScQHwJh8pJjMcUJyf9vlQNRI/kK7FN7Kvdw/ICTRFVVferXBqyb+MrckS
 5reX4t+cRL3cYH+xYkt20Kqfa0uoy/5Yc+6jcJkfHOKYDAHVEYqCPEJz5YEhH53h/ClQlqAn
 NPZMrIxta5lYdnV6SEKN0oa4v84W1rVUHqUyyA/lY54XRT1V04sSNW+DVuoeGkpK4qenHMh/
 /Fo7Bqj0FV+cjUgCZ6Ko5aW927lRFPhD/br4P0bzY+qhUW3Pp3zgQYK1L4RK9GhDrxaLRMRr
 zY0eU/THsGxlZy+LNCJTGMGQQ/PMoJu+wpkEYDGwczj+h8oizlJiwW3w15hz9AoT9zot+G5u
 zkj6vT8sXLjIa9Yc1l0GLI6h+grVNHDUY3iM/2xLe0xT5D9LsyeMy419gQCfViQtiRg1hDIb
 c4NpGWgEvY8AhAH+5vJj/kU+uK0jM7YyrZiEDb2YnAm9jAUGgu70u7YZBockCJczd9olngh3
 snWZwzzBFPTz9zzLEBwwJ2XV43OSX2tqvVjsxpwhYRIrOPMqBTqG2CR0dL4sLmOAyKa8dw6u
 iOPllcLn+lOsue/Yvqg7zsYrhXApRoAZrJnoRWEis2T0oGWIQlWYc0qYOA/gFUBIcYRk0glw
 0gSDKZ1uBoHSXWRpgQaGyqrx5oCPebe5Ag0EXPSmtQEQANf2rC7b06yvp6+3vd2VTcSyHzTu
 C+9E5QUBI1HZ2jnrQVkKGTR9f72qvOCLeGTRp3dD0OMwpFvmfdLTH7WSJWy9jQLk9YkOiDZ5
 oJzqXzYBGoNvzG+NWue4Xz/U7qVi+XdszrQnX0y0xFcJ5LwxMeU1Ybo8W3axFi1n8dA5qyPo
 y23bQnp3u5A1fuiGCgzHVylck8xxpraZ+Y2Z16ljeBThHY0NCDxzpXNQU9JaTIJk+nEjJrOa
 R92WH/bRxveF8SkqUaXnpk0zXzFJBSLVOvoG8PRiKMelam7+mRL9DwIWyj6BI6266RWcPZNM
 lHqV9HvJ69Hg+JHkMgulg1lnQylchRaIZXAYhUW+gXISSpv/txCmbuPi9SBLVDBLSQIJ9Xog
 ONgTg6djhuBQU/8LRxOwmIR8c8ipP5ccV8tkFhl7QgSCtyzz3JTA4GIdMdG6LGO27t7V+I4k
 rNE/eSC92JeMHjApQMUEUGLeORIhElnjgZ5fAB1fGA8Mvju7iE9jh6cb3WO2CtYBzYuRN8mi
 NFwl17csPNiyADsXAlLjJLjTLATrQTN4Bw6Lq8azZ2MWRAz+lHKCZ9308nr0QajEWkMFEh7q
 NMesr482Nh4Th864N0Ie1y5/JsSK/8/NpJ/vnA/6t3sBHurgF5LeyNdjEdI24oRsG/CmVpcC
 va2ALXwjABEBAAGJBHIEGAEIACYWIQTyCCuID55COTRobj9QA5jfWrOH0wUCXPSmtQIbAgUJ
 A8JnAAJACRBQA5jfWrOH08F0IAQZAQgAHRYhBEdyCM/7NGgyAIY+Bn4s7c0/VKyFBQJc9Ka1
 AAoJEH4s7c0/VKyFH4gQALdzfG1FB9mUGobVTtgrhIh8nNx9H/AZhFRs75w3JqCRHx+rkv9J
 BdGNOWl/lOqGIPxPVVs7QOhOoLguwc/c6+n2GWi5w3n85Lg0UAM2cwTacXFKyYXjpGAwGv/H
 zkSEFyTtdg0jquIPV9kUqiHJkIMdvyqFuFBt3uDgK6oDEuxEg0+rk9VhXLHH6ozyV41yiB97
 YP2ie2Q5BjBWp2LA2oiCNWSqaK/VmQLHyJj4tJ9lGUjRGWbV6Eeq7aeFE/jt0KzK5zGUJTgZ
 L9hw6tRXtT1zIhbLeZAFHIISHm8h3UYUAASO6yxXlKh6BFRrgMrmsk7FTXnDLHu6RTuOKLac
 BWXvuXg07BIoWNS3lrlyJIwYKNJJjU2Tk8IzXi9mg3aWcze9B+Arb+vq9uNuPERTIstWFKLC
 Bv1J+jimOIVUoS7lzqrFC+NY+FCSkQpRxFhCBRVIVIHo9z7NaVMS1TiPrpIQFCcFsAWoLCqv
 xm/E/wIR956KLAhwV3j+Wck+bzJh5Nmb8MFkJ1CVRwQL9nvaV6DljHqcmk7PzfbuLtxxt/62
 Ep2BY4JeMMz2e90FLwsRGHyYvVeGM5Z/hfYSuoSo92yhwEIr8fhNzbxbiCDNWnYkYYUApYdj
 GmVcveMVOkn7ZfXKNwbIpVdx+8K1nef77n2ZWQ7R5j6HWnu7+QBZmr6yFxcQALJuGTsMM4Ru
 os/vZhmpCQVo1xCsZwKLbiNhQi1mVf2bPLX4ZG3qmBTvFZc96NLI/q+t7FhZFU1zm1+4wkFM
 Fux1xHTGgmg3wujVJJCk9TySAQvpKXFT0quL/zbJ/soPivjhlGx43poY70u+wcmazfyAWTpv
 eA0mIGUCUU5k1WHfehvvtnTDzmlLVo6pgs7t8Tn6Zbi9XUdfagmYw9fpgMeXpai4uwa2YCTl
 I5lG/1yP6wywaaBUP+sTSbgwOFE4tXfnhGXnDhLu5mNcQUJLyjVy+nrKse5XYnmizQH+MFJL
 APkxFJdlz7vOKYyzFG5tBQPrFJxrzJIQp/GHULRG3IDWKuHiJTox1voe81Nhuf6ZvhZsTQCc
 e4ol2lGPSkN7J6BM969+0cRA3L02PSimocMRM5NjH+fDj1WleDxLEYmp65hK0lH5qZfd2oG7
 WSta+S2sXiLRTo/jtoVhSzQ3pyUZQWMF8JSQoh8TPztu94WWT6D/C+aeeLl4WkuRCbldl84G
 4t1RG8Nxma/hJwwu1zRNsFK55Q/8Nlukc1WI1U+iF+EmpjZVfjFl9P9X2ArrX6mZfOgUipiY
 5VqX5Dys8s44RkFWa02WJygLuO9YUb/P+g8eSbmSYAwp2Gpzcdww63kTLv56uk32jnpDLcYD
 WG//KA68tPVBR2xhy7Fp+qAa
Message-ID: <75fde41c-5ae2-af96-c712-ab5009aa8214@puri.sm>
Date:   Tue, 3 Sep 2019 14:51:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20190903134303.000008be@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 03.09.19 14:43, Jonathan Cameron wrote:
> +CC Greg as fix for a patch in my outstanding pull request.
> 
> On Tue, 3 Sep 2019 07:18:02 +0200
> Martin Kepplinger <martin.kepplinger@puri.sm> wrote:
> 
>> With the underscore character in the lsm9ds1_imu device name, we get the
>> following error below, so use a dash, just like the other device names do too.
>>
>> [    3.961399] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
>> [    4.010581] Mem abort info:
>> [    4.013838]   ESR = 0x96000004
>> [    4.023602]   Exception class = DABT (current EL), IL = 32 bits
>> [    4.047993]   SET = 0, FnV = 0
>> [    4.052690]   EA = 0, S1PTW = 0
>> [    4.056015] Data abort info:
>> [    4.059020]   ISV = 0, ISS = 0x00000004
>> [    4.080106]   CM = 0, WnR = 0
>> [    4.085237] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000e4f61000
>> [    4.092194] [0000000000000018] pgd=0000000000000000
>> [    4.097474] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> [    4.103286] Modules linked in: tcpci st_sensors st_lsm6dsx_i2c(+) tcpm st_lsm6dsx industrialio_triggered_buffer kfifo_buf vcnl4000 roles typec goodix snd_soc_sgtl5000 bq25890_charger snvs_pwrkey imx_sdma virt_dma qoriq_thermal imx2_wdt snd_soc_fsl_sai aes_ce_blk imx_pcm_dma crypto_simd watchdog crct10dif_ce ghash_ce sha2_ce snd_soc_simple_card snd_soc_gtm601 snd_soc_simple_card_utils sha1_ce snd_soc_core snd_pcm_dmaengine snd_pcm snd_timer snd soundcore gpio_vibra usb_f_acm u_serial usb_f_rndis g_multi usb_f_mass_storage u_ether libcomposite ip_tables x_tables ipv6 nf_defrag_ipv6 xhci_plat_hcd xhci_hcd usbcore dwc3 ulpi udc_core usb_common phy_fsl_imx8mq_usb
>> [    4.105389] bq25890-charger 0-006b: Capacity for 3784000 is 86%
>> [    4.164061] CPU: 1 PID: 344 Comm: systemd-udevd Tainted: G        W         5.3.0-rc2-g24e3d989d49f-dirty #161
>> [    4.164063] Hardware name: Purism Librem 5 devkit (DT)
>> [    4.164067] pstate: 80000005 (Nzcv daif -PAN -UAO)
>> [    4.164082] pc : st_lsm6dsx_i2c_probe+0x18/0x80 [st_lsm6dsx_i2c]
>> [    4.164093] lr : i2c_device_probe+0x1f0/0x2b8
>> [    4.164094] sp : ffff8000a499f970
>> [    4.164097] x29: ffff8000a499f970 x28: 0000000000000000
>> [    4.164100] x27: ffff000010b70000 x26: ffff8000a499fd68
>> [    4.164104] x25: ffff000010860000 x24: ffff000008a8b038
>> [    4.164108] x23: ffff000008a8b038 x22: ffff000008a8b000
>> [    4.164111] x21: ffff8000a55b2400 x20: ffff000008a89000
>> [    4.164115] x19: ffff8000a55b2400 x18: ffffffffffffffff
>> [    4.164118] x17: 0000000000000000 x16: 0000000000000000
>> [    4.164121] x15: 0000000000040000 x14: 00000000fffffff0
>> [    4.164125] x13: ffff000010b6c898 x12: 0000000000000030
>> [    4.164128] x11: 0000000000000000 x10: 0101010101010101
>> [    4.260542] x9 : fffffffffffffffc x8 : 0000000000000008
>> [    4.266073] x7 : 0000000000000004 x6 : 1e0e1a00f2ade4ef
>> [    4.271605] x5 : 6f642d72001a0e1e x4 : 8080808000000000
>> [    4.277136] x3 : 0000000000000000 x2 : ffff000008a8a000
>> [    4.282667] x1 : 0000000000000000 x0 : ffff8000a55b2400
>> [    4.288199] Call trace:
>> [    4.290753]  st_lsm6dsx_i2c_probe+0x18/0x80 [st_lsm6dsx_i2c]
>> [    4.296648]  i2c_device_probe+0x1f0/0x2b8
>> [    4.300825]  really_probe+0x168/0x368
>> [    4.304638]  driver_probe_device.part.2+0x10c/0x128
>> [    4.309716]  device_driver_attach+0x74/0xa0
>> [    4.314071]  __driver_attach+0x84/0x130
>> [    4.318065]  bus_for_each_dev+0x68/0xc8
>> [    4.322058]  driver_attach+0x20/0x28
>> [    4.325780]  bus_add_driver+0xd4/0x1f8
>> [    4.329683]  driver_register+0x60/0x110
>> [    4.333677]  i2c_register_driver+0x44/0x98
>> [    4.337944]  st_lsm6dsx_driver_init+0x1c/0x1000 [st_lsm6dsx_i2c]
>> [    4.344200]  do_one_initcall+0x58/0x1a8
>> [    4.348195]  do_init_module+0x54/0x1d4
>> [    4.352098]  load_module+0x1998/0x1c40
>> [    4.356001]  __se_sys_finit_module+0xc0/0xd8
>> [    4.360446]  __arm64_sys_finit_module+0x14/0x20
>> [    4.365166]  el0_svc_common.constprop.0+0xb0/0x168
>> [    4.370154]  el0_svc_handler+0x18/0x20
>> [    4.374056]  el0_svc+0x8/0xc
>> [    4.377059] Code: d2800003 910003fd a90153f3 aa0003f3 (f9400c34)
>> [    4.383406] ---[ end trace 6dfe010c028e3371 ]---
>>
> 
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Fixes: a106864fd667 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
> 
> Thanks Martin.  This one is entirely my fault for messing up tweaking
> that naming.  I should have bounced the patch back for another round
> rather than thinking "it's trivial, what could possibly go wrong!"

I wouldn't have thought but even your trivial change would probably have
deserved to be a separate commit. That would've saved time.

but np. worse things have happened. I'm glad to have it fixed. thanks
for the quick response.

                       martin

> 
> On basis Greg may prefer to pick this one directly:
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Convenient lore.kernel.org link.
> 
> https://lore.kernel.org/linux-iio/20190903051802.22716-1-martin.kepplinger@puri.sm/T/#u
> 
> 
> If not I'll pick it up for first set of fixes post rc1.
> 
> As for the question below, I've not taken a look yet and certainly seems
> an odd result!
> 
> Thanks,
> 
> Jonathan
> 
> 
> 
>> ---
>>
>> While this patch fixes my (formerly already mentioned) issue, it's
>> a question actually: Why does is this underscore character a problem?
>>
>> thanks,
>>
>>                         martin
>>
>>
>>
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> index 5e3cd96b0059..80e42c7dbcbe 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> @@ -24,7 +24,7 @@
>>  #define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
>>  #define ST_LSM6DS3TRC_DEV_NAME	"lsm6ds3tr-c"
>>  #define ST_ISM330DHCX_DEV_NAME	"ism330dhcx"
>> -#define ST_LSM9DS1_DEV_NAME	"lsm9ds1_imu"
>> +#define ST_LSM9DS1_DEV_NAME	"lsm9ds1-imu"
>>  
>>  enum st_lsm6dsx_hw_id {
>>  	ST_LSM6DS3_ID,
> 
> 

