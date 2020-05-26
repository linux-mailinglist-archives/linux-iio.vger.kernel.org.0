Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EE41E2EB7
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 21:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390440AbgEZTb0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 15:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391236AbgEZTbX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 15:31:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70258C03E96D
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 12:31:23 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s18so9419333ioe.2
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DnCQ4lhG/YlYramaw4jbZFb6k6+oix6HHllYpDJH5TM=;
        b=UtwqVoUkoaR0/IG+IAuUWOLb+rGVK5ZgrvpCI9Flg17ZofTBZ1ng596vaqUvE3Ffzx
         7lH/8douPtqW3ExINsuvY+rahTcVc7pj9olk2hfqw0UyW+5UQ4c7ExeX9GRRI7nJfq97
         XaFv2szaHfOKAj6WTF2dFM4G5AtsE/epBelnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DnCQ4lhG/YlYramaw4jbZFb6k6+oix6HHllYpDJH5TM=;
        b=h4hLgFDlsW55vkltdAberXIKmdj1LZ36zyy6X4QHwz7eZdexy9CljPcViYMjxCneAT
         /ppYcJLxom6UuEfeis+E6siXDgpnLwM7a6r9+ekmo1Dk/2CkPtuuIuVzxkCEW6E3oa2U
         Ol62oLaJqBIWDOGawolQPvVPWbfLZIUZ16XzZtumVjxhwPAx/YC+lOf0n87c9jBZKX5M
         Ood5XQA28uIVRaEiUxlLpezsPvj0ozHP30IkaCicdvcReY/8vRu8jSWgffiOcBFcxWeL
         lcK60R0FYr3TNQ9kNvsrdIouD1M3nw7LTQr++Y11i/YiuFApTDEGZFFEzAaZHJP1zFyQ
         R+Ng==
X-Gm-Message-State: AOAM5322PBkTIg4wbrwRQdZsn+Tek1dh2wDgjM7RQm95e/Xm4eeb+6Pv
        vJxBIgKJ9c36sErCYfTNS9q1h4moOhy23F6UR6L7Cg==
X-Google-Smtp-Source: ABdhPJyWRdAwvnrcrWb9/2bGHNu3aJy7KyzXf//n491Fa8j8zyXQh9QBSQiyiStSe9GQrDIr+LVoFB3cuPFKAQ151rs=
X-Received: by 2002:a6b:3e86:: with SMTP id l128mr11755785ioa.95.1590521482734;
 Tue, 26 May 2020 12:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200525170628.503283-1-jic23@kernel.org> <20200525170628.503283-10-jic23@kernel.org>
In-Reply-To: <20200525170628.503283-10-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 26 May 2020 12:31:11 -0700
Message-ID: <CAJCx=g=cCucvub6-kPq5+tGu5M+J_LqJDwmDCoHj-aLUGQk6kQ@mail.gmail.com>
Subject: Re: [PATCH 09/25] iio:humidity:hdc100x Fix alignment and data leak issues
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 25, 2020 at 10:09 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data.
> This data is allocated with kzalloc so no data can leak apart
> from previous readings.
>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Fixes: 16bf793f86b2 ("iio: humidity: hdc100x: add triggered buffer support for HDC100X")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alison Schofield <amsfield22@gmail.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/humidity/hdc100x.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 7ecd2ffa3132..fd825e281d4f 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -38,6 +38,11 @@ struct hdc100x_data {
>
>         /* integration time of the sensor */
>         int adc_int_us[2];
> +       /* Ensure natural alignment of timestamp */
> +       struct {
> +               __be16 channels[2];
> +               s64 ts;
> +       } scan;
>  };
>
>  /* integration time in us */
> @@ -322,7 +327,6 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
>         struct i2c_client *client = data->client;
>         int delay = data->adc_int_us[0] + data->adc_int_us[1];
>         int ret;
> -       s16 buf[8];  /* 2x s16 + padding + 8 byte timestamp */
>
>         /* dual read starts at temp register */
>         mutex_lock(&data->lock);
> @@ -333,13 +337,13 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
>         }
>         usleep_range(delay, delay + 1000);
>
> -       ret = i2c_master_recv(client, (u8 *)buf, 4);
> +       ret = i2c_master_recv(client, (u8 *)data->scan.channels, 4);
>         if (ret < 0) {
>                 dev_err(&client->dev, "cannot read sensor data\n");
>                 goto err;
>         }
>
> -       iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +       iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>                                            iio_get_time_ns(indio_dev));
>  err:
>         mutex_unlock(&data->lock);
> --
> 2.26.2
>
