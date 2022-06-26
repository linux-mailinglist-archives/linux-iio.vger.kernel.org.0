Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5A855B00C
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiFZHvV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 03:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiFZHvU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 03:51:20 -0400
Received: from sonic301-20.consmr.mail.ir2.yahoo.com (sonic301-20.consmr.mail.ir2.yahoo.com [77.238.176.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3081F120AF
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 00:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1656229877; bh=39cnnm2LcZpob9DUMBAQbw/FL7wmWN3SUwndjA+V+IM=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=aCOHGye8jea7IQosA6kJLtGHeXJ0nYmVYabloYgoyge4OeNF3i3yppRY2HYmdh/R9Kq5Ufl6zGGQQp7uhvHwlncFACKVU8MnHIbTuqd8cQvRWfBIDrwiUkYPGSXklJp8IUPT3nnIvoPV8J/eoelpoWyuGFfMBQ/+B/j1NdA9uZZJmP0V+Zb96/Q0FAwBdM3U9ldrGuPcU/NMgm9lcEAyiw8xjGzq/XfdMe5Sc7jLuFUfpOUYyc5ME7qvLGR197wj56BTGa6H5K8WdDRbD+yISNlNDNKX9zGzp1rnbLbI4pJhVfSbFb0sXt+W6QkN2xNawYmgtTaxi3WgZhwFIYh0jQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656229877; bh=Qezq+kiFonbVJBLljqyjQV8R26/WQGnH7Xqlfj1tTGH=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=hLF6gVA+MS+LfFYqRumOtsfX4SQOlaPmUiZX01JvrDziAg99lPte4QOkWZF2ZNj4bxV0XQfi42UOqlkNgxceiyTFh2Wq1hPLCtJ45GfWR+KdtHahvVRproP4auXcOm2XJvesG0fZblHYho30AWwa7vy8Dna6H1c6bg1U4IOn+msQ2AqbJv8yjsHVrCh08TVL70o9JXcvmkmBuKW3TpSdFh3kbKkSh35d/vpQdpUGB+y7fojopBYZENyVN3GFK13WOvJGaYz1dObrmnASOKezvVC8zaRlMmv3hnt59Ks2yau/Qzixbjy8n93iv1JzrwBHa67LLJPET5xVO03gshYmGQ==
X-YMail-OSG: qQ0smoAVM1mnPWGV7bUD98WUopSwrzNXadP2D1iGIuSf1TEGJhpE5LrbFTThXRZ
 i1hFhK0z.GmGB3JqK393rKDt2q5QZbqyoj9bH.sMJpZJsfw2ONXVwmaMULEDyzlXZSDgTsGXTYGE
 aeuPIIOCaPClOhV147udSUXdln05JFNBw1lpS3bHa0JxpGu58_WWuRFf07knohna74zaPAErmtpj
 L1mDMI0a.r5aG_06YnA.SdsKkEFVmRKGVToyT_6pbkcHV3vgporI.RaDIgb_YbF21qh7ruKgHVGJ
 E6.b1KWp1v8ouGZUibXHi6HXaImFLBqZzocebFQEvLEaRpLbqNHrr4T6Ps6Zg3H19XUYC9LvckkE
 MX9sRcuZmfgqlfsnXJ.39F7n1KT.iwsUjAeubyeh0HDLKeymXS.9Pf4LHikFEYm_TwgKPXvbY2ul
 egpu9OHEL5ZIY9JqeEBdarNkUBNuY55wG2V.u81dW60hagJh2JTRpMJqirhm8mMKbYDrl3vLHCj4
 E10PpelW5OYhyBDMjZSRQM_XztfnWxkFKJAcn7Q0hM3aR.Yfc5v02gx.y1gJDpXiuXzR9MjFgr9q
 O3uj6BYKIiv6itFcFKiJjwM_93xcPFkH4MtPxyV5fHKqQ97evGT6IRCUx.SXsYbA7yk3hKEi4PN_
 LayAn3syYrkrWGqcjQpcnyEotRwZGv9ep7FD6Hovt6QTBL6sYxXx30Ba6WptzkQrjErbnsTIrF1Y
 KzT3imbGUs901bP7f8_xiyzaqihfMH7PLhkncmtt78rlLhul9crCbpmZE6WpZnU023ok7YVeWUQt
 237O8Fwzh8y_WPeqADPbMLQrS6EShg9tJbKxyc7toV28GEpAsWH4zpxvZbLJkVckGpe2IbqD36U1
 uR8Med9mYKAtnkENeywd.11xrh6uHPG9Uh2X9lRQsf3CDS5B9utCv0rGL0oVSbKQpqR84KxduHqA
 Tkk20gCmQKhqiHSSv0FndhtM1NL5RyTdjNc3Mjvn6Y71gwBkj2BhaapZXdOvg2.f8eQbg0Yhihaa
 lDhc5D9kMZVTBC.wECIaN0o5q5jHtxW9QZOWJmEUG8pvlhpZadFLVEsMomgoDEIshuAaKkufUzYj
 29JzUGkb0ivx7Sc37ZWcHXjzM15YLi2MWs9hE7HtWPad21K8kx8D7ejLTJON0drhfAmhCXtRwRIC
 DCP374HsH6jzS6cpgj8kz2ygKnh483I9sJD4I.27oMSKF0h5gmDRjFJUsFaYUH6IYNwOf0B09hQB
 mLUji6ysFptXxzHx8zhrbRbzlkLfKY3vOfhr0rEEKedjFEVntPGmLnYcGssmJdomDnfaYbtrgvlk
 3WUkDZXVwNVdAmlNtDiSfh1KSh.rB_th3JDfbeuVnIR4RWPBxxE01_zS0MPJ8KO8hKZTzu1iotsD
 CM2CULG3ehLnlJuaWs7W0RLCtvAVSD0jYPs_sDpG4msv1x8oFBy0ZDflXJBotC65Z2nG5j2FmJcT
 8IXswusGqLMwwlfNn1CiwqT4.ns22Aiapg4hVxlBQSd9uzkg6t60zKoQ0CcgGsTRWt9d3sNoUdOH
 bVlqIgFnMQFUf4nY43f.PAb6L5Adztz1TNIiD_.6cuaOZWv7nqQ2ul1g5UZASUADtC0Fj_AiKCtz
 Uub.rj13k8xPf2A07UEIENUGCQBIFkeLrkJLOQlNr.UZpCnudr4ZC1j6jZt89f5LRpUicd8DsJP2
 Kn6CpcF5yv1CeKBlDe7vFJIkGFG.gUv202Apt0garmIYJfaS_gd8mKI79tiq.WrZw_PaWqf8whWK
 Ns4nsYmUqSYr0lur44fuw5ieFcnS9ZkiEYUnuGrugi_sDX9U7VDkU.eyKU13IgYIE5PmGZmt5lGU
 f2SiSFCHVpumXvIxlyny0jnLecMZJ.j4jxqhhtuWSn_ZpwcK1B7e6kV_Z7cp6hYzSp35yuWOnjdd
 ugvG.cEU1FMrcRMF1nR8xi8a.AQRmPva5VbinjoOEGIwVAGUk.FYY9zqvpu7cDIOFT.eGXry3vup
 oW9maZOkDmsxm9WKN181d2A_0D.uDFUA5THgfR6MFkh4OLyS6FSedDQ13DAdmrHKwMrVAm0ikNEI
 1uH2iMiiz8yxlGrKVyDmAXJ9ALJyeGJULvVZBpB4b4ezHErRk._YdXOGqCHQwraYSDsRdFyQ.EO2
 b0yScIUqm8c5kZdyOc8EwrUF1URiNGHtzrGCjGWDCqXnkm0eM8R2p9i4UgPRALfSoLJST46ZUT9o
 ygGxrk_DXDikGLGE6ztEr2VxA2SpSquv3ApO8Qp476GeoCFCph_6MBAPO.h8d8jIT8lpG
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sun, 26 Jun 2022 07:51:17 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-fw6gn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3a9d8ca4ca272df8e505774fd3b7d3a5;
          Sun, 26 Jun 2022 07:51:12 +0000 (UTC)
Message-ID: <c7de2a05-af72-5b73-b70c-82d84e84887c@rocketmail.com>
Date:   Sun, 26 Jun 2022 09:51:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/8] iio: magnetometer: yas530: Change data type of
 calibration coefficients
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655509425.git.jahau@rocketmail.com>
 <18f223776f6942d52af2e41dd10160e220a23311.1655509425.git.jahau@rocketmail.com>
 <20220618155618.18996d0c@jic23-huawei>
 <10c06f21-23d3-d3a8-5a6d-8290cf2971cb@rocketmail.com>
In-Reply-To: <10c06f21-23d3-d3a8-5a6d-8290cf2971cb@rocketmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 21.06.22 02:51, Jakob Hauser wrote:
>
> 
> On 18.06.22 16:56, Jonathan Cameron wrote:
>
>> On Sat, 18 Jun 2022 02:13:13 +0200
>> Jakob Hauser <jahau@rocketmail.com> wrote:
>>
>>> This is a preparation for adding YAS537 variant.
>>>
>>> YAS537 uses other data types on the calibration coefficients [1] than YAS530 [2]
>>> and YAS532 [3].
>>>
>>> On YAS537, at least for a4 and a7 this could matter because 8-bit unsigned data
>>> from the register gets stored into a signed data type, therefore this should be
>>> 8-bit as well.
>>>
>>> For YAS530/532, on the other hand, it doesn't seem to matter. The size of a2-a9
>>> and k is smaller than 8-bit at extraction, also the applied math is low. And
>>> Cx/Cy1/Cy2, now being defined as signed 16-bit, are extracted as unsigned 8-bit
>>> and undergo only minor math.
>>
>> Ok. If this is harmless to existing drivers fair enough, though my personal
>> inclination would have been to take the easier approach of making the
>> new variant sign extend on variable load (sign_extend_32() and similar)
>> just so we didn't need to check the older parts weren't affected.
> 
> I didn't know that operation :) Let's take this.

While working on patchset v4, I just realized that sign_extend32() can't
be used at the variable declaration but instead needs to be applied at
"variable load", as you wrote.

I wasn't aware of this until now. In that case, I'd  prefer to leave the
patch unchanged. Overall the resulting code looks simpler that way.
Applying sign_extend32() at all locations where we extract calibration
coefficients makes it more dizzy.

Kind regards,
Jakob
