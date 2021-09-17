Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C84F40F3CB
	for <lists+linux-iio@lfdr.de>; Fri, 17 Sep 2021 10:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245568AbhIQIKd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Sep 2021 04:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245279AbhIQIKX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Sep 2021 04:10:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B32C061796;
        Fri, 17 Sep 2021 01:08:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y8so8446259pfa.7;
        Fri, 17 Sep 2021 01:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m52x3jUpVmY1V020n+TdYZWzz+BP2ZGTjxgbxuVV3E8=;
        b=hw6GllV6AGFer+dlvuKslXlsCgnBj5NMWXx78fzz7MngbFUOaM01ZwOGT/Ed9ydzm/
         mYAgq+jMZN808uSqCo+rEjcHMfMEjy9Pq/OiVe583ghlHFgkzeBheT4zKPKatD4hK+y4
         dJgvw8WdqPX/ctg/seawAJtnHaIdXcHY8b41nkIA2xH1MdlXGUR1NUXApFrxq8KB/rEx
         /71gUb0yedwk7dngAzU+YEtbpUd+UTPMV8MXx0MqDirVhnybYg6zoi/ytZgBpvXjkNEC
         WPpo7BnsqmRKLQM3m7Nhl87sXYqBVllDA7FM+URWU0vYl2/gtpdlPycUtUXnGsfQRHhI
         zklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m52x3jUpVmY1V020n+TdYZWzz+BP2ZGTjxgbxuVV3E8=;
        b=s7Ku+kOC2i2nO5/YR5BJK7SPp/Qu7Y3PdlZiD4niv6m4fJlcrQRb95XBhzlyTbqlMs
         h4QPvpkO+htDG+z3E4SRvo321OTgW5R9yVGbUVs2sh02agZumGgYRHDgPoYQ1Yb1gnln
         xQ76/Tv/jzP7Fvf72vLX8K1sglAdX5AeH8LfhS6khWGzjsrJAdp+v1UxGM4Tv7yjS1I9
         3nUltvxo0xezUwEfvW790Yxr09lgWlF6vL9C/TV5pfPDoU3HXEo3y7QRvF5tiowImWPZ
         uXi7dJV8tcvvWqp6vA/rHUhmmNPg4sVa8dBChdvlUdYBsI+KvwwQLebf+J0vIDo0Rwkt
         aXXQ==
X-Gm-Message-State: AOAM532BimZYtWTjzY9K+QNQ9L1wBuM+3TY6cgLW06GepqzeNtA4P6f7
        nuafq6ebD9vbwbDqkzOSar/dyStfRCDm6waV//U=
X-Google-Smtp-Source: ABdhPJzSoaxLER5FttMv6jcgULkvma8eqthy8FxDBclXD318BdBUjyR18N7kPhReHvyw8oWVsg2Cm3377u9g6VeLM80=
X-Received: by 2002:aa7:8387:0:b029:395:a683:a0e6 with SMTP id
 u7-20020aa783870000b0290395a683a0e6mr9436996pfm.12.1631866116263; Fri, 17 Sep
 2021 01:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210916182914.1810-1-mihail.chindris@analog.com> <20210916182914.1810-7-mihail.chindris@analog.com>
In-Reply-To: <20210916182914.1810-7-mihail.chindris@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 17 Sep 2021 11:08:24 +0300
Message-ID: <CA+U=DsrNExNT2Bvjve80GJwBPy3pH_gmhc5vjYTbnsh65MHNHQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] drivers:iio:dac:ad5766.c: Add trigger buffer
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 17, 2021 at 9:11 AM Mihail Chindris
<mihail.chindris@analog.com> wrote:
>
> This chip is able to generate waveform and using an
> with the output trigger buffer will be easy to generate one.
>

This turned out to look quite neat.
Some minor notes inline.
Nothing major.
But other than that:

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> ---
>  drivers/iio/dac/ad5766.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
> index dafda84fdea3..71491e6d466e 100644
> --- a/drivers/iio/dac/ad5766.c
> +++ b/drivers/iio/dac/ad5766.c
> @@ -5,10 +5,13 @@
>   * Copyright 2019-2020 Analog Devices Inc.
>   */
>  #include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
>  #include <asm/unaligned.h>
> @@ -41,6 +44,7 @@
>  #define AD5766_CMD_DITHER_SCALE_2              0xD0
>
>  #define AD5766_FULL_RESET_CODE                 0x1234
> +#define AD5766_NUM_CH                          16
>
>  enum ad5766_type {
>         ID_AD5766,
> @@ -455,6 +459,7 @@ static const struct iio_chan_spec_ext_info ad5766_ext_info[] = {
>         .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                   \
>         .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |         \
>                 BIT(IIO_CHAN_INFO_SCALE),                               \
> +       .scan_index = (_chan),                                          \
>         .scan_type = {                                                  \
>                 .sign = 'u',                                            \
>                 .realbits = (_bits),                                    \
> @@ -576,6 +581,28 @@ static int ad5766_default_setup(struct ad5766_state *st)
>         return  __ad5766_spi_write(st, AD5766_CMD_SPAN_REG, st->crt_range);
>  }
>
> +static irqreturn_t ad5766_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct iio_buffer *buf = indio_dev->buffer;

Purely stylistic.
I would keep the variable name as "struct iio_buffer *bufffer".
Reason is: when you start to grep the kernel-code, `buf` tends to
refer to simple/small buffers (like buf[4], or buf[16]).
And when wanting to do some multiple-changes, grepping easier is useful.

> +       int ret, ch, i;
> +       u16 data[AD5766_NUM_CH];
> +
> +       ret = iio_pop_from_buffer(buf, (u8 *)data);

Does the compiler complain if this (u8 *) cast is removed?
Because it doesn't look like this is needed or that it would do
anything as the argument of data is (void *).

> +       if (ret)
> +               goto done;
> +
> +       i = 0;
> +       for_each_set_bit(ch, indio_dev->active_scan_mask, AD5766_NUM_CH - 1)
> +               ad5766_write(indio_dev, ch, le16_to_cpu(data[i++]));
> +
> +done:
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}
> +
>  static int ad5766_probe(struct spi_device *spi)
>  {
>         enum ad5766_type type;
> @@ -609,6 +636,15 @@ static int ad5766_probe(struct spi_device *spi)
>         if (ret)
>                 return ret;
>
> +       /* Configure trigger buffer */
> +       ret = devm_iio_triggered_buffer_setup_ext(&spi->dev, indio_dev, NULL,
> +                                                 ad5766_trigger_handler,
> +                                                 IIO_BUFFER_DIRECTION_OUT,
> +                                                 NULL,
> +                                                 NULL);
> +       if (ret)
> +               return ret;
> +
>         return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>
> --
> 2.27.0
>
