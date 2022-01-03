Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB8D483749
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jan 2022 19:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiACS7F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jan 2022 13:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiACS7E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jan 2022 13:59:04 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AB9C061761
        for <linux-iio@vger.kernel.org>; Mon,  3 Jan 2022 10:59:04 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id s6so32476877ioj.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Jan 2022 10:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cp1QaAmgh1jSP2p9lfwV8AUochi5p5sTMh6Mpnzz0ME=;
        b=kEmsRndIuMT9Y3bxVJVacY9wrB9bKt37ZnJqeuR1v7v2cq95p9mcT8Ye+4XunQWyDa
         8p2C25LHzeDhrRHdCopq0xwCTOLRfo4iRkTZ6lzIX2wpkTkk4mpqkKGlcQunigXxnZWE
         3hrMbnuDEG41begk5Qnsrvo/sws6VHrRE3Im8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cp1QaAmgh1jSP2p9lfwV8AUochi5p5sTMh6Mpnzz0ME=;
        b=WZaRXRTK0JOBEd0XTv8rajD3IqynxT7e0R5DVxUNd4WjDM7bUb0nmw8hc6MS1UiB7a
         UvL2chYYX2KaXDgIkar84hRYnEqyOS1o/Nr3Dh0OQ/wRFggxAEZ4HQMObUD8L8QRICLQ
         KqPe8Qw6f3PUIVhqvuZUYjeFOSI5MR5cgRf2eFK49l1YQcGFQb+C6tD+hBgLevthU4ql
         HLUjgkB8iaHzoTMDOLVCwlWTayS5R89y7LuT5liFFVGeDwLeZaUR1kqArwSu0sI7NVVe
         XvcjA2Xc8CinPcnYz5IBv7L82s5gIpKAHV1S063Xcz6/STJNiti4Nvf1P7lG9xXRDiR8
         wWWw==
X-Gm-Message-State: AOAM530hTQq9DANU9ANRCo1kGdrb1aSIYF4OdE3AIBvFmy6uDczvZQIK
        KNm4rg9BRhlJqrt5KNNab7dlpxsMkbmSX0cqi0S7Hfuy81DV0g==
X-Google-Smtp-Source: ABdhPJwu6SjZMn4dw+xtlpxet3DVL6+tyMZ/GZ6bfZwcoFJ8LEPEA74bhOck5X6FIfwXsDlL66t/PevW0nkX0xZSRmA=
X-Received: by 2002:a02:ba8b:: with SMTP id g11mr20641446jao.20.1641236343572;
 Mon, 03 Jan 2022 10:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20220102125617.1259804-1-jic23@kernel.org> <20220102125617.1259804-43-jic23@kernel.org>
In-Reply-To: <20220102125617.1259804-43-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 3 Jan 2022 10:58:53 -0800
Message-ID: <CAPUE2uuW2dB44grme2T2yz+fhR9CFb+ZDm0FVykysebKTjA=Gw@mail.gmail.com>
Subject: Re: [PATCH v2 42/51] iio:proximity:sx9500: Switch from
 CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 2, 2022 at 4:52 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based config guards.
>
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/proximity/sx9500.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 3e4ddb2e8c2b..01bfd748d820 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -993,7 +993,6 @@ static int sx9500_remove(struct i2c_client *client)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM_SLEEP
>  static int sx9500_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> @@ -1030,11 +1029,8 @@ static int sx9500_resume(struct device *dev)
>
>         return ret;
>  }
> -#endif /* CONFIG_PM_SLEEP */
>
> -static const struct dev_pm_ops sx9500_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(sx9500_suspend, sx9500_resume)
> -};
> +DEFINE_SIMPLE_DEV_PM_OPS(sx9500_pm_ops, sx9500_suspend, sx9500_resume);
>
>  static const struct acpi_device_id sx9500_acpi_match[] = {
>         {"SSX9500", 0},
> @@ -1060,7 +1056,7 @@ static struct i2c_driver sx9500_driver = {
>                 .name   = SX9500_DRIVER_NAME,
>                 .acpi_match_table = ACPI_PTR(sx9500_acpi_match),
>                 .of_match_table = of_match_ptr(sx9500_of_match),
> -               .pm = &sx9500_pm_ops,
> +               .pm = pm_sleep_ptr(&sx9500_pm_ops),
>         },
>         .probe          = sx9500_probe,
>         .remove         = sx9500_remove,
> --
> 2.34.1
>
