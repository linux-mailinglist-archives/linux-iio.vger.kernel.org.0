Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 784FA15F524
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 19:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgBNPtD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 10:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbgBNPtC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 10:49:02 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0E4722314;
        Fri, 14 Feb 2020 15:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695341;
        bh=iPSMz9m+b6TUU1rBeRiiINPLup/BJ2uTJt5Gu19G7Ts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XOlOtbYN91NTX5WQtG7fSL9pK17AEigsLWFVC3TJd5igmif76Upsz7OR9d8zNfCIF
         2NmiiQTvlPqirtxwTVxkMiGH2MdyTFsO+cUV+xGpE52QnnaTFf5Ryzsf7IGvYnkcbV
         oaKuCWEGKACKRRlJlS1Wfb+UnP1PYFCtRGxLTJRs=
Date:   Fri, 14 Feb 2020 15:47:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] staging: iio: adc: ad7192: modify iio_chan_spec
 array
Message-ID: <20200214154748.3f977906@archlinux>
In-Reply-To: <20200212161721.16200-3-alexandru.tachici@analog.com>
References: <20200212161721.16200-1-alexandru.tachici@analog.com>
        <20200212161721.16200-3-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 Feb 2020 18:17:18 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> This patch changes the static const struct iio_chan_spec arrays
> in a way that all the necessary attributes are set at
> compile time. Now ad7192_channels_config only makes the
> channels attribute of iio_dev point to the right array depending
> on the chip.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
Applied, thanks


> ---
>  drivers/staging/iio/adc/ad7192.c | 112 ++++++++++++++++++-------------
>  1 file changed, 66 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 41da8b4cdc48..8fca8915543d 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -786,73 +786,93 @@ static const struct iio_info ad7195_info = {
>  	.validate_trigger = ad_sd_validate_trigger,
>  };
>  
> +#define __AD719x_CHANNEL(_si, _channel1, _channel2, _address, _extend_name, \
> +	_type, _mask_type_av, _ext_info) \
> +	{ \
> +		.type = (_type), \
> +		.differential = ((_channel2) == -1 ? 0 : 1), \
> +		.indexed = 1, \
> +		.channel = (_channel1), \
> +		.channel2 = (_channel2), \
> +		.address = (_address), \
> +		.extend_name = (_extend_name), \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			BIT(IIO_CHAN_INFO_OFFSET), \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
> +		.info_mask_shared_by_type_available = (_mask_type_av), \
> +		.ext_info = (_ext_info), \
> +		.scan_index = (_si), \
> +		.scan_type = { \
> +			.sign = 'u', \
> +			.realbits = 24, \
> +			.storagebits = 32, \
> +			.endianness = IIO_BE, \
> +		}, \
> +	}
> +
> +#define AD719x_DIFF_CHANNEL(_si, _channel1, _channel2, _address) \
> +	__AD719x_CHANNEL(_si, _channel1, _channel2, _address, NULL, \
> +		IIO_VOLTAGE, BIT(IIO_CHAN_INFO_SCALE), \
> +		ad7192_calibsys_ext_info)
> +
> +#define AD719x_CHANNEL(_si, _channel1, _address) \
> +	__AD719x_CHANNEL(_si, _channel1, -1, _address, NULL, IIO_VOLTAGE, \
> +		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
> +
> +#define AD719x_SHORTED_CHANNEL(_si, _channel1, _address) \
> +	__AD719x_CHANNEL(_si, _channel1, -1, _address, "shorted", IIO_VOLTAGE, \
> +		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
> +
> +#define AD719x_TEMP_CHANNEL(_si, _address) \
> +	__AD719x_CHANNEL(_si, 0, -1, _address, NULL, IIO_TEMP, 0, NULL)
> +
>  static const struct iio_chan_spec ad7192_channels[] = {
> -	AD_SD_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M, 24, 32, 0),
> -	AD_SD_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M, 24, 32, 0),
> -	AD_SD_TEMP_CHANNEL(2, AD7192_CH_TEMP, 24, 32, 0),
> -	AD_SD_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M, 24, 32, 0),
> -	AD_SD_CHANNEL(4, 1, AD7192_CH_AIN1, 24, 32, 0),
> -	AD_SD_CHANNEL(5, 2, AD7192_CH_AIN2, 24, 32, 0),
> -	AD_SD_CHANNEL(6, 3, AD7192_CH_AIN3, 24, 32, 0),
> -	AD_SD_CHANNEL(7, 4, AD7192_CH_AIN4, 24, 32, 0),
> +	AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
> +	AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
> +	AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
> +	AD719x_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M),
> +	AD719x_CHANNEL(4, 1, AD7192_CH_AIN1),
> +	AD719x_CHANNEL(5, 2, AD7192_CH_AIN2),
> +	AD719x_CHANNEL(6, 3, AD7192_CH_AIN3),
> +	AD719x_CHANNEL(7, 4, AD7192_CH_AIN4),
>  	IIO_CHAN_SOFT_TIMESTAMP(8),
>  };
>  
>  static const struct iio_chan_spec ad7193_channels[] = {
> -	AD_SD_DIFF_CHANNEL(0, 1, 2, AD7193_CH_AIN1P_AIN2M, 24, 32, 0),
> -	AD_SD_DIFF_CHANNEL(1, 3, 4, AD7193_CH_AIN3P_AIN4M, 24, 32, 0),
> -	AD_SD_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M, 24, 32, 0),
> -	AD_SD_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M, 24, 32, 0),
> -	AD_SD_TEMP_CHANNEL(4, AD7193_CH_TEMP, 24, 32, 0),
> -	AD_SD_SHORTED_CHANNEL(5, 2, AD7193_CH_AIN2P_AIN2M, 24, 32, 0),
> -	AD_SD_CHANNEL(6, 1, AD7193_CH_AIN1, 24, 32, 0),
> -	AD_SD_CHANNEL(7, 2, AD7193_CH_AIN2, 24, 32, 0),
> -	AD_SD_CHANNEL(8, 3, AD7193_CH_AIN3, 24, 32, 0),
> -	AD_SD_CHANNEL(9, 4, AD7193_CH_AIN4, 24, 32, 0),
> -	AD_SD_CHANNEL(10, 5, AD7193_CH_AIN5, 24, 32, 0),
> -	AD_SD_CHANNEL(11, 6, AD7193_CH_AIN6, 24, 32, 0),
> -	AD_SD_CHANNEL(12, 7, AD7193_CH_AIN7, 24, 32, 0),
> -	AD_SD_CHANNEL(13, 8, AD7193_CH_AIN8, 24, 32, 0),
> +	AD719x_DIFF_CHANNEL(0, 1, 2, AD7193_CH_AIN1P_AIN2M),
> +	AD719x_DIFF_CHANNEL(1, 3, 4, AD7193_CH_AIN3P_AIN4M),
> +	AD719x_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
> +	AD719x_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M),
> +	AD719x_TEMP_CHANNEL(4, AD7193_CH_TEMP),
> +	AD719x_SHORTED_CHANNEL(5, 2, AD7193_CH_AIN2P_AIN2M),
> +	AD719x_CHANNEL(6, 1, AD7193_CH_AIN1),
> +	AD719x_CHANNEL(7, 2, AD7193_CH_AIN2),
> +	AD719x_CHANNEL(8, 3, AD7193_CH_AIN3),
> +	AD719x_CHANNEL(9, 4, AD7193_CH_AIN4),
> +	AD719x_CHANNEL(10, 5, AD7193_CH_AIN5),
> +	AD719x_CHANNEL(11, 6, AD7193_CH_AIN6),
> +	AD719x_CHANNEL(12, 7, AD7193_CH_AIN7),
> +	AD719x_CHANNEL(13, 8, AD7193_CH_AIN8),
>  	IIO_CHAN_SOFT_TIMESTAMP(14),
>  };
>  
>  static int ad7192_channels_config(struct iio_dev *indio_dev)
>  {
>  	struct ad7192_state *st = iio_priv(indio_dev);
> -	const struct iio_chan_spec *channels;
> -	struct iio_chan_spec *chan;
> -	int i;
>  
>  	switch (st->devid) {
>  	case ID_AD7193:
> -		channels = ad7193_channels;
> +		indio_dev->channels = ad7193_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(ad7193_channels);
>  		break;
>  	default:
> -		channels = ad7192_channels;
> +		indio_dev->channels = ad7192_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(ad7192_channels);
>  		break;
>  	}
>  
> -	chan = devm_kcalloc(indio_dev->dev.parent, indio_dev->num_channels,
> -			    sizeof(*chan), GFP_KERNEL);
> -	if (!chan)
> -		return -ENOMEM;
> -
> -	indio_dev->channels = chan;
> -
> -	for (i = 0; i < indio_dev->num_channels; i++) {
> -		*chan = channels[i];
> -		chan->info_mask_shared_by_all |=
> -			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY);
> -		if (chan->type != IIO_TEMP) {
> -			chan->info_mask_shared_by_type_available |=
> -				BIT(IIO_CHAN_INFO_SCALE);
> -			chan->ext_info = ad7192_calibsys_ext_info;
> -		}
> -		chan++;
> -	}
> -
>  	return 0;
>  }
>  

