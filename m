Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5195528A1
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 02:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243026AbiFUAgr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 20:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiFUAgq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 20:36:46 -0400
Received: from sonic304-23.consmr.mail.ir2.yahoo.com (sonic304-23.consmr.mail.ir2.yahoo.com [77.238.179.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C15418397
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 17:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655771803; bh=ObwGVCptuhG5JaeLLM0dzWY7CyvD4kHX1uD7M54t4Yc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=krkVfFpGYIq1CArZ3p9LlUgqMgANzNoguMuciVs6R3OrqO/qAqChTzH71NYRiNKNVHdr6Dbiy/QEc2biyOIvJa2ymCfqzOYx6mDKDY3t3ilNlQ7hcRAHARDJV1x3/WKUbc4eODUYhbLIsyAbBLwmJ20pNMr6xIiMfqKIJoGma1MsLbFy2cpfdHkHC1JESaE63jYeHw34rFFiJBg2zHPz6C1kM+kMnIjH5iH0u6dY/S2PUY3RGJjM9ibg4P3Il9LjfZ5LdzhGV38E0V33tbFqx0n+GimOODgCPVGq3tUvXRoxtD6r2kZyZFVknJQblGVMD9P1lv0yIcNzWP1B8Wib7w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655771803; bh=s5wrvN52P3XFOAq3iv4txZJb4SAOctILItmrj2zSzz5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hhns34TI1QY8W02PvGnAg4mmpUxT1DA0VvfuM9Uq4J5fseIlo2RCsxjmueDt77KyvzxBDWGgPo1yI79oVUz3+50c20/px0JDZsHRkrdRF0x0c9EWXZNeNRpRxMOk8eqS5yutr1p5+dQRESnZAlX0mebVVUcQqwY0mH2ojvwxJYmHZwhsQRMvX4vrI1Cg8OHvqJokHjYO21awWXDJgJ/qCiud3QRQ6smNUSqmssIrijdtMxGtiGTLUtnG3jV99HUbhsrt8Zuf/onqPGa2wWDrO+boHSLYXh9kWZIrfI8zeJMK2LUJKyHtQo/fG4kHe2URVo8LCAYz4pN+ew99CKyQvg==
X-YMail-OSG: Ps7BfVcVM1mEOE5WD1.N_82dQ2KpFXaNcx4yLmyqtbu0iIj05snznDV3ALRdjtO
 JY2u4C0nEVF.GI0MbArSG3Htzgn2mBRm6RaXaVxrS6g20oAGB9OSOqW9HS6I_Lr3S2gKdNYTZGnw
 AJICfAwxUG6vwdRoZAvevNnr9zo_NwRlIFv3_r0mpLetr0dFTDKjzftgcbk4wJpN1Z8wl3HatBzm
 iXKmyrYJw5sxbfErH9HKIktMjwRphg10KKTrA.oqJQyucWtTVtEs38LBGI9sIRbcX2ySqp.mvrFV
 9MYdj1DzXHzlAzE2dKTSx59.8VRNspQp4uaJhzJYDPpBDBzrAw5P7rWY7MjwOMj5G6yUFQsc7dDe
 eEjzCs7N7hQvxansLpNj8YH_cCK2U9EozaxjnWQNSt9R0GD4KbUdtMdobrZtbth50bxC.6UtBHpu
 rGLg7sYvJ3YLRPR.FGwwSxn1tvgBuzkeL7XSoffB44ZNXclis3U91oYBkXUrGiwgz7ZDRk.gpLko
 4HRGjnkKTwS.btzXj_0N2OE2infertecxaiebNIQrgvPmCWoH_Uc11_ykoCX2nf0NpPkwEk3aZnJ
 2nJTa5XuNZrYnosuIANgFO1qwuSUyOMq3PFFrtc.nHnZfIsC7OQX03N7Nk2vLsa04hFEJ6mUjWQ7
 OfXJo6fNDFaDd8mbd8iJzyToFqk0H9i0CsxZJQJKoTL9p4Mj6e3LU3cO1TtWo_oC_23Zz499WFaK
 a8jCkUILSjAQFAMuBYA5ZlAH4NnU101gFsbU3VZ8SJzESN.QitEh2HZNSPT_lCS38_cyvoTedezZ
 4CiDNpcAoJxc4zSx9JCG2o5KPv7ZqOUpR9.juoB9ZmuzHKUpUOkVjraYkRRtVS6ymDbfEeush90i
 s90xhGH5ymvJHBLO8DKzLrBQdizyuz0lbtUpjv3nsLluP2b878IyGW.l7v1RNqZw5A0Ffb_YX7CL
 Wk60GIPEoQ.eriuBrvAhT_4zBcu8L7w41boTXTaeLELU.6ge2YgE1IdBJK62kf6t0iI_RYzz_QIR
 sKACh2sIC8culXsOvIfsfHKOp3r7mAR96WDUKx81gEE0WiDfF2kAZgTnIE.b75Q2xuC_olw0tMtN
 jHOXUkQV.2NNcGiC3mV8JhY6nZkgg.8azneglE6bO4_iBnCxLK.5dR.LXhTd0OVVdvks6AxvndVo
 8PiLH3R9yH.c8dn8uOb6MPE4B0khRvn3gN4eaMp43nWtPt8AvU2_BHPVnvi2dlS611V_dQdfjHlk
 QN76ny.MPZNM2.BzmMQGvS6TKTHsvaEApFhrxPwE7l11vbnQRbmMCbldgRknUyxq34wDlpyyW8w9
 yUmUU35x8cIDFhgE5bN4.ocNIQUDbsGzJjGbpFkXTXNn9psSiGZYhneikYucsV.eMEt6c5yICPY.
 N4usKasFeJtDj4walXtPX9ZyrqBtSqbFNpiMassoFehdZE3SRSdyQnpK5PYcXSg_UsjDsGSg4qZG
 8GUVICyQdF6at9Rs4MKKv1R5JDjCAcubHo4Wmujl9J.QErtLr7EppBUUpLZWOOuKrb4cybSodImG
 nUFEPPAZN7y4xXsbqPEp2VyUlCkPFiJrlhUww.k5RiUHN9BPyp5AwuA1whwPsBeBfgQPmC98pokh
 gZkj4VHlKJAnIe2TCYzJ4izV6nqBflHOUtzLlPnWm6twbxgXGB6coDZnYxpe_vciPTVaokSM2X2e
 156hXPNzWhdhPSQsR61.VW498TlV_zgvGk1y0oySmkDWoyX0TpDCJwyurO85eFYjwPbeQxbp5WKM
 3E7hPxEm7W_ukXUC_F22xIpfBDWkBro2iAOpPfe8yQ6bbGzltYX7BYf2APNcn3_zRqkhx06c.dB0
 6_PHjSGys8iveduDZ3sl0WPQqzTA0HDrj1egbpvOTBJxrZWqrSyiWkB_X_mgrzTZZd3C.R6Dvpsp
 TSx2dKUiVvAbU_P6B2uG5idqT2xqNwcpeIxyMQJm7HrePlktwNA4Ghu.X.dtVdXad3F0mv1g4g_a
 .kDp8HDXr.Y9r4I_0Sd9Iv8.a4smteO2pX6EKpyYpqIabQGOiC6Qb_cKFN5var3qd2s12RIFrFqX
 IcZ.hEMk3UIcCtFBnQcuB6Oley_BkYh6dE3H1qukyzVAZVsfTJxslp4zd9gjn.DQlrveSowMh_DU
 85hWJIaTvCb0gqyjpKQHkw8RB6y5F1I65rrHINJFK23RSMNgsS_b9dW1eOh10Mptc7oR2F55jmZu
 ppdFO5T_nYudDdfvJAG_NkPSFdEU9CXic1uzYrfc6zlnpx4UeB_CJnWQB4RgIONa8m3kEGkXHp7M
 V7Q--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Tue, 21 Jun 2022 00:36:43 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-bp5rh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID be704d10c683b207e37803df7d34a3fd;
          Tue, 21 Jun 2022 00:36:39 +0000 (UTC)
Message-ID: <47098d5d-c70f-a844-376c-03eadd1f691c@rocketmail.com>
Date:   Tue, 21 Jun 2022 02:36:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/8] iio: magnetometer: yas530: Change data type of
 hard_offsets to signed
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655509425.git.jahau@rocketmail.com>
 <dd6fe7f67e2f8c917aabd6eb0e0deccc660b48c2.1655509425.git.jahau@rocketmail.com>
 <20220618151800.0616c21f@jic23-huawei>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20220618151800.0616c21f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
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

Hi Jonathan,

On 18.06.22 16:18, Jonathan Cameron wrote:
>
> On Sat, 18 Jun 2022 02:13:09 +0200
> Jakob Hauser <jahau@rocketmail.com> wrote:
> 
>> The "hard_offsets" are currently unsigned u8 but they should be signed as they
>> can get negative. They are signed in function yas5xx_meaure_offsets() and in the
>> Yamaha drivers [1][2].
>>
>> [1] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas.h#L156
>> [2] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L91
>>
>> Fixes: de8860b1ed47 ("iio: magnetometer: Add driver for Yamaha YAS530")
>> Cc: Linus Walleij <linus.walleij@linaro.org>
> 
> Trivial but it's nice to clean out CC if you also have a tag from the person.
> All the automation will generally send emails to anyone who has given a tag
> so the CC doesn't add anything at this point
> 
> I try to drop cases of this when applying patches, but if it's done by
> the submitter it makes my life a little easier!

I didn't know, thanks for explaining. I'll remove the redundant Cc's.

Kind regards,
Jakob

...
