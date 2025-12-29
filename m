Return-Path: <linux-iio+bounces-27408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A986DCE63B8
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 09:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6590B3000DD3
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 08:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCD926E6E1;
	Mon, 29 Dec 2025 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNxnPSnH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68543272816
	for <linux-iio@vger.kernel.org>; Mon, 29 Dec 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766996429; cv=none; b=ZGMEYcc3jqU886maKS/4B1Ld10vyeGLiF7noGBvDxuzCa7wx6I5RqxNCsQQrq/jPeUCqUQH14zQFgz66CqnY7m+k6r+aQ5oVRGCi/2MxBGptp9mP4qRJpC8teSINPVfKOgsXTJj+Dt9Tk79cfBEgcBruTqdpkm6/iKJEn69p1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766996429; c=relaxed/simple;
	bh=XNKCfyWlS1I9hXURg/ShCfdueGtYndG0m6Ppfilh1oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPEXfcTtWNMofizV4HC2tVhNIZyKUVubWCYlgsC9XCE3/zg8LB+nLd3AIX70Ky+APHZ6Cnn3pq1jHZD6VbUsnZjiku42vomsWWCcn4bmSqoQfMrP6IYxT3XYpwQmCtn3gBIwvLayDmC0S3xzcIJEWLD/b12egPsC1niHSXqcryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNxnPSnH; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-594330147efso10674329e87.2
        for <linux-iio@vger.kernel.org>; Mon, 29 Dec 2025 00:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766996425; x=1767601225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n51YESICvfpRm8ksQv4jSSb8R6pc2K6b6lP0CB2YgHs=;
        b=kNxnPSnHckWxlg9kC2CqroMYwyBPW87AY2zp5SOeShwsdGgRdcuR849cQLYkQVMpCM
         Pw17jWtjWicwKGnRnmlUUkRpBghuoWf9i4zQVqDX5DtevAthFUJdT9dxZVnaPQGdp0b9
         uEFyhYV/5eC4dmoGKPmQeoPZHasInUQuQKkjtmFoZRKrGV5znykDCSd4pUi59avRw7Q0
         DnOsxLVp7/zB/ClqCYanf8uNWXBVy8n/E2n7s9XiMtc/0GfIhKrWz+KJqg/Q+S5JqnHu
         +CQ3gaY2W9cKgS6OtNMcWbJu6c4SxK9s4hM1pAQMgSBksGdr9OlwPuJXdXqbziFbGWYP
         M3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766996425; x=1767601225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n51YESICvfpRm8ksQv4jSSb8R6pc2K6b6lP0CB2YgHs=;
        b=dDo9v4SrIOF7LlUBuoZDAwLy1sWra5PddHVDXD/1CIzS1pnj1u4xCBbAYdvf0gyBtS
         7/pM67nj5krZZUPdkZG+5YDxVLiiHMXPn/gkX9CcuXNSfSOgx+6+hG6wAOnCEzWH+lcA
         DYASdiuZxhm1FvJOuvTOkUyMCZG5KEeaRfQhQhhgSVecFxU78xQYCSOkH85Op3HJ1SPI
         o6+42912DVI8Lp6DyF2dQ5GEoZ75p2vlVzS5hQzCfp0czkUz1hxvTS+R/AOIQJtFIr67
         l/p2QN/b8NObKYZgrwDFzPttM4ilezN0ktwMmQ+xicWE7C5uygKSIRABts5BtNPiYTDX
         b09A==
X-Gm-Message-State: AOJu0YxpoSz4L++GW8LkvsvmS9jYcYrN6UzEw2p+BliaHnBejCxewcqD
	9oxyhPJlN+EwXCR1V7QrY/NMUpHM2t1AELSN1CxJlYaqcU/xQeBtN0b8
X-Gm-Gg: AY/fxX4DVR1jPwuJ527bVfzuThEX8Wo1PBl7vXUedaloP70MNILlTS8XqpT9RncTQ+9
	eeLDz6nSmJdCelVxUCMlHzazJ1NWNfVxQ8yZQj8LqldSOnn/L2RRMXCRcQoHrYm+EQHZ65C3OUf
	MnrHpCds0pzNCuZywV2/3X7STIwys54imwKEOOYm8MRTYXC8rf+eGVhK8foLyxQZDncC4hkYSs5
	DLKrzOV+pHMtcLfjFVDqc+U6emK8Ea8uvbHfXonWGAmSSnGYGh+31/E4uRCFmLNU/BcL3+fgCVg
	7+uUIxLibaVRMxecMtRpOH2QQelBQIC+VU044Dai6CZrOE6zRoEF6+YkW3xxnuopLSm+Kh5c09W
	cR04l2ngmfzWgMU0Qh+fMiucDj31JctNXZYIOW+Bx++i8+RBlm9UeojobXDbhGYoCbwL7URqGaf
	ZJ/sz1XfBLhNIGtaIwpzJ1mBDl66GGsj5jvsqDdqMF0qKt11o1/IICcFdj4lR38PCAbvig
X-Google-Smtp-Source: AGHT+IF+bA86J9sN/fDCC7icLlIgcEX2Mgl5aUrTsacSBJ5uQaHoHx1SitOJ6/8y+CDd8CA4crZJlA==
X-Received: by 2002:a05:6512:1588:b0:598:95ad:11b0 with SMTP id 2adb3069b0e04-59a17d495c0mr9018172e87.6.1766996425210;
        Mon, 29 Dec 2025 00:20:25 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861f2c9sm9058645e87.68.2025.12.29.00.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 00:20:24 -0800 (PST)
Message-ID: <efbe9720-0974-4d5e-9a03-fefd3c86e275@gmail.com>
Date: Mon, 29 Dec 2025 10:20:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: add driver for Texas Instruments TLA2528
 adc
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 nuno.sa@analog.com, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
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
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251223155534.220504-3-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/12/2025 17:55, Maxime Chevallier wrote:
> This adds a new driver for the TI TLA2528 ADC chip. It ha 8 12-bit
> channels, that can also be configured as 16-bit averaging channels.
> 
> Add a very simple driver for it, allowing reading raw values for each
> channel.
> 
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>   MAINTAINERS                  |   7 ++
>   drivers/iio/adc/Kconfig      |  10 ++
>   drivers/iio/adc/Makefile     |   1 +
>   drivers/iio/adc/ti-tla2528.c | 209 +++++++++++++++++++++++++++++++++++
>   4 files changed, 227 insertions(+)
>   create mode 100644 drivers/iio/adc/ti-tla2528.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dc731d37c8fe..5c382ae216c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25866,6 +25866,13 @@ F:	include/dt-bindings/soc/ti,sci_pm_domain.h
>   F:	include/linux/soc/ti/ti_sci_inta_msi.h
>   F:	include/linux/soc/ti/ti_sci_protocol.h
>   
> +TEXAS INSTRUMENTS' TLA2528 ADC DRIVER
> +M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
> +F:	drivers/iio/adc/ti-tla2528.c
> +
>   TEXAS INSTRUMENTS' TMP117 TEMPERATURE SENSOR DRIVER
>   M:	Puranjay Mohan <puranjay@kernel.org>
>   L:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 58da8255525e..67376de410bf 100644

Hmm. Would it ease merging if MAINTAINERS changes were in their own patch?

> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1803,6 +1803,16 @@ config TI_LMP92064
>   	  This driver can also be built as a module. If so, the module will be called
>   	  ti-lmp92064.
>   
> +config TI_TLA2528
> +	tristate "Texas Instruments TLA2528 ADC driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for Texas Instruments TLA2528
> +	  12-Bit 8-Channel ADC.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ti-tla2528.
> +
>   config TI_TLC4541
>   	tristate "Texas Instruments TLC4541 ADC driver"
>   	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 7cc8f9a12f76..941606defbf7 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -157,6 +157,7 @@ obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
>   obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
>   obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>   obj-$(CONFIG_TI_LMP92064) += ti-lmp92064.o
> +obj-$(CONFIG_TI_TLA2528) += ti-tla2528.o
>   obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
>   obj-$(CONFIG_TI_TSC2046) += ti-tsc2046.o
>   obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
> diff --git a/drivers/iio/adc/ti-tla2528.c b/drivers/iio/adc/ti-tla2528.c
> new file mode 100644
> index 000000000000..9c572e730ffb
> --- /dev/null
> +++ b/drivers/iio/adc/ti-tla2528.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Texas Instruments TLA2528 ADC
> + *
> + * Copyright (C) 2020-2021 Rodolfo Giometti <giometti@enneenne.com>
> + * Copyright (C) 2025 Maxime Chevallier <maxime.chevallier@bootlin.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define TLA2528_OP_WRITE_REG		0x08
> +
> +#define TLA2528_DATA_CFG_ADR		0x02
> +
> +/* Datasheet says [5:4] sets the append status, but only bit 4 is used */
> +#define TLA2528_DATA_CFG_APPEND_STATUS	BIT(4)
> +#define TLA2528_PIN_CFG_ADR		0x05
> +#define TLA2528_SEQUENCE_CFG_ADR	0x10
> +#define TLA2528_CHANNEL_SEL_ADR		0x11
> +
> +struct tla2528 {
> +	struct i2c_client *client;
> +	int vref_uv;
> +
> +	/* Protects manual channel selection, i.e. last_read_channel */
> +	struct mutex lock;
> +	u8 last_read_channel;
> +};
> +
> +static s32 tla2528_write_reg(const struct i2c_client *client, u8 reg, u8 val)
> +{
> +	u8 data[3] = {TLA2528_OP_WRITE_REG, reg, val};
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
> +	if (ret < 0)
> +		return ret;
> +
> +	return be16_to_cpu(data) >> 4;
> +}

Can regmap be used for all the usual benefits?

> +
> +static int tla2528_read(struct tla2528 *tla2528, u8 channel, int *val)
> +{
> +	struct i2c_client *client = tla2528->client;
> +	int ret;
> +
> +	if (channel != tla2528->last_read_channel) {
> +		ret = tla2528_write_reg(client, TLA2528_CHANNEL_SEL_ADR, channel);
> +		if (ret < 0)
> +			return ret;
> +
> +		tla2528->last_read_channel = channel;
> +	}
> +
> +	ret = tla2528_read_sample(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = ret;
> +
> +	return 0;
> +}
> +
> +static int tla2528_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct tla2528 *tla2528 = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&tla2528->lock);
> +		ret = tla2528_read(tla2528, chan->channel, val);
> +		mutex_unlock(&tla2528->lock);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = tla2528->vref_uv / 1000;
> +		*val2 = 12;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define TLA2528_CHAN(_chan, _name) { \
> +	.type = IIO_VOLTAGE,					\
> +	.channel = (_chan),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.datasheet_name = _name,				\
> +	.indexed = 1,						\
> +}
> +
> +static const struct iio_chan_spec tla2528_channel[] = {
> +	TLA2528_CHAN(0, "AIN0"),
> +	TLA2528_CHAN(1, "AIN1"),
> +	TLA2528_CHAN(2, "AIN2"),
> +	TLA2528_CHAN(3, "AIN3"),
> +	TLA2528_CHAN(4, "AIN4"),
> +	TLA2528_CHAN(5, "AIN5"),
> +	TLA2528_CHAN(6, "AIN6"),
> +	TLA2528_CHAN(7, "AIN7"),
> +};

Not really insisting a change here, merely giving a nudge :)

I wonder if the channels should be obtained from fwnode? I think the 
dt-review mentioned channel inputs may be used for GPIOs? One might be 
able to use the devm_iio_adc_device_alloc_chaninfo_se() to build the 
chan_spec based on the dt - depending on the non dt use-cases.

All in all, I think this is clean and nice driver.

> +static const struct iio_info tla2528_info = {
> +	.read_raw = tla2528_read_raw,
> +};
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
> +	tla2528->client = client;
> +
> +	indio_dev->name = client->name;
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

As mentioned above, perhaps get the channels from the DT, and only mux 
the given channels?

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
> +
> +static const struct i2c_device_id tla2528_id[] = {
> +	{ "tla2528", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tla2528_id);
> +
> +static const struct of_device_id tla2528_of_match[] = {
> +	{ .compatible = "ti,tla2528", },
> +	{  },
> +};
> +MODULE_DEVICE_TABLE(of, tla2528_of_match);
> +
> +static struct i2c_driver tla2528_driver = {
> +	.driver = {
> +		.name = "tla2528",
> +		.of_match_table = tla2528_of_match,
> +	},
> +	.probe = tla2528_probe,
> +	.id_table = tla2528_id,
> +};
> +module_i2c_driver(tla2528_driver);
> +
> +MODULE_AUTHOR("Maxime Chevallier <maxime.chevallier@bootlin.com>");
> +MODULE_AUTHOR("Rodolfo Giometti <giometti@enneenne.com>");
> +MODULE_DESCRIPTION("Texas Instruments TLA2528 ADC driver");
> +MODULE_LICENSE("GPL");

Yours,
	-- Matti

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

