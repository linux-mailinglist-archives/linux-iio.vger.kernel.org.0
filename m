Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45C5482253
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhLaFsq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhLaFsp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:48:45 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A3BC061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:48:45 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id d3so12992807ilr.10
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emC7gGntIaDxBsti5L/zRBrO2SO432BNChBFbXwSg1k=;
        b=e5fs7KOiygH1Z/uAaK95zPl1RZXHsFfuIiehtrPCq5tIjdNWLmFN8/vkg2HnFo+Q79
         ge+CTRcYOXsZEW4KxWDmn0My8sR7pwGafnYPEGNpy1bY8gSzHw8MVE7gUxwpd4nxvKv2
         OgoMa+j0nKy9IPXZoc8Ztly0anOX74u2iU7Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emC7gGntIaDxBsti5L/zRBrO2SO432BNChBFbXwSg1k=;
        b=LNLV1GSCCWvMnUH+7N85nepaGvCtKVP7RHf7f4pJruM6vXshcznuy0IAIWCrUVCOcE
         Jp3uAUmXsHpIzFNpVbPBcMeOQTFKX9fD9zQpBMiuhAfQlAWk5W/6Nl2U548llN0CYUzG
         sMmAAocgVyJoAQPk1bCectyimZYqE5yjkL4QEMxOWFsyKV4BtumzGZ0MeEWTKQVTQETI
         RAhhn7bwZWRVMFcaR/kz634ID3I+44cv3ZOv0lI1Ttv1E61HSrV/aiNtS4QyWmMHmcAY
         JO7DHq+TUsfyt/+/OJuMYfFoYn0KmaYiwfimgSOKIsqv9tXXIbGkkzMX1/fed946z41e
         2jWw==
X-Gm-Message-State: AOAM531dsP7hoyiNig1kWe9CzdLJYIMPA5o0FNylTI51b574DfqiN802
        ZVnDfmIum6y+zJ6oiXOelg35b7IySX/sZNBNKezTaA==
X-Google-Smtp-Source: ABdhPJz8jIO6oiL0SD+go54xX1Z2Q7BN7YSMjmnJkesTOz2UCuSlN1RjVlZUuPr3+024IQ0JzfQUe3mhex16Ov9wL3c=
X-Received: by 2002:a05:6e02:17cd:: with SMTP id z13mr14783696ilu.299.1640929724808;
 Thu, 30 Dec 2021 21:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-8-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-8-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:48:33 -0800
Message-ID: <CAPUE2utPBJ5V8=ey_yNELG1X7OLKP+21QZrTLss8Dw+UyOVVKQ@mail.gmail.com>
Subject: Re: [PATCH 07/16] iio:proximity:rfd77402: White space cleanup of
 spacing around {} in id tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The spacing in this driver was inconsistent with a space after the {
> but not before the }.  Tidy this up to avoid providing a bad example
> to copy into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/proximity/rfd77402.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
> index 8c06d02139b6..0ae91963b570 100644
> --- a/drivers/iio/proximity/rfd77402.c
> +++ b/drivers/iio/proximity/rfd77402.c
> @@ -310,7 +310,7 @@ static int rfd77402_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(rfd77402_pm_ops, rfd77402_suspend, rfd77402_resume);
>
>  static const struct i2c_device_id rfd77402_id[] = {
> -       { "rfd77402", 0},
> +       { "rfd77402", 0 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, rfd77402_id);
> --
> 2.34.1
>
