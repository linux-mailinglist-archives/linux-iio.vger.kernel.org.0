Return-Path: <linux-iio+bounces-4842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852D58BCF83
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 15:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2E61F2323B
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C05811FE;
	Mon,  6 May 2024 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwypjOc5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CA1DA22;
	Mon,  6 May 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003791; cv=none; b=T7DfyDkHVHqmJU9w9JOKplCk7pjKb+FWQJZE3WFPfyIqOIEV171+yKKobenqYW6ArqAZFxPMmdyyKgc6YV6pBjbBs9R85bufhUNzjkYcMpxPAHAvBIFH1loWdebuuDM1LAxaFiXFqYjxIdJFFnykqVefM4/tQuCkAnRMU2PDIgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003791; c=relaxed/simple;
	bh=kqCz4Btya3yPuVmc0GJcrjYPV1o+yZRdXKotJjRVcH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WomSrSIwN8H42QwIahIKb0MnE5vHu/nMFS7pB0hq08fnZl5FYjgtIaYM6+sOORaAWQgJHWkYIqs6suWuCnIvAWMh1zqyCmF2XWkvM7nI7MlbCPt80TPLxzLEzyvMzl4yl+PFN5OCpaYexshal466hfJnANxNjpfi9pL/k5V2Jng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwypjOc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638D6C4AF63;
	Mon,  6 May 2024 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715003790;
	bh=kqCz4Btya3yPuVmc0GJcrjYPV1o+yZRdXKotJjRVcH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YwypjOc5k7bLp8P8nrsaCDppA/QGL/skc89iZz0AHZCNY7hgZhlAP2Tfu7ujTO/1v
	 Rq0c5Ze62LbC/BbY03c4IK0TDdDkBMNICAE7Yxti9T9rI0fuk/g0Zijw8pdWL6IlS2
	 4AiI8Ul5fr+v3aQgSD1XbR7pEoci8eElGd4srdUqOOaRx8FrnGY/adw/Yew/x4lg15
	 YeR0zFvv25g45CYEB3KmqGW9hGL3mt0lW6J/HXHQF9csNe37qZTe5LgITYoMgPUhL5
	 ZpVULcb1Sw6yLtrGfMhyGU15XWA51JTP1xlyNDM9CrTOq1xV8Lt7ZBgAlqwjCH6i83
	 pRNDuif0kFd/g==
Date: Mon, 6 May 2024 14:56:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, kernel test robot <lkp@intel.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH RFC v6 02/10] iio: adc: ad7380: new driver for AD7380
 ADCs
Message-ID: <20240506145616.243a2433@jic23-huawei>
In-Reply-To: <20240501-adding-new-ad738x-driver-v6-2-3c0741154728@baylibre.com>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
	<20240501-adding-new-ad738x-driver-v6-2-3c0741154728@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 May 2024 16:55:35 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> From: David Lechner <dlechner@baylibre.com>
> 
> This adds a new driver for the AD7380 family ADCs.
> 
> The driver currently implements basic support for the AD7380, AD7381,
> 2-channel differential ADCs. Support for additional single-ended,
> pseudo-differential and 4-channel chips that use the same register map
> as well as additional features of the chip will be added in future patches.
> 
> Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> [Julien Stephan: add datasheet links of supported parts]
> [Julien Stephan: fix rx/tx buffer for regmap access]
> [Julien Stephan: fix scale issue]
> [Julien Stephan: use the new iio_device_claim_direct_scoped
> instead of iio_device_claim_direct_mode]
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

I took another look, mostly so I could refresh my memory of the driver
before getting to the newer patches.

A few minor things inline, + I wondering if the structure for the
scan is what was meant about keeping timestamps in the same place.

> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> new file mode 100644
> index 000000000000..a218f59c276e
> --- /dev/null
> +++ b/drivers/iio/adc/ad7380.c
> @@ -0,0 +1,443 @@

> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

This and linux/sysfs.h are are normally only needed it you are providing
custom attrs.  I don't see those here so not sure those headers are used
directly by this driver.

> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +

> +struct ad7380_state {
> +	const struct ad7380_chip_info *chip_info;
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	unsigned int vref_mv;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 * Make the buffer large enough for 2 16-bit samples and one 64-bit
> +	 * aligned 64 bit timestamp.
> +	 */
> +	struct {
> +		u16 raw[2];
> +
> +		s64 ts __aligned(8);

Ah is the comment in patch 10 about consistent timestamps coming from this?
If so then don't worry about that - you just loose the pretty option of
using a structure to define the data layout.

	union {
		u16 raw[4 + 4] __aligned(8); /* include the ts*/
		u32 raw[4 + 2] __aligned(8);  /* include ts */
	} scan_data __aligned(IIO_DMA_MINALIGN);

There are lots of drivers that are highly flexible in how many
channels we have so they always have to take this more manual path
to data sizing.   Some do magic with ALIGN() so if you want you could
do something like that here. That magic ensures the right amount of
padding to have the naturally aligned 8 byte timestamp in an array of
smaller type.	

Note you can't solve this by putting the timestamp first because it
is always optional whether it is enabled (that bit is just dealt with
by the IIO core rather than a driver).

> +	} scan_data __aligned(IIO_DMA_MINALIGN);
> +	u16 tx;
> +	u16 rx;
> +};

> +static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
> +				     u32 writeval, u32 *readval)
> +{
> +	iio_device_claim_direct_scoped(return  -EBUSY, indio_dev) {
> +		struct ad7380_state *st = iio_priv(indio_dev);
> +		int ret;
> +
> +		if (readval)
> +			ret = regmap_read(st->regmap, reg, readval);
Trivial, but 
			return regmap_read()
> +		else
> +			ret = regmap_write(st->regmap, reg, writeval);
			return regmap_write()

unless something gets added here later in the series.

> +
> +		return ret;
> +	}
> +	unreachable();
> +}


