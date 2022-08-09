Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26A858E3C5
	for <lists+linux-iio@lfdr.de>; Wed, 10 Aug 2022 01:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiHIXc6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Aug 2022 19:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiHIXc6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Aug 2022 19:32:58 -0400
Received: from sonic306-21.consmr.mail.ir2.yahoo.com (sonic306-21.consmr.mail.ir2.yahoo.com [77.238.176.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5FB7E833
        for <linux-iio@vger.kernel.org>; Tue,  9 Aug 2022 16:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660087974; bh=h+nosmBX2YYbcoY4VZpLL7LMDSMIVR3mnEx0D5rs9Bo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=eUxD0Vd73e7/nL3bVm0dDM7A03DDg3Ibd6i/uPz7+uTlRIwSptRqqy//jyE8wwgUCPhBNHCnZfIPpkqFUCkLuvX6oBC8an/k6yIpcAWLZElUrWDqtezasx1HVsQPGEUPElaQlDsU6oUnNa6m5BVvwPQ4LjsFFUDZ+PsNFHoD4tzPCjQYpVxyb30NRtRr+v98LO2u+COPRJckyHoHnpv2cxKIypOpdyMA0EMUoGu8Xfa5F98eror8Vntojy+ha04etYlqinDQadW1Hqi2fb+eQwq63Cz7GmMy/1TsBniPV3pfu978epu4GeFb91zaBeDo4ANpPY71xKDKi/efbxEbEw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660087974; bh=LZ2snbXEf7pAnHz820mKrtA8fH13a1P0y9YODJYuO6P=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=CTwCKywWFRBm2YPS8XQM0WB6Qon7n//v6fm8ABrcJuq51SUWW1zGxNFLGHq77+3HfzHb+16DayL/udf9pblyn+2Vi6BNRTtvIkykLzdGWZgKVwPciObvunv4vKP0e6LjEYjWHNBJmCrKGO6wLHF26Fh7AeE+j/L6uA5M8IBqLnfJH2T7ZDF+gMriCg1KLb+8UuraD6XPK9WZDW8eopSycxagu+lia7FRTlEXqcERn+wX6HY6R3MJ8cwhr4mXWngb5Apk1cFXDfJs3KJJrH3QBpZrXC8WWKRyv2LfbWyxHdp7xumTKO4/LbS82QzzscDt1H6pRse6rxqA+sAWCYi0cA==
X-YMail-OSG: xSxvYX4VM1mjhpXtp2wXwcdGpeSKUVenLi91DnIjewm7DaqlRpSZ5dpz9Tlit97
 DhLlMHUoOuK9X2wKCV8P18XX_Izqq_k.wTjaQp.9Kkor4wCoQX_g_zUIM7iIkR19WYd29LZts0iE
 nKtMeNzUPxWiv1nKo61ELxKt6eZ6BrZwHoKPySGa9lTivtIEj3X7w6vk.KeVLFvaITqDXJP0xlbL
 r0exwVLzH0QKxYDmOkct69mz9lmxi9vfRayL7Ag0y2pHpzrQ3JOjfKJWiqikfXjXce4AOXiCz_Na
 YIcRJhhV4bydMUsSIew8eZ.Xdgnb9yZVKtYOjp6KO45zrZqLqp7JwmneojN1NItnUpFxlJ.ChWIO
 JcrILo19vNVE2k38Wd2s3iDxMQfYJ0Taxx3qQKwDOo0xHgTIoFW.B3MR8znxkZYQkfidOgjL1f2Y
 5qE38IkFEAnfwwSwe2_weHmL0u9SqVYD_I4zyu55xvklLUZc3qJwYR1IRkjBrLVelCtHtUdWmTHO
 J3Y_zXqJvwSA2plvRL9QfuWyzg.oCsBFH8umIoaf12TQjscakSe5DYL75OdU6xLtnUaSnus7lpCC
 qNmkvmk4hwatyVqhrAYeAgDHiHCTYBs3zXcdMkBDtoWWC1s_JlkVxup4Vzj5nCNJagnQFG6e8a5H
 BXSelkiIC1pBz.jmyz5kQ0PPLSp.bV1DQot9ohRfnRV4MBJWx7U4xJUBFqzU1ewkKSqi8W8bcxVv
 g5eoutWhwMd2jKUxRX_BXJ7fDYeRwkM9Bpeajko8Wqd7PyJrQ.apGwiREHwQaRd6BO9lAhuO8NtO
 CTreAAeLtuplBfam3Z032C_7iecv5EIwL6e028XN65vcuYtVx928fkXNLvpPLJO3NIut5Z4FYsWV
 ylGIuPw_nKubnJIXk6pjitvGhFDh.Vzje5f.ALwfR3AlspfvfrZyGcFMh8aZZOxXtXzKaJwGbya8
 5P.sL8.n9h1tGGL3v9VZl10C3TkboXN1u._hjUKBhF2eeZALWAxejNebKhKdGHP5FMazEcOzzVgJ
 Bs4b0tji3Sw0PEPWN6PKowb.lXfdtMrcYUknQ.sXyg325W6lK6jDlKpoMz7iqHSUHMaTjPdAWPTw
 ANX3IifmnaUV5WLfceImXSyb5b4s94eLRferEL1pBF21XChrNGsPTXhQH9ca4..mwnU.Z4czQtx6
 LN1SvtxmNLUmxTqL3cyf.8pQuWZBtRb_XkEoaS_1TYFJYpSqeT17b7h5Zuo.mtzbt2v.Ajje6sLb
 MNw9ASziAzjJcKgX5l3LN21WZJJ8YwEdBeQFyfjULSxVMHhdiUOoExn60YxUym_c_M3DPiC0Bulj
 YEKtKs0U03hPFRvttrm3MZ2TWIAvKL6E_4BJrwrklwo552xzFdpkJ8yXbsTXcXNbPOUdet.wInzk
 l.nuJSDJZW9GynByYyyu08zcrZY8JYUBdDfCKq8Xh59ea2wu8VtF_V5WOQ8QHQX3iUK4BX06xK6r
 V2z._GEH_dl_10xk_3xjhP7oTfRHvt78Q03A1GVokk2yWyYM.Cw0acFBSle1itsF.xrhxph54uVU
 M9tfqhxNCSyqT60i.ezuXCz65ucav4W0._cJtLrAWKyOtzAiOKMZKzv2XsoIsQ5wEo0CIcE6cKVb
 3qGZA5pr87r7y1JJbCuiT3FFdcf5ZPkhR8aGTnmoCb7Oa8MfFtx4Z4OVpOGEQtbxAQ9i54HUzrE7
 HS3psacHSheAVhpwJH3g3mIfbuG38W3tUeK.3_bWitg0PVkpuXU.osHkz8qvaJf3Bi_dpFrfPvLq
 uUTkQHfAVrdvHoJILeAhs11UVpgYhGC0qzUx6n4O5eyQKLw2NxA2BiNcFvvNky57MJlzV9ectO6a
 EXWvHsCpib62.OroAxkv_FnitiLFtOBQ7YnkLA8g5Gvxo4KM5U0_wjJ_bHUl9NyFt6pgmAY.rJrb
 6ghNGzwFB4vsODy1SU.uScG1M5Zerka0OhThqfKPeAh0sJ4eV2qoL3hEp3ktwoMtPa_powU2Zkb_
 fIX4MJtKrcuuuqu76JDBovcNwUegB9xThB_wAim_nboWodB_9WfGmA8MDfDJO1rcgkbcsbHzq35u
 x03tPLs2GPUf2Ukt3F6NHI8Za3aD7QJN5UQ3DaXOjxENANl0zfpDPxvp2G5RPErieDgvQo4VkZzk
 22J92CDnj2PR.CH_lxM1lu4fjCPwoXelJg4l22JF3gL1wEWc0oVvjyI9kr3jJ0WxwZKOiKStWimR
 qFPs_GbLDq2rOj8BoT7y6zkOMpuDvIjJYjlxFCXsp2V_td6MIId8tusPczs9YV3Eq.9lqrCyhaUR
 R8w4PzA--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Tue, 9 Aug 2022 23:32:54 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-5bdfc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ba13ee3be7da56c92119090366e686d9;
          Tue, 09 Aug 2022 23:32:53 +0000 (UTC)
Message-ID: <2735d34c-a4c9-ce87-b29f-50e75c1fe4a3@rocketmail.com>
Date:   Wed, 10 Aug 2022 01:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 09/14] iio: magnetometer: yas530: Introduce "chip_info"
 structure
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1659909060.git.jahau@rocketmail.com>
 <8f5f58c9bf0f4006fabd01b5564af071d20f2a2d.1659909060.git.jahau@rocketmail.com>
 <CAHp75VdfketWiZc+72TLdabMN0Vw7VHBveGfVp8OHH5bzSkcrg@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VdfketWiZc+72TLdabMN0Vw7VHBveGfVp8OHH5bzSkcrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20491 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 08.08.22 13:32, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 1:07 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> 
> ..
> 
>> +       yas5xx->chip = id->driver_data;
>> +       yas5xx->chip_info = &yas5xx_chip_info_tbl[yas5xx->chip];
> 
> I don't see how ->chip is being used, I would expect it is the part of
> chip_info, if it's really needed. That said, please make it directly a
> pointer, so the above becomes:
> 
>   ... ->chip_info = (const struct ...)id->driver_data;
> 
> ..
> 
>> +       {"yas530", yas530 },
>> +       {"yas532", yas532 },
>> +       {"yas533", yas533 },
> 
> Read above and here:
> 
>   yas53... ==> (kernel_ulong_t)&...[yas53...]
> 

Generally on this part, I'm quite confused about the ...

        enum chip_ids {
                yas530,
                yas532,
                yas533,
        };

... at the beginning of the driver.


In my naive beginners approach I think that I have to initialize this
enum. I did this by:

        struct yas5xx {
                ...
                enum chip_ids chip;
                ...
        };

        ...

        yas5xx->chip = id->driver_data;

The i2c_device_id at the end of the driver initially only contained the
fist part, looking like this:

        static const struct i2c_device_id yas5xx_id[] = {
                {"yas530", },
                {"yas532", },
                {"yas533", },
                {}
        };

This first part is "char name[I2C_NAME_SIZE]" according to [1]. I didn't
manage to initialize the enum with "id->name"...

        yas5xx->chip = id->name;

... this resulted in a compiler error stating "incompatible types when
assigning to type 'enum chip_ids' from type 'const char *'".

This made me introduce the second part of i2c_device_id...

        static const struct i2c_device_id yas5xx_id[] = {
                {"yas530", yas530 },
                {"yas532", yas532 },
                {"yas533", yas533 },
                {}
        };

... which is "kernel_ulong_t driver_data;". Initializing the enum by
"id->driver_data" did work:

        yas5xx->chip = id->driver_data;

[1]
https://github.com/torvalds/linux/blob/v5.19/include/linux/mod_devicetable.h#L465

--------------------

I think in other drivers I've seen enums not being initialized. I don't
understand how this works. Unfortunately I can't recall specific examples.

--------------------

I now had a try with following changes...

        struct yas5xx {
                struct device *dev;
-               enum chip_ids chip;
                const struct yas5xx_chip_info *chip_info;
                ...
        };

        ...

-       yas5xx->chip = id->driver_data;
-       yas5xx->chip_info = &yas5xx_chip_info_tbl[yas5xx->chip];
+       yas5xx->chip_info = &yas5xx_chip_info_tbl[id->driver_data];


... or summarized as:

        enum chip_ids {
                yas530,
                yas532,
                yas533,
        };

        ...

        struct yas5xx {
                ...
        };

        ...

        yas5xx->chip_info = &yas5xx_chip_info_tbl[id->driver_data];

        ...

        static const struct i2c_device_id yas5xx_id[] = {
                {"yas530", yas530 },
                {"yas532", yas532 },
                {"yas533", yas533 },
                {}
        };

This seems to work. Therefore I would it implement it that way. I hope
it works reliably, as I don't see a connection between the enum and the
chip_info.

--------------------

What I still can't manage is getting rid of the "id->driver_data" part.
When trying the above with "id->name"...

        yas5xx->chip_info = &yas5xx_chip_info_tbl[id->name];

... the compiler complains about "array subscript is not an integer".
When trying to add quotation marks to the enum chip_ids content, the
compiler complains about this by "expected identifier before string
constant".

Kind regards,
Jakob
