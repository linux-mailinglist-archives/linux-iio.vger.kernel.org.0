Return-Path: <linux-iio+bounces-23214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59446B33DC3
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1541B4877EB
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBFB2E5418;
	Mon, 25 Aug 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUd114hu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609392DBF46;
	Mon, 25 Aug 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756120604; cv=none; b=mIIykVtNaBNAAOROx1v9XJxczXq5C9XoGi+0tbudUh1/Gzye5nS6n3gnoOU5KoXPw5AE9BJTENGLjnoyJG02gZTIunz3NTCf11cDnQiTUEIhsyLkJWwPKy2hg48LLxbYgjcFeKeki3nUpi8Y1h42H7NnrZTM8PeVdKUiPhValss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756120604; c=relaxed/simple;
	bh=csdrdzRFyjcOF+eH27VJ8NpHjrGrWqDAvSSRKKFYK3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mta7BnOo/TsaBIoEDdTyMyD1weWcxV+TQkEPW92cQfRj8M3rPbXA7qALbzLwTEnfUTIQwkbq/UKKkzVuBqLR8xgSj1zMvJzn26hyyW3FoJtRRgcItPUGaYOJ3qODIJV7MQYqU2HVb+cILXukh8HsZAOX28TxfOJpi3P76fNckEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUd114hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECDFC4CEED;
	Mon, 25 Aug 2025 11:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756120604;
	bh=csdrdzRFyjcOF+eH27VJ8NpHjrGrWqDAvSSRKKFYK3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mUd114hudPE8EoIIdcJ4lVTRQ7oBdCBGnqtyPYqH8Ctco5vyN0NnWRXZYi7U7oam9
	 tdqKNPhulXDdHg1XDYN4prQuN7QZqdbq9SvLEO6DnnBtjSLmNa0/UDQ7t2vkgzKwQy
	 +iLwUmvq8Ym8sW74QJWYwUtB2bWgIP7+LhZGfAwP1kaHH9CWIZNFkeemBmDWglXBg/
	 nE8Cg74UkfPmoLee8AVQL5ikc+XtVlLLu+/ivKl804C3q5N7MquUtmG3mcxKQAWXab
	 dckwO7PlsfOJaOpmX7fY4fu+4PNPO4Xv7sAwE4JwP5ccwipolQPbOlH6CkPq8E0VDA
	 uKVVdndtZcSeg==
Date: Mon, 25 Aug 2025 12:16:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marcelo
 Schmitt <marcelo.schmitt1@gmail.com>, Marcelo Schmitt
 <Marcelo.Schmitt@analog.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>
Subject: Re: [PATCH v1 2/2] iio: adc: Add basic support for MAX14001
Message-ID: <20250825121632.605b50a2@jic23-huawei>
In-Reply-To: <2919a00f86c1188b83446853bcb9740138d70f44.1755778212.git.marilene.agarcia@gmail.com>
References: <cover.1755778211.git.marilene.agarcia@gmail.com>
	<2919a00f86c1188b83446853bcb9740138d70f44.1755778212.git.marilene.agarcia@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 10:39:07 -0300
Marilene Andrade Garcia <marilene.agarcia@gmail.com> wrote:

> The MAX14001/MAX14002 are configurable, isolated 10-bit ADCs for
> multi-range binary inputs. Besides the ADC readings, the MAX14001/MAX14002
> offers more features, like a binary comparator, a filtered reading that
> can provide the average of the last 2, 4, or 8 ADC readings, and an inrush
> comparator that triggers the inrush current. There is also a fault feature
> that can diagnose seven possible fault conditions. And an option to select
> an external or internal ADC voltage reference.
> 
> Add basic support for MAX14001/MAX14002 with the following features:
> - Raw ADC reading.
> - Filtered ADC average reading with the default configuration.
> 
> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>

Given the discussion on the cover letter, perhaps this will need to be
merged with the earlier set. I'll do a quick review anyway!

Fairly minor comments inline. This is in a pretty good state for a v1.

Thanks,

Jonathan


> ---
>  MAINTAINERS                |   1 +
>  drivers/iio/adc/Kconfig    |  10 ++
>  drivers/iio/adc/Makefile   |   1 +
>  drivers/iio/adc/max14001.c | 213 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 225 insertions(+)
>  create mode 100644 drivers/iio/adc/max14001.c

> diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
> new file mode 100644
> index 000000000000..fb79f3b81e0c
> --- /dev/null
> +++ b/drivers/iio/adc/max14001.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MAX14001/MAX14002 SPI ADC driver
> + *
> + * Copyright (c) 2025 Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> + *
> + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX14001-MAX14002.pdf
> + */
> +
> +#include <asm/unaligned.h>

As per build bot this doesn't work on modern kernels.  linux/unaligned.

> +#include <linux/bitfield.h>
> +#include <linux/bitrev.h>
> +#include <linux/module.h>

various headers missing. Please follow approximate include what you use principles.
There are some headers that are obviously going to be included by another one
because they cannot stand alone, so for those you can include just the parent.
E.g. mutex.h not mutex_types.h but in most other cases all includes with definitions
that are used in this file should be here.

> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>
> +
> +/* MAX14001 registers definition */
> +#define MAX14001_REG_ADC				0x00
> +#define MAX14001_REG_FADC				0x01
> +#define MAX14001_REG_FLAGS				0x02
> +#define MAX14001_REG_FLTEN				0x03
> +#define MAX14001_REG_THL				0x04
> +#define MAX14001_REG_THU				0x05
> +#define MAX14001_REG_INRR				0x06
> +#define MAX14001_REG_INRT				0x07
> +#define MAX14001_REG_INRP				0x08
> +#define MAX14001_REG_CFG				0x09
> +#define MAX14001_REG_ENBL				0x0A
> +#define MAX14001_REG_ACT				0x0B
> +#define MAX14001_REG_WEN				0x0C
> +
> +/* MAX14001 CONTROL values*/

Missing space before */

They are going in the WR field below I'd rename that MASK_W
then you can just 1 and 0 with their boolean meaning and
not bother with these defines.

> +#define MAX14001_REG_WRITE				0x1
> +#define MAX14001_REG_READ				0x0
> +
> +/* MAX14001 MASKS */
The comment isn't very useful.  Masks of what?  These seems to be
SPI message related.  Also no point in prefixing comments
with MAX14001 when the naming makes that clear.


> +#define MAX14001_MASK_ADDR				GENMASK(15, 11)
> +#define MAX14001_MASK_WR				BIT(10)
> +#define MAX14001_MASK_DATA				GENMASK(9, 0)
> +
> +enum max14001_chip_model {
> +	max14001,
> +	max14002,
> +};
> +
> +struct max14001_chip_info {
> +	const char *name;
> +};
> +
> +struct max14001_state {
> +	const struct max14001_chip_info *chip_info;
> +	struct spi_device *spi;
> +	int vref_mv;
> +
> +	__be16 rx_buffer __aligned(IIO_DMA_MINALIGN);
> +	__be16 tx_buffer;

I'd add a comment on these to mention they are also bit
reversed after we've flipped the bytes to be in the right order.

> +};
> +
> +static struct max14001_chip_info max14001_chip_info_tbl[] = {
> +	[max14001] = {
> +		.name = "max14001",
> +	},
> +	[max14002] = {
> +		.name = "max14002",
> +	},
> +};
> +
> +static int max14001_spi_read(struct max14001_state *st, u16 reg, int *val)

The register map is large enough I'd consider using a custom regmap
as then we can take advantage of caching and the field manipulation
functions that we get from regmap.

> +{
> +	struct spi_transfer xfer[] = {
> +		{
> +			.tx_buf = &st->tx_buffer,
> +			.len = sizeof(st->tx_buffer),
> +			.cs_change = 1,
> +		},
> +		{
> +			.rx_buf = &st->rx_buffer,
> +			.len = sizeof(st->rx_buffer),
> +		},
> +	};
> +	int ret;
> +

No locking? Given use of shared buffers I would suggest you need
a mutex here, the bus lock won't be enough.

> +	st->tx_buffer = FIELD_PREP(MAX14001_MASK_ADDR, reg) |
> +			FIELD_PREP(MAX14001_MASK_WR, MAX14001_REG_READ);
> +	st->tx_buffer = bitrev16(st->tx_buffer);
> +
> +	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
> +	if (ret < 0)
> +		return ret;
> +
> +	st->rx_buffer = bitrev16(be16_to_cpu(st->rx_buffer));
> +	*val = FIELD_GET(MAX14001_MASK_DATA, st->rx_buffer);
> +
> +	return 0;
> +}


> +static const struct spi_device_id max14001_id_table[] = {
> +	{ "max14001", (kernel_ulong_t)&max14001_chip_info_tbl[max14001] },
> +	{ "max14002", (kernel_ulong_t)&max14001_chip_info_tbl[max14002] },
> +	{}

Trivial but for consistency
	{ }

which is the preferred style in IIO.  There isn't any general agreement
across the kernel so I picked a choice at random a while back as any choice
is better than a mix like we have here.

> +};
> +MODULE_DEVICE_TABLE(spi, max14001_id_table);
> +
> +static const struct of_device_id max14001_of_match[] = {
> +	{ .compatible = "adi,max14001",
> +	  .data = &max14001_chip_info_tbl[max14001], },
> +	{ .compatible = "adi,max14002",
> +	  .data = &max14001_chip_info_tbl[max14002], },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max14001_of_match);


