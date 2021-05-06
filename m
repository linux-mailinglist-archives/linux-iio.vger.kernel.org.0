Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D7374F83
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 08:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhEFGqw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 02:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhEFGqv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 02:46:51 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40AEC061574
        for <linux-iio@vger.kernel.org>; Wed,  5 May 2021 23:45:53 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z14so3894905ioc.12
        for <linux-iio@vger.kernel.org>; Wed, 05 May 2021 23:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TX6zI9Hl8SVHshqo9Dvl9Vv9MwLDBOUxe4BUuL/t6OU=;
        b=J7yrfnUq2mwLt6MrA5NGJZL2YOVWs37i9tboQC+PAVcgfiXDgQrsAR1dUFlO+buO2y
         HkwSg4ciWpDXKB+4S2xvhJv57YO/R8cOGphdMwHCwJJwdWdD8KRK5iplTpVYzgzkBBSb
         yJASkPZtsvIxiYUZdvdfuTdoSyOUyIT6RZlfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TX6zI9Hl8SVHshqo9Dvl9Vv9MwLDBOUxe4BUuL/t6OU=;
        b=Te8Ze7PDGBl0kcKp4r/WycfikxpaE72VfG1o3CqdVDtmjRi91N6vnhX95OuR5f4mZn
         2XqTHOoctYKZHZAfr9Qb8QteoZsK4USEi8wnyvF8+jKcxLo1m1Q1ypXTyLA7QSwos5nK
         JVmEkO0iLAGBo5H1Lgh63o7u1OOY7d3Vn7CpiWfu4Zs3VmwM0tq+AeptdgbXmy0w0DA5
         7MtSQzChAvkdkASmqvT8uf9gC2V/z56WfTR0Yg6VLP7TMYv0nlFCz2znwC5k0ZEXr+C7
         86BzZxduL+xY6FDlYjcwso1e2HZm0mciDba+/YzEwJAFhcPlmrDUowLDcwhNS+tnFpzX
         8hvA==
X-Gm-Message-State: AOAM53100pHKf4zzzOIBv9GfG80+wYvvMZ8lspMjlaLA3iGCUUxi3V8d
        SSgqGjhXoX+QDatrhJoGEkLaIScd9xtwAPZTRwMKLpjHFKQpqA/N
X-Google-Smtp-Source: ABdhPJy19+QXgvSb0SKdS17cRKMvUX2w1nnqQX18HWouHie6SLZ9Klr4juCp9qq2IeR6AzmZcuJQoZo6XnD0QAwP6AE=
X-Received: by 2002:a05:6638:3fc:: with SMTP id s28mr2439111jaq.117.1620283553389;
 Wed, 05 May 2021 23:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210501170121.512209-1-jic23@kernel.org> <20210501170121.512209-15-jic23@kernel.org>
In-Reply-To: <20210501170121.512209-15-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Wed, 5 May 2021 23:45:42 -0700
Message-ID: <CAJCx=gkE+UQLdkY5=Ead+6cJcJTrf2m1oO_7L6MJ4f8G5=haKw@mail.gmail.com>
Subject: Re: [PATCH 14/19] iio: prox: as3935: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 1, 2021 at 10:03 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> To make code more readable, use a structure to express the channel
> layout and ensure the timestamp is 8 byte aligned.
>
> Found during an audit of all calls of uses of
> iio_push_to_buffers_with_timestamp()
>
> Fixes: 37b1ba2c68cf ("iio: proximity: as3935: fix buffer stack trashing")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/proximity/as3935.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index edc4a35ae66d..1d5ace2bde44 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -59,7 +59,11 @@ struct as3935_state {
>         unsigned long noise_tripped;
>         u32 tune_cap;
>         u32 nflwdth_reg;
> -       u8 buffer[16]; /* 8-bit data + 56-bit padding + 64-bit timestamp */
> +       /* Ensure timestamp is naturally aligned */
> +       struct {
> +               u8 chan;
> +               s64 timestamp __aligned(8);
> +       } scan;
>         u8 buf[2] ____cacheline_aligned;
>  };
>
> @@ -225,8 +229,8 @@ static irqreturn_t as3935_trigger_handler(int irq, void *private)
>         if (ret)
>                 goto err_read;
>
> -       st->buffer[0] = val & AS3935_DATA_MASK;
> -       iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
> +       st->scan.chan = val & AS3935_DATA_MASK;
> +       iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
>                                            iio_get_time_ns(indio_dev));
>  err_read:
>         iio_trigger_notify_done(indio_dev->trig);
> --
> 2.31.1
>
