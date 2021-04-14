Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E9635EE89
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 09:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhDNHjY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 03:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhDNHjX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Apr 2021 03:39:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E231C061574
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:39:01 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so12054658pjh.1
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qbe2IWrL9Ux8M8pYpfTkyFR+mBZb7MJ884w1FUz2Z+M=;
        b=V7djZoMzrMjOClF2eVJqhDdrGj9WkD53F9mp27zEOkn+Mr4VDgRia5DYghWRjXYEhI
         g3Q79nDHsQ+YVTGsdy5JIwhCzFtfAc+rCJRy1YsI0TjCUSsK941J7fPUnfe6JrZip3D3
         k33tgbbWiMr++2LtrTbdwpObWlG4ygkAAL+9OnFcW8fKB3KAw3bW95AXf8XHLO2Ssr4X
         H9+lZeRzqQE3XiRsJb5EU7nItVNZG8BYLDz9ku1S22AAuP69gcdRGXrwnmFXgw+VZ4/9
         4dgDN7Ckw0YaoMO+laeLcnqEjaGEbKpJxAaS/GSdvy8R1yDRWBTKMobYVyoWOUBb/+Nc
         oF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qbe2IWrL9Ux8M8pYpfTkyFR+mBZb7MJ884w1FUz2Z+M=;
        b=LbUud+M3otkcOH8CLigw/EphhY9iv6lJZJv+9gmxZKdE+n4qh+M8v5VE+c1gxWG7VA
         kLM3qoIKBYaG63uJ1/AmA/nbwAdjKRV7e334zBrxc6GCKdhf+huioRMTcnnx5G+xxalG
         ahjLhPrpiJY/UCG1NiZfXLteDI2DW59uoDO6Ksjovdhu9ZuC89X/YlgHEXM7E6cjnQ+S
         G4kKDyQZIvxtcnPTEM4hZr05Xb6URVjTz6IereiZPOktaORFpufui3TI/R0BMmqs1Q0C
         j0QjN0e4/s7bVPXXMweDiECAeFGKfH/TSQtFSR5QKqAY1wpH9SjoSYedi6/12G7KKcSa
         vmIQ==
X-Gm-Message-State: AOAM530GGDtOlwa5Y01SsOq+KbyI3tH6BKFacAtaaoft9ZXLEO6IaUT1
        VKgWyIm6QkeByqUyqpsHyigDS0KVE0BX9qTrUfw=
X-Google-Smtp-Source: ABdhPJxSXzaH2getjziM6h7FXfSXVc1f7Iq+RS1PORtblk3VfeahVfcJKCYmMpvYa55aBlurbGOFTKn5+rr7SDx1I34=
X-Received: by 2002:a17:903:2488:b029:e9:708f:2e4a with SMTP id
 p8-20020a1709032488b02900e9708f2e4amr30891603plw.32.1618385940737; Wed, 14
 Apr 2021 00:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210413112105.69458-1-nuno.sa@analog.com> <20210413112105.69458-8-nuno.sa@analog.com>
In-Reply-To: <20210413112105.69458-8-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 14 Apr 2021 10:38:49 +0300
Message-ID: <CA+U=DsrBUFcwkO900StwY8-8W9fn3z+LZOaJ7YR=9qBQsFi_2w@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: adis_buffer: update device page after changing it
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 13, 2021 at 5:45 PM Nuno Sa <nuno.sa@analog.com> wrote:
>
> With commit 41f2770a07e0 ("iio: adis_buffer: don't push data to buffers on
> failure"), we return if 'spi_sync()' fails which would leave
> 'adis->current_page' in an incoherent state. Hence, set this variable
> right after we change the device page.
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis_buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 73790b71102b..aa37981c28f1 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -142,6 +142,8 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>                                 dev_err(&adis->spi->dev, "Failed to change device page: %d\n", ret);
>                                 goto irq_done;
>                         }
> +
> +                       adis->current_page = 0;

If the above spi_write() fails, this adis->current_page isn't reset.
Maybe reset this as the first thing in this if block?

>                 }
>         }
>
> @@ -151,10 +153,8 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>                 goto irq_done;
>         }
>
> -       if (adis->data->has_paging) {
> -               adis->current_page = 0;
> +       if (adis->data->has_paging)
>                 mutex_unlock(&adis->state_lock);
> -       }
>
>         iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
>                 pf->timestamp);
> --
> 2.31.1
>
