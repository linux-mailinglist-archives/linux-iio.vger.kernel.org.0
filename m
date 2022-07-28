Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642AE584895
	for <lists+linux-iio@lfdr.de>; Fri, 29 Jul 2022 01:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiG1XNZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jul 2022 19:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiG1XNY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jul 2022 19:13:24 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com (sonic308-19.consmr.mail.ir2.yahoo.com [77.238.178.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2E64D82B
        for <linux-iio@vger.kernel.org>; Thu, 28 Jul 2022 16:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659050002; bh=s/WSooojRrP9tZaxzqJceOX49hecj01ku7KLOvg1q5M=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gpkf8Y6dEOkTqmcZSX4lnbdGz/7m1Xrvu/U2yK0qX2BHlQwzgc8oW90XSU5sqmQkSwZ8i7raR9q5L2VFxe2/4QZNU169CXYMMhmhBiqy4iCc3eKNpps3ytBhfQyWLUpMgDO4Rk9VarMf5v+rPrEyB8GZBbFjXgLoe1tFX4SvszxO72cjcrd+9nHdmu8aAO3x1JBtnEQaJQInXX2O/sDp5dmX516aPhjF5G+uvX/8PBzSMv5hfJl4KjfdsTSRtX0mTB2cW12Cz3r/wZqQQNV619h35dGsAyEr2yXu9L5o7sRk7EZZGFtcB3mdGjGL+m0emgtGpeBhp5LV+edRkg2IGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659050002; bh=BlIVH2GPTezadxUqhIvwAl4nckpWvVXFAAGBoZyiqOX=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SXQMsBXEeckQfisD1g734v5WDZ+9hgeT+avBaQ3tnGMEpOBCPeEHYjeZoRA7r0xOM+r1QPpFsPbUoY7zB+ibxtrWpjbixdw75ZK66J4DpW1OjeWzg5m6nOmO1ZN4JOdymnTNCGBA1Uv0eH9gRac1l04hoFGZ777BY0fbDwTWxwuiQXrqmr75h7hFZJ0TQtAlv3Qy5hn9d9psiR/UXR8Ff3o4NVd8tfhm2/hlAVKDNyBYH9oifFCRbuzX/2PS120VZP5K+7/haggJRx1VV55EEPT2KdVaQnqCmZ66LxYktD+VMlAEoyMmCt5ye1wXZQlCc3DvmJ6PxxyMLCB8+zwnrg==
X-YMail-OSG: 7HZri7wVM1mGIdjoeNfxttbaf7zqz0hoyUMT0nCpuKQS9hs6WFErEeVOqPXmjgf
 _2jdD1S9DR3XkQnVhh7aRDXDrCu2kuDFOM5tPQ9rOq0k3uTeabHFtTN03o7q0ZYHKFXGY0r0QucD
 In9wvWpKEmWdtWlidA5MkScjZhxNdJbyqsZHPYCgrSP26o52DNfGbxtDrPdFOyykWnkJcd_y3LGU
 TQcnWh4DDrIz47iCtDGPCR5Hu1mM4htkMhtM6QBK1WCOa7t8Hbm4JaPxqM3Ec9lN4SbVYmWofGyq
 Yl9s5zsLsODN4Vx21jUIw8TOHSAmRmgA5Q71kXQlyTWGIfWfOpfo8sOWP2LQHTQtZ4ZtVUprf74M
 0RAGuF2WaUERUWBbpoM5SK8KZB6wAa5Zbnm8zvVg4OxDf8Io9_HgKFi3mMWYG5knRoG7Fieg2iGp
 s8vMxVwlyCH8NGOo4LgVO6E3iqY21qrNk2WxmdVSHGOX0V8oK2X07F.vGhYBh4NyL.WaxMcuS1Fc
 qMIkxFgs30QA9b9B1HZHNWY_o.Vxi8go8hfdzbNnlul71aV0rKXyVBH.LkczufBJoNWvOJewhd0U
 RAjztHABW52M.cvcB8KArkXMQOUTm2eepjJZxBtgitxDtPOdGXL05xQbvZWf2kByT9J7Ced9tTaz
 pEeENmwAmC5R.QAcz77f0JOmosx_yadWyfZZotFVMjRS8RHJ7SeZpPHBu5AFh2p7eLCS8f5793rJ
 fPWeBnBo6kyXO2R7g6YW6V7dt06OlsZKk0uvVdxNyAzfY9mLgZYpd4TgxAgT2GFax0RSg9aiQ0LU
 ._S4qzmRBS9IKaxrkfO4fUNr3IBVTl31J8F6TupMHHcdcWZX0aX3dWHcCs3ScLFE.Z9ZQEcixy.m
 0HeFtq_Xh_fNeA0_OzTQ54PIEEIEYcJY9Xc8AkqAeHBlI.ve_lwBNhzu39mnoyzBgs5Hkv1I_RPw
 WhBVjZoj3LzGji8HQfnZLwO0PR0jpsEauXIvg3LRpiK4QrU_uh3z.7DrRdmJnhV9N6E1LjGLEPdq
 AQRSMSnCGDJhsmDX26RSibidkpyIx7DxUA57UUr01b.n_23nN1eW43PfzZ_fpqqAonsme1_txs0s
 OKpCMWhDhMB.Wn6PB6Wf.qOsBp.xQYXX6zmwfNbqqQHgNbYlmo.TD_VSLEPghVwvbE3yl9TzEiQV
 yl7Hw6domRoA5AQeRrFCEuI5uWpfwN64fARRQk7RCttPHdiSGrOOcYQk7CQjC6mL5ZiZoU2sBHQ.
 BubxyzjRzubN0BwAw1h2U8eVTmnFZn9cj6gibawyr0UlubWkAc7aL5OdqvdVW2VqsKmL36xhAxFK
 XZFUhwtlF9iYf560xUPWtyomxx_K7QC1OiytJP37z6ql7Wp2BHGsoStnDbLwnhdeWQnQz2VsiKX0
 ecm_8gtDo1R8zALqh6ON3mTpfhTThHetI7Qr3.aYI7FFAlk7hnjVwqU2JSM3BwOVDMke6HDJVLnP
 Kb_J2O8bu738ySskhkieiPEDhNMafGAM7PYzupqJ674qfvVDhnPcnk3UNkz2dZ95UUroDPMOGMPz
 V778jrzw9ChDfpLc.qGC6ecRHtS7kglm8zmLEe6OqzFmtd59VadQ_kkGMbx4elNgEpNu7LYJa_7b
 VgQZ9BVnC1tkVL3O6n98JZk7A_z77glvLEjGDat5x5unZSDFRMADprJUnkOfAvcpZhzPLUChhKyQ
 T8o6aZz5FXidPmAAxDmgrYrDWdxoHHXICJqGy4PjMsvbu.Gf32pTjz2FOpZGvpmn1_LnoS4As2lE
 3O9O7jnbRtLOkVH40pMKst_cqhlHU4dvvEoMg_BCREzc.h_L6S_iApR9vRZDQKFBB6gKjvzSKY7x
 h1eul9Gf7sonMJjpTeJL87weIVM8IQgG_wdokJY_aJRK2ttg1yJqgpmOZiVa0pprbOtpCyQ4jcH1
 uRFcRbnrY3__Mldb8H8NKlz7a9zfMqThWQ7axNszbIK59KzcvoAD1AXDXKaa_Pi2bQPR8V7C1Gue
 xDfnJcEfQRvTFmMSi8hy0T2UJsD.UzPzP2ZiYCdNB8KHj7vSRL2PTJpptMaGr0n.MyyfZbAbPvaf
 LvP5X6LCoz3aFnLuo89rDazQel.EZz5w2dTW6WLpDMUDJNN4TORZakfLrylgWZImwem7VdDXuEf.
 aYX_w3kznXDl0buOJBtm3S0rXMI6N6yk1Jxhl56_9xOnFWzrFSc_q9k7W7LjZqhV0LzdB21V2zWg
 wMkiuREdGiYITA81e.WHsUg2P943cYXW049xV52lBs8x5fLirZb7laFC4EX6ZF95htPndG6DRIEY
 -
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Thu, 28 Jul 2022 23:13:22 +0000
Received: by hermes--canary-production-ir2-d447c45b6-sqmx2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0c0520b279e1b4d01c1fdd4cdd6345a6;
          Thu, 28 Jul 2022 23:13:19 +0000 (UTC)
Message-ID: <6e13daf2-179f-d37f-ace4-db5cd37be8d3@rocketmail.com>
Date:   Fri, 29 Jul 2022 01:13:17 +0200
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
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VdDdKo7rt+cik4J+_4tDRgBXhgZYc8p+dOSH4s_gtCOUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20447 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 27.07.22 19:46, Andy Shevchenko wrote:
> On Wed, Jul 27, 2022 at 12:13 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>> On 04.07.22 21:47, Andy Shevchenko wrote:
>>> On Mon, Jul 4, 2022 at 12:05 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> 
> ..
> 
>>>> +       /* Write registers according to Android driver */
>>>
>>> Would be nice to elaborate in the comment what exactly the flow is
>>> here, like "a) setting value of X;  b) ...".
>>
>> Unfortunately, I don't know more than what the code already says. In the
>> Yamaha Android driver, this part looks like this:
>> https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L345-L350
>>
>> The comment "Write registers according to Android driver" actually says
>> "I don't know what I'm doing here, this is copy-paste from Android".
>>
>> I can remove the comment if you find it inappropriate. Though from my
>> point of view the comment is ok.
> 
> The comment is okay for you, but for me it needs elaboration. So,
> something like above in compressed format (couple of short sentences
> to explain that nobody knows what the heck is that) will be
> appreciated.

I was thinking about:

/*
 * Write registers according to Android driver, the exact meaning
 * is unknown
 */

This reminded me of another location where I first had a comment
"Writing SRST register, the exact meaning is unknown". There you
criticized the part "the exact meaning is unknown", so I changed it to
simply "Writing SRST register".

Accordingly, I would choose the following comment here:

/* Writing ADCCAL and TRM registers */

>>>> +       ret = regmap_write(yas5xx->map, YAS537_ADCCAL, GENMASK(1, 0));
>>>> +       if (ret)
>>>> +               return ret;
>>>> +       ret = regmap_write(yas5xx->map, YAS537_ADCCAL + 1, GENMASK(7, 3));
>>>> +       if (ret)
>>>> +               return ret;
>>>
>>> Can bulk write be used here?
>>
>> Technically yes. But in this case I strongly would like to keep the
>> single regmap_write as we go through different registers step by step
>> and write them. That way it's much better readable. And it's just these
>> two that are neighboring each other. As this happens in
>> yas537_power_on(), it isn't done very often, thus doesn't cost much
>> resources.
> 
> You seems program the 16-bit register with a single value, I don't
> think it's a good idea to split a such. When it's a bulk write and
> value defined with __be16 / __le16 it makes much more clear what
> hardware is and what it expects.

We don't know for sure whether it is a 16-bit register or an incomplete
register naming.

Not all the registers are properly named in the original driver. E.g.
there is a register called "YAS537_REG_MTCR" [1] with no names for the
following registers. Further down, this and the following 11 registers
are written by just counting up the register number [2].

It looks similar to the situation at register "YAS537_REG_ADCCALR",
where the numerically following register (0x92) doesn't have a name [3].
It could be because of a 16-bit register, as you say, but it could also
be a naming thing.

At the location in discussion, the original driver uses two single
writes [4]. I'd stick to that.

[1]
https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L38
[2]
https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L277-L279
[3]
https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L37
[4]
https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L345-L348

>>>> +       /* The interval value is static in regular operation */
>>>> +       intrvl = (YAS537_DEFAULT_SENSOR_DELAY_MS * 1000
>>>
>>> MILLI ?
>>
>> What do you mean by this comment?
>>
>> The suffixes _MS and _US were proposed by you in v2. I think they are fine.
> 
> 1000 --> MILLI ?
> 
> 10^-3 sec * 10^-3 = 10^-6 sec.

Ah, well, the full formula is ...

        intrvl = (YAS537_DEFAULT_SENSOR_DELAY_MS * 1000
                 - YAS537_MEASURE_TIME_WORST_US) / 4100;

... with the fixed defined values:

        #define YAS537_DEFAULT_SENSOR_DELAY_MS	50
        #define YAS537_MEASURE_TIME_WORST_US	1500

So it means ...

        intrvl = (50 milliseconds * 1000 - 1500 microseconds) / 4100;

... which is:

        intrvl = (50000 microseconds - 1500 microseconds) / 4100;

The units of "4100" and "intrvl" are unclear. I don't know if "intrvl"
is a time or some abstract value.

Still I didn't get your comment. Is your intention to change the "50
milliseconds * 1000" to "50000 microseconds" in the define?

It would look like ...

        #define YAS537_DEFAULT_SENSOR_DELAY_US	50000

... though I would prefer to keep current define, as it is implemented
now and stated above:

        #define YAS537_DEFAULT_SENSOR_DELAY_MS	50

>>>> -       ret = yas5xx->chip_info->measure_offsets(yas5xx);
>>>> -       if (ret)
>>>> -               goto assert_reset;
>>>
>>>> +       if (yas5xx->chip_info->measure_offsets) {
>>>
>>> This can be done when you introduce this callback in the chip_info
>>> structure, so this patch won't need to shuffle code again. I.o.w. we
>>> can reduce ping-pong development in this series.
>>
>> I did this change in this patch on purpose because it's the introduction
>> of YAS537 variant that's causing this change. YAS537 is the first
>> variant that doesn't use yas5xx->chip_info->measure_offsets.
>>
>> Shall I move it to patch 9 nonetheless?
> 
> It's a bit hard to answer yes or no, I think after you try to resplit,
> we will see what is the best for this part.

Hm... to avoid discussions and shorten iterations, I'll move it to the
newly "add function pointers" patch in v5. I'll add a comment on this in
the commit message of that patch.

...

Kind regards,
Jakob
