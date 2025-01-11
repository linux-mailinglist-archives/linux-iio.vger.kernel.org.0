Return-Path: <linux-iio+bounces-14146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 123F1A0A675
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 00:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4947A37C0
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 23:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13571B9831;
	Sat, 11 Jan 2025 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVBEL131"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF951CFBC;
	Sat, 11 Jan 2025 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736636680; cv=none; b=Y9CaOD1BWU1QiZp2yJVm5+Orqt3/6dfYWpdShq1JTFEt37JNaEFQnYhRSprBJrxZG9h76uemwcUF3vxwo31qw05C4sScDuf8bUBWwjJ8pZDDAkCKdYnpUECmiV6LPpn6OWS3AlD0PlnChDsYYphXiMQPb7Z02+VN4jMChqxPYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736636680; c=relaxed/simple;
	bh=W2H3AW6407JrXP6XAsE6+DrUggYoa4M4nN/h6ORef3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRcmV1MqbG8INzLwRC0Ag0JmZT62w39H/5T4eDX6wLf7NUgUBvlKDuiReTgNExZ1ow9fade9pfbySJcox1jok/WFnH//h0QQgEV4JIsh1rU1GcHQhAt0tbQvaVnwFOAF/itag1YEqpf9X61GVMT0z+zQRCPbIbnaxC7G4c4/3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVBEL131; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54024ecc33dso3314802e87.0;
        Sat, 11 Jan 2025 15:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736636677; x=1737241477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w55y3+3erCyA+fwa/UE39zyE5mUBB5pydvZI9fr70hw=;
        b=QVBEL1310vLDybx38keHPx01ZPKLTofXDrfFMLqk8UJn4EPwftyL7iT7BkOFDL7D+S
         yMW4ugjgAritfvwazYiC+Moj9Kdmo8BagzkaEI+DIac8fU8bHBnLQ+SlabD7nzvyCxQN
         AzJ24bwukVALDHgianbPh0rp+LUbeWVJ4xcoLQUDvok+umfeyPJJwakjEACaCBm+wozX
         BOOkNPLgN9cCM4fH6iag+y14z/9fHvQ51JqiJCVfo1HhfFFHGvKTFHyrwicRJj/KS0fZ
         eY9krCKSCAMAHJlH7MD/dYkOy/TyLVF8u2lm7MA+bCH4N+pjGK3QAEFf7fA75I5lxFnU
         Jv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736636677; x=1737241477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w55y3+3erCyA+fwa/UE39zyE5mUBB5pydvZI9fr70hw=;
        b=U+7+g+0qG6KBumvBr3ECP0LUpu15Om76qkBwmE4pP7fqR5oCthmvsg4hP4YAET60Nu
         3w9X6iGhmzXLZrK2Xj6GHAXTiPBhWrfzsYaCE6d79Nmr51r3YnhW3Cop0thYEYqhWJb4
         SxzrV+3SQgJQIkKnN7qjO/EGRTcZMNXwUMI7cPf10Gf6VMUClezngpMUnkoIBcE62wl4
         4Hh0pmKg+EVnoqBk6b60ISRMCP5dEsE6vauxcFgAeSCeFT3WqR/0vQsVx6aZJnxXp9bg
         Ebal46qCoveTXhiYNWVs6dGMNsEp4gXHb4fP9SUgCQfhcqxROptBHsTnVcGZuygwJ5jV
         LYBg==
X-Forwarded-Encrypted: i=1; AJvYcCUfs07ltg/QaLbIl6mPFAL/qfTLfFdID8KbmOZeBDU27uE/RIsLfubvJd7SIHWEae/0fHJKam9MEp/jjWoK@vger.kernel.org, AJvYcCVDYlkCCbRhZ+I2HX3GQaqNedwoRNrWmXkQ63DN3+qpKUsvzRsQ2O6t6W5pRMssCPFsySuAz56K+rM3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1CrOyo9cAiwL7WQiNNERoGBUW7r8XKowbigSo2C0xN2mNHZpz
	EWYsTiJwrbZcLiV+evLYhIaIQwRg+LSarHC4APVvrH1Twn7i5LeM
X-Gm-Gg: ASbGncsaZ3BjnI8xVSiyCLb04VJRXd2mvjzHMobWyf2zHlfsk6Joz4UlBTGh+/KVVl3
	C3nV7I3gwyljNR5BhDQsYjxCMJxhz6dX9nuO+UYNlZy9rpfeXZuuAT4+nC58Tu4yTcG6o0kmJ+R
	aq071MUUa8Re59QMYQiKtdWbwzHLZddtfQK7ouRKce8SD0tJ9Bs9cg4Oei70blQa5x0hO3i4D4O
	bEzD41GzD0xky1pKiRyWrbJIReaL6yM7nuCpy9ZMvxZcpdDwMvDoZZt1ze63ONSNpI6
X-Google-Smtp-Source: AGHT+IFo+nLjLF6Oglw5MtqkMHVxv611rxkq4yDYJnjnR12ZaaxKIguR/K5cKAaiXr5f8CpBkQ6ZpA==
X-Received: by 2002:a05:6512:4013:b0:540:1e65:1d7d with SMTP id 2adb3069b0e04-54284545eadmr4888517e87.23.1736636676561;
        Sat, 11 Jan 2025 15:04:36 -0800 (PST)
Received: from [192.168.31.111] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428bea6a7dsm920499e87.150.2025.01.11.15.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 15:04:36 -0800 (PST)
Message-ID: <8d5a2647-a130-4d99-a3e1-3abd1d336bbb@gmail.com>
Date: Sun, 12 Jan 2025 01:04:34 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] iio: accel: mc3230: add mc3510c support
To: nekodevelopper@gmail.com, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
 <20250111-mainlining-mc3510c-v1-3-57be503addf8@gmail.com>
Content-Language: en-US
From: Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <20250111-mainlining-mc3510c-v1-3-57be503addf8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/25 10:11 PM, Vasiliy Doylov via B4 Relay wrote:
> From: Vasiliy Doylov <nekodevelopper@gmail.com>
>
> This commit integrates support for the mc3510c into the mc3230 driver.
>
> Tested on Huawei MediaPad T3 10 (huawei-agassi)
>
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> ---
>   drivers/iio/accel/mc3230.c | 55 ++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 44 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index 3cad6f2d7a2a79df38f90e5656763f6ed019a920..ebbb96c658d87a83007c7c3c7212ce9ebf039963 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -22,20 +22,41 @@
>   #define MC3230_MODE_OPCON_STANDBY	0x03
>   
>   #define MC3230_REG_CHIP_ID		0x18
> -#define MC3230_CHIP_ID			0x01
> -
>   #define MC3230_REG_PRODUCT_CODE		0x3b
> -#define MC3230_PRODUCT_CODE		0x19
>   
>   /*
>    * The accelerometer has one measurement range:
>    *
>    * -1.5g - +1.5g (8-bit, signed)
>    *
> - * scale = (1.5 + 1.5) * 9.81 / (2^8 - 1)	= 0.115411765
>    */
>   
> -static const int mc3230_nscale = 115411765;
> +enum mc3xxx_chips {
> +	MC3230,
> +	MC3510C,
> +};
> +
> +struct mc3xxx_chip_info {
> +	const char *name;
> +	const u8 chip_id;
> +	const u8 product_code;
> +	const int scale;
> +};
The struct members are usually ordered alphabetically. Also, const 
specifiers for u8s and int are redundant, you will only want it for the 
pointer, usually.
> +
> +static struct mc3xxx_chip_info mc3xxx_chip_info_tbl[] = {
> +	[MC3230] = {
> +		.name = "mc3230",
> +		.chip_id = 0x01,
> +		.product_code = 0x19,
> +		.scale = 115411765, // (1.5 + 1.5) * 9.81 / (2^8 - 1) = 0.115411765
/* */ style comments are preferred. Also, it should be above the .scale 
to not make the line so long (even if the line length requirement is met).
> +	},
> +	[MC3510C] = {
> +		.name = "mc3510c",
> +		.chip_id = 0x23,
> +		.product_code = 0x10,
> +		.scale = 625000000, // Was obtained empirically
Same here.
> +	},
> +};
>   
>   #define MC3230_CHANNEL(reg, axis) {	\
>   	.type = IIO_ACCEL,	\
> @@ -50,6 +71,7 @@ static const int mc3230_nscale = 115411765;
>   struct mc3230_data {
>   	struct i2c_client *client;
>   	struct iio_mount_matrix orientation;
> +	const struct mc3xxx_chip_info *chip_info;
Same here, order alphabetically.
>   };
>   
>   static const struct iio_mount_matrix *
> @@ -111,7 +133,7 @@ static int mc3230_read_raw(struct iio_dev *indio_dev,
>   		return IIO_VAL_INT;
>   	case IIO_CHAN_INFO_SCALE:
>   		*val = 0;
> -		*val2 = mc3230_nscale;
> +		*val2 = data->chip_info->scale;
>   		return IIO_VAL_INT_PLUS_NANO;
>   	default:
>   		return -EINVAL;
> @@ -127,15 +149,23 @@ static int mc3230_probe(struct i2c_client *client)
>   	int ret;
>   	struct iio_dev *indio_dev;
>   	struct mc3230_data *data;
> +	const struct mc3xxx_chip_info *chip_info;
>   
> +	chip_info = i2c_get_match_data(client);
>   	/* First check chip-id and product-id */
>   	ret = i2c_smbus_read_byte_data(client, MC3230_REG_CHIP_ID);
> -	if (ret != MC3230_CHIP_ID)
> +	if (ret != chip_info->chip_id) {
> +		dev_err(&client->dev,
> +		"chip id check fail: 0x%x != 0x%x !\n", ret, chip_info->chip_id);
>   		return (ret < 0) ? ret : -ENODEV;
> +	}
>   
>   	ret = i2c_smbus_read_byte_data(client, MC3230_REG_PRODUCT_CODE);
> -	if (ret != MC3230_PRODUCT_CODE)
> +	if (ret != chip_info->product_code) {
> +		dev_err(&client->dev,
> +		"product code check fail: 0x%x != 0x%x !\n", ret, chip_info->product_code);
>   		return (ret < 0) ? ret : -ENODEV;
> +	}
>   
>   	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>   	if (!indio_dev) {
> @@ -145,10 +175,11 @@ static int mc3230_probe(struct i2c_client *client)
>   
>   	data = iio_priv(indio_dev);
>   	data->client = client;
> +	data->chip_info = chip_info;
>   	i2c_set_clientdata(client, indio_dev);
>   
>   	indio_dev->info = &mc3230_info;
> -	indio_dev->name = "mc3230";
> +	indio_dev->name = chip_info->name;
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>   	indio_dev->channels = mc3230_channels;
>   	indio_dev->num_channels = ARRAY_SIZE(mc3230_channels);
> @@ -200,13 +231,15 @@ static int mc3230_resume(struct device *dev)
>   static DEFINE_SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
>   
>   static const struct i2c_device_id mc3230_i2c_id[] = {
> -	{ "mc3230" },
> +	{ "mc3230", (kernel_ulong_t)&mc3xxx_chip_info_tbl[MC3230] },
> +	{ "mc3510c", (kernel_ulong_t)&mc3xxx_chip_info_tbl[MC3510C] },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
>   
>   static const struct of_device_id mc3230_of_match[] = {
> -	{ .compatible = "mcube,mc3230" },
> +	{ .compatible = "mcube,mc3230", &mc3xxx_chip_info_tbl[MC3230] },
> +	{ .compatible = "mcube,mc3510c", &mc3xxx_chip_info_tbl[MC3510C] },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, mc3230_of_match);

