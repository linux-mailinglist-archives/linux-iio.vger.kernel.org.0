Return-Path: <linux-iio+bounces-9578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0499979216
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31442834FB
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21DD1D017C;
	Sat, 14 Sep 2024 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQlA7rhQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6537DD530;
	Sat, 14 Sep 2024 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726331558; cv=none; b=iKrQ86VxsstNzVUvqWu+Zw4kzdc2ps9nxt9SO3tdPMuPu/TEYCRNIzEedOcld2OAOx4y/L6SP3lBokpmCTh4Y2MvbAWiGkBVB3RAp47V+ACQb2eJT1nukzfz/YB8dcIjHK9hTqxFLBzIuwq1nyQbACMbYfqhbZKWVb1BDcyD/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726331558; c=relaxed/simple;
	bh=lGEgAqiWM82/fxJHrOZwIMXOzotXa5a0IT2KSUG5R/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2h8e+AZhndLNQ0H0eo+jy4An4oNRbFAUI8cFqqOOG+8k/oyZsvuHMxD8epX3lW64U33YRHshpFZzNCOF7IOKc8o379GQcrQqMPymOJ7Ov75BPA3eTrPMs5ZPgKR/YZ+naOliPJCUW+ZyZGXu2iDlE8KbFY8ljteAS7g5sav588=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQlA7rhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA47C4CEC0;
	Sat, 14 Sep 2024 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726331557;
	bh=lGEgAqiWM82/fxJHrOZwIMXOzotXa5a0IT2KSUG5R/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pQlA7rhQylyLjupwys5PcaO7OdFL4k/ZIRYvdu0D+ck6FZEETP+VtqHCTEyLCDYDQ
	 UIQsS0RHTjndkg2nfSTkUkuGUMvJOvhVbnWl4o6h+Ai00QLXfSRvWeqdiGjCpbWf2u
	 9fUBF6LIO/rJaLFajYV6nXnXI31LOvV/YUeFLFDopFHDZItkCfzagXTYafHySCu/up
	 VOx3W3X7EqbqlLn9sOs/BgRib7hMHetT/2iYGZC/e4llI02aHJAwbrS+O+aNt8CYu8
	 unguiMZtvPyIQmi9qdZRVnCVA2ZDPGfDHvfbLKMA94fKNFW5Z3b/DZvJ2EQWsRYX35
	 YrEKHuZifVvBw==
Date: Sat, 14 Sep 2024 17:32:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Jianping.Shen@de.bosch.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Christian.Lorenz3@de.bosch.com>, <Ulrike.Frauendorf@de.bosch.com>,
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v7 2/2] iio: imu: smi240: add driver
Message-ID: <20240914173229.57548005@jic23-huawei>
In-Reply-To: <20240913100011.4618-3-Jianping.Shen@de.bosch.com>
References: <20240913100011.4618-1-Jianping.Shen@de.bosch.com>
	<20240913100011.4618-3-Jianping.Shen@de.bosch.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Sep 2024 12:00:11 +0200
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

Hi Shen,

I suspect I led you astray.  regmap core seems unlikely to feed us
little endian buffers on writes (they should be CPU endian I think)
so there should be memcpy() for that not a get_unaligned_le16()

A few other minor comments inline that I missed before.
I'd probably have just tidied those up whilst applying if it wasn't
for the above question.

Jonathan


> diff --git a/drivers/iio/imu/smi240.c b/drivers/iio/imu/smi240.c
> new file mode 100644
> index 00000000000..892e14f3f60
> --- /dev/null
> +++ b/drivers/iio/imu/smi240.c
> @@ -0,0 +1,611 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2024 Robert Bosch GmbH.
> + */
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
Conventionally this goes..
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>

here.

> +
> +#include <asm/unaligned.h>
> +
> +#define SMI240_CHIP_ID 0x0024
> +
> +#define SMI240_SOFT_CONFIG_EOC_MASK BIT_MASK(0)
> +#define SMI240_SOFT_CONFIG_GYR_BW_MASK BIT_MASK(1)
BIT() only

You aren't applying these to a kernel bitmap which is an array
of unsigned longs (hence these macros have % BITS_PER_LONG
which makes no sense here).

> +#define SMI240_SOFT_CONFIG_ACC_BW_MASK BIT_MASK(2)
> +#define SMI240_SOFT_CONFIG_BITE_AUTO_MASK BIT_MASK(3)
> +#define SMI240_SOFT_CONFIG_BITE_REP_MASK GENMASK(6, 4)
> +
> +#define SMI240_CHIP_ID_REG 0x00
> +#define SMI240_SOFT_CONFIG_REG 0x0A
> +#define SMI240_TEMP_CUR_REG 0x10
> +#define SMI240_ACCEL_X_CUR_REG 0x11
> +#define SMI240_GYRO_X_CUR_REG 0x14
> +#define SMI240_DATA_CAP_FIRST_REG 0x17
> +#define SMI240_CMD_REG 0x2F
> +
> +#define SMI240_SOFT_RESET_CMD 0xB6
> +
> +#define SMI240_BITE_SEQUENCE_DELAY_US 140000
> +#define SMI240_FILTER_FLUSH_DELAY_US 60000
> +#define SMI240_DIGITAL_STARTUP_DELAY_US 120000
> +#define SMI240_MECH_STARTUP_DELAY_US 100000
> +
> +#define SMI240_CRC_INIT 0x05
> +#define SMI240_CRC_POLY 0x0B
> +#define SMI240_BUS_ID 0x00
> +
> +#define SMI240_SD_BIT_MASK 0x80000000
> +#define SMI240_CS_BIT_MASK 0x00000008
BIT() as mentioned below for these as well.

> +
> +#define SMI240_BUS_ID_MASK GENMASK(31, 30)
> +#define SMI240_WRITE_ADDR_MASK GENMASK(29, 22)
> +#define SMI240_WRITE_BIT_MASK 0x00200000
> +#define SMI240_WRITE_DATA_MASK GENMASK(18, 3)
> +#define SMI240_CAP_BIT_MASK 0x00100000

BIT(20) ?
Same for other single bit masks.

> +#define SMI240_READ_DATA_MASK GENMASK(19, 4)
> +
> +/* T=C2=B0C =3D (temp / 256) + 25 */
> +#define SMI240_TEMP_OFFSET 6400   // 25 * 256
> +#define SMI240_TEMP_SCALE 3906250 // (1 / 256) * 1e9
> +
> +#define SMI240_ACCEL_SCALE 500  // (1 / 2000) * 1e6
> +#define SMI240_GYRO_SCALE 10000 // (1 /  100) * 1e6


Even in this case, use traditional /* */ style comments.

> +

> +}
> +
> +static int smi240_regmap_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	u8 reg_addr;
> +	u16 reg_data;
> +	u32 request;
> +	struct spi_device *spi =3D context;
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(&spi->dev);
> +	struct smi240_data *iio_priv_data =3D iio_priv(indio_dev);
> +
> +	if (count < 2)
> +		return -EINVAL;
> +
> +	reg_addr =3D ((u8 *)data)[0];
> +	reg_data =3D get_unaligned_le16(&((u8 *)data)[1]);

Why is the regmap core giving us an le16?
I probably sent you wrong way with this earlier :(
memcpy probably the correct choice here.


> +
> +	request =3D FIELD_PREP(SMI240_BUS_ID_MASK, SMI240_BUS_ID);
> +	request |=3D FIELD_PREP(SMI240_WRITE_BIT_MASK, 1);
> +	request |=3D FIELD_PREP(SMI240_WRITE_ADDR_MASK, reg_addr);
> +	request |=3D FIELD_PREP(SMI240_WRITE_DATA_MASK, reg_data);
> +	request |=3D smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> +
> +	iio_priv_data->spi_buf =3D cpu_to_be32(request);
> +
> +	return spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
> +}

