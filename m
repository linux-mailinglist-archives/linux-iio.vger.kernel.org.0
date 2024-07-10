Return-Path: <linux-iio+bounces-7482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ED192CEEC
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2024 12:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E1E1F2525E
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2024 10:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC45818FDAE;
	Wed, 10 Jul 2024 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i26JYMet"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519BC18FA12;
	Wed, 10 Jul 2024 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606331; cv=none; b=ShYneo/PtydR7IXk3407fk+q2iV1jULZlV40BYqXlVuOqFVFA/2uRRvFn+Fs+cnHWJ2x2nQcEdIVnr01VFTsoEXYTEgbDiITbHWhlTaPn+xIBFZUKpn5aKj2fJJbHoTMX0VO/sJ73zKGOtTUIObBg8ikBwzy0ABbTRNBvBAJvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606331; c=relaxed/simple;
	bh=s7XkNZJ/tmvmUOUOkwxRuX1V+80bZRwPqlq5S+jNx0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t95e/mLIyJMP39wKv28j4msyvGNu1iYVEEWogb7JWFoTlQ48mbh0s88G2hXoYFuxKQT+2iJMk8MMa/s9nQivZrc9wGSAWfIX6jh0p4/m80vbZZ0//eZr3NhIn2dJfeiZwPEjbYnUksvPn1sPXqsB6tF6awzw6wuu0xsUtqFRNt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i26JYMet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BA5C32781;
	Wed, 10 Jul 2024 10:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720606329;
	bh=s7XkNZJ/tmvmUOUOkwxRuX1V+80bZRwPqlq5S+jNx0I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i26JYMetfFZ5QN4o7NY1cg/b0O21ZjQnvo9785yPyj53aTuaWeylNI3peXlGCdTIA
	 p/WLdagSqNkkgz/fFQP7N1zwZq9+nI4R6zuzBsz0LDZgYL7ngrk3exZClL86ass1sR
	 7x0Cg8dZukIlKgzjlu6fCaNoYSoV/Ljljgb7ZBessk9FZwtAPbiEEihf4eU6lEd8AA
	 C71Gg9P6APcVazdWIPw3uFESzUvLNQbafuHIymlWJKOJbr3/31OrKloYDdkMWifYeA
	 f13rYj+8fR4vGqlk69X64ms8U4RRw1NlsULUAWtA0mUJeRRoSewLAvnwD1Pd1lUDZ7
	 cWZdchxHO55aQ==
Message-ID: <3828472d-b0ec-4629-a844-d2fb81bc31a8@kernel.org>
Date: Wed, 10 Jul 2024 12:12:06 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: humidity: Add support for ENS21x
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240709-ens21x-v1-0-678521433cdd@thegoodpenguin.co.uk>
 <20240709-ens21x-v1-2-678521433cdd@thegoodpenguin.co.uk>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240709-ens21x-v1-2-678521433cdd@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2024 18:36, Joshua Felmeden wrote:
> Add support for ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215.
> 
> The ENS21x is a family of temperature and relative humidity sensors with
> accuracies tailored to the needs of specific applications.
> 
> Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
> ---
>  drivers/iio/humidity/Kconfig  |  11 ++
>  drivers/iio/humidity/Makefile |   1 +
>  drivers/iio/humidity/ens21x.c | 348 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 360 insertions(+)
> 


> +
> +static int ens21x_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	const struct of_device_id *match;
> +	struct ens21x_dev *dev_data;
> +	struct iio_dev *indio_dev;
> +	uint16_t part_id_le, part_id;
> +	int ret, tries;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +			I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +			I2C_FUNC_SMBUS_WRITE_BYTE |
> +			I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +		dev_err(&client->dev,
> +			"adapter does not support some i2c transactions\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	match = of_match_device(ens21x_of_match, &client->dev);
> +	if (!match) {
> +		dev_err(&client->dev, "failed to get match data\n");

That's odd. This should never happen, so printing error suggests
something is odd in your driver.

There is anyway helper for getting match data from i2c/of cases.


> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	dev_data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	dev_data->client = client;
> +	mutex_init(&dev_data->lock);
> +
> +	/* reset device */
> +	ret = i2c_smbus_write_byte_data(client, ENS21X_REG_SYS_CTRL,
> +					ENS21X_SYS_CTRL_SYS_RESET);
> +	if (ret)
> +		return ret;
> +
> +	/* wait for device to become active */
> +	usleep_range(4000, 5000);
> +
> +	/* disable low power mode */
> +	ret = i2c_smbus_write_byte_data(client, ENS21X_REG_SYS_CTRL, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	/* wait for device to become active */
> +	tries = 10;
> +	while (tries-- > 0) {
> +		msleep(20);
> +		ret = i2c_smbus_read_byte_data(client, ENS21X_REG_SYS_STAT);
> +		if (ret < 0)
> +			return ret;
> +		if (ret & ENS21X_SYS_STAT_SYS_ACTIVE)
> +			break;
> +	}
> +	if (tries < 0) {
> +		dev_err(&client->dev,
> +			"timeout waiting for ens21x to become active\n");
> +		return -EIO;
> +	}
> +
> +	/* get part_id */
> +	part_id_le = i2c_smbus_read_word_data(client, ENS21X_REG_PART_ID);
> +	if (part_id_le < 0)
> +		return part_id_le;
> +	part_id = le16_to_cpu(part_id_le);
> +
> +	if (part_id != id->driver_data) {
> +		dev_err(&client->dev,
> +			"Part ID does not match (0x%04x != 0x%04lx)\n", part_id,
> +			id->driver_data);
> +		return -ENODEV;
> +	}
> +
> +	/* reenable low power */
> +	ret = i2c_smbus_write_byte_data(client, ENS21X_REG_SYS_CTRL,
> +					ENS21X_SYS_CTRL_LOW_POWER_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	dev_data->part_id = part_id;
> +
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ens21x_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ens21x_channels);
> +	indio_dev->info = &ens21x_info;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +
> +static const struct of_device_id ens21x_of_match[] = {
> +	{ .compatible = "sciosense,ens210" },
> +	{ .compatible = "sciosense,ens210a" },
> +	{ .compatible = "sciosense,ens211" },
> +	{ .compatible = "sciosense,ens212" },
> +	{ .compatible = "sciosense,ens213a" },
> +	{ .compatible = "sciosense,ens215" },

Mismathed with i2c_device_id. These should have the same data. Also,
keep the tables next to each other (here).



Best regards,
Krzysztof


