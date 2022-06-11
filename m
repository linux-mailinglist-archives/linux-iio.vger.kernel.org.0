Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9216354751C
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jun 2022 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiFKOAe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jun 2022 10:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiFKOAd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2022 10:00:33 -0400
Received: from sonic304-22.consmr.mail.ir2.yahoo.com (sonic304-22.consmr.mail.ir2.yahoo.com [77.238.179.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF6563FF
        for <linux-iio@vger.kernel.org>; Sat, 11 Jun 2022 07:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1654956029; bh=5CoiKmj63OxvlCRqUuQOL91dlAFr5KdehhlfjLxvEiM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PN4Bw1+Hx9dnY5U6x2gxioj8aZh4yKoCYmMTHAB4zDRkyUBP+84H94LWkJ/Kq8B2bHkO7mF9QTOVAJnWAhkkc5NJs3l2A/QFpzD0UJPITZz1lky4KAjAVVDTJ8E15SuDaLbhGGmmWkSoROOJJ5JCOEGZ4dQ77FmHbCjcLynMAPyDTp1mlYZ3a3hih1YOmY9Ri2iBCAUKKnhOT9CCUawIjdj5SJhvD4VLbUmNg2x4aP5hhpdcL7tI95nlGPMmliWbC8z1KZHxilo0BFZB743TLmfGkH3KuynqqA76OQeHwUfiVF1Avlw8ax9vI4akflGlNFJVgrXLCpf1EQsF7N8CTw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654956029; bh=6F5CbcfCB7Et/wbuAtEWUqokNys0DdFv3lEwA4isihi=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sBg1bCbjdBUt713asUam+yOAKyN+jIchlZm7983BhhLn+nN1M3eZypKL2CiDjgK+wwYeS7f0LX0FFoY8/bVCv4rZDxPZBeqQf8CO5yrCDTYqO40MuKAlYgNPiAC27izEQFrxtMFKhNflS+lF+oFPA4WSbcXFmfPY5dFeHjspfVvZJM6N8+EbbxxzILG318nw2e8F87Bipti1xUb4b4EYB+ilDb8MfC69GKJnbfo8TXopDmtICSmSwUgu5ocL5Ibo4NMPaEFlNEoLb4I55wUA+ygnHR38oU5vZN0DAvmVBEmaUletEKw7EMgKQy7RKCCdWRMLZ7LrhJgHPBzTyk8JJQ==
X-YMail-OSG: waHn4kgVM1lQcr.C8Tqdkc43RufqZ5rGcbWWGWjU7w5gz9ABrsanOyQWSZnnHPJ
 XiYUdo9rt5UjFZl458ueF730nfOSCwyX5N92HhoSi3Ji10eXYGO4PYDSgU2MUyEhUJYvxRs57N8t
 lcnTNpXFFT5jX8sQja_fjpLM2KNXCYKvO9P5BrCtvJL9_AtdI2MR_Dh390lYey7lGPcH6nkqK434
 7LXEFdVQx2fxehbuvK2_etnxSxNygLsTZnhYTKy9vX9bJOHHSnDQQBDeu2L_1W1zwmHMCNmy348f
 AO_MfE3iSriZTeODPJCwUpSSz533Ns3Hxv3lyyq6KgwrU7hImuTSybqaEGmvmZgaj0yonahBAYIn
 PW5UYWe4YQs8.1f3Una6whCSin0YRR9snzcsgwkPxbEtumFD1idL7Su7ZlyUhHCirs9eBUHs3AGI
 j0bGq4TFeV6mlkTUq.LPlPxmTlWWwbeEWmeeIAYmM0ycyICyvUzHhkKSYlb64DxPqEzmEz4D_1vN
 oNETYJ022XiKx.w8FVuVKgpAAhMd7WKbO0X2xHLEL42kgu61I4hhzPLUCEeKYA54nr2tKgsmxxbb
 YZKGKdsRaSrBOmN0S7tKvJ45HyqOguxG8K3J0zYbocNq8iy77K55h8AwlGBAZXbo1PtmeV4mk1iU
 ZXNHZNeBQtFp8KW4o_dyqCs2vJUQQvbSxdln0lDEE53fxGP3FZgMXN_cytijT83CgRvH0ei4xxZA
 7UoSKqXA3fyP_ep7NsTp4gdldY3ifRfYxr16gdN2czihIlcBpwibaKWjgkeJxh.hkayvZ5SSZ_F0
 7BxiTuQq0T6loCAfIMif_s804l6Uj6_Im_dNyuLKipY7cdYcBRghPgVxX6QDpq0YW2cBFLHOWL4S
 rOWf4KcZumti_82FhPvsjgBIWPZIxCg.R2irv317cDtUKcEbnahdWOW2y_vQfWdyFzsvz3QcbgkU
 Dm4X6YR46fZLYpi75PhRBsKKk2BJovyoZHqKmCrF_EjZiBY090yBvURjrwHL5yss0rTw_YMpmO6U
 4M7o9C39NfNeZ9bqtCgj8zj36Turn2YRDfudqCdIggvgr_bEx4Lmr3GEY.LA831zePmCqM5lrg3N
 nBUMYJZpzUH8IlKeDjLJvvEqZ4WiTxgZ6PZZMP0WCQvPEFlu3k5sjjFN2X_mjw62n5w1I2TzaJw8
 RLqvveF2iig4sO0O5hWYgHfXDAlZpa7qBVW7Ag8mfejGu8UcwPxnjTCVMj9oj1bcE7NG3cCNMNl6
 tdDkYutZhZgUZnYxzB57d.5BH1MtkqI2QP.n4eZWjamcdXNQ6yQZV9kSxYOyn_DMgpmVvu2ZxjgQ
 ztQ3899T1ZcUOHqslvEMfgTr_yuP_Dpeebch7ohsDVXBs2rptJK309iI66qQK2WQPdxBHScY8mom
 UtB1ArCelmi9mPraNH1yBEB23rKzDDFxTXmtTjIv.IM1dcHkb2otfFo.y30xow_XvZe1HMzvqIFj
 NgNluNIpx6BL1eIvzY9w7vfEL0MFS3sSY7bZdOBURMHHhooWy378wpHKIVm.vY8efNCXtvEcbL0x
 9Bm82YqdIhyYnbjdg_eHUIs0YO7vwwBBzVcW254JbU7vgSv7doxJMlgu_OEEEhhXEpZGTfkJUx5l
 8bNooPE5Cjivvosg0VweBNcE82q7yGE7NazQ8J.CSYDmu1DLx_TSq5.ttAFocwXRsYmNOfqvSs4d
 8PxQ95nzVkl_84IRrZlAZAGCNRHc2xVqwpKcgZv.7uxM1f0CDkfkC.cHnORGr167bhYylo8fUH.0
 QwuLvpQYA8.HhWB4MHSpEVYWrZUQ_Bg9c.a.XA6VOD4nsX4vQ_hS0yjRlUUAtMWhOYEj7XeJ.17u
 OJQvbZGoaN2sVyPGXZRqRLbendUDXfBE7E1_8VbNdNGJC5Qbajxz6oBG8fAJy7QPTU90n7LyMrE2
 GncjF10vVqAyX7tmnqmrf2kHcSfSc.IOqT2ISaTV4R0CmJq.tF5M_HWaaqcUjWL2W88paRwg.Inm
 HNzq7QrSm1X8ykIV8._OI.aacyVlt4HDyPVsHNf2EV3bST5IPc8TQSNrdUnxXuquOtNweyOF8OlH
 Ifq_c_PgzfxSllXjPD2GECp_YFZxky8YDd7Py4OytrKkhplwnPjssX7G9Traa2vohsX0Iz92cgZs
 bTfllUb.gvtJTYJ9h0BADi2zEh7Kep9qPnpvdB2RbQo9UtYZg2wEPXMrbvnmKkCM.Myoz9w1nt7S
 eFqEHJ2dPjdf0L2XyOyIMR49nl0EDZUUx6omnZ6DyTiRMTBSYmVIH76.t9vjaFST9pjsmV4fy8GH
 NDQ--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Sat, 11 Jun 2022 14:00:29 +0000
Received: by hermes--canary-production-ir2-6c7595c778-pmqqk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5eca18952f5c3421b9be658943847e07;
          Sat, 11 Jun 2022 14:00:25 +0000 (UTC)
Message-ID: <7265c507-b32d-c2e3-d9ca-876d9382a8e8@rocketmail.com>
Date:   Sat, 11 Jun 2022 16:00:24 +0200
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
 <6ac31983-698c-5333-da4b-4f562c47afc7@rocketmail.com>
 <CAHp75VeprMCdP_HqcVUhQow_OStKDMF4c2k5s1gs7RwOTzO=FQ@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VeprMCdP_HqcVUhQow_OStKDMF4c2k5s1gs7RwOTzO=FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

(Side note: There is something wrong with the Cc list in your e-mail,
the list of addresses isn't handled correctly.)

On 11.06.22 12:56, Andy Shevchenko wrote:
> On Sat, Jun 11, 2022 at 1:57 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>> Ok, I'll remove those direct regmap reads in yas537_dump_calibration().
> 
> I'm not sure I understand what you are going to drop. I was talking
> about debug messages, the regmap reads are fine. Or you are talking
> about them as they are tightened together and one makes no sense
> without the other?

Yes on your question. In the new function yas537_dump_calibration() I
added some regmap reads that are performed only because of debug
messages. I'll remove those regmap reads incl. the corresponding debug
messages. However, I'd like to keep the "other" debug messages.

I'll explain more detailed.

Generally speaking on YAS530/532:
At driver probe, calibration "raw" data is read from the calibration
register (currently YAS5XX_CAL). Within the driver, this data gets
processed into several calibration coefficients like e.g. c->a2. These
are later on applied on the measure data.

Calibration debug on YAS530/532:
After reading the calibration "raw" data from the register (for further
processing), we dump that "raw" data to debug. After having "calculated"
the calibration coefficients like c->a2 within the driver, we dump them
to debug too.

Generally speaking on YAS537 version 0:
There are two versions of YAS537. Version 0 reads calibration data from
the register (YAS537_CAL) and writes it directly back into some other
registers. The driver doesn't touch anything. This is done in new
function yas537_get_calibration_data() after "case YAS537_VERSION_0:".

Generally speaking on YAS537 version 1:
Version 1 of YAS537 is a mixture. Some of the data being read from the
calibration register (YAS537_CAL) is directly written back to some other
registers. But additionally, some calibration coefficients like c->a2
need to be "calculated". This happens in new function
yas537_get_calibration_data() after "case YAS537_VERSION_1:". The
calibration coefficients will be applied on the measure data later on.

Calibration debug on YAS537:
In the new function yas537_dump_calibration(), I implemented that
mixture also. Firstly, I added some regmap reads and debug dumps of the
registers where some of the calibration data was written into. Secondly,
for YAS537 version 1, I dumped the "calculated" calibration coefficients
like c->a2.

What I intend to change for patchset v2:
In the new function yas537_dump_calibration(), I'll remove the two "for
loops" (they contain the "unnecessary" regmap reads and debug dumps).
But I'd like to keep the debug dump of the "calculated" calibration
coefficients after the "for loops".

>> However, I'd like to keep the others. The calibration data is dumped
>> before [1] and after [2] being processed by the driver. This is helpful
>> to check if it was processed correctly. Dumping the data is done only
>> once at probing.
> 
> Then it should be probably dev_info() in such cases.

To my understanding, in this case it's rather debug. If at some point it
turns out that the driver doesn't work correctly, it allows a deeper
insight on the intermediate steps the driver is doing internally.

>> In yas537_dump_calibration(), I'd also like to keep dumping the
>> "hard_offsets". Currently there is no linearization formula known for
>> YAS537. Providing the "hard_offsets" may help to find a way.
> 
> I understand that, but per se this is not for production esp. taking
> into account that regmap has a tracepoint mechanism.

Well, ok, I'll drop the "hard_offsets" debug dump.

Kind regards,
Jakob
