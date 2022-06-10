Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA810547064
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jun 2022 02:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344935AbiFJX5r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 19:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244610AbiFJX5q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 19:57:46 -0400
Received: from sonic313-21.consmr.mail.ir2.yahoo.com (sonic313-21.consmr.mail.ir2.yahoo.com [77.238.179.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4001915F2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jun 2022 16:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1654905461; bh=jCSiTkteS74dgbk0AXaRNqgIGulLOepyzxTVr+DcRg0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=a88z3pwaCD3ajFid7ocafw/OnN0H2lCUIt5UBCV/ErEj/SsAxbBZHiqHDI6IRYKLO8R2UXosRkdmAMPPQws0Im5ysosDKOW241HPbukgpYlLf0/vc/ZZ/4E9tWzQeu7xWx8j62LUuNg4WCE7IQrACT0KRfrKe1GWqL8CbRYKROsIR/QMcjCIl2TS/IxpLlyF2o7inSQ6VawWuCCQPvWXKVAteMu/DwNZLMeh3zKNucDJtvElNMHuQjxDOX5t+7LaYKG2GykEw5B54dMxmorG0SuosRGh4e31fwaPsPbfT4I6eNamuU1b9Mwc02aCPq/MEpkan0B1XXUXkGYLX3oVzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654905461; bh=hKeqn3Loq9Ygb16ecHr2nQ7HIzLyLrIwCG6E/v1AJUK=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IW5sOm27NMuuV/H1xJvQY1oV0rsBZ2d0GC/sS3etxhd0ppJ0veRGSPJRkfQYZHM4MflaTQZSSOPFHmsZUWaWqgQ8QKG4ihtfeTVAIBX6Sfj6hd+wchzx+Js2PkzaBqMlOn+7oMKXfIaCjnf4wfnBbVqAE8qOn5r/kBp/MR4DpEOfv18I8bUjF8wHbGqr3+qvGdPSvxY/ZpHEIjOSP4FDi/IkSN3dmV8rjbGoqBW/ZeVrM7gIUaIB5V7DDjh7h9bnO1R+T1ma2qkoTx7b8IARP3vHzbWywg93qRv8R7yMLbqXqWgF9jVqi85gsEO502/3Eh1coZZlKBTRpDluJBAq0Q==
X-YMail-OSG: RvnHKIMVM1mpV7QeNMEkO9sapo1pi9N.XdH1hnUHFwHnBjP4cA3CejeLmBOLUJX
 xgib.1D23Bm.1Ua6HxvtOOeWFobNRSxfzoJKfisGa2U7bhdNNePqd.opB1KV7f_bs1inweVd5xaX
 AYYDjGU429ijhizjnRmC6c_LxcidWgLbDAgBYT3RmV6_QsnR6YNtQcC3Hi.f6vQrb4p9eOQw.ceL
 kAO4CGF7ic1CgIwYp8NUtxIPLcFib_iL0OIpREGa3ux_EAToOUfNF08TTUKKg9p2Q4g0D4fuNwcm
 oJpEDLVEAochxawEyWebueM_52mtli4ND3iGlvqv90si1Wz2rYVDRYxLDFalqy8i5wd5vt2BnNlu
 qTWlk3krv_4Bdgl9T5cvd9IYYaiZymBwPJwJqbjG_FPaijJkoHtY7RvUqM_z1wVfOejM30rq477q
 ockUlKerdtUhPwxGxTvS8p9Da3X9GkASucDy86NFH2.vsIIeZhH1RmxTOOsWx0aPaOBkmswuG2J2
 J5nLD13qdYp0JbomL09xJnOX9_kvP3JmJQ7UxWkxKnT1JcRxnFFulWvQ3YY_RQlocmwTYb1QGMxH
 nMd.RFLI7g.VBdZvG75_0WwTjPvMneWvY8z2crR_dtRA8i8hQeZRFxmK0HqdmZDDXBwRLljQyhcy
 hVgZk5juYLDCpCZtjL87Riuk5icuX7uqFW4wb9XnbKr0AdFoYHIi6abUqSUBi7Vx7jqRaNcNvlck
 DCopTHPPp3voJGCHPzYwx3MFf00hiAqPs4jft.WjaaDFgCHZTKff.4JEThNLfvligzCb.FAtmQKs
 podWpkGI7AL4zFG6kYbc3VuAaezDvXmmlH0IL2o8IoSkE7ye5.U0KG4zp6WT4cTbzZDqt.7delp0
 8g3ZTVT2.0EvNcZnuuk3vfEqRVex6peWftjWu5CkWn56GvGV4gPXNSgC4q_.iGsrk1VetMC.fxPJ
 8t9TaGoKPP7FTXiCypiuARpFcDQVqDi0CEeOZb0BIAYXXRV0NJyaZhMkctiOrWDZj0Og6o778aYq
 3gJ0KuzhagNHSEEPysD5rgsWFhnIIPX02HdPXdovrdST1Ykw18Vh6PBgdEMSw3Na5BWYj1RqiPhG
 vVPHLPE5Fw10ejt.Ep.ARnx9Q2xZLBAdIfirx02aC7vtaHsE9H93n5aeF8vmbwzg8R2slbvxLx8R
 GBMeqHAAz8on8T4z4WfcwI3UmqcCiqSlg2wlRcpPWTHoEBogK__Ejs4Jaz2zFI24MyCSQu4ZjsNd
 EtLiw_Fh3GLPrxKEP7VTmrfm1zD2P9LdFBBnnXJulNHS87kEUh7dS0iM5zkE7H8YuEkFBk8xnJ45
 xQdr_vvhqPPsiSPjY.bpSxxOMAbtSFV65hyBwig8N4iMIhfSknZzxLvsyOArbfCEN7P3LBpsMj0T
 O2CgZRa5sOAIM1QA.LRKBUligsrShfT6v.coWKZ4goSXtFvqa_zbvLr3QHehmlCMrMUHTUvt2BHz
 pmeMJQ_G50wppoWIydzBLNIuA.mEImjRTUJ5qPu8kk09MyknJjxXjt6WGa30Cc_8mb2ZYii_eOqP
 iOfzxv6WJPHkp4sqKAGlLpscsMnXrlHGWUTeBUMhv3..3aYF0Z0HR6e6fKfY6wQ0SMai3qolN7S6
 Am2rA1HJ4xnvAPWgVNmK8oBUGlbw0MIvCirURz_oq9zEOiex40.ij4HT3012ZL4k9zxpIb1HE.Wd
 Cp_FKBfKH6rN74kf7PN2M1553oM.7lcijeSjQ66xXX9psZ2DrkhhllUrqWoiH3hiHN9pQTIDjsWy
 AqdbNIUspCjdcwNF3YfWlae9rsQWNbxf_Th85Dd8eAUswKXaSB.H2F51rdbNGfNscIn0iTZtCbvg
 hRO4AkfwwQLBKmlhZGSPCqsxHNj1T4ZyVWhHwrKSzwkR_lLSNYnY9_ujcVdsjJk_X5FQ8e6pTrhD
 Vc._4Ii9CUSzHdLK8NtH8eu_PAxESRudT5e1gA.YcpwKVLAA7cIO9El343l0fnG0Cqw0sLJhz_P4
 g8u_htAyXrqFZ7PlxExX6JHJd8RLjjw64wXKLrj0rDV_ciWHP1sbgx4ekuA2U04RbQuyihtyD1YI
 K0ToxR1aCoESlpnbH5fwzxSGfrUo3hs0AS.EZ8cHKuzB0JOYnuwU3GLEnHhQQt5uGXrXlp5o9VrY
 UUFhI217wWbtBaU4ZrgWKsEltcdcVKCh0o9hfmO._opBOF4aBEDWzDAUPTqlQs_K_my3DQL6gBDD
 puA00hv1V4hJXNCqSKN5PX_W2qoGwYwWljbJ6i9v3TsDL444v20pq46_dCJEJVBwUV579XIwSX2g
 PeGaabb22
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Fri, 10 Jun 2022 23:57:41 +0000
Received: by hermes--canary-production-ir2-6c7595c778-tbh7g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3e776e23ce8b870e9d67beb9592e399d;
          Fri, 10 Jun 2022 23:57:39 +0000 (UTC)
Message-ID: <6ac31983-698c-5333-da4b-4f562c47afc7@rocketmail.com>
Date:   Sat, 11 Jun 2022 01:57:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 7/7] iio: magnetometer: yas530: Add YAS537 variant
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1654727058.git.jahau@rocketmail.com>
 <a914ca0ea6f0149cd2941d60ae6fa2f49927f66a.1654727058.git.jahau@rocketmail.com>
 <CAHp75Vdg2i8NjrFn5gtKBKNbYrWd49nq31Exy=4K2RsxHeQ1hw@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75Vdg2i8NjrFn5gtKBKNbYrWd49nq31Exy=4K2RsxHeQ1hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 10.06.22 16:31, Andy Shevchenko wrote:
> I understand that Linus knows well this code and may review this, but
> can you please split register renaming (at least, maybe something else
> can be split as well as preparatory change) to the separate patch?

That makes sense, I'll move the renaming into a separate patch.

>> +                               regmap_read(yas5xx->map, i, &val);
>> +                               dev_dbg(yas5xx->dev, "register 0x%02x: %u\n",
>> +                                       i, val);
> 
> Please, drop all these value reads/writes debug messages, they are
> quite expensive (by resource consuming), noisy (may spam logs), and
> most important duplicative. regmap API has tracepoints, use them!
> 
> Perhaps it would require an additional patch to clean this up, if
> anything like this is present in the current code base..

Ok, I'll remove those direct regmap reads in yas537_dump_calibration().

However, I'd like to keep the others. The calibration data is dumped
before [1] and after [2] being processed by the driver. This is helpful
to check if it was processed correctly. Dumping the data is done only
once at probing.

In yas537_dump_calibration(), I'd also like to keep dumping the
"hard_offsets". Currently there is no linearization formula known for
YAS537. Providing the "hard_offsets" may help to find a way.

[1]
https://github.com/torvalds/linux/blob/v5.18/drivers/iio/magnetometer/yamaha-yas530.c#L592
[2]
https://github.com/torvalds/linux/blob/v5.18/drivers/iio/magnetometer/yamaha-yas530.c#L678-L699

Kind regards,
Jakob
