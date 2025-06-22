Return-Path: <linux-iio+bounces-20858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C79AAE3046
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 16:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61922188D030
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAB91E5B97;
	Sun, 22 Jun 2025 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHMHnoRa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A6757EA;
	Sun, 22 Jun 2025 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750601337; cv=none; b=LHSOy7XjV1xXZkHJ+OtbMPklUXQR6YJHS/4dd4yHnzVzpUSnzo/zMG1MGt6SnQhYJFXMzH+414ixZQONHPACHG7tZWiMXeOGdq8jl80ADu5hcI4GhDSgumVZpE/Q5DFuEcvDiy2tboC6TZv+boLQNksNjAWRyAqpYcGcHwB6294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750601337; c=relaxed/simple;
	bh=R04QMDq24/57NKiGgo54rF7dGhM/KDMlU/6BuWJA/aM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZAKloyWx6AzxrcxMcEBJP3qd2G1jeMqK/t5BXmdg6aGbQEZUijYPgYZ7s0t1ywKL0Dq4Ipfam7n/iUOfmSyzX7ALVzoyhVeo+IkJSibb9mqtE+TBADxUxo99qWyylflS1blWBh6+ffWOy4rc/sWMGeDc/Unaro2kP74Dz937yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHMHnoRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1547C4CEE3;
	Sun, 22 Jun 2025 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750601336;
	bh=R04QMDq24/57NKiGgo54rF7dGhM/KDMlU/6BuWJA/aM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XHMHnoRaOgQhX76Qe4hRwvuSmM8kZ5dykzw9TdSagcH5XpJYtHx0JtEIJsPG++xWe
	 Wg6q8wfhzFEEiMoU6KGUr5E7aU+hkd2wf4uDebyzQRKo0fbRU0/JSBG9v8HtKdxKZt
	 2OdMA2a6CL5/mNEccVmPcDSsbQp+/iOeuKCQNTUxnrTQtxB6ny1e/TU37K9x5GPmZe
	 t3JjwH9f78SfBR1WjBCbPt2wS8VEqDzAjcP+IGU9Qg1uqTiA74HfrysKU/hHL26oJ+
	 fOQ+hYOuY5NRnMUQBq3XWThzt4a72MhFMTe6ipnLv/JV2LZB0yjgW+bEytRXUM0b25
	 65udz60aGGLWA==
Date: Sun, 22 Jun 2025 15:08:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ana-Maria
 Cusco <ana-maria.cusco@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
 <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v6 02/12] iio: adc: Add basic support for AD4170
Message-ID: <20250622150845.1558da7e@jic23-huawei>
In-Reply-To: <51a3055eb4a5c643cc4ced749f452d4e9b64ecf8.1750258776.git.marcelo.schmitt@analog.com>
References: <cover.1750258776.git.marcelo.schmitt@analog.com>
	<51a3055eb4a5c643cc4ced749f452d4e9b64ecf8.1750258776.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 14:35:38 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> 
> The AD4170 is a multichannel, low noise, 24-bit precision sigma-delta
> analog to digital converter. The AD4170 design offers a flexible data
> acquisition solution with crosspoint multiplexed analog inputs,
> configurable ADC voltage reference inputs, ultra-low noise integrated PGA,
> digital filtering, wide range of configurable output data rates, internal
> oscillator and temperature sensor, four GPIOs, and integrated features for
> interfacing with load cell weigh scales, RTD, and thermocouple sensors.
> 
> Add basic support for the AD4170 ADC with the following features:
> - Single-shot read.
> - Analog front end PGA configuration.
> - Differential and pseudo-differential input configuration.
> 
> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

One comment directing you back to some stuff that came in after you'd
posted this but was in the v5 thread.  The other is a random musing on
whether this should just use spi_write_then_read() to simplify things
at the cost of a few extra data copies.  For that I'm not that fussed
so it is entirely up to you.

Jonathan

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 6516ccb4d63b..d99c35ff9a1c 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_AD4000) += ad4000.o
>  obj-$(CONFIG_AD4030) += ad4030.o
>  obj-$(CONFIG_AD4080) += ad4080.o
>  obj-$(CONFIG_AD4130) += ad4130.o
> +obj-$(CONFIG_AD4170) += ad4170.o
>  obj-$(CONFIG_AD4695) += ad4695.o
>  obj-$(CONFIG_AD4851) += ad4851.o
>  obj-$(CONFIG_AD7091R) += ad7091r-base.o
> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> new file mode 100644
> index 000000000000..58716ad6e7fc
> --- /dev/null
> +++ b/drivers/iio/adc/ad4170.c


> +static int ad4170_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct ad4170_state *st = context;
> +	unsigned int size;
> +	int ret;
> +
> +	ret = ad4170_get_reg_size(st, reg, &size);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_be16(reg, st->tx_buf);
> +	switch (size) {
> +	case 3:
> +		put_unaligned_be24(val, &st->tx_buf[AD4170_SPI_INST_PHASE_LEN]);
> +		break;
> +	case 2:
> +		put_unaligned_be16(val, &st->tx_buf[AD4170_SPI_INST_PHASE_LEN]);
> +		break;
> +	case 1:
> +		st->tx_buf[AD4170_SPI_INST_PHASE_LEN] = val;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return spi_write(st->spi, st->tx_buf, AD4170_SPI_INST_PHASE_LEN + size);

If we did use the below suggestion and switch the read path to spi_write_then_read()
we could do the same here (with zero size write). 

Perhaps neither is a change worth doing though.  Up to you.


> +}
> +
> +static int ad4170_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct ad4170_state *st = context;
> +	struct spi_transfer t[] = {
> +		{
> +			.tx_buf = st->tx_buf,
> +			.len = AD4170_SPI_INST_PHASE_LEN,
> +		},
> +		{
> +			.rx_buf = st->rx_buf,
> +		},

I wonder....  Would we better off just using spi_write_then_read() here
given they are all fairly small register sizes.  The big advantage
is we can skip messing around with dma safe buffers as spi_write_then_read
always bounces the data through some buffers the SPI core creates for this
purpose.

> +	};
> +	unsigned int size;
> +	int ret;
> +
> +	ret = ad4170_get_reg_size(st, reg, &size);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_be16(AD4170_REG_READ_MASK | reg, st->tx_buf);
> +	t[1].len = size;
> +
> +	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> +	if (ret)
> +		return ret;
> +
> +	switch (size) {
> +	case 3:
> +		*val = get_unaligned_be24(st->rx_buf);
> +		return 0;
> +	case 2:
> +		*val = get_unaligned_be16(st->rx_buf);
> +		return 0;
> +	case 1:
> +		*val = st->rx_buf[0];
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}



> +static int ad4170_parse_adc_channel_type(struct device *dev,
> +					 struct fwnode_handle *child,
> +					 struct iio_chan_spec *chan)
> +{
> +	const char *propname, *propname2;
> +	int ret, ret2;
> +	u32 pins[2];
> +
> +	/* Parse pseudo-differential channel configuration */
> +	propname = "single-channel";
> +	propname2 = "common-mode-channel";
> +	ret = fwnode_property_read_u32(child, propname, &pins[0]);
> +	ret2 = fwnode_property_read_u32(child, propname2, &pins[1]);
> +	if (!ret && ret2)
> +		return dev_err_probe(dev, ret,
ret isn't appropriate to use here as it's 0 so you'll report success.
> +				     "When %s is defined, %s must be defined too\n",
> +				     propname, propname2);
> +
> +	if (!ret && !ret2) {

See feedback following from Dan's email in v5 thread that came in just after you'd
posted this.

Andy was keen that we do this differently and I think his suggestion makes sense.

> +		chan->differential = false;
> +		chan->channel = pins[0];
> +		chan->channel2 = pins[1];
> +		return 0;
> +	}
> +	/* Failed to parse pseudo-diff chan props so try diff chan */
> +
> +	/* Parse differential channel configuration */
> +	propname2 = "diff-channels";
> +	ret = fwnode_property_read_u32_array(child, propname2, pins,
> +					     ARRAY_SIZE(pins));
> +	if (!ret) {
> +		chan->differential = true;
> +		chan->channel = pins[0];
> +		chan->channel2 = pins[1];
> +		return 0;
> +	}
> +	return dev_err_probe(dev, ret, "Channel must define one of %s or %s.\n",
> +			     propname, propname2);
> +}



