Return-Path: <linux-iio+bounces-20870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3014FAE3079
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 16:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76DF16FA59
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924D91EEA28;
	Sun, 22 Jun 2025 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfZC1pc0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE61C1F12;
	Sun, 22 Jun 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750603837; cv=none; b=hQK9zehoJsRHOrD3yMpcYlT4uQmE9aT6FnPmKBiXMRznZhIZGwg8jWTlIDwPc2QjPwEq7ORIaXqrfsDV3qmafprzdSehLxPC9XQ6CSEsha+4BTcqkUUs+r6WnXQUy9HsNOgINspp/NA5+QPx63EdnHUZ3D5bqECgZGAL6QEa2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750603837; c=relaxed/simple;
	bh=OXFWX2z4djnWqsmJu+1RnGawjjex3BBcN4vqd/j1MMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lq8I2ZP44OgeetXeEyXbqic+oH0fOvBX8vYlZzAUpTvpm/AEDtPwl9R46noYKFmAlKuWng5DnKjCUmXh4WFMnlLlP5rLPdq1oBDkwtplJSz2Wq5m6G7+nRZGO5JduAu1o7OeaT8+yBLs8AJQD8gXX8U6QNmuA/yQOlcn+Gsi3ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfZC1pc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD09C4CEE3;
	Sun, 22 Jun 2025 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750603836;
	bh=OXFWX2z4djnWqsmJu+1RnGawjjex3BBcN4vqd/j1MMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IfZC1pc0nL4pzLThUCl9ecAjaSvRcLjpEnfTTlZV9gBl2lpHIJ8B8YtsOimvXXWHB
	 AhO9BdSzvle9NnkpZuGA3ooA72lwnypasxsQvBEydkSuU/j0S2VSjJqdhov7kow4ew
	 YgF4i/YkqetB8Ayj2XEzyO3ur97y6BqkiikM9IJjf1JAf4sugS/2B1GG1bc2msXDwV
	 QrLJ8K+E0mC6wWSlqn2s5Y01PwUSrcl5DsBqDfD1xQQC2g50f3m+vtsIzeNgr1OlF9
	 BcqLtCl8hQcbA7LV1FZ/L53gPCNQi9111B53wB6ORCp56ehcM3jcdGeF7FyAmAEeol
	 mTZYVMwwmMxzw==
Date: Sun, 22 Jun 2025 15:50:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 5/9] iio: adc: ad_sigma_delta: use
 spi_optimize_message()
Message-ID: <20250622155026.15b3723c@jic23-huawei>
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-5-0766f6297430@baylibre.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
	<20250620-iio-adc-ad7173-add-spi-offload-support-v1-5-0766f6297430@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 17:20:11 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use spi_optimize_message() to improve the performance of buffered reads.
> 
> By setting up the SPI message and pre-optimizing it in the buffer
> postenable callback, we can reduce overhead during each sample read.
> 
> A rough estimate shows that this reduced the CPU usage of the interrupt
> handler thread from 22% to 16% using an EVAL-AD4112ARDZ board on a
> DE10-Nano (measuring a single channel at the default 6.2 kHz sample
> rate).
Nice.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
A query inline that is really about what the existing code is doing.
Also a request for duplicating the comment about extra padding as that
is unusual!

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c       | 74 ++++++++++++++++------------------
>  include/linux/iio/adc/ad_sigma_delta.h |  3 ++
>  2 files changed, 38 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 883cc02d4099908644af523bcf66c0178fbd0e55..a9b97f5d4107a2e1bb74877d30403445e9b04a44 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -458,8 +458,10 @@ EXPORT_SYMBOL_NS_GPL(ad_sigma_delta_single_conversion, "IIO_AD_SIGMA_DELTA");
>  static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> +	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
> +	struct spi_transfer *xfer = sigma_delta->sample_xfer;
>  	unsigned int i, slot, samples_buf_size;
> -	unsigned int channel;
> +	unsigned int channel, scan_size;
>  	u8 *samples_buf;
>  	int ret;
>  
> @@ -493,7 +495,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  			return ret;
>  	}
>  
> -	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits, 8);
> +	samples_buf_size = ALIGN(slot * scan_type->storagebits, 8);

What is this doing?  Storage bits as the name suggests is in bits but this superficially
seems to be treating it like it was in bytes.

The ALIGN() is I think just about the timestamp alignment.


>  	samples_buf_size += sizeof(int64_t);
>  	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
>  				    samples_buf_size, GFP_KERNEL);
> @@ -501,6 +503,27 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  		return -ENOMEM;
>  
>  	sigma_delta->samples_buf = samples_buf;
> +	scan_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
> +	xfer[1].rx_buf = &sigma_delta->rx_buf[scan_size == 3 ? 1 : 0];

This is black magic.  Comment needed I think on why the offset in rx_buf.

> +	xfer[1].len = scan_size + (sigma_delta->status_appended ? 1 : 0);
> +	xfer[1].cs_change = 1;
> +
> +	if (sigma_delta->info->has_registers) {
> +		xfer[0].tx_buf = &sigma_delta->sample_addr;
> +		xfer[0].len = 1;
> +
> +		ad_sd_set_read_reg_addr(sigma_delta,
> +					sigma_delta->info->data_reg ?: AD_SD_REG_DATA,
> +					&sigma_delta->sample_addr);
> +		spi_message_init_with_transfers(&sigma_delta->sample_msg, xfer, 2);
> +	} else {
> +		spi_message_init_with_transfers(&sigma_delta->sample_msg,
> +						&xfer[1], 1);
> +	}
> +
> +	ret = spi_optimize_message(sigma_delta->spi, &sigma_delta->sample_msg);
> +	if (ret)
> +		return ret;
>  
>  	spi_bus_lock(sigma_delta->spi->controller);
>  	sigma_delta->bus_locked = true;
> @@ -520,6 +543,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  
>  err_unlock:
>  	spi_bus_unlock(sigma_delta->spi->controller);
> +	spi_unoptimize_message(&sigma_delta->sample_msg);
>  
>  	return ret;
>  }



> @@ -550,51 +577,20 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
>  	u8 *data = sigma_delta->rx_buf;
> -	unsigned int transfer_size;
>  	unsigned int sample_size;
>  	unsigned int sample_pos;
>  	unsigned int status_pos;
>  	unsigned int reg_size;
> -	unsigned int data_reg;
> +	int ret;
>  
>  	reg_size = BITS_TO_BYTES(indio_dev->channels[0].scan_type.realbits +
>  				 indio_dev->channels[0].scan_type.shift);
> +	/* For 24-bit data, there is an extra byte of padding. */
> +	status_pos = reg_size + (reg_size == 3 ? 1 : 0);

Ah. I guess this applies above as well.  I'd duplicate the comment.

>  
> -	if (sigma_delta->info->data_reg != 0)
> -		data_reg = sigma_delta->info->data_reg;
> -	else
> -		data_reg = AD_SD_REG_DATA;
> -
> -	/* Status word will be appended to the sample during transfer */
> -	if (sigma_delta->status_appended)
> -		transfer_size = reg_size + 1;
> -	else
> -		transfer_size = reg_size;
> -
> -	switch (reg_size) {
> -	case 4:
> -	case 2:
> -	case 1:
> -		status_pos = reg_size;
> -		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[0]);
> -		break;
> -	case 3:
> -		/*
> -		 * Data array after transfer will look like (if status is appended):
> -		 * data[] = { [0][sample][sample][sample][status] }
> -		 * Keeping the first byte 0 shifts the status position by 1 byte to the right.
> -		 */
> -		status_pos = reg_size + 1;
> -
> -		/* We store 24 bit samples in a 32 bit word. Keep the upper
> -		 * byte set to zero. */
> -		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[1]);
> -		break;
> -
> -	default:
> -		dev_err_ratelimited(&indio_dev->dev, "Unsupported reg_size: %u\n", reg_size);
> +	ret = spi_sync_locked(sigma_delta->spi, &sigma_delta->sample_msg);
> +	if (ret)
>  		goto irq_handled;
> -	}
>  
>  	/*
>  	 * For devices sampling only one channel at
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 5056677c9941afadc2383febbcafeb02e23a4f44..2037bb68b44115681ff48f66b580b63f50c2ea9e 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -105,6 +105,8 @@ struct ad_sigma_delta {
>  	bool			status_appended;
>  	/* map slots to channels in order to know what to expect from devices */
>  	unsigned int		*slots;
> +	struct spi_message	sample_msg;
> +	struct spi_transfer	sample_xfer[2];
>  	u8			*samples_buf;
>  
>  	/*
> @@ -116,6 +118,7 @@ struct ad_sigma_delta {
>  	 */
>  	u8				tx_buf[4] __aligned(IIO_DMA_MINALIGN);
>  	u8				rx_buf[16] __aligned(8);
> +	u8				sample_addr;
>  };
>  
>  static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
> 


