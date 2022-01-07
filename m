Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016F6487A49
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jan 2022 17:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348222AbiAGQ1i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jan 2022 11:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiAGQ1i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jan 2022 11:27:38 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4986C06173E
        for <linux-iio@vger.kernel.org>; Fri,  7 Jan 2022 08:27:37 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i31so17314511lfv.10
        for <linux-iio@vger.kernel.org>; Fri, 07 Jan 2022 08:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ee5TfAm0O/7oOb78wyCjsPYvF8t2d2cn5OSORbvHz4=;
        b=lmfhs9Unvsa0JVwr+yaavqdMLXSMvPihFC7wUcl6yCbJcnP0sFhBerazGYto6B26Zk
         KK3OVtuvUihYmuzhn/qpgNTREg2O7nsPzH4kUhK8/9oczN33tSDJIgw5FxF5m+9BiSly
         OxxTOhmP8F8IrV3fMvbECCze5UKO5VBxfDPw+1Hqb07dM4OGoHvFpk3mBBhif9mg+fO+
         B835IdCFKazt6ho3NGidHRsNauOS2vpWWF4VtD7h5UN0pMBNbyCDBXaY94wmj2/spkvf
         60pheYdvVwpZ+v6ONxehFkPfz5mx/QnbeYVbo+8T01rcyyrpbXSxF5cm4iFJ0X4eQQnD
         eIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ee5TfAm0O/7oOb78wyCjsPYvF8t2d2cn5OSORbvHz4=;
        b=rRgiw8weG7Q+sJU47vNUweDgZkHN7icePsxIkNubahXiFrnBEEvtOsGRzrOJcgqBeR
         /AbZ0i9yIRbr56drK56Ks2ZYmjWmY6SkbGLp6EXJSfyxnaOCQUa7qgbkg9G4ycWbiGzI
         6SkfAY8GoxU0yG/kSz+5UFpfAchUGMjgQTUBAaP69IQr1Mfa4HhtbzQPb0Yy5+wW93Lm
         VSebsPIRtVfm7urxKRXkEDnzhhx2BSRL2JDuMVaYawIIl6AiAnYL3KBxCtoT/NcC0XP5
         QymGe0GcDxGmAjDQAIXph4JQ34LxGGuEupxrpP2RytTYAZ9b1Rttriv5KVxgljYvAC01
         O4KA==
X-Gm-Message-State: AOAM532TW6DLfWS8yxKrRgdgBD8ABFrO9TmeAJGW4qpwv6pUqf2xPadt
        LkzJk+8DGFWyxs+WEoC29memnazt9DplvISe6biCNA==
X-Google-Smtp-Source: ABdhPJxDUAV+onrE/eFRssYk5Hxo7+8TSlBh+dLnXGAN2nXCchIxKEPDtRv+bPiA77beRzI9qDcWSo60rl1Uw1PsG+8=
X-Received: by 2002:a2e:9659:: with SMTP id z25mr51179931ljh.16.1641572856161;
 Fri, 07 Jan 2022 08:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20220105182939.106885-1-paul@crapouillou.net> <20220105182939.106885-3-paul@crapouillou.net>
In-Reply-To: <20220105182939.106885-3-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jan 2022 17:26:59 +0100
Message-ID: <CAPDyKFppBN3R5pMx0MDhbn119+JeSdrduR5csNBMfRcT=f2pzw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] PM: core: Remove static qualifier in
 DEFINE_SIMPLE_DEV_PM_OPS macro
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 Jan 2022 at 19:29, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Keep this macro in line with the other ones. This makes it possible to
> use them in the cases where the underlying dev_pm_ops structure is
> exported.
>
> Restore the "static" qualifier in the two drivers where the
> DEFINE_SIMPLE_DEV_PM_OPS macro was used.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> Notes:
>     v2: Merge the driver changes to make the commit atomic
>
>  drivers/mmc/host/jz4740_mmc.c | 4 ++--
>  drivers/mmc/host/mxcmmc.c     | 2 +-
>  include/linux/pm.h            | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 7693236c946f..7ab1b38a7be5 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -1128,8 +1128,8 @@ static int jz4740_mmc_resume(struct device *dev)
>         return pinctrl_select_default_state(dev);
>  }
>
> -DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
> -       jz4740_mmc_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
> +                               jz4740_mmc_resume);
>
>  static struct platform_driver jz4740_mmc_driver = {
>         .probe = jz4740_mmc_probe,
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 98c218bd6669..40b6878bea6c 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1210,7 +1210,7 @@ static int mxcmci_resume(struct device *dev)
>         return ret;
>  }
>
> -DEFINE_SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcmci_suspend, mxcmci_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcmci_suspend, mxcmci_resume);
>
>  static struct platform_driver mxcmci_driver = {
>         .probe          = mxcmci_probe,
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 31bbaafb06d2..389e600df233 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -362,7 +362,7 @@ struct dev_pm_ops {
>   * to RAM and hibernation.
>   */
>  #define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> -static const struct dev_pm_ops name = { \
> +const struct dev_pm_ops name = { \
>         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>  }
>
> --
> 2.34.1
>
