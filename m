Return-Path: <linux-iio+bounces-10791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3C69A4EAA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121A51F25682
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0641A276;
	Sat, 19 Oct 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvu8ow44"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B0A2F50;
	Sat, 19 Oct 2024 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729348309; cv=none; b=C7SqegztUjg3T5bV8jJfhNdUl8ZRi7wOX1FXc5jSkzhmtYQL7FH/DYJ1/1vh0LKZFVAcPuJLOjM4ubdx3eVWYxQoB04qmcjKSNAcnXLN54KL++iXl6vDUofT9nmzB0bVJooHz8wTEGcS3p2gFrB46EuQP3kT4nt+B+ncJnZjFqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729348309; c=relaxed/simple;
	bh=MPVB3J/0kjSGHaNAIKMKwFFw8G+Tb4mYXMtJiStvQsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9HGRDls8KMTl92g8Lz5UF+nRfU7XTYpVLA+gB3G5NGNw85oCic998EFMUSvh8cclAEZNMNHW+MsLoXDHx5jwUxCAHDKSusLm7ELsE2Pd3Wxjyn0wRpxy6NbD8hS5yr0PxRX+c1eyXOJPuEQcUjO4Vq2WV2NfoUDRf20RNwnBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvu8ow44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB60C4CEC5;
	Sat, 19 Oct 2024 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729348308;
	bh=MPVB3J/0kjSGHaNAIKMKwFFw8G+Tb4mYXMtJiStvQsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tvu8ow44iN2mndv3IxTdKeDYHj+z/uKqt+lz25xiXKBupBTnEZrW9IJOsypOsUTDz
	 R8LhYLsNiSJcPXkMFmhtcbp9utx4UNYVbeJMjZy4XCWAaCAcGV4sRv1r99RtO1GFiS
	 9JWayG0B38jWxflRubqUF9OoFLm283ybBIsFhw8cYSSgE+7H0vV9+XpRT1NjiZPjMs
	 84qgKeITv/v2nkqH4eA6EACLH5ZIC+fSIQR+MNbOwPYC9/pFlOxN3kSsuwHOuS/2lE
	 XZmAifuuTnjW4fMfAf9nHY5fZfidgKyVnylugnYuymAZ7g1u0vTVUH3qBtsaORG5Yv
	 Ihh18T0F058MA==
Date: Sat, 19 Oct 2024 15:31:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: add support for veml3235
Message-ID: <20241019153140.4f7a4f47@jic23-huawei>
In-Reply-To: <20241016-veml3235-v1-2-b904f802daef@gmail.com>
References: <20241016-veml3235-v1-0-b904f802daef@gmail.com>
	<20241016-veml3235-v1-2-b904f802daef@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 23:39:32 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The Vishay veml3235 is a low-power ambient light sensor with I2C
> interface. It provides a minimum detectable intensity of
> 0.0021 lx/cnt, configurable integration time and gain, and an additional
> white channel to distinguish between different light sources.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

A few minor things inline but looking good in general to me.


> diff --git a/drivers/iio/light/veml3235.c b/drivers/iio/light/veml3235.c
> new file mode 100644
> index 000000000000..9bda42379456
> --- /dev/null
> +++ b/drivers/iio/light/veml3235.c
> @@ -0,0 +1,534 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VEML3235 Ambient Light Sensor
> + *
> + * Copyright (c) 2024, Javier Carrasco <javier.carrasco.cruz@gmail.com>
> + *
> + * Datasheet: https://www.vishay.com/docs/80131/veml3235.pdf
> + * Appnote-80222: https://www.vishay.com/docs/80222/designingveml3235.pdf
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define VEML3235_REG_CONF       0x00
> +#define VEML3235_REG_WH_DATA    0x04
> +#define VEML3235_REG_ALS_DATA   0x05
> +#define VEML3235_REG_ID         0x09
> +
> +#define VEML3235_SD             BIT(0)
> +#define VEML3235_SD0            BIT(8)

Name these so it's obvious they are in REG_CONF.
#define VEML3235_CONF_SD
etc.



> +
> +static int veml3235_set_gain(struct iio_dev *indio_dev, int val, int val2)
> +{
> +	struct veml3235_data *data = iio_priv(indio_dev);
> +	int ret, new_gain, gain_idx;

	if (val2 !== 0)
		return -EINVAL;

	switch (val)
.. 
	default:
		return -EINVAL;

> +
> +	if (val == 1 && val2 == 0) {
> +		new_gain = 0x00;
> +		gain_idx = 3;
> +	} else if (val == 2 && val2 == 0) {
> +		new_gain = 0x01;
> +		gain_idx = 2;
> +	} else if (val == 4 && val2 == 0) {
> +		new_gain = 0x03;
> +		gain_idx = 1;
> +	} else if (val == 8 && val2 == 0) {
> +		new_gain = 0x07;
> +		gain_idx = 0;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_field_write(data->rf.gain, new_gain);
> +	if (ret) {
> +		dev_err(data->dev, "failed to set gain: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (data->gain < gain_idx)
> +		data->resolution <<= gain_idx - data->gain;
> +	else if (data->gain > gain_idx)
> +		data->resolution >>= data->gain - gain_idx;
> +
> +	data->gain = gain_idx;
> +
> +	return 0;
> +}

> +static int veml3235_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*vals = (int *)&veml3235_it_times;
> +		*length = 2 * ARRAY_SIZE(veml3235_it_times);
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)&veml3235_scale_vals;
> +		*length = ARRAY_SIZE(veml3235_scale_vals);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	}
> +
> +	return -EINVAL;

Push this into a default: as it lets static analysis tools be sure you intended
to only handle those two cases.

> +}
>
> +static int veml3235_read_id(struct veml3235_data *data)
> +{
> +	int ret, reg;
> +
> +	ret = regmap_field_read(data->rf.id,  &reg);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "failed to read ID\n");
> +
> +	if (reg != 0x35)
> +		return dev_err_probe(data->dev, -ENODEV, "Unknown ID %d\n", reg);

This looks to be breaking any potential use of fallback dt compatibles for
future devices that are fully backwards compatible.

Should just be a dev_info() to log that we aren't sure what the device is then
carry on anyway on basis the firmware tables should be correct.


> +
> +	return 0;
> +}

