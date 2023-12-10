Return-Path: <linux-iio+bounces-804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ECB80BB91
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 15:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9221F20FE4
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ECD13FE5;
	Sun, 10 Dec 2023 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo4LXIgw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7FFF9E2;
	Sun, 10 Dec 2023 14:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F180C433C8;
	Sun, 10 Dec 2023 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702217875;
	bh=C0Dyij2zYyDSC/iOZ8fDWtJJfC4MPWXnUM1ZCg4mFmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Eo4LXIgwZ26syD0BqAJAz6I44ZVP933WfHHlP+oVbBMOoThjeY1Ib2TPjZLoNyJfF
	 SXQL6LLtVVpKoGxMbguH7gIl9KTzcwIDxvwIEr9u1tHee27qz9GWRG3tsSYA8cUEXm
	 OuWcO6Y2oj+i0HyDuA2Co6Dt3kUKLcONjADn/k4nHx1Bea0YLe2ZndWPtHLVGEuzNo
	 siGmV6teNLEGlJ/gG3revS0UzuR7llSdMipdlBwpazxrwe2DqNrTg29A9Y9L63lvGi
	 LKjktg+yA1p/tW2c41/PW8kbheb0ubqf6r90lFYB7AXxjP9WEGkqj+gtBRAMimRNCd
	 6N4/aiwXJYFIA==
Date: Sun, 10 Dec 2023 14:17:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Li peiyu <579lpy@gmail.com>
Cc: javier.carrasco.cruz@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/4] iio: humidity: Add driver for ti HDC302x
 humidity sensors
Message-ID: <20231210141749.2d206591@jic23-huawei>
In-Reply-To: <20231209105816.3871-1-579lpy@gmail.com>
References: <20231209105217.3630-1-579lpy@gmail.com>
	<20231209105816.3871-1-579lpy@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 Dec 2023 18:58:16 +0800
Li peiyu <579lpy@gmail.com> wrote:

> Add support for HDC302x integrated capacitive based relative
> humidity (RH) and temperature sensor.
> This driver supports reading values, reading the maximum and
> minimum of values and controlling the integrated heater of
> the sensor.
> 
> Co-developed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Signed-off-by: Li peiyu <579lpy@gmail.com>

A few follow up comments as you are going to be doing a v6 to resolve the
dt-binding feedback on v5.

Thanks,

Jonathan

> diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
> index f19ff3de97c5..5fbeef299f61 100644
> --- a/drivers/iio/humidity/Makefile
> +++ b/drivers/iio/humidity/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_AM2315) += am2315.o
>  obj-$(CONFIG_DHT11) += dht11.o
>  obj-$(CONFIG_HDC100X) += hdc100x.o
>  obj-$(CONFIG_HDC2010) += hdc2010.o
> +obj-$(CONFIG_HDC3020) += hdc3020.o
>  obj-$(CONFIG_HID_SENSOR_HUMIDITY) += hid-sensor-humidity.o
>  
>  hts221-y := hts221_core.o \
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> new file mode 100644
> index 000000000000..da7a7990656c
> --- /dev/null
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -0,0 +1,470 @@

..

> +static const struct iio_chan_spec hdc3020_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
> +		BIT(IIO_CHAN_INFO_TROUGH) | BIT(IIO_CHAN_INFO_OFFSET),
> +	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
> +		BIT(IIO_CHAN_INFO_TROUGH) | BIT(IIO_CHAN_INFO_OFFSET),
The offset is 0 for this channel.  Convention for that is don't provide it
as that is the assumed default. So drop BIT(IIO_CHAN_INFO_OFFSET) from
here and return an error in read_raw if offset is requested for channels
of type other than IIO_TEMP
> +	},
> +	{
> +		/*
> +		 * For setting the internal heater, which can be switched on to
> +		 * prevent or remove any condensation that may develop when the
> +		 * ambient environment approaches its dew point temperature.
> +		 */
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
> +		.output = 1,
> +	},
> +};
> +



> +
> +static int hdc3020_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct hdc3020_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type != IIO_TEMP && chan->type != IIO_HUMIDITYRELATIVE)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		guard(mutex)(&data->lock);
> +		ret = hdc3020_read_measurement(data, chan->type, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_PEAK: {
> +		guard(mutex)(&data->lock);
> +		if (chan->type == IIO_TEMP) {
> +			ret = hdc3020_read_high_peak_t(data, val);
> +			if (ret < 0)
> +				return ret;
> +		} else {
> +			ret = hdc3020_read_high_peak_rh(data, val);
> +			if (ret < 0)
> +				return ret;
> +		}
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_TROUGH: {
> +		guard(mutex)(&data->lock);
> +		if (chan->type == IIO_TEMP) {
> +			ret = hdc3020_read_low_peak_t(data, val);
> +			if (ret < 0)
> +				return ret;
> +		} else {
> +			ret = hdc3020_read_low_peak_rh(data, val);
> +			if (ret < 0)
> +				return ret;
> +		}
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val2 = 65536;
> +		if (chan->type == IIO_TEMP)
> +			*val = 175;
> +		else
> +			*val = 100;
> +		return IIO_VAL_FRACTIONAL;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type == IIO_TEMP)
> +			*val = 16852;
> +		else
> +			*val = 0;
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
Where we expect all cases in a switch statement to return (no breaks)
like here, I think we can make that explicit and let the compiler catch any
that break this intent, by moving this final return into
	default:
		return -EINVAL;

> +}
> +

> +
> +static int hdc3020_update_heater(struct hdc3020_data *data, int val)
> +{
> +	u8 buf[5];
> +	int ret;
> +
> +	if (val < hdc3020_heater_vals[0] || val > hdc3020_heater_vals[2])
> +		return -EINVAL;
> +
> +	buf[0] = HDC3020_HEATER_CMD_MSB;
> +
> +	if (!val) {
> +		buf[1] = HDC3020_HEATER_DISABLE;
> +		return hdc3020_write_bytes(data, buf, 2);
> +	}
> +
> +	buf[1] = HDC3020_HEATER_CONFIG;
> +	buf[2] = (val & 0x3F00) >> 8;
> +	buf[3] = val & 0xFF;

You could do this as a put_unaligned_be16(val & GENMASK(13, 0), &buf[2]);

(at least I think that's what it is doing).  That makes it a little more
explicit that a 14 bit value is being written.

> +	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
> +	ret = hdc3020_write_bytes(data, buf, 5);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf[1] = HDC3020_HEATER_ENABLE;
> +
> +	return hdc3020_write_bytes(data, buf, 2);
> +}
> +

> +static int hdc3020_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct hdc3020_data *data;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	crc8_populate_msb(hdc3020_crc8_table, HDC3020_CRC8_POLYNOMIAL);
> +
> +	indio_dev->name = "hdc3020";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &hdc3020_info;
> +	indio_dev->channels = hdc3020_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
> +
> +	ret = hdc3020_write_bytes(data, HDC3020_S_AUTO_10HZ_MOD0, 2);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Unable to set up measurement\n");
> +
> +	ret = devm_add_action_or_reset(&data->client->dev, hdc3020_stop, data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to add device\n");

Ah. I was talking about this bit above in previous review as the
devm_add_action_or_reset() is the call that is unlikely to fail and
isn't "add device".  Having an error for devm_iio_device_regiser()
was fine and that kind of is adding a device so the error message was fine.

Generally comments, in my reviews at least, come immediately after the code.
In this example it was indeed ambiguous, so sorry about that!

> +
> +	return devm_iio_device_register(&data->client->dev, indio_dev);
> +}


