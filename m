Return-Path: <linux-iio+bounces-9295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB71970323
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 18:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FD7283C59
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7480E15C149;
	Sat,  7 Sep 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEEEark4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F522339;
	Sat,  7 Sep 2024 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725726049; cv=none; b=GSoCSlu0KdaO+pMUEGliPY9SQ7FfvPF0ZYYfI+07beOUwX6npc/TxWa6kQqEwY3Kz6otA+s/AKzrZamzRr3QXwfmOTeytHS5tRDEkwFh+zFIjbh3IhcXJMjkWA187upqQ8xRk8/1gOy2osoXRkdTM+HINYDAQ8R22gzSrJqkc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725726049; c=relaxed/simple;
	bh=qJ6/waoFmT1Cv0La4E8wcTpUpscnpHiv3jMhTxVzN28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lpc4UihcI270DAqOnWEWHY2G0zck/fbCug1EDjhoNrUmtjFbugDieCK64OFe4BuN4IDCsARNfeZq5vlYXFtM3+16muDSKBvua00NvpG8/91kZhHnjegusxFX/0apTSrRtHel4X6UaebvkOmATexSlAMcUGEjSI+VfQibjNNty44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEEEark4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05406C4CEC2;
	Sat,  7 Sep 2024 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725726048;
	bh=qJ6/waoFmT1Cv0La4E8wcTpUpscnpHiv3jMhTxVzN28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lEEEark4aC4PhE91Gaq2r5z37AH3VAKz8oKtHjF7M6kZuDnNfePUHDkIOsdbBDnNa
	 blIyhCCUzdyFf8o1lvvZdWzP+qgHZrf5BAzLkGes6DHHvK3edHZYMZsRMmNh/vQoUA
	 JRuuIFDowlTMD+SdZQXbNUaUaX0a68Quid86TiWgINzljU0V4+/fmES881jg4oTkNZ
	 PC6STuwxCqqqY4j3Ufp06HqkvYMaTywLtwEAyBLUDyIBtbzwnIkX1ELuaH5AZ5uAk9
	 CyuY6qv/gq6U315zRO9Eb2XQMGfu7rhVQAmtYsX6MW0UuWUntpQGZLulCxXu0eLzJ7
	 pcUQNMA+K8rYQ==
Date: Sat, 7 Sep 2024 17:20:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: temperature: tmp006: add triggered buffer
 support
Message-ID: <20240907172040.7cca5430@jic23-huawei>
In-Reply-To: <20240902125946.350635-2-apokusinski01@gmail.com>
References: <20240902125946.350635-1-apokusinski01@gmail.com>
	<20240902125946.350635-2-apokusinski01@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Sep 2024 14:59:47 +0200
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> Add support for continuous data capture using triggered buffers for the
> tmp006 sensor. The device features a "data ready" interrupt line which
> is pulled down once a new measurement is ready to be read.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
> Note:
> For some reason, the checkpatch.pl returns a warning for this patch:

Don't worry - it's a well known checkpatch false positive but the case is obscure
enough no one ever bothered 'fixing' it.

Ignore it.

However, I just merged a patch from Andy providing
aligned_s64 as a type so feel free to use that which should
get rid of this message.


> 
>   WARNING: Missing a blank line after declarations
>   #156: FILE: drivers/iio/temperature/tmp006.c:253:
>   +               s16 channels[2];
>   +               s64 ts __aligned(8);
> 
> It also suggests that the following code with a blank line is correct:
> 
> 	struct {
> 		s16 channels[2];
> 
> 		s64 ts __aligned(8);
> 	} scan;
> 
> I left the code as it was (with the WARNING) since it feels obviously
> more natural.

Various comments inline.

Jonathan

> ---
>  drivers/iio/temperature/Kconfig  |   2 +
>  drivers/iio/temperature/tmp006.c | 116 +++++++++++++++++++++++++++++--
>  2 files changed, 111 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index ed0e4963362f..1244d8e17d50 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -91,6 +91,8 @@ config MLX90635
>  config TMP006
>  	tristate "TMP006 infrared thermopile sensor"
>  	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  If you say yes here you get support for the Texas Instruments
>  	  TMP006 infrared thermopile sensor.
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> index 6d8d661f0c82..183b30a41573 100644
> --- a/drivers/iio/temperature/tmp006.c

>  #define TMP006_VOBJECT 0x00
>  #define TMP006_TAMBIENT 0x01
> @@ -45,6 +46,7 @@
>  struct tmp006_data {
>  	struct i2c_client *client;
>  	u16 config;
> +	struct iio_trigger *drdy_trig;
>  };
>  
>  static int tmp006_read_measurement(struct tmp006_data *data, u8 reg)
> @@ -81,15 +83,21 @@ static int tmp006_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);

I'd suggest the scoped variant of this as you
are effectively taking and releasing locks in different scopes.
The code is write, but not nice to read.

> +		if (ret)
> +			return ret;
> +
>  		if (channel->type == IIO_VOLTAGE) {
>  			/* LSB is 156.25 nV */
>  			ret = tmp006_read_measurement(data, TMP006_VOBJECT);
> +			iio_device_release_direct_mode(indio_dev);
>  			if (ret < 0)
>  				return ret;
>  			*val = sign_extend32(ret, 15);
>  		} else if (channel->type == IIO_TEMP) {
>  			/* LSB is 0.03125 degrees Celsius */
>  			ret = tmp006_read_measurement(data, TMP006_TAMBIENT);
> +			iio_device_release_direct_mode(indio_dev);
>  			if (ret < 0)
>  				return ret;
>  			*val = sign_extend32(ret, 15) >> TMP006_TAMBIENT_SHIFT;

> @@ -164,13 +178,29 @@ static const struct iio_chan_spec tmp006_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_BE
trailing comma wanted here.

> +		}
>  	},
>  	{
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -	}
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 14,
> +			.storagebits = 16,
> +			.shift = TMP006_TAMBIENT_SHIFT,
> +			.endianness = IIO_BE
add trailing comma. New fields may be added in future and need setting
so having ht comma will make that easier to do.

> +		}
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2)

Add a comma.  In is possible that other channels will follow this.
Doesn't often happen but there have been cases.

>  };
>  
>  static const struct iio_info tmp006_info = {
> @@ -213,6 +243,49 @@ static void tmp006_powerdown_cleanup(void *dev)
>  	tmp006_power(dev, false);
>  }
>  
> +static irqreturn_t tmp006_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct tmp006_data *data = iio_priv(indio_dev);
> +	struct {
> +		s16 channels[2];
> +		s64 ts __aligned(8);
> +	} scan;
> +
> +	scan.channels[0] = i2c_smbus_read_word_data(data->client, TMP006_VOBJECT);

read word_data uses an s32 return type to leave space for errors.  
What you have here will cause problems if the top bit happens to be set in
the register (i.e. it's a negative value).

So use a local s32 first then assign it to the buffer
data after checking for negative values.

Note you currently don't ensure both channels are enabled, so if the
user requests only the second channel they will get the wrong data.

Either make this code handle or set available_scan_masks appropriately
to let the core IIO code reorganize the data to what the user asked for.

> +	if (scan.channels[0] < 0)
> +		goto err;
> +
> +	scan.channels[1] = i2c_smbus_read_word_data(data->client, TMP006_TAMBIENT);
> +	if (scan.channels[1] < 0)
> +		goto err;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> +					   iio_get_time_ns(indio_dev));
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static int tmp006_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct tmp006_data *data = iio_priv(indio_dev);
> +
> +	if (state)
> +		data->config |= TMP006_CONFIG_DRDY_EN;
> +	else
> +		data->config &= ~TMP006_CONFIG_DRDY_EN;
> +
> +	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
> +		data->config);

Align with data on the line above, so just after the (

That's the preferred kernel style except when we are up against
really long lines or similar.

> +}
> +
> +static const struct iio_trigger_ops tmp006_trigger_ops = {
> +	.set_trigger_state = tmp006_set_trigger_state,
> +};
> +
>  static int tmp006_probe(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev;
> @@ -258,6 +331,35 @@ static int tmp006_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (client->irq > 0) {
> +		data->drdy_trig = devm_iio_trigger_alloc(&client->dev,
> +							 "%s-dev%d",
> +							 indio_dev->name,
> +							 iio_device_id(indio_dev));
> +		if (!data->drdy_trig)
> +			return -ENOMEM;
> +
> +		data->drdy_trig->ops = &tmp006_trigger_ops;
> +		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> +		ret = iio_trigger_register(data->drdy_trig);
> +		if (ret)
> +			return ret;
> +
> +		indio_dev->trig = iio_trigger_get(data->drdy_trig);
> +
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						iio_trigger_generic_data_rdy_poll,
> +						NULL,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
Type of interrupt should come from firmware.   We wrongly used to set it
in drivers (and are now stuck with that) but that overly constrains
things for no useful purpose.  So IRQF_ONESHOT only here.

> +						"tmp006_irq",
> +						data->drdy_trig);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> +					      tmp006_trigger_handler, NULL);
> +
check ret.

>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  


