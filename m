Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC82C2C7511
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbgK1Vt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732568AbgK1TCA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:02:00 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B04824672;
        Sat, 28 Nov 2020 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606570453;
        bh=yZvlOf7/LQLMMBpn5XVrFU9zEb4NbWedk0oxkJYa5mE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hdeWmGD/FVy1+NCMSvgLzHJanDF2tSUyJfukJDIV7IgSlHsIIQz56CVIKZt0095JU
         nSQ1Q5ypLvlabeCUOdJWYh7eQYSHnyO05v7q4ZLMpz5J8TQSMQZ9P/r1Ma/xqlRQdC
         EJnJGZJSDZE7B0jiJdo01E8ye7gH/WPJ9n3usHVM=
Date:   Sat, 28 Nov 2020 13:34:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <alexandru.tachici@analog.com>
Subject: Re: [PATCH v3] iio: ad_sigma_delta: Don't put SPI transfer buffer
 on the stack
Message-ID: <20201128133408.3218c1fd@archlinux>
In-Reply-To: <20201124123807.19717-1-alexandru.ardelean@analog.com>
References: <20201113094059.152651-1-alexandru.ardelean@analog.com>
        <20201124123807.19717-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Nov 2020 14:38:07 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Use a heap allocated memory for the SPI transfer buffer. Using stack memory
> can corrupt stack memory when using DMA on some systems.
> 
> This change moves the buffer from the stack of the trigger handler call to
> the heap of the buffer of the state struct. The size increases takes into
> account the alignment for the timestamp, which is 8 bytes.
> 
> The 'data' buffer is split into 'tx_buf' and 'rx_buf', to make a clearer
> separation of which part of the buffer should be used for TX & RX.
> 
> Fixes: af3008485ea03 ("iio:adc: Add common code for ADI Sigma Delta devices")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Given where we are in the cycle and the fact this has been there a long time
I've queued it up for the next merge window.  Also marked it for stable so
it will get backported in the medium term.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to do their usual magic.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c       | 18 ++++++++----------
>  include/linux/iio/adc/ad_sigma_delta.h |  6 +++++-
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 86039e9ecaca..3a6f239d4acc 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -57,7 +57,7 @@ EXPORT_SYMBOL_GPL(ad_sd_set_comm);
>  int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
>  	unsigned int size, unsigned int val)
>  {
> -	uint8_t *data = sigma_delta->data;
> +	uint8_t *data = sigma_delta->tx_buf;
>  	struct spi_transfer t = {
>  		.tx_buf		= data,
>  		.len		= size + 1,
> @@ -99,7 +99,7 @@ EXPORT_SYMBOL_GPL(ad_sd_write_reg);
>  static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
>  	unsigned int reg, unsigned int size, uint8_t *val)
>  {
> -	uint8_t *data = sigma_delta->data;
> +	uint8_t *data = sigma_delta->tx_buf;
>  	int ret;
>  	struct spi_transfer t[] = {
>  		{
> @@ -146,22 +146,22 @@ int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta,
>  {
>  	int ret;
>  
> -	ret = ad_sd_read_reg_raw(sigma_delta, reg, size, sigma_delta->data);
> +	ret = ad_sd_read_reg_raw(sigma_delta, reg, size, sigma_delta->rx_buf);
>  	if (ret < 0)
>  		goto out;
>  
>  	switch (size) {
>  	case 4:
> -		*val = get_unaligned_be32(sigma_delta->data);
> +		*val = get_unaligned_be32(sigma_delta->rx_buf);
>  		break;
>  	case 3:
> -		*val = get_unaligned_be24(&sigma_delta->data[0]);
> +		*val = get_unaligned_be24(sigma_delta->rx_buf);
>  		break;
>  	case 2:
> -		*val = get_unaligned_be16(sigma_delta->data);
> +		*val = get_unaligned_be16(sigma_delta->rx_buf);
>  		break;
>  	case 1:
> -		*val = sigma_delta->data[0];
> +		*val = sigma_delta->rx_buf[0];
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -395,11 +395,9 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> +	uint8_t *data = sigma_delta->rx_buf;
>  	unsigned int reg_size;
>  	unsigned int data_reg;
> -	uint8_t data[16];
> -
> -	memset(data, 0x00, 16);
>  
>  	reg_size = indio_dev->channels[0].scan_type.realbits +
>  			indio_dev->channels[0].scan_type.shift;
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index a3a838dcf8e4..efc2413abaf4 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -79,8 +79,12 @@ struct ad_sigma_delta {
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> +	 * 'tx_buf' is up to 32 bits.
> +	 * 'rx_buf' is up to 32 bits per sample + 64 bit timestamp,
> +	 * rounded to 16 bytes to take into account padding.
>  	 */
> -	uint8_t				data[4] ____cacheline_aligned;
> +	uint8_t				tx_buf[4] ____cacheline_aligned;
> +	uint8_t				rx_buf[16] __aligned(8);
>  };
>  
>  static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,

