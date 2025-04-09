Return-Path: <linux-iio+bounces-17898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B911A83386
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 23:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5373BA510
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 21:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E8E2AC17;
	Wed,  9 Apr 2025 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hgn7ZW8J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F24C2116F1
	for <linux-iio@vger.kernel.org>; Wed,  9 Apr 2025 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744234953; cv=none; b=jKGgTqBuSHebSdS/BfZVSttpKJMScP/QWcoSBgpmXpS3hD775f3WOi5her6vlq9sBr468ZYXCaKNxH5znsowVtvl4Q3iO9UGoR9eee5kp6xvaHiV+1AlJjnwjf+RHNLFvl4oHQOu+zu400seXf5bzHF68KPsD8VniP7ODVFGMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744234953; c=relaxed/simple;
	bh=cfJPQ2csCV/nOg33ipaPN6bsrYIHeDxIzO5gVFkRRmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpJ2gUacRj6q0bwWBQJhDMjpQ+VHJZSO6Iqb4PCFmYmn8xDnRQF70jwnJtdgdsi1AFKtgHegW/k2aBrXHumi7mfOTrnHIUcqqZ4I3wzoQpS0nKE5RfDVZrOiKVaVZhkva4H9qobw2TC/ZQUjXc0xZGrr676LRmRXOjjDOcAdItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hgn7ZW8J; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73bb647eb23so82204b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2025 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744234950; x=1744839750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PSDf8jS5yD0Drp3/LuCz3kudLOGiq/80jWmpcNRXqNw=;
        b=hgn7ZW8JgijVkOVYgE66WvtMh+ImSW1Fc0Fx4ibIkbCipABWVRC4K4Am0itYJAdrN5
         +Yhwsu8llaUXgg6fmArilgAdHjcUvNi0GnP8YOe/BA9DJRT0J3cUliNZHyleXImBfYUC
         v9gRIJt56J8u9yjzb9bcNbp4yx0oUOrpfnoEktMCnbr4+g2snRMn5X+i1ng1D8SZNkms
         6GfXEJsefor6OLaRaffXGr8OkSRPq/nIrRw+B/wUbMwSKQQRFhju95G6PYmlbOMrXFmd
         TVAOh424q1bCqJ2g6qj3XzK2sj5z1J5h4o9NBcUax0/AOGm02bCqua9lbb7Vg1xDqGYg
         tnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744234950; x=1744839750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSDf8jS5yD0Drp3/LuCz3kudLOGiq/80jWmpcNRXqNw=;
        b=YJ6mVAeVt8VAQ9SSkh+QB7ernKPZ5UxhcmfHs8/RgVNqttK5KjFqsy2AkV3P5ftOma
         //LwyHIX18WHBT3gdo49QCGWsj52wvfbnxBKU/GrgDKi95kz32n7Md++q+gpW3CAL1dx
         PfmXIaNi3gA0Y22FHxICAV11w3Er4+ZNwJzuSWBm5UigD5odRll++vlB8Ylc8zIdkRT6
         o/sbUpF4fhG3qDbicWuMdFkW6fN9Hpi4uSQjLKgXF0GKSsotZ+a9d2ZiKhRkpauuHfFI
         6un7aS7Uvs55bDXl4M0+bgiW88GRjYD+NBWQMQ2r8MsqYZLsui0UyRq7aFdxjOEoLZ+k
         ExCg==
X-Forwarded-Encrypted: i=1; AJvYcCWEQLsLhNm9TV/SCaGoIvCw6H0+HFOE+GgmNx5GvjtDfep1CAjpU/vkgU5jZDe0xgPS6cA6mUqUrcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypBOSX+N/AQaDnKF2Sy2z9bdTH+one2fn68Y4wRReZC2U9qEG6
	KWRm7WYN/qEi9LCKA1F3hN5i8AEGsxpX8EHGdo7GDXOcY1gkAcugzTuyb9afaao=
X-Gm-Gg: ASbGncvUlnpHJDuhVlx1FvLlzLSRTM4uT1Q8b+X85R2TyDnfD3ffjVXgssWUgiyw0PW
	dvCOOrLJsYFzZ/icP2/mZYIYle3HWtBQg5YMKEGb8GMons/nCb7h5SwC9IxevrrhpSJoJOQn1mf
	phPgv5zUfeMYvbs+WpBnqY+nB28Y9snFwmlTPeCVqRmVMz/r9ij23jKGutVsA+pSaNbc9eHjuUy
	kVVAZq5kfukyTdLHfY1QLRrIorPVLERjr8BIVdQjEOiouepvcUJFImTZ9QNwf7VmcVxMGo+LB8a
	9JKRzdGYwP2adZCbH9Y2j7OJ2sKSzl9D5FJX2/YJ53SaKJTuwONiw1SU7zdZy1TLtEDJ3TQCGOn
	fqwlXJNGN888=
X-Google-Smtp-Source: AGHT+IH21z3+gRyC6UEn+n4zbaJfKLGfAM719YHE8Kw8mV7/twG26me6iN7MJkg2sySpsZTxa/N0aA==
X-Received: by 2002:a05:6a00:1152:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-73bbefa53edmr484440b3a.15.1744234949597;
        Wed, 09 Apr 2025 14:42:29 -0700 (PDT)
Received: from dev-linux (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e51f48sm1925155b3a.147.2025.04.09.14.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 14:42:29 -0700 (PDT)
Date: Wed, 9 Apr 2025 14:42:26 -0700
From: Sukrut Bellary <sbellary@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-adc128s052: Add lower resolution
 devices support
Message-ID: <Z/bpwq/i91+Xlljf@dev-linux>
References: <20250408132120.836461-1-sbellary@baylibre.com>
 <20250408132120.836461-3-sbellary@baylibre.com>
 <25291cca-a456-4f6c-8aac-466cd6124683@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25291cca-a456-4f6c-8aac-466cd6124683@baylibre.com>

On Tue, Apr 08, 2025 at 03:57:32PM -0500, David Lechner wrote:
> On 4/8/25 8:21 AM, Sukrut Bellary wrote:
> > The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> > interface. The device family responds with 12-bit data, of which the LSB
> > bits are transmitted by the lower resolution devices as 0.
> > The unavailable bits are 0 in LSB.
> > Shift is calculated per resolution and used in scaling and
> > raw data read.
> 
> Could improve the line wrapping in the commit message if there is a v4.

Thanks for the review.
Ok, I will improve in v4.

> > 
> > Lets reuse the driver to support the family of devices with name
> > ADC<bb><c>S<sss>, where
> > * bb is the resolution in number of bits (8, 10, 12)
> > * c is the number of channels (1, 2, 4, 8)
> > * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> > and 101 for 1 MSPS)
> > 
> > Complete datasheets are available at TI's website here:
> > https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
> > 
> > Tested only with ti-adc102s051 on BegalePlay SBC.
> > https://www.beagleboard.org/boards/beagleplay
> > 
> > Co-developed-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
> > ---
> 
> I didn't see any serious issues, just some room for more polish...
> 
> > Changes in v3: 
> >         - used be16_to_cpu() for the endian conversion.
> >         - used config index enum while setting up the adc128_config[]
> > 
> > - Link to v2: 
> >         https://lore.kernel.org/lkml/20231022031203.632153-1-sukrut.bellary@linux.com/
> > 
> > Changes in v2:
> >         - Arranged of_device_id and spi_device_id in numeric order.
> >         - Used enum to index into adc128_config.
> >         - Reorder adc128_config in alphabetical.
> >         - Include channel resolution information.
> >         - Shift is calculated per resolution and used in scaling and 
> >         raw data read.
> > 
> > - Link to v1: https://lore.kernel.org/all/20220701042919.18180-1-nm@ti.com/
> > ---
> >  drivers/iio/adc/ti-adc128s052.c | 149 ++++++++++++++++++++++++--------
> >  1 file changed, 112 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> > index a456ea78462f..d4b76fd85abd 100644
> > --- a/drivers/iio/adc/ti-adc128s052.c
> > +++ b/drivers/iio/adc/ti-adc128s052.c
> > @@ -7,6 +7,22 @@
> >   * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
> >   * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
> >   * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
> > + *
> > + * The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> > + * interface. This driver supports the whole family of devices with a name
> > + * ADC<bb><c>S<sss>, where
> > + * bb is the resolution in number of bits (8, 10, 12)
> > + * c is the number of channels (1, 2, 4, 8)
> > + * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> > + * and 101 for 1 MSPS)
> 
> Looks like odd line wrapping. I assume bullet points were meant here?

* were part of comments. I will fix line wrapping.

> * ... where:
> * - bb is ...
> * - c is ...
> * - sss is ...
> 
> > + *
> > + * Complete datasheets are available at TI's website here:
> > + *   https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
> > + *
> > + * 8, 10, and 12 bits converters send 12-bit data with
> > + * unavailable bits set to 0 in LSB.
> > + * Shift is calculated per resolution and used in scaling and
> > + * raw data read.
> >   */
> >  
> >  #include <linux/err.h>
> > @@ -53,7 +69,7 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
> > +	return be16_to_cpu(*((__be16 *)adc->buffer));
> >  }
> >  
> >  static int adc128_read_raw(struct iio_dev *indio_dev,
> > @@ -70,7 +86,8 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
> >  		if (ret < 0)
> >  			return ret;
> >  
> > -		*val = ret;
> > +		*val = (ret >> channel->scan_type.shift) &
> > +			GENMASK(channel->scan_type.realbits - 1, 0);
> 
> It's a bit odd to do this here instead of in the helper function since
> the helper function is doing some rearranging of bits already.
> 
> Could pass scan_type to the helper function and do it all in one
> place.

Ok, I will try with helper in v4.

> >  		return IIO_VAL_INT;
> >  
> >  	case IIO_CHAN_INFO_SCALE:
> > @@ -80,7 +97,7 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
> >  			return ret;
> >  
> >  		*val = ret / 1000;
> > -		*val2 = 12;
> > +		*val2 = channel->scan_type.realbits;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >  
> >  	default:
> > @@ -89,24 +106,34 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
> >  
> >  }
> >  
> > -#define ADC128_VOLTAGE_CHANNEL(num)	\
> > -	{ \
> > -		.type = IIO_VOLTAGE, \
> > -		.indexed = 1, \
> > -		.channel = (num), \
> > -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> > -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
> > +#define _ADC128_VOLTAGE_CHANNEL(num, real_bits, store_bits)		\
> > +	{								\
> > +		.type = IIO_VOLTAGE,					\
> > +		.indexed = 1,						\
> > +		.channel = (num),					\
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> > +		.scan_index = (num),					\
> > +		.scan_type = {						\
> > +			.sign = 'u',					\
> > +			.realbits = (real_bits),			\
> > +			.storagebits = (store_bits),			\
> 
> It looks like storagebits is always 16, so we could drop that parameter.

Sure, I will drop storagebits.

> > +			.shift = (12 - real_bits),			\
> > +		},							\
> >  	}
> >  
> > -static const struct iio_chan_spec adc128s052_channels[] = {
> > -	ADC128_VOLTAGE_CHANNEL(0),
> > -	ADC128_VOLTAGE_CHANNEL(1),
> > -	ADC128_VOLTAGE_CHANNEL(2),
> > -	ADC128_VOLTAGE_CHANNEL(3),
> > -	ADC128_VOLTAGE_CHANNEL(4),
> > -	ADC128_VOLTAGE_CHANNEL(5),
> > -	ADC128_VOLTAGE_CHANNEL(6),
> > -	ADC128_VOLTAGE_CHANNEL(7),
> > +#define ADC082_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 8, 16)
> > +#define ADC102_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 10, 16)
> > +#define ADC128_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 12, 16)
> > +
> > +static const struct iio_chan_spec adc082s021_channels[] = {
> > +	ADC082_VOLTAGE_CHANNEL(0),
> > +	ADC082_VOLTAGE_CHANNEL(1),
> > +};
> > +
> > +static const struct iio_chan_spec adc102s021_channels[] = {
> > +	ADC102_VOLTAGE_CHANNEL(0),
> > +	ADC102_VOLTAGE_CHANNEL(1),
> >  };
> >  
> >  static const struct iio_chan_spec adc122s021_channels[] = {
> > @@ -121,10 +148,46 @@ static const struct iio_chan_spec adc124s021_channels[] = {
> >  	ADC128_VOLTAGE_CHANNEL(3),
> >  };
> >  
> > +static const struct iio_chan_spec adc128s052_channels[] = {
> > +	ADC128_VOLTAGE_CHANNEL(0),
> > +	ADC128_VOLTAGE_CHANNEL(1),
> > +	ADC128_VOLTAGE_CHANNEL(2),
> > +	ADC128_VOLTAGE_CHANNEL(3),
> > +	ADC128_VOLTAGE_CHANNEL(4),
> > +	ADC128_VOLTAGE_CHANNEL(5),
> > +	ADC128_VOLTAGE_CHANNEL(6),
> > +	ADC128_VOLTAGE_CHANNEL(7),
> > +};
> > +
> > +enum adc128_configuration_index {
> > +	ADC128_CONFIG_INDEX_082S,
> > +	ADC128_CONFIG_INDEX_102S,
> > +	ADC128_CONFIG_INDEX_122S,
> > +	ADC128_CONFIG_INDEX_124S,
> > +	ADC128_CONFIG_INDEX_128S,
> > +};
> > +
> >  static const struct adc128_configuration adc128_config[] = {
> 
> I would have rather removed the array here. Adding the enum just
> makes lots more code to read without any technical benefit.
> 
> > -	{ adc128s052_channels, ARRAY_SIZE(adc128s052_channels) },
> > -	{ adc122s021_channels, ARRAY_SIZE(adc122s021_channels) },
> > -	{ adc124s021_channels, ARRAY_SIZE(adc124s021_channels) },
> > +	[ADC128_CONFIG_INDEX_082S] = {
> > +		.channels = adc082s021_channels,
> > +		.num_channels = ARRAY_SIZE(adc082s021_channels)
> > +	},
> > +	[ADC128_CONFIG_INDEX_102S] = {
> > +		.channels = adc102s021_channels,
> > +		.num_channels = ARRAY_SIZE(adc102s021_channels)
> > +	},
> > +	[ADC128_CONFIG_INDEX_122S] = {
> > +		.channels = adc122s021_channels,
> > +		.num_channels = ARRAY_SIZE(adc122s021_channels)
> > +	},
> > +	[ADC128_CONFIG_INDEX_124S] = {
> > +		.channels = adc124s021_channels,
> > +		.num_channels = ARRAY_SIZE(adc124s021_channels)
> > +	},
> > +	[ADC128_CONFIG_INDEX_128S] = {
> > +		.channels = adc128s052_channels,
> > +		.num_channels = ARRAY_SIZE(adc128s052_channels)
> > +	},
> >  };
> 
> I.e. instead:
> 
> static const struct adc128_configuration adc08s021_config = {
> 	.channels = adc082s021_channels,
> 	.num_channels = ARRAY_SIZE(adc082s021_channels),
> };
> 
> static const struct adc128_configuration adc10s021_config = {
> 	.channels = adc102s021_channels,
> 	.num_channels = ARRAY_SIZE(adc102s021_channels)
> };
> 
> ...

OK, I will remove enum.

> >  
> >  static const struct iio_info adc128_info = {
> > @@ -177,31 +240,43 @@ static int adc128_probe(struct spi_device *spi)
> >  }
> >  
> >  static const struct of_device_id adc128_of_match[] = {
> > -	{ .compatible = "ti,adc128s052", .data = &adc128_config[0] },
> > -	{ .compatible = "ti,adc122s021", .data = &adc128_config[1] },
> > -	{ .compatible = "ti,adc122s051", .data = &adc128_config[1] },
> > -	{ .compatible = "ti,adc122s101", .data = &adc128_config[1] },
> > -	{ .compatible = "ti,adc124s021", .data = &adc128_config[2] },
> > -	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
> > -	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
> > +	{ .compatible = "ti,adc082s021", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
> > +	{ .compatible = "ti,adc082s051", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
> > +	{ .compatible = "ti,adc082s101", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
> > +	{ .compatible = "ti,adc102s021", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
> > +	{ .compatible = "ti,adc102s051", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
> > +	{ .compatible = "ti,adc102s101", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
> > +	{ .compatible = "ti,adc122s021", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
> > +	{ .compatible = "ti,adc122s051", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
> > +	{ .compatible = "ti,adc122s101", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
> > +	{ .compatible = "ti,adc124s021", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
> > +	{ .compatible = "ti,adc124s051", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
> > +	{ .compatible = "ti,adc124s101", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
> > +	{ .compatible = "ti,adc128s052", .data = &adc128_config[ADC128_CONFIG_INDEX_128S] },
> >  	{ /* sentinel */ },
> >  };
> >  MODULE_DEVICE_TABLE(of, adc128_of_match);
> 
> It would be easier to see what is new and what is changed if we split out the
> "cleanup" to a separate patch.

This is not a cleanup. Addressed the review comments on v1 i.e., to
arrange of_device_id and spi_device_id in a numeric order. And added
more device ids used enum.

> >  
> >  static const struct spi_device_id adc128_id[] = {
> > -	{ "adc128s052", (kernel_ulong_t)&adc128_config[0] },
> > -	{ "adc122s021",	(kernel_ulong_t)&adc128_config[1] },
> > -	{ "adc122s051",	(kernel_ulong_t)&adc128_config[1] },
> > -	{ "adc122s101",	(kernel_ulong_t)&adc128_config[1] },
> > -	{ "adc124s021", (kernel_ulong_t)&adc128_config[2] },
> > -	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
> > -	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
> > +	{ "adc082s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
> > +	{ "adc082s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
> > +	{ "adc082s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
> > +	{ "adc102s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
> > +	{ "adc102s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
> > +	{ "adc102s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
> > +	{ "adc122s021",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
> > +	{ "adc122s051",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
> > +	{ "adc122s101",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
> > +	{ "adc124s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
> > +	{ "adc124s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
> > +	{ "adc124s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
> > +	{ "adc128s052", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_128S] },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(spi, adc128_id);
> >  
> >  static const struct acpi_device_id adc128_acpi_match[] = {
> > -	{ "AANT1280", (kernel_ulong_t)&adc128_config[2] },
> > +	{ "AANT1280", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
> 

