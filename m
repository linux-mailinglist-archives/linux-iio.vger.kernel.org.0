Return-Path: <linux-iio+bounces-9817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359A8988FBD
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E78CBB215A3
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDA01CD29;
	Sat, 28 Sep 2024 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgtbSKJS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1618E11;
	Sat, 28 Sep 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727534458; cv=none; b=tdJHhCTuUbFHpW935Z/pAmvvFL4grrgt+Tg2di7de1uzgdak+b/vQ2XuJLGFKYwvNC60MPIhmNXVDzEm4XHxW9GDFWd2TToXNrti9sfCz4MeRt4DV8/3bmApg24LuGRMxuWmIn2PxOfIVPVWqIqDQbeN2qKvQ1H16FNoCBIlFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727534458; c=relaxed/simple;
	bh=u4BcB6prh4ZdngGMroobBycpJplVZ5SyhbiDR3TeX5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYWB4cqFs/VAdBAkSwnSB4Ya9mgCh3rGRlGnxqnOfyawzLUD02YZxHKnSKQfWejLN8R01n0BZ1wpAq4zvXClvLwVkoLA1Fndm7TJwQTKF3Y2VYBSDq72RhD1/E6x0iHi3cj2p4YgjWax9TrXshuPC1PZTukukwYFDczzvaUZ6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgtbSKJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CC6C4CEC3;
	Sat, 28 Sep 2024 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727534457;
	bh=u4BcB6prh4ZdngGMroobBycpJplVZ5SyhbiDR3TeX5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OgtbSKJSWB2ePaN1OwFe/VqXeWs100B8wSxFwhz6ltumORYCr6pVVzGZTAXMwdELX
	 6mKS7w0iV+UYxM7JMEd1pc6tAJs7C2670noSYSPBn3FTUfjFpP5CXBbqPFlSn2gG8j
	 EFMa6jj5jRo09H6bhgwmUfLbjA8cUwsscLpC+jMwLNPfa1mRyD6b+5eNvMkm82WnUN
	 RPsUB3ZVCm4HluIWgOB3I/Qe2qyoXj8Pc5ufVeUI2aoH+k/P98kHwo2pUORJQSrW2U
	 xvaDLcUyA1G8pJYHa29ca5JUpw0qGRtRlZc5tAMR0Y8g7IieJObYk0vVGy0jSnX+Z/
	 Vn7IFkBplxhew==
Date: Sat, 28 Sep 2024 15:40:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 7/7] iio: light: veml6030: add support for veml6035
Message-ID: <20240928154049.6641a645@jic23-huawei>
In-Reply-To: <e3414f78-417c-4983-a91d-0c58e1639de8@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
	<20240913-veml6035-v1-7-0b09c0c90418@gmail.com>
	<20240914170347.54959319@jic23-huawei>
	<e3414f78-417c-4983-a91d-0c58e1639de8@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

...

> >>  
> >> +/*
> >> + * Set ALS gain to 1/8, integration time to 100 ms, ALS and WHITE
> >> + * channel enabled, ALS channel interrupt, PSM enabled,
> >> + * PSM_WAIT = 0.8 s, persistence to 1 x integration time and the
> >> + * threshold interrupt disabled by default. First shutdown the sensor,
> >> + * update registers and then power on the sensor.
> >> + */
> >> +static int veml6035_hw_init(struct iio_dev *indio_dev)
> >> +{
> >> +	int ret, val;
> >> +	struct veml6030_data *data = iio_priv(indio_dev);
> >> +	struct i2c_client *client = data->client;
> >> +
> >> +	ret = veml6030_als_shut_down(data);
> >> +	if (ret) {
> >> +		dev_err(&client->dev, "can't shutdown als %d\n", ret);
> >> +		return ret;  
> > 
> > If this is only ever called from probe() (I think that's true?)
> > can use return dev_err_probe() for all these error cases.
> > Main advantage here being shorter simpler code.
> >   
> 
> I know, I procrastinated a little bit and I left the dev_err() calls as
> they are. But that's easy to update, so I will add a patch for it in v2.
> >> +	}
> >> +
> >> +	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF,
> >> +			   VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD);
> >> +	if (ret) {
> >> +		dev_err(&client->dev, "can't setup als configs %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
> >> +				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
> >> +	if (ret) {
> >> +		dev_err(&client->dev, "can't setup default PSM %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
> >> +	if (ret) {
> >> +		dev_err(&client->dev, "can't setup high threshold %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
> >> +	if (ret) {
> >> +		dev_err(&client->dev, "can't setup low threshold %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = veml6030_als_pwr_on(data);
> >> +	if (ret) {
> >> +		dev_err(&client->dev, "can't poweron als %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	/* Clear stale interrupt status bits if any during start */
> >> +	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
> >> +	if (ret < 0) {
> >> +		dev_err(&client->dev,
> >> +			"can't clear als interrupt status %d\n", ret);
> >> +		return ret;  
> > 
> > It's true of existing code, but I noticed it here.
> > Should we be powering down in this error path?
> >   
> 
> We could, because this is the only error path where the device is
> powered on before the power off action gets registered. On the other
> hand, could we not move the call to devm_add_action_or_reset() a few
> lines up, so the action gets registered before calling hw_init()?

Move it in here so that you register the powerdown alongside the power
up. Doesn't matter that it is inside the hw_init() function so a little
less obvious.

Jonathan
> 
> Powering off the device is just writing a bit, so it would not hurt in
> the error paths where the device is already powered off. Then we would
> not need an explicit call to power off the device in this error path.
> 
> >> +	}
> >> +
> >> +	/* Cache currently active measurement parameters */
> >> +	data->cur_gain = 5;
> >> +	data->cur_resolution = 1024;
> >> +	data->cur_integration_time = 3;
> >> +
> >> +	return 0;
> >> +}  
> >   
> 
> 
> Best regards,
> Javier Carrasco


