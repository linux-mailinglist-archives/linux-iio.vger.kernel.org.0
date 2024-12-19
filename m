Return-Path: <linux-iio+bounces-13673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2E69F822C
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E42B1893234
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9371A9B56;
	Thu, 19 Dec 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0Uc7HSF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC251A08D1;
	Thu, 19 Dec 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629784; cv=none; b=nV+jp6p8EbyuH9wq7G/9aez/1Go5qIK+FbUq+vlS21l8PbKksXkJ9KirP7uahwemvcRFqTKsXZm7piEPBmFr1YjO/DRB4h4+6MDEbtg8YJRgzwVapO4GcN6Cldz0MZFzcdBC/Qnuw7GQOa+p84X0MrjUsArx6JvW6FGz0smoJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629784; c=relaxed/simple;
	bh=Oh4M/Ix9SWL4XtOKV3HQnSZPRnBHPERnO8cKvi+CBeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXxUSK02A/57YO02x32aXuafIgHR/JArlWGvZfIKnbzq8zxg8AglVZBEviwZlobZvEsboXh6WCh6FWX3VMfgAf40fwWpGMoiJoNzS9RW33v8rERjh9Zumj/SpzTbzr7FqQ1p0P0Ul2fF+kHtXw0DuLgPzElP6luk3SMAfwOAFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0Uc7HSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBA7C4CED4;
	Thu, 19 Dec 2024 17:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734629783;
	bh=Oh4M/Ix9SWL4XtOKV3HQnSZPRnBHPERnO8cKvi+CBeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h0Uc7HSFKt5apJ8LXR4QsHCEnlywB119CeZK79oq0fcu8vQGS46CLTAme5A8BPcCS
	 2z3ybKXxL9mZ6kCtaQJoG7i6nyp0uOkvMsUxmmECiM8bw0wsZFlG01PQAZ1aJwGYOa
	 j1OvzahWKQROZTsTp1+N4NN1PmLuvcYOHkEv990wICKtBxFcOAkecKUjJWMxKCfrSC
	 cmZDoIwc1cQkTIQjtnlSp0+Y/nrBMEFFyg9W3fsdyk0PsSPq+xaKvp63xFmt0M54ug
	 ViAYZ4W4rvaIRqIs6AqIe8dKmvn27YHtzSpuQAsZoiEypTV2zHNPYb7qVNpqlRnjv3
	 VMMYhouGQOA6Q==
Date: Thu, 19 Dec 2024 17:36:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shen Jianping
 <Jianping.Shen@de.bosch.com>, "Alex Lanzano" <lanzano.alex@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <robi_budai@yahoo.com>
Subject: Re: [PATCH v3 6/7] iio: imu: adis16550: add adis16550 support
Message-ID: <20241219173613.7f6572aa@jic23-huawei>
In-Reply-To: <20241216144818.25344-7-robert.budai@analog.com>
References: <20241216144818.25344-1-robert.budai@analog.com>
	<20241216144818.25344-7-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Dec 2024 16:48:12 +0200
Robert Budai <robert.budai@analog.com> wrote:

> The ADIS16550 is a complete inertial system that includes a triaxis
> gyroscope and a triaxis accelerometer. Each inertial sensor in
> the ADIS16550 combines industry leading MEMS only technology
> with signal conditioning that optimizes dynamic performance. The
> factory calibration characterizes each sensor for sensitivity, bias,
> and alignment. As a result, each sensor has its own dynamic com-
> pensation formulas that provide accurate sensor measurements
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
>=20
> v3:
> - freed xbuf
> - fixed code styling related issues
> - removed the sensor type enum and used separate structures for providing=
 chip info data

Hi

A few comments inline to add to what Nuno noted.

Thanks

Jonathan


>  adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) +=3D adis_trigger.o
> diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
> new file mode 100644
> index 000000000000..6e9d98dee0d8
> --- /dev/null
> +++ b/drivers/iio/imu/adis16550.c




> +static int adis16550_update_scan_mode(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
> +{
> +	struct adis *adis =3D iio_device_get_drvdata(indio_dev);
> +	u16 burst_length =3D ADIS16550_BURST_DATA_LEN;
> +	u8 burst_cmd;
> +	u8 *tx;
> +
> +	if (*scan_mask & ADIS16550_BURST_DATA_GYRO_ACCEL_MASK)
> +		burst_cmd =3D ADIS16550_REG_BURST_GYRO_ACCEL;
> +	else
> +		burst_cmd =3D ADIS16550_REG_BURST_DELTA_ANG_VEL;
> +
> +	if (adis->xfer)
How would we be getting here if these weren't set?  Should be fine to
assume they are.

> +		memset(adis->xfer, 0, 2 * sizeof(*adis->xfer));
> +	if (adis->buffer)
> +		memset(adis->buffer, 0, burst_length + sizeof(u32));
> +
> +	tx =3D adis->buffer + burst_length;
> +	tx[0] =3D 0x00;
> +	tx[1] =3D 0x00;
> +	tx[2] =3D burst_cmd;
> +	/* crc4 is 0 on burst command */
> +	tx[3] =3D spi_crc4(get_unaligned_le32(tx));
> +
> +	adis->xfer[0].tx_buf =3D tx;
> +	adis->xfer[0].len =3D 4;
> +	adis->xfer[0].cs_change =3D 1;
> +	adis->xfer[0].delay.value =3D 8;
> +	adis->xfer[0].delay.unit =3D SPI_DELAY_UNIT_USECS;
> +	adis->xfer[1].rx_buf =3D adis->buffer;
> +	adis->xfer[1].len =3D burst_length;
> +
> +	spi_message_init_with_transfers(&adis->msg, adis->xfer, 2);
> +
> +	return 0;
> +}


...

> +static int adis16550_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct adis16550 *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->info =3D spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -EINVAL;
> +
> +	indio_dev->name =3D st->info->name;
> +	indio_dev->channels =3D st->info->channels;
> +	indio_dev->num_channels =3D st->info->num_channels;
> +	indio_dev->available_scan_masks =3D adis16550_channel_masks;
> +	indio_dev->info =3D &adis16550_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	st->adis.ops =3D &adis16550_ops;
> +
> +	struct spi_transfer *xfer_tmp =3D kcalloc(2, sizeof(*st->adis.xfer), GF=
P_KERNEL);
> +
> +	if (!xfer_tmp)
> +		return -ENOMEM;
> +
> +	void *buffer_tmp =3D kzalloc(ADIS16550_BURST_DATA_LEN + sizeof(u32),
> +				   GFP_KERNEL);
> +	if (!buffer_tmp) {
> +		kfree(st->adis.xfer);
> +		return -ENOMEM;
> +	}
> +
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret) {
> +		dev_err_probe(dev, ret,
> +			      "Failed to get vdd regulator\n");
> +		goto free_on_error;
> +	}
> +
> +	ret =3D adis_init(&st->adis, indio_dev, spi, &adis16550_data);
> +	if (ret)
> +		goto free_on_error;
> +
> +	ret =3D __adis_initial_startup(&st->adis);
> +	if (ret)
> +		goto free_on_error;
> +
> +	ret =3D adis16550_config_sync(st);
> +	if (ret)
> +		goto free_on_error;
> +
> +	ret =3D devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> +						 adis16550_trigger_handler);
> +	if (ret)
> +		goto free_on_error;
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		goto free_on_error;
> +
> +	adis16550_debugfs_init(indio_dev);
> +
> +	st->adis.xfer =3D no_free_ptr(xfer_tmp);
> +	st->adis.buffer =3D no_free_ptr(buffer_tmp);
I guess this was me explaining something badly.
You need to look at all the infrastructure in cleanup.h.
This only makes sense if you are using auto freeing of the variables
That is
	void *buffer_tmp __free(kfree) =3D
		kzalloc(ADIS16550_BURST_DATA_LEN + sizeof(u32), GFP_KERNEL);
etc
Then get rid of the kfree below as they will be freed on exiting scope if
no_free_ptr() hasn't been called on them (which sets the pointer to NULL).
Then you can avoid the goto's.

However as Nuno pointed out, devm_kzalloc() may well be a better choice.
We need alignement for DMA, but dma_kzalloc does guarantee that so it is al=
l fine.

That would also fix actually freeing these on driver remove which is curren=
tly
missing.


> +
> +	return 0;
> +
> +free_on_error:
> +	kfree(xfer_tmp);
> +	kfree(buffer_tmp);
> +
> +	return ret;
> +}

