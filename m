Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF32737FC77
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhEMR0J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhEMR0J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:26:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45E8B6142C;
        Thu, 13 May 2021 17:24:58 +0000 (UTC)
Date:   Thu, 13 May 2021 18:26:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 02/19] iio: accel: bma220: Fix buffer alignment in
 iio_push_to_buffers_with_timestamp()
Message-ID: <20210513182606.2abf9e73@jic23-huawei>
In-Reply-To: <20210501170121.512209-3-jic23@kernel.org>
References: <20210501170121.512209-1-jic23@kernel.org>
        <20210501170121.512209-3-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  1 May 2021 18:01:04 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> To make code more readable, use a structure to express the channel
> layout and ensure the timestamp is 8 byte aligned.
> 
> Found during an audit of all calls of this function.
~Gah. Clearly wasn't on my best form when I originally wrote these.
Number of chans in this one is wrong as well.  Fixed to 3 as per the
comment that got dropped because it should have been obvious.

As you might imagine, the error in patch 1 made me look closer at
the rest of these whilst applying.
> 
> Fixes: 194dc4c71413 ("iio: accel: Add triggered buffer support for BMA220")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to poke at.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bma220_spi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index 36fc9876dbca..2802ce1852ef 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -63,7 +63,11 @@ static const int bma220_scale_table[][2] = {
>  struct bma220_data {
>  	struct spi_device *spi_device;
>  	struct mutex lock;
> -	s8 buffer[16]; /* 3x8-bit channels + 5x8 padding + 8x8 timestamp */
> +	struct {
> +		s8 chans[2];
> +		/* Ensure timestamp is naturally aligned. */
> +		s64 timestamp __aligned(8);
> +	} scan;
>  	u8 tx_buf[2] ____cacheline_aligned;
>  };
>  
> @@ -94,12 +98,12 @@ static irqreturn_t bma220_trigger_handler(int irq, void *p)
>  
>  	mutex_lock(&data->lock);
>  	data->tx_buf[0] = BMA220_REG_ACCEL_X | BMA220_READ_MASK;
> -	ret = spi_write_then_read(spi, data->tx_buf, 1, data->buffer,
> +	ret = spi_write_then_read(spi, data->tx_buf, 1, &data->scan.chans,
>  				  ARRAY_SIZE(bma220_channels) - 1);
>  	if (ret < 0)
>  		goto err;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>  					   pf->timestamp);
>  err:
>  	mutex_unlock(&data->lock);

