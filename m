Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F59F58E3BD
	for <lists+linux-iio@lfdr.de>; Wed, 10 Aug 2022 01:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiHIX3T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Aug 2022 19:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHIX3S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Aug 2022 19:29:18 -0400
Received: from sonic314-19.consmr.mail.ir2.yahoo.com (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8547C7E833
        for <linux-iio@vger.kernel.org>; Tue,  9 Aug 2022 16:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660087756; bh=nU+yAan4IOhKOQA9U2a++hxulWTNeEmBrdOs2ClL5YU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=syBZsJmnIGnbaI6A0f0yFxrbEmPgKYGiXoY6plWGQNbUj9T2padqHwVnuoZl0ACwE/NJPl5HP7JjxVnoLxY4SCHiMroDnGFrYij+RKAtNrt3GE0cCS83ErascjEN1QsQoGPxAu5AKJ5SrE9Z55acuHAh3OM2XOwGFjMK86aTxiDktUJRCITAEkvUTakBrfi1PKz+ndRXnTmFDEQAriFWou7fbyHRTzW62JcbdGjDU3MT6ZKEAIHAr3QavwfzsEIwrURMwLiweU46uFtqe84hyQH77OufVFA6PovKLCGsfz+GIjjlLgRIejHAeGF+3ZL/HrzKCdpYQInmtVhSGwBGFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660087756; bh=fEeLM6jJxu4nQEtrE3GXCAmCed7q4OjWZLKouRLJXR8=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GrAKGJBgPObU2yncRZXeBQWu+xLtrnsAR/y6Kf6+ddDdw9Sedb2stK/9fEuAiUs9todQUEbqPaW4QTmRdLpfK2ke803Hsqzzhek8sBTWlrFjRPM4q6A1E3N/EJiXzcwfPciM2x3W0ou6zh4m8Pfufr7hhvK/yZ+fSH+E4tDzameMul6NvMG841g2hQQYC04Hl/80cN3WDVR9HwG14jzgWC6VcVMeJo2UxbadZMGRQSFUQncrjS6xar5Sf/+9P0uVwyVVEbCJpX8T5Pz+KGJZpKIO3LP8zTxUhYUvzdrIt7jXwA10rjEs8A+FVVyTzrIckXKNimIyZii13SZV6sFHOw==
X-YMail-OSG: dv.c7agVM1mdOoKlOYq_p._14oUaoDw3e.m9Vl.kHT2Vv6FolvxIN5RRgz15Y1y
 _IHXGpSVYK4Yhaf4KWq9J5VNxLlx4jlP3bI5E5pyOYnnFp2F5TNCUodaYNZlnwc_aMCQSWDAlieR
 jS2eSdngvj31ijajSJdtJQJ8sr9OCreJO1s519sVwSrNHPpW3H_xopRzXs1n1BmC8SlC7Jmqc40C
 tx9CpON0H7jWWx44sQL2cz7fz73UknNRZMnMyZ0MQegUiMqC5apWHejC6cZ3axoteJ45lDj.TEvn
 wfkLzJDzVEuBzwCyjnW5OH2rGgtNp_Qoz.HtNmZOsAZ.fzarLWDnbJ4LfpyjLbfBkgT.56PUKBMq
 f9b_Z9PxwbB7ZRjoNcV3vkQCjYVcvB1iZ6jmVvSwGNmjB7oQV608izN3tIExL_XpZgccN2Dqlj.x
 dYfP0NrahBxlRhEUVnezhNzoRT49TbCo6o58Ow7_IU1EHeZGukOIHGRi5KnwHGG2uLtYphXFxjkY
 j.ywNbivCNA.PaAf76v4nIs3Q1U2332OGaR9K3ixnyzxMrmJSaDMgNLrTwiIacJq0.WW1nA9PCq8
 pAeVgPyP6f1Zc6B7lc_y_r64Z5PcMuARioOm1F0nWn5W_J4MycLtBzadfiOY0hsjJjIwtGOFdRkE
 F43RwipVHV3BtCXP9_POWttSzOF3sv_d1E8f.FgwVwXRCa1vlaaYyvKpekmetSEdmQl21h.JkIlU
 .mVQw4.YP8AHfMWumNFi5_Gn5vqXhSaVizor2GpmrQOLSiIUbALD60UwlfFKXhoUJ5ceE6yACPS5
 TsqlKR.pnpdJTmqmkMv0p6Jh9GVrh0E07OW68xHeSq6RX.qi4ln1SXadxFgpL0QrkDLkb1yhfQwD
 DH9fN9xOnC4L8RnLiHR50ixcdfc_vwyGl6bwokJAYd8tduCiyi3VaISe4cRDrfAzbntGq_vgpi6B
 0G6XjTKHDE85XxqpxFICky7rMSup5FGVvUvZk7lGCet3EVfKMLQ_2Rc6l_aztWx7u8SY4d0cf6fE
 UorR3IJF4aGJE.SbcaBJOmVV0kq87iEU17quRgg77wHrzqJnPju6HSr.27fVe6FXqf5E8TK1pD4W
 OGHFemsXoFr6gzhWUb8a0_VkOn0naw2_P_NYGb3ywJlCq4G2S4YdIIKe70dUfPv04_oN.Q9tHfr4
 kQpXy7mRQVIbKDwgfooBfYBpl94hqGTN991iKHnNr6jFTdvucrjMysRtroeimfNv1uAU0UPlIeKk
 TzWo2mGeVIZIM9a5HFv3k1fHY1VuL3jxwYCw5lCMjJSJbpvzTcl1dXp3iDdvXa5Lv_FgLkCOyyvZ
 UlPUCrfAPUjldWv4CdRVwEWPV.oJAcIA5PKRckLkzUlaFMP_FYgXoZt3Lqrm98GvEAuhtzReumpp
 ftBTRJRUfDLllZEH9FBIT3G0y7eNZNg0uFFex4oyWE4ZggMlxe63YQTMtUeGx_wZqwJJELZDV85f
 4WMhgJp8uMXBEUeHHZNiKwsZ1PUZJmMvJ6Lk.iavjnfjyId0zdW8PEnUISSxBHF5Q.pERRJte9_Y
 U.rih6be6SCbelHtcul9Ht5gPnZ1f.5nJIaDRhaEo.GOfJHpGXvGXTnwyecbiWI60CRnz.sFo_d3
 vlj2udAcNX3JQr_SLBVhzbySRSLRn5lmL2d9E1xU0pBH5JRFkuoe.RqprHjS72yn7B4aUToiEdBR
 WWC7t.W6GolWoybIpKfUfitmIW4lp6EpNJDZuPkw6RrLYm9HEFV2mnyXiXmKdGnyXS.mqbaSRmr3
 DgqtRNXJm3AbIEi9mO1TtgcU0gjubcPcJxPPKMNKGcXpSb8QydvWyOvP0VO7bMT969JLYXzVl97f
 qxgUDae4qSbiBzr_PQlWWTHWF5buck2S4Ir0yLnvqQiQPQvweUYnCkFqnIGWWIPTcn409potCfPC
 jEXEkxMqJ3J_oT0ttpOSyu5CiochlKrrEQBz.seoai9FaTnPuTBPR1MMrTO5uuNkPeE7qym7tAYH
 Zd01udrUbodpwt__WRGB_Dthylw1Xz2Tr0TGn502pvnNyRJyc8cC3ZXeQ4rwtGgX6VGWvkZ5j1Ka
 yRsBKwcnaX91FeYLU_.eZyP.2ULFK2wFqTRArsBo7QQlLZfqpo_z0P2i0kxcGZ0.PdQBBgxujxNN
 YwZX7zpT_H0n55BG7RzkaLndR9SvBUA6nYH1zkSdP36FfsKWG_jAirGZ2.WCPWAHY968L403uSS8
 TteekOQazUyQ5vuyBY0hxuRPRYwyeSYr3J48GcdsXjifnNwuMuy.F8D4n_QKav6jEMBlqUyJMT4e
 f8V7Usg--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Tue, 9 Aug 2022 23:29:16 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-2vqg6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e6b9145df121af81fcc9147d42d3618f;
          Tue, 09 Aug 2022 23:29:12 +0000 (UTC)
Message-ID: <c03a7ece-0b3a-0bb9-e37b-97a442eb3d4e@rocketmail.com>
Date:   Wed, 10 Aug 2022 01:29:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 09/14] iio: magnetometer: yas530: Introduce "chip_info"
 structure
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1659909060.git.jahau@rocketmail.com>
 <8f5f58c9bf0f4006fabd01b5564af071d20f2a2d.1659909060.git.jahau@rocketmail.com>
 <CAHp75VcS9y=cp6+G-QweVpQ6+HdEJHuMx3dBug+aSyfae-Ra8w@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VcS9y=cp6+G-QweVpQ6+HdEJHuMx3dBug+aSyfae-Ra8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20491 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 08.08.22 13:22, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 1:07 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>>
>> This commit introduces the "chip_info" structure approach for better variant
>> handling.
> 
> Read "Submitting Patches" in the chapter which mentions "This patch"
> pattern and fix the above accordingly.

I'll change the sentence to imperative mood.

>> The variant to be used is now chosen by the Device Tree (enum "chip_ids"),
>> not by the chip ID in the register. However, there is a check to make sure
>> they match (using integer "id_check").

...

>> +       if (id_check != yas5xx->chip_info->devid) {
> 
>> +       switch (yas5xx->chip_info->devid) {
> 
> You can make these kind of lines shorter by introducing a temporary variable:
> 
>    struct ... *ci = yaas5xx->chip_info;
> 

Everywhere? OK. There will be many changes, this also affects the
following patches.

I hope "ci" for chip_info and "c" for calibration is not too confusing.
Though I guess it's ok.

Kind regards,
Jakob
