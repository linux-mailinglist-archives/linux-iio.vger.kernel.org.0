Return-Path: <linux-iio+bounces-9837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A0B989037
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 18:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929D9281FFF
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D167E45C0B;
	Sat, 28 Sep 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyJGst2s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ED229429;
	Sat, 28 Sep 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727539530; cv=none; b=BPUBq88EreWemkOB8oFHFgERJmKltoV1QvXDbpQWWQcLSzioMV9xl3KyV1STD4nMjungCSgH6L0f5253fOG4TygmXuVjDiYFr84dNbzdJK/eYvkuhPpryhXU4qKgWp0vL0Ekw07MJaPnkmHIAhE0BFpZWlErKZfWaDcz1EU0pZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727539530; c=relaxed/simple;
	bh=/kpQ5i5Ao0vJN3d7/pzZXKZZN8p8Kj+a3qxCCDNZSnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+3i2M07KXGvlJLeynj8vi3TE14CnWM47KKFek4JEGpWU+SgDh2xyWRXFo0xvhMO/NPlCpMJvdecKwW68fgNRvXOf7Mshf7nJuENzJf/FXgCl5u9i2hryY5ZZhpoaCD4rXojat/G9v8MZvFkkHeApM/+cyVJmjOjLrxwVJgWpJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyJGst2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F5DC4CEC3;
	Sat, 28 Sep 2024 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727539530;
	bh=/kpQ5i5Ao0vJN3d7/pzZXKZZN8p8Kj+a3qxCCDNZSnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hyJGst2sThzdvSg7P1HLPcogfK12E1vG5BRfe7sko0eskeZP3PMpsnt47lNyKkbCn
	 ZeNc+N82wvrmElt4fLezFqY0zB5XHVm34hT6xlooaV22aXgcTtI5yvQClHlSmxhzEr
	 +9lGIYTBwCyN8uGx9fjMz5QELBZ8D6/UsfgwG+2c+fdSiR13/fjNGOnRURVOYSe63k
	 sb6yn23gjSdIMJWzMsHCko2bMcR22Ta9W18uiVF3q6VNAubJXn25DtkdIMsNNzQ4Fz
	 p5MRWzs+VIhifp5a8Py1uxNHtXRqO3rqQuYKLWQ1P/tLSz4TFKoRNLFqY9gCNTI9px
	 tieRYY4FUb4MQ==
Date: Sat, 28 Sep 2024 17:05:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Emil Gedenryd <emil.gedenryd@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v3 3/3] iio: light: opt3001: add support for TI's
 opt3002 light sensor
Message-ID: <20240928170520.02a27690@jic23-huawei>
In-Reply-To: <20240916-add_opt3002-v3-3-984b190cd68c@axis.com>
References: <20240916-add_opt3002-v3-0-984b190cd68c@axis.com>
	<20240916-add_opt3002-v3-3-984b190cd68c@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 16:56:39 +0200
Emil Gedenryd <emil.gedenryd@axis.com> wrote:

> TI's opt3002 light sensor shares most properties with the opt3001
> model, with the exception of supporting a wider spectrum range.
> 
> Add support for TI's opt3002 by extending the TI opt3001 driver.
> 
> Datasheet: https://www.ti.com/product/OPT3002
> Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
Hi Emil,

A few things inline,

Thanks,

Jonathan

> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 176e54bb48c3..5e3fe42c5b59 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c


> @@ -479,6 +565,9 @@ static int opt3001_write_event_value(struct iio_dev *iio,
>  {
>  	struct opt3001 *opt = iio_priv(iio);
>  	int ret;
> +	int whole;
> +	int integer;
> +	int decimal;
>  
>  	u16 mantissa;
>  	u16 value;
> @@ -497,7 +586,12 @@ static int opt3001_write_event_value(struct iio_dev *iio,
>  		goto err;
>  	}
>  
> -	mantissa = (((val * 1000) + (val2 / 1000)) / 10) >> exponent;
> +	whole = opt->chip_info->factor_whole;
> +	integer = opt->chip_info->factor_integer;
> +	decimal = opt->chip_info->factor_decimal;
> +
> +	mantissa = (((val * integer) + (val2 / decimal)) / whole) >> exponent;
> +
>  	value = (exponent << 12) | mantissa;
>  
>  	switch (dir) {
> @@ -610,7 +704,7 @@ static int opt3001_read_id(struct opt3001 *opt)
>  	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_DEVICE_ID);
>  	if (ret < 0) {
>  		dev_err(opt->dev, "failed to read register %02x\n",
> -				OPT3001_DEVICE_ID);
> +			OPT3001_DEVICE_ID);

Unrelated change so in theory should be in a separate patch but
meh, it's trivial so leave it here if you like.

>  		return ret;
>  	}

> @@ -755,22 +850,25 @@ static int opt3001_probe(struct i2c_client *client)
>  	opt = iio_priv(iio);
>  	opt->client = client;
>  	opt->dev = dev;
> +	opt->chip_info = device_get_match_data(&client->dev);

Use the i2c specific way to to do this.
https://elixir.bootlin.com/linux/v6.11/source/drivers/i2c/i2c-core-base.c#L120
i2c_get_match_data() because it will also handle falling back to matching
via the i2c_match_id() path against the old style match tables in a few
cases.

>  
>  	mutex_init(&opt->lock);
>  	init_waitqueue_head(&opt->result_ready_queue);
>  	i2c_set_clientdata(client, iio);
>  
> -	ret = opt3001_read_id(opt);
> -	if (ret)
> -		return ret;
> +	if (opt->chip_info->has_id) {
> +		ret = opt3001_read_id(opt);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	ret = opt3001_configure(opt);
>  	if (ret)
>  		return ret;
>  
>  	iio->name = client->name;
> -	iio->channels = opt3001_channels;
> -	iio->num_channels = ARRAY_SIZE(opt3001_channels);
> +	iio->channels = *opt->chip_info->channels;
> +	iio->num_channels = ARRAY_SIZE(*opt->chip_info->channels);
This won't work as it has no way to perform a sizeof
through a pointer.

Add a num_channels filed to your opt3001_chip_info structure
as then it can be ARRAY_SIZE(&opt3001_channels) which can work.

>  	iio->modes = INDIO_DIRECT_MODE;
>  	iio->info = &opt3001_info;
>  
> @@ -825,14 +923,36 @@ static void opt3001_remove(struct i2c_client *client)
>  	}
>  }
>  
> +static const struct opt3001_chip_info opt3001_chip_information = {
> +	.channels = &opt3001_channels,
> +	.chan_type = IIO_LIGHT,
> +	.scales = &opt3001_scales,
> +	.factor_whole = 10,
> +	.factor_integer = 1000,
> +	.factor_decimal = 1000,
> +	.has_id = true,
> +};
> +
> +static const struct opt3001_chip_info opt3002_chip_information = {
> +	.channels = &opt3002_channels,
> +	.chan_type = IIO_INTENSITY,
> +	.scales = &opt3002_scales,
> +	.factor_whole = 12,
> +	.factor_integer = 10,
> +	.factor_decimal = 100000,
> +	.has_id = false,
> +};
> +
>  static const struct i2c_device_id opt3001_id[] = {
> -	{ "opt3001" },
> +	{ "opt3001", (kernel_ulong_t)&opt3001_chip_information },
> +	{ "opt3002", (kernel_ulong_t)&opt3002_chip_information },
>  	{ } /* Terminating Entry */
>  };
>  MODULE_DEVICE_TABLE(i2c, opt3001_id);
>  
>  static const struct of_device_id opt3001_of_match[] = {
> -	{ .compatible = "ti,opt3001" },
> +	{ .compatible = "ti,opt3001", .data = &opt3001_chip_information },
> +	{ .compatible = "ti,opt3002", .data = &opt3002_chip_information },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, opt3001_of_match);
> 


