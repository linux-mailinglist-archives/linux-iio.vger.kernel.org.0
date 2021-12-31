Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C29E48224A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhLaFru (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhLaFrt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:47:49 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC58C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:47:49 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id l3so29569236iol.10
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lsgRudN+nTzBf3hKzqJ2JNpBMAEnS0NNkPZdhTUTMGw=;
        b=K+FaJrp8bNV5y8xe68t8UWyyFSD+l6LcN3ALpfxQ1W81bA3YJrF6Bwhply/Fh0cL51
         10GC58APy2ULbCk3zRuBsMXsQGx4Xh5rZZKXLtb88f9j3d0gF5gx+vTNN4NmkZlnrFzH
         XrlkPHxdRyy37FzOsyBeUdZSlyp0jUzRe6kNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lsgRudN+nTzBf3hKzqJ2JNpBMAEnS0NNkPZdhTUTMGw=;
        b=to7vG9xqaQHUuls4LMN3FsPikIk7vPIaSe8LJhnccQHzs2tQAX/Q7hfXFeolnUKWsv
         8xfisJa9pvKI5rwXELLW47pSpHRfzixqZ8PmT4GSX82tCOSKaitLwYnzb4t9HbDzAnKg
         GHcJi6PXxhDIB75SGe0RZxI4sqt44ev/UPhIJU7Gz/j5QwPczLBW7jJ4rl1ttcRzhEUB
         X9AgmWHtGWkejmbNzC6VH7cCd7uR0l546je0kK/9EViU3QGSBGcdVgMleDg1UmUuDSPX
         3hMKGz/dGVmmP8DoZE4vqOngnnrjavToiUaArNmJ5ss1Bw7G016qilMR/X2xMg90Ph22
         GU8A==
X-Gm-Message-State: AOAM533JDPENFRKZ8XHJein7mVWGpIdcd80G2RQh4dwxGlKjUaxP8Is6
        omat81fyIAOCG/kO5yDqmGN2loNz7mL0y6dfitAhxBRC2g7qqQ==
X-Google-Smtp-Source: ABdhPJxlHNKh+hviRtzYMgqFQoym3Wv6WTGfyIh/YK9q9HyRqIp8t1PJPr3zJPYOvj9I0FYoVYNwr9xyb9cuC4D1J2A=
X-Received: by 2002:a05:6638:23a:: with SMTP id f26mr15570631jaq.222.1640929668950;
 Thu, 30 Dec 2021 21:47:48 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-5-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-5-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:47:37 -0800
Message-ID: <CAPUE2uvMLUMOMUi83bpm9CAJH5W1OMfj5iiFT4AwXpaNROBjug@mail.gmail.com>
Subject: Re: [PATCH 04/16] iio:light:us5182: White space cleanup of spacing
 around {} in id tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:43 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The spacing in this driver was inconsistent so make sure we have a space
> after { and before } for the two id tables.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/light/us5182d.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index 96e4a66ddf28..1492aaf8d84c 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -947,15 +947,15 @@ static const struct dev_pm_ops us5182d_pm_ops = {
>  };
>
>  static const struct acpi_device_id us5182d_acpi_match[] = {
> -       { "USD5182", 0},
> +       { "USD5182", 0 },
>         {}
>  };
>
>  MODULE_DEVICE_TABLE(acpi, us5182d_acpi_match);
>
>  static const struct i2c_device_id us5182d_id[] = {
> -               {"usd5182", 0},
> -               {}
> +       { "usd5182", 0 },
> +       {}
>  };
>
>  MODULE_DEVICE_TABLE(i2c, us5182d_id);
> --
> 2.34.1
>
