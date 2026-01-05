Return-Path: <linux-iio+bounces-27482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DCFCF2EF9
	for <lists+linux-iio@lfdr.de>; Mon, 05 Jan 2026 11:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B5E5301FC33
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jan 2026 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69042F3C3E;
	Mon,  5 Jan 2026 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qWUESvLK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F12F1FEE;
	Mon,  5 Jan 2026 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607922; cv=none; b=eL6XEYe2b7PM3aHUSV8JCgRUhy41zDEzHsdgiyenJBb7k81ittyhZkZUTS5l9C9SB2+ijYlh8L8zXE9MUfsW4wuXti3yEcXkpsfjuxSMbNvi2yIk6n0e5tVjJvDvN3vqOxcVRmzAXrXxkMZCYaCXvm15uh/A5asWNIwlIh+pBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607922; c=relaxed/simple;
	bh=iaxCfWTu79QIfYhKC98bg3+oxT5P4uZAd9qhnmaekgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqeGjg2cSPto1WtNFw6blic6B4urfcqnur5NVcwZfr2rrZsJ3XVI8qv5z4xDCYruOWIWwTuqZ4rnxAYBUjJ9qFczsMFVz8lJNLzkM1W8zOkRMoWzZieEBSkNL6z5ZOyK8OmoDXtuSPbueaROk0l7gmvfC84YrXvmEvDNqUKI/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qWUESvLK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 22D6D4E41F63;
	Mon,  5 Jan 2026 10:11:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E53AD60726;
	Mon,  5 Jan 2026 10:11:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2AEA103C8458;
	Mon,  5 Jan 2026 11:11:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767607915; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=UBGLtAPCxRqGUd7drHdDfykkh+GZIgiO84U/jh43uJo=;
	b=qWUESvLKN7V9RWBXqcnVWvK+4zNS4oKo+Kkc2PlmwPrU+4luInMk/VXJcwzy82kYY3Kcf9
	WkA9eD65plD4AsW1mOeyC53BixoMID1N3X4ayUZe8jDV7httrl1elZxWkgOY/zaabPRUOa
	ixuDqd7tnSa1pPwFuM+ujHpBF/2hQiOVugtUc6tiXGyeovtWEWR2W7W3RIx7rzNObtcvnT
	YwzLTCfQfucoC3NIn0PKt6WeT4usy3hMBcKnIY8Co5gAx/msMaLd5c4+JghEviPurEMg60
	elvy53198Zt8jf2YE8qIencBrExUrp2KE/81rCz/04fkTKrBWVXbqJPlNz4G2w==
Message-ID: <bec3a0be-56a1-4eb0-bb77-c1786f00e7b3@bootlin.com>
Date: Mon, 5 Jan 2026 11:11:51 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: add driver for Texas Instruments TLA2528
 adc
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, nuno.sa@analog.com, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 duje@dujemihanovic.xyz, herve.codina@bootlin.com,
 Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
 <20251223155534.220504-3-maxime.chevallier@bootlin.com>
 <5832d047-e93f-497e-aa23-6f67aeb00a99@baylibre.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <5832d047-e93f-497e-aa23-6f67aeb00a99@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi David,

On 23/12/2025 19:26, David Lechner wrote:
> On 12/23/25 9:55 AM, Maxime Chevallier wrote:
>> This adds a new driver for the TI TLA2528 ADC chip. It ha 8 12-bit
> 
> s/This adds/Add/
> 
> s/ha/has/
> 
>> channels, that can also be configured as 16-bit averaging channels.
>>
>> Add a very simple driver for it, allowing reading raw values for each
> 
> Don't need to say we are adding a driver twice.

I'll reword accordingly, thanks :)

> 
>> channel.
>>
>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> ---
>>  MAINTAINERS                  |   7 ++
>>  drivers/iio/adc/Kconfig      |  10 ++
>>  drivers/iio/adc/Makefile     |   1 +
>>  drivers/iio/adc/ti-tla2528.c | 209 +++++++++++++++++++++++++++++++++++
>>  4 files changed, 227 insertions(+)
>>  create mode 100644 drivers/iio/adc/ti-tla2528.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dc731d37c8fe..5c382ae216c7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -25866,6 +25866,13 @@ F:	include/dt-bindings/soc/ti,sci_pm_domain.h
>>  F:	include/linux/soc/ti/ti_sci_inta_msi.h
>>  F:	include/linux/soc/ti/ti_sci_protocol.h
>>  
>> +TEXAS INSTRUMENTS' TLA2528 ADC DRIVER
>> +M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
>> +L:	linux-iio@vger.kernel.org
>> +S:	Supported
>> +F:	Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
> 
> This part can be included in the dt-bindings patch since that is where
> the file is introduced.
> 
>> +F:	drivers/iio/adc/ti-tla2528.c
> 
> And just keep this line in this patch.

ACK, no problem

> 
>> +
>>  TEXAS INSTRUMENTS' TMP117 TEMPERATURE SENSOR DRIVER
>>  M:	Puranjay Mohan <puranjay@kernel.org>
>>  L:	linux-iio@vger.kernel.org
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 58da8255525e..67376de410bf 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -1803,6 +1803,16 @@ config TI_LMP92064
>>  	  This driver can also be built as a module. If so, the module will be called
>>  	  ti-lmp92064.
>>  
>> +config TI_TLA2528
>> +	tristate "Texas Instruments TLA2528 ADC driver"
>> +	depends on I2C
>> +	help
>> +	  Say yes here to build support for Texas Instruments TLA2528
>> +	  12-Bit 8-Channel ADC.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called ti-tla2528.
>> +
>>  config TI_TLC4541
>>  	tristate "Texas Instruments TLC4541 ADC driver"
>>  	depends on SPI
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 7cc8f9a12f76..941606defbf7 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -157,6 +157,7 @@ obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
>>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
>>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>>  obj-$(CONFIG_TI_LMP92064) += ti-lmp92064.o
>> +obj-$(CONFIG_TI_TLA2528) += ti-tla2528.o
>>  obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
>>  obj-$(CONFIG_TI_TSC2046) += ti-tsc2046.o
>>  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
>> diff --git a/drivers/iio/adc/ti-tla2528.c b/drivers/iio/adc/ti-tla2528.c
>> new file mode 100644
>> index 000000000000..9c572e730ffb
>> --- /dev/null
>> +++ b/drivers/iio/adc/ti-tla2528.c
>> @@ -0,0 +1,209 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for Texas Instruments TLA2528 ADC
>> + *
>> + * Copyright (C) 2020-2021 Rodolfo Giometti <giometti@enneenne.com>
>> + * Copyright (C) 2025 Maxime Chevallier <maxime.chevallier@bootlin.com>
>> + */
>> +
>> +#include <linux/delay.h>
> 
> Check the headers to see what is actually used. For example,
> I don't seen any delays/sleeps. And we have a mutex, but no
> mutex header.

I'll give another pass at the includes, thanks :)

> 
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#include <linux/iio/iio.h>
>> +
>> +#define TLA2528_OP_WRITE_REG		0x08
>> +
>> +#define TLA2528_DATA_CFG_ADR		0x02
>> +
>> +/* Datasheet says [5:4] sets the append status, but only bit 4 is used */
>> +#define TLA2528_DATA_CFG_APPEND_STATUS	BIT(4)
>> +#define TLA2528_PIN_CFG_ADR		0x05
>> +#define TLA2528_SEQUENCE_CFG_ADR	0x10
>> +#define TLA2528_CHANNEL_SEL_ADR		0x11
>> +
>> +struct tla2528 {
>> +	struct i2c_client *client;
>> +	int vref_uv;
>> +
>> +	/* Protects manual channel selection, i.e. last_read_channel */
>> +	struct mutex lock;
>> +	u8 last_read_channel;
>> +};
>> +
>> +static s32 tla2528_write_reg(const struct i2c_client *client, u8 reg, u8 val)
> 
> Usually type is just "int" for error code returns.

yeah int makes sense, that's a leftover form the rewriting i've made...

> 
>> +{
>> +	u8 data[3] = {TLA2528_OP_WRITE_REG, reg, val};
>> +	int ret;
>> +
>> +	ret = i2c_master_send(client, data, 3);
>> +
>> +	return ret < 0 ? ret : 0;
>> +}
>> +
> 
> Would it make sense to use regmap instead?

I think so yeah, let me add that to the next iteration. Based on your
comments further down, it should really be worth it.

> 
> 
>> +static int tla2528_read_sample(const struct i2c_client *client)
>> +{
>> +	__be16 data;
>> +	int ret;
>> +
> 
> Don't we need to set the CNVST bit in GENERAL_CFG register to trigger
> a conversion in manual mode?

Let me double-check. From what I've tested, it seems to work without
this, but this may be out of luck.

> 
>> +	ret = i2c_master_recv(client, (char *)&data, 2);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return be16_to_cpu(data) >> 4;
>> +}
>> +
>> +static int tla2528_read(struct tla2528 *tla2528, u8 channel, int *val)
>> +{
>> +	struct i2c_client *client = tla2528->client;
>> +	int ret;
>> +
>> +	if (channel != tla2528->last_read_channel) {
>> +		ret = tla2528_write_reg(client, TLA2528_CHANNEL_SEL_ADR, channel);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		tla2528->last_read_channel = channel;
>> +	}
> 
> If we implemented regmap with cache, then we could avoid having to
> track last_read_channel. We could just call regmap_write() unconditionally
> and the regmap framework would decide if it needs to actually do the write
> or not.

True, that would simplify code so much ! I'll add that

>> +
>> +	ret = tla2528_read_sample(client);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*val = ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int tla2528_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val, int *val2, long mask)
>> +{
>> +	struct tla2528 *tla2528 = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		mutex_lock(&tla2528->lock);
>> +		ret = tla2528_read(tla2528, chan->channel, val);
>> +		mutex_unlock(&tla2528->lock);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = tla2528->vref_uv / 1000;
> 
> Why not just store vref_mV?

heh very good point :)

> 
>> +		*val2 = 12;
>> +
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +#define TLA2528_CHAN(_chan, _name) { \
>> +	.type = IIO_VOLTAGE,					\
>> +	.channel = (_chan),					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>> +	.datasheet_name = _name,				\
>> +	.indexed = 1,						\
>> +}
>> +
>> +static const struct iio_chan_spec tla2528_channel[] = {
>> +	TLA2528_CHAN(0, "AIN0"),
>> +	TLA2528_CHAN(1, "AIN1"),
>> +	TLA2528_CHAN(2, "AIN2"),
>> +	TLA2528_CHAN(3, "AIN3"),
>> +	TLA2528_CHAN(4, "AIN4"),
>> +	TLA2528_CHAN(5, "AIN5"),
>> +	TLA2528_CHAN(6, "AIN6"),
>> +	TLA2528_CHAN(7, "AIN7"),
>> +};
>> +
>> +static const struct iio_info tla2528_info = {
>> +	.read_raw = tla2528_read_raw,
>> +};
>> +
>> +static int tla2528_probe(struct i2c_client *client)
>> +{
>> +	struct iio_dev *indio_dev;
>> +	struct tla2528 *tla2528;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
>> +				     I2C_FUNC_SMBUS_WRITE_WORD_DATA))
>> +		return -EOPNOTSUPP;
> 
> Perhaps we should also fail if the adapter has I2C_AQ_NO_CLK_STRETCH?
> It looks like clock stretching is required for the conversion time.

Good point indeed, I'll add that

> 
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*tla2528));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	tla2528 = iio_priv(indio_dev);
> 
>> +	i2c_set_clientdata(client, indio_dev);
> 
> Not sure this is needed if there is no i2c_get_clientdata() anywhere.

Ah yeah this is a leftover from the devm_* conversion, thanks !

> 
>> +	tla2528->client = client;
>> +
> 
>> +	indio_dev->name = client->name;
> 
> This should be the chip name ("tla2528"), not the I2C device name.

Fair, I'll change that

> 
>> +	indio_dev->info = &tla2528_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->channels = tla2528_channel;
>> +	indio_dev->num_channels = ARRAY_SIZE(tla2528_channel);
>> +
>> +	mutex_init(&tla2528->lock);
> 
> Use dem_mutex_init().

right :)

> 
>> +
>> +	tla2528->vref_uv = devm_regulator_get_enable_read_voltage(&client->dev,
>> +								  "vref");
>> +	if (tla2528->vref_uv < 0)
>> +		return tla2528->vref_uv;
>> +
> 
>> +	/* Set all inputs as analog */
>> +	ret = tla2528_write_reg(tla2528->client, TLA2528_PIN_CFG_ADR, 0x00);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = tla2528_write_reg(tla2528->client, TLA2528_DATA_CFG_ADR,
>> +				TLA2528_DATA_CFG_APPEND_STATUS);
> 
> Why? It doesn't appear to be used.
> 
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Set manual mode */
>> +	ret = tla2528_write_reg(tla2528->client, TLA2528_SEQUENCE_CFG_ADR, 0x00);
>> +	if (ret < 0)
>> +		return ret;
>> +
> 
> 
> Perhaps simpler to just write the RST bit GENERAL_CFG to reset everything
> to a known state?

Alright, I'll clean-up that init sequence

> 
> 
>> +	/* Init private data */
>> +	tla2528->last_read_channel = ~0;
>> +
>> +	return devm_iio_device_register(&client->dev, indio_dev);
>> +}
>> +
>> +static const struct i2c_device_id tla2528_id[] = {
>> +	{ "tla2528", 0 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, tla2528_id);
>> +
>> +static const struct of_device_id tla2528_of_match[] = {
>> +	{ .compatible = "ti,tla2528", },
>> +	{  },
>> +};
>> +MODULE_DEVICE_TABLE(of, tla2528_of_match);
>> +
>> +static struct i2c_driver tla2528_driver = {
>> +	.driver = {
>> +		.name = "tla2528",
>> +		.of_match_table = tla2528_of_match,
>> +	},
>> +	.probe = tla2528_probe,
>> +	.id_table = tla2528_id,
>> +};
>> +module_i2c_driver(tla2528_driver);
>> +
>> +MODULE_AUTHOR("Maxime Chevallier <maxime.chevallier@bootlin.com>");
>> +MODULE_AUTHOR("Rodolfo Giometti <giometti@enneenne.com>");
>> +MODULE_DESCRIPTION("Texas Instruments TLA2528 ADC driver");
>> +MODULE_LICENSE("GPL");
> 

Thank you very much for the thourough review !

Maxime


