Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25602368DEA
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 09:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbhDWH24 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 03:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhDWH2z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 03:28:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC67C061574
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 00:28:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id lr7so6518197pjb.2
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 00:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7plHJlKPNoKopX08yJnE2dGZno2mijJNqH2KJ+YqsRk=;
        b=Gos8p3TckLYWwsUHdiBJFdx9Q2YwbH0h6O54/CmbckQsXiFsqnIYMDNWGLooD5QbNC
         ZcIONXn6bsBU1Ieq1Tmu4ilLHDbeo8yp4AIMOAiZ1Mo066QcQSmSZElRxWi6jQAoGwAh
         CxLwzQZYQSzB77Gj5dbjo4OklXtSsUGeg0fn6VQVDZVbJqGMhu0Eq0RwnNy/1MgGfVzi
         pfAjrAS7IJ8TThY9vSadncG+57YmRTuXvLtSqpl7AkVbNdDjh/R/n/d/p3cAXJHpCRSG
         rR/920bb4WXiVYZzsPhpbkPG/YmamAzKgqxPq4IsX/W8oA+xQ8n5a20wkcLaQI2mYA1n
         dRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7plHJlKPNoKopX08yJnE2dGZno2mijJNqH2KJ+YqsRk=;
        b=RUKLzoz7qXOxIQX0A6bbhzXiJquwcgt50VzeCierWedT77dNt69AFqp6RMQpKHgfLk
         RoAm/xnvtxhlwrTQte8k/FaUNhagyZTJkd9iAB5nIHn5fpxhvUYpVqWjllrvMbGzLhQH
         IIhNONpPIWGUMmVinHzvCQgIwYcMRU9d66tI7s6SDoIryJqAJZtukzH9u1OHoJ+Q6fzz
         0U91aTrViEkgvp1qx7Tk1wpRwzyFA+OSkqSdpzvODQ6vCLP/Q+fKdBxVPobIaQ9YXMfk
         4FGQj6TT6kwt3541Loy9s7FpBhQDRyHica8vXa6B4CvF6RF1g771bLCwFuFKjIaWX7mj
         5VCQ==
X-Gm-Message-State: AOAM530NvSUf2LSHT2WhSYWqC9hKFThLVKAVuHq2bo4Zsn0AqaIcqMpP
        2A0ZOG1wGMP5EEsrlwp3GGtt6S51BsnczJwgmx8=
X-Google-Smtp-Source: ABdhPJwA0nlsIaL7I2aSBIpft1IIlR3tr0oKGVlN/6uRbjSY2dAbg1quQleZE2xMuIp0tcDsH2dPWpaZYtZa1Eh9GhY=
X-Received: by 2002:a17:90a:d352:: with SMTP id i18mr4465115pjx.19.1619162899431;
 Fri, 23 Apr 2021 00:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210422101911.135630-1-nuno.sa@analog.com> <20210422101911.135630-6-nuno.sa@analog.com>
In-Reply-To: <20210422101911.135630-6-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 23 Apr 2021 10:28:08 +0300
Message-ID: <CA+U=Dsq-8bggBJtTi5dkq9LrKpweyCSzZ4nisuDJ3doPu37FTg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] iio: adis_buffer: don't push data to buffers on failure
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 22, 2021 at 1:17 PM Nuno Sa <nuno.sa@analog.com> wrote:
>
> There's no point in pushing data to IIO buffers in case 'spi_sync()'
> fails.
>

Overall, this feels like it's adding some duplication.
However, short-term I'm not seeing a considerably better way to do this.
Maybe, this would require some refactoring of the
adis_trigger_handler() to handle the paging logic a bit more
elegantly.
But that's a broader change.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis_buffer.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 0ae551a748eb..a29d22f657ce 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -144,9 +144,12 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>         }
>
>         ret = spi_sync(adis->spi, &adis->msg);
> -       if (ret)
> +       if (ret) {
>                 dev_err(&adis->spi->dev, "Failed to read data: %d", ret);
> -
> +               if (adis->data->has_paging)
> +                       mutex_unlock(&adis->state_lock);
> +               goto irq_done;
> +       }
>
>         if (adis->data->has_paging) {
>                 adis->current_page = 0;
> --
> 2.31.1
>
