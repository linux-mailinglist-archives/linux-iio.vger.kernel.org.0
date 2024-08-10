Return-Path: <linux-iio+bounces-8405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB6D94DCEC
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 14:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655AB1C20CC5
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ABB15855D;
	Sat, 10 Aug 2024 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBRCk0DY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582851E86E;
	Sat, 10 Aug 2024 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723293868; cv=none; b=CZZBWPLEgEgBSka1xVKhBXdGqhb1F4caExt9PVs9c3JwYJoKQ346N5GHe3vIyPbwLf+Gdh5mzRmaN7jQeIGHGPY3+wMErWipSiq0SQ24QixqiTlKzhF/xcPcHXLTPlF0z4oBhXjMtkLwfQBI7IVZz37J9SAffbVr2leWf1FIrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723293868; c=relaxed/simple;
	bh=u0AAH4/SI9Mt5qQofVmjij+85q0umZRFDunjPco/8jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SLwEyBo07BuSWcdfHGtqCkNrW8crQOAFgBE/5jldeJF58/9pbfkZb2NDco88BsPZD7Ejfa4gCK8sbNtEM5hzfcPNXciiusQRRAhogvDWR/6qUQFkyGnwck9XtgmTlDkHRlQ0XmxfMFXR4JMuEvxBifx3XtKgjoKjHXtqpjP8UYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBRCk0DY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A779C32781;
	Sat, 10 Aug 2024 12:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723293867;
	bh=u0AAH4/SI9Mt5qQofVmjij+85q0umZRFDunjPco/8jo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=RBRCk0DYsknlwGR5P95YM4lJYNNk9TstM0STiGj7T2AGt1a0/+lizst3ZvCcMcE6P
	 kN42twl00IF9qLTe4+657/j9n6jH+xbjCO6OidtMikpYZ6GJZlGxe17qiiTgOPvoYl
	 jimAXb/U2j0kVGtz2dx9rCCWO1WuVB02p9eZN+YqKWTuRQyiBpwbsi/QwK11HEWfsm
	 nyVeX710sDCYoLiwKS6+5b2IcF5ylqVZ43NUMCqnzsvva2U6bggV76R5mOQD6gCycF
	 46TBMSxQXMR4a7hNaxZLSrjm2BUbu7icSh2yP60xGSiUAX9foeHa9mJNm98h29thbB
	 qA2LJ7ebSHO4w==
Message-ID: <561b467a-58aa-471c-8ea6-cd6ef927c287@kernel.org>
Date: Sat, 10 Aug 2024 14:44:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: imu: smi240: imu driver
To: Jianping.Shen@de.bosch.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dima.fedrau@gmail.com, marcelo.schmitt1@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian.Lorenz3@de.bosch.com,
 Ulrike.Frauendorf@de.bosch.com, Kai.Dolde@de.bosch.com
References: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
 <20240809111635.106588-3-Jianping.Shen@de.bosch.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240809111635.106588-3-Jianping.Shen@de.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/08/2024 13:16, Jianping.Shen@de.bosch.com wrote:
> From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
> 
> iio: imu: smi240: driver improvements

?????

> Signed-off-by: Shen Jianping (ME-SE/EAD2) <Jianping.Shen@de.bosch.com>
> ---
> 


...

> +	ret = regmap_read(data->regmap, SMI240_CHIP_ID_REG, &response);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Read chip id failed\n");
> +
> +	if (response != SMI240_CHIP_ID)
> +		dev_info(dev, "Unknown chip id: 0x%04x\n", response);
> +
> +	ret = smi240_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Device initialization failed\n");
> +
> +	indio_dev->channels = smi240_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(smi240_channels);
> +	indio_dev->name = "smi240";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &smi240_info;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      smi240_trigger_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Setup triggered buffer failed\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Register IIO device failed\n");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(smi240_core_probe);
> +
> +MODULE_AUTHOR("Markus Lochmann <markus.lochmann@de.bosch.com>");
> +MODULE_AUTHOR("Stefan Gutmann <stefan.gutmann@de.bosch.com>");
> +MODULE_DESCRIPTION("Bosch SMI240 driver");
> +MODULE_LICENSE("Dual BSD/GPL");

Hm? How many modules do you have here? What are their names?


> diff --git a/drivers/iio/imu/smi240/smi240_spi.c b/drivers/iio/imu/smi240/smi240_spi.c
> new file mode 100644
> index 00000000000..ac9e37ffa37
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/smi240_spi.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2024 Robert Bosch GmbH.
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +
> +#include "smi240.h"
> +
> +#define SMI240_CRC_INIT 0x05
> +#define SMI240_CRC_POLY 0x0B
> +#define SMI240_BUS_ID 0x00
> +
> +#define SMI240_SD_BIT_MASK 0x80000000
> +#define SMI240_CS_BIT_MASK 0x00000008
> +
> +#define SMI240_WRITE_ADDR_MASK GENMASK(29, 22)
> +#define SMI240_WRITE_BIT_MASK 0x00200000
> +#define SMI240_WRITE_DATA_MASK GENMASK(18, 3)
> +#define SMI240_CAP_BIT_MASK 0x00100000
> +#define SMI240_READ_DATA_MASK GENMASK(19, 4)
> +
> +static u8 smi240_crc3(u32 data, u8 init, u8 poly)
> +{
> +	u8 crc = init;
> +	u8 do_xor;
> +	s8 i = 31;
> +
> +	do {
> +		do_xor = crc & 0x04;
> +		crc <<= 1;
> +		crc |= 0x01 & (data >> i);
> +		if (do_xor)
> +			crc ^= poly;
> +
> +		crc &= 0x07;
> +	} while (--i >= 0);
> +
> +	return crc;
> +}
> +
> +static bool smi240_sensor_data_is_valid(u32 data)
> +{
> +	if (smi240_crc3(data, SMI240_CRC_INIT, SMI240_CRC_POLY) != 0)
> +		return false;
> +
> +	if (FIELD_GET(SMI240_SD_BIT_MASK, data) &
> +	    FIELD_GET(SMI240_CS_BIT_MASK, data))
> +		return false;
> +
> +	return true;
> +}
> +
> +static int smi240_regmap_spi_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	int ret;
> +	__be32 request, response;
> +	struct spi_device *spi = context;
> +	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> +	struct smi240_data *data = iio_priv(indio_dev);
> +
> +	request = SMI240_BUS_ID << 30;
> +	request |= FIELD_PREP(SMI240_CAP_BIT_MASK, data->capture);
> +	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, *(u8 *)reg_buf);
> +	request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> +	request = cpu_to_be32(request);
> +
> +	/*
> +	 * SMI240 module consists of a 32Bit Out Of Frame (OOF)
> +	 * SPI protocol, where the slave interface responds to
> +	 * the Master request in the next frame.
> +	 * CS signal must toggle (> 700 ns) between the frames.
> +	 */
> +	ret = spi_write(spi, &request, sizeof(request));
> +	if (ret)
> +		return ret;
> +
> +	ret = spi_read(spi, &response, sizeof(response));
> +	if (ret)
> +		return ret;
> +
> +	response = be32_to_cpu(response);
> +
> +	if (!smi240_sensor_data_is_valid(response))
> +		return -EIO;
> +
> +	response = FIELD_GET(SMI240_READ_DATA_MASK, response);
> +	memcpy(val_buf, &response, val_size);
> +
> +	return 0;
> +}
> +
> +static int smi240_regmap_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	__be32 request;
> +	struct spi_device *spi = context;
> +	u8 reg_addr = ((u8 *)data)[0];
> +	u16 reg_data = ((u8 *)data)[2] << 8 | ((u8 *)data)[1];
> +
> +	request = SMI240_BUS_ID << 30;
> +	request |= FIELD_PREP(SMI240_WRITE_BIT_MASK, 1);
> +	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, reg_addr);
> +	request |= FIELD_PREP(SMI240_WRITE_DATA_MASK, reg_data);
> +	request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> +	request = cpu_to_be32(request);
> +
> +	return spi_write(spi, &request, sizeof(request));
> +}
> +
> +static struct regmap_bus smi240_regmap_bus = {

Not const?

> +	.read = smi240_regmap_spi_read,
> +	.write = smi240_regmap_spi_write,
> +};
> +
> +static const struct regmap_config smi240_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +static int smi240_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +
> +	u32 max_frequency = 10000000;
> +
> +	of_property_read_u32(spi->dev.of_node, "spi-max-frequency",
> +			     &max_frequency);

Why?


> +
> +	spi->bits_per_word = 8;

That's  default.

> +	spi->max_speed_hz = max_frequency;

Why? Core does it.

> +	spi->mode = SPI_MODE_0;

I really wonder why you need all this code...

> +
> +	regmap = devm_regmap_init(&spi->dev, &smi240_regmap_bus, &spi->dev,
> +				  &smi240_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
> +				     "Failed to initialize SPI Regmap\n");
> +
> +	return smi240_core_probe(&spi->dev, regmap);
> +}
> +
> +static const struct spi_device_id smi240_spi_id[] = { { "smi240", 0 }, {} };

Don't wrap it.

> +MODULE_DEVICE_TABLE(spi, smi240_spi_id);
> +
> +static const struct of_device_id smi240_of_match[] = {
> +	{ .compatible = "bosch,smi240" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, smi240_of_match);
> +
> +static struct spi_driver smi240_spi_driver = {
> +	.probe = smi240_spi_probe,
> +	.id_table = smi240_spi_id,
> +	.driver = {
> +		.of_match_table = of_match_ptr(smi240_of_match),

Why did it appear? You introduce now warnings.


Best regards,
Krzysztof


