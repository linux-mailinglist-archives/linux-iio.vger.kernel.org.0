Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B73565E22
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 21:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiGDTsJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 15:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiGDTsI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 15:48:08 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2ED65E8;
        Mon,  4 Jul 2022 12:48:07 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31c8bb90d09so36464897b3.8;
        Mon, 04 Jul 2022 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7b6iaLPT+N43EUHbL5TJeDRA6vo4Z/MJZAW25KHjfs=;
        b=mQX9ZF+iXH+faBGdUwaZjrVGgVhrIDwsvycbczhnaes5ux/icEYIRxIe6XzIk+OjTb
         ldRh3Mu8/Rc/9tZn5eTjsZ3Tfb4A2zsxe4xD+jFe03VDZXmIyhIwgV2RGxwdzN1GuxsM
         xsnr+uNX4Re0+2TIQ2UGhLhKMbC0WBqn+8K/kJEFBZ3TwhpDu8eYelymLARLyQuMzsdU
         0k0CnQslQh3swT4S+mig37mVoJBiPTISTw21wcT3ec4DnLz3v90itm9OXzXS9wTOWyup
         p6R5ZUJyYcoqnQ6s96NtNoV5MQnY70N9K+j4B1+HD0jQ/NtyrXFSsZgtavNGcnYilxL1
         oaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7b6iaLPT+N43EUHbL5TJeDRA6vo4Z/MJZAW25KHjfs=;
        b=rh7hlqSbP57eYRfG3mqO8gI2anUhnwNWByPtEABCz/VgQXb/sO6mbG7xONFFnIKN2R
         FZX1gIy1NlzOP9oAn6yeRVobCz6+5oHuYwjMTkz+f1syrX9RjslhZWbV8yu/jEcuJinW
         five5JVe9t66veFKR172uAycW2NRJRrFDU1VMjsNBMBm3vUjEBNKu9BVrNH/OYKwASW9
         pPntlFZjBgY+lsUdgstt6jE8qyCZss1v37IkO9abjEdzdsOsG0DVAsvND3vQEImaZeF+
         zIJJKr2BQMpO7azCmvQ3R2oxZQ/UBnTUVuHqqp7mvdfhT33x+gItsZVWxlgsLmGiTVON
         tdKQ==
X-Gm-Message-State: AJIora8XdbR2nk+Q6qDUu9P4sNU34bV/x9IODfZw5B5iiOd2KYRvVXlx
        RidXhsvqy7bUokkquAbPA/wviSsi/ySCO+1K8p8=
X-Google-Smtp-Source: AGRyM1tOJG+ZOkWiXbVP0O7EWYeBB2jopBkge822HMizNJ9EyC7I18SKbDOaRKWGeddCEh7IiBDrhqMkRXDIRJQzNJU=
X-Received: by 2002:a81:8397:0:b0:31c:8a02:3f6d with SMTP id
 t145-20020a818397000000b0031c8a023f6dmr10762737ywf.486.1656964086779; Mon, 04
 Jul 2022 12:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <69a512cf5b62b34415d5983a6406c3d5ba438a1d.1656883851.git.jahau@rocketmail.com>
In-Reply-To: <69a512cf5b62b34415d5983a6406c3d5ba438a1d.1656883851.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 21:47:30 +0200
Message-ID: <CAHp75Ve5Z9OOx94FtXY77_Fwkp27D32Hn7bAG+Da++HXmupytA@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] iio: magnetometer: yas530: Add YAS537 variant
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 4, 2022 at 12:05 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> This adds support for the magnetometer Yamaha YAS537. The additions are based
> on comparison of Yamaha Android kernel drivers for YAS532 [1] and YAS537 [2].
>
> In the Yamaha YAS537 Android driver, there is an overflow/underflow control
> implemented. For regular usage, this seems not necessary. A similar overflow/
> underflow control of Yamaha YAS530/532 Android driver isn't integrated in the
> mainline driver. It is therefore skipped for YAS537 in mainline too.
>
> Also in the Yamaha YAS537 Android driver, at the end of the reset_yas537()
> function, a measurement is saved in "last_after_rcoil". Later on, this is
> compared to current measurements. If the difference gets too big, a new
> reset is initialized. The difference in measurements needs to be quite big,
> it's hard to say if this is necessary for regular operation. Therefore this
> isn't integrated in the mainline driver either.
>
> [1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c
> [2] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c

Much better, my comments below.

...

>         yas530,
>         yas532,
>         yas533,
> +       yas537,
>  };
>
>  static const char yas5xx_product_name[][13] = {
>         "YAS530 MS-3E",
>         "YAS532 MS-3R",
> -       "YAS533 MS-3F"
> +       "YAS533 MS-3F",

This is exactly the point why it's good practice to add comma for
non-terminator entries.

> +       "YAS537 MS-3T"

...here.

>  };
>
>  static const char yas5xx_version_name[][2][3] = {
>         { "A", "B" },
>         { "AB", "AC" },
> -       { "AB", "AC" }
> +       { "AB", "AC" },

Ditto.

> +       { "v0", "v1" }
>  };

...

> +       /* Write registers according to Android driver */

Would be nice to elaborate in the comment what exactly the flow is
here, like "a) setting value of X;  b) ...".

...

> +       ret = regmap_write(yas5xx->map, YAS537_ADCCAL, GENMASK(1, 0));
> +       if (ret)
> +               return ret;
> +       ret = regmap_write(yas5xx->map, YAS537_ADCCAL + 1, GENMASK(7, 3));
> +       if (ret)
> +               return ret;

Can bulk write be used here?

...

> +       /* The interval value is static in regular operation */
> +       intrvl = (YAS537_DEFAULT_SENSOR_DELAY_MS * 1000

MILLI ?

> +                - YAS537_MEASURE_TIME_WORST_US) / 4100;

...


> +       },

>         }

And this is for chip_info and comma for non-terminator entries (see above).

...

> -       ret = yas5xx->chip_info->measure_offsets(yas5xx);
> -       if (ret)
> -               goto assert_reset;

> +       if (yas5xx->chip_info->measure_offsets) {

This can be done when you introduce this callback in the chip_info
structure, so this patch won't need to shuffle code again. I.o.w. we
can reduce ping-pong development in this series.

> +               ret = yas5xx->chip_info->measure_offsets(yas5xx);
> +               if (ret)
> +                       goto assert_reset;
> +       }

-- 
With Best Regards,
Andy Shevchenko
