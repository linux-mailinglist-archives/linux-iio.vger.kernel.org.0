Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E824585A97
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jul 2022 15:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiG3NcG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Jul 2022 09:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiG3NcF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jul 2022 09:32:05 -0400
Received: from sonic307-53.consmr.mail.ir2.yahoo.com (sonic307-53.consmr.mail.ir2.yahoo.com [87.248.110.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB0EDECD
        for <linux-iio@vger.kernel.org>; Sat, 30 Jul 2022 06:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659187921; bh=ZFKGG+QJeG36yV8mW4ZeHxE12cS6z6ePgVw2PXNaxpw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qtslHs4rNGoDrYokJm3HD2GWUShQ+2X6xKdNV38y2K24KOcT1WrbfTjOEvbEShUWRLWoxCzEpj3aaMjC0MkVLa7hurxqgqdl5v1lfULpH53LslsN5HisYiaLdLXjdgqq5IsSOlgkvfEYUNmI4wbg1CcL+l+WTsCDTvnFosssuyGnLTw7waXglcliKzWl3LPHbp7SSvjGHGxwxxoNGodt8tZJURZpYATVnWcIQswSur8exM47sqJWRZl3OLzUg//rz09V1D3NGOqL56oJ+63jlLdlmN4YFhhkOX8d4xcy1gMvPuKSiTonPjvHut2nNsHL9GS5N9iETVmsMHftQh28gw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659187921; bh=oqs++X3+Ng2tTJQuo2yx6Wy0E2qJ4Q+amGEOL85yHdr=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sQPFrfBNIh2Z1WjQPhfAdRHxKwXmRZnvwSUTMdwWy9F+9OXqDiC3uDkt1dPpCaP5aeGZ0N9MQO5a4INdrPxWMSIDO0K4E4/FdeiIGV5QsyXpmrU8ztUf4C5rcKyCXOAej4vW8ledUQMLAsIijHW0NyHf8mVvylAPOS2Tfpv1pWIsOMm5kbPlBQga/rRWAhU2TcpaApaa47TlK//NzplZ6loBcpw8kX0y/ZaBFHZfu9KzGtMV1Ru29LIh3sSA9xEFhqJcsbm1nD/GcOGr/t9r5JbvbMkvkibICKmuFtKWO/0TtIgSTlfrSbOQKz9CBLYepSgbLKreAEK2sJ7psx8l4Q==
X-YMail-OSG: qRIfJFMVM1ktgIajrUTVw97N7tdEoF0dNXczL8FJlVc5ZojoKPjWbVu6sor8Mpn
 AISpCpMRiUBn2V5B.bWLQSWNa9kgQ0luFgYq73GcbeA5LxmWCcP1FMgYQlM27paYsF9JninTsoZA
 He1nfrQ62xjfHiWGm8mWRAUCTIdolHwjb1YMkhWT2tJTcPD1XomGhuk.7U.r2jsTbRkaBFRDUW6g
 WmR0yQNfxmWwSaoABH6f1HZ2nb7zuSDSPOZYuC4QTOnHECDOhXXkkLj9qlP23Lp1fJ8cTy3vyavD
 SqkfwBv90LtBpfLDV1GGLG.9kKUWKu2SSh.MQdL1PqlYAJazCCrfRpXcelRAQMZavhaomR90OIRs
 205AnRr8ZdggQV25U4BwJ22czP1YAzcra9nmlWf0riNQ4JR.BZPGf0KhAKuf9Ov8u162f8tyxkaf
 eIxMaQyE2WYiM6x1qN4lGjwe9UUK2DeGLWzISouQC1iM_wzkfPG58XH260m3q.Qq309vI6NMOAZu
 wSCPc.3gEeaLSh_a5FFG5K3Q8anER_5y0i2dX37eWyFWUIAGFVMO67pP0ReZI_7MzXLW0H1fZAXa
 nNpa8T00HgbcPqPOI9neJeY5y69OS_rLXLmamAlEaqrlYhDtieHPJSsYN7Doirnu6zeWn3cMjTMe
 6ag2bDuBKbc0zM4VbAIG4RZURvlz2ffhDtL0ozDhfA1ecoRKRWzwsvJWGqMY.Sfisecsi7o8b0fE
 vzZmWcjvrAvwc..phVwW8Ql1bEjIb8GlW3rc9TToH_jjoCZER9l3_XEoZBIPpuKWeDKQVc36Ibsn
 ra4Lcok0xK60EWB4zwvwnrJCCblts.SZN6UrDEW0GdRgCLUwX6jFJhyH72jBus0g72MitBYc8H2K
 Jjlh0dTRApUMvDSt38vgjSEsJu79FSQJyGkYfBBWVx9KhTawJ68qifP6E3o4ZlH2xxgdYLirDRCu
 5QhxY7trNQkx1MUzuOvNxBCoiJ6EyzST8cSDGqpSfxPXkL5al86Ij0YMfsBb9XxC8oYF2kGCAhcg
 ezl6zqOTpGrMhC9GLcCsGV5wcI8cuTOrhNEKmqFKSQenICmgFLyCJ0gHCTAgXHx6zPyreuH.uQWa
 9NfLF4OZwB8WAxi2u4W8a.7Gx9AH2XGxy4G1YgBqyqnZos77N.pNOZv.abhHZPln4GMS5hjnSxCf
 u9pBNXEeUnLOZaBTDL1YHC6KuZIyI71sRWIWVfveEijDZxFbf3nO4t787JHh9DxSz61OgPtYW8R7
 G90Zm4WHMKzsBzVkAlHWb16uUdLihEcEL.7R4xFSLijOYtPTuQuzlUmtGv5hbrcz_4XjpTcxKgu2
 GZ6fNwFfAtCo2qE8GeFjhhTnX9HTn.jM2RENxlBBIRxO0b_Pujk4sWRky1TSiHngGycU.8NubFO.
 uhdUpTxxnrTrVLH3uNCpvo9WwGnFm7TT4f0Jz6LOqH.Wc4eklTrceOhdlJedulAfwJR7ZqAu6JkG
 5kK5J2QEeDzTxz2lrmkQTitKgJF5y8HsVI9qA_xsy_Uw3Gm0qFnE1TC8ewdSmGB4.BLHt3KzBbag
 QSGvER370XLs9sPyWEAwS3X0FUKO4BApMkfvL6LDtSmWsDNSQzsGkNHcaSiD5S77jKP9OwW5LsZc
 Zgd3JTam53BhnyCuq_zMffGMZrAG2LlTG3_Z_u3kZWbm.dW7GphDZlDCyEfOx_UESO_y3kQPFuxq
 7zoGKxRAqWCrVDssS1audIFMS9.b__FqRyVZTlhSR2yAcZU808bAh4Ft8_nKHLcARNhDN24seHYj
 t0d26HR5X3d1n.GPDH4T0QMjur8Z8PbopRmcIl4BETb.l1P1vPycGkFrSK2xn2h3yal08Pql.2ku
 2OMTMwtyfUbPWcSbPWVtg9HOsUPiVSK5A1E9Ddvl6jDbUScRIzPPj4jz4mVs0lPcDya0TQHms_ck
 7eijdah6CGunzkU9urGsSkW_GGMsAb0I7MKFxxlc_oeTMzuLqq2ogmi193Ie2lzNiqdTkiovNzTf
 U3.G8aYsIHzsFy_rn0drAuwzzD.lWmhlMB6M3AbA_WzFz6VAI_VbDn.iqQsWcXCItwMCvP2NwS33
 VLZpFX7l.ZxSRaBfVpLpTwmplzB4dmkFvVqAlhQFQqlyKxBWKrxWTwDfzed2qZUNANnfw4fdhg1t
 UjnAEgsPH_wED6je.qX9d7EOUmOpLL3aB1_VicihZIFI2gkwoze1a4aJzSrCfvtAEpyNbgNdeppb
 XPGBwm3cR4T3oNgsoWgJKyHltDP2PesK7ey04QeZZYKo2zvXcC9ZayLOJC8CGKzzy6_0p8XEa9pe
 Q5cUp
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Sat, 30 Jul 2022 13:32:01 +0000
Received: by hermes--canary-production-ir2-d447c45b6-fs4tk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a6cbdbc435e8cabd45c6e78cbf4fdfde;
          Sat, 30 Jul 2022 13:31:57 +0000 (UTC)
Message-ID: <fa6c77e9-1d22-de2f-4cad-4afadf8c6a2a@rocketmail.com>
Date:   Sat, 30 Jul 2022 15:31:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 10/10] iio: magnetometer: yas530: Add YAS537 variant
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1656883851.git.jahau@rocketmail.com>
 <69a512cf5b62b34415d5983a6406c3d5ba438a1d.1656883851.git.jahau@rocketmail.com>
 <CAHp75Ve5Z9OOx94FtXY77_Fwkp27D32Hn7bAG+Da++HXmupytA@mail.gmail.com>
 <c5643cee-8491-3fae-b9d4-ac03d86c1e8a@rocketmail.com>
 <CAHp75VdDdKo7rt+cik4J+_4tDRgBXhgZYc8p+dOSH4s_gtCOUg@mail.gmail.com>
 <6e13daf2-179f-d37f-ace4-db5cd37be8d3@rocketmail.com>
 <CAHp75VdLBowZ7=6g4aFVr5zkN5Pkv7ir68vPCdkRmoFysqRz9Q@mail.gmail.com>
 <f8071532-14c5-c2a8-ca75-f4327066817b@rocketmail.com>
 <CAHp75VcPMZSpDS_S_4mM2bfq4154HVMHzZHvdJnP6oUA7RtpiQ@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VcPMZSpDS_S_4mM2bfq4154HVMHzZHvdJnP6oUA7RtpiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20447 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 30.07.22 13:32, Andy Shevchenko wrote:
> On Sat, Jul 30, 2022 at 1:10 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>> On 29.07.22 19:24, Andy Shevchenko wrote:
>>> On Fri, Jul 29, 2022 at 1:13 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> 
> ..
> 
>>>> We don't know for sure whether it is a 16-bit register or an incomplete
>>>> register naming.
>>>
>>> By the values you write into it seems to be a __be16 calibration
>>> register. The value to write is 0x3f8 which might ring a bell to you
>>> if you know what other values related to ADC.
>>
>> Sigh, ok, I'll apply bulk write.
>>
>> How to do it correctly? I guess:
>>
>>         __be16 buf = cpu_to_be16(GENMASK(9, 3));
> 
> Looks like that, yes.
> 
>>         ret = regmap_bulk_write(yas5xx->map, YAS537_ADCCAL, &buf, 2);
> 
> sizeof(buf)

OK

>>         if (ret)
>>                 return ret;
>>
>> The whole block would then look like:
>>
>>         /* Writing ADCCAL and TRM registers */
>>         __be16 buf = cpu_to_be16(GENMASK(9, 3));
> 
> (Taking into account that definitions are at the top of the function it would be
> 
>   __be16 buf;
>   ...
>   buf = cpu_to_be16(...);

Thanks for the details, I'll implement it like this.

>>         ret = regmap_bulk_write(yas5xx->map, YAS537_ADCCAL, &buf, 2);
>>         if (ret)
>>                 return ret;
>>         ret = regmap_write(yas5xx->map, YAS537_TRM, GENMASK(7, 0));
>>         if (ret)
>>                 return ret;
> 
> ..
> 
>>> To the 4100 denominator:
>>> https://github.com/XPerience-AOSP-Lollipop/android_kernel_wingtech_msm8916/blob/xpe-11.1/drivers/input/misc/yas_mag_drv-yas537.c#L235,
>>> seems you can find a lot by browsing someone's code and perhaps a Git
>>> history.
>>
>> I've seen that comment before but I don't understand its meaning.
> 
> It points out that there is a SMPLTIM, which I decode as Sample Time,
> which is in 4.1 msec steps (up to 255 steps).

Also thanks for this interpretation, that makes sense. Then the
denominator consists of factor 1000 to convert microseconds back to
milliseconds and a factor of 4.1 milliseconds per step. The value
"intrvl", which is written into the YAS537_MEASURE_INTERVAL register,
would then be the number of steps of the sample time.

However, I wouldn't add anything of this into the driver as a comment or
as a name, because we're just guessing.

> 
> ..
> 
>>>> Still I didn't get your comment. Is your intention to change the "50
>>>> milliseconds * 1000" to "50000 microseconds" in the define?
>>>>
>>>> It would look like ...
>>>>
>>>>         #define YAS537_DEFAULT_SENSOR_DELAY_US  50000
>>>>
>>>> ... though I would prefer to keep current define, as it is implemented
>>>> now and stated above:
>>>>
>>>>         #define YAS537_DEFAULT_SENSOR_DELAY_MS  50
>>>
>>> No, just to show in the actual calculation that you convert MS to US
>>> using MILLI.
>>
>> Sorry, I still don't get what you want me to do. What do you mean by
>> "using MILLI", can you elaborate?
> 
> You use formula x * 1000 to convert milliseconds to microseconds. My
> suggestion is to replace 1000 with MILLI which adds information about
> exponent sign, i.e. 10^-3 (which may be important to the reader).

Hm, ok, but the MILLI has to be defined. Or is it predefined somewhere?
I couldn't find any examples.

To my interpretation, it would look like this (upper part showing the
location of the define, lower part the formula):

    ...
    #define YAS537_LCK_MASK_GET             GENMASK(3, 0)
    #define YAS537_OC_MASK_GET              GENMASK(5, 0)

    #define MILLI                           1000

    /* Turn off device regulators etc after 5 seconds of inactivity */
    #define YAS5XX_AUTOSUSPEND_DELAY_MS     5000

    enum chip_ids {
            ...
    };

    ...

    intrvl = (YAS537_DEFAULT_SENSOR_DELAY_MS * MILLI
             - YAS537_MEASURE_TIME_WORST_US) / 4100;

I think the define and the formula both look strange.

Kind regards,
Jakob
