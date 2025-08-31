Return-Path: <linux-iio+bounces-23525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B36FEB3D2D2
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 14:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F29189899B
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D8325A631;
	Sun, 31 Aug 2025 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrFqNhLz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F988259C80;
	Sun, 31 Aug 2025 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756643264; cv=none; b=oDr31pLx4DDZlqz7w7y+CG9P5TBzGMBtjkaevrq7wMJ3/bOC6Rn0/0FHSo+8UV1OiuM/sgfxcRh7+xzCccRur7/TlYbp32V+scu4BhSwNGzopNfKXEtnL7Ww0kN9c+4QYK2zHhl1Oniwrd4U5t3iYdB07sa4tyD+DuVZcv00sw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756643264; c=relaxed/simple;
	bh=bPKhfTBzMY9I92soo2FdT1/MUwIki7DO1HtC3OssbrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJ2u1aWeNxCCl+AqVGy9bLktNDlHfFGEhIPHQvBQ+W3xllGOj3lWqBG4JF3PVRzUlKtBH9VuUCrZJLPnykPK0qw3gwceiMdKm1kmz8xSHrTVS3MGoApyZ5en/+ThQerfTCyGmbUlBGT/tuceRIg0Ugu2ruTVP504a8+GFhsscuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrFqNhLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F958C4CEED;
	Sun, 31 Aug 2025 12:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756643264;
	bh=bPKhfTBzMY9I92soo2FdT1/MUwIki7DO1HtC3OssbrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KrFqNhLzXXvM/UuFyfKFctDtC/tH+kl2th7u23gvZqoW/QajK9dQ9fBCNUuEQyc14
	 2eK/eJjiSyGrGYVGPnpkdcc13gcVIn2LauZEZTJ5XnKAzBLIfZfdsFtdQ8SNLSh8cF
	 4Iw/jk5mSUIKFVKKxRS3QQD/oI8827QEwT7dxjSwutQM6dEy8xFWjhu5723ltXozTz
	 SvHtwfT/s4hB1bzzpwC8L8lWAT/NbiWdBZoozmDG8axEBG1nUVjNaxEEKu/0KzQQDl
	 NVBqD391fX+SwSHuKUD8q+1d6yZpICtto2AtxWgf/jrokbqiElQFzSMummdxujmlx/
	 EMw/uubsmvLFA==
Date: Sun, 31 Aug 2025 13:27:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
 jic23@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, Marcelo.Schmitt@analog.com, dumitru.ceclan@analog.com,
 Jonathan.Santos@analog.com, dragos.bogdan@analog.com
Subject: Re: [PATCH v1 2/2] iio: adc: Add initial support for MAX22531 ADC
Message-ID: <20250831132643.647f7c4d@jic23-huawei>
In-Reply-To: <edc52c93e0d4e08619ba8a98674aeb7d49e6dd1b.1756115378.git.jain.abhinav177@gmail.com>
References: <cover.1756115378.git.jain.abhinav177@gmail.com>
	<edc52c93e0d4e08619ba8a98674aeb7d49e6dd1b.1756115378.git.jain.abhinav177@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 02:55:49 +0530
Abhinav Jain <jain.abhinav177@gmail.com> wrote:

> Add device support for MAX22530-MAX22531.
> Implement scale and read functionality for raw/filtered ADC readings.
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
Hi Abhinav,

A few minor style related things and one question on FADC registers address.

Thanks,

Jonathan

>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ea3ba1397392..a35c3c945e27 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -933,6 +933,16 @@ config MAX1363
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called max1363.
>  
> +config MAX22531
> +        tristate "Analog Devices MAX22531 ADC Driver"
> +        depends on SPI
> +        help
> +          Say yes here to build support for field-side self-powered 12-bit
> +	   isolated Maxim ADCs. (max22530, max22531, max22532).
Use a list
	  - max22530
	  - max22531
etc
because it means new parts being added create less fuzz.  We've gotten this wrong
in far too many drivers and ended up with messier follow up series as a result!

> +
> +	   To compile this driver as a module, choose M here: the module will be
> +	   called max22531.
Should be tab index + 2 spaces for whole help block. 
> +

> diff --git a/drivers/iio/adc/max22531.c b/drivers/iio/adc/max22531.c
> new file mode 100644
> index 000000000000..fb035225e426
> --- /dev/null
> +++ b/drivers/iio/adc/max22531.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MAX22531 SPI ADC Driver
> + *
> + * Copyright (C) 2025 Abhinav Jain
> + *
> + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max22530-max22532.pdf
> + */
> +
> +#include <linux/module.h>
> +#include <linux/unaligned.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>

As per the build bot report, there are some headers that want to be here and
aren't. In general aim for following Include What You Use IWYU principles
for kernel code, subject to some fuzz around headers that are always used via
an other one.

> +
> +#define MAX22531_REG_PROD_ID		0x00
> +#define MAX22531_REG_ADC_CHAN(x)	((x) + 1)
> +#define MAX22531_REG_FADC_CHAN(x)	((x) + 1)

I'm confused. Why the same registers for both of these?  If they really
are the same, perhaps one macro is enough.

> +
> +#define MAX22531_VREF_MV		1800
> +#define MAX22531_DEVICE_REV_MSK		GENMASK(6, 0)
> +#define MAX22531_DEVICE_REV		0x01
> +
> +#define MAX22531_REG_ADDR_MASK		GENMASK(7, 2)
> +#define MAX22531_REG_WRITE_MASK		BIT(1)
> +
> +enum max22531_id {
> +	max22530,
> +	max22531,
> +	max22532,
> +};
> +
> +struct max22531_chip_info {
> +	const char *name;
> +};
> +
> +static struct max22531_chip_info max22531_chip_info_tbl[] = {
> +	[max22530] = {
> +		.name = "max22530",
> +	},
> +	[max22531] = {
> +		.name = "max22531",
> +	},
> +	[max22532] = {
> +		.name = "max22532",
> +	},
> +};

See below for reasoning. Split these into separate structures rather
than an array.

> +static int max22531_reg_read(struct max22531 *adc, unsigned int reg,
> +			     unsigned int *readval)
> +{
> +	u8 cmd;
> +
> +	cmd = FIELD_PREP(MAX22531_REG_ADDR_MASK, reg);
> +	*readval = spi_w8r16be(adc->spi_dev, cmd);

Rather than having side effect of leaving a negative in *readval, use
a local variable and only assign readval if all is good.

> +	if (*readval < 0)
> +		return *readval;
> +
> +	return 0;
> +}

> +static int max22531_probe(struct spi_device *spi)
> +{

> +	ret = max22531_reg_read(adc, MAX22531_REG_PROD_ID, &prod_id);
> +	if (ret ||
A failure to read is a bug that we should fail on, whereas the value
read not matching is indeed something were a warn or info makes sense.
So split this check 
	if (ret)
		return ret;

	if (FIELD_GET()...
		dev_warn

> +	    FIELD_GET(MAX22531_DEVICE_REV_MSK, prod_id) != MAX22531_DEVICE_REV)
> +		dev_warn(&spi->dev, "PROD_ID verification failed\n");
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id max22531_id[] = {
> +	{ "max22530", (kernel_ulong_t)&max22531_chip_info_tbl[max22530] },
> +	{ "max22531", (kernel_ulong_t)&max22531_chip_info_tbl[max22531] },
> +	{ "max22532", (kernel_ulong_t)&max22531_chip_info_tbl[max22532] },

Whilst this style used to be common, over time we've come to the conclusion
that an indexed array for these doesn't bring value. Instead
just have separate structures with names that indicate which chip they
are for.  max22532_chip_info etc  That allows the enum to be dropped which
has the advantage of removing the temptation to use it for anything else
(which is usually a bad idea)

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, max22531_id);
> +
> +static const struct of_device_id max22531_spi_of_id[] = {
> +	{ .compatible = "adi,max22530",
> +		.data = &max22531_chip_info_tbl[max22530], },
> +	{ .compatible = "adi,max22531",
> +		.data = &max22531_chip_info_tbl[max22531], },
> +	{ .compatible = "adi,max22532",
> +		.data = &max22531_chip_info_tbl[max22532], },
> +	{ }


