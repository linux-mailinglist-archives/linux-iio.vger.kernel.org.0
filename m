Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACB026ACA5
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 20:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgIOSzd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 14:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbgIOSzP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 14:55:15 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8B7C06174A
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:55:11 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d190so5317120iof.3
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ta4Oa1PhsK36kQeVS379GIMX2BsNo07kyURb/oKcy1Q=;
        b=O6cMXUjBTqJQnsVoZQ+4H7apAdbWLc3Keq2dgcgeiHh1hltoFnKFk5S3nOMg6y8+/T
         t8faZmVS/2cWQHhZClpcwv3tPKzvWuROeKVTW7Nn2wUk7J6rLbaBz+W/y/nuHliz4zj1
         oGT34ONpaarYwYyIn5PMsNLozWp38riXeWDcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ta4Oa1PhsK36kQeVS379GIMX2BsNo07kyURb/oKcy1Q=;
        b=o7aw80RzTmfcswccvAI5axIC8wjOQBNAudSHIv6KaIXUEMuSi88xG1q4Aa0f/oIhMC
         7DRnko+p+azvKNaiWyu80nayf0npY7E/cygg9oFAZfkRv7sp8z1jpg5ynUJfAaXhQ5zj
         RNim7Uwh9iNN/WAO0iiCwT9Yl75iYebTuSrnaRaWY8iXMesCWkf30wX2SsSUy081BLrM
         PMz7oH4lcEybcb2K7r20oiyv13vNfgmitQF+EVrZCesoFxNR9S5QorFGjLYT0TuKKfy0
         oR0NndBeJD4oLjv4a5L1q1EiPq0a2UK5K504Gl4Sdj/anPVuAsKq2wPi6S6rlld5kJuX
         gltQ==
X-Gm-Message-State: AOAM532xZippoq06oyOd9QcpScbaJ8R/gO6l5mdG7U9HkzE9O/1yoZdw
        vcSXnj6Yfr/bl8SGDswmmr+RuCC4IKTCBb5rteDGDQ==
X-Google-Smtp-Source: ABdhPJwSbbDA7f3GGmsCvWpthj8p+IX7AVNdeARiw2C6P5vLTDu6LNTf1MLvNWB7no1sbm2Ez8n3WJAIuBLY01gjfzg=
X-Received: by 2002:a6b:3e41:: with SMTP id l62mr3371335ioa.166.1600196111228;
 Tue, 15 Sep 2020 11:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200910173242.621168-1-jic23@kernel.org> <20200910173242.621168-34-jic23@kernel.org>
In-Reply-To: <20200910173242.621168-34-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 15 Sep 2020 11:55:00 -0700
Message-ID: <CAJCx=gkG1rSS-WjFOPtUNeEBkKF0FHQ+JQ1B=sB=ji+RpZGYzw@mail.gmail.com>
Subject: Re: [PATCH 33/38] iio:proximity:pulsedlight: Drop of_match_ptr protection
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 10, 2020 at 10:35 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This prevents use of this driver with ACPI via PRP0001 and is
> an example of an anti pattern I'm trying to remove from IIO.
> Hence drop from this driver.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index a8e716dbd24e..c685f10b5ae4 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -13,6 +13,7 @@
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -360,7 +361,7 @@ static const struct dev_pm_ops lidar_pm_ops = {
>  static struct i2c_driver lidar_driver = {
>         .driver = {
>                 .name   = LIDAR_DRV_NAME,
> -               .of_match_table = of_match_ptr(lidar_dt_ids),
> +               .of_match_table = lidar_dt_ids,
>                 .pm     = &lidar_pm_ops,
>         },
>         .probe          = lidar_probe,
> --
> 2.28.0
>
