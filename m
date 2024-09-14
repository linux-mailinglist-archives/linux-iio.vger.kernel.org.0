Return-Path: <linux-iio+bounces-9577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0348979212
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B62B2173D
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC481D049C;
	Sat, 14 Sep 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6zKBlGJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190624414;
	Sat, 14 Sep 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726330765; cv=none; b=tr0hPxQIzxZ4VFshTGyapdzHHhHOofPOKz+tJ7qaidq2RZgepOVXXWFvQFgX/2+6qLBpcpdtQ55wx9XIxqDyTeHtm2lUz+oHmLzL1j411KLNaaRiJ0bIZ8N0e3Z7ZnnBySfEFBMVTN/pgHSOzlxv8Ycx5tR3jvjAggHFTUWf0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726330765; c=relaxed/simple;
	bh=BXETtzy7/0e7XK2eL29srUTJ7lT0Zq7pNyXtXZCdKzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSs+MSRtLQIIXHDOxILVGBXYlCOaCQ9i9grX2Jr99LvTVbKn5YnXijURqi0SG6UFNFImHDonRrrAqsqxKayvwHtylSvlk8/5z3TDq/tv0X/f1VA5wzHk8/uZDKt60Ea23BVodRMOS7Jf1bH+o1+HzzZkP2Jd8oc2ymOYWq9iP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6zKBlGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B697C4CEC0;
	Sat, 14 Sep 2024 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726330764;
	bh=BXETtzy7/0e7XK2eL29srUTJ7lT0Zq7pNyXtXZCdKzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k6zKBlGJTuhbYgpii/jaiUgPXCGdJpNeHDdc3RQ/5L0DrRlVRY1sttKE2Y1IPLu4+
	 uIb/uXbJTQF2paUDbdXiziWbOd4IaxkghTgMRnOHloc2qAw34kXM2AFi+P2trfKz7d
	 SSwUKiNdklQfla8L5np9rhKdvZoGAS58sTvvHmtIQhUE4/iH4XQe65MQTG113FfPAU
	 EH2ciDwzpCqvkBNrmK7esPhQ6/ndbbBrGcLI4yX5SLy4mFhnVWAGZ0NAQAG4XGRGIr
	 vPVMJPjIevMpwWvRNIbNY2A5NSkfR0qKBH9pLPtJ/kWNkNSmLaGOANPKZ6l/5dpYtI
	 MjUNn2ZbraGBQ==
Date: Sat, 14 Sep 2024 17:19:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Emil Gedenryd <emil.gedenryd@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v2 3/3] iio: light: opt3001: add support for TI's
 opt3002 light sensor
Message-ID: <20240914171918.4b29e847@jic23-huawei>
In-Reply-To: <20240913-add_opt3002-v2-3-69e04f840360@axis.com>
References: <20240913-add_opt3002-v2-0-69e04f840360@axis.com>
	<20240913-add_opt3002-v2-3-69e04f840360@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 11:57:04 +0200
Emil Gedenryd <emil.gedenryd@axis.com> wrote:

> TI's opt3002 light sensor shares most properties with the opt3001
> model, with the exception of supporting a wider spectrum range.
> 
> Add support for TI's opt3002 by extending the TI opt3001 driver.
> 
> Datasheet: https://www.ti.com/product/OPT3002
> 
No blank line here. Datasheet: should be part of this tags block.
> Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
> ---
>  drivers/iio/light/Kconfig   |   2 +-
>  drivers/iio/light/opt3001.c | 169 +++++++++++++++++++++++++++++++++++---------
>  2 files changed, 138 insertions(+), 33 deletions(-)
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
> index 176e54bb48c3..83c49f4517b7 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -70,6 +70,21 @@
>  #define OPT3001_RESULT_READY_SHORT	150
>  #define OPT3001_RESULT_READY_LONG	1000
>  
> +struct opt3001_scale {
> +	int	val;
> +	int	val2;
> +};
> +
> +struct opt300x_chip_info {

Don't use wild cards.  Just call it opt3001_chip_info.
Wild cards tend to bite us as manufacturers have an 'amusing' habit
of filling in gaps with unrelated devices.


> +	const struct iio_chan_spec (*channels)[2];
> +	enum iio_chan_type chan_type;
> +	const struct opt3001_scale (*scales)[12];
> +	int factor_whole;
> +	int factor_integer;
> +	int factor_decimal;

These three aren't obvious when just looking to fill in this
structure. Add some docs to hint at what they are.

> +	bool has_id;
> +};

> @@ -610,7 +690,7 @@ static int opt3001_read_id(struct opt3001 *opt)
>  	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_DEVICE_ID);
>  	if (ret < 0) {
>  		dev_err(opt->dev, "failed to read register %02x\n",
> -				OPT3001_DEVICE_ID);
> +			OPT3001_DEVICE_ID);

In general whitespace only changes belong in their own patch, but I guess
this one is pretty minor so we can skip that requirement this time.

>  		return ret;
>  	}

> @@ -746,7 +827,7 @@ static int opt3001_probe(struct i2c_client *client)
>  	struct iio_dev *iio;
>  	struct opt3001 *opt;
>  	int irq = client->irq;
> -	int ret;
> +	int ret = 0;
>  
>  	iio = devm_iio_device_alloc(dev, sizeof(*opt));
>  	if (!iio)
> @@ -755,12 +836,14 @@ static int opt3001_probe(struct i2c_client *client)
>  	opt = iio_priv(iio);
>  	opt->client = client;
>  	opt->dev = dev;
> +	opt->chip_info = device_get_match_data(&client->dev);
>  
>  	mutex_init(&opt->lock);
>  	init_waitqueue_head(&opt->result_ready_queue);
>  	i2c_set_clientdata(client, iio);
>  
> -	ret = opt3001_read_id(opt);
> +	if (opt->chip_info->has_id)
> +		ret = opt3001_read_id(opt);
>  	if (ret)
>  		return ret;
>  
Only check the ret if the function ran.  That way no need for the
dance with ret = 0 above.


> +static const struct iio_chan_spec opt3002_channels[] = {
> +	{
> +		.type = IIO_INTENSITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				BIT(IIO_CHAN_INFO_INT_TIME),

Generally intensity channels can't be processed because there are no
defined units as what you measure depends entirely on the frequency
sensitivity. There are some defined measurements such as illuminance
that use a specific sensivitiy curve, but if it's just intensity we
normally stick to _RAW..

> +		.event_spec = opt3001_event_spec,
> +		.num_event_specs = ARRAY_SIZE(opt3001_event_spec),
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +

