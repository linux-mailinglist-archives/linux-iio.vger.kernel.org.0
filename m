Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFE3482257
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhLaFtq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhLaFtq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:49:46 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF67C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:49:45 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id 19so31281099ioz.4
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RzQqh9cswy8IbQyehJ1D8uKH+CR3njWvzlKw8pCqZME=;
        b=MrJGPGNj59tWQrCXJtB23TF9rc9ydIrAvmeq0bJoK1DQSrZYHwe0s5MnugZWNxemac
         aJX+S/4y4V8tZ6UdaS+pYt+Tzpl4s11xDYJk4FRitHx3BXcBrHXR0hSFftbuyWYEpJoc
         v3KCrpGKLxfl4bVt/fRhlqFiXUEO9efRFJ7fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzQqh9cswy8IbQyehJ1D8uKH+CR3njWvzlKw8pCqZME=;
        b=tburzvinQp8j4UfMlKSqTirpszR6YFzqaTao1jhMX1g4yw2P/I73e4fG81EZvvnUr/
         j4XEot28Pi9urhXUv63jEK0RRLptaUyoxcP4sEET+BC00jkoDo85lQVcz7krYbTlhsFP
         UUDuzt99ZvQxILVrlj3mMFHplScWFbpod6DmYXJyhsjKsBYPrzSTmR9hUgRrZ06qjKj9
         ad7GJDkC4b82T9/UHW69T7QVitc7zwzva9wLonBEdtVEXZtiOd3AAW0tF1Cpi95L64vn
         qbGc4M3exPBeaImFsZt6c8OAWzs39KJqT+6rW1XXbYCWOzzRiPjRbHjvYRUJceKb83uP
         gt7w==
X-Gm-Message-State: AOAM532/OReydgZJyTvjrrNZOsTC9F672IpFhO+QOF7VcTl6GDefOY4d
        aBBxWnrgMIjOkv9mtw4TbXC7mK37OJwBKEvKXdInjg==
X-Google-Smtp-Source: ABdhPJx/CxWSMOaykgbPuZhuMpjSlkPwwcyNA/6UpU1w65sO0dHSy4TcXBDi8PTjmhyAxAh6ECUbjjWIIKcBUVetzPA=
X-Received: by 2002:a02:2aca:: with SMTP id w193mr16115885jaw.240.1640929785035;
 Thu, 30 Dec 2021 21:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-12-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-12-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:49:33 -0800
Message-ID: <CAPUE2usPuEH-j5Hu8fy2n=VcRbw-Z_yk2AcNpVkOKdBjz4q2mA@mail.gmail.com>
Subject: Re: [PATCH 11/16] iio:adc:mt6577_auxadc: Tidy up white space around
 {} in id tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Hui Liu <hui.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Previously inconsistent with space after { and not before }.
> Tidy that up to avoid providing a bad example to copy into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Cc: Hui Liu <hui.liu@mediatek.com>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/adc/mt6577_auxadc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index d4fccd52ef08..327fff96c6c8 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -330,11 +330,11 @@ static SIMPLE_DEV_PM_OPS(mt6577_auxadc_pm_ops,
>                          mt6577_auxadc_resume);
>
>  static const struct of_device_id mt6577_auxadc_of_match[] = {
> -       { .compatible = "mediatek,mt2701-auxadc", .data = &mt8173_compat},
> -       { .compatible = "mediatek,mt2712-auxadc", .data = &mt8173_compat},
> -       { .compatible = "mediatek,mt7622-auxadc", .data = &mt8173_compat},
> -       { .compatible = "mediatek,mt8173-auxadc", .data = &mt8173_compat},
> -       { .compatible = "mediatek,mt6765-auxadc", .data = &mt6765_compat},
> +       { .compatible = "mediatek,mt2701-auxadc", .data = &mt8173_compat },
> +       { .compatible = "mediatek,mt2712-auxadc", .data = &mt8173_compat },
> +       { .compatible = "mediatek,mt7622-auxadc", .data = &mt8173_compat },
> +       { .compatible = "mediatek,mt8173-auxadc", .data = &mt8173_compat },
> +       { .compatible = "mediatek,mt6765-auxadc", .data = &mt6765_compat },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, mt6577_auxadc_of_match);
> --
> 2.34.1
>
