Return-Path: <linux-iio+bounces-5105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D70E18C94E3
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 16:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DDBB2113C
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61ED481B1;
	Sun, 19 May 2024 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0/KK0d0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A98E1870;
	Sun, 19 May 2024 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716127324; cv=none; b=cya5+LyyWvWH2yuLV+pRszyq1QKZF5wCPcnRi+o1Ygl082igkrIYcOdxBbM9ZIrAuVdk9f0jwTsmK/rdouJMiZwoNaGOV6ytmXP3ZnqFYT/wjsOQZt/GDTfUuNvyr95c+o5AsxQQPCa83Bd9RKHYxELddSTe68TDeJs6pg/LNKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716127324; c=relaxed/simple;
	bh=sbK7rEfM58wG30zLosVCLwXkwK3gPeXX22rig67yu5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ttv2vsiyNBhM+S210bnSo03Tgb6odNPmdsP0rysN0gjhmuBkeRrP1Wjwo9jExt4617ndGRzpueIbJ+nYX99euBmIChHmT1WmNhzu+XGjzAGrB3xMGKtAyRqB6+NL2JqNOZ2+YKbrkGIHNvAE+lm7KXomhpt/gqv9LjJIDOy/zJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0/KK0d0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117CFC32781;
	Sun, 19 May 2024 14:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716127324;
	bh=sbK7rEfM58wG30zLosVCLwXkwK3gPeXX22rig67yu5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O0/KK0d0scZK4qnwDw/19GUKq9cLiQnQaoI19woZ2343Yd5YdodxMV8ItYcGplaNj
	 bkW4T0dU5vG8AEdnWcO9zxpsWZontsRPYgBHMzRjo6IIu6vWAS6hZ/Xi4ENVAYrzcq
	 pg77dtx3hDAVam3bLxq93mpd5tNjgehBW+yd7yY8c7pIvQq54wuUQemI3lv3Hs+peA
	 xQ/cPjLcN5dwza1KEMaCOzQf2riD0dmm/fj+Jy+ryF3vg4crOvhfm5DsUZz+Lb2yPo
	 VmGa6XsZ3V32PECiYdYMrOg0oI3R/3JgLnR9QDZEZJLRWFvh7VvgULZZtmyJqxSUqN
	 9GvSEsIKRuXRg==
Date: Sun, 19 May 2024 15:01:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, christophe.jaillet@wanadoo.fr,
 gerald.loacker@wolfvision.net, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: chemical: add driver for ENS160 sensor
Message-ID: <20240519150151.291a21dc@jic23-huawei>
In-Reply-To: <20240512210444.30824-4-gustavograzs@gmail.com>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
	<20240512210444.30824-4-gustavograzs@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 May 2024 18:04:39 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> ScioSense ENS160 is a digital metal oxide multi-gas sensor, designed
> for indoor air quality monitoring. The driver supports readings of
> CO2 and VOC, and can be accessed via both SPI and I2C.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>

Hi Gustavo,

Nice driver in general. 2 things that need fixing though.

- DMA safe buffers for the bulk accesses etc. This is esoteric and won't actually
  cause you any problems today (and depending on your host may never do so)
  but I'm trying to keep the IIO drivers inline with the rule that if they do SPI
  even via regmap and bulk accesses they need to use DMA safe buffers
- devm vs non-devm cleanup. If you mix these it has to be a clean transition. 
  So devm for first N and non devm for everything from N+1. They cannot be mixed
  safely. Easiest option is devm_ for everything.

Jonathan

> diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
> new file mode 100644
> index 000000000..25593420d
> --- /dev/null
> +++ b/drivers/iio/chemical/ens160_core.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ScioSense ENS160 multi-gas sensor driver
> + *
> + * Copyright (c) 2024 Gustavo Silva <gustavograzs@gmail.com>
> + *
> + * Data sheet:
> + *  https://www.sciosense.com/wp-content/uploads/2023/12/ENS160-Datasheet.pdf
> + *
Trivial, but this blank line adds nothing so drop it.
> + */

> +
> +static int ens160_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct ens160_data *data = iio_priv(indio_dev);
> +	__le16 buf;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_bulk_read(data->regmap, chan->address,
> +					&buf, sizeof(buf));

As below, should use a DMA safe buffer.

> +		if (ret)
> +			return ret;
> +		*val = le16_to_cpu(buf);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->channel2) {
> +		case IIO_MOD_CO2:
> +			/* The sensor reads CO2 data as ppm */
> +			*val = 0;
> +			*val2 = 100;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_MOD_VOC:
> +			/* The sensor reads VOC data as ppb */
> +			*val = 0;
> +			*val2 = 100;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		}

		default:
			return -EINVAL;
and drop the one below.

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ens160_set_mode(struct ens160_data *data, u8 mode)
> +{
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, ENS160_REG_OPMODE, mode);
> +	if (ret)
> +		return ret;
> +
> +	msleep(ENS160_BOOTING_TIME_MS);
> +
> +	return 0;
> +}
> +
> +static int ens160_chip_init(struct ens160_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	u8 fw_version[3];
> +	__le16 part_id;
> +	unsigned int status;
> +	int ret;
> +
> +	ret = ens160_set_mode(data, ENS160_REG_MODE_RESET);
> +	if (ret)
> +		return ret;

No docs that I can see on what this means for access to registers etc.
Good to add a comment if you have info on this.

> +
> +	ret = regmap_bulk_read(data->regmap, ENS160_REG_PART_ID, &part_id,
> +			       sizeof(part_id));

Ah. So this is a fun corner case.  Currently regmap makes not guarantees
to always bounce buffer things (though last time I checked it actually did
do so - there are optimisations that may make sense where it will again
not do so).  So given we have an SPI bus involved, we should ensure that
only DMA safe buffers are used. These need to ensure that no other data
that might be changed concurrently with DMA is in the same IIO_DMA_MINALIGN
of aligned data (traditionally a cacheline but it gets more complex in some
systems and is less in others).  Upshot is that if you are are doing
bulk accesses you need to use a buffer that is either on the heap (kzalloc etc)
or carefully placed at the end of the iio_priv() structure marked
__align(IIO_DMA_MINALIGN). Lots of examples of that in tree.
If you are curious, wolfram did a good talk on the i2c equivalent of this
a few years back. 
https://www.youtube.com/watch?v=JDwaMClvV-s I think.

> +	if (ret)
> +		return ret;
> +
> +	if (le16_to_cpu(part_id) != ENS160_PART_ID)
> +		return -ENODEV;
> +
> +	ret = ens160_set_mode(data, ENS160_REG_MODE_IDLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, ENS160_REG_COMMAND,
> +			   ENS160_REG_COMMAND_CLRGPR);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, ENS160_REG_COMMAND,
> +			   ENS160_REG_COMMAND_GET_APPVER);
> +	if (ret)
> +		return ret;
> +
> +	msleep(ENS160_BOOTING_TIME_MS);

Why here?  Not obviously associated with a boot command?
A comment might make this easier to follow.  I 'think' it is
because this next read is the first time it matters. If so that
isn't obvious.  Also, there is an existing sleep in the mode set,
so I'm not sure why we need another one.

> +
> +	ret = regmap_bulk_read(data->regmap, ENS160_REG_GPR_READ4,
> +			       fw_version, sizeof(fw_version));

The first datasheet that google provided me has this 
GPR_READ0/GPR_READ1 and only 2 bytes. I hope they have maintained backwards
compatibility with that earlier doc!

When you do a separate DT binding in v2, make sure to include a link
to the datasheet you are using.  Also use a Datasheet: tag
in this patch to make it easy to find that.
I dug a little deeper and found the one on sciosense own website
- ah, you do have it in the comments.  Add to the commit message
and DT binding as well.


> +	if (ret)
> +		return ret;
> +
> +	msleep(ENS160_BOOTING_TIME_MS);
Why again?
> +
> +	dev_info(dev, "firmware version: %u.%u.%u\n", fw_version[2],
> +		 fw_version[1], fw_version[0]);

Can definitely do this before the sleep above.

> +
> +	ret = ens160_set_mode(data, ENS160_REG_MODE_STANDARD);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, ENS160_REG_DEVICE_STATUS, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(ENS160_STATUS_VALIDITY_FLAG, status)
> +	    != ENS160_STATUS_NORMAL)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct iio_info ens160_info = {
> +	.read_raw = ens160_read_raw,
> +};
> +
> +int ens160_core_probe(struct device *dev, struct regmap *regmap,
> +		      const char *name)
> +{
> +	struct ens160_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);

After you've moved to devm_add_action_or_reset() for the unwind of
ens160_chip_init() you probably don't need to set the drvdata.

> +	data->regmap = regmap;
> +
> +	indio_dev->name = name;
> +	indio_dev->info = &ens160_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ens160_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ens160_channels);
> +
> +	ret = ens160_chip_init(data);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "chip initialization failed\n");
> +		return ret;
		return dev_err_probe();

> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_NS(ens160_core_probe, IIO_ENS160);
> +
> +void ens160_core_remove(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ens160_data *data = iio_priv(indio_dev);
> +
> +	ens160_set_mode(data, ENS160_REG_MODE_IDLE);

This looks to be mixing devm and manual cleanup.
My guess is this is the unwind for code in ens160_chip_init()
If so that unwind should definitely happen after we unregister
the userspace intefaces in the unwind of devm_iio_device_register().
Currently it happens before this.

This is an even stronger reason to use devm_add_action_or_reset()
for this than tidying up as mentioned below (note I tend to
review backwards through patches so my comments may make more
sense read that way around).

> +}
> +EXPORT_SYMBOL_NS(ens160_core_remove, IIO_ENS160);
> +
> +MODULE_AUTHOR("Gustavo Silva <gustavograzs@gmail.com>");
> +MODULE_DESCRIPTION("ScioSense ENS160 driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/chemical/ens160_i2c.c b/drivers/iio/chemical/ens160_i2c.c
> new file mode 100644
> index 000000000..ee2b44184
> --- /dev/null
> +++ b/drivers/iio/chemical/ens160_i2c.c
> @@ -0,0 +1,68 @@
...

> +static int ens160_i2c_probe(struct i2c_client *client)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &ens160_regmap_i2c_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return ens160_core_probe(&client->dev, regmap, client->name);

As below, hardcode the name for now.  If it matters in future, get it
from a chip specific structure that we can look up from whichever
firmware table we have matched against.

> +}
> +
> +static void ens160_i2c_remove(struct i2c_client *client)
> +{
> +	ens160_core_remove(&client->dev);
As below, switch to devm_add_action_or_reset() called from
devm_ens160_core_probe() to avoid need to have manual remove
in here.

> +}
> +
> +static const struct i2c_device_id ens160_i2c_id[] = {
> +	{ "ens160", 0 },

As below - drop the 0.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ens160_i2c_id);
...

> diff --git a/drivers/iio/chemical/ens160_spi.c b/drivers/iio/chemical/ens160_spi.c
> new file mode 100644
> index 000000000..effc4acee
> --- /dev/null
> +++ b/drivers/iio/chemical/ens160_spi.c
...

> +static int ens160_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +	regmap = devm_regmap_init_spi(spi, &ens160_regmap_spi_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
> +			regmap);
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return ens160_core_probe(&spi->dev, regmap, id->name);

Hardcode the name here for now.  When you support multiple drivers you will want to
get it from a chip type specific structure, not id->name because that path gives
rather unexpected answers if we are using devicetree fallback compatibles
or the lists end up not matching perfectly for some other reason.

That fragility means we mostly just use another source for the name
and where possible hard code it.

> +}
> +
> +static void ens160_spi_remove(struct spi_device *spi)
> +{
> +	ens160_core_remove(&spi->dev);
Might as well register an automated cleanup, particularly as you can
do it in ens160_core_probe() and have it apply to any other buses for
free.  If you do that, rename that function devm_ens160_core_probe()
to make it obvious that is what is going on.

Use devm_add_action_or_reset() to register custom cleanup.

Then you can drop this remove function entirely.

> +}
> +
> +static const struct of_device_id ens160_spi_of_match[] = {
> +	{ .compatible = "sciosense,ens160" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ens160_spi_of_match);
> +
> +static const struct spi_device_id ens160_spi_id[] = {
> +	{ "ens160", 0 },

Don't set the 0 as that suggests it matters whereas it doesn't
yet. Maybe it will matter when more parts are added to this driver in future
 - if so introduce it then.  As a general best practice, this is almost
always a pointer these days anyway rather than an integer.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ens160_spi_id);


