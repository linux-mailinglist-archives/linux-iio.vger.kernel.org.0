Return-Path: <linux-iio+bounces-795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E14F80BAAF
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 13:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6FB1C20908
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 12:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5A3BE74;
	Sun, 10 Dec 2023 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtrPxM5C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F13D72;
	Sun, 10 Dec 2023 12:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5C7C433C7;
	Sun, 10 Dec 2023 12:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702211632;
	bh=N9/kqstXD8U7IPBmYFZROtil/oc5Xniz8xWapHWaMvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mtrPxM5C0jy16l8EMCWn1a4BzLhVBWYsyBP6p/UQVloQAYMNzO8q2khJZrthnh0/p
	 1XvSfjYcykH0/Evq+rrCf7UmSn3Xv5MYnFdMJDdz29SBXvrx1+pydX76VyC43x1Hvi
	 HUpMyWyehvsygzRfBx42pbQShNRZblkjR/uNX1Bc3w+SwsZv1r3ej2Ps+e+odMuBuu
	 +eJ5BwqyO6ax1QNM0pmsNRGErhc9/CyQ62mreBcWFFDM0gBw5QHk3MdGknnekhku4E
	 jvsvWMFl5T6bfni76/tj45PVtjyyx4/aML425FbQ7dJ641UkfrmQaztVH6ZtsPYDms
	 QedtgtvNcIXhg==
Date: Sun, 10 Dec 2023 12:33:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
 <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
 <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <dan.carpenter@linaro.org>, <marcelo.schmitt1@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 12/13] iio: adc: Add support for AD7091R-8
Message-ID: <20231210123343.2695a9dc@jic23-huawei>
In-Reply-To: <0dd8b9682728b07a30877fcb37335b5055d046ff.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
	<0dd8b9682728b07a30877fcb37335b5055d046ff.1701971344.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 15:42:56 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add support for Analog Devices AD7091R-2, AD7091R-4, and AD7091R-8
> low power 12-Bit SAR ADCs with SPI interface.
> Extend ad7091r-base driver so it can be used by the AD7091R-8 driver.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

A few trivial things inline.
Otherwise looks pretty good to me.

Jonathan
> diff --git a/drivers/iio/adc/ad7091r8.c b/drivers/iio/adc/ad7091r8.c
> new file mode 100644
> index 000000000000..8dc0f784913b
> --- /dev/null
> +++ b/drivers/iio/adc/ad7091r8.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices AD7091R8 12-bit SAR ADC driver
> + *
> + * Copyright 2023 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include "ad7091r-base.h"
> +
> +#define AD7091R8_REG_ADDR_MSK				GENMASK(15, 11)
> +#define AD7091R8_RD_WR_FLAG_MSK				BIT(10)
> +#define AD7091R8_REG_DATA_MSK				GENMASK(9, 0)
> +
> +#define AD7091R2_DEV_NAME				"ad7091r-2"
> +#define AD7091R4_DEV_NAME				"ad7091r-4"
> +#define AD7091R8_DEV_NAME				"ad7091r-8"
Not seeing any advantage in these macros.  It will be more readable to just
have the strings inline where the macros are currently used.

> +static int ad7091r8_gpio_setup(struct ad7091r_state *st)
> +{
> +	st->convst_gpio = devm_gpiod_get(st->dev, "adi,conversion-start",
> +					 GPIOD_OUT_LOW);
> +	if (IS_ERR(st->convst_gpio))
> +		return dev_err_probe(st->dev, PTR_ERR(st->convst_gpio),
> +				     "Error getting convst GPIO\n");
> +
> +	st->reset_gpio =  devm_gpiod_get_optional(st->dev, "reset",
> +						  GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->reset_gpio))
> +		return PTR_ERR(st->reset_gpio);
Maybe a dev_err_probe() here as well both for consistency and for the
debug info that gets stashed if it's EPROBE_DEFER
> +
> +	if (st->reset_gpio) {
> +		fsleep(20);
> +		gpiod_set_value_cansleep(st->reset_gpio, 0);
> +	}
> +
> +	return 0;
> +}

> +
> +static struct ad7091r_init_info ad7091r2_init_info = {
> +	.info_no_irq = AD7091R_SPI_CHIP_INFO(2),
> +	.regmap_config = &ad7091r2_reg_conf,
> +	.ad7091r_regmap_init = &ad7091r8_regmap_init,
> +	.ad7091r_setup = &ad7091r8_gpio_setup
> +};
> +
> +static struct ad7091r_init_info ad7091r4_init_info = {
> +	.irq_info = AD7091R_SPI_CHIP_INFO_IRQ(4),
> +	.info_no_irq = AD7091R_SPI_CHIP_INFO(4),
> +	.regmap_config = &ad7091r4_reg_conf,
> +	.ad7091r_regmap_init = &ad7091r8_regmap_init,
> +	.ad7091r_setup = &ad7091r8_gpio_setup
> +};
> +
> +static struct ad7091r_init_info ad7091r8_init_info = {
> +	.irq_info = AD7091R_SPI_CHIP_INFO_IRQ(8),
> +	.info_no_irq = AD7091R_SPI_CHIP_INFO(8),
> +	.regmap_config = &ad7091r8_reg_conf,
> +	.ad7091r_regmap_init = &ad7091r8_regmap_init,
> +	.ad7091r_setup = &ad7091r8_gpio_setup
> +};
> +
> +static int ad7091r8_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	const struct ad7091r_init_info *init_info;
> +
> +	init_info = spi_get_device_match_data(spi);
> +	if (!init_info)
> +		return -EINVAL;
> +
> +	return ad7091r_probe(&spi->dev, id->name, init_info, NULL, spi->irq);
id->name isn't generally a good idea because we end up with lots of odd corner
cases if the of_device_id and spi_device_id tables get out of sync - which
can happen if fallback compatibles get used.

Normal way round this is just put the naming of the device in the
info structure.  Costs a little storage, but makes the code simpler
and less probe to odd corner cases.  Also, I think you already have it
in there!

> +}
> +
> +static const struct of_device_id ad7091r8_of_match[] = {
> +	{ .compatible = "adi,ad7091r2", .data = &ad7091r2_init_info },
> +	{ .compatible = "adi,ad7091r4", .data = &ad7091r4_init_info },
> +	{ .compatible = "adi,ad7091r8", .data = &ad7091r8_init_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7091r8_of_match);
> +
> +static const struct spi_device_id ad7091r8_spi_id[] = {
> +	{ "ad7091r2", (kernel_ulong_t)&ad7091r2_init_info },
> +	{ "ad7091r4", (kernel_ulong_t)&ad7091r4_init_info },
> +	{ "ad7091r8", (kernel_ulong_t)&ad7091r8_init_info },
> +	{}
Trivial but be consistent on spacing for these terminators.  I like a space, so
{ } but I don't mind if an author prefers {} as long as they are consistent!

> +};
> +MODULE_DEVICE_TABLE(spi, ad7091r8_spi_id);


