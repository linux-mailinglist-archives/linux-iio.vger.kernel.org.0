Return-Path: <linux-iio+bounces-15592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFFEA37610
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F43B16C2B5
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B514719CC28;
	Sun, 16 Feb 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RywDD3Yu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64039450FE;
	Sun, 16 Feb 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724906; cv=none; b=B7pxsd61/7enm8YM4SGNz6uIb8zd5FGyZCaeX3feGNVJnoWTnV5uRgaiLVKJ5Y+RbP/utian9//jr44tT1IvZSNBDhY0ETLc/o/oLUqBQVv4OuOyMDskwBXbt8Y5yCAYLfOI0Z8h+AB+Hv1JsX4Klen2b1uIX/1dXCia99eXxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724906; c=relaxed/simple;
	bh=040YWPfU812dBBfsyyc5rB2JzQPPBMjqTd3jw1rGJpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmswQ/3vawR6iRS0OHRJIEk9NDCdFE+3twvLVZhnckA4cD6HbdTEQxJ7AkyeaHKnfjZHqnFYTbR9dtvgSvsyLR4xPE9Hf6Cdihl/JPF0mOAcBEOrJNNVQ2QVpEgBgtnfh3OLtiNmKOSaotf0/EKuTu7BHh25udl/Yk48+8HMbnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RywDD3Yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6E3C4CEDD;
	Sun, 16 Feb 2025 16:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739724904;
	bh=040YWPfU812dBBfsyyc5rB2JzQPPBMjqTd3jw1rGJpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RywDD3Yul7zfbPJPIb+dmsBT5pVEgxPlIu5j1S9btxs/kf5DS/hj6doygrELrMijS
	 3kS43kamOrudL6WXK7XrbCs6ItvpNZg9by4xV+T6nJnSPg8INozFWPmTRlBOLqbwri
	 1F/ivYrPFrXCGs0C5WOW36P/jlTwAM/O0AktFRZhZoJPUzerVOcUe0VFp16htjhO+k
	 Wr+Dg3kSosmyXbJr6wD3pU5hqx0TaQ3nEd0QkUf8KpI60cbr7O7ErFX50/UFQlfmKc
	 neZTqplt0II58k98zAWjXc2xyvwmNcRSfxgeruhVLBuZOAsRzFl4+/R6M2FBj5V4eN
	 SUJfRfqmV0k6w==
Date: Sun, 16 Feb 2025 16:54:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Ramona
 Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] iio: imu: adis16550: add adis16550 support
Message-ID: <20250216165455.0d5d0206@jic23-huawei>
In-Reply-To: <20250211175706.276987-6-robert.budai@analog.com>
References: <20250211175706.276987-1-robert.budai@analog.com>
	<20250211175706.276987-6-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Feb 2025 19:57:02 +0200
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
> ---
>=20
> v7:
> - minor changes according to PR suggestions
List them next time.  Reviewers tend to have limited memories.

>
A few things from a fresh glance through.

Jonathan

> diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
> new file mode 100644
> index 000000000..b4a88e31c
> --- /dev/null
> +++ b/drivers/iio/imu/adis16550.c

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

Why do you need the second __aligned(IIO_DMA_MINALIGN)?
Do you access any of these buffers whilst others are in use?  If not it
should be fine to just mark the first one (Which is about avoiding overlap
with the earlier fields) and reduce the resulting padding.

> +	__be32 dout[2];
> +};

;
> +
> +static u32 adis16550_validate_crc(const u32 *buf, const u8 n_elem,
> +				  const u32 crc)
> +{
> +	int i;
> +	u32 crc_calc;
> +	u32 crc_buf[ADIS16550_BURST_N_ELEM - 2];
> +	/*
> +	 * The crc calculation of the data is done in little endian. Hence, we
> +	 * always swap the 32bit elements making sure that the data LSB is
> +	 * always on address 0...
> +	 */
> +	for (i =3D 0; i < n_elem; i++)
> +		crc_buf[i] =3D swab32(buf[i]);

Probably makes more sense to pass it in to this function as __be32 *
Also do crc32 implementations really take little endian rather than
cpu endian?  I suspect not, so my guess is you should be using
be32_to_cpu() here which will swap on little endian architectures
only.


> +
> +	crc_calc =3D crc32(~0, crc_buf, n_elem * 4);
> +	crc_calc ^=3D ~0;
> +
> +	return (crc_calc =3D=3D crc);
> +}
> +
> +static irqreturn_t adis16550_trigger_handler(int irq, void *p)
> +{
> +	u32 crc;
> +	int ret;
> +	u16 dummy;
> +	bool valid;
> +	struct iio_poll_func *pf =3D p;
> +	__be32 data[ADIS16550_MAX_SCAN_DATA];
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct adis16550 *st =3D iio_priv(indio_dev);
> +	struct adis *adis =3D iio_device_get_drvdata(indio_dev);
> +	__be32 *buffer =3D (__be32 *)st->buffer;
> +
> +	ret =3D spi_sync(adis->spi, &adis->msg);
> +	if (ret)
> +		goto done;
> +	/*
> +	 * Validate the header. The header is a normal spi reply with state
> +	 * vector and crc4.
> +	 */
> +	ret =3D adis16550_spi_validate(&st->adis, buffer[0], &dummy);
> +	if (ret)
> +		goto done;
> +
> +	crc =3D be32_to_cpu(buffer[ADIS16550_BURST_N_ELEM - 1]);
> +	/* the header is not included in the crc */
> +	valid =3D adis16550_validate_crc((u32 *)&buffer[1],
Why not pass it as __be32 * ?
> +				       ADIS16550_BURST_N_ELEM - 2, crc);
> +	if (!valid) {
> +		dev_err(&adis->spi->dev, "Burst Invalid crc!\n");
> +		goto done;
> +	}
> +
> +	/* copy the temperature together with sensor data */
> +	memcpy(data, &buffer[3],
> +	       (ADIS16550_SCAN_ACCEL_Z - ADIS16550_SCAN_GYRO_X + 2) *=20
> +	       sizeof(__be32));
> +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static const unsigned long adis16550_channel_masks[] =3D {
> +	ADIS16550_BURST_DATA_GYRO_ACCEL_MASK | BIT(ADIS16550_SCAN_TEMP),
> +	ADIS16550_BURST_DATA_DELTA_ANG_VEL_MASK | BIT(ADIS16550_SCAN_TEMP),
> +	0,
This one is a terminator, so no trailing comma (unlike below)

> +};

> +
> +enum {
> +	ADIS16550_STATUS_CRC_CODE,
> +	ADIS16550_STATUS_CRC_CONFIG,
> +	ADIS16550_STATUS_FLASH_UPDATE,
> +	ADIS16550_STATUS_INERIAL,
> +	ADIS16550_STATUS_SENSOR,
> +	ADIS16550_STATUS_TEMPERATURE,
> +	ADIS16550_STATUS_SPI,
> +	ADIS16550_STATUS_PROCESSING,
> +	ADIS16550_STATUS_POWER,
> +	ADIS16550_STATUS_BOOT,
> +	ADIS16550_STATUS_WATCHDOG =3D 15,
> +	ADIS16550_STATUS_REGULATOR =3D 28,
> +	ADIS16550_STATUS_SENSOR_SUPPLY,
> +	ADIS16550_STATUS_CPU_SUPPLY,
> +	ADIS16550_STATUS_5V_SUPPLY
Trailing comma. Generally unless the value is such that nothing should ever
follow it (e.g. NULL terminators and similar), you should have trailing com=
mas.
> +};

