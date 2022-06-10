Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69C9546836
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 16:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244605AbiFJOXj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 10:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349372AbiFJOXb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 10:23:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE10171242;
        Fri, 10 Jun 2022 07:23:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g7so1215884eda.3;
        Fri, 10 Jun 2022 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKRgCb2xcFyiy411BNa/ope94PUEMwt2spZr8HE4v0U=;
        b=bdOaYfUyy5jzTnTuwnR2OXlKv22nxyK+6Nt0hFIZp/RlIdQGUCPGINZO8vP0ki2Bkk
         BBOsxUvSHQqBmFpgMxb3E7dDeZ+1UFzlFRrSX41zzMRtulo2raDUWhz/1JXRfm2PzxU9
         K1L0VUZKvUOE0SBBSIDkwI0ah6IIU20xSuYWUDPUSmObLelNSWxDcc8q5SDQcz9Qrqem
         y0QCfU7IqAuAnKuxj3Y7xWefU2Bq5AaC++0NKeQarGicOLp+xYyH1vRoeSgxETz+0qNi
         cu5O7m2jY+HZTe4bdAb2J3e/fjHaSKuQlhKrfts3AAs+QQ8KNjvaslyrSQ8M4a/pwTVU
         8tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKRgCb2xcFyiy411BNa/ope94PUEMwt2spZr8HE4v0U=;
        b=UHsRifAJy6NlxXnzf1U81lCcRAGqcSsMGvhu2WfFvkipRDMK9dF3LH4xJ9UsV7EZcA
         uS7VO6rox49rvZCjUmSf6hnwCcI+eMDhIueACndY9Z/S6AdgB2wDKtdqsLwigx9UwxEa
         Li5ggd1Pr5D3kFxDR7ssgqpifzw5SMoYShjc0Sp4olFJzTsamEmvE6d0DdtHfVdYNBCB
         GevGltCXRJbdFwEOdSHXx5nCEa2SlAaJ0JBv2/st4tN7PhGEMoJUUghW3IBHcNa4xsZO
         dRK0qGQRLKN+zoAIdvPL3OONA0ilh46P6lFiRO3T8LW4LJ4jQu3R5Hu4P4qe9laOvNJ4
         gwMw==
X-Gm-Message-State: AOAM5322U9OAL2YMvfEQY2rNklxxFEMA0QyyD7K5pftDFshNGCA+BmED
        PaG+PRhtEFARY0IRtBpisf9vwL7SNAVALTIAolw=
X-Google-Smtp-Source: ABdhPJwhQWkPmhct0TtCTIvWUZdcahmYfpMSS7N4CR8HQ6v1y8GxJiJUc+XYvn8t1HfM0FODQ1DtS+/lLWh+ERrd+1E=
X-Received: by 2002:aa7:c396:0:b0:42d:8b86:a8dc with SMTP id
 k22-20020aa7c396000000b0042d8b86a8dcmr50346702edq.54.1654871000622; Fri, 10
 Jun 2022 07:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654727058.git.jahau@rocketmail.com> <1b6e152e1dda138c68ea8c207e46f91337989d35.1654727058.git.jahau@rocketmail.com>
In-Reply-To: <1b6e152e1dda138c68ea8c207e46f91337989d35.1654727058.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 16:22:42 +0200
Message-ID: <CAHp75VdBgPT_iMopU0bQ2Va1UtyDsiMnxfUfzb_knkXMEaLO+Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] iio: magnetometer: yas530: Change data type of
 hard_offsets to signed
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>
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

On Thu, Jun 9, 2022 at 1:44 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> The "hard_offsets" are currently unsigned u8 but they should be signed as they
> can get negative. They are signed in function yas5xx_meaure_offsets() and in the
> Yamaha drivers [1][2].
>
> [1] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas.h#L156
> [2] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L91
>
> Fixes: de8860b1ed47 ("iio: magnetometer: Add driver for Yamaha YAS530")

The series should be organized like this:
1) definite fixes;
2) cleanups / refactoring;
3) new features / documentation.

It will give a maintainer easier times to handle it.

Code looks good to me.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index 2e8d20b05217..9bfb3b573907 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -133,7 +133,7 @@ struct yas5xx {
>         unsigned int version;
>         char name[16];
>         struct yas5xx_calibration calibration;
> -       u8 hard_offsets[3];
> +       s8 hard_offsets[3];
>         struct iio_mount_matrix orientation;
>         struct regmap *map;
>         struct regulator_bulk_data regs[2];
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
