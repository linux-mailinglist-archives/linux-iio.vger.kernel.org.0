Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDAA5528D9
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 02:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiFUA7Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 20:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244761AbiFUA5t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 20:57:49 -0400
Received: from sonic301-20.consmr.mail.ir2.yahoo.com (sonic301-20.consmr.mail.ir2.yahoo.com [77.238.176.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E813B1A06F
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 17:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655773066; bh=d7s8izpIgU4O6YXucqa1rkEHVgp+ftHT2VSi1qDeYk4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=k7i/vkz/WUTgkrDT6Hd0p+S7tmsIVWcAkirwaSmA+KnZCppzR1uD3yvY9eK7KCW8tgi+w7kmjkAt0AEttNyG5G2zp1OmwsPugXqcy5C7IPFjliXQxyxkW28CRM2iPir9xMz6aFIrLUeMwa7AsApcGVUPUJjoaxEobO0khL373TVkzadMbtBKxj5ATxbCGS4ixYRdicyC8gfbDlMuhH7wmiMaD1k+0MoCMiS7aFCyWcFrPVpwQQQAnYG3qVJ9Yu6su9QhmOUkN9AVvL9I4MJqF5sHPPSaxNxI7r3DpUeebieSRSWMl540mbCPMxlVBSUEbJrTj4KwiuMAt1TKr0lUaw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655773066; bh=i0ZRoqepNZTqaEj8uIbiSkx8iDPyMtW91epO1OmD3zf=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=O+qvYj/tGcFU6LIY+Q7drq2Azn1ZwIcGycRHR8PEtRCv+I9bWKrnWXIehHAdq3P5HTHqj6X5n1JduYB4W+ZHwhoHfFdhxEMxn45onl9PHmGs3BiZbWz1zpKd18iyx0qaGAr8h/gKJdN0VSMV+nOoDQepKXMZUjbwIEqkc/PwpZEyQNrFjHf5HmoOPCQXnEoHl/ErNY5+8YiMq2nPMHtj/2MJEyi7kTMYEPh5yB9wnN5cO/q3cVxe1iY3C3iUAMwG5ronWsTeOuyyCYXyGHSXKRJcpTbBq1xe/MA8IRUSyiNkxpXeDLQC48DIiZMxjNCI1mESCO/WkcGGNadJ4fr6iw==
X-YMail-OSG: BBhC4JoVM1n0DM_6uR5HPVGOwgT1j3cHjwGuMwaEXcV6WnmnMsDeIFlRftlENBU
 3nqDNlJZSYPw.eDbZ8ChwPZrqR4jqdryNSfwpIKGtT0Iq9NNWXs1B7kCjwaJn6RaU27lc5eGRCUl
 bMTNzk_pCNOXoQdw1KBsQAn.uTQHForskGTF._M7qVaoG0JH8HnAsBMEMf7DaqLKmKdnHMYiicrV
 .YMiyGUBhscFLXJe72o_4aCnAfl9doblK8wyFfdJ6zQGgmTT0ky.w.Fxc3t2EyEYvYLSNlZFw0KX
 o4GGIkFlDqFFrRQXVFC4eE5mOD5.XTzSjhqGfTnl0FVBSMQI7vh8xN7EUnEy_dhj5cFa0Q5nZrmc
 zWIk7BXaVdKhO5jnOuJiuBS_jsPovgcAq94tVGMhUQByQdHvwWfQ57bcXA1ukEx6a8Zu.nHsQoYk
 0kd.Ddb1JFo4EUcP9VuuVTOe7Q6D6xrI.V0jDBlgGbupx7WVmPkw_XJ_X77AqaOIL6Z3IV3DUr2d
 GoqID31GMo8WjEmthXaucWP6PTMrVnAfPVedYc0S5etDCJbMAiH_uPFECtHWX.O9dVvVUCZSCsRo
 l4Voqzrqs_dhUuF7D95UwX2dSEDrBCTH6V6Ew8xsTcB.6qBrpEYEo1sLzx9RQiyWiWjnBnlfyNqS
 .VMYhJOxHw5NOVd1xCPHy1C4xNhJsXai5gf3elUfQXB55dnaPxFoJev8V1z8k2G.jCsFw55r0TdK
 iRJqiYkxgx49UbFHUdBBPYAuvhdr8PgTfFdSCQFerudiDZ.3HAhogZmWwKMFfUZNKfVuFj36HA4Y
 vPkQCzMnepZuEMN4KFmR88WKPzpUAMNVSzTq204v0as3oW3.MxcqRS6AqCaynV_pN0Z3ZrVVG44L
 10qiZWTWuoIovN8EE39pES3fMeTPkzCBnpuKFVFhZ.3ugPhBzFfAZ1iC2DUfAbaVSZfYsDr7zIKX
 rWQXY.tb4K4fZGacNss2qzEPEm0r2s_4TT5_hEjOMEp0mfiOGlyfOX9T0lC.z1NRzdEMwHMmWWMz
 O47sdxb10DMUy6AJ199aafAErnNkQx9mYEXdYyAZMZh1uv9vf3yaH1EwgTj29LLAYoZymD0uWwOO
 2alQuSibYtt4SG7bqv_ciuluZ6yHF1w1MbkRWlGRagEny3WfUpZs7YdEJLWgMjrMf9eq2SOrwhzQ
 KOgsho5JxES4L3CeaNRBLc4xtuJjn8C821TI_6DGm30DNCYbnzg_n3Sse6OqJwzHEsk0igA45MHx
 HToxeGLtuyqHcDxEoeUA7orlPzDffh2i86v.CUFmVaNSSXr8QAfq1JUenBZdxlCOqllJkdsbY08Y
 0JSy3tsRJc32X_EZb9oMSfgkojbS9C1R.kHPqTUA04cPaYYygFOBm23cwNLepDpLNgufGLIn6jZ8
 QfFc7l4p0sF88GhPlpJL8hAdLZUaGcaolJ_VoUlODFzRXEin9PRw_OWqKohvmpz_btiFKsJZwZex
 RfubdMWoY.FRf3MKgthJ3wtrVpp3RQ0RvBLpY98enPf_ej0E6MkNkZKPA3EzIxvlB2fKPGwVCdXF
 6CXeiRwzz4odUnBNLSULe43nWd_a.7SC5RIN6WBTWveVtsyrbFihByrrS0gXJUm.KIzjJkByRehb
 AS8MXP8fSjGr26n4mEeXXdL3rEaaH9lThiW3KLDkyP9BBHJ_Rk2O0oXD.cvCcjnGGyJJ6xlYjjRR
 k9OXBOHOmTUIrL9r5_rETGZCfKOQ.XeDJ1y16j_CQoGIhJ4Poun3ovoqecWVWMoGQDe62GXW.xCe
 Tpac3q4vLJdUaElGz7QwbxZ7axnLUDdQtcp5llR84BvNbKeC9q2drpMk4UO.5RJGTli0Q2okWL9f
 H2zfqdU5F9n7fMfOV6xSdmngvbKT73Yl9KBp6r1VeFNtEB2NKF02BhnNLe03hg4TvnM63_KKVCf0
 mzZ_8qoZ4.OeYD74csyFzkmSyttF1baYT.WB_3lZplfG9rNLIiUgq3ohK3PC47B6meuDExUA7_dV
 UTDFl0DapjGARJEmKL0vBEIfF_7woDG1ruKuHr5UrEMT.cpyN32XSsoJ8rpiL9BCV2YvSn3E1moX
 Pu3PwOsKHwYO5VB7z3dJA9R5mas4pgPA5eEcVeM4guX7ExzUWkJU7y13tUMv8em0jSYbC_enZHA9
 wZ0o2lZC.afYBDQAFH1apHInVBnjAqbU2wr6fLp8wVcSFmx7IhD98D2As9Ea1ZRPQBOD5l4bUAOT
 jch_PsyibgGrEuSW_XCHouLfoYHex1VOB0HRZXoYl7e.9w64uLUItDesrDLz8uqpgSBS8m9.SvM1
 msg--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Tue, 21 Jun 2022 00:57:46 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-2x4fh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 329a7232a8c94467337a6bc48703ea0a;
          Tue, 21 Jun 2022 00:57:44 +0000 (UTC)
Message-ID: <e4288080-3c2a-9def-7f56-36fa327f9be9@rocketmail.com>
Date:   Tue, 21 Jun 2022 02:57:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 7/8] iio: magnetometer: yas530: Apply minor cleanups
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655509425.git.jahau@rocketmail.com>
 <362744427c87bfcfa8c885b1bb174dacc4861ec3.1655509425.git.jahau@rocketmail.com>
 <CAHp75Vc=uqirY2c2aRWoxiw1pOwznZynaecED_LCG+t2xLjnGg@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75Vc=uqirY2c2aRWoxiw1pOwznZynaecED_LCG+t2xLjnGg@mail.gmail.com>
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

Hi Andy,

On 18.06.22 11:53, Andy Shevchenko wrote:
>
> On Sat, Jun 18, 2022 at 2:15 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>>
>> This commit gathers minor cleanups in the current driver.
>>
>> In the device examples, "Xiaomi" is too generic, specific devices should be
>> listed here. E.g. Xiaomi Redmi 2 seems to have YAS537 but it's not fully clear
>> if this applies to all its variants. Samsung Galaxy S7 is often quoted in
>> conjunction with YAS537.
>>
>> In the function yas530_get_calibration_data(), the debug dump was extended to
>> 16 elements as this is the size of the calibration data array of YAS530.
> 
> We do not accept or even consider contributions w/o SoB tag, sorry.

I'm not used to the routines yet, sorry...

> P.S. Reading briefly, split this to two patches:
> 1) moving %*ph parameters out from stack;
> 2) documentation and indentation fixes.

There is also the change on memchr_inv(). Additionally on that line, I
would also add the "if (a && b)" that you suggested in patch 8.

So I'd split this patch into two, as recommended by you, but the second
one would be "documentation and style fixes" including the changes on
memchr_inv().

Kind regards,
Jakob
