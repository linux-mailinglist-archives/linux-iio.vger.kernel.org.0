Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EADB58E3CF
	for <lists+linux-iio@lfdr.de>; Wed, 10 Aug 2022 01:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiHIXle (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Aug 2022 19:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiHIXld (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Aug 2022 19:41:33 -0400
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4407538C
        for <linux-iio@vger.kernel.org>; Tue,  9 Aug 2022 16:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660088489; bh=yyj6auEMoO8WoL/D2T7k+nEJrDfdGoSfd6uX3RTsiS4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=D1qmxLEagnyIxsbZ+aER3M6AHhxprwGdTkSI6S5D/8L3WprNrxuy6bYBE5zTW+a2a8ugAmZbkltAnhU99TQYYCrZ3mU0WFLakFACJN2slI+oL2Pj2SWQExS8BD4+EsXO8TUlhsrB20KuXaki5IoR5G08YhoEGV3VoCYkJvjWzz0QhoWv7HbeA/GXuMqtb2SwctnE5uV0mC248qksjkkRHJWIxsj/BfVSzgvoy9T4kJ4VgfRZA0JxUSNLHrHs8JNxsejgUW4KIHKbkO7g+w/lLX20gyVHAHucTUoE4oDl2h9GTLqxiqwTSAQTecN0j3h7p0WjcTQjRNEbitzfJvpFIA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660088489; bh=kF8ohh8pY2wNuN21TGi/ByXdbwazhFEm/skMuH/4Uh9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=N5A41AtF0Bh3N86HmVLmDbnBJSmjWcCbAIeIBO50XFp4hDyl1LaEtc1nAONqyKxjx9uasQTHi6Ls7zIG+DxMCaVnLc/kM7G4WSMq5WRD0UpQPfuaFcqQad1AuCVgxy5VhZw12ifTdSTSUPXRWAa5ZO13iTkF+WHaZX2EF9IzNUWHE6lIq1AVK9Wgk8vHoPUVT+KVup2s4ZLqd9T5F7BG3i0E5Ix8FQPS4red16Pi+/najeFzchwderBf4J6N9m6T3qLfMAeEBkkhqW8oCeLn+XbBMdVdFUznQI142hWSjh2OHIGhoGLQcdcHzaZE1L2StKOtr8AAQ2On3ooGNouZvw==
X-YMail-OSG: EaNtiPoVM1lruehrOMuORG7I9_ZFgmCQPn67QSKWqHve1PDmacHM9NJFqPn4lKa
 G7UIdD.sQiItTr.nqhaBNOeUBI39uxK8QsQaq8U9h80QEp9bvRGKzUP92hSK8z7tQB5RmVBPSyi0
 DPbW0F5sWTYTPb9T8ehUEPuuqjaJiEZuHE3EyG_VHYV1gVj9fKlejRBnlE55P6wYDOGVDXv.XLH5
 vQ69L31RfnouL7wJ192kRKYAISF1qh4_MVdze_.yzxIjuR_TeMN56m5MZAmSfuLLFvw5W2J9zzPO
 zL89EeYtZmw74BNGCszMuWEB0S5di_PrP4JB_RmapyWwrJOaopL7BKYZl7kFnhP6D1hYZacq2mU5
 OfF6zcnbb3ubu9_3LnhGkPNOZ6JYo9WJjzCO5m03UcZlbMh3N4POahW86S0k76Xa1lzzXqGHNFVi
 Et_vijIV27jeNQAeVfWxn3f58YtA5apzB_c25bNJCSKluqwurW1y8oWfy0_yESEU3jlTwsA._pwo
 dBRhZnjtqo2fnHi5aKzSoldwa5r4trPDvLmIhE6gVTulKIURo7r6zHWJGm8e6qJ51PWpHV2kAMU0
 x63sWpaDhhAdUlqrNIb9vhRURm7p7O4EaYEBR5gCbcQXxkiH77ytJokdqpOcZj2hy_Hg4YlmXPzx
 17K79XfwKv6dGXOlNr0.ehR4JKMXvWzABTtuYgmBJrSWHbbqQChaXbTs0kUoo1MhEaa7ZOLoJ1bl
 qtApzzou049024A1sMl1OBcZegne2EHui5eqjemzmv3NMMU2SCd7OHgvMMFIP1ifsDw.Di9mr6c5
 _g5mUUvAFaOXN0N3aUMDMZXaA7GnbeYKKYKtxJSHdJbJxmw7HJxQHSGZnutP7qghDiQtLExvoh4x
 bWZYJBHn3J5avjEOZQ0pmVL30jbNmA.daVOho7wdzbYzdhW8qzKqT9W.uTghXs84fbN8_dDeW4Xc
 OaOsNnGUIKTqtDVoClN1HXRH6DUOnhTFI_8iWLcJs8k5lqqkBlMxXnmPF68iyeo966PIHQdxePEc
 cLvioRbYU7.WaQ8aWwnWFk3oAMD.560uFuIDLcLjk3Wi9SQtbjcVNwJw1NwjnBOJXuN5UIdTBIkS
 7dKhZ4MJx7EfrlG2eau6J60EN9QJaS.SlC24jEoGvoEX5kOAZJ6qgJ.JDMym099bkySDwMQqhPI1
 urC6CbyVI0f8IgzQgOJPbBn3JW40lYyNqvOLJv5FaMTnBDSMGR8j0YN6qv.LIc41_fC.uKvIaaZo
 9ZSvrc6Urslbbs3tn_dbtmZEUKs_no1amXU4WzVObefuZaZpioC6K5DSaPnfOTkjmGw.lZ2S3gu9
 F6G6Mc.JFo5ieQo_QV_dXi7dAuYQsBvdatekWMocWpHWAzSgeO0mnV5v0aLq4Mvq.iwScvaEn1zm
 xzst8X0nRsj2izFIbmGoksOLBRfVNA5i.aEgPa.X2WchSka43.EMrjovDwGVk9_IzLWX5jkVKuDx
 vviF2LplBjeq7iCE.S.N4cJInot..VVvvhuGPTl4_bLnpHpzY0nZLcio5Go5pnQ5vRyzg8Rk28WT
 AnP3QT6I3QZQWTZUGBuyDA2RfVloZcttcbzIlCI6KWNnMnUiWQI_ijlOrsZOFbZU_4xRo3Zzpkto
 PgWwVuNVBnr_Vuk7DTwjFH_3_106nhL0UFZtuH_lJhvhKdQBUPE6iEdicdY0p575AcPDpsw2xxva
 .Y592zFafQwGheUo9rmA3NggNC9UPK3IP5A8Tpg0a5p0_Zc_SPm7tepYkvl72NcY0R1FuUBvU5ld
 kC8W6WihTR8h1wEpzJRfGkVw_8mO5RV1vxcm7I5k1rlfXX7PkZ_phsYYsrtSOmAvxzjVxkR19qBD
 BIqFGZ_wUDQHKmPJgJTY4MmtEFCiPLITF4yKlmmukMhEPUjaCASytcSZzUAd2rCbmXAcbpL2Em4D
 VEMqDgM693RK24ayiIR5vOu4Owj5CJWejTVKqX5S0ckn50YZbCS1PtOMagBIPsSUQUORimtV7xQP
 m21y90EFea6KK4T0UO1jx8SxTWB8.KZ5TA7cvuwuM_ihr9UYPxwp75Vcd.4VGsjtRGXS8xTrUf3.
 _LUfYMS9XoIt1UC0INUdigdOB4btN6sdaSbwxSlkVe1sCP7uWLOOCJ9tgNHLQJUiMe0hq1C17NlF
 i77F.2xcM4SvTZQhnueqySPrA.AZkUyFMCf1siIfNk.hyKultK_jrMhdr95bN.iacJuHzVVcBDLR
 NcbWXZddpU1yJsN5Asslq60DDQapE7fFRUMqmeYWZl8jv73bmxJ449ekA2lbIndOJW3WJcFX_51s
 8i3ND
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Tue, 9 Aug 2022 23:41:29 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-pzqbs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6f29886ae1a8611f7f272a0ac9c52f12;
          Tue, 09 Aug 2022 23:41:25 +0000 (UTC)
Message-ID: <850de937-8fe6-ebce-4e9d-35a617c3ade6@rocketmail.com>
Date:   Wed, 10 Aug 2022 01:41:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 14/14] iio: magnetometer: yas530: Add YAS537 variant
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
 <a7bc9d7a7bb12a76fb217a1709fb09abd2b45892.1659909060.git.jahau@rocketmail.com>
 <CAHp75VegA6zzvQXEi_9-K3832o+j48Af3X8LivYY47Xav+w-xQ@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VegA6zzvQXEi_9-K3832o+j48Af3X8LivYY47Xav+w-xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20491 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 08.08.22 13:47, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 1:12 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>>
>> This adds support for the magnetometer Yamaha YAS537. The additions are based
> 
> Add support

OK

>> on comparison of Yamaha Android kernel drivers for YAS532 [1] and YAS537 [2].
>>
>> In the Yamaha YAS537 Android driver, there is an overflow/underflow control
>> implemented. For regular usage, this seems not necessary. A similar overflow/
>> underflow control of Yamaha YAS530/532 Android driver isn't integrated in the
>> mainline driver. It is therefore skipped for YAS537 in mainline too.
> 
> the mainline

OK

>> Also in the Yamaha YAS537 Android driver, at the end of the reset_yas537()
>> function, a measurement is saved in "last_after_rcoil". Later on, this is
>> compared to current measurements. If the difference gets too big, a new
>> reset is initialized. The difference in measurements needs to be quite big,
>> it's hard to say if this is necessary for regular operation. Therefore this
>> isn't integrated in the mainline driver either.
> 
> ..
> 
>>         help
>>           Say Y here to add support for the Yamaha YAS530 series of
>> -         3-Axis Magnetometers. Right now YAS530, YAS532 and YAS533 are
>> -         fully supported.
>> +         3-Axis Magnetometers. YAS530, YAS532, YAS533 and YAS537 are
>> +         supported.
> 
> So, after this change the rest become partially supported?
> 
> Perhaps you want to leave the original and add a new sentence like:
> 
>   "The YAS537 is partially supported."
> 
> ?

All four variants are fully supported. I changed the sentence according
to Jonathan's suggestion in v3:
https://lore.kernel.org/linux-iio/cover.1655509425.git.jahau@rocketmail.com/T/#m6ba6b576cdf6f86f550f7598fcf7c408ac5f2d46

> 
> ..
> 
>> - * For YAS532/533, this value is known from the Android driver. For YAS530,
> 
> It seems this comma is unneeded in the original comment.

I'll remove the comma here and in patch 12, where it was introduced.

>> - * it was approximately measured.
>> + * For YAS532/533, this value is known from the Android driver. For YAS530
>> + * and YAS537, it was approximately measured.
> 
> P.S. Do you see now how your series and the end result become better?

The driver improves. Though we kind of get lost in details, I have the
impression we could go on like this forever.

Kind regards,
Jakob
