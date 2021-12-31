Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05644482247
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhLaFpn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhLaFpm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:45:42 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6827DC061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:45:42 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e128so31869172iof.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlrfCCv3HazGowQhgGTZ8VgVoGCf1ssta3SxB52sGhg=;
        b=YcbaERGhB4yimB6oCTv4C0xakMwg3irH3q5WG/dv3UwXgpe3xl9nNMuljA4A4sK8dd
         kv1CX2cO9fI+N9e3rMw1tQhYv3HJlAy4FE9VYgAg/gEvUkos7eH7Ici83CnaNlsj0A9g
         C8IltqHyE7DyHmJHXy4sNKTRiS+QNgWZJyBGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlrfCCv3HazGowQhgGTZ8VgVoGCf1ssta3SxB52sGhg=;
        b=6kpGc6Vui2HIUgWIbfKYXCKxbSNNaqHvXUVhrcPX8nk+Hm51BlO3WKeP2LKV+tGrT6
         /eb7uwIzFgB6gImomFrruc8IkX5562p+tJDsIx9ep9jMpVK0HNTfkZ6x+w1JYTvmLZix
         3lYDNen9ubfrL/xXw95x48JU2dV7S4vqgixT1h3ih4mlEImekKtIKSe/tCaUYAp37pc6
         3JRxdNLIryu6yQRbLJj2QVcosm2Eo36UiJ7wi/FAKZKfC/aRUkxMDMZlZA0NK9n4yihb
         DZoCglgReMVe0bx8ht8wky68qPUE2xWDgB8cAOf5F6nNTbewko3nvoa1Ros3JDmHhDlF
         eScw==
X-Gm-Message-State: AOAM5306JAYItmDom//5EG7Z11TH6vHPfDFfHmW+RQ3R+2d7oii+Uj70
        Qq1y7UNBp7ga2zXAntB3AhSRSYYwz6v/P1D16ptqWQ==
X-Google-Smtp-Source: ABdhPJxjw8AXfU7zZct8OGCV3rC4HbISCdRQzmX4MPx4rp6qYIYJfGARn226Rzo2ExrJTVy5xGfcLMX/YpK4k3JdgEA=
X-Received: by 2002:a6b:dc10:: with SMTP id s16mr15263524ioc.131.1640929541803;
 Thu, 30 Dec 2021 21:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-3-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-3-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:45:29 -0800
Message-ID: <CAPUE2usM+c5DFzGthtL1WGjeYgu8UraSLpeaK8SF-mGY1Hjmfw@mail.gmail.com>
Subject: Re: [PATCH 02/16] iio:light:pa12203001: Tidy up white space change to
 add spaces after { and before }
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
> One case in here was inconsistent and was main focus of this patch.
> In that case there was a space after the { and none before the }.
> The second case was then inconsistent in having now spaces.
> Change makes sure there are spaces.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/light/pa12203001.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
> index a52b2c788540..528fa5dd2b13 100644
> --- a/drivers/iio/light/pa12203001.c
> +++ b/drivers/iio/light/pa12203001.c
> @@ -452,14 +452,14 @@ static const struct dev_pm_ops pa12203001_pm_ops = {
>  };
>
>  static const struct acpi_device_id pa12203001_acpi_match[] = {
> -       { "TXCPA122", 0},
> +       { "TXCPA122", 0 },
>         {}
>  };
>
>  MODULE_DEVICE_TABLE(acpi, pa12203001_acpi_match);
>
>  static const struct i2c_device_id pa12203001_id[] = {
> -               {"txcpa122", 0},
> +               { "txcpa122", 0 },
>                 {}
>  };
>
> --
> 2.34.1
>
