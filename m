Return-Path: <linux-iio+bounces-7997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B0F93E5DE
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A591F214C7
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D7656B81;
	Sun, 28 Jul 2024 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGu3J8UF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84C47F6B;
	Sun, 28 Jul 2024 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180517; cv=none; b=jci7jl97x9DlDf9W5w3y+lySjEnrByH975/wrhN0dSvSv3RLMnxCRbmmjWJ+rtSPW6XBE3oFqImBK9jJmQxgNwwMYxMNDgJUKijfDxf/sqY6mHQ6sOi+dkPCF+BnSirWtn0S4PS+5Lm9NNfHHzwJvIqyDJLG0mS2yFaCcw1W3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180517; c=relaxed/simple;
	bh=C8GVXeI1Gt1K6GoxCquQ+a0F+j83p8v7uKm+CXsEl2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZj4MMqtpJ4Pa9yWbHwF/tBg8ruFIvsYuhMyKICAxvgbacQtOdp1CYDPbslbdiCkExCSi0Yet0P00MUwNbM3tGM9jUWVvUZ6cAZ1erwqXcj4V0SkhBwpEZ01Nl/Rp5W+GGfOnmzxd0x+DH/RSokSMzfbYI8HdsOKJZ1XWF0xVf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGu3J8UF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1E3C116B1;
	Sun, 28 Jul 2024 15:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722180516;
	bh=C8GVXeI1Gt1K6GoxCquQ+a0F+j83p8v7uKm+CXsEl2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YGu3J8UFox5vhGu40TJg76U28BxKhBmLfiDb2V2Fo32bU8WL9odw5IsNMI1uNHFh5
	 EEvdjCmd6HBowdA74PHQZVfgSGxJpmZwBHDCh8Dkn1H0MRnOguffww9+aZzfU7aLqS
	 9+kq40hW83wxM7REdgLOA9gfJKpYT0AtLD+MVgUYJ2srFSPe1IH55LjpO75ZdbXqnc
	 95tHf3M7QV/05qjAq3QEvY6KhQJOeB8a0dZ+thc455PwmvDFsafgX4PWMXiCh6RwXN
	 3OnNQhFvg1C9s4MDMR+STb8FboNNe7Zb0VkEsuywbMVXm27dllT/Lqexu8J7NCWi+W
	 DwBaB+UqN+21g==
Date: Sun, 28 Jul 2024 16:28:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>
Cc: pd.pstoykov@gmail.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: pressure: Add driver for Sensirion SDP500
Message-ID: <20240728162828.3c9cc118@jic23-huawei>
In-Reply-To: <20240725-mainline_sdp500-v4-2-ea2f5b189958@gmail.com>
References: <20240725-mainline_sdp500-v4-0-ea2f5b189958@gmail.com>
	<20240725-mainline_sdp500-v4-2-ea2f5b189958@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 17:37:28 +0200
Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org> wrote:

> From: Petar Stoykov <pd.pstoykov@gmail.com>
> 
> Sensirion SDP500 is a digital differential pressure sensor. The sensor is
> accessed over I2C.
> 
> Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
Hi Petar,

Some really trivial things inline + Krzysztof's comment.

Rather than go around again, I'll tidy them up as follows and apply this series
to the testing branch of iio.git

Thanks,

Jonathan


diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp500.c
index 77d7e68f5dea..6ff32e3fa637 100644
--- a/drivers/iio/pressure/sdp500.c
+++ b/drivers/iio/pressure/sdp500.c
@@ -62,7 +62,7 @@ static int sdp500_read_raw(struct iio_dev *indio_dev,
 
                received_crc = rxbuf[2];
                calculated_crc = crc8(sdp500_crc8_table, rxbuf,
-                       sizeof(rxbuf) - 1, 0x00);
+                                     sizeof(rxbuf) - 1, 0x00);
                if (received_crc != calculated_crc) {
                        dev_err(data->dev,
                                "calculated crc = 0x%.2X, received 0x%.2X",
@@ -123,7 +123,7 @@ static int sdp500_probe(struct i2c_client *client)
        i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
 
        ret = devm_iio_device_register(dev, indio_dev);
-       if (ret < 0)
+       if (ret)
                return dev_err_probe(dev, ret, "Failed to register indio_dev");
 
        return 0;
@@ -137,7 +137,6 @@ MODULE_DEVICE_TABLE(i2c, sdp500_id);
 
 static const struct of_device_id sdp500_of_match[] = {
        { .compatible = "sensirion,sdp500" },
-       { .compatible = "sensirion,sdp510" },
        { }
 };
 MODULE_DEVICE_TABLE(of, sdp500_of_match);

>  st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
> diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp500.c
> new file mode 100644
> index 000000000000..77d7e68f5dea
> --- /dev/null
> +++ b/drivers/iio/pressure/sdp500.c
> @@ -0,0 +1,157 @@
...

> +
> +static int sdp500_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	int ret;
> +	u8 rxbuf[SDP500_READ_SIZE];
> +	u8 received_crc, calculated_crc;
> +	struct sdp500_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = to_i2c_client(data->dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to receive data");
> +			return ret;
> +		}
> +		if (ret != SDP500_READ_SIZE) {
> +			dev_err(data->dev, "Data is received wrongly");
> +			return -EIO;
> +		}
> +
> +		received_crc = rxbuf[2];
> +		calculated_crc = crc8(sdp500_crc8_table, rxbuf,
> +			sizeof(rxbuf) - 1, 0x00);

align just after (

> +		if (received_crc != calculated_crc) {
> +			dev_err(data->dev,
> +				"calculated crc = 0x%.2X, received 0x%.2X",
> +				calculated_crc, received_crc);
> +			return -EIO;
> +		}
> +
> +		*val = get_unaligned_be16(rxbuf);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1;
> +		*val2 = 60;
> +
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info sdp500_info = {
> +	.read_raw = &sdp500_read_raw,
> +};
> +
> +static int sdp500_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct sdp500_data *data;
> +	struct device *dev = &client->dev;
> +	int ret;
> +	u8 rxbuf[SDP500_READ_SIZE];
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			"Failed to get and enable regulator\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	/* has to be done before the first i2c communication */
> +	crc8_populate_msb(sdp500_crc8_table, SDP500_CRC8_POLYNOMIAL);
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = dev;
> +
> +	indio_dev->name = "sdp500";
> +	indio_dev->channels = sdp500_channels;
> +	indio_dev->info = &sdp500_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = ARRAY_SIZE(sdp500_channels);
> +
> +	ret = sdp500_start_measurement(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to start measurement");
> +
> +	/* First measurement is not correct, read it out to get rid of it */
> +	i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret < 0)
if (ret) is more consistent with other handling in the driver (and my preference
in general for checking IIO core code calls).

> +		return dev_err_probe(dev, ret, "Failed to register indio_dev");
> +
> +	return 0;
> +}

