Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC5DCCA09
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 15:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfJENKr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 09:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbfJENKq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 09:10:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB4B9222CD;
        Sat,  5 Oct 2019 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570281044;
        bh=T/bCrkOAVYuc/lzoYyy4cZEh1gbJpPYdo8UptL4D9xA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HDAa8N/lg8cPX8W9ELhwDihvwHUHfxO1VVpck7yavc6EMWFY1ARAY8q7cH7KwKvZ8
         AWguV+0c5T1ieIxYPQtVfe452isrJWcpdOvMjIrQBetAr4QA2Lv8Tsuz8kjjDQPhAk
         cKF0FOt928aCqkEa4YgZysfHWSguw6dXufg0gLYE=
Date:   Sat, 5 Oct 2019 14:10:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Jones <rjones@gateworks.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] io: imu: Add support for the FXOS8700 IMU
Message-ID: <20191005141039.54cdbded@archlinux>
In-Reply-To: <20190918012856.18963-3-rjones@gateworks.com>
References: <20190918012856.18963-1-rjones@gateworks.com>
        <20190918012856.18963-3-rjones@gateworks.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Sep 2019 18:28:56 -0700
Robert Jones <rjones@gateworks.com> wrote:

> FXOS8700CQ is a small, low-power, 3-axis linear accelerometer and 3-axis
> magnetometer combined into a single package. The device features a
> selectable I2C or point-to-point SPI serial interface with 14-bit
> accelerometer and 16-bit magnetometer ADC resolution along with
> smart-embedded functions.
>=20
> FXOS8700CQ has dynamically selectable accelerationfull-scale ranges of
> =C2=B12 g/=C2=B14 g/=C2=B18 g and a fixed magnetic measurement range of =
=C2=B11200 =CE=BCT.
> Output data rates (ODR) from 1.563 Hz to 800 Hz are selectable by the user
> for each sensor. Interleaved magnetic and acceleration data is available
> at ODR rates of up to 400 Hz. FXOS8700CQ is available in a plastic QFN
> package and it is guaranteed to operate over the extended temperature
> range of =E2=80=9340 =C2=B0C to +85 =C2=B0C.
>=20
> TODO: Trigger and IRQ configuration support
>=20
> Datasheet:
>   http://cache.freescale.com/files/sensors/doc/data_sheet/FXOS8700CQ.pdf
>=20
> Signed-off-by: Robert Jones <rjones@gateworks.com>
Looks pretty good.  There are various bits in there you don't want until
you add buffered support and a few formatting bits and pieces but nothing
that should take long to tidy up.

One obscure issue in the regmap_bulk_read usage that will come back to
bite you if not fixed.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/Kconfig                  |   1 +
>  drivers/iio/imu/Makefile                 |   1 +
>  drivers/iio/imu/fxos8700/Kconfig         |  32 ++
>  drivers/iio/imu/fxos8700/Makefile        |   6 +
>  drivers/iio/imu/fxos8700/fxos8700.h      | 183 +++++++++++
>  drivers/iio/imu/fxos8700/fxos8700_core.c | 517 +++++++++++++++++++++++++=
++++++
>  drivers/iio/imu/fxos8700/fxos8700_i2c.c  |  75 +++++
>  drivers/iio/imu/fxos8700/fxos8700_spi.c  |  63 ++++
>  8 files changed, 878 insertions(+)
>  create mode 100644 drivers/iio/imu/fxos8700/Kconfig
>  create mode 100644 drivers/iio/imu/fxos8700/Makefile
>  create mode 100644 drivers/iio/imu/fxos8700/fxos8700.h
>  create mode 100644 drivers/iio/imu/fxos8700/fxos8700_core.c
>  create mode 100644 drivers/iio/imu/fxos8700/fxos8700_i2c.c
>  create mode 100644 drivers/iio/imu/fxos8700/fxos8700_spi.c
>=20
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index f3c7282..acfc383 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -53,6 +53,7 @@ config KMX61
> =20
>  source "drivers/iio/imu/inv_mpu6050/Kconfig"
>  source "drivers/iio/imu/st_lsm6dsx/Kconfig"
> +source "drivers/iio/imu/fxos8700/Kconfig"
> =20
>  endmenu
> =20
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> index 4a69588..edf841a 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -19,3 +19,4 @@ obj-y +=3D inv_mpu6050/
>  obj-$(CONFIG_KMX61) +=3D kmx61.o
> =20
>  obj-y +=3D st_lsm6dsx/
> +obj-y +=3D fxos8700/
> diff --git a/drivers/iio/imu/fxos8700/Kconfig b/drivers/iio/imu/fxos8700/=
Kconfig
> new file mode 100644
> index 0000000..4b98c2b
> --- /dev/null
> +++ b/drivers/iio/imu/fxos8700/Kconfig
> @@ -0,0 +1,32 @@
> +#
> +# FXOS8700 IMU driver
> +#
> +
> +config FXOS8700
> +	tristate
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER

So far I don't think you actually support triggered buffers
so bring this in when you add it.

> +
> +config FXOS8700_I2C
> +	tristate "Freescale FXOS8700 I2C driver"
> +	depends on I2C
> +	select FXOS8700
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to build support for the Freescale FXOS8700 m+g combo
> +	  sensor on I2C.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called fxos8700_i2c.
> +
> +config FXOS8700_SPI
> +	tristate "Freescale FXOS8700 SPI driver"
> +	depends on SPI
> +	select FXOS8700
> +	select REGMAP_SPI
> +	help
> +	  Say yes here to build support for the Freescale FXOS8700 m+g combo
> +	  sensor on SPI.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called fxos8700_spi.
> \ No newline at end of file

Fix that.

> diff --git a/drivers/iio/imu/fxos8700/Makefile b/drivers/iio/imu/fxos8700=
/Makefile
> new file mode 100644
> index 0000000..43ae69e
> --- /dev/null
> +++ b/drivers/iio/imu/fxos8700/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for Freescale FXOS8700 IMU
> +#
> +obj-$(CONFIG_FXOS8700) +=3D fxos8700_core.o
> +obj-$(CONFIG_FXOS8700_I2C) +=3D fxos8700_i2c.o
> +obj-$(CONFIG_FXOS8700_SPI) +=3D fxos8700_spi.o

Hmm. I wonder. Is it worth a directory?  If you keep to those 3 files, prob=
ably
not.  For now at least I'd move it down in to the base imu directory.
We tend to only add the dir when things get really messy.

> \ No newline at end of file

Add one

> diff --git a/drivers/iio/imu/fxos8700/fxos8700.h b/drivers/iio/imu/fxos87=
00/fxos8700.h
> new file mode 100644
> index 0000000..c3720e3
> --- /dev/null
> +++ b/drivers/iio/imu/fxos8700/fxos8700.h
> @@ -0,0 +1,183 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef FXOS8700_H_
> +#define FXOS8700_H_
> +
> +extern const struct regmap_config fxos8700_regmap_config;
> +
> +struct fxos8700_data {
> +	struct regmap *regmap;
> +	struct iio_trigger *trig;
> +};
> +
> +int fxos8700_core_probe(struct device *dev, struct regmap *regmap,
> +			const char *name, bool use_spi);
> +
> +void fxos8700_core_remove(struct device *dev);
> +
> +/* Register Definitions */

Are any of these used except in the main file?
If not push them all down to the c file.

> +#define FXOS8700_STATUS             0x00
> +#define FXOS8700_OUT_X_MSB          0x01
> +#define FXOS8700_OUT_X_LSB          0x02
> +#define FXOS8700_OUT_Y_MSB          0x03
> +#define FXOS8700_OUT_Y_LSB          0x04
> +#define FXOS8700_OUT_Z_MSB          0x05
> +#define FXOS8700_OUT_Z_LSB          0x06
> +#define FXOS8700_F_SETUP            0x09
> +#define FXOS8700_TRIG_CFG           0x0a
> +#define FXOS8700_SYSMOD             0x0b
> +#define FXOS8700_INT_SOURCE         0x0c
> +#define FXOS8700_WHO_AM_I           0x0d
> +#define FXOS8700_XYZ_DATA_CFG       0x0e
> +#define FXOS8700_HP_FILTER_CUTOFF   0x0f
> +#define FXOS8700_PL_STATUS          0x10
> +#define FXOS8700_PL_CFG             0x11
> +#define FXOS8700_PL_COUNT           0x12
> +#define FXOS8700_PL_BF_ZCOMP        0x13
> +#define FXOS8700_PL_THS_REG         0x14
> +#define FXOS8700_A_FFMT_CFG         0x15
> +#define FXOS8700_A_FFMT_SRC         0x16
> +#define FXOS8700_A_FFMT_THS         0x17
> +#define FXOS8700_A_FFMT_COUNT       0x18
> +#define FXOS8700_TRANSIENT_CFG      0x1d
> +#define FXOS8700_TRANSIENT_SRC      0x1e
> +#define FXOS8700_TRANSIENT_THS      0x1f
> +#define FXOS8700_TRANSIENT_COUNT    0x20
> +#define FXOS8700_PULSE_CFG          0x21
> +#define FXOS8700_PULSE_SRC          0x22
> +#define FXOS8700_PULSE_THSX         0x23
> +#define FXOS8700_PULSE_THSY         0x24
> +#define FXOS8700_PULSE_THSZ         0x25
> +#define FXOS8700_PULSE_TMLT         0x26
> +#define FXOS8700_PULSE_LTCY         0x27
> +#define FXOS8700_PULSE_WIND         0x28
> +#define FXOS8700_ASLP_COUNT         0x29
> +#define FXOS8700_CTRL_REG1          0x2a
> +#define FXOS8700_CTRL_REG2          0x2b
> +#define FXOS8700_CTRL_REG3          0x2c
> +#define FXOS8700_CTRL_REG4          0x2d
> +#define FXOS8700_CTRL_REG5          0x2e
> +#define FXOS8700_OFF_X              0x2f
> +#define FXOS8700_OFF_Y              0x30
> +#define FXOS8700_OFF_Z              0x31
> +#define FXOS8700_M_DR_STATUS        0x32
> +#define FXOS8700_M_OUT_X_MSB        0x33
> +#define FXOS8700_M_OUT_X_LSB        0x34
> +#define FXOS8700_M_OUT_Y_MSB        0x35
> +#define FXOS8700_M_OUT_Y_LSB        0x36
> +#define FXOS8700_M_OUT_Z_MSB        0x37
> +#define FXOS8700_M_OUT_Z_LSB        0x38
> +#define FXOS8700_CMP_X_MSB          0x39
> +#define FXOS8700_CMP_X_LSB          0x3a
> +#define FXOS8700_CMP_Y_MSB          0x3b
> +#define FXOS8700_CMP_Y_LSB          0x3c
> +#define FXOS8700_CMP_Z_MSB          0x3d
> +#define FXOS8700_CMP_Z_LSB          0x3e
> +#define FXOS8700_M_OFF_X_MSB        0x3f
> +#define FXOS8700_M_OFF_X_LSB        0x40
> +#define FXOS8700_M_OFF_Y_MSB        0x41
> +#define FXOS8700_M_OFF_Y_LSB        0x42
> +#define FXOS8700_M_OFF_Z_MSB        0x43
> +#define FXOS8700_M_OFF_Z_LSB        0x44
> +#define FXOS8700_MAX_X_MSB          0x45
> +#define FXOS8700_MAX_X_LSB          0x46
> +#define FXOS8700_MAX_Y_MSB          0x47
> +#define FXOS8700_MAX_Y_LSB          0x48
> +#define FXOS8700_MAX_Z_MSB          0x49
> +#define FXOS8700_MAX_Z_LSB          0x4a
> +#define FXOS8700_MIN_X_MSB          0x4b
> +#define FXOS8700_MIN_X_LSB          0x4c
> +#define FXOS8700_MIN_Y_MSB          0x4d
> +#define FXOS8700_MIN_Y_LSB          0x4e
> +#define FXOS8700_MIN_Z_MSB          0x4f
> +#define FXOS8700_MIN_Z_LSB          0x50
> +#define FXOS8700_TEMP               0x51
> +#define FXOS8700_M_THS_CFG          0x52
> +#define FXOS8700_M_THS_SRC          0x53
> +#define FXOS8700_M_THS_X_MSB        0x54
> +#define FXOS8700_M_THS_X_LSB        0x55
> +#define FXOS8700_M_THS_Y_MSB        0x56
> +#define FXOS8700_M_THS_Y_LSB        0x57
> +#define FXOS8700_M_THS_Z_MSB        0x58
> +#define FXOS8700_M_THS_Z_LSB        0x59
> +#define FXOS8700_M_THS_COUNT        0x5a
> +#define FXOS8700_M_CTRL_REG1        0x5b
> +#define FXOS8700_M_CTRL_REG2        0x5c
> +#define FXOS8700_M_CTRL_REG3        0x5d
> +#define FXOS8700_M_INT_SRC          0x5e
> +#define FXOS8700_A_VECM_CFG         0x5f
> +#define FXOS8700_A_VECM_THS_MSB     0x60
> +#define FXOS8700_A_VECM_THS_LSB     0x61
> +#define FXOS8700_A_VECM_CNT         0x62
> +#define FXOS8700_A_VECM_INITX_MSB   0x63
> +#define FXOS8700_A_VECM_INITX_LSB   0x64
> +#define FXOS8700_A_VECM_INITY_MSB   0x65
> +#define FXOS8700_A_VECM_INITY_LSB   0x66
> +#define FXOS8700_A_VECM_INITZ_MSB   0x67
> +#define FXOS8700_A_VECM_INITZ_LSB   0x68
> +#define FXOS8700_M_VECM_CFG         0x69
> +#define FXOS8700_M_VECM_THS_MSB     0x6a
> +#define FXOS8700_M_VECM_THS_LSB     0x6b
> +#define FXOS8700_M_VECM_CNT         0x6c
> +#define FXOS8700_M_VECM_INITX_MSB   0x6d
> +#define FXOS8700_M_VECM_INITX_LSB   0x6e
> +#define FXOS8700_M_VECM_INITY_MSB   0x6f
> +#define FXOS8700_M_VECM_INITY_LSB   0x70
> +#define FXOS8700_M_VECM_INITZ_MSB   0x71
> +#define FXOS8700_M_VECM_INITZ_LSB   0x72
> +#define FXOS8700_A_FFMT_THS_X_MSB   0x73
> +#define FXOS8700_A_FFMT_THS_X_LSB   0x74
> +#define FXOS8700_A_FFMT_THS_Y_MSB   0x75
> +#define FXOS8700_A_FFMT_THS_Y_LSB   0x76
> +#define FXOS8700_A_FFMT_THS_Z_MSB   0x77
> +#define FXOS8700_A_FFMT_THS_Z_LSB   0x78
> +#define FXOS8700_A_TRAN_INIT_MSB    0x79
> +#define FXOS8700_A_TRAN_INIT_LSB_X  0x7a
> +#define FXOS8700_A_TRAN_INIT_LSB_Y  0x7b
> +#define FXOS8700_A_TRAN_INIT_LSB_Z  0x7d
> +#define FXOS8700_TM_NVM_LOCK        0x7e
> +#define FXOS8700_NVM_DATA0_35       0x80
> +#define FXOS8700_NVM_DATA_BNK3      0xa4
> +#define FXOS8700_NVM_DATA_BNK2      0xa5
> +#define FXOS8700_NVM_DATA_BNK1      0xa6
> +#define FXOS8700_NVM_DATA_BNK0      0xa7
> +
> +#define SENSOR_IOCTL_BASE           'S'
> +#define SENSOR_GET_MODEL_NAME       _IOR(SENSOR_IOCTL_BASE, 0, char *)
> +#define SENSOR_GET_POWER_STATUS     _IOR(SENSOR_IOCTL_BASE, 2, int)
> +#define SENSOR_SET_POWER_STATUS     _IOR(SENSOR_IOCTL_BASE, 3, int)
> +#define SENSOR_GET_DELAY_TIME       _IOR(SENSOR_IOCTL_BASE, 4, int)
> +#define SENSOR_SET_DELAY_TIME       _IOR(SENSOR_IOCTL_BASE, 5, int)
> +#define SENSOR_GET_RAW_DATA         _IOR(SENSOR_IOCTL_BASE, 6, short[3])
> +
> +#define FXOS8700_I2C_ADDR           0x1E
> +#define FXOS8700_DEVICE_ID          0xC7
> +#define FXOS8700_PRE_DEVICE_ID      0xC4
> +#define FXOS8700_DATA_BUF_SIZE      6
> +#define FXOS8700_DELAY_DEFAULT      200 /* msecs */
> +#define FXOS8700_POSITION_DEFAULT   1   /* msecs */
> +
> +#define FXOS8700_TYPE_ACC           0x00
> +#define FXOS8700_TYPE_MAG           0x01
> +#define FXOS8700_STANDBY            0x00
> +#define FXOS8700_ACTIVE             0x01
> +#define FXOS8700_ACTIVE_MIN_USLEEP  4000 //from table 6 in datasheet
> +
> +#define ABS_STATUS                  ABS_WHEEL
> +#define FXOS8700_DRIVER             "fxos8700"
> +
> +#define ABSMAX_ACC_VAL              0x01FF
> +#define ABSMIN_ACC_VAL              -(ABSMAX_ACC_VAL)
> +#define FXOS8700_POLL_INTERVAL      400
> +#define FXOS8700_POLL_MAX           800
> +#define FXOS8700_POLL_MIN           100
> +#define FXOS8700_CTRL_ODR_MSK       0x38
> +#define FXOS8700_CTRL_ODR_MAX       0x00
> +#define FXOS8700_CTRL_ODR_MIN       (0x03 << 3)
> +
> +enum {
> +	MODE_2G =3D 0,
> +	MODE_4G,
> +	MODE_8G,
> +};
> +
> +#endif  /* FXOS8700_H_ */
> diff --git a/drivers/iio/imu/fxos8700/fxos8700_core.c b/drivers/iio/imu/f=
xos8700/fxos8700_core.c
> new file mode 100644
> index 0000000..9098980
> --- /dev/null
> +++ b/drivers/iio/imu/fxos8700/fxos8700_core.c
> @@ -0,0 +1,517 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FXOS8700 - Freescale IMU (accelerometer plus magnetometer)
> + *
> + * Copyright (c) 2019, Freescale Corporation.
> + *
> + * IIO core driver for FXOS8700, with support for I2C/SPI busses
> + *
> + * TODO: Trigger and IRQ support
> + */
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/of_irq.h>
> +#include <linux/mutex.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>

Quite a few of these aren't yet used. Drop them until you add
buffer / trigger support.

> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +
> +#include "fxos8700.h"
> +
> +/* Regmap info */
> +static const struct regmap_range read_range[] =3D {
> +	{
> +		.range_min =3D 0x00,
> +		.range_max =3D 0x18,
> +	}, {
> +		.range_min =3D 0x1d,
> +		.range_max =3D 0x78,
> +	},
> +};
> +
> +static const struct regmap_range write_range[] =3D {
> +	{
> +		.range_min =3D 0x09,

Use the defines for these rather than register addresses.
It might be easier to just use a big switch statement...


> +		.range_max =3D 0x0a,
> +	}, {
> +		.range_min =3D 0x0e,
> +		.range_max =3D 0x0f,
> +	}, {
> +		.range_min =3D 0x11,
> +		.range_max =3D 0x15,
> +	}, {
> +		.range_min =3D 0x17,
> +		.range_max =3D 0x1d,
> +	}, {
> +		.range_min =3D 0x1f,
> +		.range_max =3D 0x21,
> +	}, {
> +		.range_min =3D 0x23,
> +		.range_max =3D 0x31,
> +	}, {
> +		.range_min =3D 0x3f,
> +		.range_max =3D 0x44,
> +	}, {
> +		.range_min =3D 0x52,
> +		.range_max =3D 0x52,
> +	}, {
> +		.range_min =3D 0x54,
> +		.range_max =3D 0x5d,
> +	}, {
> +		.range_min =3D 0x5f,
> +		.range_max =3D 0x78,
> +	},
> +};
> +
> +static const struct regmap_access_table driver_read_table =3D {
> +	.yes_ranges =3D   read_range,
> +	.n_yes_ranges =3D ARRAY_SIZE(read_range),
> +};
> +
> +static const struct regmap_access_table driver_write_table =3D {
> +	.yes_ranges =3D   write_range,
> +	.n_yes_ranges =3D ARRAY_SIZE(write_range),
> +};
> +
> +const struct regmap_config fxos8700_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D FXOS8700_NVM_DATA_BNK0,
> +	.rd_table =3D &driver_read_table,
> +	.wr_table =3D &driver_write_table,
> +};
> +EXPORT_SYMBOL(fxos8700_regmap_config);
> +
> +#define FXOS8700_CHANNEL(_type, _axis, _index) {		\
> +	.type =3D _type,						\
> +	.modified =3D 1,						\
> +	.channel2 =3D IIO_MOD_##_axis,				\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |  \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +	.scan_index =3D _index,					\

So far you haven't added buffered support to the driver, so scan_*
should only be added when you do.

> +	.scan_type =3D {						\
> +		.sign =3D 's',					\
> +		.realbits =3D 16,					\
> +		.storagebits =3D 16,				\
> +		.endianness =3D IIO_LE,				\
> +	},							\
> +}
> +
> +/* scan indexes follow DATA register order */
> +enum fxos8700_scan_axis {
> +	FXOS8700_SCAN_ACCEL_X =3D 0,
> +	FXOS8700_SCAN_ACCEL_Y,
> +	FXOS8700_SCAN_ACCEL_Z,
> +	FXOS8700_SCAN_MAGN_X,
> +	FXOS8700_SCAN_MAGN_Y,
> +	FXOS8700_SCAN_MAGN_Z,
> +	FXOS8700_SCAN_RHALL,
> +	FXOS8700_SCAN_TIMESTAMP,
> +};
> +
> +enum fxos8700_sensor {
> +	FXOS8700_ACCEL	=3D 0,
> +	FXOS8700_MAGN,
> +	FXOS8700_NUM_SENSORS /* must be last */
> +};
> +
> +enum fxos8700_int_pin {
> +	FXOS8700_PIN_INT1,
> +	FXOS8700_PIN_INT2
> +};
> +
> +struct fxos8700_scale {
> +	u8 bits;
> +	int uscale;
> +};
> +
> +struct fxos8700_odr {
> +	u8 bits;
> +	int odr;
> +	int uodr;
> +};
> +
> +static const struct fxos8700_scale fxos8700_accel_scale[] =3D {
> +	{ MODE_2G, 244},
> +	{ MODE_4G, 488},
> +	{ MODE_8G, 976},
> +};
> +
> +/* Accellerometer and magnetometer have the same ODR options, set in the
> + * CTRL_REG1 register. ODR is halved when using both sensors at once in
> + * hybrid mode.
> + */
> +static const struct fxos8700_odr fxos8700_odr[] =3D {
> +	{0x00, 800, 0},
> +	{0x01, 400, 0},
> +	{0x02, 200, 0},
> +	{0x03, 100, 0},
> +	{0x04, 50, 0},
> +	{0x05, 12, 500000},
> +	{0x06, 6, 250000},
> +	{0x07, 1, 562500},
> +};
> +
> +static const struct iio_chan_spec fxos8700_channels[] =3D {
> +	FXOS8700_CHANNEL(IIO_ACCEL, X, FXOS8700_SCAN_ACCEL_X),
> +	FXOS8700_CHANNEL(IIO_ACCEL, Y, FXOS8700_SCAN_ACCEL_Y),
> +	FXOS8700_CHANNEL(IIO_ACCEL, Z, FXOS8700_SCAN_ACCEL_Z),
> +	FXOS8700_CHANNEL(IIO_MAGN, X, FXOS8700_SCAN_MAGN_X),
> +	FXOS8700_CHANNEL(IIO_MAGN, Y, FXOS8700_SCAN_MAGN_Y),
> +	FXOS8700_CHANNEL(IIO_MAGN, Z, FXOS8700_SCAN_MAGN_Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(FXOS8700_SCAN_TIMESTAMP),
> +};
> +
> +static enum fxos8700_sensor fxos8700_to_sensor(enum iio_chan_type iio_ty=
pe)
> +{
> +	switch (iio_type) {
> +	case IIO_ACCEL:
> +		return FXOS8700_ACCEL;
> +	case IIO_ANGL_VEL:
> +		return FXOS8700_MAGN;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int fxos8700_set_active_mode(struct fxos8700_data *data,
> +				    enum fxos8700_sensor t, bool mode)
> +{
> +	int ret;
> +
> +	ret =3D regmap_write(data->regmap, FXOS8700_CTRL_REG1, mode);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(FXOS8700_ACTIVE_MIN_USLEEP,
> +		     FXOS8700_ACTIVE_MIN_USLEEP + 1000);
> +
> +	return 0;
> +}
> +
> +static int fxos8700_set_scale(struct fxos8700_data *data,
> +			      enum fxos8700_sensor t, int uscale)
> +{
> +	int i;
> +	static const int scale_num =3D ARRAY_SIZE(fxos8700_accel_scale);
> +	struct device *dev =3D regmap_get_device(data->regmap);
> +
> +	if (t =3D=3D FXOS8700_MAGN) {
> +		dev_err(dev, "Magnetometer scale is locked at 1200uT\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i < scale_num; i++)
> +		if (fxos8700_accel_scale[i].uscale =3D=3D uscale)
> +			break;
> +
> +	if (i =3D=3D scale_num)
> +		return -EINVAL;
> +
> +	return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
> +			    fxos8700_accel_scale[i].bits);
> +}
> +
> +static int fxos8700_get_scale(struct fxos8700_data *data,
> +			      enum fxos8700_sensor t, int *uscale)
> +{
> +	int i, ret, val;
> +	static const int scale_num =3D ARRAY_SIZE(fxos8700_accel_scale);
> +
> +	if (t =3D=3D FXOS8700_MAGN) {
> +		*uscale =3D 1200; // Magnetometer is locked at 1200uT
> +		return 0;
> +	}
> +
> +	ret =3D regmap_read(data->regmap, FXOS8700_XYZ_DATA_CFG, &val);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < scale_num; i++)
> +		if (fxos8700_accel_scale[i].bits =3D=3D (val & 0x3)) {
> +			*uscale =3D fxos8700_accel_scale[i].uscale;
> +			return 0;
> +		}
> +
> +	return -EINVAL;
> +}
> +
> +static int fxos8700_get_data(struct fxos8700_data *data, int chan_type,
> +			     int axis, int *val)
> +{
> +	u8 base, reg;
> +	int ret;
> +	__le16 sample =3D 0;
> +	enum fxos8700_sensor type =3D fxos8700_to_sensor(chan_type);
> +	u8 tmp_data[FXOS8700_DATA_BUF_SIZE];
regmap_bulk_read can cause dma to occur directly using the buffers
provided. That can lead into the fun of cacheline corruption if
the buffer shares a cacheline with any other data.

Upshot you can't use it with a buffer on the stack.  Best solution
is normally to use __cacheline_aligned magic and put it in
private data structure for your driver (at the end so you don't
waste space by having to force following elements to yet another
cacheline).

If you don't do that you can look forward to extremely hard to
diagnose intermittent errors on some hosts. It's one of those
nightmare issues to debug :)

> +
> +	base =3D type ? FXOS8700_OUT_X_MSB : FXOS8700_M_OUT_X_MSB;
> +
> +	ret =3D regmap_bulk_read(data->regmap, base, tmp_data,
> +			       FXOS8700_DATA_BUF_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	reg =3D (axis - IIO_MOD_X) * sizeof(sample);
> +	sample =3D ((tmp_data[reg] << 8) & 0xff00) | tmp_data[reg + 1];

Superficially this looks like a endian conversion, so I'm a little
confused how we end up with another one below.  Should be able to
do that directly on tmp_data.  If it's actually an array of
__le16 then make the data type say that rather than u8.

> +	*val =3D sign_extend32(le16_to_cpu(sample), 15);
> +
> +	return 0;
> +}
> +
> +static int fxos8700_set_odr(struct fxos8700_data *data, enum fxos8700_se=
nsor t,
> +			    int odr, int uodr)
> +{
> +	int i, ret, val;
> +	bool active_mode;
> +	static const int odr_num =3D ARRAY_SIZE(fxos8700_odr);
> +
> +	ret =3D regmap_read(data->regmap, FXOS8700_CTRL_REG1, &val);
> +	if (ret)
> +		return ret;
> +
> +	active_mode =3D val & FXOS8700_ACTIVE;
> +
> +	if (active_mode) {
> +		/* The device must be in standby mode to change any of the
> +		 * other fields within CTRL_REG1

Multiline comment syntax - see below.

> +		 */
> +		ret =3D regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> +				   val & ~FXOS8700_ACTIVE);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i =3D 0; i < odr_num; i++)
> +		if (fxos8700_odr[i].odr =3D=3D odr && fxos8700_odr[i].uodr =3D=3D uodr)
> +			break;
> +
> +	if (i >=3D odr_num)
> +		return -EINVAL;
> +
> +	return regmap_update_bits(data->regmap,
> +				  FXOS8700_CTRL_REG1,
> +				  FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
> +				  fxos8700_odr[i].bits << 3 | active_mode);
> +}
> +
> +static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_se=
nsor t,
> +			    int *odr, int *uodr)
> +{
> +	int i, val, ret;
> +	static const int odr_num =3D ARRAY_SIZE(fxos8700_odr);
> +
> +	ret =3D regmap_read(data->regmap, FXOS8700_CTRL_REG1, &val);
> +	if (ret)
> +		return ret;
> +
> +	val &=3D FXOS8700_CTRL_ODR_MSK;
> +
> +	for (i =3D 0; i < odr_num; i++)
> +		if (val =3D=3D fxos8700_odr[i].bits)
> +			break;
> +
> +	if (i >=3D odr_num)
> +		return -EINVAL;
> +
> +	*odr =3D fxos8700_odr[i].odr;
> +	*uodr =3D fxos8700_odr[i].uodr;
> +
> +	return 0;
> +}
> +
> +static int fxos8700_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	int ret;
> +	struct fxos8700_data *data =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D fxos8700_get_data(data, chan->type, chan->channel2, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 0;
> +		ret =3D fxos8700_get_scale(data, fxos8700_to_sensor(chan->type),
> +					 val2);
> +		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret =3D fxos8700_get_odr(data, fxos8700_to_sensor(chan->type),
> +				       val, val2);
> +		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;

Don't think you can get here so remove the return 0.

> +}
> +
> +static int fxos8700_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct fxos8700_data *data =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return fxos8700_set_scale(data, fxos8700_to_sensor(chan->type),
> +					  val2);
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return fxos8700_set_odr(data, fxos8700_to_sensor(chan->type),
> +					val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +

Can't get here so remove the return 0.

> +	return 0;
> +}
> +
> +static IIO_CONST_ATTR(in_accel_sampling_frequency_available,
> +		      "1.5625 6.25 12.5 50 100 200 400 800");
> +static IIO_CONST_ATTR(in_magn_sampling_frequency_available,
> +		      "1.5625 6.25 12.5 50 100 200 400 800");
> +static IIO_CONST_ATTR(in_accel_scale_available, "0.000244 0.000488 0.000=
976");
> +static IIO_CONST_ATTR(in_magn_scale_available, "0.000001200");
> +
> +static struct attribute *fxos8700_attrs[] =3D {
> +	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,
> +	&iio_const_attr_in_magn_sampling_frequency_available.dev_attr.attr,
> +	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
> +	&iio_const_attr_in_magn_scale_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group fxos8700_attrs_group =3D {
> +	.attrs =3D fxos8700_attrs,
> +};
> +
> +static const struct iio_info fxos8700_info =3D {
> +	.read_raw =3D fxos8700_read_raw,
> +	.write_raw =3D fxos8700_write_raw,
> +	.attrs =3D &fxos8700_attrs_group,
> +};
> +
> +static const char *fxos8700_match_acpi_device(struct device *dev)
> +{
> +	const struct acpi_device_id *id;
> +
> +	id =3D acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!id)
> +		return NULL;
> +
> +	return dev_name(dev);
> +}
> +
> +static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
> +{
> +	int ret;
> +	unsigned int val;
> +	struct device *dev =3D regmap_get_device(data->regmap);
> +
> +	ret =3D regmap_read(data->regmap, FXOS8700_WHO_AM_I, &val);
> +	if (ret) {
> +		dev_err(dev, "Error reading chip id\n");
> +		return ret;
> +	}
> +	if (val !=3D FXOS8700_DEVICE_ID && val !=3D FXOS8700_PRE_DEVICE_ID) {
> +		dev_err(dev, "Wrong chip id, got %x expected %x or %x\n",
> +			val, FXOS8700_DEVICE_ID, FXOS8700_PRE_DEVICE_ID);
> +		return -ENODEV;
> +	}
> +
> +	ret =3D fxos8700_set_active_mode(data, FXOS8700_ACCEL, true);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D fxos8700_set_active_mode(data, FXOS8700_MAGN, true);
> +	if (ret)
> +		return ret;
> +
> +	/* The device must be in standby mode to change any of the other fields
> +	 * within CTRL_REG1
> +	 */
Most of the kernel, including IIO, uses
/*=20
 * The device...
 * ...
 */
For multiline comments.

> +	ret =3D regmap_write(data->regmap, FXOS8700_CTRL_REG1, 0x00);
> +	if (ret)
> +		return ret;
> +	// Set max oversample ratio (OSR) and both devices active
> +	ret =3D regmap_write(data->regmap, FXOS8700_M_CTRL_REG1, 0x1F);

If you can, please specify these register values as | combinations of
the bits that make them up.

> +	if (ret)
> +		return ret;
> +	// Disable and rst min/max measurements & threshold
> +	ret =3D regmap_write(data->regmap, FXOS8700_M_CTRL_REG2, 0x1c);
> +	if (ret)
> +		return ret;
> +	// Max ODR (800Hz individual or 400Hz hybrid), active mode
> +	ret =3D regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> +			   FXOS8700_CTRL_ODR_MAX + FXOS8700_ACTIVE);
> +	if (ret)
> +		return ret;
> +	// Set for max full-scale range (+/-8G)

Kernel uses /* .. */ C style comments except in very specific cases
so please swap to that throughout. Careful with SPDX though as some
of those should use //

> +	ret =3D regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG, MODE_8G);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "fxos8700 device driver init success\n");

Easy to tell this anyway as the device won't be created if it isn't.
Hence either dev_dbg or (better still) get rid of this log noise entirely.

> +	return 0;
> +}
> +
> +static void fxos8700_chip_uninit(void *data)
> +{
> +	struct fxos8700_data *fxos8700_data =3D data;
> +
> +	fxos8700_set_active_mode(fxos8700_data, FXOS8700_ACCEL, false);
> +	fxos8700_set_active_mode(fxos8700_data, FXOS8700_MAGN, false);
> +}
> +
> +int fxos8700_core_probe(struct device *dev, struct regmap *regmap,
> +			const char *name, bool use_spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct fxos8700_data *data;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +	data->regmap =3D regmap;
> +
> +	ret =3D fxos8700_chip_init(data, use_spi);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev, fxos8700_chip_uninit, data);
> +	if (ret)
> +		return ret;
> +
> +	if (!name && ACPI_HANDLE(dev))
> +		name =3D fxos8700_match_acpi_device(dev);
name is supposed to end up as the part number.  Can we not establish
that via a more direct means?=20

IIRC we recently added a label attribute to provide a 'unique' id if
that is what you are after here.

> +
> +	indio_dev->dev.parent =3D dev;
> +	indio_dev->channels =3D fxos8700_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(fxos8700_channels);
> +	indio_dev->name =3D name;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &fxos8700_info;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_GPL(fxos8700_core_probe);
> +
> +MODULE_AUTHOR("Gateworks, Inc.");
> +MODULE_DESCRIPTION("FXOS8700 6-Axis Acc and Mag Combo Sensor driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/imu/fxos8700/fxos8700_i2c.c b/drivers/iio/imu/fx=
os8700/fxos8700_i2c.c
> new file mode 100644
> index 0000000..a1891d2
> --- /dev/null
> +++ b/drivers/iio/imu/fxos8700/fxos8700_i2c.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FXOS8700 - Freescale IMU, I2C bits
> + *
> + * Copyright (c) 2016, Freescale Corporation. TODO
> + *
> + * 7-bit I2C slave address determined by SA1 and SA0 logic level
> + * inputs represented in the following table:
> + *      SA1  |  SA0  |  Slave Address
> + *      0    |  0    |  0x1E
> + *      0    |  1    |  0x1D
> + *      1    |  0    |  0x1C
> + *      1    |  1    |  0x1F
> + */
> +#include <linux/acpi.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include "fxos8700.h"
> +
> +static int fxos8700_i2c_probe(struct i2c_client *client,
> +			      const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
> +	const char *name =3D NULL;
> +
> +	regmap =3D devm_regmap_init_i2c(client, &fxos8700_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	if (id)
> +		name =3D id->name;
> +
> +	return fxos8700_core_probe(&client->dev, regmap, name, false);
> +}
> +
> +static const struct i2c_device_id fxos8700_i2c_id[] =3D {
> +	{"fxos8700", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, fxos8700_i2c_id);
> +
> +static const struct acpi_device_id fxos8700_acpi_match[] =3D {
> +	{"FXOS8700", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, fxos8700_acpi_match);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id fxos8700_of_match[] =3D {
> +	{ .compatible =3D "fsl,fxos8700" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, fxos8700_of_match);
> +#endif
> +
> +static struct i2c_driver fxos8700_i2c_driver =3D {
> +	.driver =3D {
> +		.name			=3D "fxos8700_i2c",
> +		.acpi_match_table	=3D ACPI_PTR(fxos8700_acpi_match),
> +		.of_match_table		=3D of_match_ptr(fxos8700_of_match),

As for spi driver, don't do this with the of_match_ptr trickery.
Breaks use of PRP001 ACPI ids.  Slowly but surely it's getting
phased on in new drivers and old ones where anyone actually
wants to use that approach to the binding.

> +	},
> +	.probe		=3D fxos8700_i2c_probe,
> +	.id_table	=3D fxos8700_i2c_id,
> +};
> +module_i2c_driver(fxos8700_i2c_driver);
> +
> +MODULE_AUTHOR("Robert Jones <rjones@gateworks.com>");
> +MODULE_DESCRIPTION("FXOS8700 I2C driver");
> +MODULE_LICENSE("GPL v2"); //TODO
> diff --git a/drivers/iio/imu/fxos8700/fxos8700_spi.c b/drivers/iio/imu/fx=
os8700/fxos8700_spi.c
> new file mode 100644
> index 0000000..c75ccb8
> --- /dev/null
> +++ b/drivers/iio/imu/fxos8700/fxos8700_spi.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FXOS8700 - Freescale IMU, I2C bits
> + *
> + * Copyright (c) 2016, Freescale Corporation. TODO.
> + *
> + */
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "fxos8700.h"
> +
> +static int fxos8700_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	const struct spi_device_id *id =3D spi_get_device_id(spi);
> +
> +	regmap =3D devm_regmap_init_spi(spi, &fxos8700_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +	return fxos8700_core_probe(&spi->dev, regmap, id->name, true);
> +}
> +
> +static const struct spi_device_id fxos8700_spi_id[] =3D {
> +	{"fxos8700", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, fxos8700_spi_id);
> +
> +static const struct acpi_device_id fxos8700_acpi_match[] =3D {
> +	{"FXOS8700", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, fxos8700_acpi_match);
> +
> +#ifdef CONFIG_OF

Given the magic that allows us to use dt bindings from ACPI
these days, we no longer protect these with such an ifdef.

> +static const struct of_device_id fxos8700_of_match[] =3D {
> +	{ .compatible =3D "fsl,fxos8700" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, fxos8700_of_match);
> +#endif
> +
> +static struct spi_driver fxos8700_spi_driver =3D {

Nitpick: Personally I'm usually anti doing tab indents for simple cases lik=
e this.
The reason is the amount of noise it generates when we then get another
entry added that happens to need everything realigned.
In cases where it is a table of values it can help readability.
Here not so much...

> +	.probe		=3D fxos8700_spi_probe,
> +	.id_table	=3D fxos8700_spi_id,
> +	.driver =3D {
> +		.acpi_match_table	=3D ACPI_PTR(fxos8700_acpi_match),
> +		.of_match_table		=3D of_match_ptr(fxos8700_of_match),

Don't use that macro.  It stops the magic PRP001 ACPI id working.
		.of_match_table =3D fxos8700_of_match,=20

> +		.name			=3D "fxos8700_spi",
> +	},
> +};
> +module_spi_driver(fxos8700_spi_driver);
> +
> +MODULE_AUTHOR("Robert Jones <rjones@gateworks.com>");
> +MODULE_DESCRIPTION("FXOS8700 SPI driver");
> +MODULE_LICENSE("GPL v2"); //TODO

You want to fix that TODO :)


