Return-Path: <linux-iio+bounces-9308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385F7970364
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 19:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E853B227F3
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9F51537D8;
	Sat,  7 Sep 2024 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvO6igFx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47459487B0;
	Sat,  7 Sep 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725730550; cv=none; b=ZsUaBCqWhk3UhIVD/UDRIEcBFHOL2dafipCw6mumaV6n2hLP2ipSPhFAeZIpNoXPYjyVNuD0tqCBCIGJBOcFc4qdzPS325WfsbGNCLrEMWzXXoub93XLZjR3TimwJyyOT4okQK17Ym9NKpf9VqXgXkd78t2HNeDqtaWtMbRFINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725730550; c=relaxed/simple;
	bh=kYRfiavOxNrAyi8Czh7NZlZ90eWICY+cSgo36pvPQw8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6BI6cHRRhOLdtqiZleIjL47ue32yZCUCkm+ZZftHcVFXn54HKDHzYgnvIt9Z3NHAWJQfMfe1OnE7iCHxU9kCl77hyOOYhE0irigc7NEO66eIdmbbi9HXwLWvfZ7BWbOxpYQP3OCdV6VoIxYd7pNH+l5fq3ahTD50ApJLUvO4Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvO6igFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2358C4CEC2;
	Sat,  7 Sep 2024 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725730549;
	bh=kYRfiavOxNrAyi8Czh7NZlZ90eWICY+cSgo36pvPQw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BvO6igFxf75rWMUOXP2JzjowUvIgZvv36hnrXHw7bg8Zt+oZggYRyBn4hvkmNT5ZO
	 VBejTHtx/VGuDwzuyem9XTnMURS6RJkt8r0xlG+UR8IxEh2/TLoo54I9tt+8RMCJq5
	 ywivMeGm0GD3h8PWkrLOech2wVRYcVpyLaVwQIzP/pZH0OJEv7JeAoTMiZxt2cjCyE
	 g3505gYeNPRP4ZI2vhMLXS7BgX7b8RTU+lgmVfErWe9FMhNhnFARZYzm+oL/5Kc6nX
	 uTNNbIy56OhY2xwlwzX8zJtnfokg2aE1HcRyKHrJ6uypjVlmbSs1QpWhDd82I4Cwe9
	 gimsC7g/85q3A==
Date: Sat, 7 Sep 2024 18:35:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Emil Gedenryd <emil.gedenryd@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH 2/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Message-ID: <20240907183518.1e8ee0bf@jic23-huawei>
In-Reply-To: <20240905-add_opt3002-v1-2-a5ae21b924fb@axis.com>
References: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
	<20240905-add_opt3002-v1-2-a5ae21b924fb@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 12:20:46 +0200
Emil Gedenryd <emil.gedenryd@axis.com> wrote:

> TI's opt3002 light sensor shares most properties with the opt3001
> model, with the exception of supporting a wider spectrum range.
> 
> Add support for TI's opt3002 by extending the TI opt3001 driver.
> 
> See https://www.ti.com/product/OPT3002 for more information.
Make that a Datasheet tag.
> 
Datasheet: https://www.ti.com/product/OPT3002
> Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>

Various comments inline.
Thanks,

Jonathan

> ---
>  drivers/iio/light/Kconfig   |   2 +-
>  drivers/iio/light/opt3001.c | 199 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 167 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index b68dcc1fbaca..c35bf962dae6 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -461,7 +461,7 @@ config OPT3001
>  	depends on I2C
>  	help
>  	  If you say Y or M here, you get support for Texas Instruments
> -	  OPT3001 Ambient Light Sensor.
> +	  OPT3001 Ambient Light Sensor, OPT3002 Light-to-Digital Sensor.
>  
>  	  If built as a dynamically linked module, it will be called
>  	  opt3001.
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 176e54bb48c3..e6098f88dd04 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -70,6 +70,19 @@
>  #define OPT3001_RESULT_READY_SHORT	150
>  #define OPT3001_RESULT_READY_LONG	1000
>  
> +/* The opt3002 doesn't have a device id register, predefine value instead */
> +#define OPT3002_DEVICE_ID_VALUE		3002

Why?  Just make the code not care about the value for this
device.  Add a flag to the chip info structure to say it doesn't have
one and check that before using it.


> +
> +enum chip_model {
> +	OPT3001,
This should not be needed. See below.

> +	OPT3002,
> +};
> +
> +struct opt300x_chip_info {
> +	enum chip_model model;
> +	enum iio_chan_type chan_type;
> +};
> +
>  struct opt3001 {
>  	struct i2c_client	*client;
>  	struct device		*dev;
> @@ -79,6 +92,7 @@ struct opt3001 {
>  	bool			result_ready;
>  	wait_queue_head_t	result_ready_queue;
>  	u16			result;
> +	const struct opt300x_chip_info *chip_info;
>  
>  	u32			int_time;
>  	u32			mode;
> @@ -97,6 +111,16 @@ struct opt3001_scale {
>  	int	val2;
>  };
>  
> +static const struct opt300x_chip_info opt3001_chip_info = {
> +	.model = OPT3001,
Having a model in a chip_info structure is almost always a sign
of a design that won't scale well to lots of additional devices.

Get rid of that and instead add all the 'data' that you are looking
up with that model number to this structure so it can be just
referenced without caring which mode it is for.

> +	.chan_type = IIO_LIGHT,
> +};
> +
> +static const struct opt300x_chip_info opt3002_chip_info = {
> +	.model = OPT3002,
> +	.chan_type = IIO_INTENSITY,
> +};

> +
>  static int opt3001_find_scale(const struct opt3001 *opt, int val,
>  		int val2, u8 *exponent)
>  {
>  	int i;
> +	const struct opt3001_scale (*scale_arr)[12];
>  
> -	for (i = 0; i < ARRAY_SIZE(opt3001_scales); i++) {
> -		const struct opt3001_scale *scale = &opt3001_scales[i];
> +	switch (opt->chip_info->model) {
> +	case OPT3001:
> +		scale_arr = &opt3001_scales;
Put them in chip_info directly, not look them up here.

> +		break;
> +	case OPT3002:
> +		scale_arr = &opt3002_scales;
> +		break;
> +	default:
> +		dev_err(opt->dev, "scale not configured for chip model\n");
> +		return -EINVAL;
> +	}
>  
> +	for (i = 0; i < ARRAY_SIZE(*scale_arr); i++) {
> +		const struct opt3001_scale *scale = &(*scale_arr)[i];
>  		/*
> -		 * Combine the integer and micro parts for comparison
> -		 * purposes. Use milli lux precision to avoid 32-bit integer
> -		 * overflows.
> +		 * Compare the integer and micro parts to determine value scale.
>  		 */
> -		if ((val * 1000 + val2 / 1000) <=
> -				(scale->val * 1000 + scale->val2 / 1000)) {
> +		if (val < scale->val ||
> +		    (val == scale->val && val2 <= scale->val2)) {
>  			*exponent = i;
>  			return 0;
>  		}
> @@ -174,11 +259,20 @@ static int opt3001_find_scale(const struct opt3001 *opt, int val,
>  static void opt3001_to_iio_ret(struct opt3001 *opt, u8 exponent,
>  		u16 mantissa, int *val, int *val2)
>  {
> -	int lux;
> +	int ret;
>  
> -	lux = 10 * (mantissa << exponent);
> -	*val = lux / 1000;
> -	*val2 = (lux - (*val * 1000)) * 1000;
> +	switch (opt->chip_info->model) {
> +	case OPT3001:
> +		ret = 10 * (mantissa << exponent);
> +		*val = ret / 1000;
> +		*val2 = (ret - (*val * 1000)) * 1000;
> +		break;
> +	case OPT3002:
> +		ret = 12 * (mantissa << exponent);
> +		*val = ret / 10;
> +		*val2 = (ret - (*val * 10)) * 100000;

As below - constants in the chip_info structure so this becomes
a simple case of using them without needing to know the chip type
in the code.

> +		break;
> +	}
>  }

> @@ -497,7 +602,15 @@ static int opt3001_write_event_value(struct iio_dev *iio,
>  		goto err;
>  	}
>  
> -	mantissa = (((val * 1000) + (val2 / 1000)) / 10) >> exponent;
> +	switch (opt->chip_info->model) {
> +	case OPT3001:
> +		mantissa = (((val * 1000) + (val2 / 1000)) / 10) >> exponent;

Encode the sections of this maths that is different as values in the chip
info structure and use them directly here rather than having a switch statement.

> +		break;
> +	case OPT3002:
> +		mantissa = (((val * 10) + (val2 / 100000)) / 12) >> exponent;
> +		break;
> +	}
> +
>  	value = (exponent << 12) | mantissa;
>  
>  	switch (dir) {
> @@ -607,15 +720,22 @@ static int opt3001_read_id(struct opt3001 *opt)
>  	manufacturer[0] = ret >> 8;
>  	manufacturer[1] = ret & 0xff;
>  
> -	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_DEVICE_ID);
> -	if (ret < 0) {
> -		dev_err(opt->dev, "failed to read register %02x\n",
> +	switch (opt->chip_info->model) {

Add a callback for this to the chip_info structure. That will make it
much cleaner to add future devices.

> +	case OPT3001:
> +		ret = i2c_smbus_read_word_swapped(opt->client,
> +						  OPT3001_DEVICE_ID);
> +		if (ret == 0) {
> +			dev_err(opt->dev, "failed to read register %02x\n",
>  				OPT3001_DEVICE_ID);
> -		return ret;
> +			return ret;
> +		}
> +		device_id = ret;
> +		break;
> +	case OPT3002:
> +		device_id = OPT3002_DEVICE_ID_VALUE;
> +		break;

> @@ -755,6 +877,7 @@ static int opt3001_probe(struct i2c_client *client)
>  	opt = iio_priv(iio);
>  	opt->client = client;
>  	opt->dev = dev;
> +	opt->chip_info = device_get_match_data(&client->dev);
>  
>  	mutex_init(&opt->lock);
>  	init_waitqueue_head(&opt->result_ready_queue);
> @@ -769,10 +892,18 @@ static int opt3001_probe(struct i2c_client *client)
>  		return ret;
>  
>  	iio->name = client->name;
> -	iio->channels = opt3001_channels;
> -	iio->num_channels = ARRAY_SIZE(opt3001_channels);
>  	iio->modes = INDIO_DIRECT_MODE;
>  	iio->info = &opt3001_info;
> +	switch (opt->chip_info->model) {
> +	case OPT3001:
> +		iio->channels = opt3001_channels;
> +		iio->num_channels = ARRAY_SIZE(opt3001_channels);
Add this to the chip info structure so this can become a simple assignment
rather than having to look up by model.

> +		break;
> +	case OPT3002:
> +		iio->channels = opt3002_channels;
> +		iio->num_channels = ARRAY_SIZE(opt3002_channels);
> +		break;
> +	}
>  
>  	ret = devm_iio_device_register(dev, iio);
>  	if (ret) {
> @@ -826,13 +957,15 @@ static void opt3001_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id opt3001_id[] = {
> -	{ "opt3001" },
> +	{ "opt3001", 0 },
> +	{ "opt3002", 1 },
>  	{ } /* Terminating Entry */
>  };
>  MODULE_DEVICE_TABLE(i2c, opt3001_id);
>  
>  static const struct of_device_id opt3001_of_match[] = {
> -	{ .compatible = "ti,opt3001" },
> +	{ .compatible = "ti,opt3001", .data = &opt3001_chip_info },
> +	{ .compatible = "ti,opt3002", .data = &opt3002_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, opt3001_of_match);
> 


