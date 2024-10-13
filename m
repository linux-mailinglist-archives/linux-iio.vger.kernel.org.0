Return-Path: <linux-iio+bounces-10532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0C099B800
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 04:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A9C1F22845
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 02:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F45617FE;
	Sun, 13 Oct 2024 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="Qn03igP5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BwpOhhpz"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6668BF0;
	Sun, 13 Oct 2024 02:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728787323; cv=none; b=LA2yLWG51TJS7wQvBzt5JCmK4sfMqwWeivE44KWiD/NU/zzXaA3hrLddfRHbcOjwACksComUwCuHs6Q1w5oHUmtmA8fQSkKnctP5y+azJ11yryMYjxtpE5mKMyUKw/sBR8qCaYWalg1n7exMDVkIgJFkiOEaZZz69o6hknsLKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728787323; c=relaxed/simple;
	bh=SwJ5mj5odNFSCLOnu4Gvn4AEN4AHjrhJ5wIYoZb1a4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NiqLqYZtWzvgPCGVeFFP+ymcxsTDjMn2KEmmt4yx2iDx9KXutLVYyVAQM5v3R0hYIeTZmtwr9aH0L+FFaYDAJvYwROQEH1freeWIMEJ4DK41gd3a3uL4X5yRNi5CbltBFn9Fh7XdnfgbjQ58+VqP4sI1VpKv/NyACEB3JV1feRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=Qn03igP5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BwpOhhpz; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6BB1E1380278;
	Sat, 12 Oct 2024 22:42:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 12 Oct 2024 22:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728787320; x=
	1728873720; bh=2jv+WSh8c01fwbEG9TWlN1BX0ykQhFhFq/D/99UYLzg=; b=Q
	n03igP5BSyHIirwzV4Bk39Xd8Rkvi4TZ/ltLhwr/RgXodkNN5TrDeHmBQbSioKby
	W/FggZiHmF+PX/BFXXAaseVjk7OJ7gwbZFNl9aD3sgQMTwHDo6itrxW9RUjuk/Is
	lM+ykmlldLH1KFud8b5k9qZgLo2x3v9elIMvlceTkxq8QIOQvIWmxZY4JgwR0TCe
	RjfyQbUxmgImMw2TMl2kycB7BMiPbGEyY/jzhxpRV8Zl/L0TAdwC4oxud1dJH+Z0
	PDAxJeWKa2HrK1nrXvy86JUq1mVrF+wFaBdVeNEwJOhn2vkAPo7kJS48H9PLcY73
	pVCShmb+rZ4YTPnSXcg9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728787320; x=1728873720; bh=2jv+WSh8c01fwbEG9TWlN1BX0ykQ
	hFhFq/D/99UYLzg=; b=BwpOhhpzKcr8UFlkzj0U7nvAYu3pKCdWJFILaAAyXxMX
	mps0/IxQiAhrtJ6B9mczJ3Pj1WOTorwWvllOCyhzBJJHSCl0nQwcOkkB0i4D7ynI
	w7oODlfErIbu5/UHzBBsYmmC5KpeCwMgvs+LT9oHA9go2zjV0X2+gAQLL79gI4I2
	scn3vrPZDP6AZI+uNM7QipGdj+xbcqFdC5DzmLxx7Mr+70JugkJKfJ/l51pvzntW
	QZd7P2lLte/cbsagFigTdOZgNBXz7JmHNhbdAn+U/KXnaJhqpH/14oDgbx48tM3H
	GtKtFJyjr74ccu5dF8GY/NB1IRDJ+wdnZ+/jWRFwOA==
X-ME-Sender: <xms:dzMLZ9NizXWFp5mCubv1MIO5iGqg3I4HER3ci98ZSSL5obpxVf_Vrg>
    <xme:dzMLZ__BtgsC9rS16DYt7W_PlIJ4KAN-Qk1-T36m0oKdQE_go5vbl8_wka_OUww3z
    lZR0fFsff_p7DsZ-A>
X-ME-Received: <xmr:dzMLZ8QLkB-Go91fkEaDZ7GZGsBftOfbpCXOTl7F7XmfRo8NXwSPVjWOCU2vzhSsy_CToRZTj5IO0_E_w4R3HHEaEzXDlNUg4f4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegvddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpeevveevudeutdehgeehvdeuieduteeh
    kefhleefffegheejhfdulefgjefhffefueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhu
    shhtihhnsehjuhhsthhinhifvghishhsrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhmsehmrghnjhgrrhhordhorhhg
    pdhrtghpthhtohepuggvrhgvkhhjohhhnhdrtghlrghrkhesghhmrghilhdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhiihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhgrrhhssehmvghtrghfohhordguvgdprhgtphhtthhopehlrghniigrnhho
    rdgrlhgvgiesghhmrghilhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:dzMLZ5uGevAjzKRXN-99tVVU5X6Coo2q4QMkckg_8frN4xbvJQkAbQ>
    <xmx:dzMLZ1dWQjbxfNm6fMkYxYAoE9chwGEW-u0jVCSZNUaNhXKeuhyUNw>
    <xmx:dzMLZ12J6z6YJ63-xq4lagkcbrD6RoqiUY1dMcKIQPNy-03QwNUg9w>
    <xmx:dzMLZx-cDCJ-I6HJ-WDXT8hi7HnYhrTffaOTw33OxXuJncG0eCR2Tw>
    <xmx:eDMLZ_vJ4OC24H_jiZYRzQvpQrLPc8UmOz1PSRn4OcrJ1hA7PZ9IF4lh>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 22:41:58 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  linux-iio@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH 1/3] iio: imu: Add i2c driver for bmi260 imu
In-Reply-To: <20241012120830.338aca19@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 12 Oct 2024 12:08:30 +0100")
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-2-justin@justinweiss.com>
	<20241012120830.338aca19@jic23-huawei>
Date: Sat, 12 Oct 2024 19:41:58 -0700
Message-ID: <874j5grafd.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Fri, 11 Oct 2024 08:37:47 -0700
> Justin Weiss <justin@justinweiss.com> wrote:
>
> Title needs an edit to reflect the description that follows.
>
> iio: imu: bmi270: Add i2c support for bmi260

Thanks, I'll fix this in v2.

>> Adds i2c support for the Bosch BMI260 6-axis IMU to the Bosch BMI270
>> driver. Setup and operation is nearly identical to the Bosch BMI270,
>> but has a different chip ID and requires different firmware.
>> 
>> Firmware is requested and loaded from userspace.
>> 
>> Signed-off-by: Justin Weiss <justin@justinweiss.com>
>> ---
>>  drivers/iio/imu/bmi270/bmi270.h      | 16 ++++++++++++++-
>>  drivers/iio/imu/bmi270/bmi270_core.c | 29 +++++++++++++++++++++++-----
>>  drivers/iio/imu/bmi270/bmi270_i2c.c  | 22 ++++++++++++++++++---
>>  drivers/iio/imu/bmi270/bmi270_spi.c  | 11 ++++++++---
>>  4 files changed, 66 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
>> index 8ac20ad7ee94..51e374fd4290 100644
>> --- a/drivers/iio/imu/bmi270/bmi270.h
>> +++ b/drivers/iio/imu/bmi270/bmi270.h
>> @@ -10,10 +10,24 @@ struct device;
>>  struct bmi270_data {
>>  	struct device *dev;
>>  	struct regmap *regmap;
>> +	const struct bmi270_chip_info *chip_info;
>> +};
>> +
>> +enum bmi270_device_type {
>> +	BMI260,
>> +	BMI270,
>> +};
> It is obviously fairly trivial in this case, but the 'ideal' form for
> a patch series adding this flexibility is:
> Patch 1) Add a noop refactor to include the configuration structures etc.
> Patch 2) Add the support for the new device.
>
> First patch can then be reviewed on basis it's not destructive and second one just for
> the chip specific data added

Makes sense, I'll split these up for v2.

>> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
>> index aeda7c4228df..e5ee80c12166 100644
>> --- a/drivers/iio/imu/bmi270/bmi270_core.c
>> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
>> @@ -11,6 +11,7 @@
>
>>  static int bmi270_get_data(struct bmi270_data *bmi270_device,
>>  			   int chan_type, int axis, int *val)
>>  {
>> @@ -154,8 +170,8 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
>>  	if (ret)
>>  		return dev_err_probe(dev, ret, "Failed to read chip id");
>>  
>> -	if (chip_id != BMI270_CHIP_ID_VAL)
>> -		dev_info(dev, "Unknown chip id 0x%x", chip_id);
>> +	if (chip_id != bmi270_device->chip_info->chip_id)
> If we have multiple known IDs it can be slightly more friendly to check them all
> and if another one matches, just moan about broken firmware before carrying on
> using the correct data.

Sounds good. I'll dev_info a message if it doesn't match what the
chip_info expects, and then switch to the chip_info corresponding to the
chip ID returned by the device.

>
>> +		return dev_err_probe(dev, -ENODEV, "Unknown chip id 0x%x", chip_id);
>>  
>>  	return 0;
>>  }
>> @@ -187,7 +203,8 @@ static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
>>  		return dev_err_probe(dev, ret,
>>  				     "Failed to prepare device to load init data");
>>  
>> -	ret = request_firmware(&init_data, BMI270_INIT_DATA_FILE, dev);
>> +	ret = request_firmware(&init_data,
>> +			       bmi270_device->chip_info->fw_name, dev);
>>  	if (ret)
>>  		return dev_err_probe(dev, ret, "Failed to load init data file");
>>  
>> @@ -274,7 +291,8 @@ static int bmi270_chip_init(struct bmi270_data *bmi270_device)
>>  	return bmi270_configure_imu(bmi270_device);
>>  }
>
>> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
>> index e9025d22d5cc..c8c90666c76b 100644
>> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
>> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
>> @@ -18,28 +18,44 @@ static int bmi270_i2c_probe(struct i2c_client *client)
>>  {
>>  	struct regmap *regmap;
>>  	struct device *dev = &client->dev;
>> +	const struct bmi270_chip_info *chip_info;
>> +
>> +	chip_info = i2c_get_match_data(client);
>> +	if (!chip_info)
>> +		return -ENODEV;
>>  
>>  	regmap = devm_regmap_init_i2c(client, &bmi270_i2c_regmap_config);
>>  	if (IS_ERR(regmap))
>>  		return dev_err_probe(dev, PTR_ERR(regmap),
>>  				     "Failed to init i2c regmap");
>>  
>> -	return bmi270_core_probe(dev, regmap);
>> +	return bmi270_core_probe(dev, regmap, chip_info);
>>  }
>>  
>>  static const struct i2c_device_id bmi270_i2c_id[] = {
>> -	{ "bmi270", 0 },
>> +	{ "bmi260", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
>> +	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info[BMI270] },
>>  	{ }
>>  };
>>  
>> +static const struct acpi_device_id bmi270_acpi_match[] = {
>> +	{ "BOSC0260", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
>> +	{ "BMI0260",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },
>> +	{ "BOSC0160", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
>> +	{ "BMI0160",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },
>
> Sigh.  That's not a valid ACPI ID or PNP ID.
> (Well technically it is, but it belongs to the Benson Instrument Company
> not Bosch)
>
> Which of these have been seen in the wild?
> For any that are not of the BOSC0160 type form add a comment giving
> a device on which they are in use.

I know of the BMI0160 (this seems to be the most common way the BMI260
is identified on handheld PCs), and the 10EC5280 has been seen in the
wild, as described here:
https://lore.kernel.org/all/CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com/

I have not personally seen any devices using BMI0260, but I'll add
comments to the BMI0160 and 10EC5280 entries with some examples of
devices that use those IDs.

>> +	{ "10EC5280", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
>
> What's this one?  There is no such vendor ID.
>
>> +	{ },
> No trailing comma on null terminators like this.

Thanks, will fix in v2.

>> +};
>> +
>>  static const struct of_device_id bmi270_of_match[] = {
>> -	{ .compatible = "bosch,bmi270" },
>> +	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },
>
> Add the 260 here as well + add to the dt docs.

Will fix in v2.

>>  	{ }
>>  };
>>  
>>  static struct i2c_driver bmi270_i2c_driver = {
>>  	.driver = {
>>  		.name = "bmi270_i2c",
>> +		.acpi_match_table = bmi270_acpi_match,
>>  		.of_match_table = bmi270_of_match,
>>  	},
>>  	.probe = bmi270_i2c_probe,
>> diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
>> index 34d5ba6273bb..3d240f9651bc 100644
>> --- a/drivers/iio/imu/bmi270/bmi270_spi.c
>> +++ b/drivers/iio/imu/bmi270/bmi270_spi.c
>> @@ -50,6 +50,11 @@ static int bmi270_spi_probe(struct spi_device *spi)
>>  {
>>  	struct regmap *regmap;
>>  	struct device *dev = &spi->dev;
>> +	const struct bmi270_chip_info *chip_info;
>> +
>> +	chip_info = spi_get_device_match_data(spi);
>> +	if (!chip_info)
>> +		return -ENODEV;
>>  
>>  	regmap = devm_regmap_init(dev, &bmi270_regmap_bus, dev,
>>  				  &bmi270_spi_regmap_config);
>> @@ -57,16 +62,16 @@ static int bmi270_spi_probe(struct spi_device *spi)
>>  		return dev_err_probe(dev, PTR_ERR(regmap),
>>  				     "Failed to init i2c regmap");
>>  
>> -	return bmi270_core_probe(dev, regmap);
>> +	return bmi270_core_probe(dev, regmap, chip_info);
>>  }
>>  
>>  static const struct spi_device_id bmi270_spi_id[] = {
>> -	{ "bmi270" },
>> +	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info[BMI270] },
>>  	{ }
>>  };
>>  
>>  static const struct of_device_id bmi270_of_match[] = {
>> -	{ .compatible = "bosch,bmi270" },
>> +	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },
>
> If the bmi260 supports SPI, should be added here as well. (I've no idea if it does!)
>
> Or is this because you can't test it?

Yeah, it was because I can't test it, the BMI260 does support SPI. I can
add entries here, though.

Should the ACPI match entries from I2C also go here? All of the devices
with mismatched IDs seem to use I2C so there might not be as much of a
problem here.

>>  	{ }
>>  };
>>  

Thanks again,
Justin

