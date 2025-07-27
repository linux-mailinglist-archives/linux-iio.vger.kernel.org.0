Return-Path: <linux-iio+bounces-22041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F6BB12F9E
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 15:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89EAE7AA61C
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7061212FAD;
	Sun, 27 Jul 2025 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFQaCtRC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6C63CF;
	Sun, 27 Jul 2025 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753621569; cv=none; b=NNTlRnyVpk60eUjZJVok0G9iRA7kmFduG4dCoqAJi3VjPLN5BXHr8IaclqvA2enfQ1KuQuVVM293eiNq46f5NtQU2NbpeCLQD249sb2OKcmZF1T3p9KSSHTFqMcDkjU8AJaVLfo4LMTFQe0JrDMivaZDyMclW056XyrFRaVBMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753621569; c=relaxed/simple;
	bh=/5sflx+TiCuCRKfcklV+v6YjyiJIYAxLVArUbC4Ze7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ps79sBu3E/61odUrd3GEo83x/+cSdGFb6JY8/XIxcQmd2USVR9kSzRb+ksH/bqbrJWl/Xq0ZJWi9u4d01hE+JFN9d+0hj51p1OxrU7KLRO96Fk+eX+EBvLb6fET25r/6/HaSmiLZhT0hyoKeUtc6NR2boH37VjgdS+MxWotlqcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFQaCtRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8152C4CEEB;
	Sun, 27 Jul 2025 13:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753621569;
	bh=/5sflx+TiCuCRKfcklV+v6YjyiJIYAxLVArUbC4Ze7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NFQaCtRCI38PPskV50syDjsW3S25eWfWOFvAy3iUVYWwTez2abyxxfHZLAyv5S28u
	 AKslRA9Uj8Tr9ir17DCPPFhsjxTQKRPazfGKfxv20fFyMKNstotBh/FdxnBWOi81jt
	 vCCcWxvsdvA6cMWEMklyvd8QEeLRhVUu8F2W25/zC93GXfPONvTEhhBDG3B9LK1woL
	 J1RgfRTs1lbmJdOzhmwOKCq8Spi+OaOMwl9fBRGJMX9+MSqkHTj05ZS9sYPKve3tF9
	 2SWSTCmhjOGNFmHgcKv+TAO0+ceCbmJPN1lQxrG0+6emfGcySyNaTingOOGZNdirtF
	 Vhp8lYVg0/HkQ==
Date: Sun, 27 Jul 2025 14:05:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
Message-ID: <20250727140559.1f6c1668@jic23-huawei>
In-Reply-To: <20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
	<20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Jul 2025 15:07:01 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

Hi Dixit,

Very clean driver for a v1. Nice.

> The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor

Slightly odd wrap.  Aim for 75 chars for patch descriptions.

> applications includes joysticks, control elements (white goods,
> multifunction knops), or electric meters (anti tampering) and any
> other application that requires accurate angular measurements at
> low power consumptions.
>=20
> The Sensor is configured over I2C, and as part of Sensor measurement
> data it provides 3-Axis magnetic fields and temperature core measurement.
>=20
> The driver supports raw value read and buffered input via external trigger
> to allow streaming values with the same sensing timestamp.
>=20
> The device can be configured in to different operating modes by optional
> device-tree "mode" property. Also, the temperature sensing part requires
> raw offset captured at 25=C2=B0C and that can be specified by "temp-offse=
t"
> optional device-tree property.
>=20
> While sensor has interrupt pin multiplexed with I2C SCL pin. But for bus
> configurations interrupt(INT) is not recommended, unless timing constrain=
ts
> between I2C data transfers and interrupt pulses are monitored and aligned.
>=20
> The Sensor's I2C register map and mode information is described in product
> User Manual[1].
>=20
> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/inf=
ineon-tlv493d-a1b6-datasheet-en.pdf
Tag, so in the tags block (no blank line to the SoB)
> [1] https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserM=
anual-v01_03-EN.pdf
Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserM=
anual-v01_03-EN.pdf #1

So make it a tag with a trailing comment to give the reference number.

>=20
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>


> ---
>  drivers/iio/magnetometer/Kconfig   |  14 +
>  drivers/iio/magnetometer/Makefile  |   2 +
>  drivers/iio/magnetometer/tlv493d.c | 606 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 622 insertions(+)
>=20
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/=
Kconfig
> index 3debf1320ad1..e0070dccc751 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -246,6 +246,20 @@ config SI7210
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called si7210.
> =20
> +config TLV493D
> +	tristate "Infineon TLV493D Low-Power 3D Magnetic Sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here to add support for the Infineon TLV493D-A1B6 Low-
> +	  Power 3D Megnetic Sensor.
> +
> +	  This driver can also be compiled as a module.
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called tlv493d.
> +
>  config TI_TMAG5273
>  	tristate "TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor"
>  	depends on I2C
> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer=
/Makefile
> index 9297723a97d8..39c62dd06db8 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -35,4 +35,6 @@ obj-$(CONFIG_SI7210)			+=3D si7210.o
> =20
>  obj-$(CONFIG_TI_TMAG5273)		+=3D tmag5273.o
> =20
> +obj-$(CONFIG_TLV493D)	+=3D tlv493d.o

As already noted, alphabetical.

> +
>  obj-$(CONFIG_YAMAHA_YAS530)		+=3D yamaha-yas530.o
> diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetomete=
r/tlv493d.c
> new file mode 100644
> index 000000000000..f230d6409a4b
> --- /dev/null
> +++ b/drivers/iio/magnetometer/tlv493d.c
> @@ -0,0 +1,606 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/**
> + * Driver for the Infineon TLV493D Low-Power 3D Magnetic Sensor
> + *
> + * Copyright (C) 2025 Dixit Parmar <dixitparmar19@gmail.com>
> + *

Trivial comment of the day - what does this blank line add?  I'd drop it.

> + */
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define TLV493D_RD_REG_BX	0x00
> +#define TLV493D_RD_REG_BY	0x01
> +#define TLV493D_RD_REG_BZ	0x02
> +#define TLV493D_RD_REG_TEMP	0x03
> +#define TLV493D_RD_REG_BX2	0x04
> +#define TLV493D_RD_REG_BZ2	0x05
> +#define TLV493D_RD_REG_TEMP2	0x06
> +#define TLV493D_RD_REG_RES1	0x07
> +#define TLV493D_RD_REG_RES2	0x08
> +#define TLV493D_RD_REG_RES3	0x09
> +#define TLV493D_RD_REG_MAX	0x0a
> +#define TLV493D_WR_REG_RES	0x00
> +#define TLV493D_WR_REG_MODE1	0x01
> +#define TLV493D_WR_REG_RES2	0x02
> +#define TLV493D_WR_REG_MODE2	0x03
> +#define TLV493D_WR_REG_MAX	0x04

Add a blank line here.

> +#define TLV493D_VAL_MAG_X_AXIS_MSB	GENMASK(7, 0)

Can we name these to relate them to the registers they are in?
If it's the whole register can probably just skip the mask.

> +#define TLV493D_VAL_MAG_X_AXIS_LSB	GENMASK(7, 4)
> +#define TLV493D_VAL_MAG_Y_AXIS_MSB	GENMASK(7, 0)
> +#define TLV493D_VAL_MAG_Y_AXIS_LSB	GENMASK(3, 0)
> +#define TLV493D_VAL_MAG_Z_AXIS_MSB	GENMASK(7, 0)
> +#define TLV493D_VAL_MAG_Z_AXIS_LSB	GENMASK(3, 0)
> +#define TLV493D_VAL_TEMP_MSB		GENMASK(7, 4)
> +#define TLV493D_VAL_TEMP_LSB		GENMASK(7, 0)
> +#define TLV493D_VAL_FRAME_COUNTER	GENMASK(3, 2)
> +#define TLV493D_VAL_CHANNEL	GENMASK(1, 0)
> +#define TLV493D_VAL_PD_FLAG	BIT(4)
> +#define TLV493D_RD_REG_RES1_WR_MASK	GENMASK(4, 3)
> +#define TLV493D_RD_REG_RES2_WR_MASK	GENMASK(7, 0)
> +#define TLV493D_RD_REG_RES3_WR_MASK	GENMASK(4, 0)
> +#define TLV493D_MODE1_MOD_FAST	BIT(1)
> +#define TLV493D_MODE1_MOD_LOW	BIT(0)
> +#define TLV493D_MODE2_TEMP_CTRL	BIT(7)
> +#define TLV493D_MODE2_LP_PERIOD	BIT(6)
> +#define TLV493D_MODE2_PARITY_CTRL	BIT(5)
> +
> +#define SET_BIT(b, bit)	(b |=3D bit)
> +#define CLR_BIT(b, bit)	(b &=3D ~bit)

As others have mentioned. Drop these - they aren't things a kernel reviewer=
 will
expect and just make the code harder to read as a result.

> +
> +#define TLV493D_DATA_X_GET(b)	\
> +	sign_extend32(FIELD_GET(TLV493D_VAL_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX=
]) << 4 | \
> +			(FIELD_GET(TLV493D_VAL_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4), =
11)

These are odd enough I'd make them c functions rather than macros. Burn a f=
ew lines
for better readability.=20

> +#define TLV493D_DATA_Y_GET(b)	\
> +	sign_extend32(FIELD_GET(TLV493D_VAL_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY=
]) << 4 | \
> +			FIELD_GET(TLV493D_VAL_MAG_Y_AXIS_LSB, b[TLV493D_RD_REG_BX2]), 11)
> +#define TLV493D_DATA_Z_GET(b)	\
> +	sign_extend32(FIELD_GET(TLV493D_VAL_MAG_Z_AXIS_MSB, b[TLV493D_RD_REG_BZ=
]) << 4 | \
> +			FIELD_GET(TLV493D_VAL_MAG_Z_AXIS_LSB, b[TLV493D_RD_REG_BZ2]), 11)
> +#define TLV493D_DATA_TEMP_GET(b)	\
> +	sign_extend32(FIELD_GET(TLV493D_VAL_TEMP_MSB, b[TLV493D_RD_REG_TEMP]) <=
< 8 | \
> +			FIELD_GET(TLV493D_VAL_TEMP_LSB, b[TLV493D_RD_REG_TEMP2]), 11)
> +
> +enum tlv493d_channels {
> +	AXIS_X =3D 0,
> +	AXIS_Y,
> +	AXIS_Z,
> +	TEMPERATURE,
> +};
> +
> +enum tlv493d_op_mode {
> +	TLV493D_OP_MODE_POWERDOWN =3D 0,
> +	TLV493D_OP_MODE_FAST,
> +	TLV493D_OP_MODE_LOWPOWER,
> +	TLV493D_OP_MODE_ULTRA_LOWPOWER,
> +	TLV493D_OP_MODE_MASTERCONTROLLED,
> +	TLV493D_OP_MODE_MAX,
No comma on a 'terminating entry'.  We don't want anyone to accdientally add
anything after the MAX entry.

> +};
> +
> +struct tlv493d_mode {
> +	u8 m;
> +	u32 sleep_us;
> +};
> +
> +struct tlv493d_data {
> +	struct device *dev;

Isn't this just client->dev?  If so don't bother having both.

> +	struct i2c_client *client;
> +	struct mutex lock;
Needs a comment on what data it protects.

> +	struct regmap *map;
> +	u8 mode;
> +	u8 wr_regs[TLV493D_WR_REG_MAX];
> +	s32 temp_offset;
> +};
> +
> +/*
> + * Different mode has different measurement cycle time, this time is
> + * used in deriving the sleep and timemout while reading the data from
> + * sensor in polling.
> + * Power-down mode: No measurement.
> + * Fast mode: Freq:3.3 KHz. Measurement time:305 usec.
> + * Low-power mode: Freq:100 Hz. Measurement time:10 msec.
> + * Ultra low-power mode: Freq:10 Hz. Measurement time:100 msec.
> + * Master controlled mode: Freq:3.3 Khz. Measurement time:305 usec.
> + */
> +static struct tlv493d_mode modes[TLV493D_OP_MODE_MAX] =3D {
> +	{.m =3D TLV493D_OP_MODE_POWERDOWN, .sleep_us =3D 0 },
> +	{.m =3D TLV493D_OP_MODE_FAST, .sleep_us =3D 305 },
> +	{.m =3D TLV493D_OP_MODE_LOWPOWER, .sleep_us =3D 10 * USEC_PER_MSEC },
> +	{.m =3D TLV493D_OP_MODE_ULTRA_LOWPOWER, .sleep_us =3D 100 * USEC_PER_MS=
EC },
> +	{.m =3D TLV493D_OP_MODE_MASTERCONTROLLED, .sleep_us =3D 305 },

Space before .m

> +};
> +
> +/*
> + * The datasheet mentions the sensor supports only direct byte-stream wr=
ite starting from
> + * register address 0x0. So for any modification to be made to any write=
 registers, it must
> + * be written starting from the register address 0x0.
> + * I2C write operation should not contain register address in the I2C fr=
ame, it should
> + * contains only raw byte stream for the write registers. As below,
> + * I2C Frame: |S|SlaveAddr Wr|Ack|Byte[0]|Ack|Byte[1]|Ack|.....|Sp|
> + */
> +static int tlv493d_write_all_regs(struct tlv493d_data *data)
> +{
> +	int ret;
> +
> +	if (!data || !data->client)
> +		return -EINVAL;
> +
> +	/*
> +	 * As regmap does not provide raw write API which perform I2C write wit=
hout
> +	 * specifying register address, direct i2c_master_send() API is used.
> +	 */
> +	ret =3D i2c_master_send(data->client, data->wr_regs, ARRAY_SIZE(data->w=
r_regs));

Given we have to do this, I'm a bit doubtful about regmap usage in general =
in here.
Maybe it's just not a good fit and we should stick to direct use of the i2c=
 stuff
like here?

> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to write registers. error %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tlv493d_set_operating_mode(struct tlv493d_data *data, u8 mode)
> +{
> +	if (!data)
> +		return -EINVAL;
> +
> +	u8 *reg_mode1 =3D &data->wr_regs[TLV493D_WR_REG_MODE1];
> +	u8 *reg_mode2 =3D &data->wr_regs[TLV493D_WR_REG_MODE2];
> +
> +	switch (mode) {
> +	case TLV493D_OP_MODE_POWERDOWN:
> +		CLR_BIT(*reg_mode1, TLV493D_MODE1_MOD_FAST);

As already mentioned by others, use FIELD_PREP etc.

> +		CLR_BIT(*reg_mode1, TLV493D_MODE1_MOD_LOW);
> +		break;
> +
> +	case TLV493D_OP_MODE_FAST:
> +		SET_BIT(*reg_mode1, TLV493D_MODE1_MOD_FAST);
> +		CLR_BIT(*reg_mode1, TLV493D_MODE1_MOD_LOW);
> +		break;
> +
> +	case TLV493D_OP_MODE_LOWPOWER:
> +		CLR_BIT(*reg_mode1, TLV493D_MODE1_MOD_FAST);
> +		SET_BIT(*reg_mode1, TLV493D_MODE1_MOD_LOW);
> +		SET_BIT(*reg_mode2, TLV493D_MODE2_LP_PERIOD);
> +		break;
> +
> +	case TLV493D_OP_MODE_ULTRA_LOWPOWER:
> +		CLR_BIT(*reg_mode1, TLV493D_MODE1_MOD_FAST);
> +		SET_BIT(*reg_mode1, TLV493D_MODE1_MOD_LOW);
> +		CLR_BIT(*reg_mode2, TLV493D_MODE2_LP_PERIOD);
> +		break;
> +
> +	case TLV493D_OP_MODE_MASTERCONTROLLED:
> +		SET_BIT(*reg_mode1, TLV493D_MODE1_MOD_FAST);
> +		SET_BIT(*reg_mode1, TLV493D_MODE1_MOD_LOW);
> +		break;
> +
> +	default:
> +		dev_err(data->dev, "invalid mode configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	return tlv493d_write_all_regs(data);
> +}
> +
> +static int tlv493d_get_measurements(struct tlv493d_data *data, s16 *x, s=
16 *y,
> +				s16 *z, s16 *t)
> +{
> +	u8 buff[7] =3D {0};
The 0 isn't needed and did odd things in older compilers (though only ones
we've since dropped support form.
	=3D { };

is fine.

> +	int err, ret;
> +	struct tlv493d_mode *mode;
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret =3D pm_runtime_resume_and_get(data->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	mode =3D &modes[data->mode];
> +
> +	/*
> +	 * Poll until data is valid,
> +	 * For a valid data TLV493D_VAL_CHANNEL bit of TLV493D_RD_REG_TEMP shou=
ld be set to 0.
> +	 * The sampling time depends on the sensor mode. poll 3x the time of th=
e sampling time.
> +	 */
> +	ret =3D read_poll_timeout(regmap_bulk_read, err, err ||
> +			FIELD_GET(TLV493D_VAL_CHANNEL, buff[TLV493D_RD_REG_TEMP]) =3D=3D 0,
> +			mode->sleep_us, (3 * mode->sleep_us), false, data->map, TLV493D_RD_RE=
G_BX,
> +			buff, ARRAY_SIZE(buff));
> +	if (ret) {
> +		dev_err(data->dev, "read poll timeout, error:%d", ret);
> +		goto out;
> +	}
> +	if (err) {
> +		dev_err(data->dev, "read data failed, error:%d\n", ret);
> +		ret =3D err;
> +		goto out;
> +	}
> +
> +	*x =3D TLV493D_DATA_X_GET(buff);
> +	*y =3D TLV493D_DATA_Y_GET(buff);
> +	*z =3D TLV493D_DATA_Z_GET(buff);
> +	*t =3D TLV493D_DATA_TEMP_GET(buff);
> +
> +out:
> +	pm_runtime_mark_last_busy(data->dev);

As below  This should get simpler.

Not directly relevant to this patch:

If this cycle is quiet I plan to propose some cleanup.h based handling for =
runtime
pm as it's annoying how often we need a goto for it.  The new ACQUIRE()  / =
ACQUIRE_ERR()
should work for this.=20


> +	pm_runtime_put_autosuspend(data->dev);
> +	return ret;
> +}
> +
> +static int tlv493d_init(struct tlv493d_data *data)
> +{
> +	int ret;
> +	u8 buff[TLV493D_RD_REG_MAX];
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	/*
> +	 * The sensor initialization requires below steps to be followed,
> +	 * 1. Power-up sensor.
> +	 * 2. Read and store read-registers map (0x0-0x9).
> +	 * 3. Copy values from read reserved registers to write reserved fields=
 (0x0-0x3).
> +	 * 4. Set operating mode.
> +	 * 5. Write to all registers.
> +	 */
> +	ret =3D regmap_bulk_read(data->map, TLV493D_RD_REG_BX, buff, ARRAY_SIZE=
(buff));
> +	if (ret) {
> +		dev_err(data->dev, "bulk read failed, error %d\n", ret);
> +		return ret;
> +	}
> +
> +	data->wr_regs[0] =3D 0; /* Write register 0x0 is reserved. Does not req=
uire to be updated.*/
> +	data->wr_regs[1] =3D buff[TLV493D_RD_REG_RES1] & TLV493D_RD_REG_RES1_WR=
_MASK;
> +	data->wr_regs[2] =3D buff[TLV493D_RD_REG_RES2] & TLV493D_RD_REG_RES2_WR=
_MASK;
> +	data->wr_regs[3] =3D buff[TLV493D_RD_REG_RES3] & TLV493D_RD_REG_RES3_WR=
_MASK;
> +
> +	ret =3D tlv493d_set_operating_mode(data, data->mode);
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to set operating mode\n");
> +		return ret;
> +	}
> +
> +	return ret;
return 0?

> +}
> +
> +static int tlv493d_parse_dt(struct tlv493d_data *data)
> +{
> +	struct device_node *node;
> +	u32 val =3D 0;
> +	int ret;
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	node =3D data->dev->of_node;
> +
> +	/* Optional 'mode' property to set sensor operation mode */
> +	ret =3D of_property_read_u32(node, "mode", &val);
Use accessors from property.h not, the of specific ones.

This will go away anyway (see comments on dt-bindings from others) but..

> +	if (ret < 0 || val >=3D TLV493D_OP_MODE_MAX) {
> +		/* Fallback to default mode if property is missing or invalid */
> +		data->mode =3D TLV493D_OP_MODE_MASTERCONTROLLED;
If it's invalid error out so we know we have a bad DT for default
a common pattern is.

	data->mode =3D TLV493D_OP_MODE_MASTERCONTROLLED;
	device_property_read_u32(data->dev, "mode", &data->mode);
	if (data->mode >=3D TLV493D_OP_MODE_MAX)
		return dev_err_probe()...

=09

> +	} else {
> +		data->mode =3D val;
> +	}
> +
> +	/*
> +	 * Read temperature offset (raw value at 25=C2=B0C). If not specified,
> +	 * default to 340.
> +	 */
> +	ret =3D of_property_read_u32(node, "temp-offset", &val);

As others have mentioned, this sort of calibration thing is normally a user=
space
problem unless it's coming from something wiring related?  E.g. external co=
mponents.

> +	if (ret)
> +		val =3D 340;
> +	/*
> +	 * The above is a raw offset; however, IIO expects a single effective o=
ffset.
> +	 * Since final temperature includes an additional fixed 25=C2=B0C (i.e.=
 25000 m=C2=B0C),
> +	 * we compute a combined offset using scale =3D 1100 (1.1 * 1000).
> +	 */
> +	data->temp_offset =3D -val + (s32)div_u64(25000, 1100);
> +
> +	return 0;
> +}
> +
> +static int tlv493d_read_raw(struct iio_dev *indio_dev, const struct iio_=
chan_spec *chan,

wrap to keep this under 80.  Doesn't look like it will hurt readability.

> +		int *val, int *val2, long mask)
> +{
> +	struct tlv493d_data *data =3D iio_priv(indio_dev);
> +	s16 x, y, z, t;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:

Not used.

> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D tlv493d_get_measurements(data, &x, &y, &z, &t);
> +		if (ret) {
> +			dev_err(data->dev, "failed to read sensor data\n");
> +			return ret;
> +		}
> +		/* Return raw values for requested channel */
> +		switch (chan->address) {
> +		case AXIS_X:
> +			*val =3D x;
> +			return IIO_VAL_INT;
> +		case AXIS_Y:
> +			*val =3D y;
> +			return IIO_VAL_INT;
> +		case AXIS_Z:
> +			*val =3D z;
> +			return IIO_VAL_INT;
> +		case TEMPERATURE:
> +			*val =3D t;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_MAGN:
> +			/*
> +			 * Magnetic field scale: 0.0098 mTesla (i.e. 9.8 =C2=B5T)
> +			 * Expressed as fractional: 98/10 =3D 9.8 =C2=B5T.
> +			 */
> +			*val =3D 98;
> +			*val2 =3D 10;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_TEMP:
> +			/*
> +			 * Temperature scale: 1.1 =C2=B0C per LSB, expressed as 1100 m=C2=B0C
> +			 * Returned as integer for IIO core to apply:
> +			 * temp =3D (raw + offset) * scale
> +			 */
> +			*val =3D 1.1 * MILLI;
Whilst a compiler should figure this out, maybe safer to just do 1100

> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			/*
> +			 * Temperature offset includes sensor-specific raw offset
> +			 * plus compensation for +25=C2=B0C bias in formula.
> +			 * This value is precomputed during probe/init:
> +			 * offset =3D -raw_offset + (25000 / scale)
> +			 */
> +			*val =3D data->temp_offset;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}



> +static int tlv493d_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct tlv493d_data *data;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	data->dev =3D dev;
> +	data->client =3D client;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret =3D devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	data->map =3D devm_regmap_init_i2c(client, &tlv493d_regmap_config);
> +	if (IS_ERR(data->map))
> +		return dev_err_probe(dev, PTR_ERR(data->map), "failed to allocate regi=
ster map\n");

Long line, break before the string.  For IIO we 'aim' for 80 chars
but let that slip if there is a good readability reason.


> +
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> +
> +	ret =3D tlv493d_parse_dt(data);

Rename as parse_firmware() or similar after changing to property.h.
For a case as simple as this there is no advantage in limiting the firmware
handling to DT.


> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to parse device-tree\n");
> +
> +	ret =3D tlv493d_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialized\n");
> +
> +	indio_dev->info =3D &tlv493d_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->name =3D client->name;
> +	indio_dev->channels =3D tlv493d_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(tlv493d_channels);
> +	indio_dev->available_scan_masks =3D tlv493d_scan_masks;
> +
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +			iio_pollfunc_store_time, tlv493d_trigger_handler,
> +			&tlv493d_setup_ops);

Align as per comments below.

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");
> +
> +	ret =3D pm_runtime_set_active(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 500);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	pm_runtime_mark_last_busy(dev);

By the time this lands, a series to make pm_runtime_put_autosuspend()
include a call to pm_runtime_mark_last_busy() should be upstream.
I'll hopefully remember to drop this when applying or it'll get
caught by a follow up series tidying up the ones that crossed with that
series.

> +	pm_runtime_put_autosuspend(dev);
> +
> +	ret =3D  devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "iio device register failed\n");
> +
> +	return 0;
> +}

> +static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops,
> +		tlv493d_runtime_suspend, tlv493d_runtime_resume, NULL);
Align typically as
static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops, tlv493d_runtime_suspend,
				 tlv493d_runtime_resume, NULL);

If you do have a very long line, perhaps due to a verbose parameter name
and need to not align after the ( then use just one tab more than the line
above, not 2.

> +
> +static const struct i2c_device_id tlv493d_id[] =3D {
> +	{ "tlv493d" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tlv493d_id);
> +
> +static const struct of_device_id tlv493d_of_match[] =3D {
> +	{ .compatible =3D "infineon,tlv493d-a1b6", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tlv493d_of_match);
> +
> +static struct i2c_driver tlv493d_driver =3D {
> +	.driver =3D {
> +		.name =3D "tlv493d",
> +		.of_match_table =3D tlv493d_of_match,
> +		.pm =3D pm_ptr(&tlv493d_pm_ops),
> +	},
> +	.probe =3D tlv493d_probe,
> +	.id_table =3D tlv493d_id,
> +};
> +
> +module_i2c_driver(tlv493d_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Infineon TLV493D Low-Power 3D Magnetic Sensor");
> +MODULE_AUTHOR("Dixit Parmar <dixitparmar19@gmail.com>");
>=20


