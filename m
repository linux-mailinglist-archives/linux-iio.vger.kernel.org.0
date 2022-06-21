Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145445528AA
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 02:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbiFUAjX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 20:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243929AbiFUAjW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 20:39:22 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com (sonic308-19.consmr.mail.ir2.yahoo.com [77.238.178.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FD81FA53
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 17:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655771960; bh=tnvwehH4yqjdbmJErm4f1BHdQGdpq4dZWM/u6ENK+RM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=tuv753QkuIJwoh3y0vbN/D5WiXO2QcTbj/8vC+RHzv3mr2y+iP6X7v4EcPdoKOz+GecWscstdAT6/dKxASJaBJN8xX7AwnH1cTZhxDqjuKEg04pxRvSRUeQyo98hLmhPsBhnF21uqrhH7E8w24m9kqtozBdDKYlekb/8ZLqEdlM7ByLCemetOyV8rkRHyCW6gc/8AZUOH/DmkrYwfNfuxmD8C1WdMMnxU75JWE6IIGd4UKXeddE95aPgGuq9ZkYbeMm9bUKIq1QBKMFz5tAdfy5izsP97wfw9B4+ORB3hKeNN7PeKU5W89rx657p3HUH6akQ5MuE6X9g2onEc+sXJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655771960; bh=csPgdFznqwfrQPJZpyRf+7U0hZTWnQPsxd3j0oKOrus=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OIukjUh2UWl6/o16xDIm9yAKjIax+a4cB5r0zRw1V2DGOsRiZwey4twlGWKKKRw2uwy0I8VV5RsJdNjX2EtHPncp6gauSiXPKxqBx2x091b0KnG7NSDxFFSgZoXqTCOSspoGNXVcPDbhjbPu2qWVuK3R1/Em3oKq7w+NI6IImnzB3YlnYgvezVFalS+QUuibvTpcFrl+h7pCOjwYJohGpJZFtcjApGBX3YLVdA2f4Se5Lci8TC2stwhJTJUvUkIAWaB3ndf93R/sEzaUSSclaSxd3SLy5B6er99FNi2FazGSiTNysnyPixqf4d5agHJPhCFDFZeLd7+MRQ2cN45gMQ==
X-YMail-OSG: dhrKByUVM1lzouggXJ0OYWTv.ws5rYaxQy8DuAb1VOfY13xJ3v.7lwAVonow8P2
 6xmjrZS3DD.WRC3sCNKqk1gVtmurrz67Nexog296swMaJBzmRyn__Thj0ChdkodY5cxKBaf90W0Z
 NB03xpKHQjs.PkiFUR0WBdiy0hSRzQtuqgCFSc5zsaETwHzeNcd9sqKn4Ut_diXQ_tt4tcDIZ4mI
 RR8YiE_99Qxv4OGGJjtyZ34FyUId2EjEbaTnMscIbEohR0uDoHiikivN6EA6.QvQkxbdeZO1MLNl
 vElqP4IOr5CfgW_B_5T0ihcijcisay_4GoypfhobzbQ0vThfqqeRdbGcsVSTErn23MBGGTXamh_X
 iPBOu7FhO5TdAdo5gvixiwFwmLVGIgU7ylNMmdIlkYqxy3n_.RqwC5XPg3yIXBMpLCxfzCrtj7OZ
 hXhn3BGr4mtv8a1nQ0bKapkkIdoj9JsyzRcpw9Gk__M8a9GMyCt06tv20eQ6ta8yTfMfk20uA96F
 6A87LbW76F7I5Ry9Pjxp3EIzZuwz9kGR1P86FBKiYj2LoFlN4HmBzWyu2mXbSGDArPk.X.ELdLDk
 zjLEKH0krwto8DevzNl3NPTnXILxViipq67aTb70R8hCtIcyM4ytZjkZVU2NxPYt2xi3q68rd2Zo
 y8TBx95C7gMrILkRIoSE828eVlOA98iyVWOi495rcpCvv_JlDE2dIEu1pTEWtNrJSCtOER.Z1mcj
 b8d90NZaTrxV7I2FMHtEH6X6s3d8eocwAgeopoFtsfZ7ZWN6_6ATH90_1wB5eR8le1_5gTxSwr2m
 y0Hv29iY1jz90Do9qWAsIib18gGgG2CnvnbCkSr.2UGS.OsU3MQN.CjFaeG7j9qN.QIfG1B.KH4D
 jCbeyO5Bvellh17ycloFzk842.NP3vl9VMot6hr34BWy2NZUpfcKXA9w1VJJWEdSemt1QAXljy12
 QSVOB8CmsxZmZvK1P3HZQ.Vd6XoBVIjT5EsWardHu6cmXqC5OQYv_YE61C3OuNo12yjb2QdbFO6D
 i9c2HK7pUHWeu0bfvQP_ytfHX0e26ifhoMo5n9ENCAy0fPf9Lxwcp1wt_51mgE9EmYGZnnWaPkTh
 5yCc9GfoB10Fz374jmCDguH_h4jADPLr_LnCdqjTGaBh_WF37MX4xyG4Y.h1b0EfvZrZWl4.tOcd
 16_7LyLt3tH7MLQd_Orc4eBcCMAxkTHYyeKJhIo5aduHD7fVQNH_2t4kQ3AghyL9FUlx0eSAGq7y
 EO.czZKaO_0ZNxPorkaTLRQcnckTzkFogdvE4m5e5RwVzIAcAGIXrDVSYm76ylON6au2LKA1Sqxu
 yk.mS2dlQS0Luq14_OG9SKYyf1Z99HlUjcoZkyjKAlY4qqsameDZMUuGrdZfFNTUe6yY0LI4I1vx
 LRJA3rvHkdhHDMawaEi9eTjBlKfneqnmzsnI4GOAcr7_yMe3zLaUBH0MS2m5NX_Jg_urPv1a8fiX
 4.NsjW1vB5UZ1V75Z_tE8CawEWxETZgGHPjQK3hcBAYfOelxGdAyi3cXGGJSTwa4ACw_y.UbB6eG
 Pjz3sWdEUyRERNvIpDFacEn2BJVzwyzqtnWid9amgUDmZ1x595vFfmTOjBhershvskPBxq6PoVEi
 N2N4.aGUPNZC2p8A_ey9nUORbyFnDXFbk_u5JC1pVCHVIXUvcJ9JpbTGLMFG9g3YYvn.dPzmAVyR
 XR0kU4Bn4jJkgfDDNmwa5gBkFrYj1ramHRBnZ8Z_vy0iIufBFQujQsDYNa4hVhkJ.oAi19mdUrxG
 x88RzZ3Lu_5PyneeceFLSYxhCRLM0Uau7RriEYN82KYncXByPNM8LSV5etVkGQoQ1HSUNhV4tEv2
 rnZNYm0W9NYq2UpGeRPd7srGZK5O39FVyHR1D2v2092PAkJJhpd29jrZoALGGdknbe2WRXLf88T5
 qqW_nvVYnVvnsFa8jAx79K9GBHYsBaX1r8Ht2zhRGOTNxsL1GpDti_Dxi5k_20Y.WdhUcL5FLOlq
 nc6QqDuhDiq8HbPyPrZT8G8aeD5J9PshpvRDvR0ysi4Wa0sNtztnIMZS.GvHU0nZHc.uzbAzBWuk
 .kPVEEnoXJXsarCkO6ZKdCbeSuc0ghK5Nx64tQedeTpHM9BUWb0l81lRtKJjmNnEBzeRsv34b7TQ
 T.KclA49wvxTYf_srF1G1E6lx0LASWMPOKrdtf5ZqDrF1ovApn71838GsklwtGRpoztb_9rMTvg5
 5VcNintZmA3axRL8qO06gj1CZMdrK47C0ESXsn5Ly9PAZb6kU0uI4421qWUDvkABz00XK4Zmv
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Tue, 21 Jun 2022 00:39:20 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-ff8x9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 67491ddf0c44a64418ea51191bcaf438;
          Tue, 21 Jun 2022 00:39:17 +0000 (UTC)
Message-ID: <11df139b-99a1-b43b-6f12-200587cb03d1@rocketmail.com>
Date:   Tue, 21 Jun 2022 02:39:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/8] iio: magnetometer: yas530: Change range of data in
 volatile register
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655509425.git.jahau@rocketmail.com>
 <bd9cd1d425afc07cd9939e4b41ada39a9ca350b4.1655509425.git.jahau@rocketmail.com>
 <20220618152137.59de13fb@jic23-huawei>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20220618152137.59de13fb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 18.06.22 16:21, Jonathan Cameron wrote:
>
> On Sat, 18 Jun 2022 02:13:10 +0200
> Jakob Hauser <jahau@rocketmail.com> wrote:
...
>>  	return reg == YAS5XX_ACTUATE_INIT_COIL ||
>>  		reg == YAS5XX_MEASURE ||
>> -		(reg >= YAS5XX_MEASURE_DATA && reg <= YAS5XX_MEASURE_DATA + 8);
>> +		(reg >= YAS5XX_MEASURE_DATA && reg <= YAS5XX_MEASURE_DATA + 7);
> trivial, but I'd prefer it as
> reg < RAS5XX_MEASURE_DATA + 8
> because we have 8 registers and do bulk reads of sizeof(u8[8]) so it is more natural
> to use 8 as the constant.

OK, I'll change that. Need to slightly change the commit message then,
I'll probably add a sentence.

Kind regards,
Jakob
