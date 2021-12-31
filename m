Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AB1482248
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhLaFqO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhLaFqO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:46:14 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CD0C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:46:14 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id y18so23522854iob.8
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCy/hsLT2swc+MEP1teFlpZm09MRTMb2dDscjsFex8M=;
        b=OCjARFwxvSi2pPc1e3yMnUymMJ3FHaKe+O6rd+p7nklB1qLMCMy+UTrFwXVv07QH6w
         IwgnrhxCFlRa5gPzmo+4zXMiB0W/8tyGO32uQx6D2tFjeeeuCVmTtP3HA+UuJ8QQA1bh
         jU4puCDeE+/mNO5WJR3ojuP4wmUFiZuIhQa24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCy/hsLT2swc+MEP1teFlpZm09MRTMb2dDscjsFex8M=;
        b=RU90u6Wmk5Fcq6wn0A658Ff93seQNEP+RXj0by6jkouDPwZUZDnAwDoGm5SCyCQQCw
         po6ttCK/oX6rcDOqVkf17Pxw4gt8ekbMw/x2pDI7s08U5XA5gnPr06vxMkPWxDYsIqrE
         t9NX+L3T01sdC52XB8eWGw7TaEWvktO3mSB1s55QQe1bNtD3gixkXZoKLoctaUqByJFv
         yq7f9B9wDXcsqdDjYVw9ZZe+giwueJJztxzCllVCcg+xPrAOeTgq5Yi1cp1Brub7T8Yd
         gpLfvq5xFw/WFXcrt7aI75+LW4O+8f/rsHBt3pPDo2kUZfPgEXQF31uNN8y553ZMotDw
         70Zw==
X-Gm-Message-State: AOAM531tuv4wJKB49ORoAry7pSUBBfyzMO8z2QVaUI06Dn6J7F/1n1vf
        kfWJYZeMoUAEZZMMOu8J7Rh03WTqpy9cI+BzY+sBnA==
X-Google-Smtp-Source: ABdhPJzqp4H0+A5GP8pJ73E06sCULJ+Kr0jcSuwlCxLZnvZ//3/QFYk9ESVioSyhYPednppT5Cd8W2tlXM4DzZfS1xs=
X-Received: by 2002:a05:6602:2d53:: with SMTP id d19mr15888031iow.77.1640929573342;
 Thu, 30 Dec 2021 21:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-2-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-2-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:46:01 -0800
Message-ID: <CAPUE2uvmjM6+qQDFG8faTDm=ZzzPD8LV9RL0p-pY0YW=X-gPqA@mail.gmail.com>
Subject: Re: [PATCH 01/16] iio:chemical:atlas: Trivial white space cleanup to
 add space before }
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:43 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Having a space after the { and not one before the } is inconsistent and
> good to remove examples that might get copied into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/chemical/atlas-sensor.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 04b44a327614..a8211dd20b35 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -589,11 +589,11 @@ static const struct iio_info atlas_info = {
>  };
>
>  static const struct i2c_device_id atlas_id[] = {
> -       { "atlas-ph-sm", ATLAS_PH_SM},
> -       { "atlas-ec-sm", ATLAS_EC_SM},
> -       { "atlas-orp-sm", ATLAS_ORP_SM},
> -       { "atlas-do-sm", ATLAS_DO_SM},
> -       { "atlas-rtd-sm", ATLAS_RTD_SM},
> +       { "atlas-ph-sm", ATLAS_PH_SM },
> +       { "atlas-ec-sm", ATLAS_EC_SM },
> +       { "atlas-orp-sm", ATLAS_ORP_SM },
> +       { "atlas-do-sm", ATLAS_DO_SM },
> +       { "atlas-rtd-sm", ATLAS_RTD_SM },
>         {}
>  };
>  MODULE_DEVICE_TABLE(i2c, atlas_id);
> --
> 2.34.1
>
