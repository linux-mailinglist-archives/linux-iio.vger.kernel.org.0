Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E368585734
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jul 2022 01:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbiG2XLB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Jul 2022 19:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiG2XK7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2022 19:10:59 -0400
Received: from sonic314-19.consmr.mail.ir2.yahoo.com (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8904BDFC7
        for <linux-iio@vger.kernel.org>; Fri, 29 Jul 2022 16:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659136257; bh=j0y90HcGnvh7+Fiy7DXqAfH7+i9WBOWWjO3AdIO9Szs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bnUW6kdU3CLdbysRpdYm1Se4edFUwdJPTX7sp2iOixfLWUyNpidhlBQf/xFBsI5r+NyRDUxFi/MlFX9lvwETs0U1QmaWyYR82Y3aR8YgMuHjcuugxxqe2VgGQlYeZ3Q2Lzalc9wUDcUnTp/DKjUr68qdxfo1qFoD9pVFfMCM7zdSxfXfrnFFJ6/9ClXBqMVEAHgSXJgzgXWCZZp0blmcxs7/kgZ0RRjQRi1B20ZrbkhRe9l96w2d0mcIwka/7sk6Z8p9H7isshKNIxfIeafufLEHotzA2UzbnQOnLmFii4ONDFHr9HKneW3UOl1gcznzW6VPoM3NL77gbQOQKTBllA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659136257; bh=fFygH170iKSZU6LoFUCAyDOdnf0Amylyb3iefI9oeVc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=B49BPUaWq6v3b6bK0XObio8mWcab0UQhFOK1fWr4AXWa+wxpXFsGvmqgqL0uxwRNZqkur+6bT52Fn3V4eJNjCZ5l/a5/qwwnlFOXow4J1dRviolyuPPyjPW/jYO0kWSPlY3NBnGRN9Sc3s82V+kjG/ux85phXzvGMQ4Hx76MqxBpvHDN+zJjEvndhP0H3QcRFnjSLti5VFLwHtNJ8jDBEEe+Uvn8kmu9LJFffoMnJc7zxjN42IUwE4SsgMllTL67yCkBgOXCZO19297n4ziqDoyEwOzZU6WyZRM2F0STZ3JS6BES6AdyxOmPGTqeDqEa64RxTSx89S7E1mH+lyuOUA==
X-YMail-OSG: SElaZPMVM1mbduzjf_D6.z2DtvnBfc4egVF7BmO8bOrW1CChALi4XiwSsQ_Fwke
 745WkN0G.Jqq_.SK1J03saG6zT0jPLX.OX7WR6A5FbXLP0TWaFV5wWdYCHln7fqsbkn.WkP9vEou
 DejPFHnQIJybgxBGXJm8RxJWkqM_MgxNejb4nSLFG7UfCaYCgW3EqrKJSLs5307TJLktOnzlaw_Z
 mBC9JiUFJzgN8b8ROd0X1R7udTnGb3.A4LGD3D5dl4nzzOb0SqEdnAo4mPyonlDidtljbPm9RPyz
 t.zQzbkG5Unkfu_pQXC3iEi2dhSloQoXZcU21JDwiwrfnuf5ng03E.ZFNcLTtb1vDo0aaVkkPr_K
 .2zzDrAt9bMgn_0mx04E7iDZHknZxFSYyn1joSd5CtftrWS67k0IpTeXK7CXxLiQf1lz_BYaIjGC
 f9rz4h3daupx15espZ0W8Ia4_A6R79ullrQSfj9QKgWYQte2o5l7U0e5AyQXTnbBgKq2yws4hhWS
 MvlHJI.pT50tRh2Ood76lLZp8qptKzMmNknLNZz_oYt4xiEYNugeZXCWvMk8rCrYDA76Cf6hHwrG
 3dN3Di3QGXmkY9ztNhDqDC7jAOJRtwa9_CjEk4YTGf2YtOnYQ2wmyUf_1RYP3iY4HKRDm2sdISZ8
 hXnCr2cvaxoV0i5AjR7KFg0pnADPLjNNMVlKOENh4WmUlSrcFssujDXCS1EdhnOHogn56No55yWz
 9wo2AUbhh1_Ae4TMhbds8Gn.F.gt26XQU0O2AN3R4qS.sd0gqCzF2Y9T9oH3wkxlo_8PZB24vf1E
 mivL3mTGaWS29.gvSxLbZ_qi_dj8vprGbZiQjajwQrZfb51BP.AHg832BRhItGrMtRRDYwCV9skU
 K0zjw0hTEQOO_fA1EzLzximMKM5mcsg5jXq_wQ2_rQefTjpcysF_sT00U3cuaFXRGQUxwKxQGPFh
 EjL0Pm8GAZ8ba6O.e1T9uEZyInC35juhnb05mSCMLBD1DhGhQVpUdlS5hzPRK_GCpzLc82EFtxEV
 wqEpO_3Krpl.srgPrm7vzygRCg2XPCzJh8LdLYGROKtgkfptfD74iMo7b15n9rRyzbTgVKthaCEt
 p4x_nTWMtBtghrys.Jv_OAQL2K.IHPhjuskowFvqyOaC2xCIDdwSYJtXNzkxSZIsV8kpas0tAvmJ
 ys3eX38ahnJODW7tlxgZ7IlESpVfpHL537DzERUQsMucAAGAqQRg8JH1_5ipyvTYxqySsapqVMo6
 uWAc2aLgMjRJ1zlKl6JtdsHhWuPNFzqc41YXGLRjswfDOPdK1bI8pYTt1yiIgkKgOydcdbUVVnSZ
 _9Kl_3uQlI47pKgHHYBBHOKgYJjy00l2Owog3zCgOUWEuzyvI7DVcqPJBs6vN7lrRy36.0T4Tb5_
 sfoKJLixkPOjUXgU_1kj3oJAKI9Aca8ratb4RbyoUWrGuPqxc11Q94zNFLNVesr.8RMomyRohMcx
 9C1rbjrqXiQnsiGRwJh4fC8X1PRaq8NO25PFEvizD_bbtsJ8ZxUApl8qTipsriLLisloG1TjyJWd
 LQ4o246AjRzvwzYF9fKO2iCmk75v3nAFHTvEj3WNKkdGFKa0.nCutdC0JAl_nubPH8eb4pCLdh6m
 PBb_ZoafTHXtkLLgn72h5cb4UDQImDD1nnifD4izLw7uUK9FQ.1GWT9uHZ_Ys8aH5wuBxMfENkZw
 C1jbEtIldOtAxnTnBHZc40U6yEMCYwvMznH.2U5RaRzDJROKlhlG1rL.LiP8lLSQE56ebhi9vZuh
 pVHMh3boC5VlwzE9tmLkrogvBMvtlSh4n343.aH8QlaZ1h3yGxr43bmUjuGlbzaMxTcPj9YfIfc5
 mLc6vFTXzTeUhaIJWh7Oe1IJFuvsmF9nlNCwb8DEVgit9NuJN8HXY48rrpCIS4cOpqGBP4kutjBC
 jfQtW6PUp1aXAt_9sTOAWgtkLYkTpgbi9LljDxrskI3M0.9uftIEtpBou_k6EmCalM7uhxnN.e3T
 kphrfw1948PU.h4vNXB8Ucjl8bZ31yp7FU6s7OfF1ZmdWy1FIHrZFu0TG7Rpzvtqum3XREwuJaBG
 bqJmhoEgVs2x6GVokJSZpi3z0zFPHou9MSEAHT6Ygdo9zn1LOkWpfxqn03XOvOqVbV8W8B4i0IPm
 Xm00XVKY3AWa0J4XNrprZoj5p2bDZDIu1rTNq19e734vYQfBDypxvf2nl0G3wqnRgKy3aKxlwgNO
 XQAdw5pMSNtghbmaN3barSEGT6PJ0SraDGYVhRWLX0BEx9e6f3JreM8dBaqsvoWKNj_eyg9Xje4i
 tr_6lFw--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Fri, 29 Jul 2022 23:10:57 +0000
Received: by hermes--canary-production-ir2-d447c45b6-sqmx2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1f3ccc7804ef89f3edf9285c0ab5243c;
          Fri, 29 Jul 2022 23:10:55 +0000 (UTC)
Message-ID: <f8071532-14c5-c2a8-ca75-f4327066817b@rocketmail.com>
Date:   Sat, 30 Jul 2022 01:10:53 +0200
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
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VdLBowZ7=6g4aFVr5zkN5Pkv7ir68vPCdkRmoFysqRz9Q@mail.gmail.com>
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

On 29.07.22 19:24, Andy Shevchenko wrote:
> On Fri, Jul 29, 2022 at 1:13 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>> On 27.07.22 19:46, Andy Shevchenko wrote:
> 
> ..
> 
>> /*
>>  * Write registers according to Android driver, the exact meaning
>>  * is unknown
> 
> With a period at the end :-)
> 
>>  */
> 
>> This reminded me of another location where I first had a comment
>> "Writing SRST register, the exact meaning is unknown". There you
>> criticized the part "the exact meaning is unknown", so I changed it to
>> simply "Writing SRST register".
> 
> Yeah, but that is different, SRST seems like easy to deduce to "soft
> reset" (taking into account where it's programmed in the run flow).
> 
>> Accordingly, I would choose the following comment here:
>>
>> /* Writing ADCCAL and TRM registers */
> 
> Fine with me!

OK, I'll apply the comment "Writing ADCCAL and TRM registers".

> 
> ..
> 
>>> You seem to program the 16-bit register with a single value, I don't
>>> think it's a good idea to split a such. When it's a bulk write and
>>> value defined with __be16 / __le16 it makes much more clear what
>>> hardware is and what it expects.
>>
>> We don't know for sure whether it is a 16-bit register or an incomplete
>> register naming.
> 
> By the values you write into it seems to be a __be16 calibration
> register. The value to write is 0x3f8 which might ring a bell to you
> if you know what other values related to ADC.

Sigh, ok, I'll apply bulk write.

How to do it correctly? I guess:

        __be16 buf = cpu_to_be16(GENMASK(9, 3));
        ret = regmap_bulk_write(yas5xx->map, YAS537_ADCCAL, &buf, 2);
        if (ret)
                return ret;

The whole block would then look like:

        /* Writing ADCCAL and TRM registers */
        __be16 buf = cpu_to_be16(GENMASK(9, 3));
        ret = regmap_bulk_write(yas5xx->map, YAS537_ADCCAL, &buf, 2);
        if (ret)
                return ret;
        ret = regmap_write(yas5xx->map, YAS537_TRM, GENMASK(7, 0));
        if (ret)
                return ret;

...

> To the 4100 denominator:
> https://github.com/XPerience-AOSP-Lollipop/android_kernel_wingtech_msm8916/blob/xpe-11.1/drivers/input/misc/yas_mag_drv-yas537.c#L235,
> seems you can find a lot by browsing someone's code and perhaps a Git
> history.

I've seen that comment before but I don't understand its meaning.

>> Still I didn't get your comment. Is your intention to change the "50
>> milliseconds * 1000" to "50000 microseconds" in the define?
>>
>> It would look like ...
>>
>>         #define YAS537_DEFAULT_SENSOR_DELAY_US  50000
>>
>> ... though I would prefer to keep current define, as it is implemented
>> now and stated above:
>>
>>         #define YAS537_DEFAULT_SENSOR_DELAY_MS  50
> 
> No, just to show in the actual calculation that you convert MS to US
> using MILLI.

Sorry, I still don't get what you want me to do. What do you mean by
"using MILLI", can you elaborate?

Kind regards,
Jakob
