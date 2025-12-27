Return-Path: <linux-iio+bounces-27396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D30CE0126
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 19:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A91D8301B80E
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D62324B24;
	Sat, 27 Dec 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6Xf69sK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F5632;
	Sat, 27 Dec 2025 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766860938; cv=none; b=pY2TKW1q5OuuSiKYkyoiv+vPedZ43saMY3wRdI/LsaVbmlnrbE1vJNn1FtJYrcE8SFkw1cLXuDRUOwJ5rTV8CtBnVXwe0Ol6FOQdOpczxFn83kEqaX3aUgls2BQrGUP6ymC+JU+iaFaTdFjaviJYW/CdvJKNWKTsq91CS5EUYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766860938; c=relaxed/simple;
	bh=2huUn/PzWL56HOjSRVJVnYIV4xXPnaVAb0pq+ijBdY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rer6qfYgMD3AE0QpL+Ca3Qpu1931oxw1iI6zVORc3k+bwyrPBRSAZNd9rTMCaD1zHEYLp/aGiS2aBN6faVebVqqv1r6vf0OcV4a0WToJrzsMQm/31/qgymNAvhyrgQLOmny/uBMG8xa2pAF8VgWB2hCyVK6UutX3R7PzZdt0RkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6Xf69sK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CA3C4CEF1;
	Sat, 27 Dec 2025 18:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766860937;
	bh=2huUn/PzWL56HOjSRVJVnYIV4xXPnaVAb0pq+ijBdY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R6Xf69sKFHFd3F6tDaBlI2AcK6BbGfJVkYu+FSpPQU/gIyIcuNXpsqUSkOP/l6RoX
	 Lv7Y1agtRks9s27v19XuQRH/bU8QBRIzmRVZYf0xCf5X5Q0BSAs8Yc3V83XTyg+q34
	 rfuBXylx4NroFEgxnrw3J8H/PKgWTC+sZ6ECY5oxEN8xBuJU0YWxIpeXmmR/aOGdLx
	 FRG3XeI+bJYv59aSjYzSx4IJBhU2upFPzEc3PE4xg4g8BBWBEd8sDAoFK3lLWE7hg+
	 p2zD/KzRlyOSDu0LfL0tBrtdOUeifNf53tX+fdemoIqqoce0Q/5ZA5yOoIx1kBopVM
	 rsoTLUPqghC2A==
Date: Sat, 27 Dec 2025 18:42:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>, Tobias Sperling
 <tobias.sperling@softing.com>, Eason Yang <j2anfernee@gmail.com>, Marilene
 Andrade Garcia <marilene.agarcia@gmail.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz,
 herve.codina@bootlin.com, Rodolfo Giometti <giometti@enneenne.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] iio: adc: add driver for Texas Instruments TLA2528
 adc
Message-ID: <20251227184204.6815a3b4@jic23-huawei>
In-Reply-To: <20251223155534.220504-3-maxime.chevallier@bootlin.com>
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
	<20251223155534.220504-3-maxime.chevallier@bootlin.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Dec 2025 16:55:33 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> This adds a new driver for the TI TLA2528 ADC chip. It ha 8 12-bit
> channels, that can also be configured as 16-bit averaging channels.
> 
> Add a very simple driver for it, allowing reading raw values for each
> channel.
> 
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Hi Maxime,

A few extra bits from me

Thanks,

Jonathan


> diff --git a/drivers/iio/adc/ti-tla2528.c b/drivers/iio/adc/ti-tla2528.c
> new file mode 100644
> index 000000000000..9c572e730ffb
> --- /dev/null
> +++ b/drivers/iio/adc/ti-tla2528.c
> @@ -0,0 +1,209 @@

> +
> +static s32 tla2528_write_reg(const struct i2c_client *client, u8 reg, u8 val)
> +{
> +	u8 data[3] = {TLA2528_OP_WRITE_REG, reg, val};

Style wise. Prefer { TLA25... val };

- couple of spaces next to the brackets.

> +	int ret;
> +
> +	ret = i2c_master_send(client, data, 3);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int tla2528_read_sample(const struct i2c_client *client)
> +{
> +	__be16 data;
> +	int ret;
> +
> +	ret = i2c_master_recv(client, (char *)&data, 2);

sizeof(data)

> +	if (ret < 0)
> +		return ret;
> +
> +	return be16_to_cpu(data) >> 4;
> +}

> +
> +#define TLA2528_CHAN(_chan, _name) { \

The _ aren't adding anything here, so I'd drop them.

> +	.type = IIO_VOLTAGE,					\
> +	.channel = (_chan),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.datasheet_name = _name,				\
> +	.indexed = 1,						\
> +}

> +
> +static int tla2528_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct tla2528 *tla2528;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> +				     I2C_FUNC_SMBUS_WRITE_WORD_DATA))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*tla2528));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	tla2528 = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

Ever used? If not don't set it.

> +	tla2528->client = client;
> +
> +	indio_dev->name = client->name;

Prefer to see it hard coded as a string.  If we added extra firmware
types in future the content of client->name can become something other
than the part number.


> +	indio_dev->info = &tla2528_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = tla2528_channel;
> +	indio_dev->num_channels = ARRAY_SIZE(tla2528_channel);
> +
> +	mutex_init(&tla2528->lock);
> +
> +	tla2528->vref_uv = devm_regulator_get_enable_read_voltage(&client->dev,
> +								  "vref");
> +	if (tla2528->vref_uv < 0)
> +		return tla2528->vref_uv;
> +
> +	/* Set all inputs as analog */
> +	ret = tla2528_write_reg(tla2528->client, TLA2528_PIN_CFG_ADR, 0x00);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = tla2528_write_reg(tla2528->client, TLA2528_DATA_CFG_ADR,
> +				TLA2528_DATA_CFG_APPEND_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set manual mode */
> +	ret = tla2528_write_reg(tla2528->client, TLA2528_SEQUENCE_CFG_ADR, 0x00);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Init private data */
> +	tla2528->last_read_channel = ~0;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}

