Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5714A47E5
	for <lists+linux-iio@lfdr.de>; Mon, 31 Jan 2022 14:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347959AbiAaNRZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Jan 2022 08:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiAaNRZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Jan 2022 08:17:25 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BADCC061714
        for <linux-iio@vger.kernel.org>; Mon, 31 Jan 2022 05:17:25 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 23so40267504ybf.7
        for <linux-iio@vger.kernel.org>; Mon, 31 Jan 2022 05:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfAaDdGjxPBBDUetpJ+oUxbsUd9gTe75eH5K8hXVhYc=;
        b=CiZpdvwDcR+8vgDqkc7zhLpVFr3TEna++KHNY0IOyIysw/yUmmXJY3s1PmIi8aCfbF
         KIN3nFLoHsBxb1swOBt6BEkjVsXbzT+Wjkqev85o7TGMGIaTOhpRcLIjw6kgFb29w/iY
         7oaJ6TuWZIYf5M3lnZHOs6le/fVCOoC6CNVLvctaipPd9mie16Jz6dj3z3zMSgy59erU
         cG/ATChFTpk+dtfKncUFMIjL+aJSlorfv4sIBcgjX4jtz4UKuExfXAMQ2z2pnVlNcR8w
         vrBpK9lWFr+Q4KM2/AjRvCIakVyjr4TsHD/bLQ1L0xEEHZ/anaLwbHRxAhfD3ij1nikr
         CTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfAaDdGjxPBBDUetpJ+oUxbsUd9gTe75eH5K8hXVhYc=;
        b=h5h6quyiWzQCeUQWLn7A7WtQtV9neNG/UqG7z/6iVpDM2vzs5I9MHAPTm55fficJSR
         9wJ5mwZ7HF3YZg8GNbfwdVnpl2Xzaxr1Dluofrdi0wfpnXRG2SHNZ/pe8fu+l19by97R
         IHFzSXwmcUPbFnlA8k0enC5nyoZEURrVP1TgnLO556TQ89nAeGqI5TySqh/iuixJfhDx
         iPeoSRoqwVDFBlVN0tYb/4EX4aod0gTHIjs6cRSEcQRP6OMlRxAaX0d4fTKOvtVSYGWV
         wOzhBHbc4LVChsAx6jMfaCLho3vJcBfRqmCozpH48A0FSy4Onnb1WSbuV/Whri1njLxw
         CbEA==
X-Gm-Message-State: AOAM532nJLxoIv2nWEWN+sp9HQThFvty81Lsu/CNA1Fbb4XngxIYfWhx
        hd0vEKcV4RVHSvXyKjVEWG3+08KyvrKflM5kG6WGcA==
X-Google-Smtp-Source: ABdhPJxvo4Pm3dgZOKWDtC15Eejg3tOuHSz3ANeH8lcLoxA+9xjm390Bi03MVwMersS8WbWGgCnNAffXRAVoqYQc1jE=
X-Received: by 2002:a25:3c8:: with SMTP id 191mr31465508ybd.204.1643635044376;
 Mon, 31 Jan 2022 05:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20220130193147.279148-1-jic23@kernel.org> <20220130193147.279148-43-jic23@kernel.org>
In-Reply-To: <20220130193147.279148-43-jic23@kernel.org>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 31 Jan 2022 14:16:47 +0100
Message-ID: <CAKv63uuacQkz1eBxc191Q87qEe_-GLwpRYYNRKJXxCsDObBucA@mail.gmail.com>
Subject: Re: [PATCH v3 42/50] iio:temperature:mlx90614: Switch from CONFIG_PM*
 guards to pm_ptr() etc
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reviewed-by: Crt Mori <cmo@melexis.com>

I don't have setup ready for a quick test of this, but it is
consistent with other changes.

Best regards,
Crt


On Sun, 30 Jan 2022 at 20:27, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Letting the compiler remove these functions when the kernel is built
> without one or  more of CONFIG_PM/CONFIG_PM_SLEEP support is simpler and
> less error prone than the use of #ifdef based config guards.
>
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90614.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index afcb10ea7c44..c253a5315988 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -600,7 +600,6 @@ static const struct of_device_id mlx90614_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mlx90614_of_match);
>
> -#ifdef CONFIG_PM_SLEEP
>  static int mlx90614_pm_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> @@ -630,9 +629,7 @@ static int mlx90614_pm_resume(struct device *dev)
>
>         return 0;
>  }
> -#endif
>
> -#ifdef CONFIG_PM
>  static int mlx90614_pm_runtime_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> @@ -648,19 +645,18 @@ static int mlx90614_pm_runtime_resume(struct device *dev)
>
>         return mlx90614_wakeup(data);
>  }
> -#endif
>
>  static const struct dev_pm_ops mlx90614_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(mlx90614_pm_suspend, mlx90614_pm_resume)
> -       SET_RUNTIME_PM_OPS(mlx90614_pm_runtime_suspend,
> -                          mlx90614_pm_runtime_resume, NULL)
> +       SYSTEM_SLEEP_PM_OPS(mlx90614_pm_suspend, mlx90614_pm_resume)
> +       RUNTIME_PM_OPS(mlx90614_pm_runtime_suspend,
> +                      mlx90614_pm_runtime_resume, NULL)
>  };
>
>  static struct i2c_driver mlx90614_driver = {
>         .driver = {
>                 .name   = "mlx90614",
>                 .of_match_table = mlx90614_of_match,
> -               .pm     = &mlx90614_pm_ops,
> +               .pm     = pm_ptr(&mlx90614_pm_ops),
>         },
>         .probe = mlx90614_probe,
>         .remove = mlx90614_remove,
> --
> 2.35.1
>
