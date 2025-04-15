Return-Path: <linux-iio+bounces-18150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ACDA8AB45
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 00:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBEBC7A21DF
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3296C289344;
	Tue, 15 Apr 2025 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cKmt+PLk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A890F24397A
	for <linux-iio@vger.kernel.org>; Tue, 15 Apr 2025 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755940; cv=none; b=WefCFpY5knT9RJobejUHq3tbQbmGH0xm60H0Zu3sUm06m2uyDO8UJjqgAMb1f1ILz5nWt7krSpSBTTR8oe4hz8xVax1N0RGR8gRLexR4GM/4uNP2AoEb+97T048Txdjn9cIf8JfzFyoSjqY67ovI+L8oQUyXwAFPaHjx1JXjR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755940; c=relaxed/simple;
	bh=gGSD0CWGPy24MKZUpaTIEP/iS1AfnleyWsM/vgcWFu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5Tsvcko/yq7BiMHar6v26e0sBgdZ8jYiAppa1sIuEthTsFXMgifG2oD4V/aEUp4MdwI35ZWtNJpiU9n/198CRjIxG6KiFsXb7Ss88/Tc4DlKNJa6+7fKugACxfG1us4GTRQ8JIN1B+j1AhJ4ghK1PHYAPKPZV5LXDdFlt8S/TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cKmt+PLk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2264aefc45dso91029295ad.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Apr 2025 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744755936; x=1745360736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fuXWDiU20Sf9ZYkFZ5DAYPiYmbHBo8nFl2I2ufv9pM=;
        b=cKmt+PLkl04j5+jkcaIBNBGZg5vVlRJR7zagsTobFucS1PzWd6T75nMcQu1+N5URQt
         6G/WsjOM+yYFU02ncSIfn47OViLCkNkEsIX3M8fcsuN8g+rNdzY8icEZUmRCbYBYDgO9
         UnewsHdQMeEpn+ehYW6RYffCZEfHh94zC7+htokTcmrhhc7Ogp/zu7atgic+i83hZIPM
         AVnIc7ca0Ae1Sr4PavRgSFbJgrSqVK201q+11ADGw0l/xxuKi51m7iA5wijaGQ97V9Kj
         Qi8kq6RtEa6waaAx7OT8umgQAeooUXv4O86WULRToqUXnIE5HFRqOSJTCG2HvZBFv+OM
         W4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744755936; x=1745360736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fuXWDiU20Sf9ZYkFZ5DAYPiYmbHBo8nFl2I2ufv9pM=;
        b=M2Y9LQ+Ax1hk4p5t12qJ9SnOIYM0OI9zJ+xS0A7/QcbLHi9ndX1UaxskIepsy8hgp0
         5lpkw14KHIiQiOPOk6LFzE2ZLWAqurq4vlyA/doiSOqdBij28cvmTOKd9rtv8/TsS9O9
         IguwO5Lng0SJbb9x3+7h6nY5+QfldgxkEETP39xW3K9dUWdNiM+Bi7XeGRjRuLJKWCYD
         NbRpctpyeIS1Us+HTkTjgEkmNiTv1yn+htwttK9BjPyxeoxJzR99WzBClttEqBcvbzBX
         1WqYjGDttZZxcWm23ILXJ7+0QB6xzmmomb2Gr5W+D4SzEM1yWCgbZvqE+YcTalFecxXQ
         YC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYGGQOWYApQBjVMifBJckvc5g4NPat6MSEdBP7EneqvX8vNjMIYrMUeGFgFCjufSDdW9/Kb+gDaTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBliR6Wjpdage+sLYaJaeNw8krvqkemRygcJlRDfwkp2r8bHt
	ImQdpOMSozMIbbYgW0ZLTpALNYIqbLkZxxlQWDGmTWj/uBT3mkVNNjnpzQn7sRU=
X-Gm-Gg: ASbGncuAsLJrIEIN+jGwC4llfzmJfMeVrsexZMcj3HoVxLnIx69FpK1auRYwrCuSAQv
	/c9xKzgI7L6cFRvM+5ywwFukvlK8FuTFHLNV33pHvMHZCpD2jw4/lO+t6MoJFfVNT2FDtMad2hj
	+q9ulN2FmSaXObCzj1545Kkt07r/9U2xNUVg3Xu00MC5N/xeQgKZhezzDuRN+qh/IDHt58qvZbJ
	GiY5AoEBQLgA2Z7pBFbgXuLV8AJDbJuE0Hr6GOT+l+yplJu1jSIPZGweipyWJTjydJPHx0OV6uf
	LTWu+gMDrIbjbLMTPHQ/UhEgnYalXzmqEGk9eavKvBrCB+Euma3fD8cUhubdsuVINALZxyZhFTS
	i
X-Google-Smtp-Source: AGHT+IHcP/y9sOhdqTXx+CzHnAkpFEegaFiMWTBYUuZTI6u7KezT4jTw8ONp+O7d4rHZKOQdUAY7jQ==
X-Received: by 2002:a17:902:f650:b0:224:584:6f05 with SMTP id d9443c01a7336-22c31a86891mr13687825ad.41.1744755935917;
        Tue, 15 Apr 2025 15:25:35 -0700 (PDT)
Received: from dev-linux (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fe6dc5sm400445ad.228.2025.04.15.15.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:25:35 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:25:32 -0700
From: Sukrut Bellary <sbellary@baylibre.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-adc128s052: Add lower resolution
 devices support
Message-ID: <Z/7c3HgvkjB770ep@dev-linux>
References: <20250408132120.836461-1-sbellary@baylibre.com>
 <20250408132120.836461-3-sbellary@baylibre.com>
 <cb81cba4-0fa3-431a-924f-b362fd0c4638@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb81cba4-0fa3-431a-924f-b362fd0c4638@gmail.com>

On Mon, Apr 14, 2025 at 09:40:03AM +0300, Matti Vaittinen wrote:
> On 08/04/2025 16:21, Sukrut Bellary wrote:
> > The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> > interface. The device family responds with 12-bit data, of which the LSB
> > bits are transmitted by the lower resolution devices as 0.
> > The unavailable bits are 0 in LSB.
> > Shift is calculated per resolution and used in scaling and
> > raw data read.
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
> 
> I tried looking up:
> https://www.ti.com/lit/gpn/adc102s051.pdf

Sorry about that. I missed to check the link before submitting the
patch series v3.

> > 
> > Tested only with ti-adc102s051 on BegalePlay SBC.
> > https://www.beagleboard.org/boards/beagleplay
> > 
> > Co-developed-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
> > ---
> > Changes in v3:
> >          - used be16_to_cpu() for the endian conversion.
> >          - used config index enum while setting up the adc128_config[]
> > 
> > - Link to v2:
> >          https://lore.kernel.org/lkml/20231022031203.632153-1-sukrut.bellary@linux.com/
> > 
> > Changes in v2:
> >          - Arranged of_device_id and spi_device_id in numeric order.
> >          - Used enum to index into adc128_config.
> >          - Reorder adc128_config in alphabetical.
> >          - Include channel resolution information.
> >          - Shift is calculated per resolution and used in scaling and
> >          raw data read.
> > 
> > - Link to v1: https://lore.kernel.org/all/20220701042919.18180-1-nm@ti.com/
> > ---
> >   drivers/iio/adc/ti-adc128s052.c | 149 ++++++++++++++++++++++++--------
> >   1 file changed, 112 insertions(+), 37 deletions(-)
> > 
> 
> Hi dee Ho,
> 
> Thanks for improving this! It's always nice to be able to support more
> devices with small(ish) changes!
> 
> This looks good to me. I will take another, hopefully more in-depth look at
> the rebased version when available though.
> 
> I have just one comment for now, but it's not strictly related to this
> change. If you wish to go the extra mile, then I'd appreciated it. If not,
> then it can be re-worked later. Anyways, please, see below.
> 
> > diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> > index a456ea78462f..d4b76fd85abd 100644
> > --- a/drivers/iio/adc/ti-adc128s052.c
> > +++ b/drivers/iio/adc/ti-adc128s052.c
> > @@ -7,6 +7,22 @@
> >    * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
> >    * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
> >    * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
> > + *
> > + * The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> > + * interface. This driver supports the whole family of devices with a name
> > + * ADC<bb><c>S<sss>, where
> > + * bb is the resolution in number of bits (8, 10, 12)
> > + * c is the number of channels (1, 2, 4, 8)
> > + * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> > + * and 101 for 1 MSPS)
> > + *
> > + * Complete datasheets are available at TI's website here:
> > + *   https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
> > + *
> > + * 8, 10, and 12 bits converters send 12-bit data with
> > + * unavailable bits set to 0 in LSB.
> > + * Shift is calculated per resolution and used in scaling and
> > + * raw data read.
> >    */
> >   #include <linux/err.h>
> > @@ -53,7 +69,7 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
> >   	if (ret < 0)
> >   		return ret;
> > -	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
> > +	return be16_to_cpu(*((__be16 *)adc->buffer));
> >   }
> >   static int adc128_read_raw(struct iio_dev *indio_dev,
> > @@ -70,7 +86,8 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
> >   		if (ret < 0)
> >   			return ret;
> > -		*val = ret;
> > +		*val = (ret >> channel->scan_type.shift) &
> > +			GENMASK(channel->scan_type.realbits - 1, 0);
> >   		return IIO_VAL_INT;
> >   	case IIO_CHAN_INFO_SCALE:
> > @@ -80,7 +97,7 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
> >   			return ret;
> >   		*val = ret / 1000;
> > -		*val2 = 12;
> > +		*val2 = channel->scan_type.realbits;
> >   		return IIO_VAL_FRACTIONAL_LOG2;
> >   	default:
> > @@ -89,24 +106,34 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
> >   }
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
> > +			.shift = (12 - real_bits),			\
> > +		},							\
> >   	}
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
> >   };
> >   static const struct iio_chan_spec adc122s021_channels[] = {
> > @@ -121,10 +148,46 @@ static const struct iio_chan_spec adc124s021_channels[] = {
> >   	ADC128_VOLTAGE_CHANNEL(3),
> >   };
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
> 
> I like the fact you added these indexes as it makes this a lot clearer.
> But...
> 
> > +
> >   static const struct adc128_configuration adc128_config[] = {
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
> >   };
> 
> ... I don't really love this array. I believe the code would be clearer if
> this array was changed to individual structs because ...
> 
> >   static const struct iio_info adc128_info = {
> > @@ -177,31 +240,43 @@ static int adc128_probe(struct spi_device *spi)
> >   }
> >   static const struct of_device_id adc128_of_match[] = {
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
> 
> ... here we could then directly refer to individual structs. That way we
> would not need to define the names for the array indexes (for clarity), or
> look up the individual array members based on magic numbers.

Thanks for the review.
yes, I will take care of this in v4.

> >   	{ /* sentinel */ },
> >   };
> >   MODULE_DEVICE_TABLE(of, adc128_of_match);
> 
> Yours,
> 	-- Matti

