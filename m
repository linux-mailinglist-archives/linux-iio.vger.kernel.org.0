Return-Path: <linux-iio+bounces-12893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B18A9DF310
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFC5162E8D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACDD1AA783;
	Sat, 30 Nov 2024 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEWu9BjS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1317BD3;
	Sat, 30 Nov 2024 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732999179; cv=none; b=M+HBjDwJhAcZvtkqgHiTN2RYwYcn37Xyv+A0zJ7AnFwM0p8OujRCH1tXllK2mbDSKL7myPclDHcaPWH055gVn4T/i5OipcLOCXJFnLxp1eBQ/CwhbjF2vfzOPefyg6i2llggwQ7NdNzChM8DKgcUDFFf9dESlFIbIKykSg9APlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732999179; c=relaxed/simple;
	bh=qRfK5PtAMC0vE9aCNwX6k13FTpxAWYYO+TlvjaJvqUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONX3yvB8/pnvlxS9/eF4q+Pp/arWYp2OV0G1o+L49pBV0H+iKB4pyNOmocDAQk9lGT3yJ7YVi/EVdM3Yp+xcrVgpYYoGBRa0WWM4F3inZaNrUc7/3l6LsZqBuO+bF4SWFfboiGER7ZOgUWq/ySIGzSNiacqu6tVA6IvGjjxTjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEWu9BjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35A6C4CECC;
	Sat, 30 Nov 2024 20:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732999178;
	bh=qRfK5PtAMC0vE9aCNwX6k13FTpxAWYYO+TlvjaJvqUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uEWu9BjS7dRxjjxuSsKCWRgeHYrsoPaHKQWRxv7XQrv5jDnrgUgPWwQXV3yZ6tyFk
	 DonYgQGmsmE6PtD7HzVZAmgIG6ErU22pAmhHNzIkLAGUNFvxCOSBStKB52S2Wf9OmN
	 9d/NlEoYyl37PiH+mFuZmFeRBiH+z9hf3+VsnjAa7K9nzJNJihNNl/We+SqmTrCiXB
	 ChdPvVItxqdEzSXx+YsNtzwBNCGhp9Ee7WOcpYUiiGatBOpTxg01bSJa+6HW1by1FR
	 cNHgEV3pN0emSywRDOAbFeo05zMhhYePIBsF9hA5+HWvKqDBvkVH/hQFi5i3FYRBTf
	 Njt9RqfXNqDQw==
Date: Sat, 30 Nov 2024 20:39:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, cmo@melexis.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: temperature: Add Nuvoton NCT7718W support
Message-ID: <20241130203929.67c6c7f6@jic23-huawei>
In-Reply-To: <20241126074005.546447-3-tmyu0@nuvoton.com>
References: <20241126074005.546447-1-tmyu0@nuvoton.com>
	<20241126074005.546447-3-tmyu0@nuvoton.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 15:40:05 +0800
Ming Yu <a0282524688@gmail.com> wrote:

> This patch adds support for the Nuvoton NCT7718W temperature sensor.
> 
Hi Ming, I'll give this a quick look only as I suspect you will end
up moving over to hwmon.

Thanks,

Jonathan

> Signed-off-by: Ming Yu <tmyu0@nuvoton.com>
...

> diff --git a/drivers/iio/temperature/nct7718.c b/drivers/iio/temperature/nct7718.c
> new file mode 100644
> index 000000000000..60624b3de629
> --- /dev/null
> +++ b/drivers/iio/temperature/nct7718.c
> @@ -0,0 +1,505 @@

> +struct nct7718_data {
> +	struct i2c_client *client;
> +	struct mutex lock;
Locks need a comment to say what data they are protecting.

> +	u16 status_mask;
> +};

> +static int nct7718_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      int state)
> +{
> +	struct nct7718_data *data = iio_priv(indio_dev);
> +	unsigned int status_mask;
> +	int ret;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_TEMP_AMBIENT:
> +		if (dir == IIO_EV_DIR_RISING)
> +			status_mask = NCT7718_MSK_LTH;
> +		break;
> +	case IIO_MOD_TEMP_OBJECT:
> +		if (dir == IIO_EV_DIR_RISING)
> +			status_mask = NCT7718_MSK_RT1H;
> +		else
> +			status_mask = NCT7718_MSK_RT1L;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_smbus_read_byte_data(data->client, NCT7718_ALERTMASK_REG);
> +	mutex_unlock(&data->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (state)
> +		ret &= ~status_mask;
> +	else
> +		ret |=  status_mask;
I would not bother with this sort of alignment. It tends to be fragile longer
term as code gets modified and doesn't make much difference to readablility.

> +
> +	return i2c_smbus_write_byte_data(data->client, NCT7718_ALERTMASK_REG,
> +					 data->status_mask = ret);
> +}

> +
> +static int nct7718_write_thresh(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct nct7718_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u8 msb_reg, lsb_reg;
> +	s16 thresh;
> +	int ret, s_val;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_TEMP_AMBIENT:
> +		val = clamp_val(val, NCT7718_LOCAL_TEMP_MIN,
> +				NCT7718_LOCAL_TEMP_MAX);
> +
> +		if (dir == IIO_EV_DIR_RISING) {
> +			return i2c_smbus_write_byte_data(client,
> +							 NCT7718_LT_HALERT_REG,
> +							 val);
> +		}
> +		break;
> +	case IIO_MOD_TEMP_OBJECT:
> +		s_val = (val < 0) ? ((val * 1000000) - val2) :
> +				    ((val * 1000000) + val2);
> +
> +		s_val = clamp_val(s_val, NCT7718_REMOTE_TEMP_MIN_MICRO,
> +				  NCT7718_REMOTE_TEMP_MAX_MICRO);
> +
> +		if (dir == IIO_EV_DIR_RISING) {
> +			msb_reg = NCT7718_RT1_HALERT_MSB_REG;
> +			lsb_reg = NCT7718_RT1_HALERT_LSB_REG;
> +		} else {
> +			msb_reg = NCT7718_RT1_LALERT_MSB_REG;
> +			lsb_reg = NCT7718_RT1_LALERT_LSB_REG;
> +		}
> +
> +		thresh = (s16)(s_val / (1000000 >> 3));
> +		ret = i2c_smbus_write_byte_data(client,
> +						msb_reg, thresh >> 3);
> +		if (ret < 0)
> +			return ret;
> +		return i2c_smbus_write_byte_data(client,
> +						 lsb_reg, thresh << 5);
> +	default:
> +		break;
return -EINVAL; and drop return below.

> +	}
> +
> +	return -EINVAL;
> +}
>
> +
> +static bool nct7718_check_id(struct i2c_client *client)
> +{
> +	int chip_id, vendor_id, device_id;
> +
> +	chip_id = i2c_smbus_read_byte_data(client, NCT7718_VID_REG);
> +	if (chip_id < 0)
> +		return false;
> +
> +	vendor_id = i2c_smbus_read_byte_data(client, NCT7718_VID_REG);
> +	if (vendor_id < 0)
> +		return false;
> +
> +	device_id = i2c_smbus_read_byte_data(client, NCT7718_DID_REG);
> +	if (device_id < 0)
> +		return false;
> +
> +	return (chip_id == NCT7718_CHIP_ID &&
> +		vendor_id == NCT7718_VENDOR_ID &&
> +		device_id == NCT7718_DEVICE_ID);
As below. Don't treat this failing as an error.   It is an error if
you can't read anything however.

> +}
> +
> +static int nct7718_chip_config(struct nct7718_data *data)
> +{
> +	int ret;
> +
> +	/* Enable MSK_LTH, MSK_RT1H, and MSK_RT1L to monitor alarm */
Code makes this fairly obvoius.

> +	ret = i2c_smbus_read_byte_data(data->client,
> +				       NCT7718_ALERTMASK_REG);
> +	if (ret < 0)
> +		return ret;
> +	data->status_mask = ret;
> +	data->status_mask &= ~(NCT7718_MSK_LTH	|
> +			       NCT7718_MSK_RT1H	|
> +			       NCT7718_MSK_RT1L);
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					NCT7718_ALERTMASK_REG,
> +					data->status_mask);

Perhaps consider regmap for it's richer set of functionality.

> +	if (ret < 0)
> +		return ret;
> +
> +	/* Config ALERT Mode Setting to comparator mode */

Ideally (like here) the code should be self explanatory so you don't
need comments.  When that is the case the comment is both unnecessary
and a source of possible future confusion if the code changes and we
fail to keep the comment in sync.

> +	return i2c_smbus_write_byte_data(data->client,
> +					 NCT7718_ALERTMODE_REG,
> +					 NCT7718_MOD_COMP);
> +}
> +
> +static int nct7718_probe(struct i2c_client *client)
> +{
> +	struct nct7718_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!nct7718_check_id(client)) {
> +		dev_err(&client->dev, "No NCT7718 device\n");

If you get an ID missmatch, it is fine to print a message, but carry on anyway.
This is necessary because DT has fallback compatibles to allow for newer devices
working with older drivers.  That only works if we believe the firmware and
ignore a mismatched ID.

> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);

For new code prefer
	ret = devm_mutex_init()
	if (ret)
		return ret;

> +
> +	indio_dev->name = client->name;

client->name doesn't always end up as the part number which is what
we need here.  Just put "nct7718" in here directly.

Some drivers do this wrong and we can't fix them without breaking 
userspace, but we don't want to introduce more.

> +	indio_dev->channels = nct7718_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(nct7718_channels);
> +	indio_dev->info = &nct7718_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = nct7718_chip_config(data);
> +	if (ret)
> +		return ret;
> +
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(&client->dev,
> +						client->irq,
> +						NULL,
> +						nct7718_alert_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						"nct7718", indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev, "Failed to request irq!\n");
> +			return ret;
> +		}
> +	}
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}

