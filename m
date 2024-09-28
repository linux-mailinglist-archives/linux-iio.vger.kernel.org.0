Return-Path: <linux-iio+bounces-9850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F869890A8
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 19:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20E21F21749
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699D5381A;
	Sat, 28 Sep 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHLdmlC8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9796B1755C;
	Sat, 28 Sep 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727543489; cv=none; b=oJ2Edme1/hbtMRRkkLL7SnVpAjtQJ7NtJb+OxRS3tZFSpcnzggitG7spqqElHzKLfSOfrtSW+0IaDfX2C3nJhkdmqqAt+Fsld9napP4aRC9r1dOx8r3G19nkBeJME2hTZYQhtvumcxwyM7c2Budsz3vObBUGf6K6vcLl6K+dXuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727543489; c=relaxed/simple;
	bh=hwBbv+gqJx570oJqh9my+jWcN57dgOBGoUYfFkoRYjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZoAxTV7ZKA/aAQbDnCA5X3JQ1QYZvfQmVVZEEW6b84Mval2Zqh+U3jS6AIwmgIMAwFRKZ91hMT1eqmAJi+yZWLdmyW8XC521T6X+J0cAtBh9I8mroNhJnjHuJ3xGL4GnbWcNk9YZJDekj6cBc71UNg0OR+y9OPsm9rjyoITC9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHLdmlC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A541C4CEC3;
	Sat, 28 Sep 2024 17:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727543489;
	bh=hwBbv+gqJx570oJqh9my+jWcN57dgOBGoUYfFkoRYjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HHLdmlC8WLTHPwKgaP12x8qz9BX9/OAe+M49DzrW+ZW9PCX7f5zKJpNQZQoU9d2VO
	 qc3U0/wl+Ie3+5HNAB4Zk+/lwgGdU0oQFlKnUVgn46+7JhxvJ4VV1UbOzRprIcWtQy
	 cG4dUFjdeCO1QFBmaFASVHbdeX/BJ9pLxcmWleL2s7R78j7GQk7pqLdzFduuKmEuW7
	 mArf/ia5xASArplsJhlD6JS9aq5BiWjRGnYswHhUDdiZ7WXK8oQyjYYYGuLzCOfB0J
	 D9HUg0565tbj997wVAB3RWSL7uV4U5GhEKH4GoGY7k+ccWnR1trDQtiNoqkrZtUYsV
	 9iTj8bvk4vIfQ==
Date: Sat, 28 Sep 2024 18:11:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Jianping.Shen@de.bosch.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Christian.Lorenz3@de.bosch.com>, <Ulrike.Frauendorf@de.bosch.com>,
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v8 2/2] iio: imu: smi240: add driver
Message-ID: <20240928181121.0e62f0ad@jic23-huawei>
In-Reply-To: <20240923124017.43867-3-Jianping.Shen@de.bosch.com>
References: <20240923124017.43867-1-Jianping.Shen@de.bosch.com>
	<20240923124017.43867-3-Jianping.Shen@de.bosch.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Sep 2024 14:40:17 +0200
<Jianping.Shen@de.bosch.com> wrote:

> From: Shen Jianping <Jianping.Shen@de.bosch.com>
>=20
> add the iio driver for bosch imu smi240. The smi240 is a combined
> three axis angular rate and three axis acceleration sensor module
> with a measurement range of +/-300=C2=B0/s and up to 16g. A synchronous
> acc and gyro sampling can be triggered by setting the capture bit
> in spi read command.
>=20
> Implemented features:
> * raw data access for each axis through sysfs
> * tiggered buffer for continuous sampling
> * synchronous acc and gyro data from tiggered buffer
>=20
> Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>
At least one endian issue remaining ;( =20

Make sure you run at least C=3D1 builds before sending patches to the list
  CHECK   drivers/iio/imu/smi240.c
drivers/iio/imu/smi240.c:223:14: warning: incorrect type in assignment (dif=
ferent base types)
drivers/iio/imu/smi240.c:223:14:    expected unsigned short [usertype]
drivers/iio/imu/smi240.c:223:14:    got restricted __le16 [usertype]


> +
> +static int smi240_regmap_spi_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	int ret;
> +	u32 request, response;
> +	u16 *val =3D val_buf;
> +	struct spi_device *spi =3D context;
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(&spi->dev);
> +	struct smi240_data *iio_priv_data =3D iio_priv(indio_dev);
> +
> +	if (reg_size !=3D 1 || val_size !=3D 2)
> +		return -EINVAL;
> +
> +	request =3D FIELD_PREP(SMI240_WRITE_BUS_ID_MASK, SMI240_BUS_ID);
> +	request |=3D FIELD_PREP(SMI240_WRITE_CAP_BIT_MASK, iio_priv_data->captu=
re);
> +	request |=3D FIELD_PREP(SMI240_WRITE_ADDR_MASK, *(u8 *)reg_buf);
> +	request |=3D smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> +
> +	iio_priv_data->spi_buf =3D cpu_to_be32(request);
> +
> +	/*
> +	 * SMI240 module consists of a 32Bit Out Of Frame (OOF)
> +	 * SPI protocol, where the slave interface responds to
> +	 * the Master request in the next frame.
> +	 * CS signal must toggle (> 700 ns) between the frames.
> +	 */
> +	ret =3D spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D spi_read(spi, &iio_priv_data->spi_buf, sizeof(response));
> +	if (ret)
> +		return ret;
> +
> +	response =3D be32_to_cpu(iio_priv_data->spi_buf);
> +
> +	if (!smi240_sensor_data_is_valid(response))
> +		return -EIO;
> +
> +	*val =3D cpu_to_le16(FIELD_GET(SMI240_READ_DATA_MASK, response));
So this is line sparse doesn't like which is reasonable given you are forci=
ng
an le16 value into a u16.=20
Minimal fix is just to change type of val to __le16 *

I still find the endian handling in here mess and am not convinced
the complexity is strictly necessary or correct.

I'd expect the requirements of reordering to be same in read and write
directions (unless device is really crazy), so why do we need
a conversion to le16 here but not one from le16 in the write?


> +
> +	return 0;
> +}
> +
> +static int smi240_regmap_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	u8 reg_addr;
> +	u16 reg_data;
> +	u32 request;
> +	const u8 *data_ptr =3D data;
> +	struct spi_device *spi =3D context;
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(&spi->dev);
> +	struct smi240_data *iio_priv_data =3D iio_priv(indio_dev);
> +
> +	if (count < 2)
> +		return -EINVAL;
> +
> +	reg_addr =3D data_ptr[0];
> +	memcpy(&reg_data, &data_ptr[1], sizeof(reg_data));
> +
> +	request =3D FIELD_PREP(SMI240_WRITE_BUS_ID_MASK, SMI240_BUS_ID);
> +	request |=3D FIELD_PREP(SMI240_WRITE_BIT_MASK, 1);
> +	request |=3D FIELD_PREP(SMI240_WRITE_ADDR_MASK, reg_addr);
> +	request |=3D FIELD_PREP(SMI240_WRITE_DATA_MASK, reg_data);

This is built as fields in a native 32 bit register.
My gut feeling is that you don't want the REGMAP_ENDIAN_LITTLE but
rather use REGMAP_ENDIAN_NATIVE.

The explicit reorder to be32 is fine though as that is just
switching from the this native endian value to the byte ordering on
the bus.

> +	request |=3D smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> +
> +	iio_priv_data->spi_buf =3D cpu_to_be32(request);
> +
> +	return spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
> +}
> +
> +static const struct regmap_bus smi240_regmap_bus =3D {
> +	.read =3D smi240_regmap_spi_read,
> +	.write =3D smi240_regmap_spi_write,
> +};
> +
> +static const struct regmap_config smi240_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 16,
> +	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> +};

