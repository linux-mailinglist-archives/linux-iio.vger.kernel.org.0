Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFBD55B05D
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 10:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiFZIjs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 04:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiFZIjq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 04:39:46 -0400
Received: from sonic310-57.consmr.mail.ir2.yahoo.com (sonic310-57.consmr.mail.ir2.yahoo.com [77.238.177.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0482511454
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 01:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1656232783; bh=PERmfplRdvSLSyKVEv1CEvkeTqyeWKpirz+NeED+LV4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PIxc168/IVhUl/8t2TqzSw1j6cLXjpvKPV1Fp46n9Htm/9UQoje6CTX4EIpFMa7Nm0KCiL3gCUB7CaOaFW1rX2IH/7g/2zzzfuQ7K3CiEEawrbqbZYEEV/zGx49D65kpiU2IHEmLjhx8kQ8f1ow5zfpmQLCVXh9pH9ppbR3sugyzuFDh4UwkOvof83i9OYYt/lIazx4Qz1tItZL18ttHSPhVQgUDUkuocSKGnGdcxuj0e5Ev0YmHz6CJG1Y6g6aFP0aAZh0uaI8/IsIck4VFRZ58ZryR2WkB6eFLt99mTOVe0NnKo2mHNWVGtCdijF1qk6sUM72aJAjLYY5Jlg0DZw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656232783; bh=fkEfSZbvjwc+J4CusW6LxTPHb8B2sd6BRbMnLrnpEd5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mNkiJwZB8abEgwCG4btrNv0hrQUYQolmsLdHfZ1Q8eJGg3mFICRXF5SD5qcbrF8vcWX2Y6hRi/4eq+TN78o0N3gR4axrrZtz4Eko2KjKGuERc0xZzIuwpZDQu63ZWvfae2rMVQ/hYsu8e1FUMsWHVLDAAHsYWbGJkmrz2nL15mXS5VU9m2c6APFs6Z/VzRXVMgTlkdPAxcB982EJpW1qxC+EuR2FZTTp95EN1lLw+qkQgo5lXnRRGGodl7DzBhkm9kUfbLvJs5UBSr8BNiJ1DNjS7ywLGMwVBE+VqRV2Q5nXMcv0JkhRKp+JuPUQ29mquz7/fs3dEMPdGxKgci5YGA==
X-YMail-OSG: WuKzFysVM1nbnXJb4xF00IEES6YkqZzdRqlcKXP4d2lR6pr2D4F32iGkcqb6aii
 l.UZWMRpkNvia2E997wgdqwEbZXkbhDKuRNBQguFbayqt7nJmsidhzICxNaVsngz0m8L3Csm7uF7
 PkjT.vK3CN17A10WTHWZ31JvTdisN1JaXdfK0hrfICUNDwylXZyEsiq41pH6taorvqrePKVAp_FJ
 IiD9OAUivM57LGvVZjPdl7jLthZIbFraPPff9mu2UWTwZXTBEV4AjinKpKVa.RnQHoS2zAtWbwXT
 rPBXIX7p7CLDr5VrBEz4ZYWoQOA0fQ_XXU.MYN0DE3R.zwP0QDBg5CR2SJQBTVYpsJpsfGJ8_aV0
 JzdH3494Emq2SoMXs54Rk4g_wnz7fZJq4563fxTl7jDIhDAWAfcg_sw8u9SBL1Z5w4.Oe_dX6y5W
 gyTbeIiObHvNoWZGj6N.hQ7CO1C97wVoOHjqawrPcKuv5oG3Mp1eVql5tl8FO39q7cr0EMix8h1L
 7hBIdK1DauSr2jNZzkGUmgJs89qGo.96dj7YJwJF6manUbaRrmRsnXKMSlQL4FKzHNjOY8_NZgNW
 LoQaDcbTtSl98SIFZhR0ee1V5K7_Bb7lZEjkZqlMEbIBc9r_sMKjPO1QIoAnnYNdoG6tBy4d3W11
 J6kNmy83ECb5inb8KCRQhIzuyFSO49SGSkrv9kad671VzL9rmU7ZIKZ9GeknTVARrmiPzDK6TgW0
 pWTeDdtSO8VpvoSqfQ4r8HwYln2_zkVn.ZGxpTh0mn0zqlspayL8M_s8mwCjj17XYQ9pBsM3lW3V
 Ayzx6Hntq6mN.queGN.FdtlAzrROaDZSmdmrr8Sc0Py8Js24t4bWRxI5EQC48YJLFk3VsbW.uTWw
 skRKDgKHt4mEiNzR_G3Hr58oZjgSYivSUAGVYGwOL_qbyMHga.OSJDHAGsW85T1PH6GnePPNObg5
 fgRb9oCNkrI3josj7vS.3zeYH7Y_0C_Wb4KkrxTid.47A.C0Mb2sjeh3aMCw8JqWoJVnxz8e5pVZ
 OFTY2w1tGmpcpiLEBFVRS8r2IkqxAiG_HByw3yKXUUeDKKqndNrKf4CObpvUIqYDpNb95gplW4id
 l3PExLBtYL4byY9ugwk3ffR3doY71PUH_qKqG38py.hB4QHFkAyyX8frrGqImd_UDiV_fOjxZGQq
 oQ3Hd0BRcmP5JomxNRCp_qWjRXYaK.b.qL65wntfkWNvIPbt3FLCiobk9hegr3nGKO6gFQ4xV00E
 LAHGSNA0a5WVFR.Fk9uCPd4uXj8DdSEtjYWBEFETMWmsYQlAmoL69T4VDWaiyDoAEk8mnhSnGX9l
 UnahN6S7HDqFIxKXMMQvoCkQLBpW.Ly1RGAMw_SMtGwf8fuHTd5SDjjAnGzVdzToT4G3v8zrGYEL
 gLkzoRh6dRXG_inOmHp2ww5pgd9SnPTCTqtxqkWHOd03UsJVR58Lsxi3rfm.JyBRA0yEAIS3VPtD
 K4iFzDCKWWA33B_51Nez7fFcrsPnSrw8cDqcxBgXs9eSs7uK.q8MQwz0Uy9_KV9KUi.qez_EWIXp
 YLpegL84xb_jyltZ1QwPq8s21biLbFuTftY1hOyfK0swMEzLB6ex.hLzS1mSXExBRnmoDJ6D.WR7
 xlbbFqJ4urNcHnk0cdttmpI9SmguGBPsVIDRdih.ty.9u83rF7QNizz36UqOmzGR_9mEzijKFYCy
 IjaQTBkp4efsDMtISyQLOwTPXe62GZZgdBSNpD8LHRAgETdNQz13Rz3a.3qd3P.2_mXPKRjJw_OQ
 99LdJIYUKry77EEkINe29D.K5dVNxzOC00LX5e89Z9F1EudT1HJNPq69OZvtCT_nEqHssQNsI8gh
 tjjJA5mVfy.robKLKcuR2uWwGmhyxhaMGNzxXucHKoYANwcEkd72Y2HaaxSQA8VIYWTeKc75aKDs
 X_FEQVCfYDSrNJI.x2rrT3947800FqHp2rsPlCfs1GaUevi6iMJBsn0MGnONsMqzzWM8f7qdvtZN
 xTLAZsDJyZSk0ODl85XSa8JbcRdFVp4RpE80jX8dSvcftqMLURf90ZBCRkCjoMOPcZYUTPKUL_wZ
 4i25.ySSJvj5cON.CQ6XP47WnLoTCGtPjTQ4uRE58HDTnLb5giG5OV_IkGBXIO6SGpf.aniSCXll
 ioXgM5BoOKD1YaPM3Fy_E6D2.Nov6Ty74HHS8IwbYNsvruJXFk1heklvxeercYny5p4sXa_ofnxh
 t4iC24hAoI1IbIKbAuG7V4G0R1A7CSMxjj9_ZT3bO4qTRfzRva.Ohqr769smMqqLFVup_hzEa
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Sun, 26 Jun 2022 08:39:43 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-brwkd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4f396652dc92420c3e14bdad7cbc95a1;
          Sun, 26 Jun 2022 08:39:40 +0000 (UTC)
Message-ID: <daf3206f-0cd5-e8a4-bab9-6f8f379e4ba2@rocketmail.com>
Date:   Sun, 26 Jun 2022 10:39:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 6/8] iio: magnetometer: yas530: Rename functions and
 registers
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655509425.git.jahau@rocketmail.com>
 <f1a49262b124cbcdf4a258f65fd54ee389de3a29.1655509425.git.jahau@rocketmail.com>
 <20220618160041.15798dcd@jic23-huawei>
 <d3e074b8-9679-87fe-dc5a-9493f0586aca@rocketmail.com>
 <20220625151637.600d20a0@jic23-huawei>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20220625151637.600d20a0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 25.06.22 16:16, Jonathan Cameron wrote:
>
> On Tue, 21 Jun 2022 02:53:58 +0200
> Jakob Hauser <jahau@rocketmail.com> wrote:
> 
>> On 18.06.22 17:00, Jonathan Cameron wrote:
>>>
>>> We've been bitten in the past by naming choices like this, so please
>>> use yas530 only and rely on comments or code that makes it obvious that
>>> it applies to the yas532 as well.  
>>
>> Hm, ok. It's harder to keep the overview. But I can imagine adding up
>> names can get out of control. I'll change it.
>>
>> For functions and registers used by all variants, I'd keep yas5xx or
>> YAS5XX respectively. I hope that's ok.
> 
> I reserve the right to laugh at you if the next variant to come along
> fits the wild card but not the registers that have been shared until then :)
> 
> Otherwise, I'm fine with keeping the naming for those cases.

Thanks for your reply. Reserving that right is fine :) It could turn out
that way.

For the time being and as long as possible, keeping the generic ya5xx
naming for those cases makes it more distinguishable what's generally
applicable and what's variant-specific.

Kind regards,
Jakob
