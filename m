Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECB42D7119
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 08:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbgLKHtS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 02:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436827AbgLKHtL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 02:49:11 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3479C0613CF
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 23:48:30 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id d9so8553579iob.6
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 23:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLRqCbFeSjLxy1AivaHBHXaZ8NTeW/wO87Z1jDHRIEA=;
        b=Ln6Ub0MfpQKZ+z93dX3/mFFaawYrBtkvjoq8LZLl5y1HPYTOWTU+w/HYOF3Gflzykx
         AeBVDY4263+avWp/3JhjjD62qJnRYYEvKpYA95ui9ngdWApgrPUwMDf8LjGGAyx4A6m/
         UOdJZmMQoYPfWH2hQHh35K17uUgApaWvKJfWT5PRrlbfzi2YBCsvDSMXDCzlZ58yG9Jm
         QjXJDYtcb/+f52xn67jS9jdffOFUg8YOemqozi66LIVJJ8mgwanqE6sD0FIoyH+3/S/Z
         zikOJXvMZ95VuC29aA7jUw4xJdjPzCB5biZFm1R6MImm6BsUe9D2H3Iwq9DtdMaLnonH
         lnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLRqCbFeSjLxy1AivaHBHXaZ8NTeW/wO87Z1jDHRIEA=;
        b=qFF2Q0+gp5RSkSqGnJK6U0fq49WIClN/32zDqKfU/ycM0wCIpElnKRdx+9AWYA1AYF
         grAHeYJOQWFh+Qv4uN60FY5AnQIp7q1QYQQ9/pJGtyUf3pN3cUEtkJ/h25gfia5EYX+e
         76W4gyAhggj3aYb1x7hbwZtoN6+3Mhbmq2ebF8GT+PXMR7CEknr4z6PDtFdM1IbrvcxG
         IqKJkyOBMVYNmdIFTjkXa++Eexv2PjsQltTvzqKiYRAsZPsoHul2HJSug5/qdY0rIQJx
         6NI0v2SvOn/WQsvSbzYtosDkji0NnDxAVZMWMqec0tfl1duMLO21sE7NR7hehgfySfVz
         xVKQ==
X-Gm-Message-State: AOAM532DornRMn0od8PBzJmoLBP6uMUfy90Hp85wOBrnaWKF/0G/36q8
        eLiyNefKAx69IYD+uKO8bnShtXZhQ6vN1mdvE3M=
X-Google-Smtp-Source: ABdhPJw6b62qU1vpNimX5c4FUax1mVT+Rr1sxkJQs8ezHk2xyb0TZRH3EEBCNtH+reoK/ekVAzNGVaU2HkQjtadYqls=
X-Received: by 2002:a5d:9507:: with SMTP id d7mr13398841iom.32.1607672910392;
 Thu, 10 Dec 2020 23:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20201210204211.967018-1-gwendal@chromium.org> <20201210204211.967018-4-gwendal@chromium.org>
In-Reply-To: <20201210204211.967018-4-gwendal@chromium.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 11 Dec 2020 09:48:19 +0200
Message-ID: <CA+U=Dsp66nwx_ifP03yHm3Y1MicRHkXpiEFAH-Bx_HJ3Av6PnA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] iio: adis_trigger: Remove code to set trigger parent
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 10, 2020 at 10:42 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Already done in boiler plate code.

Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/imu/adis_trigger.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
> index 64e0ba51cb18..0f29e56200af 100644
> --- a/drivers/iio/imu/adis_trigger.c
> +++ b/drivers/iio/imu/adis_trigger.c
> @@ -27,13 +27,6 @@ static const struct iio_trigger_ops adis_trigger_ops = {
>         .set_trigger_state = &adis_data_rdy_trigger_set_state,
>  };
>
> -static void adis_trigger_setup(struct adis *adis)
> -{
> -       adis->trig->dev.parent = &adis->spi->dev;
> -       adis->trig->ops = &adis_trigger_ops;
> -       iio_trigger_set_drvdata(adis->trig, adis);
> -}
> -
>  static int adis_validate_irq_flag(struct adis *adis)
>  {
>         /*
> @@ -72,7 +65,8 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
>         if (!adis->trig)
>                 return -ENOMEM;
>
> -       adis_trigger_setup(adis);
> +       adis->trig->ops = &adis_trigger_ops;
> +       iio_trigger_set_drvdata(adis->trig, adis);
>
>         ret = adis_validate_irq_flag(adis);
>         if (ret)
> --
> 2.29.2.576.ga3fc446d84-goog
>
