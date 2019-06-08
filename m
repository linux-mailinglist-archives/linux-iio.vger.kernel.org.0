Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A87B3A03D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFHOVE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 10:21:04 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33346 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHOVE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 10:21:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id F29F59E8E7E;
        Sat,  8 Jun 2019 15:21:01 +0100 (BST)
Date:   Sat, 8 Jun 2019 15:21:00 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: ad_sigma_delta: allocate data dynamically for
 samples
Message-ID: <20190608152100.72f004d7@archlinux>
In-Reply-To: <20190530075911.6032-1-alexandru.ardelean@analog.com>
References: <20190530075911.6032-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 May 2019 10:59:11 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change has a few parts:
> 1. Remove the buffer from the trigger handler's stack
> 2. Having it dynamically allocated means it should be cache-aligned
> 3. The buffer would now adapt to the actual number of bytes needed,
>    whether it's more than 16 bytes, or less
> 4. Having it in the heap somewhere, allows it to work with DMA
> 
> This is a fix + enhancement in one.
> 
> Fixes: af3008485ea03 ("iio: ad_sigma_delta: allocate data dynamically for samples")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Comment inline.  This is using an element of iio_dev that is marked
INTERN in the header...

> ---
>  drivers/iio/adc/ad_sigma_delta.c       | 12 ++++++++++--
>  include/linux/iio/adc/ad_sigma_delta.h |  2 ++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index ec0e38566ece..91d5dda53d29 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -360,6 +360,11 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> +	kfree(sigma_delta->buf_data);
> +	sigma_delta->buf_data = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
Hmm. Another thing that I'm trying to stop drivers doing is accessing elements
of the struct iio_dev that have been marked in the header as INTERN.

That really restricts the ability to refactor that code.

The argument has always been that a driver ought to be able to 'tell' how
large a buffer it can conceivably need and often it will actually use
a 'superset' of that to avoid the need to do additional allocations.

It's a it trickier when there is a generic layer inbetween the driver and
the core like we have here. 

If the below 16 is correct, you are almost certain to not actually see any
advantage in a separate allocation.  So two options come to mind.

1) Ensure ad_sigma_delta is appropriately aligned in the priv data
of each driver, then use ___cacheline_aligned on a fixed 16 byte buffer
in ad_sigma_delta.
2) Do the separate allocation, but stick to 16 bytes (you will always
get more than that anyway as always at least a cacheline - otherwise
same DMA issue might occur).

> +	if (!sigma_delta->buf_data)
> +		return -ENOMEM;
> +
>  	spi_bus_lock(sigma_delta->spi->master);
>  	sigma_delta->bus_locked = true;
>  	sigma_delta->keep_cs_asserted = true;
> @@ -403,12 +408,12 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> +	uint8_t *data = sigma_delta->buf_data;
>  	unsigned int reg_size;
>  	unsigned int data_reg;
> -	uint8_t data[16];
>  	int ret;
>  
> -	memset(data, 0x00, 16);
> +	memset(data, 0x00, indio_dev->scan_bytes);
>  
>  	reg_size = indio_dev->channels[0].scan_type.realbits +
>  			indio_dev->channels[0].scan_type.shift;
> @@ -568,6 +573,9 @@ EXPORT_SYMBOL_GPL(ad_sd_setup_buffer_and_trigger);
>   */
>  void ad_sd_cleanup_buffer_and_trigger(struct iio_dev *indio_dev)
>  {
> +	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> +
> +	kfree(sigma_delta->buf_data);
>  	ad_sd_remove_trigger(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  }
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 6e9fb1932dde..36dc49b8dfd5 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -75,6 +75,8 @@ struct ad_sigma_delta {
>  
>  	const struct ad_sigma_delta_info *info;
>  
> +	uint8_t			*buf_data;
> +
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.

