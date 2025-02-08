Return-Path: <linux-iio+bounces-15170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A4A2D6E9
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 16:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062253A7F9E
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E12500AB;
	Sat,  8 Feb 2025 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vif3bfRS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A1248189;
	Sat,  8 Feb 2025 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739029044; cv=none; b=Ns1MSTKDwpAK/p1SaMWAI2cKwFbT7ybe0qqbc8iCbQ7BXgXa8xJQ28kTlBrfiSbnuqnAJzpZ4kTX8TV5Y35ObePgEom3EGXLTNshFNbW4U6eoh+/Ljti4H2CNtmzWbU8NbhKJEhmMYvOGjEPpX8Lr4YLCNIpxDqxSi1rNDK/Vdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739029044; c=relaxed/simple;
	bh=Of+FGUU0azeEe6zTrINmA8le2Fyns8jIwH2YV16Evw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4EIiyk1dvzFvxKhj9OjPipgs/TzKy3z1D4BPZTGSNINxBzyQ/s8+6nnrO67xVl92KJykZbwyM5w4HnxyxQBEychYQYLXFwwYSzneSnSTVRtNQFMi6GSn5FgjFBJ92AmEc+5mFNZyX03M9Fbn6Lit5bi7KvgH7BYlGMdd3bGxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vif3bfRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC23C4CED6;
	Sat,  8 Feb 2025 15:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739029043;
	bh=Of+FGUU0azeEe6zTrINmA8le2Fyns8jIwH2YV16Evw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vif3bfRSrPNw2Umvi9C0qjS5yIc4f5Z3n9moXOcAtztVXReVQLp8hhq6rDc29yWQH
	 lzovMkJ7Optg9TPz4jDXGqEUU0+S6xnIHL4LKlip6Zdpo1FADS4QnIVAFV0u1GLZ0c
	 5GqCbjtz2zhmuPUnewe5kFNcE6PCR3eeAoj/eP7qFeWhT81TQnpXtUIadrRhLn0yp6
	 D/QAeftRnMyFdJij9MUmjsuVK+k8qVpjPDpPA69Xm+AcE9MUbCeD34/p+NIIwGvh+O
	 EI3K4WjuNMbJCu0w9spHcvREVewZ7YMxVqQYxoYKHjcNWk74RzRfVHJxMs2vgAHqrm
	 JanDAaqLRQKeQ==
Date: Sat, 8 Feb 2025 15:37:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Nuno Sa
 <nuno.sa@analog.com>, Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, Paul
 Cercueil <paul@crapouillou.net>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 5/6] iio: imu: adis16550: add adis16550 support
Message-ID: <20250208153711.1e0215d1@jic23-huawei>
In-Reply-To: <20250204143612.85939-6-robert.budai@analog.com>
References: <20250204143612.85939-1-robert.budai@analog.com>
	<20250204143612.85939-6-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Feb 2025 16:36:09 +0200
Robert Budai <robert.budai@analog.com> wrote:

> The ADIS16550 is a complete inertial system that includes a triaxis
> gyroscope and a triaxis accelerometer. Each inertial sensor in the
> ADIS16550 combines industry leading MEMS only technology with signal
> conditioning that optimizes dynamic performance. The factory calibration
> characterizes each sensor for sensitivity, bias, and alignment. As a
> result, each sensor has its own dynamic compensation formulas that
> provide accurate sensor measurements.
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>

A few minor comments inline given you will need to do a v7 for
the DT feedback.  Otherwise I might just have tweaked these
whilst applying.


> diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
> new file mode 100644
> index 000000000000..b20dc850346f
> --- /dev/null
> +++ b/drivers/iio/imu/adis16550.c
> @@ -0,0 +1,1156 @@

> +
> +struct adis16550 {
> +	const struct adis16550_chip_info *info;
> +	struct adis adis;
> +	unsigned long clk_freq_hz;
> +	u32 sync_mode;
> +	struct spi_transfer xfer[2];
> +	u8 buffer[ADIS16550_BURST_DATA_LEN + sizeof(u32)] __aligned(IIO_DMA_MIN=
ALIGN);
> +	__be32 din[2] __aligned(IIO_DMA_MINALIGN);
> +	__be32 dout[2] __aligned(IIO_DMA_MINALIGN);

In most cases only one such marking is needed.  Devices tend not to interfe=
re
with themselves and we tend not to be changing values from software in one =
of
the buffer DMA is targetting whilst the device is using the others.

So we normally just mark the first one of a set like this.  That avoids
adding a lot of padding when it is not needed.

> +};


> +
> +static int adis16550_set_gyro_filter_freq(struct adis16550 *st, int freq=
_hz)
> +{
> +	u8 en =3D 0;
> +
> +	if (freq_hz)
> +		en =3D 1;
Could save a line or two without greatly affecting readability.
Same thing applies in at least one other place.

	u8 en =3D freq_hz ? 1 : 0;


> +
> +	return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
> +				  ADIS16550_GYRO_FIR_EN_MASK,
> +				  FIELD_PREP(ADIS16550_GYRO_FIR_EN_MASK, en));
> +}

> +
> +static irqreturn_t adis16550_trigger_handler(int irq, void *p)
> +{

> +	memcpy(data, &buffer[3], (ADIS16550_SCAN_ACCEL_Z -
> +						ADIS16550_SCAN_GYRO_X + 2) *
> +						sizeof(__be32));
Strange alignment.
	memcpy(data, &buffer[3],
	       (ADIS16550_SCAN_ACCEL_Z - ADIS16550_SCAN_GYRO_X + 2) *
	       sizeof(__be32));

Is about the best I could come up with.
Good to add a comment on why the + 2 as well.

> +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}



> +static int adis16550_probe(struct spi_device *spi)
> +{
> +	u16 burst_length =3D ADIS16550_BURST_DATA_LEN;
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct adis16550 *st;
> +	struct adis *adis;
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
> +	adis =3D &st->adis;
> +	indio_dev->name =3D st->info->name;
> +	indio_dev->channels =3D st->info->channels;
> +	indio_dev->num_channels =3D st->info->num_channels;
> +	indio_dev->available_scan_masks =3D adis16550_channel_masks;
> +	indio_dev->info =3D &adis16550_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	st->adis.ops =3D &adis16550_ops;
> +	st->xfer[0].tx_buf =3D st->buffer + burst_length;
> +	st->xfer[0].len =3D 4;
> +	st->xfer[0].cs_change =3D 1;
> +	st->xfer[0].delay.value =3D 8;
> +	st->xfer[0].delay.unit =3D SPI_DELAY_UNIT_USECS;
> +	st->xfer[1].rx_buf =3D st->buffer;
> +	st->xfer[1].len =3D burst_length;
> +
> +	spi_message_init_with_transfers(&adis->msg, st->xfer, 2);
> +
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			      "Failed to get vdd regulator\n");

Totally trivial but preference is to align after ( unless the line ends
up too long. In those cases it is fine to indent just one tab more than
the line above.

Here it actually fits on one line anyway as it's exactly 80 chars.

		return dev_err_probe(dev, ret, "Failed to get vdd regulator\n");

> +
> +	ret =3D adis_init(&st->adis, indio_dev, spi, &adis16550_data);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __adis_initial_startup(&st->adis);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D adis16550_config_sync(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> +						 adis16550_trigger_handler);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	adis16550_debugfs_init(indio_dev);
> +
> +	return 0;
> +}

