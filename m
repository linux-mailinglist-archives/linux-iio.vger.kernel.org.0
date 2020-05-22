Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA14D1DEC31
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgEVPji (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 11:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgEVPji (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 11:39:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247C7C061A0E;
        Fri, 22 May 2020 08:39:38 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b12so4525395plz.13;
        Fri, 22 May 2020 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGfVO66NIASCYss1VEsqVK1IvyD8uVLJ356IsgZ5/h4=;
        b=rUnmae/cB1FrAueUUbajtueRyWOc2uhmANZ7vbtYHd/H0owx2++n9JnnZh3dEH95pA
         Ul6LmJ/+uvsDO0VVmB4QKrJ8pTsPs8rVhaRdp9FrDtP/AzRRVwoe8H0GB94w8cDwiPcA
         2tybCQCCryC3WVY70+aS3nVzDRNInkV0LCW/kOzDkgtathVVFbc5n2KiCNrRIXasn257
         VGhe8G8oi43rrdKLXljixWcvQchShYI977YYs8SgYAPdLLx7HkqmVFGu5TczHUGpKA6D
         aBTfA3udMFAaWU62XYPKR3bDQY///qD87GPtaj68+Vz51OhjlRv/4Ta6KfkLqIRF2dVO
         X++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGfVO66NIASCYss1VEsqVK1IvyD8uVLJ356IsgZ5/h4=;
        b=dQnx3a+AnWt9FMw6e417Ht9z3e4wOmGhkv0DbQrQ4KCwKS2EX74nwwu0POfz965tQR
         BuiHzSM7iLgbscUEBuHkA+b/B71ZGLbuFPUdgLnssGghQ0VNWXV8djc0USpKehpeMGGc
         xKSCdMYbXAcn70oV+Xm+++oct4JXESBZs+1UC+lvse1Nd3+t3tCu/tq1LtMNEIVLQE4p
         rS6WNL3XDXxoKxpjYXIFBQDvADHlXdR73dXOsmd6nPHy6UGHJKPeg76MFz96MlFB8Pu/
         g+t+clwK+FIDjP+W1LGs5R4EHX9/eXopzHjU/GenLwvbcg5qWVagrJAo3csBtMDg8jMY
         kc9A==
X-Gm-Message-State: AOAM533EVhvVyEDBF2+y93JV2Gvkk9bZO7E2EnnLgGZOvnSTUGrZ2qSj
        2bkzCVuM+FKwjyrADrZblMR0AvGVdrAe8O1b3ZY=
X-Google-Smtp-Source: ABdhPJy7ZsfZiErLwVjfyCmiFmRsFZFST+YwIMSHuHFuNfgjo3Komq6u9dkXOCjyyxp2eCLiiM2wMbaz51U544W/FfI=
X-Received: by 2002:a17:90b:3651:: with SMTP id nh17mr5293146pjb.228.1590161977685;
 Fri, 22 May 2020 08:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <1590157452-27179-1-git-send-email-jprakash@codeaurora.org> <1590157452-27179-5-git-send-email-jprakash@codeaurora.org>
In-Reply-To: <1590157452-27179-5-git-send-email-jprakash@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 May 2020 18:39:26 +0300
Message-ID: <CAHp75VcE9Q26HUn9cRH8TtjzCrFxSyu=J9XhT-m1Fs6=Gbh-8Q@mail.gmail.com>
Subject: Re: [PATCH V5 4/5] iio: adc: Update debug prints
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        smohanad@codeaurora.org, kgunda@codeaurora.org,
        aghayal@codeaurora.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 22, 2020 at 5:25 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
> Change pr_err/pr_debug statements to dev_err/dev_dbg for
> increased clarity.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

In the same way you should have patch with removal of ' < 0' parts.

> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index e1482fd..11eb97c 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -249,11 +249,11 @@ static int adc5_read_voltage_data(struct adc5_chip *adc, u16 *data)
>         *data = (rslt_msb << 8) | rslt_lsb;
>
>         if (*data == ADC5_USR_DATA_CHECK) {
> -               pr_err("Invalid data:0x%x\n", *data);
> +               dev_err(adc->dev, "Invalid data:0x%x\n", *data);
>                 return -EINVAL;
>         }
>
> -       pr_debug("voltage raw code:0x%x\n", *data);
> +       dev_dbg(adc->dev, "voltage raw code:0x%x\n", *data);
>
>         return 0;
>  }
> @@ -385,24 +385,24 @@ static int adc5_do_conversion(struct adc5_chip *adc,
>
>         ret = adc5_configure(adc, prop);
>         if (ret) {
> -               pr_err("ADC configure failed with %d\n", ret);
> +               dev_err(adc->dev, "ADC configure failed with %d\n", ret);
>                 goto unlock;
>         }
>
>         if (adc->poll_eoc) {
>                 ret = adc5_poll_wait_eoc(adc);
>                 if (ret) {
> -                       pr_err("EOC bit not set\n");
> +                       dev_err(adc->dev, "EOC bit not set\n");
>                         goto unlock;
>                 }
>         } else {
>                 ret = wait_for_completion_timeout(&adc->complete,
>                                                         ADC5_CONV_TIMEOUT);
>                 if (!ret) {
> -                       pr_debug("Did not get completion timeout.\n");
> +                       dev_dbg(adc->dev, "Did not get completion timeout.\n");
>                         ret = adc5_poll_wait_eoc(adc);
>                         if (ret) {
> -                               pr_err("EOC bit not set\n");
> +                               dev_err(adc->dev, "EOC bit not set\n");
>                                 goto unlock;
>                         }
>                 }
> @@ -724,7 +724,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>         channel_name = of_get_property(node,
>                                 "label", NULL) ? : node->name;
>         if (!channel_name) {
> -               pr_err("Invalid channel name\n");
> +               dev_err(dev, "Invalid channel name\n");
>                 return -EINVAL;
>         }
>         prop->datasheet_name = channel_name;
> @@ -767,7 +767,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>                         return ret;
>                 }
>
> -               pr_debug("dig_ver:minor:%d, major:%d\n", dig_version[0],
> +               dev_dbg(dev, "dig_ver:minor:%d, major:%d\n", dig_version[0],
>                                                 dig_version[1]);
>                 /* Digital controller >= 5.3 have hw_settle_2 option */
>                 if ((dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
> @@ -971,7 +971,7 @@ static int adc5_probe(struct platform_device *pdev)
>
>         ret = adc5_get_dt_data(adc, node);
>         if (ret) {
> -               pr_err("adc get dt data failed\n");
> +               dev_err(dev, "adc get dt data failed\n");
>                 return ret;
>         }
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With Best Regards,
Andy Shevchenko
