Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A4522286
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 11:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbfERJK5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 05:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfERJK5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 05:10:57 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6B92082C;
        Sat, 18 May 2019 09:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558170655;
        bh=s/tc3EsoYjf6NsW3xIeXtlSWtFTeF/ITskRmqlS9HtY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TScTnIKjWXaaTyIu9N13SLXbsluSLuA5q2O6LsTstCoXdaN4BiAsNjlcN+zYCRqOr
         fJku78sSkyYIYP1HEEmMDswu2/b44/d96Z1mHOxrSqCog3GSbryJupMHWm7Zys7AH9
         wn0N08EMxveztPHHIBTnki3j5Eq11b6GKDo7h3TE=
Date:   Sat, 18 May 2019 10:10:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Adam Michaelis <adam.michaelis@rockwellcollins.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        michael.hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        charles-antoine.couret@essensium.com, devicetree@vger.kernel.org,
        brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com
Subject: Re: [PATCH v3 4/5] iio: ad7949: Fix SPI interfacing for 14-bit
 messages
Message-ID: <20190518101050.75c5d60e@archlinux>
In-Reply-To: <1557759185-167857-4-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1557759185-167857-1-git-send-email-adam.michaelis@rockwellcollins.com>
        <1557759185-167857-4-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 May 2019 09:53:04 -0500
Adam Michaelis <adam.michaelis@rockwellcollins.com> wrote:

> The AD7949 (but not the other two models supported by this driver) uses
> samples 14 bits wide. When attempting to communicate through certain SPI
> controllers that do not support word widths of 14, this fails. Adding
> logic to pack the 14-bit messages into the most-significant bits of a
> 16-bit message or a 2-word 8-bit message for communication using more SPI
> bus controllers.
> 
> Only able to test with AD7949 part on Cadence SPI, but should support
> the 16-bit samples of the AD7682 and AD7689, as well.
> 
> Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
This one looks fine to me as well.  For my reference
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note a trivial comment inline that can be tidied up whilst applying
or if you do another spin.

Jonathan
> ---
> 	V2:
> 	- Add some defines to reduce use of magic numbers.
> 	V3:
> 	- Use union for message buffer to keep messages word-aligned for
> 	various word sizes.
> 	- Calculate SPI bits-per-word once and use for logic throughout.
> 	- Add logic to use SPI controller's bits-per-word field to make
> 	the most use of the hardware's capabilities.
> 	- Try to support SPI word widths of 16, 14, and 8 bits.
> ---
>  drivers/iio/adc/ad7949.c | 115 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 87 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index b648b1ab9559..d67033a008e5 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -78,10 +78,30 @@ struct ad7949_adc_chip {
>  	enum ad7949_ref_sel ref_sel;
>  	u8 resolution;
>  	u16 cfg;
> +	u8 bits_per_word;
>  	unsigned int current_channel;
> -	u32 buffer ____cacheline_aligned;
> +	union {
> +		u32 buffer;
> +		u16 buf16[2];
> +		u8 buf8[4];
> +	} ____cacheline_aligned;
>  };
>  
> +static void ad7949_set_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
> +{
> +	/* Prefer messages that match the ADC's resolution */
> +	if (ad7949_adc->spi->controller->bits_per_word_mask &
> +			SPI_BPW_MASK(ad7949_adc->resolution))
> +		ad7949_adc->bits_per_word = ad7949_adc->resolution;
> +	/* Second choice is to pad 14-bit words to 16 */
> +	else if (ad7949_adc->spi->controller->bits_per_word_mask &
> +			SPI_BPW_MASK(16))
> +		ad7949_adc->bits_per_word = 16;
> +	/* Last resort, use 8-bit words */
> +	else
> +		ad7949_adc->bits_per_word = 8;
> +}
> +
>  static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
>  {
>  	if (!(ad7949_adc->cfg & AD7949_CFG_READBACK))
> @@ -90,39 +110,63 @@ static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
>  	return false;
>  }
>  
> -static int ad7949_spi_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
> +static int ad7949_message_len(struct ad7949_adc_chip *ad7949_adc)
>  {
> -	int ret = ad7949_adc->resolution;
> +	int tx_len = 2;
>  
>  	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
> -		ret += AD7949_CFG_REG_SIZE_BITS;
> +		tx_len += 2;
>  
> -	return ret;
> +	return tx_len;
>  }
>  
>  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
>  				u16 mask)
>  {
> -	int ret;
> -	int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
> -	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
> +	int ret = 0;
> +	u16 tmp_cfg = 0;
>  	struct spi_message msg;
>  	struct spi_transfer tx[] = {
>  		{
>  			.tx_buf = &ad7949_adc->buffer,
> -			.len = 4,
> -			.bits_per_word = bits_per_word,
> -		},
> +			.len = ad7949_message_len(ad7949_adc),
> +			.bits_per_word = ad7949_adc->bits_per_word,
> +		}
>  	};
>  
> -	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
> -	ad7949_adc->buffer = (ad7949_adc->cfg & AD7949_CFG_MASK_TOTAL) << shift;
> +	ad7949_adc->buffer = 0;
> +
> +	tmp_cfg = ((val & mask) | (ad7949_adc->cfg & ~mask)) &
> +		AD7949_CFG_MASK_TOTAL;
> +
> +	/* If no change, return */
> +	if (tmp_cfg == ad7949_adc->cfg)
> +		return 0;
> +
> +	ad7949_adc->cfg = tmp_cfg;
> +
> +	switch (ad7949_adc->bits_per_word) {
> +	case 16:
> +		ad7949_adc->buf16[0] = ad7949_adc->cfg << 2;
> +		break;
> +	case 14:
> +		ad7949_adc->buf16[0] = ad7949_adc->cfg;
> +		break;
> +	default: /* 8 */
> +		/* Pack 14-bit value into 2 bytes, MSB first */
> +		ad7949_adc->buf8[0] = FIELD_GET(GENMASK(13, 6), ad7949_adc->cfg);
> +		ad7949_adc->buf8[1] = FIELD_GET(GENMASK(5, 0), ad7949_adc->cfg);
> +		ad7949_adc->buf8[1] = ad7949_adc->buf8[1] << 2;
> +		break;
> +	}
> +
>  	spi_message_init_with_transfers(&msg, tx, 1);
> +
>  	ret = spi_sync(ad7949_adc->spi, &msg);
>  
>  	/*
> -	 * This delay is to avoid a new request before the required time to
> -	 * send a new command to the device
> +	 * This delay is to avoid a new request before the required
> +	 * time to send a new command to the device
>  	 */
>  	udelay(2);
>  
> @@ -149,17 +193,17 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  				   unsigned int channel)
>  {
>  	int ret;
> -	int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
> -	int mask = GENMASK(ad7949_adc->resolution, 0);
>  	struct spi_message msg;
>  	struct spi_transfer tx[] = {
>  		{
>  			.rx_buf = &ad7949_adc->buffer,
> -			.len = 4,
> -			.bits_per_word = bits_per_word,
> -		},
> +			.len = ad7949_message_len(ad7949_adc),
> +			.bits_per_word = ad7949_adc->bits_per_word,
> +		}
>  	};
>  
> +	ad7949_adc->current_channel = channel;
> +
>  	ret = ad7949_spi_write_cfg(ad7949_adc,
>  				   FIELD_PREP(AD7949_CFG_CHAN_SEL, channel),
>  				   AD7949_CFG_CHAN_SEL);
> @@ -167,23 +211,37 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  		return ret;
>  
>  	ad7949_adc->buffer = 0;
> +
>  	spi_message_init_with_transfers(&msg, tx, 1);
> +
Unrelated change. Nothing wrong with it, but not in a patch making
functional changes.

>  	ret = spi_sync(ad7949_adc->spi, &msg);
>  	if (ret)
>  		return ret;
>  
>  	/*
> -	 * This delay is to avoid a new request before the required time to
> -	 * send a new command to the device
> +	 * This delay is to avoid a new request before the required time
> +	 * to send a new command to the device.
>  	 */
>  	udelay(2);
>  
> -	ad7949_adc->current_channel = channel;
> -
> -	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
> -		*val = (ad7949_adc->buffer >> AD7949_CFG_REG_SIZE_BITS) & mask;
> -	else
> -		*val = ad7949_adc->buffer & mask;
> +	switch (ad7949_adc->bits_per_word) {
> +	case 16:
> +		*val = ad7949_adc->buf16[0];
> +		/* Shift-out padding bits */
> +		if (ad7949_adc->resolution == 14)
> +			*val = *val >> 2;
> +		break;
> +	case 14:
> +		*val = ad7949_adc->buf16[0] & GENMASK(13, 0);
> +		break;
> +	default: /* 8 */
> +		/* Convert byte array to u16, MSB first */
> +		*val = (ad7949_adc->buf8[0] << 8) | ad7949_adc->buf8[1];
> +		/* Shift-out padding bits */
> +		if (ad7949_adc->resolution == 14)
> +			*val = *val >> 2;
> +		break;
> +	}
>  
>  	return 0;
>  }
> @@ -334,6 +392,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
>  	spec = &ad7949_adc_spec[spi_get_device_id(spi)->driver_data];
>  	indio_dev->num_channels = spec->num_channels;
>  	ad7949_adc->resolution = spec->resolution;
> +	ad7949_set_bits_per_word(ad7949_adc);
>  
>  	ret = of_property_read_u32(ad7949_adc->indio_dev->dev.of_node,
>  			"adi,reference-select",

