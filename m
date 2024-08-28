Return-Path: <linux-iio+bounces-8843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877CB9628FE
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 15:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE63283BC3
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C56187FF0;
	Wed, 28 Aug 2024 13:43:39 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0731EA65;
	Wed, 28 Aug 2024 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852618; cv=none; b=hkfmhD8afX9BISR8OuFxcaA8voNR4iNQIEUroL9VmclNKs4FjSw52uDg5vM80fyGUylaZOLSSxhEo/xOpH4BheZ0DeQHDD7caI897azvwZovb8Sl2TJILEHZ4/Yk9wG9XDDrCJZWh1QPwipfbpKnZ+h8oSbOY9aLKA2W21AHtNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852618; c=relaxed/simple;
	bh=u6qjWjK4vB+eii5+rdYpZfkq8L6vXynittERchj+etE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDZ0jNB1CCBScuFE/IpCy1vTjkdKVCbYjFMxdTqaHxrGkhSBf4v/2ngBMQLwuZ6ftpESbbfxNN3GciELCCR0sHNNH/I4cVTGrKRdulE6ci/sAgG0o7HkALEWYBiqAPryI6p4+cpOGcAw2M3ZHkI63c0rgaF6khelOnvw44bwvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv5Bp35x6z6J7x9;
	Wed, 28 Aug 2024 21:40:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B649614038F;
	Wed, 28 Aug 2024 21:43:34 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 14:43:34 +0100
Date: Wed, 28 Aug 2024 14:43:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <Jianping.Shen@de.bosch.com>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Christian.Lorenz3@de.bosch.com>, <Ulrike.Frauendorf@de.bosch.com>,
	<Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v4 2/2] iio: imu: smi240: imu driver
Message-ID: <20240828144333.0000386b@Huawei.com>
In-Reply-To: <20240826140545.4085-3-Jianping.Shen@de.bosch.com>
References: <20240826140545.4085-1-Jianping.Shen@de.bosch.com>
	<20240826140545.4085-3-Jianping.Shen@de.bosch.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 26 Aug 2024 16:05:45 +0200
<Jianping.Shen@de.bosch.com> wrote:

> From: Shen Jianping <Jianping.Shen@de.bosch.com>
>=20
> This patch adds the iio driver for bosch imu smi240. The smi240
> is a combined three axis angular rate and three axis acceleration
> sensor module with a measurement range of +/-300=B0/s and up to 16g.
> Smi240 does not support interrupt. A synchronous acc and gyro
> sampling can be triggered by setting the capture bit in spi read
> command.
>=20
> Implemented features:
> * raw data access for each axis through sysfs
> * tiggered buffer for continuous sampling
> * synchronous acc and gyro data from tiggered buffer
>=20
> Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>
As per the other review, I'd really prefer this as one simple file.
I know you want to keep it looking like other IMUs, but it is a much
simpler devices, so the complexity they need is not appropriate here.

A few things inline,

Jonathan

> diff --git a/drivers/iio/imu/smi240/smi240_core.c b/drivers/iio/imu/smi24=
0/smi240_core.c
> new file mode 100644
> index 00000000000..fc0226af843
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/smi240_core.c
> @@ -0,0 +1,385 @@
...

> +#define SMI240_DATA_CHANNEL(_type, _axis, _index)              \
> +	{                                                          \
> +		.type =3D _type,                                         \
> +		.modified =3D 1,                                         \
> +		.channel2 =3D IIO_MOD_##_axis,                           \
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),          \

No scaling?  I'd expect the offset + scale for an accelerometer or gyro
channel to be well defined in the datasheet.


> +		.info_mask_shared_by_type =3D                            \
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),  \
> +		.info_mask_shared_by_type_available =3D                  \
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),  \


> diff --git a/drivers/iio/imu/smi240/smi240_spi.c b/drivers/iio/imu/smi240=
/smi240_spi.c
> new file mode 100644
> index 00000000000..d308f6407da
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/smi240_spi.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2024 Robert Bosch GmbH.
> + */
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <asm/unaligned.h>

Alphabetical order preferred.


> +static int smi240_regmap_spi_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	int ret;
> +	u32 request, response;
> +	struct spi_device *spi =3D context;
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(&spi->dev);
> +	struct smi240_data *iio_priv_data =3D iio_priv(indio_dev);
> +
> +	request =3D SMI240_BUS_ID << 30;
FIELD_PREP for this field as well (and define the mask etc).

> +	request |=3D FIELD_PREP(SMI240_CAP_BIT_MASK, iio_priv_data->capture);
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
> +	response =3D FIELD_GET(SMI240_READ_DATA_MASK, response);
> +	memcpy(val_buf, &response, val_size);
> +
> +	return 0;
> +}
> +
> +static int smi240_regmap_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	u32 request;
> +	struct spi_device *spi =3D context;
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(&spi->dev);
> +	struct smi240_data *iio_priv_data =3D iio_priv(indio_dev);
> +	u8 reg_addr =3D ((u8 *)data)[0];
> +	u16 reg_data =3D get_unaligned_le16(&((u8 *)data)[1]);
> +
> +	request =3D SMI240_BUS_ID << 30;

FIELD_PREP() for this one as well with appropriate mask.

> +	request |=3D FIELD_PREP(SMI240_WRITE_BIT_MASK, 1);
> +	request |=3D FIELD_PREP(SMI240_WRITE_ADDR_MASK, reg_addr);
> +	request |=3D FIELD_PREP(SMI240_WRITE_DATA_MASK, reg_data);
> +	request |=3D smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> +
> +	iio_priv_data->spi_buf =3D cpu_to_be32(request);
> +
> +	return spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
> +}


