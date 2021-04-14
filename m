Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6403335EE7A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 09:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347757AbhDNHei (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 03:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhDNHeh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Apr 2021 03:34:37 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FF1C061574
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:34:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id j7so4379301pgi.3
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyQINZBEFrvasRaLfouSHZNX7e5qiJA4+fxkT6SC2bk=;
        b=CZ5a4C2scltjRBPRITxh+B2OQZXWYDw8QDFIG0D4ebrKiA2OvF6IIIO+uNvSDjSF8/
         z51OkNYOot4AfwK0cCkfGuA2PEYhzj1n3lwek964D8KXM+sb+mxIvqnIYrh7p2FE4eaP
         MFxYja/t2fD2HhxycvLqHn0J7SNiz47cax2msOxcJgSuiBWb5uvSUDmAHSJAive4wjzk
         FDMQSLaKCb5XHzO+bA5L7/NLlng/Xm2s1IRXiqrRT9/vXdpUmAP1hlgUZcq1bsjyV+Fq
         gc0ynZmccqA8xQ4JoSUJzIgR/yefOGiMLLXypnJDOLx6m/GCHkkNOfv43y/ojXcpB7jV
         a+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyQINZBEFrvasRaLfouSHZNX7e5qiJA4+fxkT6SC2bk=;
        b=N3eNP7jI0h7K1HSc4v8VDPvmnhrrwOX55IJ8wOK+SjD/KQ+N8hUjd4img8cbqphonE
         6g8EG9mknTZRVjAvtZW/hhXfu8+j/6mGAjKfnf2mZAJ94N4Y6cglyvuwydFYuZGeq6Qk
         ekIRnOn1qe4z5rPfakzAuyJ4G2xZjBliGN+qyzlwIuJD79sUBOLLK1vYIjsJG7asrPCf
         golfFa7ygSpZzTGJawn3qMVwjymIvmvsFLiG/GbdBPuFKmNSYzxXCvwY8N1NcEJEswP9
         HwcuX+df8sI8d2T+95y2aZnwrMC5s1W6eTrOUeTBJ2JrDRjPlqvwZfTQI6fL+9ZAaEiH
         VGgA==
X-Gm-Message-State: AOAM532V/W36pHduR42Ukpdo9av0Kd8AnX23M+Wz1E3g06OqwaDlDnR4
        H30umWH8StowVxRDYYPZbkpAUVQAULOcqcyFddI=
X-Google-Smtp-Source: ABdhPJxipIr8S6q7P+8pDGKdKAf2lcFw+obPF2DZpqmY2ABWaDJU/vgQhJxIQ/i/fwnoU7PZD+zqRDTdrDa4SbQynXc=
X-Received: by 2002:a63:703:: with SMTP id 3mr36742635pgh.253.1618385655172;
 Wed, 14 Apr 2021 00:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210413112105.69458-1-nuno.sa@analog.com> <20210413112105.69458-6-nuno.sa@analog.com>
In-Reply-To: <20210413112105.69458-6-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 14 Apr 2021 10:34:04 +0300
Message-ID: <CA+U=DsoZx3q3_620hYVcaA6AoHq2b-JUJPpzn0+C3Pc+USru0g@mail.gmail.com>
Subject: Re: [PATCH 5/7] iio: adis_buffer: check return value on page change
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
> On the trigger handler, we might need to change the device page. Hence,
> we should check the return value from 'spi_write()' and act accordingly.
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis_buffer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index f89bce10090a..7ab15c08889f 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -137,7 +137,11 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>                 if (adis->current_page != 0) {
>                         adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
>                         adis->tx[1] = 0;
> -                       spi_write(adis->spi, adis->tx, 2);
> +                       ret = spi_write(adis->spi, adis->tx, 2);
> +                       if (ret) {
> +                               dev_err(&adis->spi->dev, "Failed to change device page: %d\n", ret);
> +                               goto irq_done;
> +                       }

The &adis->state_lock is not being unlocked on this error path.
This probably needs a bit of re-organization of this block:
    if (adis->data->has_paging) {
        adis->current_page = 0;
        mutex_unlock(&adis->state_lock);
    }


>                 }
>         }
>
> --
> 2.31.1
>
