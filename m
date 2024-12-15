Return-Path: <linux-iio+bounces-13487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD5E9F2392
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 13:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF0A1652EF
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 12:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE015534E;
	Sun, 15 Dec 2024 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vM7yxdex"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B67638384;
	Sun, 15 Dec 2024 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734264335; cv=none; b=Je+fC9CusUA+wLiq4eunCT+uLWnMi9mTXU8t79B/A1o3EokVa/0N1jOoWmtLvi8kf4lMOOGK5UlWqY2qAHjPd9gIkEmAMY/7nGaYJhKHw51p80vFvvnOIjbSGQCa0iidCfWc6wzyfrRglVw8hPFloblB5pPC1GVS3OLnL0Slz/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734264335; c=relaxed/simple;
	bh=tkWNbT4uu+gfMrKCNqOzvi4TJkR3xUxhFs0MxlXbYdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svDp1Y+P7gctfd6gwbj8V0aQ+5EzJynRDHVxleZ3pjRRbr5eMWPng4OYbVYCb4/aGgV0IQmPNqOGvAJRIjxmR/JsoPiT0ca6O/TgARxbi/xR+ujeRm5oKvxPQRwuxNHdeY8RjtHvwZcdFcv4vkk3dvEEHJLZR+i5Q6jBo3jm/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vM7yxdex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6637EC4CECE;
	Sun, 15 Dec 2024 12:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734264334;
	bh=tkWNbT4uu+gfMrKCNqOzvi4TJkR3xUxhFs0MxlXbYdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vM7yxdex6QK/h27rlfikgkUfa5nwIK+ZB11Zy+rM81IAcfpe0Blz8+Ko9k4aJyAqj
	 4mNgBOD/2/Ys17CXSPmBgcFnNiO8m2JIm2SNJQSbPA7TidwsvJX44yFjlfce581EUZ
	 u57e5Jp870ojrHA1QWWSxPOXHNXA80Oe4vVgumVstE+2HLe+x85lJOHPJsb9FQehQh
	 kM04jKZu84iNdHHD6DehQm7pvKVlcQDQX1rXV5Czk/xI++N2RXimBHDYYVl0LMSzi8
	 L2z41mAZTCFrUURFNU/7YwNfEYIMkTvOLeHdfpynxsKj08K2maU8aWMpx/co9TAPRW
	 gHnzXUuBn/lfQ==
Date: Sun, 15 Dec 2024 12:05:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com,
 aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH v2 6/9] iio: adc: adi-axi-adc: Add support for AD7606
 register writing
Message-ID: <20241215120523.1b60ed43@jic23-huawei>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-6-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
	<20241210-ad7606_add_iio_backend_software_mode-v2-6-6619c3e50d81@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 10:46:46 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Since we must access the bus parallel bus using a custom procedure,
> let's add a specialized compatible, and define specialized callbacks for
> writing the registers using the parallel interface.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Hi Guillaume,

A few comments inline.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ad7606_bi.h   |  16 +++++++
>  drivers/iio/adc/adi-axi-adc.c | 100 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7606_bi.h b/drivers/iio/adc/ad7606_bi.h
> new file mode 100644
> index 000000000000..9ade23ec61dd
> --- /dev/null
> +++ b/drivers/iio/adc/ad7606_bi.h

Why bi?  Bus interface?  I'd spell it out.  Header name lengths don't
usually need to be quite this short.

> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2010-2024 Analog Devices Inc.
> + * Copyright (c) 2024 Baylibre, SAS
> + */
> +#ifndef __LINUX_PLATFORM_DATA_AD7606_H__
> +#define __LINUX_PLATFORM_DATA_AD7606_H__
> +
> +#include <linux/iio/backend.h>
Only a pointer type needed, so a forward def better than an include
(which costs some trivial amount of compile time).

struct iio_backend;

> +
> +struct ad7606_platform_data {
> +	int (*bus_reg_read)(struct iio_backend *back, u32 reg, u32 *val);
> +	int (*bus_reg_write)(struct iio_backend *back, u32 reg, u32 val);
> +};
> +
> +#endif /* __LINUX_PLATFORM_DATA_AD7606_H__ */
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 7ff636643e56..b8bcf89417b0 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -27,6 +27,7 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  
> +#include "ad7606_bi.h"
>  /*
>   * Register definitions:
>   *   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip#register_map
> @@ -73,6 +74,12 @@
>  #define ADI_AXI_ADC_REG_DELAY(l)		(0x0800 + (l) * 0x4)
>  #define   AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
>  
> +#define ADI_AXI_REG_CONFIG_WR			0x0080
> +#define ADI_AXI_REG_CONFIG_RD			0x0084
> +#define ADI_AXI_REG_CONFIG_CTRL			0x008c
> +#define   ADI_AXI_REG_CONFIG_CTRL_READ		0x03
> +#define   ADI_AXI_REG_CONFIG_CTRL_WRITE		0x01
> +
>  #define ADI_AXI_ADC_MAX_IO_NUM_LANES		15
>  
>  #define ADI_AXI_REG_CHAN_CTRL_DEFAULTS		\
> @@ -80,6 +87,11 @@
>  	 ADI_AXI_REG_CHAN_CTRL_FMT_EN |		\
>  	 ADI_AXI_REG_CHAN_CTRL_ENABLE)
>  
> +/* AD7606's specific */
> +#define AD7606_REG_READ_BIT			0x8000
> +#define AD7606_REG_ADDRESS_MASK			0xff00
> +#define AD7606_REG_VALUE_MASK			0x00ff
> +

Maybe name these to keep the ADI_AXI_ prefix as well.  Otherwise it might get
a little confusing wrt to registers in teh deivce.  They are nice short
names currently so that shouldn't make the code to messy.

>  struct axi_adc_info {
>  	unsigned int version;
>  	const struct iio_backend_info *backend_info;
> @@ -313,6 +325,80 @@ static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  	return iio_dmaengine_buffer_setup(st->dev, indio_dev, dma_name);
>  }
>  
> +static int axi_adc_raw_write(struct iio_backend *back, void *buf, unsigned int len)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	u32 data;
> +	u32 *bdata = buf;

	data = *(u32)(buf);

Is fine here I think rather than the extra local variable that is just
used to do the type cast.

> +
> +	data = *bdata;
> +	regmap_write(st->regmap, ADI_AXI_REG_CONFIG_WR, data);
> +	regmap_write(st->regmap, ADI_AXI_REG_CONFIG_CTRL,
> +		     ADI_AXI_REG_CONFIG_CTRL_WRITE);
> +	usleep_range(50, 100);
> +	regmap_write(st->regmap, ADI_AXI_REG_CONFIG_CTRL, 0x00);
> +	usleep_range(50, 100);
> +
> +	return 0;
> +}

...

> +
> +static int ad7606_bi_reg_write(struct iio_backend *back, u32 reg, u32 val)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	u32 buf;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* Read any register to switch to register mode */

What follows looks like a write...

> +	buf = 0xaf00;
> +	axi_adc_raw_write(back, &buf, sizeof(buf));
> +
> +	buf = FIELD_PREP(AD7606_REG_ADDRESS_MASK, reg) | FIELD_PREP(AD7606_REG_VALUE_MASK, val);
> +	axi_adc_raw_write(back, &buf, sizeof(buf));
> +
> +	/* Write 0x0 on the bus to get back to ADC mode */
> +	buf = 0;
> +	axi_adc_raw_write(back, &buf, sizeof(buf));
> +
> +	return 0;
> +}


