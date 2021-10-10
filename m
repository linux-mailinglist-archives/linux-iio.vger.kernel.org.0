Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93642827E
	for <lists+linux-iio@lfdr.de>; Sun, 10 Oct 2021 18:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhJJQVU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Oct 2021 12:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhJJQVT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Oct 2021 12:21:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231CB6008E;
        Sun, 10 Oct 2021 16:19:18 +0000 (UTC)
Date:   Sun, 10 Oct 2021 17:23:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <alexandru.ardelean@analog.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH v6 6/6] drivers:iio:dac:ad5766.c: Add trigger buffer
Message-ID: <20211010172325.3a546322@jic23-huawei>
In-Reply-To: <20211007080035.2531-7-mihail.chindris@analog.com>
References: <20211007080035.2531-1-mihail.chindris@analog.com>
        <20211007080035.2531-7-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Oct 2021 08:00:37 +0000
Mihail Chindris <mihail.chindris@analog.com> wrote:

> This chip is able to generate waveform and using an
> with the output trigger buffer will be easy to generate one.
> 
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Rest of series applied to the togreg branch of iio.git, initially pushed out as
testing for 0-day to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5766.c | 42 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
> index dafda84fdea3..b0d220c3a126 100644
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
> @@ -455,6 +458,7 @@ static const struct iio_chan_spec_ext_info ad5766_ext_info[] = {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |		\
>  		BIT(IIO_CHAN_INFO_SCALE),				\
> +	.scan_index = (_chan),						\
>  	.scan_type = {							\
>  		.sign = 'u',						\
>  		.realbits = (_bits),					\
> @@ -576,6 +580,35 @@ static int ad5766_default_setup(struct ad5766_state *st)
>  	return  __ad5766_spi_write(st, AD5766_CMD_SPAN_REG, st->crt_range);
>  }
>  
> +static irqreturn_t ad5766_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct ad5766_state *st = iio_priv(indio_dev);
> +	int ret, ch, i;
> +	u16 data[ARRAY_SIZE(ad5766_channels)];
> +
> +	ret = iio_pop_from_buffer(buffer, data);
> +	if (ret)
> +		goto done;
> +
> +	i = 0;
> +	mutex_lock(&st->lock);
> +	for_each_set_bit(ch, indio_dev->active_scan_mask,
> +			 st->chip_info->num_channels - 1)
> +		__ad5766_spi_write(st, AD5766_CMD_WR_IN_REG(ch), data[i++]);
> +
> +	__ad5766_spi_write(st, AD5766_CMD_SW_LDAC,
> +			   *indio_dev->active_scan_mask);
> +	mutex_unlock(&st->lock);
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int ad5766_probe(struct spi_device *spi)
>  {
>  	enum ad5766_type type;
> @@ -609,6 +642,15 @@ static int ad5766_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	/* Configure trigger buffer */
> +	ret = devm_iio_triggered_buffer_setup_ext(&spi->dev, indio_dev, NULL,
> +						  ad5766_trigger_handler,
> +						  IIO_BUFFER_DIRECTION_OUT,
> +						  NULL,
> +						  NULL);
> +	if (ret)
> +		return ret;
> +
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  

