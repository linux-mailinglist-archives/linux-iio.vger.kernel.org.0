Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE0618E30D
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 17:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgCUQw7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 12:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgCUQw7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 12:52:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D27B20732;
        Sat, 21 Mar 2020 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584809577;
        bh=Df9Azs5S5VRyHDU1J8LBBr99YqgiVp5qN+id6Nw8ym8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I78ReA1VgT5MfZvf4V/CluTrRO/fUqswc9VS4iHO3s/R3dDzLURdhF/Lk8ibGUIlu
         9y8bndUsgCwZIDPA68L6K6Gu7BfpD0noKOT92jvACh/s9DrPToXGXtPv8F52RxVBr1
         5FfvLjeAsQbG3kXxdqZCnNtAhsVMCcwLgvmpoq2g=
Date:   Sat, 21 Mar 2020 16:52:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH v2 3/5] iio: adc: ad7793: define/use own IIO channel
 macros
Message-ID: <20200321165254.042f249c@archlinux>
In-Reply-To: <20200321090802.11537-3-alexandru.ardelean@analog.com>
References: <20200321090802.11537-1-alexandru.ardelean@analog.com>
        <20200321090802.11537-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 11:08:00 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This driver seems to use most of the AD_SD_*_CHANNEL. This change will move
> them in the driver. The intent is that if a new part comes along which
> would require tweaks per IIO channel, these should be doable in the driver.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7793.c | 95 ++++++++++++++++++++++++++++++----------
>  1 file changed, 71 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index b747db97f78a..5592ae573e6b 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -546,47 +546,94 @@ static const struct iio_info ad7797_info = {
>  	.validate_trigger = ad_sd_validate_trigger,
>  };
>  
> +#define __AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
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
> +#define AD7793_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> +	_storagebits, _shift) \
> +	__AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> +		_storagebits, _shift, NULL, IIO_VOLTAGE, \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ))
> +
> +#define AD7793_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
> +	_storagebits, _shift) \
> +	__AD7793_CHANNEL(_si, _channel, _channel, _address, _bits, \
> +		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ))
> +
> +#define AD7793_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
> +	__AD7793_CHANNEL(_si, 0, -1, _address, _bits, \
> +		_storagebits, _shift, NULL, IIO_TEMP, \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ))
> +
> +#define AD7793_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
> +	_shift) \
> +	__AD7793_CHANNEL(_si, _channel, -1, _address, _bits, \
> +		_storagebits, _shift, "supply", IIO_VOLTAGE, \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ))
> +
>  #define DECLARE_AD7793_CHANNELS(_name, _b, _sb, _s) \
>  const struct iio_chan_spec _name##_channels[] = { \
> -	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), (_s)), \
> -	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), (_s)), \
> -	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), (_s)), \
> -	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), (_s)), \
> -	AD_SD_TEMP_CHANNEL(4, AD7793_CH_TEMP, (_b), (_sb), (_s)), \
> -	AD_SD_SUPPLY_CHANNEL(5, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), (_s)), \
> +	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), (_s)), \
> +	AD7793_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), (_s)), \
> +	AD7793_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), (_s)), \
> +	AD7793_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), (_s)), \
> +	AD7793_TEMP_CHANNEL(4, AD7793_CH_TEMP, (_b), (_sb), (_s)), \
> +	AD7793_SUPPLY_CHANNEL(5, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), (_s)), \
>  	IIO_CHAN_SOFT_TIMESTAMP(6), \
>  }
>  
>  #define DECLARE_AD7795_CHANNELS(_name, _b, _sb) \
>  const struct iio_chan_spec _name##_channels[] = { \
> -	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
> -	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
> -	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
> -	AD_SD_DIFF_CHANNEL(3, 3, 3, AD7795_CH_AIN4P_AIN4M, (_b), (_sb), 0), \
> -	AD_SD_DIFF_CHANNEL(4, 4, 4, AD7795_CH_AIN5P_AIN5M, (_b), (_sb), 0), \
> -	AD_SD_DIFF_CHANNEL(5, 5, 5, AD7795_CH_AIN6P_AIN6M, (_b), (_sb), 0), \
> -	AD_SD_SHORTED_CHANNEL(6, 0, AD7795_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
> -	AD_SD_TEMP_CHANNEL(7, AD7793_CH_TEMP, (_b), (_sb), 0), \
> -	AD_SD_SUPPLY_CHANNEL(8, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
> +	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
> +	AD7793_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
> +	AD7793_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
> +	AD7793_DIFF_CHANNEL(3, 3, 3, AD7795_CH_AIN4P_AIN4M, (_b), (_sb), 0), \
> +	AD7793_DIFF_CHANNEL(4, 4, 4, AD7795_CH_AIN5P_AIN5M, (_b), (_sb), 0), \
> +	AD7793_DIFF_CHANNEL(5, 5, 5, AD7795_CH_AIN6P_AIN6M, (_b), (_sb), 0), \
> +	AD7793_SHORTED_CHANNEL(6, 0, AD7795_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
> +	AD7793_TEMP_CHANNEL(7, AD7793_CH_TEMP, (_b), (_sb), 0), \
> +	AD7793_SUPPLY_CHANNEL(8, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
>  	IIO_CHAN_SOFT_TIMESTAMP(9), \
>  }
>  
>  #define DECLARE_AD7797_CHANNELS(_name, _b, _sb) \
>  const struct iio_chan_spec _name##_channels[] = { \
> -	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
> -	AD_SD_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
> -	AD_SD_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0), \
> -	AD_SD_SUPPLY_CHANNEL(3, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
> +	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
> +	AD7793_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
> +	AD7793_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0), \
> +	AD7793_SUPPLY_CHANNEL(3, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
>  	IIO_CHAN_SOFT_TIMESTAMP(4), \
>  }
>  
>  #define DECLARE_AD7799_CHANNELS(_name, _b, _sb) \
>  const struct iio_chan_spec _name##_channels[] = { \
> -	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
> -	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
> -	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
> -	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
> -	AD_SD_SUPPLY_CHANNEL(4, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
> +	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
> +	AD7793_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
> +	AD7793_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
> +	AD7793_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
> +	AD7793_SUPPLY_CHANNEL(4, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
>  	IIO_CHAN_SOFT_TIMESTAMP(5), \
>  }
>  

