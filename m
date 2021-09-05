Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2EA401089
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 17:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhIEPXy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 11:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhIEPXy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 11:23:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E86A60F12;
        Sun,  5 Sep 2021 15:22:48 +0000 (UTC)
Date:   Sun, 5 Sep 2021 16:26:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Subject: Re: [PATCH v2 04/16] iio: adc: max1027: Avoid device managed
 allocators for DMA purposes
Message-ID: <20210905162612.571fc03a@jic23-huawei>
In-Reply-To: <20210902211437.503623-5-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
        <20210902211437.503623-5-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:14:25 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> My overall understanding [1] is that devm_ allocations will require an
> extra 16 bytes at the beginning of the allocated buffer to store
> information about the managing device, this shifts a little bit the
> buffer which may then not be fully aligned on cache lines, disqualifying
> them for being suitable for DMA.
> 
> Let's switch to a regular kmalloc based allocator to ensure st->buffer
> is DMA-able, as required by the IIO subsystem.
> 
> [1] https://linux-arm-kernel.infradead.narkive.com/vyJqy0RQ/question-devm-kmalloc-for-dma
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
As per the other thread (I was late to the discussion) I don't believe this is
necessary because there is no chance of the data in the cacheline being touched
by the CPU whilst DMA is going on.

https://linux-arm-kernel.infradead.narkive.com/vyJqy0RQ/question-devm-kmalloc-for-dma#post5

Writes before dma transfer are safe.  It's writes during it that can cause problem so as
long as a driver isn't doing devm_ calls during such writes (and I really hope this isn't)
then we are safe.  The device will only overwrite the data with what was already there.

Jonathan

> ---
>  drivers/iio/adc/max1027.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index f27044324141..1167d50c1d67 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -438,9 +438,7 @@ static int max1027_probe(struct spi_device *spi)
>  	indio_dev->num_channels = st->info->num_channels;
>  	indio_dev->available_scan_masks = st->info->available_scan_masks;
>  
> -	st->buffer = devm_kmalloc_array(&indio_dev->dev,
> -					indio_dev->num_channels, 2,
> -					GFP_KERNEL);
> +	st->buffer = kmalloc_array(indio_dev->num_channels, 2, GFP_KERNEL);
>  	if (!st->buffer)
>  		return -ENOMEM;
>  
> @@ -451,7 +449,7 @@ static int max1027_probe(struct spi_device *spi)
>  						      NULL);
>  		if (ret < 0) {
>  			dev_err(&indio_dev->dev, "Failed to setup buffer\n");
> -			return ret;
> +			goto free_buffer;
>  		}
>  
>  		st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-trigger",
> @@ -460,7 +458,7 @@ static int max1027_probe(struct spi_device *spi)
>  			ret = -ENOMEM;
>  			dev_err(&indio_dev->dev,
>  				"Failed to allocate iio trigger\n");
> -			return ret;
> +			goto free_buffer;
>  		}
>  
>  		st->trig->ops = &max1027_trigger_ops;
> @@ -470,7 +468,7 @@ static int max1027_probe(struct spi_device *spi)
>  		if (ret < 0) {
>  			dev_err(&indio_dev->dev,
>  				"Failed to register iio trigger\n");
> -			return ret;
> +			goto free_buffer;
>  		}
>  
>  		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
> @@ -481,7 +479,7 @@ static int max1027_probe(struct spi_device *spi)
>  						st->trig);
>  		if (ret < 0) {
>  			dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
> -			return ret;
> +			goto free_buffer;
>  		}
>  	}
>  
> @@ -490,7 +488,7 @@ static int max1027_probe(struct spi_device *spi)
>  	ret = spi_write(st->spi, &st->reg, 1);
>  	if (ret < 0) {
>  		dev_err(&indio_dev->dev, "Failed to reset the ADC\n");
> -		return ret;
> +		goto free_buffer;
>  	}
>  
>  	/* Disable averaging */
> @@ -498,10 +496,15 @@ static int max1027_probe(struct spi_device *spi)
>  	ret = spi_write(st->spi, &st->reg, 1);
>  	if (ret < 0) {
>  		dev_err(&indio_dev->dev, "Failed to configure averaging register\n");
> -		return ret;
> +		goto free_buffer;
>  	}
>  
>  	return devm_iio_device_register(&spi->dev, indio_dev);
> +
> +free_buffer:
> +	kfree(st->buffer);
> +
> +	return ret;
>  }
>  
>  static struct spi_driver max1027_driver = {

