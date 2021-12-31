Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAD648225B
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhLaFuu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhLaFuu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:50:50 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F58C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:50:50 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id q6so20340299ilt.6
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qv7hT5Atsf6L0ZmrKkXVoUZ9jpQViJ7ZQLMtGJ/JLcI=;
        b=MUaH56OnIl4PHDT9ARsip90vPbMuMjf0LwOEDM5s78cICYjKV6p84IW4x8N4DzbX2k
         QRdCf4k0O3V4X6Hh8XXS1LMFS38ER4FpSmnd1mwyFI3lNfGhjppR5QX3CKlXSflkBRYe
         gZoHu+VM7Ic4w2lxW63J9doXlIKyxDfpwTJGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qv7hT5Atsf6L0ZmrKkXVoUZ9jpQViJ7ZQLMtGJ/JLcI=;
        b=mz7m5Xmakg7/Zub0qHh34A7ZVk2grwlaypP5d3o5VDBOyqIBz0WM4ZjaFjRiCO/Lxo
         PujrjbC7Phion95DyM6iQ6ioM5jZVLhzHlbrzQX46ZqhAXmyOo/gwygRlVW8x65FoXFL
         kj8MDb5E9gquSy2CQtbMDltkGd+b2sFrrcWp5+Nxq2/bUoXbepYYiC9jEHb5WM8eyGL6
         VHD/Yc2CccbSFkZGpVMfPCg0Zh8rWJj4jyn51VOBsDPCwB78ZBVQK07pmNlBbPbZ6fMq
         fU6RULXsnV8l03G1TtiSLMh3NUQmqLcAR+bJ1JNmr7GqQUDYG6Ir4l4/N7S5LbjhXdqO
         jv9g==
X-Gm-Message-State: AOAM533f0OZKqyICIYoEmXLPAzT8FFrmFi1s8oOV2QMR7QkJW80PoVzR
        lo7gnwv/Smig8gYbwUH3BwN244HeqkjUpmgqOcu7ug==
X-Google-Smtp-Source: ABdhPJyyk3rEJoJRZrcnVU8HQBcCGUQp1uEwVj9ORanlJW4/QCvqDgiMdYEJif0JZdGNJBR6M0SFyIW41S8cM7arSjA=
X-Received: by 2002:a05:6e02:174b:: with SMTP id y11mr15630090ill.214.1640929849650;
 Thu, 30 Dec 2021 21:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-16-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-16-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:50:38 -0800
Message-ID: <CAPUE2usk-d6v11NpDjbAWO_RCf6yGEw515+j36aiuUM1LTUZkg@mail.gmail.com>
Subject: Re: [PATCH 15/16] iio:proximity:vl53l0x: Tidy up white space around
 {} in id tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Previously inconsistent with a space after { but not before }.
> Tidy that up to avoid providing a bad example that might get copied
> into other drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/proximity/vl53l0x-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index cf38144b6f95..661a79ea200d 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -226,7 +226,7 @@ static int vl53l0x_probe(struct i2c_client *client)
>  }
>
>  static const struct i2c_device_id vl53l0x_id[] = {
> -       { "vl53l0x", 0},
> +       { "vl53l0x", 0 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, vl53l0x_id);
> --
> 2.34.1
>
