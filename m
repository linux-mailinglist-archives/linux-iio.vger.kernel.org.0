Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D30581C00
	for <lists+linux-iio@lfdr.de>; Wed, 27 Jul 2022 00:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiGZWNv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jul 2022 18:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbiGZWNu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2022 18:13:50 -0400
Received: from sonic303-21.consmr.mail.ir2.yahoo.com (sonic303-21.consmr.mail.ir2.yahoo.com [77.238.178.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDA237190
        for <linux-iio@vger.kernel.org>; Tue, 26 Jul 2022 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1658873627; bh=WnDSar4M0IRuwbdfoumwWgdg1u834RKapjEGss+3Yg4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=RYj2S2hGV1pTMfifJcb43TZ+IB61Gm8/LTqGL0Q15enkwGgP0D3MTztqytiW++eCcm9t0t8Xv52pTy8cLDWQU3rQW5L1F+37SDMmeawNZMX51//Hv5RqZlqHcQ2gb2aeyC9EBXygPukBqd3wTzRRNLDbhOWJtQ/QmLms9eQTR5H9vRKH3RdCyqyAu/QEgEC70MnMHnjbryRxUgVE+LDU1mjfavYnYpnRLEDrELwXMHLRQAmg7ldv/QJu5aGCVA3lCZJHihgnsc27lK2DFmUDtBDExI68SkuexDhysmggfwa7WkpFbRrIEzZJ6EZ6A9IGk7mDeRhIdqwXUJjXBn5pgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1658873627; bh=tFYu0mV0oSWJ9UUI8Nmak8dezJItJjSm8i2u5WMPy6y=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=nEJH3xoXJQxfFeFjvWT313gkyU/h0dMI+cpYWUGuGinm9Rb/UMqnkbnuYvwM70pa9Kt+XaCb+G/1jsM7PbNdzcXVUHwZ500L7QuAEQkZRU+XI+dy4qi+3IiLfZxfOFHYlzXEYd+XFNjTmNhHzTy9X6gRDjmmV32tit+VNfhH27qwiZZuskW/jtZSILgDlvieUjZ35/06snMO9XaDJe+wZRUkxnpu15Po31nrkDK+3ALY2sK9J3z5d8hK6Gr47njt6vqXTSxC2B/ler068UrvXSF0H6XuYTBfRE8JLIhJ4/R1iiaA2t99hKYA/sjN9lvA040VSBSjDGUKPC0BKSrKcA==
X-YMail-OSG: Bhk8f1kVM1laX_3C5rfQF4ZzmDH1OKWYh8yX6QpASwbuWUsgcAvTbHvP65KLr7n
 PbXNDv5cNBoEKihzsxLnI4Gek.In4RE6pjRjik_4Tukv7n8teA_G8BooM3J21dTyYKuAxn6_oYv.
 18YtQ2dILrzAcp2R9RpTTmZNPJj2GZ_E689aooNL70TkbZM9FWVIxXSm12jCYymNFG8ypEMbRok6
 j5cAbP5LvjVSTLXVQkTmM80U9Y04.RnUEqk55d7.MNMb13Ht9Iq.DlxzB4IXhsRLtI7Zmph315i5
 rv9IFF4rXzBLlS3szEaaa63ikGSQ1PiMQaEiYX3z2nINEH6LcuW9gwUxt5TRjlMEC8axhhZ5O0wr
 N2xwjes5IV.aEGme.Ittn_VoSfFrN4TEpLhrtMM25y44xALliI6ipWyLCHyb09m2uPmx0uWdlnMI
 GuB_o.kTtuSkT_4jpqS0bXKLijlGgXbldN5FmGoTSSHGwyfmfGvE4pp.cP7zKai2dVPaNQxqbJHc
 ueZdFqGqFu3U7_Zh39.Qu6_hwbz22z86kcOZjkVi3N5IBGmplFFN9dqml1kJ5rz2ID_XCvX8AYee
 gp3ndQm4NzLC4LM9v7a4j.x1j6ghEgkdha5N_Iut1gyv3ScZ6ux_.yb0cyDm9Dhv9WE13PPDBRWZ
 zIiwHs4nT8lWcdvfnQcKFtnY77wS9BiqEZ_u0xzjnYHBJPkv6DNw0MeNEwm.VV4hyfCSAQ1a53f1
 5kjvS4DJ6IgK0a3SpEpxt8RJqzu5SGRtYNsQNlNYbbwYpVZUBrMyGssKugQMJVd_FhIC0gXsLp9R
 FLliorh7I.R4Xqo98HKLkUDC5DYhF2d8i7s7MuU7K9itm4x5EeIB9ec_dpCriPeQloLnYhPjH6Zb
 BJK1ealVzj7gTk4g6eFXwKBGUKBpKW7xd1VDnxcVsHkyNztBTxkwOaKg7UFVyuqdTFHONr1rwKpQ
 1tV.dT.2T6JbtNpX.iT2NmUSkkcSTqhgWRnyydw3Q.tZZ.J9JhjRPceMZ2xMdF5oRELo1BFiYYGU
 s1MQVzNge4AJI92z7w3SyfK3yKYjLlWuSkX_cd_EuNO6jnoIFsAwt5jcxo5LUQyDvKSUyozhMNwc
 oogftgXqGhqDQ0M8W9NSX_YHPPCOQOX4vdM_3KEcU7y4C4VxpKgj31Mu8GS.TtVDda.vb6hDLpll
 8VY0IqILf0qnq8ksiK20J1k32WNVTw6xnNO3970Ekirfb9agyTln4U3Hi8kcauy31TRhz8pQn8Cy
 aTUzBlTn.WhhqFLeCsPSNJd.PH3ikqbFGGKb_2Fc5sAFrEbjEJqviEIZ999aJvmxzhtHr4n3afGk
 8VrTPefgk0ehfOzrhpW93ygbWZxFnh0CuUOyv5hEKdZ1r5BDX4s8pmiiC2JZlCS8E2rC_MBGRgeH
 bt.HAg3rOyHsDGPan3UWkHOLN7hQQM4HeVriTUPeAC0_cOFD9gU9HwwQD9D_yTDBoW79n0Q3ISDw
 D6qW9V7PmHhK.lsxh5l0OnkT7QrotYHizot.6glqPdIBg0mOdQJESI0vJfjYoh_A.rEMozP.YTKr
 rlyXjt0Liz7cjVd5Q.L10VdCMFcAqX_BJl6IH6e7dZY5CmWECqsN5d001ScSflZZ35qOoVqzxXDh
 T6aYEqiqGTCdIs9HmN81qWkquiXRQs6hPoESPoWHYbhHnqPxJyRp4oGaYTNXr3IkOXPj_9Y5k2ea
 pgzsWCrtrhPfa3Z.tM43kKR3RDgDdUX9L4tVaBpoZU6UBF0yKA1y8YXjn7puYcuYEos2ef8MFcn0
 idq.VZqd40fgU03Cj8UJzaKx3o2kizV8b6n_JiZioDW7GGRfyT.7a9lLA5.n66mHCYKu8bXEbpOm
 RH.xFUSqMj7PxNUGObw4vW72RzMWmOrLPvs8mHQrpTzJjzbsmZn.a4L0wboZCIpJmPkrcL2.6vI1
 jyDzHDhKi6OfKWzsTNerNP93WDfRk9Tr3fftBCsFZcKlQq2j2nwSVKUTClXjEXtqdnc85uNCego8
 8KcR2U8A1ZM2feUSEWYBY6JZGkfGoLMnNqq0so4t4VOBsmEeNrWLl4PcQmWscW6DxCvTVX.zqoTE
 auwgQc.YzshK1etKjC5oIEfW2FSbc.dy_SD4FbXWcVock8jDF5WXbZL4eOxEsGActLcZY2.zRIsR
 F8CD1tA6Mt47EQbZLnkgmO2iOiwTwMTPikQeeC6CM7Qr0Rplxliya9KE.3PDSdeQm35xcNIi8I2z
 4AInMznKfDWPwWdlpLJen6v64d.0epI.0iKGIRQWHC3XlbxvRACNnX5qbHjvIiq6y7jHbstDzV5p
 MUijLNaQ-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Tue, 26 Jul 2022 22:13:47 +0000
Received: by hermes--canary-production-ir2-d447c45b6-g7mlg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 448bd9754c6ad2a304e09154a80cb249;
          Tue, 26 Jul 2022 22:13:46 +0000 (UTC)
Message-ID: <c5643cee-8491-3fae-b9d4-ac03d86c1e8a@rocketmail.com>
Date:   Wed, 27 Jul 2022 00:13:45 +0200
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
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75Ve5Z9OOx94FtXY77_Fwkp27D32Hn7bAG+Da++HXmupytA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20447 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 04.07.22 21:47, Andy Shevchenko wrote:
> On Mon, Jul 4, 2022 at 12:05 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>>

...

>>         yas530,
>>         yas532,
>>         yas533,
>> +       yas537,
>>  };
>>
>>  static const char yas5xx_product_name[][13] = {
>>         "YAS530 MS-3E",
>>         "YAS532 MS-3R",
>> -       "YAS533 MS-3F"
>> +       "YAS533 MS-3F",
> 
> This is exactly the point why it's good practice to add comma for
> non-terminator entries.
> 
>> +       "YAS537 MS-3T"
> 
> ..here.
> 
>>  };

Yes, makes sense.

...

>> +       /* Write registers according to Android driver */
> 
> Would be nice to elaborate in the comment what exactly the flow is
> here, like "a) setting value of X;  b) ...".

Unfortunately, I don't know more than what the code already says. In the
Yamaha Android driver, this part looks like this:
https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L345-L350

The comment "Write registers according to Android driver" actually says
"I don't know what I'm doing here, this is copy-paste from Android".

I can remove the comment if you find it inappropriate. Though from my
point of view the comment is ok.

...

>> +       ret = regmap_write(yas5xx->map, YAS537_ADCCAL, GENMASK(1, 0));
>> +       if (ret)
>> +               return ret;
>> +       ret = regmap_write(yas5xx->map, YAS537_ADCCAL + 1, GENMASK(7, 3));
>> +       if (ret)
>> +               return ret;
> 
> Can bulk write be used here?

Technically yes. But in this case I strongly would like to keep the
single regmap_write as we go through different registers step by step
and write them. That way it's much better readable. And it's just these
two that are neighboring each other. As this happens in
yas537_power_on(), it isn't done very often, thus doesn't cost much
resources.

...

>> +       /* The interval value is static in regular operation */
>> +       intrvl = (YAS537_DEFAULT_SENSOR_DELAY_MS * 1000
> 
> MILLI ?

What do you mean by this comment?

The suffixes _MS and _US were proposed by you in v2. I think they are fine.

...

>> -       ret = yas5xx->chip_info->measure_offsets(yas5xx);
>> -       if (ret)
>> -               goto assert_reset;
> 
>> +       if (yas5xx->chip_info->measure_offsets) {
> 
> This can be done when you introduce this callback in the chip_info
> structure, so this patch won't need to shuffle code again. I.o.w. we
> can reduce ping-pong development in this series.

I did this change in this patch on purpose because it's the introduction
of YAS537 variant that's causing this change. YAS537 is the first
variant that doesn't use yas5xx->chip_info->measure_offsets.

Shall I move it to patch 9 nonetheless?

>> +               ret = yas5xx->chip_info->measure_offsets(yas5xx);
>> +               if (ret)
>> +                       goto assert_reset;
>> +       }
> 

Kind regards,
Jakob
