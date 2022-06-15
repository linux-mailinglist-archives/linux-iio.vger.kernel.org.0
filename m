Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E144154D387
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 23:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347704AbiFOVSo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350178AbiFOVS2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 17:18:28 -0400
Received: from sonic304-23.consmr.mail.ir2.yahoo.com (sonic304-23.consmr.mail.ir2.yahoo.com [77.238.179.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675D55488
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 14:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655327903; bh=Vz6XXiUXdcp/jIjxKajxp5nujVdhf8a8XJiBDxiAcuU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=YMm9s0Hj7/QpRu/dEu1vs8TTm67uaMaDpjT8RtmQqQknhtouI4HEYrK3sreFxXeuYeOQD8FLRisp+Q0r5TLcfE0SCoKH0pGajfvWKGJiCBMCjvt65dvTYItX5EL1Xxd1g5rXugIuEYQ18HvntOitJkDQn02ZYeLWI/9gN9yNlX44WKMGodLmq2YsvPtlUCXH18sLmpLJ65eF7K2Bsm1WTxBxPpjiN8/Um3KCfccJ5Z6bYwJfk1VYPnpoLylFzmNgrvraQB9fbk0YWS0ALKbvQbnWDnf49AKgGr5om32Q/jaiEoGK8dPt+kqKIfbBqFWe6wTIS9AQ7z9tcFRRHuu9qQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655327903; bh=XXhutocdrgeNxLqeYJ05AL3AvQ/CPsNO5MbED+q4IBP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=awBxepbidVi+MQJf5wH4F0saZkSRnUTXYXM2GO7Ar1lH3CbyTCLBF/L/Q+/Z+WlWBamzYLv4QMfvWBs4Xr2JgibqsODXRVwSt8e8tRv3cAa8oK3aiLyuuLh8TKwacaYwFarLLMDRn2ldCACGsh6omE7NlJp8IrotKzVHRHa6jy447AUyG1RHexC9hxoglVWxsKQ6+dovIjP15UxixERGSNL4hlPSmIEgy9q0J/grXctoadEcjxUEEK3cc9HHJYLOK5S+FldeGCKbvH2t1ZgWavGviHxcZdGeECDEwz4KNHBKXVYRWy67yvBk5sgzorlZXFbkIiqoP/J1rvxBFU8MlA==
X-YMail-OSG: PONnOuoVM1mPIcBPjJC7gvQpamSicOQ9CBIHckMBDU7qqtpaSLeRzEQoIAhiRUo
 ..dgDBPeOWKR8LBQuuEdBpu5mGFvwaou5T21EB4AWvQ5NCSl7BQYnGk6n3TOZ59qFPD.0CIDie_9
 M.FOmmUuQfjzAVPVtMqPkndNuNlBnjEyXGZp8RglQcheLDFXsfBIomARO2RKuJdF5BpR3RB._aTj
 g94tcL9nMMUZcyiPr3RE8idvuP9ZhjUpGYnxOWax44FhAGNXim._Zm3thSeFFBBMVbQrRYH2g1OY
 1.y20Sci.UfAbrIwCBjugJhB4y0q3fLn5AlxQfAxdDwHLxPHq1LFiypdIkOZeAhn1UXICwwo1T7L
 OpuAsYk2rV4FQmgab6r6zFrNp7ef0FMqxj7q5_6zWYkSsuuc91NtlSoG_3O5G4B2qPk5Z5e_Yauj
 6z_Q0K3QDiz_zj8wM90LonhIrNBiXiDV0mG2O9y9ouid1Cw3crqXUTc9iwEXhkPBfHP6mKTVIRK9
 mrfCbzVvwtgXlM.CVGO8Y4tAGmkeQE7UvuGJS3YJyYamFSKKpWvadz3.qmU93rF.1uacKeq04tIL
 DMzBaGZMj5FHfHvVswFLUpVappKD4sToMBZkGjJsJaVzwHH6TSEOUz50Lp7vPZQ2e1gxIiePb_2c
 vPs.zsOrqYd_BMIUhTb8GXMUHaxza6Mn5RZkAKF_5lyQu_5ku.nOI1K2iT5Zbm_QJs4bAwpNlQvH
 i8JQd9gxXbkF8v2p03YBS47EvvEzxjoy7lsgfEFmKxILyf.ukSCIueIcMNciDNyXLu852L1AQ7T1
 nv85FA2lgKGIhUv5oUS4A7jjxfKJpm0s6nqZ1epqof0Ln7RpBXREawaSzSYqIyW5ydTj3mZHDj5_
 0Qq9ydBX5jn6lqAECPWh_yHNOE8.IXMIc6u.hcB9RrAz3096pS1zuJ2ti8imV3v2pSmi7hrLiSkK
 s1acuaDD6AtJsQHHNihXlKxCvE.6ybotzagqfQKNNfo551u2dVtFxDGzggkUUgAAAnYms_U0zVho
 lV_4Cj7e007X9PEoxBAb429apb7QmMtSWoiSu1fcn1.GbiyqptoIwNhlcZpg8orhMrMRnDIovD9k
 CwH57qcnYdE1ZLJ4HmnwG10itflPptlxsuFpTziJ5vVdQUam0S00bbgQVrchnaLZiSC1sQ1I.e.A
 CnG8PdH_CXOd0JKBhcFEoo1seoaojyM4zfUEXmbXEYBJr1BAXGSwV154PIlYI2FS49LKdF81ReDm
 XslhIaOGzqmoGuF_NGad.9l3dx8eRJjZdB90XjRsxsudEzNkhT3pvRDMem_.t46vTIx68Oj06rQE
 AnRkiKD8KTKc6hRObSYf0_qV.PtTYfSOv.m6hR.ho.aBfpMsN5Z9LV89JNag8fbPgRz5KCVPurPh
 DgOKI8SCfHThJdtpatX.eJcmPw.a3z6ZHlkcrwQOCCMR1wLxNiPRZ2t7ud2MQEeli6FTNobNmWFY
 c5QAE3pn8W5sfciAoWxG.RmHjUVNW5_MmG7EHsgnL3fMAhAW3SidL6coZYiLOHDJHW3Cu5SmFikE
 cWfI9i10Ea0.alH5SKHb_PCAlsJJ5fh9LDBrcu463b0uyyRyoUfWXx2s3eoF0n2wdjEqJ4fTLiwH
 RQoXsUhRp7TafU6P7J32.VjX.um2ltKn9XluZ.KY9w73T365jBdhrC1oYtSu2MCG8WxplwYJX.v0
 vDYKLbod__2yAH_mThsR16.0tGPs_ywVckc1_vsyhT5Q1TmuQq3A5OUKFHRqHwAJsaeU4TweU8He
 esSa7DN2INjLOyv1ViSyp_JsC0I_wpBN33SF08CACrdmi9KUyw4kVVOFgmJNXn8OXTJHDy7wIJM2
 T2IvjDEst7BhQ9P838xC9_3pmRt9c7ZXoVGXYYQrw.jThhFV6qMLn1kFcKRCV79B4W2Ex9OqEBta
 KyyCOHetnzMGjZ1goFKOpngqC7WJR0maw_4LQMfXxMFwdHY6d.b_kFA--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Wed, 15 Jun 2022 21:18:23 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-fw6gn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3b38cc106c8e08bed1278d107e18ba58;
          Wed, 15 Jun 2022 21:18:19 +0000 (UTC)
Message-ID: <3026b257-ff81-bd87-4308-f30781eb8da0@rocketmail.com>
Date:   Wed, 15 Jun 2022 23:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/7] iio: magnetometer: yas530: Correct temperature
 handling
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655081082.git.jahau@rocketmail.com>
 <2e4622b2c98eda75c262d460533162f74cfb8605.1655081082.git.jahau@rocketmail.com>
 <CAHp75VeHJnuSe+2r8LvN4watFt1q5FZefUvsZokz0SA1NZ6nmw@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VeHJnuSe+2r8LvN4watFt1q5FZefUvsZokz0SA1NZ6nmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 13.06.22 17:01, Andy Shevchenko wrote:
>
> Please add default cases into switches.

Oh, I forgot these. I'll add them.

Kind regards,
Jakob
