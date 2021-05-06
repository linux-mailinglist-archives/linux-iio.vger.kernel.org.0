Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8421B374F84
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 08:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhEFGr3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 02:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhEFGr2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 02:47:28 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D65C061574
        for <linux-iio@vger.kernel.org>; Wed,  5 May 2021 23:46:29 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id p15so3912733iln.3
        for <linux-iio@vger.kernel.org>; Wed, 05 May 2021 23:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xubTdfJTJ+J4Jlf8Dix0v705VxmUzQ3ow2l8MwXkYwc=;
        b=qOL02wetlgZnPaQ14R4/bg5OL3BSRHKk9WapSEV06kXEUGhs6FcTnZByOiPXj/b+x6
         axerfbACLsVho93RF1TWW3MZJabFdnzdO6/dDyVKB331g4rNiumlZ7J8wIoYY668Djfc
         +LDESwR/NZkkOPj3hOEj/9qXHgftrSxZQBHUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xubTdfJTJ+J4Jlf8Dix0v705VxmUzQ3ow2l8MwXkYwc=;
        b=hxu6OqbPB5luieSsS/QyPC289tO4TKhpAI/NkuwasKsMXGw/VAV7UowUvraf76ThtB
         SdsKRg4X2TJ/tJ9BRGy2847pY2RCe1grk4nA+JyJI8AAGpWgHEh14AzhmQZ54EKr2tM0
         Lj/wH+wDt12WrIkwKqCkLoC9YaN8d/62zePVniSAmqQkNnYjgmV0hafl14cDme8BRUTD
         U0bv6emInKXzCXznToY2FdQBGu8Wm05X0K6ooxzKCqWAtZtn98HX+OV/gP3q5h0vKWx0
         HzvxV7lfmigY5ljuxZ4ScItZmW0rowwFN6/f+8Sg9fCLvrDQHi6WBzxDb5+Fv3iw87IO
         xclQ==
X-Gm-Message-State: AOAM532QzZREJsr9mQBdQTM8oJvbWVtmTRM0Y9VHObGhba3EZeAxVTfd
        3Nt0anoDR2QJnlEohJzHA4D7l171oSh8iUZfbqNVZNDYoabPM0js
X-Google-Smtp-Source: ABdhPJxFo3SX9YiO9lFLLRvtaOF5V8r6/3Aup9F74rFsiMOQ/B6zJeiuTqvqnN0d49qqUO4qRoqmO9HAdbiAH2ff8XA=
X-Received: by 2002:a92:dcc8:: with SMTP id b8mr2683789ilr.286.1620283589366;
 Wed, 05 May 2021 23:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210501170121.512209-1-jic23@kernel.org> <20210501170121.512209-14-jic23@kernel.org>
In-Reply-To: <20210501170121.512209-14-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Wed, 5 May 2021 23:46:18 -0700
Message-ID: <CAJCx=gkOSk1WNF_Xi_3w7L9x2ZN+r=MFkSMstrWshfhZKaDjZw@mail.gmail.com>
Subject: Re: [PATCH 13/19] iio: prox: pulsed-light: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
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
> Fixes: cb119d535083 ("iio: proximity: add support for PulsedLight LIDAR")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index c685f10b5ae4..822a68ae5e03 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -44,7 +44,11 @@ struct lidar_data {
>         int (*xfer)(struct lidar_data *data, u8 reg, u8 *val, int len);
>         int i2c_enabled;
>
> -       u16 buffer[8]; /* 2 byte distance + 8 byte timestamp */
> +       /* Ensure timestamp is naturally aligned */
> +       struct {
> +               u16 chan;
> +               s64 timestamp __aligned(8);
> +       } scan;
>  };
>
>  static const struct iio_chan_spec lidar_channels[] = {
> @@ -229,9 +233,9 @@ static irqreturn_t lidar_trigger_handler(int irq, void *private)
>         struct lidar_data *data = iio_priv(indio_dev);
>         int ret;
>
> -       ret = lidar_get_measurement(data, data->buffer);
> +       ret = lidar_get_measurement(data, &data->scan.chan);
>         if (!ret) {
> -               iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +               iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>                                                    iio_get_time_ns(indio_dev));
>         } else if (ret != -EINVAL) {
>                 dev_err(&data->client->dev, "cannot read LIDAR measurement");
> --
> 2.31.1
>
