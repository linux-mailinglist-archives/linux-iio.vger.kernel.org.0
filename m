Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EEB585704
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jul 2022 00:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbiG2W40 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Jul 2022 18:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiG2W4Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2022 18:56:24 -0400
Received: from sonic314-19.consmr.mail.ir2.yahoo.com (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EA2868A1
        for <linux-iio@vger.kernel.org>; Fri, 29 Jul 2022 15:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659135381; bh=Cyzo0mEasKIy+V2SC+VysfKIc4RFa6sAqMGybrs/t40=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=AO9ffnS2Mjp6ziaBjGou7lU0swocYn5B94eVviv32Fi2xuMRJKiMpBI21eQsiffE/MgCLXRBNCUPGywA33sBZtP8XaOfP9Rngp2QkOPABbR48uyW/mo+CJIr3Z5+PteAXF63ocStKO0wKgC7mjQ5HrrMiJFiu29RgyO7PRYLWnZHzPlXJyzTBJDrrpnTOCYdvf25yMtiH1ZrRl1fFO+wuF32Y12IjnLoy8UfKl6agRn5oIKzMLeOdLNr8i9d9mhHwftnx8aZeHXBdaUnQvICQ1whMO2AE4C0ROT8KJ0qfzylp+6tma/3N2gRYBlE2byw87jJoDq1UDgm9J9QQCyaLQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659135381; bh=fd8FaUgCh0NE7BymTcNF7GN4szEB3vXwRy5t5b0M9lb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=orc2Y31eccSOmAOci9T20HB8CyCMFrfBZtmZ6MOMC1mRqsK0qbio5WYBd6YPqlAEPX1oVisVAk5cjvS1JuD794PuFYQfeKmxSd/R0+6I9JSeplSVfnt9yImXeopE3bMjdmPqBL9Sf6bumzogOL7YtjmQ16pW5S+M36bIN+4yla1FMQ6VMGPCnCFE4KHtt7G02kqRhi5eFxI9J/zk97k9TdgUG3LzlBwRBp4yJciOMqnPHHB6wEkJwQAbWKKzGNK/P5g+EnOPeVo/Z8u1Bc8Aj+Xgx/0e9Ee+p8t0oLK+qJVPzwX67gJ5pWj3BY0XaXNG8RnJhT4tuBebrFm20yJ9yA==
X-YMail-OSG: qFLq.9QVM1lslcrtuZfvdTfETqW1MshlIVyPjwihYJcJiLz.rM0KSTe6CjaoJIQ
 PRyH9vKuX0OQiifxpvA7xUadHr3q.C701BXMAMD4LCllW2Fl2O6r141UaIML0KBsoVN2.P1k6MfU
 V_UpvCDW7bfEYQoRLsP0birHVYRNjeJWmBfeQOjEqoP7elWaz1a92m1GgdN61JyLhtXs0yeqrPXg
 zZe2VA04g6GnN.iRM.VedUQCnfi.968ZtDXpWIipELI3mK4GsFu8pURcjKkKWhreLtQJsD9CGx8U
 PLOTWG7H.5Rbq3BbCtpMABhit0S_k5a1n0Nf92bZv9L5guu5A30IolClsLJ79g.3OhYc3wQfW0.7
 01sQPI0b7ndApHamZUW.RMKBzewuTbFhBKBxlolbZ_efGJ_ZqMlC6JYagcLyX.DlYe0kz0nmIbRX
 wqMf9qFtepT2B0QIG8MjtZ2ygorrdzs95UdL8fuxfSVMAUBisbAask38XcpQyO6kP_4ex41tLDjK
 pfMzNDdlXGXyEnf_nQpomjbVB0.GExSZJoGjoOXdyu4yug857LFi76UtqQ_aKpavKRx.3JLreu9v
 V3TkxuAq6cQHfQF75yx.SpSCYnje0H5uSSXb.xJawLpzYEoPjcEsT_dUsOsN_Hy9TxEkXHfyien4
 QyNqrsImDYb_y1Gh3QXfgLS63acVRHEk2vaS41ZPbWHYGsYVmFoY.F.LgYJuuPcobu4PSrmO4cR6
 yjJOeceYXvzIg_5eJwPYX_44Ru20bpHyeDTbJVR6UiaVaa8ayKWWYku32xCXYfcVrsfCXqsGgdTI
 09XLi2FVj6eSP.1JfvYaWWr0qVLCACKpxKuwIgrHjZPdDyH5YhNTyuzv9XPy4HLIeYRFNSMtZHyR
 ubvuz16Tc5b0T9gGYxCh5vGLi1GUucsNRSu3ah2vTKRXYbJV7kZ0puyKGDz3.3JvWnBtuB8J17mE
 hDxFrsMcbbUEGg_ZM464Iz0CZhEwCHNINIhnCimKRQdrf6BpIL7Dc__WXsqqCmGENbWey..ody5n
 slwTtI3h5cS_aiR40BkOZlEB4iCj_eZMoL8IwNBXq1fb_z6DAchucktiNGFk5rjwiADri4JY2_NJ
 .MzKsAh7Rsoc8LE9CYJqux.i.hLvIdPMyigmxq.tdECKhXLqCVIcf4oEdfmgVgELE.izPfTA6LFk
 ae10BpWpYTwt_atkHc7BRAdfBaMExtQXwWjAOxcr.ZFjMESTdg4SYks9gXTngPCwaO2Er1SicayK
 ZkRGY0n9kL75_JL7gxUL4Vn3UrmK4uBDYMGrzIbmvtIDt0xuv1Q1hkJHIFQ.b9g4nf8HJ1lYqZSG
 o0zc2aaUkQiswdnpcRwcmKNo4X1lZKK54LGzJy7xSyhgfzVooAJARp7gWi4lB.JAMz3eRDqBGqvD
 1zSksZkogE0dSS6WDrlE0IaStYQCwydr.QG1bkGEBPjpjP4XX2SEnsLJcxjRfFq0FPuHv_.sXgeO
 kJ9sJc2ZlUVSiLmrcHEDJDYNX21DSAD1UHnsuYyEHL9TcTyarfpi95_rmdfoZPM9eY4AHimw1eVy
 FIno9AgnhBVY_mAAjgc2a0btXJ_BnGDqLUsBkFpbU_H6RpROwfKVGq3.xTzCf7pliSKa6KFgnF4x
 XWNvyMyD8sg92Rmceil7yFp12NUW4Af8PV4TgEBVsxi_B0vpf_gaiZ030fJJ0M2Zl7dp8Wn4Os1y
 Ip0ayh5Esdo9iAGiQzmI5rWrKWZl6jzUL0eqhKVvf6QluL5YEpLfhDCoufjgD9Et2npZ69pkvZ2c
 mVpSNMaZHHJi_IN.DoXikz3ljtzOin7t00OXzBRrlbuiHqpgrRNsHo9PuXdYGWH8gmGxNNz3O3S6
 XL41At2TPwzjxE2mr2VzBz4OlM4wZlPjPU5wyMn_ajlBQTl8OyrQEC0ap0Cm5FCrfD01XLAIKTtd
 J7HtalFax5.cNM7Rc3yp_q1kOlqT9XDlNQ4gZD0UMN98fZRWGnwf9ueGkAmEA0cXlFjBrODG1sH5
 ZGoVWQHZyZMT4Yb1JPmRPr911qvCXqe9YXm2dvyAlgjeVZ02YQNY0Rz3nqP2Hw3eROZl54vA9U2C
 CB6XilJGQN5mK1w4viSV4nSslm1vzIYUE1Tbxg3zftWDB9NYN.1StwWhts8CJHcbEq381r5fqypu
 DsayXUV51h33EYcMI9.mm0.ITk9T2YUTtCXvvgoi_fSJ_s3zTjLsY7BQSEVEcE16XlxvYMCai2WF
 Z6Yn8Dy8g2YMgYCJUqnV4txvKoOIDpxbm0eHSyCwOPiC2qWgY.VI0rncAd.Se3Lsfe0TZuH9L9wt
 aKw--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Fri, 29 Jul 2022 22:56:21 +0000
Received: by hermes--canary-production-ir2-d447c45b6-fs4tk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dbf00b67d1e8c958fdd7846f7a33db02;
          Fri, 29 Jul 2022 22:56:16 +0000 (UTC)
Message-ID: <30ce3ff6-14bf-19e5-e330-d7b8b30c1727@rocketmail.com>
Date:   Sat, 30 Jul 2022 00:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 09/10] iio: magnetometer: yas530: Introduce "chip_info"
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
References: <cover.1656883851.git.jahau@rocketmail.com>
 <28a2a9ec27c6fb4073149b897415475a8f04e3f7.1656883851.git.jahau@rocketmail.com>
 <CAHp75VfGqk_q1iDyj06tEuTNoG35xjOL0_5HgokFauUz_aAwFQ@mail.gmail.com>
 <8639301c-ae9e-54ac-919d-baeb8760a31b@rocketmail.com>
 <CAHp75VecjLe67XfK6qgM4eZfKiTJ-UabD40i6Q_YmMpyWAWMkg@mail.gmail.com>
 <c52e34f1-1cc3-4351-e03b-6b9bf83481b6@rocketmail.com>
 <CAHp75Ve_0srfZbvKJ4z8dW3Mp_a8CHSTqASSAY_SOJiD20K0eA@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75Ve_0srfZbvKJ4z8dW3Mp_a8CHSTqASSAY_SOJiD20K0eA@mail.gmail.com>
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

On 29.07.22 18:13, Andy Shevchenko wrote:
> On Fri, Jul 29, 2022 at 1:06 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> 
> ..
> 
> Just a couple of remarks.
> 
>> Indeed, to my own surprise I found a solution with the 2D array:
>>
>>         static const char * const yas5xx_product_name[] = {
>>                 "YAS530 MS-3E",
>>                 "YAS532 MS-3R",
>>                 "YAS533 MS-3F",
>>         };
>>
>>         static const char * const yas5xx_version_name[][2] = {
> 
> yas5xx_version_names (note S at the end)

As I understand you, it's to be applied on "yas5xx_version_names" only.
In the chip_info table, it would then look like:

        .product_name = yas5xx_product_name[yas530],
        .version_name = yas5xx_version_names[yas530],
                                           ^
                                           S

> 
>>                 [yas530] = { "A", "B" },
>>                 [yas532] = { "AB", "AC" },
>>                 [yas533] = { "AB", "AC" },
>>         };
>>
>>         ...
>>
>>         struct yas5xx_chip_info {
>>                 ...
>>                 const char *product_name;
>>                 const char * const *version_name;
>>                 ...
>>         };
>>
>>         static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
>>                 [yas530] = {
>>                         ...
>>                         .product_name = yas5xx_product_name[0],
>>                         .version_name = yas5xx_version_name[0],
> 
> Also 0 --> yas530 (use enum:ed indices)

OK

> 
>>                 },
>>         };
>>
> 

Kind regards,
Jakob
