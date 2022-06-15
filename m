Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2187154D417
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jun 2022 00:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349889AbiFOWAV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 18:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347212AbiFOWAU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 18:00:20 -0400
Received: from sonic305-21.consmr.mail.ir2.yahoo.com (sonic305-21.consmr.mail.ir2.yahoo.com [77.238.177.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E96853C76
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 15:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655330417; bh=9BHO/vEJQwspdOBU725pBTSFGjwJmz7DBY+o68qDYnU=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=fwTA4VWZOWS7WJusp9uR51uXBmIEuZPjz6fbbPmIuUt/3DJroY9DPCtR2rz1tusyhohtOH9XgW3Gvso5Z/EPuOco03gouahcXkODZQN9sAqnp1H6GybVoJ78GdIyrAEBhjd8CV7GL/FpykKX8jYPyydz7QFTHVA5/5LpjIxIK/uQ6D/qZAdeSeHi6H+CP1Q8mdl6H+OJJGQZYiQLjAKtYoTCu0JeEuTYsJkkTxWbHssUxawPE0iWeuHfdqyHpcL9gMPxHGI9adI9FOK8lHDw3BW4+ks6EZINSG1/5ZOfAYru+6ccfc0ZM0A7Hcq6KxS24ikoDbDeCa505lODWFjeqw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655330417; bh=yA3neS3B9Xf3zw+ZQbxMSUUSwgGz33cOJojjHXjv/cW=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=EHYzxAlzPFhzdFYIDyD5tBD4uIPrMlqlNS8c3UvyhLlGV1wOvh3kpVri/qjWPXQkL/iXBs/70HTADiUXzo5/1X3uHUuU7KRF2Daui5Iz0/Noa/gGJL4PpMC4nqS96HL5TAmWdqgVi5BpwDeF+sBz8Psxj9kTmv5WKoVG75LZZLNQS0XXAvBPRLh7Qn8MdMDo/ny9u091D0lC4mQ8kJ+LCW9xYWoAIdXQLiVv7/5CU4T4swYuwWt6FHNjlqu+8Tp8z4aKcG8SyKVz5ZxcnSdJOAWsmNUBpKYUg6b+7QeYkaGEemalskm0dNFAH4nhryNlw+ISxnh+JjzaYmT84Ku0fQ==
X-YMail-OSG: 4KuY4F0VM1nP5AyFwdexSy9aW.eJen6AHj3jkqFOChcZnUPhDPpxi_1hRxC3kEz
 sQcdAx4nK60HjW66yDnsvAahkvO97kq93kTR2Jo1x9xmOv.QKaaWWOVWf_x9Xn1W22VmTju1Asti
 aLkOB0ecM14GIm.zO5bFxjMCTzdkcNd38xBkqcChCnR6_B0_kZjJN0mzcnJt2rlDQiuM92pOWGGO
 bbnpxqLFi2sY0eRYEPotogQ87PLvelt2CaRXvwgyS3Ii99hUFo.3beLxIGb2RGP4.k3nRO4zQPWZ
 jqEtT3iC4VwfzxQYFvBE1TFtqheloDJwK_sGj_Iz5agrl.73lJyegPkralSRt1RtHLMfIcCrerXd
 9BB63f4u9VlJPythMWbzuZap_jJh8RIn_xQDvwW.TF1ngTh6WyqS4qT2HPePpOVwQMi8u7ZNpLTh
 MbldGBomLq4VrB9H6BYZung00KxVcE9zby4r.bffteKiLVR2eC.duKzey3Fm48QYVHhiQH9XpmM4
 iHMC0ZeAjDxjuWbLNCQ2Exldk16JRRPb5F7vUinx6dNU_misx60XL8qJVNN27a9gyc1J1QcyPZjA
 y180NVIf_aNciCV6u7tRd5GasJV_API6TqZMkVBUQxAQFf.vA9D5Db8lNex86L9VeU9vUhBSHZkL
 SjJwRgV5tVlRhulscOCk1dU3ufNi25dvzht3UHEomrmW15VoZbqxk2ncofhtuDDKIvepGScEKcnu
 _qkRfz7E7yvo9aSlygnh14otD2Zr9m.EgWRPMYsZObcxIMF_4x1svgKt1T0zAnyw_p0ayAE6pE6.
 s4UgcTYMDEDwKmY72kFbyqdPKDnq_Ff1RWuVHxDc3mCtdFUcTVxyGeGPuRV9eELSJVOWN6YWyyNN
 ST2aCDENM4y4MM0AVcxIUQD3RfXN4hkzamXosiozFdxn9zuR0Y_HRojuwKUe.wp8IsKuuxBYqYRQ
 989xzxrw1wO6hPvlQSF0ASfgIFG8K69bo5jc9mhJphUwYBm14TeFJDGh2wXr1J4us0MznPR6UQp2
 B7OwACqHEjxurxvNQ9ZSTrMow5bKT1jlPb6DuzVJfKxybZ58HXKsnToxeDm3UVf6YZTkalMIqlHD
 x_tmQFmGkhp_7jmGV7.PfrPuR6IQZILbaLa2yfbc3cwi5dgQ5o8xfC7m5G4arPK5a5nyKT2z6F42
 hvhigoVy5yZB5u8FkVfZ8H5IBAfcwRl.XeQWKNOiStzC5j1IHpSR3vl26w_sfmQOHeosFkDuS_Lz
 25AE4tncnp_PdKq.g_7sqD4CLRH1uiRfI65PBMd8MJEQsQtm.PkD80ElT2BvQW6YmsRPFm48MOst
 L_SVKSxQJ8wgWx6axy6n32HZLVrv8E1AdfhNRV_j0u8fTLrQ87oiek0TxQv90pSrWZKxd0uY3o9K
 YlhZaekqDb6Y6SAMeght6dT5Sb02GOKWJXr5GgKywB7gsDu3174B6NYEpB0Vi5GBGj5Spovox.GU
 fdEhOvFkDWc3NlGZnuAzmuZE5w09Yd_0wQFy3mq9rbQSPi9fWnOA90EFQeT4IE2G7DzHkcVVn1N9
 aw1dkrKS_iQ0RQuBMip0oYMg7Y7DApLQ52vyPkAp12RqwoD5HO3TAk0rDj_2hs72p6I.4LZh0UPj
 o7r_13NPnAB3HMuBxhZfeZZ5hC0BarVox1yZ7rTNyET2HhaQe2t5oTf.I6imFTvrhtzrUUry89l3
 BYE90sDuXT3aPU7rzSMETdxvAxQ80X71Z4m.gyB30ytd57klcv.Yplwm_JZw9VaNZIYQ6VunmGfg
 OJc6ZSEi1DjKV7eYl1dxK6j8m1xrwnrfGMkzAJV49DXbtxH1JWdEOtVY1aPfLus3IQKf8.fZJw3B
 602LSOLYmXn3g87FBWxwrIbNMV8Lx7H7C2AIsBziB_RIaxlrCJjjuiviMwSlbh66aiLTwgAlcxkk
 yRW.o3we4avup2_fXj.tohOFo7sdksLOhEWOmMkQ4pxwbtGryQW6ik9o_rBHLIzHhrKW2yrs5ODS
 L6YPamQuhU7OrvEANOaIcdKMggo9WJ5NLgQMaeAg3ht7EUwLFOVjeWzekay.kkkDspSD2f7Y9Tx6
 bTN0PADZ_WjK598ZJiC9A1B1ToI6d4TlkwJgxCoUp.MeHF1em1.xQ.gIG3Ch09bEnUKvUAI9AU4j
 UsVK9PMwofKptyS0vpy518ze8ybwC7xTwLJZl_lA6exxx8q_EzR83EQcS4J8wQGJTO5bC8Nvk.PX
 8A81_VoaSqGO.jjOBba22P7i3uhWYsr1vikazl6hW_1SU4FjvnGsasYN27IZu4WHOvBiqbL_je4i
 hyRQ4694-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Wed, 15 Jun 2022 22:00:17 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-74fwm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8ace1dad76e9ec93841826844d70561c;
          Wed, 15 Jun 2022 22:00:16 +0000 (UTC)
Message-ID: <5361e0d1-1a2f-e185-e5f4-b4c8e90d6215@rocketmail.com>
Date:   Thu, 16 Jun 2022 00:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 7/7] iio: magnetometer: yas530: Add YAS537 variant
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655081082.git.jahau@rocketmail.com>
 <b6e100de37921c22ebf0698f8e0e99794053303a.1655081082.git.jahau@rocketmail.com>
 <CAHp75VfFwSQ6bk=TMLiyA1j-AsafjGdVFbTTHJJ67C8zeYfz8Q@mail.gmail.com>
 <033f64ea-4ba7-eb89-3259-688008e29989@rocketmail.com>
In-Reply-To: <033f64ea-4ba7-eb89-3259-688008e29989@rocketmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 15.06.22 23:43, Jakob Hauser wrote:
> 
> On 13.06.22 17:20, Andy Shevchenko wrote:
>>
>> On Mon, Jun 13, 2022 at 3:18 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>>>
>>> - * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5, Xiaomi)
>>> + * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5, Galaxy S7)
>>
>> Not sure what happened to Xiaomi. There is nothing in the commit
>> message about this change.
> 
> "Xiaomi" is too generic, specific devices should be listed here. E.g.
> Xiaomi Redmi 2 seems to have YAS537 but I'm fully sure this applies to
> all its variants [1]. Samsung Galaxy S7 (and S7 edge) is often quoted in
> conjunction with YAS537, so I took this.

I forgot a "not" here:

"[...] but I'm *not* fully sure this applies to all its variants [...]"
