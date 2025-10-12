Return-Path: <linux-iio+bounces-25014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2513CBD0BBD
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 21:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5ED3BCC94
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A099021D011;
	Sun, 12 Oct 2025 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+UE6rq0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E534BA53;
	Sun, 12 Oct 2025 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297834; cv=none; b=hVDG8j/JpytNO7SAXp1Bwyh5aclnBVIXaE5VsiTmH8/EsCRHlBa88A8hUzYODi45b1toNFPItJkl72pI0fkc+5Kqv/euvkE3fY6vjYy4GB/dSqbuZs7tA87x6tmI899hN2G64UWf5vyP3N9nKdVUfaoXgUtRC9qVrRwwJ1/FyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297834; c=relaxed/simple;
	bh=t/5LWHq3mCqG35cMNrVuG5h7I2s/5Am3LGNG3R/6Qw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hs3g2u8FbjJFXuK3tTkncBklmjig65Z4XStwV7+IM3xRDK/0f+vqF/8WI/gto354hbBPwgKOLctic7jfGM4eLWaYJK2aYE6uSz7rLBfKpj3WFensCDM+6hATlqWsr+ueDdQhiCEf2k91xWOIJNEckZhrV+DE+E+O9od0KP9jeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+UE6rq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9659CC4CEE7;
	Sun, 12 Oct 2025 19:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760297829;
	bh=t/5LWHq3mCqG35cMNrVuG5h7I2s/5Am3LGNG3R/6Qw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l+UE6rq0T4FLm+52+t07trXwGzux1Kgqs5M9UPF8Fv5gIRv4elcpIj3ti/dQpIpWn
	 WtSF5ZcoIA0KTIJ/gSLdTLRU2owM0K99tZfDFIkaIKnBC+LxIVBMLPz74+xYWJAEoU
	 PmbQqKraBTp51a6KsRqiTKHA7+mMFh7gtpJ7VBf+IbAhLoxWZHsMYtDISr9RiDKThy
	 qYKiB9J3b3IZ87PC5rsyGC3V43BHXAaI2pfeUZHXUg3f7SteLQdCn+4E1PG12u43Ra
	 u5UBvpknr5vdyqdsYR/l6zXeZPRPLLgNpSQgBAuhqsQo2FWeKC0dZn2G6PIjI3ok0H
	 iYlvG0bTXIeLg==
Date: Sun, 12 Oct 2025 20:36:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: dlechner@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt1@gmail.com, vassilisamir@gmail.com, salah.triki@gmail.com,
 skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 akhileshpatilvnit@gmail.com
Subject: Re: [PATCH 2/2] iio: pressure: adp810: Add driver for adp810 sensor
Message-ID: <20251012203658.167f3362@jic23-huawei>
In-Reply-To: <8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
References: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>
	<8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Oct 2025 17:55:28 +0530
Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:

Hi Akhilesh, 

Thanks for sending this and a late welcome to IIO.

> Add driver for Aosong adp810 differential pressure and
> temperature sensor. This sensor provides I2C interface for
> reading data. Calculate CRC of the data received using standard
> crc8 library to verify data integrity.
> 
Wrap commit messages to 75 chars.

> Tested on TI am62x sk board with sensor connected at i2c-2
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

Where I've remembered Andy commenting on something I've not duplicated
(assuming I even noticed the same thing!)

A few things may contradict or provide alternative suggestions though!

Jonathan


> diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
> new file mode 100644
> index 000000000000..ff73330b34fc
> --- /dev/null
> +++ b/drivers/iio/pressure/adp810.c
> @@ -0,0 +1,205 @@
> +/* Trigger command to send to start measurement by the sensor */
> +#define ADP810_TRIGGER_COMMAND		0x2d37
> +#define ADP810_CRC8_POLYNOMIAL		0x31
> +
> +DECLARE_CRC8_TABLE(crc_table);
> +
> +struct adp810_read_buf {
> +	u8 dp_msb;
> +	u8 dp_lsb;

__be16 dp;
or u8 dp[2]; 

> +	u8 dp_crc;
> +	u8 tmp_msb;
> +	u8 tmp_lsb;

__be16_tmp;

> +	u8 tmp_crc;
> +	u8 sf_msb;
> +	u8 sf_lsb;

__be16 sf;

> +	u8 sf_crc;
> +} __packed;
With packed (which you didn't need previously).
(more below)

> +
> +struct adp810_data {
> +	struct i2c_client *client;
> +	/* Use lock to synchronize access to device during read sequence */
> +	struct mutex lock;
> +};
> +
> +static int adp810_measure(struct adp810_data *data, struct adp810_read_buf *buf)
> +{
> +	struct i2c_client *client = data->client;
> +	int ret;
Not sure what ordering you are using for declarations but this looks a bit
odd.  If nothing else makes more sense go with reverse xmas tree.

> +	u16 trig_cmd = ADP810_TRIGGER_COMMAND;
> +
> +	/* Send trigger to the sensor for measurement */
> +	ret = i2c_master_send(client, (char *)&trig_cmd, sizeof(u16));
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error sending trigger command\n");
> +		return ret;
> +	}
> +
> +	/* Wait for sensor to aquire data */
> +	msleep(ADP810_MEASURE_LATENCY);
> +
> +	/* Read sensor values */
> +	ret = i2c_master_recv(client, (char *)buf, sizeof(*buf));
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error reading from sensor\n");
> +		return ret;
> +	}
> +
> +	/* CRC checks */
> +	crc8_populate_msb(crc_table, ADP810_CRC8_POLYNOMIAL);
> +	if (buf->dp_crc != crc8(crc_table, &buf->dp_msb, 0x2, CRC8_INIT_VALUE)) {
> +		dev_err(&client->dev, "CRC error for pressure\n");
> +		return -EIO;
> +	}
> +
> +	if (buf->tmp_crc != crc8(crc_table, &buf->tmp_msb, 0x2, CRC8_INIT_VALUE)) {
> +		dev_err(&client->dev, "CRC error for temperature\n");
> +		return -EIO;
> +	}
> +
> +	if (buf->sf_crc != crc8(crc_table, &buf->sf_msb, 0x2, CRC8_INIT_VALUE)) {
> +		dev_err(&client->dev, "CRC error for scale\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adp810_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct adp810_data *data = iio_priv(indio_dev);
> +	struct adp810_read_buf buf = {0};
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = adp810_measure(data, &buf);
> +	mutex_unlock(&data->lock);
> +
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Failed to read from device\n");
It's normally more informative to use the parent dev for error messages.
data->client->dev here.
Probably add a local variable struct device *dev, to avoid making the dev_err() lines
even longer.

> +		return ret;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			*val = buf.dp_msb << 8 | buf.dp_lsb;

They are next to each other so either treating them as a small array or
I think you can even make the be16 you can use
			*val = get_unaligned_be16(buf.dp);
for all 3 similar cases.  1st and 3rd are actually aligned but
lets not rely on that.

> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			*val = buf.tmp_msb << 8 | buf.tmp_lsb;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			*val = buf.sf_msb << 8 | buf.sf_lsb;
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			*val = 200;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}

> +static int adp810_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *dev_id = i2c_client_get_device_id(client);
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct adp810_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
Andy mentioned this.  I used not to care about mutex debugging in IIO drivers
as in most cases lifetimes of the containing structure are so closely aligned
to the mutex it wasn't worth the extra debugging provided by mutex_destroy().

Now we can do
	ret = devm_mutex_init(&data->lock);
	if (ret)
		return ret;

It's so easy I would like to see it used in all new code even when the
gain is very small.

> +
> +	indio_dev->name = dev_id->name;

Just set it to "adp810" here.  We can add more complex handling when the driver
supports additional parts.  The advantage of an explicit string for now is
we don't have to think about what it can be.

> +	indio_dev->channels = adp810_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adp810_channels);
> +	indio_dev->info = &adp810_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register IIO device\n");
> +
> +	return ret;
return 0; 

As that clearly indicates to the reader that you can't get here in an error case.

> +}


