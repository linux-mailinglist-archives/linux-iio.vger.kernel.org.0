Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A74348224B
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhLaFsL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhLaFsL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:48:11 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9867C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:48:10 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id u8so31866267iol.5
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Yvo7HqlmEPG7XIcBf166njFDaipoWpOXiDphoKwMSg=;
        b=YE7EiyMBX340CFvq/vlFKVSf5ZpJh/7pFvXUjs6CMPzq5dBjIp2LCN/V5VMmkcePh0
         8OzK7zhhiWDTKKg8y5dAnNs/XUBdt2yWiG7V0CP5gwqz+bI9pEpneMM71Gkrv5pVK+cN
         PTOCKEfyXhqP8Es9Z8HfrpimSs7awmKlx3rUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Yvo7HqlmEPG7XIcBf166njFDaipoWpOXiDphoKwMSg=;
        b=8MH3IYcKYentqdipxzKNoBUkd0TKH89ii9oTJ5rqF40mECqEVQI7gPxhdUHiZnewge
         YfMUYKbn8IJD4wbUBWYrheLuUxZEuWY+FCJb3byYKtxP3OW2eXIJ24N0alR2Fe2v/GrV
         GcAxty6QkSnMqTHwuU+pYjZBrtMClME1gzpOZTOiRUa5zElbVfJdzcViF4HPBl7jk/G0
         h1ABthHh/zDapuddCHWhBurw+XEfZP7OshnGDNFyQW5Xu7+431f/uIy0EhzVQJQPbDxh
         pWdLVIzdRQEHiI8HrloGBuiieLitqc2zQ7giF2aXJtA8OEcSkKn69dipkCLfYswI0Umg
         mIaw==
X-Gm-Message-State: AOAM532qKnQKTf4Z7x1DPjP4CgTg8TfGwflR/qMLO7RSL2weFayOXtYs
        Jn/xmgdqyhEueQDb1Jncl36nLp4Sx82jYLtUMJPuUg==
X-Google-Smtp-Source: ABdhPJymhZ6dGj9pAXeiKxzMO97Ln0Y00y1IS5wZJdxKa6tKExH6Bnn9hQcr2zDWJykxA/79Zra7QT24k0vMNPqmG08=
X-Received: by 2002:a6b:e508:: with SMTP id y8mr14574996ioc.177.1640929690178;
 Thu, 30 Dec 2021 21:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-6-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-6-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:47:58 -0800
Message-ID: <CAPUE2usw8nu6sNiHAQHmFG+wNe5C5tzZXuFBC8V7AMtyL7+jDw@mail.gmail.com>
Subject: Re: [PATCH 05/16] iio:light:ltr501: White space cleanup of spacing
 around {} in id tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nikita Travkin <nikita@trvn.ru>,
        Maslov Dmitry <maslovdmitry@seeed.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The spacing in this driver was inconsistent so make sure we have a space
> after { and before } for the two id tables.
> Part of aim is to avoid providing examples of this inconsistency that
> get copied into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Nikita Travkin <nikita@trvn.ru>
> Cc: Maslov Dmitry <maslovdmitry@seeed.cc>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/light/ltr501.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 47d61ec2bb50..d1532ef5f08b 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1632,18 +1632,18 @@ static int ltr501_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
>
>  static const struct acpi_device_id ltr_acpi_match[] = {
> -       {"LTER0501", ltr501},
> -       {"LTER0559", ltr559},
> -       {"LTER0301", ltr301},
> +       { "LTER0501", ltr501 },
> +       { "LTER0559", ltr559 },
> +       { "LTER0301", ltr301 },
>         { },
>  };
>  MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
>
>  static const struct i2c_device_id ltr501_id[] = {
> -       { "ltr501", ltr501},
> -       { "ltr559", ltr559},
> -       { "ltr301", ltr301},
> -       { "ltr303", ltr303},
> +       { "ltr501", ltr501 },
> +       { "ltr559", ltr559 },
> +       { "ltr301", ltr301 },
> +       { "ltr303", ltr303 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltr501_id);
> --
> 2.34.1
>
