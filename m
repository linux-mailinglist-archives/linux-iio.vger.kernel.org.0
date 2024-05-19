Return-Path: <linux-iio+bounces-5098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5123F8C949A
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB0AB20D0E
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 12:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B152A2D627;
	Sun, 19 May 2024 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwCtbkiT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71558C125
	for <linux-iio@vger.kernel.org>; Sun, 19 May 2024 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716121335; cv=none; b=hB+qdBYEG9tSJONY2VzPfDQX7kGLVwctFMmtexTAlYtS1nX7ju0Xi1ZRoeikACHv7dB0VCbTVXNIIuVP/Syi6ajmu1ERz0EiWJW0vSlPIJ+CJw/fHL+YpQZL+NnI6aYcKDN6yTrZCQ/cu/hisAUJEPO+G2g1OPm5QHkLw8jBzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716121335; c=relaxed/simple;
	bh=OADU7cvMoZMxlDtWJ7BCF9KpEypaHOgvK/aVVOERg5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgAWgQXBw60d9G86vYj+xdrYkUjYl6DulkjaHEhcvAoUkF2iIZesxyNJl5Ak9zWGMwogZjFH3k/J3rwn7ko7h2QGhWJwkfucMogYmEAeOCGdC0wY02dlJffrQOC8L4DSwjW9yPHUeJBpPFeJmR85viMha3Qxo2z3wdzB9cw7HBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwCtbkiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55961C32781;
	Sun, 19 May 2024 12:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716121334;
	bh=OADU7cvMoZMxlDtWJ7BCF9KpEypaHOgvK/aVVOERg5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iwCtbkiTeQC/enougHhluWLVLQKF62KntM/7gWUhZbUXmGcNs10Yq6UB5NcTt5Ejd
	 9i/kFg4J1EeqbNIelXDFq3fU2aK3RNKPjm3usa8fN0pknm+DW7xFDkcR5z9wCOFOKz
	 9AYIWjznQtms+H+URC556maGNOJIsTSEvYXeFXSci7b9CZPe/2ALe7qlzQnNdH72jT
	 O3VuHTbOXHaDA7l6wr4zrhSCcPteLV6+qoLTvBeg32fNNtD+De7leHE4rnnzDQaQ7F
	 h7hfplIFmDvpd+3hvnZ5bkl9PRvXmurkPq7glg+4uJfIqKExJLc97oSTyeGQjSe/mW
	 31a9RTAy2pRIA==
Date: Sun, 19 May 2024 13:22:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arthur Becker <arthur.becker@sentec.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V2] iio: light: driver for Vishay VEML6040
Message-ID: <20240519132205.74daeba6@jic23-huawei>
In-Reply-To: <ZR1P278MB111789B39F5CC0086DAFA35081E22@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
References: <ZR1P278MB111789B39F5CC0086DAFA35081E22@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 14:33:39 +0000
Arthur Becker <arthur.becker@sentec.com> wrote:

> Implements driver for the Vishay VEML6040 rgbw light sensor.
> 
> Included functionality: setting the integration time and reading the raw
> values for the four channels
> 
> Not yet implemented: setting the measurements to 'Manual Force Mode' (Auto
> measurements off, and adding a measurement trigger)
> 
> Datasheet: https://www.vishay.com/docs/84276/veml6040.pdf
> signed-off-by: Arthur Becker <arthur.becker@sentec.com>
> ---
> V1 -> V2: Addressed review comments. DT-bindings in separate patch

Needs to be in the same series - with a cover-letter.
That explains the confusion going on wrt to the binding patch.
I was assuming this was unintentional mail server stuff but
from this comment I guess it's a misunderstanding.

Various comments inline. Pretty much all minor style things
as in general the driver is looking nice.

Jonathan

> diff --git a/drivers/iio/light/veml6040.c b/drivers/iio/light/veml6040.c
> new file mode 100644
> index 000000000000..9ce807d5484a
> --- /dev/null
> +++ b/drivers/iio/light/veml6040.c
> @@ -0,0 +1,307 @@
> +#include <linux/bitfield.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +

/*
 * VEML...

> +/* VEML6040 Configuration Registers
> + *
> + * SD: Shutdown
> + * AF: Auto / Force Mode (Auto Measurements On:0, Off:1)
> + * TR: Trigger Measurement (when AF Bit is set)
> + * IT: Integration Time
> + */
> +#define VEML6040_CONF_REG_RW 0x000
> +#define VEML6040_CONF_SD_MSK BIT(0)
> +#define VEML6040_CONF_AF_MSK BIT(1)
> +#define VEML6040_CONF_TR_MSK BIT(2)
> +#define VEML6040_CONF_IT_MSK GENMASK(6, 4)
> +#define VEML6040_CONF_IT_40 0
> +#define VEML6040_CONF_IT_80 1
> +#define VEML6040_CONF_IT_160 2
> +#define VEML6040_CONF_IT_320 3
> +#define VEML6040_CONF_IT_640 4
> +#define VEML6040_CONF_IT_1280 5
> +
> +/* VEML6040 Read Only Registers */
> +#define VEML6040_REG_R_RO 0x08
> +#define VEML6040_REG_G_RO 0x09
> +#define VEML6040_REG_B_RO 0x0A
> +#define VEML6040_REG_W_RO 0x0B
I'd be tempted to drop the _RW / _RO postfix.
It's a nice thing in more complex drives, but feels unnecessary
for a device with a small interface like this where the register usage
kind of makes it obvious anyway.
Channel registers are RO because writing them makes not sense and
config is RW because it's for configuration.

If you really like it then I don't mind that much.

> +static int veml6040_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	int ret, reg, it_index;
> +	struct veml6040_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = &data->client->dev;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->channel) {
Put VEML6040_REG_R_R0 etc in
	chan->address when you define the iio_chan_spec array
as then this becomes

		ret = regmap_read(regmap, chan->addr, &reg);
		if (ret) {
			dev_err(dev, "Data read failed: %d\n", ret);
			return ret;
		}
		*val = reg;
		return IIO_VAL_INT;

The address field is there for precisely this kind of case where you just
need a mapping to a specific register address.

> +		case CH_RED:
> +			ret = regmap_read(regmap, VEML6040_REG_R_RO, &reg);
> +			break;
> +		case CH_GREEN:
> +			ret = regmap_read(regmap, VEML6040_REG_G_RO, &reg);
> +			break;
> +		case CH_BLUE:
> +			ret = regmap_read(regmap, VEML6040_REG_B_RO, &reg);
> +			break;
> +		case CH_WHITE:
> +			ret = regmap_read(regmap, VEML6040_REG_W_RO, &reg);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		if (ret) {
> +			dev_err(dev, "iio-veml6040 - Can't read data %d\n",

No need to list the driver, that's easy to establish from what dev_err includes
anyway.

> +				ret);
> +			return ret;
> +		}
> +		*val = reg;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = regmap_read(regmap, VEML6040_CONF_REG_RW, &reg);
> +		if (ret) {
> +			dev_err(dev, "iio-veml6040 - Can't read data %d\n",
> +				ret);
> +			return ret;
> +		}
> +		it_index = FIELD_GET(VEML6040_CONF_IT_MSK, reg);
> +		if (it_index >= ARRAY_SIZE(veml6040_int_time_avail)) {
> +			dev_err(dev,
> +				"iio-veml6040 - Invalid Integration Time Set");
> +			return -EINVAL;
> +		}
> +		*val = veml6040_int_time_avail[it_index];
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int veml6040_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct veml6040_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		for (int i = 0; i < ARRAY_SIZE(veml6040_int_time_avail); i++) {
> +			if (veml6040_int_time_avail[i] == val) {
> +				return regmap_update_bits(
> +					data->regmap, VEML6040_CONF_REG_RW,
> +					VEML6040_CONF_IT_MSK,
> +					FIELD_PREP(VEML6040_CONF_IT_MSK, i));
> +			}
Trick to reduce indent - flip logic ;)
			if (veml6040_int_time_avail[i] != val)
				continue;

			return regmap_update_bits(regmap,
						  VEML6040_CONF_REG_RW,
						  VEML6040_CONF_IT_MSK,
						  FIELD_PREP(VEML6040_CONF_IT_MSK, i));
//case where it is worth going past 80 chars for readability.
			
> +		}
> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;

Can't get here so drop this final return.

> +}
> +
> +static int veml6040_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*length = ARRAY_SIZE(veml6040_int_time_avail);
> +		*vals = veml6040_int_time_avail;
> +		*type = IIO_VAL_INT;

That makes me suspicious.  The integration times are measured in seconds and
you only have integer values? 
Check all your ABI against the docs in Documentation/ABI/testing/sysfs-bus-iio



> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int veml6040_shutdown(struct veml6040_data *data)
> +{
> +	return regmap_update_bits(data->regmap, VEML6040_CONF_REG_RW,
> +				  VEML6040_CONF_SD_MSK, VEML6040_CONF_SD_MSK);
> +}
> +
> +static void veml6040_shutdown_action(void *data)
> +{
> +	veml6040_shutdown(data);

Combine these two functions into one as only called via this one.

> +}
> +
> +static int veml6040_probe(struct i2c_client *client)
> +{

Add a 
	struct device *dev = client->dev;
and use it throughout to avoid looking this up in every
error print etc.

> +	struct veml6040_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		return dev_err_probe(&client->dev, -EOPNOTSUPP,
> +				     "I2C adapter doesn't support plain I2C\n");
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev) {
> +		return dev_err_probe(&client->dev, -ENOMEM,
> +				     "IIO device allocation failed\n");
> +	}
> +
> +	regmap = devm_regmap_init_i2c(client, &veml6040_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		return dev_err_probe(&client->dev, PTR_ERR(regmap),
> +				     "Regmap setup failed\n");
> +	}
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	data->regmap = regmap;
> +
> +	indio_dev->name = "veml6040";
> +	indio_dev->info = &veml6040_info;
> +	indio_dev->channels = veml6040_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(veml6040_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = regmap_update_bits(
> +		data->regmap, VEML6040_CONF_REG_RW, VEML6040_CONF_IT_MSK,
You have regmap locally, so use that instead of via data->regmap.

> +		FIELD_PREP(VEML6040_CONF_IT_MSK, VEML6040_CONF_IT_40));
Unusual wrapping that we tend to only use where there are individual
parameters that can't be easily wrapped.  Preferred as

	ret = regmap_update_bits(regmap, VEML6040_CONF_REG_RW,
				 VEML6040_CONF_IT_MSK,
				 FIELD_PREP(VEML6040_CONF_IT_MASK,
					    VEML6040_CONF_IT_40));

> +
> +	if (ret) {
> +		return dev_err_probe(&client->dev, ret,
> +				     "Could not set Integration Time: %d\n",
> +				     ret);
> +	}
	if (ret)
		return dev_err_probe(dev, ret,
				     "Could not set Integration Time\n");
similar in other cases.


> +
> +	ret = regmap_update_bits(data->regmap, VEML6040_CONF_REG_RW,
> +				 VEML6040_CONF_AF_MSK,
> +				 FIELD_PREP(VEML6040_CONF_AF_MSK, 0));
> +	if (ret) {
> +		return dev_err_probe(&client->dev, ret,
> +				     "Could not set Automode: %d\n", ret);
> +	}
You are writing multiple fields in the same register. Can you just do
a single write? Build the mask and values then a single call to  regmap_update_bits
or just write the remaining couple of bits to their existing defaults so
we know what state they are in.

If there is a reason this needs to be done as multiple writes, then
add some comments to explain the sequencing.

> +
> +	ret = regmap_update_bits(data->regmap, VEML6040_CONF_REG_RW,
> +				 VEML6040_CONF_SD_MSK,
> +				 FIELD_PREP(VEML6040_CONF_SD_MSK, 0));
> +	if (ret) {
> +		return dev_err_probe(&client->dev, ret,
> +				     "Could not set Enable: %d\n", ret);
> +	}

No need for brackets around a single statement like above.
Fix all of these as there are a lot of them!

> +
> +	ret = devm_add_action_or_reset(&client->dev, veml6040_shutdown_action,
> +				       data);
> +	if (ret) {
> +		return dev_err_probe(&client->dev, ret,
> +				     "Could not add shutdown action: %d\n",
> +				     ret);

You should look at what dev_err_probe() does.
Don't print the ret value in your messages - dev_err_probe() does it much
better!

Some of these are also vanishingly unlikely to fail so you could reduce
where you print messages to the ones that are more to do with bus accesses
etc.  This one is an example of that as it can only fail if a very small
allocation fails.

> +	}
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id veml6040_id_table[] = { { "veml6040", 0 },
> +							  {} };
I'd prefer this in the more common formatting of 

static const struct i2c_device_id veml6040_id_table[] = {
	{ "veml6040" }, //note I dropped the 0 as no point in setting that when it's unused.
        { }
};

> +MODULE_DEVICE_TABLE(i2c, veml6040_id_table);
> +


