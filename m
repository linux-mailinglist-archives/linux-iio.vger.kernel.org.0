Return-Path: <linux-iio+bounces-28059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EBBD3C671
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 11:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C1925E125C
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 10:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAEE3AE6F1;
	Tue, 20 Jan 2026 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCmQH6ne"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC4D3ACA51;
	Tue, 20 Jan 2026 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905777; cv=none; b=EsPT0nm2+T/r7+chNPAPtGKMcfcfBzao9QEwhKX7kegKg7tDyVl0zdsGNXoJxSColFAUNk8ly0W4/aB2amw6iMyAIbcufhnmwXb3H4hbqr5smctTZz+HDe+VVrYsAWv6EbAp1DqCALx1VXOy5tb9Sz4vr8Bw3oFTAybJ6o5fUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905777; c=relaxed/simple;
	bh=L4Zz8MfRO4xR99kWlTDK1rKid5GAtmhoIjm2t5neR34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skmttQQ+0vtAKQTDiGG09mQVnFJRH+RrQArV6yqGgn6KzPJuvii+NFrkonoV7TX9T+N7LKpM+IEwHY01l8gQW0XH8b5j+6OQKVlCBVuMMxvItU7gDHMHxSJUrGT9bjMEMPyzrrIoZbJF76Eq1A19kEvaTXrcL7uWLV4QHDf1iN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCmQH6ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A63C16AAE;
	Tue, 20 Jan 2026 10:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768905776;
	bh=L4Zz8MfRO4xR99kWlTDK1rKid5GAtmhoIjm2t5neR34=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RCmQH6neAkWWPZZy/G2BSXA4sdJQTt+24np9qplupk+67vrnqpHxsJF/ZW8buL7uu
	 35dbRYhIKf10ESengT8cyoIeDC324EaIL+40s9QlIU0wyYNE6hDBucMmKi/npeTLC8
	 qqoWQ9LdgUB8LNpwQdNChHA35qguUFznvAvz8MFyz6xL25PMPBsaNLPVoLTXtq/JwT
	 Tv5EeoLU0qo0QeitqyWdC5MoN7h7wn24uRDOyo4bKEqa8K+eCRH1g9zKsPidfdTnsb
	 RMLp1SWGe0YFevLPChsS64fj0yDwXyXdas0lIJhRLSosil3oXC0VFNRc9V+Qx1eyFs
	 LF8sofyxGvefg==
Message-ID: <2495ad98-79ca-486f-ab80-03344a55d2f2@kernel.org>
Date: Tue, 20 Jan 2026 11:42:51 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iio: proximity: vl53l0x-i2c: Use raw I2C access and
 read full device ID
To: petr.hodina@protonmail.com, Song Qiang <songqiang1304521@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260119-vl53l0x-v1-0-cf71715a1353@protonmail.com>
 <20260119-vl53l0x-v1-4-cf71715a1353@protonmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260119-vl53l0x-v1-4-cf71715a1353@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2026 18:19, Petr Hodina via B4 Relay wrote:
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 6901ce7dd835..a2de4cc16a43 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -320,11 +320,35 @@ static const struct iio_trigger_ops vl53l0x_trigger_ops = {
>  	.validate_device = iio_trigger_validate_own_device,
>  };
>  
> +

Do not introduce stray blank lines.

> +static int vl53l0x_read_word(struct i2c_client *client, u8 reg, u16 *val)
> +{
> +	int ret;
> +	u8 buf[2];
> +
> +	ret = i2c_master_send(client, &reg, 1);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 1)
> +		return -EIO;
> +
> +	ret = i2c_master_recv(client, buf, 2);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 2)
> +		return -EIO;
> +
> +	*val = (buf[0] << 8) | buf[1];
> +
> +	return 0;
> +}
> +
>  static int vl53l0x_probe(struct i2c_client *client)
>  {
>  	struct vl53l0x_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> +	u16 model, rev;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -339,13 +363,6 @@ static int vl53l0x_probe(struct i2c_client *client)
>  				     I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -EOPNOTSUPP;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, VL_REG_IDENTIFICATION_MODEL_ID);
> -	if (ret < 0)
> -		return -EINVAL;
> -
> -	if (ret != VL53L0X_MODEL_ID_VAL)
> -		dev_info(&client->dev, "Unknown model id: 0x%x", ret);
> -
>  	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
>  	if (IS_ERR(data->vdd_supply))
>  		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
> @@ -372,6 +389,20 @@ static int vl53l0x_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	ret = vl53l0x_read_word(client, 0xC0, &model);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Failed to read model ID\n");
> +
> +	ret = vl53l0x_read_word(client, 0xC2, &rev);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Failed to read revision ID\n");
> +
> +	dev_info(&client->dev, "VL53L0X model=0x%04x rev=0x%04x\n", model, rev);

dev_dbg

This does not look like useful printk message. Drivers should be silent
on success:
https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/coding-style.rst#L913
https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/debugging/driver_development_debugging_guide.rst#L79

Best regards,
Krzysztof

