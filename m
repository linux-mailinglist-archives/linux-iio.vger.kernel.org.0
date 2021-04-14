Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1D435EE4D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 09:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349703AbhDNHY3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 03:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349682AbhDNHY2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Apr 2021 03:24:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAA8C061574
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:24:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so12053687pjb.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MoTMIqn2UFIQqdBg/1ROi88t6LW/CcewDIWj8jWPV30=;
        b=ELLw+Sy59LuERj0AnextS4+pp4+pecg+eQJuNfz7IIl4b6K9YdVnTPiohAHAgUqeyN
         KTd0CwL74t/uqFqi1qzintfqQs2nwMxxfuSk9M5b4y0R+RY8MZ4Wp50x/USDxGSBDdFD
         s34s4ZB98MmYtMZ6ci4nmIyGK/yLJBx86oAJ6YJsngPZnHTat1YVdYL9QYYDB2Mx3Mu6
         p5Mh6teGJ+Jckq45d3VKV4mhPywBFksjJOkzsgCxg0/T7tMpWw2ssqenBN1CLYPGV6Qm
         YfJwq0ykb562KIrhuw9Y+sV/4vXSAAIBTpXkgUmBfkHl54Oi/fnAkZH4KKU+rUXwD9ej
         eAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoTMIqn2UFIQqdBg/1ROi88t6LW/CcewDIWj8jWPV30=;
        b=EnA1sVrz29WDjhbQD+dn8QOu8Q9yZdRF8u6hZWVhCTNj1PejUAcppexIkcK2MlQJYr
         jhSicPRpqpxSPkK4jPUoWzl6gekfKCM6Dw3ojGer9HEuSQml6YXKogkUrSaYGlZGwsTU
         Gcj3ykrlMLq6bgUgJ9hL8Am3vzmatko6kB99zBNzRh9zrW1pBbVZCRDnNmqCArG0tjH7
         vBUdD4tYLIdHm/7ooqD6EP5FrxOX/czDfJ/3M4N5hS2Vel8jyp6UoN1yTIOJvriNdFr+
         oeaiQGKI9oQOvzw5iqIelVg5WR945gooCL9b4Y8j2Wy935wm+P4ROqRnIQ96y5RWPCYg
         zPQA==
X-Gm-Message-State: AOAM5301oMRZeTnPaA8lxZhfoKbumAk6qmmKEhJOgMxlAPsMW2gJhJF+
        mgR7gc8h5OWeiO1uDERgnXk0sp6aqlvChV4ADCrPkUmlMw/3RSyh
X-Google-Smtp-Source: ABdhPJyIuqN/iJPnylIL8aECXcvjovHsdScgseA/fidCMNt4+Yk0NVIJ5yi04a6ce3l6A6eP+P7Q4F6VVO1MT3q03S4=
X-Received: by 2002:a17:90a:ae10:: with SMTP id t16mr2189478pjq.86.1618385047250;
 Wed, 14 Apr 2021 00:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210413112105.69458-1-nuno.sa@analog.com> <20210413112105.69458-3-nuno.sa@analog.com>
In-Reply-To: <20210413112105.69458-3-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 14 Apr 2021 10:23:56 +0300
Message-ID: <CA+U=DsoLj3bO7yGeBbehU_2FUOp+GZ3o6x8XDeVrvPkXB878rg@mail.gmail.com>
Subject: Re: [PATCH 2/7] iio: adis16400: do not return ints in irq handlers
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
> On an IRQ handler we should return normal error codes as 'irqreturn_t'
> is expected.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Fixes: 5eda3550a3cc1 ("staging:iio:adis16400: Preallocate transfer message")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis16400.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index 768aa493a1a6..c2362a9ee3c3 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -646,7 +646,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
>         int ret;
>
>         if (!adis->buffer)
> -               return -ENOMEM;
> +               goto irq_done;
>
>         if (!(st->variant->flags & ADIS16400_NO_BURST) &&
>                 st->adis.spi->max_speed_hz > ADIS16400_SPI_BURST) {
> @@ -671,6 +671,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
>         iio_push_to_buffers_with_timestamp(indio_dev, buffer,
>                 pf->timestamp);
>
> +irq_done:
>         iio_trigger_notify_done(indio_dev->trig);
>
>         return IRQ_HANDLED;
> --
> 2.31.1
>
