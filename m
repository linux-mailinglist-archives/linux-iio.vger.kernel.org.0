Return-Path: <linux-iio+bounces-27483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0320CF2F1D
	for <lists+linux-iio@lfdr.de>; Mon, 05 Jan 2026 11:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F8A301A1EC
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jan 2026 10:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9110E2F5331;
	Mon,  5 Jan 2026 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gi8UZXsi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB351DED4C
	for <linux-iio@vger.kernel.org>; Mon,  5 Jan 2026 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608209; cv=none; b=erpK4syhhoEPDMfX1k4p1P6RrZF0lvOXj38g33AX+GUhPoZCBgl9KvwXi5YJGuoDI04nny3/wL2rN8nBf41OTA0jC9M1j8oQSi0/0lQEmbWYRB0XK7l3cMa07hPpSERMYm5xnSetMFmfVdtqFhar/1GOc/UXPvwmjyqMd/pF7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608209; c=relaxed/simple;
	bh=zhwiU7+UFM3MuARK2xUVYw5YaqIrTK76opBr5mY9Op8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPpbZBpzkS8OoNYTzBtcGSNqRI4uThCTeIo4xEmrbkkCJFPuqL2lK39G/bT/bnz7Slsg622izzLk9V/f9VlIHTW6UocYq8WMIVqLmDEpfk7+HERNYx/0yqCJ00agOApaq4KjF/8YBWaCtCTsjya1WafpmUdaDbxZmaXNNv+ar00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gi8UZXsi; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 725E0C1E482;
	Mon,  5 Jan 2026 10:16:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6162C60726;
	Mon,  5 Jan 2026 10:16:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA8DE103C83C7;
	Mon,  5 Jan 2026 11:16:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767608204; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=o0Dw7c1k+THI2TwhCkTngwgqRsYS8Yp0bFJ1g1p/qdw=;
	b=gi8UZXsiDQX1xyf9fMQeKGEh91wgT4fZ3LCvz57qJyzKPYEGP1A8xxdspExt4CRmzqZYcq
	ckNRMzAQAxEsh3wLjDscqBZeCX8wKDc4pn4RrsNuQgdrNKMLefmRy3wh5tX7Jl8tysOIGD
	9725TxbIzSy2p2LueqZakP59xUUqNlP0zAvl2T1hQi79XhuU1W9Pf2OZ/lKhnNvEf6zCOG
	OcxFHTtDi4xFZqmDrfPFF3z1QI68yQulhfGx28um5GLBsMppRMdJN9KQ3/oTkalfSAt7zm
	fCbvveokLMMx0+GQW+8X0/trsedkewn/X7vt+u19tbF9ACJF7+mYnmXQ3bxP4w==
Message-ID: <6b7bf02e-d016-4d2b-a409-6cd378d409fb@bootlin.com>
Date: Mon, 5 Jan 2026 11:16:39 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: add driver for Texas Instruments TLA2528
 adc
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 duje@dujemihanovic.xyz, herve.codina@bootlin.com,
 Rodolfo Giometti <giometti@enneenne.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
 <20251223155534.220504-3-maxime.chevallier@bootlin.com>
 <20251227184204.6815a3b4@jic23-huawei>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251227184204.6815a3b4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jonathan,

On 27/12/2025 19:42, Jonathan Cameron wrote:
> On Tue, 23 Dec 2025 16:55:33 +0100
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
>> This adds a new driver for the TI TLA2528 ADC chip. It ha 8 12-bit
>> channels, that can also be configured as 16-bit averaging channels.
>>
>> Add a very simple driver for it, allowing reading raw values for each
>> channel.
>>
>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Hi Maxime,
> 
> A few extra bits from me
> 
> Thanks,
> 
> Jonathan
> 
> 
>> diff --git a/drivers/iio/adc/ti-tla2528.c b/drivers/iio/adc/ti-tla2528.c
>> new file mode 100644
>> index 000000000000..9c572e730ffb
>> --- /dev/null
>> +++ b/drivers/iio/adc/ti-tla2528.c
>> @@ -0,0 +1,209 @@
> 
>> +
>> +static s32 tla2528_write_reg(const struct i2c_client *client, u8 reg, u8 val)
>> +{
>> +	u8 data[3] = {TLA2528_OP_WRITE_REG, reg, val};
> 
> Style wise. Prefer { TLA25... val };

Sure thing, I'll address that.

> 
> - couple of spaces next to the brackets.
> 
>> +	int ret;
>> +
>> +	ret = i2c_master_send(client, data, 3);
>> +
>> +	return ret < 0 ? ret : 0;
>> +}
>> +
>> +static int tla2528_read_sample(const struct i2c_client *client)
>> +{
>> +	__be16 data;
>> +	int ret;
>> +
>> +	ret = i2c_master_recv(client, (char *)&data, 2);
> 
> sizeof(data)
> 
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return be16_to_cpu(data) >> 4;
>> +}
> 
>> +
>> +#define TLA2528_CHAN(_chan, _name) { \
> 
> The _ aren't adding anything here, so I'd drop them.
> 
>> +	.type = IIO_VOLTAGE,					\
>> +	.channel = (_chan),					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>> +	.datasheet_name = _name,				\
>> +	.indexed = 1,						\
>> +}

Absolutely :)

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
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*tla2528));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	tla2528 = iio_priv(indio_dev);
>> +	i2c_set_clientdata(client, indio_dev);
> 
> Ever used? If not don't set it.

David mentionned that as well, I'll drop this as this is no longer
required. It used to be required before switching to devm_ helpers.

> 
>> +	tla2528->client = client;
>> +
>> +	indio_dev->name = client->name;
> 
> Prefer to see it hard coded as a string.  If we added extra firmware
> types in future the content of client->name can become something other
> than the part number.

True, I'll change that

> 
> 
>> +	indio_dev->info = &tla2528_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->channels = tla2528_channel;
>> +	indio_dev->num_channels = ARRAY_SIZE(tla2528_channel);
>> +
>> +	mutex_init(&tla2528->lock);
>> +
>> +	tla2528->vref_uv = devm_regulator_get_enable_read_voltage(&client->dev,
>> +								  "vref");
>> +	if (tla2528->vref_uv < 0)
>> +		return tla2528->vref_uv;
>> +
>> +	/* Set all inputs as analog */
>> +	ret = tla2528_write_reg(tla2528->client, TLA2528_PIN_CFG_ADR, 0x00);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = tla2528_write_reg(tla2528->client, TLA2528_DATA_CFG_ADR,
>> +				TLA2528_DATA_CFG_APPEND_STATUS);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Set manual mode */
>> +	ret = tla2528_write_reg(tla2528->client, TLA2528_SEQUENCE_CFG_ADR, 0x00);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Init private data */
>> +	tla2528->last_read_channel = ~0;
>> +
>> +	return devm_iio_device_register(&client->dev, indio_dev);
>> +}

Thanks for the reviews :)

Maxime

