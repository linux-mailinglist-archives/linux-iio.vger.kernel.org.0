Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7653B18E309
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 17:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgCUQwC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 12:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgCUQwC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 12:52:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A28FA20732;
        Sat, 21 Mar 2020 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584809521;
        bh=P7RZGcDfuCGA28GbU37WsmUvXtw+w1lkMU9DY9xJy2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZEdgNBk1Fk4eQYIqsBinBroB4qe0jIqhzpLHQmLU6zXxKhubNE5gTJFW+zrFl9B7I
         FCTURWRzAIQpChOas8V8kZ2DB/khVA8d/bBsiYZ6gAO0bbRUOvLwNaVFywCQTvX5ZI
         IMJiq2X8Nw6pWhy8dNiTkM35cuH6Ka1iEVpdygT8=
Date:   Sat, 21 Mar 2020 16:51:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH v2 2/5] iio: adc: ad7791: define/use own IIO channel
 macros
Message-ID: <20200321165157.7f3f5623@archlinux>
In-Reply-To: <20200321090802.11537-2-alexandru.ardelean@analog.com>
References: <20200321090802.11537-1-alexandru.ardelean@analog.com>
        <20200321090802.11537-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 11:07:59 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This driver seems to use most of the AD_SD_*_CHANNEL. This change will move
> them in the driver. The intent is that if a new part comes along which
> would require tweaks per IIO channel, these should be doable in the driver.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied, thanks

Jonathan

> ---
>  drivers/iio/adc/ad7791.c | 62 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index abb239392631..ba22808507d0 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -64,25 +64,73 @@
>  #define AD7791_MODE_SEL_MASK		(0x3 << 6)
>  #define AD7791_MODE_SEL(x)		((x) << 6)
>  
> +#define __AD7991_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> +	_storagebits, _shift, _extend_name, _type, _mask_all) \
> +	{ \
> +		.type = (_type), \
> +		.differential = (_channel2 == -1 ? 0 : 1), \
> +		.indexed = 1, \
> +		.channel = (_channel1), \
> +		.channel2 = (_channel2), \
> +		.address = (_address), \
> +		.extend_name = (_extend_name), \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			BIT(IIO_CHAN_INFO_OFFSET), \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_all = _mask_all, \
> +		.scan_index = (_si), \
> +		.scan_type = { \
> +			.sign = 'u', \
> +			.realbits = (_bits), \
> +			.storagebits = (_storagebits), \
> +			.shift = (_shift), \
> +			.endianness = IIO_BE, \
> +		}, \
> +	}
> +
> +#define AD7991_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
> +	_storagebits, _shift) \
> +	__AD7991_CHANNEL(_si, _channel, _channel, _address, _bits, \
> +		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ))
> +
> +#define AD7991_CHANNEL(_si, _channel, _address, _bits, \
> +	_storagebits, _shift) \
> +	__AD7991_CHANNEL(_si, _channel, -1, _address, _bits, \
> +		_storagebits, _shift, NULL, IIO_VOLTAGE, \
> +		 BIT(IIO_CHAN_INFO_SAMP_FREQ))
> +
> +#define AD7991_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> +	_storagebits, _shift) \
> +	__AD7991_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> +		_storagebits, _shift, NULL, IIO_VOLTAGE, \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ))
> +
> +#define AD7991_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
> +	_shift) \
> +	__AD7991_CHANNEL(_si, _channel, -1, _address, _bits, \
> +		_storagebits, _shift, "supply", IIO_VOLTAGE, \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ))
> +
>  #define DECLARE_AD7787_CHANNELS(name, bits, storagebits) \
>  const struct iio_chan_spec name[] = { \
> -	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
> +	AD7991_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
>  		(bits), (storagebits), 0), \
> -	AD_SD_CHANNEL(1, 1, AD7791_CH_AIN2, (bits), (storagebits), 0), \
> -	AD_SD_SHORTED_CHANNEL(2, 0, AD7791_CH_AIN1N_AIN1N, \
> +	AD7991_CHANNEL(1, 1, AD7791_CH_AIN2, (bits), (storagebits), 0), \
> +	AD7991_SHORTED_CHANNEL(2, 0, AD7791_CH_AIN1N_AIN1N, \
>  		(bits), (storagebits), 0), \
> -	AD_SD_SUPPLY_CHANNEL(3, 2, AD7791_CH_AVDD_MONITOR,  \
> +	AD7991_SUPPLY_CHANNEL(3, 2, AD7791_CH_AVDD_MONITOR,  \
>  		(bits), (storagebits), 0), \
>  	IIO_CHAN_SOFT_TIMESTAMP(4), \
>  }
>  
>  #define DECLARE_AD7791_CHANNELS(name, bits, storagebits) \
>  const struct iio_chan_spec name[] = { \
> -	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
> +	AD7991_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
>  		(bits), (storagebits), 0), \
> -	AD_SD_SHORTED_CHANNEL(1, 0, AD7791_CH_AIN1N_AIN1N, \
> +	AD7991_SHORTED_CHANNEL(1, 0, AD7791_CH_AIN1N_AIN1N, \
>  		(bits), (storagebits), 0), \
> -	AD_SD_SUPPLY_CHANNEL(2, 1, AD7791_CH_AVDD_MONITOR, \
> +	AD7991_SUPPLY_CHANNEL(2, 1, AD7791_CH_AVDD_MONITOR, \
>  		(bits), (storagebits), 0), \
>  	IIO_CHAN_SOFT_TIMESTAMP(3), \
>  }

