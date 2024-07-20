Return-Path: <linux-iio+bounces-7745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8D19381D3
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 17:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AF21C21050
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE813D61A;
	Sat, 20 Jul 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWoz6d8K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80982D7F;
	Sat, 20 Jul 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721489690; cv=none; b=ZifoWDZA1gd2ygfB9CqiH3ytqNJJD67ZgRKpAdePmYfoyT17fObmyLIaRq4LukXe7A7FnA8y7WXG2lxcd0ugrZmfZLI5NZsuEt/5N5YtLgCZLjUsCUaUUJWL2M5htg3JGch5bxmgqAN4VcOlE9io3Bqz0Vji+XzzbQC0ixeT474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721489690; c=relaxed/simple;
	bh=yp1wIxp6bEzkxVkD6OIJwK+tqkT3vSVfjyDiVmYyE7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGozpVXt8aoyLBNSwOC6XuIjvIspEqzJ8rsmC2+7adSBpCfFeRL9QIQg9zZnjwXG8Sp15W3nmaUCiria5N6RSLP7aP/lAzRGTRzigZ572fFghQQ/8aio0JYtrD698YzEm1fNSfT0+ZCMU+rUevjI19PmC8pnkz8ftxsiiceq1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWoz6d8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DC4C2BD10;
	Sat, 20 Jul 2024 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721489689;
	bh=yp1wIxp6bEzkxVkD6OIJwK+tqkT3vSVfjyDiVmYyE7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FWoz6d8KsOh8TKJprhtwvSv2mLMNvvedHpHH/TgA4b+wRwuxY+Cz1ozs6DoR1MSv0
	 A3DRYMa/sWA07BtDrdn8OKaHgoyPziSlsnX26W4T5KHC2pawD1NVakhAMzAkiavVht
	 EFyhGYYIIWa9NR1gTuZcL1QhNgv4v+fDnsdNUF9UyB+Qt+9FrG9rKAWlCYgIjpL5Q7
	 pAxTml5lRZDFf97UOEX4GhHgAVCWzP2FhKoJnVwhNYjdu8jlx50gI6QcLIiBOMyM1b
	 SsKqZce6ovpSHmelov3i9104lUSW1IEdPM2OL9o5U2YtYfqPzBYfzLs8PJFU2XARrm
	 GHydB0so6B5IQ==
Date: Sat, 20 Jul 2024 16:34:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Jianping.Shen@de.bosch.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Christian.Lorenz3@de.bosch.com>, <Ulrike.Frauendorf@de.bosch.com>,
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH] drivers: Bosch SMI240 IMU Driver
Message-ID: <20240720163440.03c713dc@jic23-huawei>
In-Reply-To: <20240718122449.7607-1-Jianping.Shen@de.bosch.com>
References: <20240718122449.7607-1-Jianping.Shen@de.bosch.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 14:24:49 +0200
<Jianping.Shen@de.bosch.com> wrote:

> From: "Shen Jianping (ME-SE/EAD2)" <she2rt@LR-C-0008DVM.rt.de.bosch.com>
> 
> Add Bosch SMI240 IMU IIO Driver to iio-for-6.10b
> 
> Signed-off-by: Shen Jianping (ME-SE/EAD2) <she2rt@LR-C-0008DVM.rt.de.bosch.com>
Hi Shen Jiangping,

Welcome to IIO.

Having reviewed this driver, I would encourage you to look at a number of other
recent drivers and familiarize yourself with how things are done.
If a new driver looks substantially different in style, or approach from those
then consider if that is the right way to go.

A lot of comments inline that you would have avoided via such a comparison.

I'm going to make the assumption this device has a very different interface to
the bosch IMUs we already support.

Anyhow, comments inline - feel free to ask questions as I'm sure I've
been overly brief on some of them!

Jonathan

> ---
>  .../bindings/iio/imu/bosch,smi240.yaml        |  45 +
>  drivers/iio/imu/Kconfig                       |   2 +
>  drivers/iio/imu/Makefile                      |   1 +
>  drivers/iio/imu/smi240/Kconfig                |  30 +
>  drivers/iio/imu/smi240/Makefile               |   8 +
>  drivers/iio/imu/smi240/smi240.h               |  31 +
>  drivers/iio/imu/smi240/smi240_core.c          | 814 ++++++++++++++++++
>  drivers/iio/imu/smi240/smi240_spi.c           | 153 ++++
>  8 files changed, 1084 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
>  create mode 100644 drivers/iio/imu/smi240/Kconfig
>  create mode 100644 drivers/iio/imu/smi240/Makefile
>  create mode 100644 drivers/iio/imu/smi240/smi240.h
>  create mode 100644 drivers/iio/imu/smi240/smi240_core.c
>  create mode 100644 drivers/iio/imu/smi240/smi240_spi.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> new file mode 100644
> index 00000000000..972819cacff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bosch,smi240.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BOSCH SMI240
> +
> +maintainers:
> +  - unknown
Needs one or it won't merge. Hopefully you can list yourself here.
> +
> +description: |
> +  Inertial Measurement Unit with Accelerometer, Gyroscope 
> +  https://www.bosch-semiconductors.com/mems-sensors/highly-automated-driving/smi240/
Ah well, a more or less information free link so we are guessing here.
However, there are some obvious missing elements.

Good to have a little more information on the device here to provide the
background a reader might need.  What sort of IMU, what channels etc?

> +
> +properties:
> +  compatible:
> +    const: BOSCH,SMI240
Look at what makes an acceptable compatible and fix this.

> +
> +  reg:
> +    maxItems: 1
> +
IMUs need power.  So should be at least one
-supply: true entry that is also listed in required.

Rare IMU that doesn't have at least one interrupt. So add that as well.

> +required:
> +  - compatible
> +  - spi-max-frequency
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // Example
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        smi240@0 {
> +            compatible = "BOSCH,SMI240";
> +            spi-max-frequency = <10000000>;
> +            reg = <0>;
> +        };
> +    };


> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index 52a155ff325..2c348ad686a 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -96,6 +96,8 @@ config KMX61
>  
>  source "drivers/iio/imu/inv_icm42600/Kconfig"
>  source "drivers/iio/imu/inv_mpu6050/Kconfig"
> +source "/home/she2rt/dev/smi240-linux-driver-iio/drivers/iio/imu/smi240/Kconfig"

Delete this... I guess left over from some earlier debugging?

> +source "drivers/iio/imu/smi240/Kconfig"
>  source "drivers/iio/imu/st_lsm6dsx/Kconfig"
>  source "drivers/iio/imu/st_lsm9ds0/Kconfig"
>  
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> index 7e2d7d5c3b7..b6f162ae4ed 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -27,5 +27,6 @@ obj-y += inv_mpu6050/
>  
>  obj-$(CONFIG_KMX61) += kmx61.o
>  
> +obj-y += smi240/
>  obj-y += st_lsm6dsx/
>  obj-y += st_lsm9ds0/
> diff --git a/drivers/iio/imu/smi240/Kconfig b/drivers/iio/imu/smi240/Kconfig
> new file mode 100644
> index 00000000000..7114c941cc3
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/Kconfig
> @@ -0,0 +1,30 @@
> +config SMI240
> +	tristate "Bosch Sensor SMI240 Inertial Measurement Unit"
> +	depends on SPI_MASTER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
Why? There isn't any buffered support in here as far as I can see.

> +	help
> +	  Build driver
> +	  for Bosch
> +	  SMI240 6-axis IMU
> +	  sensor.
Why the very very short wrap?  Provide more information on this
device in the help text.

> +
> +config SMI240_MAX_BUFFER_LEN
> +	depends on SMI240
> +	int "configue read buffer size"
> +	default "1024"
> +	help
> +	  1024 bytes are big
> +	  enough for most cases.
> +	  Do not change this value
> +	  if not sure.
Don't provide an interface to change it!  The driver should be able to figure out
an appropriate size and regsiter that.

> +
> +config SMI240_UNIT_TEST
Doesn't seem to do anything.
> +	tristate "Unit Test for SMI240"
> +	depends on KUNIT=y
> +	help
> +	  Build Unit Test
> +	  for Bosch
> +	  SMI240 6-axis
> +	  IMU sensor.
> +
> diff --git a/drivers/iio/imu/smi240/Makefile b/drivers/iio/imu/smi240/Makefile
> new file mode 100644
> index 00000000000..394eaecf5f3
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/Makefile
> @@ -0,0 +1,8 @@
> +#
> +# Makefile for Bosch SMI240
> +#
> +
> +obj-$(CONFIG_SMI240) += smi240.o
> +smi240-objs := smi240_core.o
> +smi240-objs += smi240_spi.o
Do you plan to add other bus support?  If not, squash the files together
to simplify things.

> +
> diff --git a/drivers/iio/imu/smi240/smi240.h b/drivers/iio/imu/smi240/smi240.h
> new file mode 100644
> index 00000000000..5167b25fe44
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/smi240.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> +/*
> + * Copyright (c) 2024 Robert Bosch GmbH.
> + *
No blank line here. It doesn't add anything useful.

> + */
> +
> +#ifndef _SMI240_H
> +#define _SMI240_H
> +
> +#define SENSOR_NAME    "SMI240"
> +#define DRIVER_VERSION "1.0.0"
Modern Linux drives do not provide a driver version.
The guarantees never to break ABI make it unnecessary.

> +
> +#define SET_BITS(reg_var, bitname, val)                                        \
> +	(((reg_var) & ~(bitname##_MASK)) |                                     \
> +	 (((val) << bitname##_POS) & bitname##_MASK))
> +
> +#define GET_BITS(reg_var, bitname)                                             \
> +	(((reg_var) & (bitname##_MASK)) >> (bitname##_POS))
FIELD_GET() / FIELD_PREP()
Don't invent your own equivalent functions.

> +
> +struct smi240_device {

This belongs in the structure you allocate via devm_iio_device_alloc()
and get to via iio_priv()

> +	uint16_t accel_filter_freq;
> +	uint16_t anglvel_filter_freq;
> +	uint16_t sign_of_channels;
> +	uint8_t bite_reps;
> +	int8_t (*xfer)(uint32_t request, uint32_t *data);
> +};
> +
> +int smi240_probe(struct device *dev, struct smi240_device *smi240_dev);
> +int smi240_remove(struct device *dev);
as below. Remove is unnecessary - drop it.

> +
> +#endif /* _SMI240_H */
> diff --git a/drivers/iio/imu/smi240/smi240_core.c b/drivers/iio/imu/smi240/smi240_core.c
> new file mode 100644
> index 00000000000..786cc3064ef
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/smi240_core.c
> @@ -0,0 +1,814 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2024 Robert Bosch GmbH.
> + *
No blank line here.

> + */
> +
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/string.h>
That's a very short list of includes.  Looks to see if there are any others
you should have here.

> +
> +#include "smi240.h"
> +
> +enum {
> +	SMI240_ACC_X_AND_Y_AND_Z,
> +	SMI240_GYRO_X_AND_Y_AND_Z,
> +	SMI240_TEMP_OBJECT,
> +	SMI240_TIMESTAMP,
As below - timestamp doesn't make sense yet as no buffered support
(so nothing useful to timestamp).

> +};
> +
> +#define SMI240_CHIP_ID 0x0024
> +
> +#define SMI240_CRC_INIT 0x05
> +#define SMI240_CRC_POLY 0x0B
> +#define SMI240_BUS_ID	0x00
> +
> +#define SMI240_SD_BIT_MASK 0x80000000
> +#define SMI240_SD_BIT_POS  31
> +#define SMI240_CS_BIT_MASK 0x00000008
> +#define SMI240_CS_BIT_POS  3
> +
> +#define SMI240_WRITE_ADDR_MASK 0x3FC00000
Use GENMASK() for all contiguous field masks.

> +#define SMI240_WRITE_ADDR_POS  22
Provide only the mask. Then use FIELD_GET / FIELD_PREP()
which will extract the shifts from the mask.

That avoids replication of information in these defines.

> +#define SMI240_WRITE_BIT_MASK  0x00200000
> +#define SMI240_WRITE_BIT_POS   21
> +#define SMI240_WRITE_DATA_MASK 0x0007FFF8
> +#define SMI240_WRITE_DATA_POS  3
> +#define SMI240_CAP_BIT_MASK    0x00100000
> +#define SMI240_CAP_BIT_POS     20
> +#define SMI240_READ_DATA_MASK  0x000FFFF0
> +#define SMI240_READ_DATA_POS   4
> +
> +#define SMI240_GYR_BW_MASK    0x0002
> +#define SMI240_GYR_BW_POS     1
> +#define SMI240_ACC_BW_MASK    0x0004
> +#define SMI240_ACC_BW_POS     2
> +#define SMI240_BITE_AUTO_MASK 0x0008
> +#define SMI240_BITE_AUTO_POS  3
> +#define SMI240_BITE_REP_MASK  0x0070
> +#define SMI240_BITE_REP_POS   4
> +
> +#define SMI240_GYR_INVERTX_MASK 0x01
Field mask definitions should indicate which register
they are in.  Here I think it's SIGN_SFT_CFG

Maybe
#define SMI240_SIGN_SFT_GYR_INVX_MSK 
would work here.

> +#define SMI240_GYR_INVERTX_POS	0
> +#define SMI240_GYR_INVERTY_MASK 0x02
> +#define SMI240_GYR_INVERTY_POS	1
> +#define SMI240_GYR_INVERTZ_MASK 0x04
> +#define SMI240_GYR_INVERTZ_POS	2
> +#define SMI240_ACC_INVERTX_MASK 0x08
> +#define SMI240_ACC_INVERTX_POS	3
> +#define SMI240_ACC_INVERTY_MASK 0x10
> +#define SMI240_ACC_INVERTY_POS	4
> +#define SMI240_ACC_INVERTZ_MASK 0x20
> +#define SMI240_ACC_INVERTZ_POS	5
> +
> +#define SMI240_CHIP_ID_REG	0x00
Start with the register definitions then provide
the field definitions.
Naming should connect the two so it's obvious if
we are applying a mask to the wrong register value


> +#define SMI240_SOFT_CONFIG_REG	0x0A
> +#define SMI240_SIGN_SFT_CFG_REG 0x0B
> +#define SMI240_TEMP_CUR_REG	0x10
> +#define SMI240_ACCEL_X_CUR_REG	0x11
> +#define SMI240_ACCEL_Y_CUR_REG	0x12
> +#define SMI240_ACCEL_Z_CUR_REG	0x13
> +#define SMI240_GYRO_X_CUR_REG	0x14
> +#define SMI240_GYRO_Y_CUR_REG	0x15
> +#define SMI240_GYRO_Z_CUR_REG	0x16
> +
> +#define SMI240_TEMP_CAP_REG    0x17
> +#define SMI240_ACCEL_X_CAP_REG 0x18
> +#define SMI240_ACCEL_Y_CAP_REG 0x19
> +#define SMI240_ACCEL_Z_CAP_REG 0x1A
> +#define SMI240_GYRO_X_CAP_REG  0x1B
> +#define SMI240_GYRO_Y_CAP_REG  0x1C
> +#define SMI240_GYRO_Z_CAP_REG  0x1D
> +
> +#define SMI240_CMD_REG	    0x2F
> +#define SMI240_BITE_CMD_REG 0x36
> +
> +#define SMI240_SOFT_RESET_CMD 0xB6
> +#define SMI240_BITE_CMD	      0xB17E
> +
> +#define SMI240_BITE_SEQUENCE_DELAY   140
> +#define SMI240_FILTER_FLUSH_DELAY    60
> +#define SMI240_DIGITAL_STARTUP_DELAY 120
> +#define SMI240_MECH_STARTUP_DELAY    100
> +
> +#define SMI240_MIN_BITE_REPS 1
> +#define SMI240_MAX_BITE_REPS 8
Good to use nam
> +
> +#define SMI240_TEMPERATURE_BASE	 25
Fixed offset?  If so provide the _offset sysfs file and let userspace do
the maths.  If the transformation needed is linear we almost always leave
it to userspace which can do maths more easily than the kernel as it has
floating point etc without jumping through a lot of hoops (which we don't
do for IIO driverS)

> +#define SMI240_TEMPERATURE_SHIFT 8
Provide masks and use FIELD_GET() to extract values.
 
> +
> +#define SMI240_DATA_CHANNEL(_type, _axis, _index)                              \
> +	{                                                                      \
> +		.type = _type, .modified = 1, .channel2 = IIO_MOD_##_axis,     \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                  \
> +		.info_mask_shared_by_type =                                    \
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),      \
> +		.info_mask_shared_by_type_available =                          \
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),      \
> +		.scan_index = _index,                                          \
> +		.scan_type = {                                                 \
> +			.sign = 's',                                           \
> +			.realbits = 16,                                        \
> +			.storagebits = 16,                                     \
> +			.endianness = IIO_LE,                                  \
> +		},                                                             \
> +	}
> +
> +#define SMI240_TEMP_CHANNEL(_index)                                            \
> +	{                                                                      \
> +		.type = IIO_TEMP, .modified = 1,                               \
> +		.channel2 = IIO_MOD_TEMP_OBJECT,                               \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                  \
> +		.scan_index = _index,                                          \
> +		.scan_type = {                                                 \
> +			.sign = 's',                                           \
> +			.realbits = 16,                                        \
> +			.storagebits = 16,                                     \
> +			.endianness = IIO_LE,                                  \

You aren't yet registering a buffered interface so this stuff is probably unused.
Bring it in when you add that support, not before that.

> +		},                                                             \
> +	}
> +
> +static const int smi240_low_pass_freqs[] = { 50, 400 };
> +
> +static const struct iio_chan_spec smi240_channels[] = {
> +	SMI240_DATA_CHANNEL(IIO_ACCEL, X_AND_Y_AND_Z, SMI240_ACC_X_AND_Y_AND_Z),
> +	SMI240_DATA_CHANNEL(IIO_ANGL_VEL, X_AND_Y_AND_Z,
> +			    SMI240_GYRO_X_AND_Y_AND_Z),

As below, this is not how modifiers work it the IIO ABI.
You need one channel per axis.
If you need to read a set together implement the triggered buffer interfaces
which I'd expect to see an IMU anyway because they 

> +	SMI240_TEMP_CHANNEL(SMI240_TEMP_OBJECT),
> +	IIO_CHAN_SOFT_TIMESTAMP(SMI240_TIMESTAMP),
This timestamp doesn't makes sense until you add buffered support. Bring it
back when you do.

> +};
> +
> +static uint8_t smi240_crc3(uint32_t data, uint8_t init, uint8_t poly)
> +{
> +	uint8_t crc = init;
> +	uint8_t do_xor;
> +	int8_t i = 31;
> +
> +	do {
> +		do_xor = crc & 0x04;
> +		crc <<= 1;
> +		crc |= 0x01 & (data >> i);
> +		if (do_xor)
> +			crc ^= poly;
> +
> +		crc &= 0x07;
> +	} while (--i >= 0);
> +
> +	return crc;

Doesn't match one of the standard crc calculations in the kernel?
That would be very unusual.

> +}
> +
> +static bool smi240_sensor_data_is_valid(uint32_t data)
> +{
> +	if (smi240_crc3(data, SMI240_CRC_INIT, SMI240_CRC_POLY))
> +		return false;
> +
> +	if (GET_BITS(data, SMI240_SD_BIT) & GET_BITS(data, SMI240_CS_BIT))
FIELD_GET() on both.
> +		return false;
> +
> +	return true;
> +}
> +
> +static int8_t smi240_get_regs(uint8_t reg_addr, uint16_t *reg_data,
> +			      uint16_t len, uint8_t capture,
> +			      const struct smi240_device *dev)
> +{
> +	int ret, i;
> +	uint8_t cap;
> +	uint32_t request, response;
> +
> +	for (i = 0; i < len; i++) {
> +		cap = capture && (i == 0);
> +		request = SMI240_BUS_ID << 30;
> +		request = SET_BITS(request, SMI240_CAP_BIT, cap);
> +		request = SET_BITS(request, SMI240_WRITE_ADDR, reg_addr + i);
FIELD_PREP() for all these.

> +		request |=
> +			smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> +
> +		ret = dev->xfer(request, &response);
> +
check ret.

> +		if (i > 0) {
> +			if (!smi240_sensor_data_is_valid(response))
> +				return -EIO;
> +
> +			reg_data[i - 1] = GET_BITS(response, SMI240_READ_DATA);
FIELD_GET()

> +		}
> +	}
> +
> +	ret = dev->xfer(0x0, &response);
check ret  here.

> +	if (!smi240_sensor_data_is_valid(response))
> +		return -EIO;
> +
> +	reg_data[i - 1] = GET_BITS(response, SMI240_READ_DATA);

FIELD_GET()

> +
> +	return ret;
When you get here, 
	return 0; as all is good.

> +}
> +
> +static int8_t smi240_set_regs(uint8_t reg_addr, uint16_t *reg_data,
> +			      uint16_t len, const struct smi240_device *dev)
> +{
> +	int ret;
> +	int i;
> +	uint32_t data;
> +
> +	for (i = 0; i < len; i++) {
> +		data = SMI240_BUS_ID << 30;
> +		data = SET_BITS(data, SMI240_WRITE_BIT, 1);
> +		data = SET_BITS(data, SMI240_WRITE_ADDR, reg_addr + i);
> +		data = SET_BITS(data, SMI240_WRITE_DATA, reg_data[i]);
FIELD_PREP() for those.

> +		data |= smi240_crc3(data, SMI240_CRC_INIT, SMI240_CRC_POLY);
> +		ret = dev->xfer(data, NULL);
	check ret here.

> +	}
> +	return ret;
If you get here
	return 0;
> +}
> +
> +static void smi240_delay(uint32_t msec)
> +{
> +	if (msec <= 100)
> +		mdelay(msec);
> +	else
> +		msleep(msec);

fsleep() in place of this function.
The trade off is a little different but is consistent across the kernel.


> +}
> +
> +static int smi240_self_test(struct smi240_device *dev)
> +{
> +	int ret;
> +	uint16_t response[7];
> +	uint16_t request = SMI240_BITE_CMD;
> +
> +	ret = smi240_set_regs(SMI240_BITE_CMD_REG, &request, 1, dev);
> +	smi240_delay(dev->bite_reps * SMI240_BITE_SEQUENCE_DELAY +
> +		     SMI240_FILTER_FLUSH_DELAY);
> +	if (ret) {
> +		pr_err("Sending BITE command failed.");
> +		return -EIO;
> +	}
> +
> +	/* Reading from all 7 sensor data capture registers w/o error
> +	 * makes sure all channels are valid.
> +	 */
IIO (and most of kernel) uses 
	/* 
	 * Reading from all...	
	 * makes..
	 */
syntax for multiline comments.

Basically look at local style and match that of the appropriate subsystem.

> +	return smi240_get_regs(SMI240_TEMP_CAP_REG, response, 7, 1, dev);
> +}
> +
> +static int smi240_soft_reset(struct smi240_device *dev)
> +{
> +	int ret;
> +	uint16_t data = SMI240_SOFT_RESET_CMD;
> +
> +	ret = smi240_set_regs(SMI240_CMD_REG, &data, 1, dev);
> +	smi240_delay(SMI240_DIGITAL_STARTUP_DELAY);
> +	return ret;
If ret says it failed, not point in delaying as chip is dead. So
check it before the delay.

> +}
> +
> +static int smi240_soft_config(struct smi240_device *dev)
> +{
> +	int ret;
> +	uint8_t acc_bw, gyr_bw;
> +	uint16_t request = 0x1;
> +
> +	switch (dev->accel_filter_freq) {
> +	case 50:
> +		acc_bw = 0x1;
> +		break;
> +	case 400:
> +		acc_bw = 0x0;
> +		break;
> +	default:
> +		pr_err("Soft Config: invalid ACC_BW.");

dev_err()

> +		return -EINVAL;
> +	}
> +
> +	switch (dev->anglvel_filter_freq) {
> +	case 50:
> +		gyr_bw = 0x1;
> +		break;
> +	case 400:
> +		gyr_bw = 0x0;
> +		break;
> +	default:
> +		pr_err("Soft Config: invalid GYR_BW.");
dev_err()

> +		return -EINVAL;
> +	}
> +
> +	request = SET_BITS(request, SMI240_GYR_BW, gyr_bw);
> +	request = SET_BITS(request, SMI240_ACC_BW, acc_bw);
> +	request = SET_BITS(request, SMI240_BITE_AUTO, 1);
> +	request = SET_BITS(request, SMI240_BITE_REP, dev->bite_reps - 1);
FIELD_PREP() for all of these with appropriate request |= 
> +
> +	ret = smi240_set_regs(SMI240_SIGN_SFT_CFG_REG, &(dev->sign_of_channels),
> +			      1, dev);
As elsewhere - handle each error, not sets of them.

> +	ret |= smi240_set_regs(SMI240_SOFT_CONFIG_REG, &request, 1, dev);
> +	if (ret)
> +		pr_err("Soft Config: IO error.");
> +
> +	smi240_delay(SMI240_MECH_STARTUP_DELAY +
> +		     dev->bite_reps * SMI240_BITE_SEQUENCE_DELAY +
> +		     SMI240_FILTER_FLUSH_DELAY);
> +	return ret;
> +}
> +
> +static int smi240_read_raw_multi(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan, int max_len,
> +				 int *vals, int *val_len, long mask)
> +{
> +	int ret = 0;
> +	int16_t data[3];
> +	struct smi240_device *dev = iio_device_get_drvdata(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->channel2 == IIO_MOD_X_AND_Y_AND_Z) {
We don't provide multi channel read of raw data. It is not part of
the standard ABI and that's not what MOD_X_AND_Y_AND_Z is for
(it's for a particular weird form of threshold detector).

The only exception to this (kind of) is for quaternions where they
have no meaning unless we get all the components.
The rule for sysfs is one file one thing. This is multiple things
so not acceptable (there are other corners where it is fine to
have multiple values, such listing what is available but in that
case it's still considered one thing, just in the form of a list of
options).

Just handle one channel at a time for each sysfs file.

Likely your applications need a scan of all channels - we do that
via the buffered interfaces not sysfs.

> +			if (chan->type == IIO_ACCEL)
> +				ret = smi240_get_regs(SMI240_ACCEL_X_CAP_REG,
> +						      data, 3, 1, dev);
> +			else if (chan->type == IIO_ANGL_VEL)
> +				ret = smi240_get_regs(SMI240_GYRO_X_CAP_REG,
> +						      data, 3, 1, dev);
> +			else
> +				return -EINVAL;
> +
> +			if (ret)
> +				return -EIO;
> +
> +			*val_len = 3;
> +			vals[0] = data[0];
> +			vals[1] = data[1];
> +			vals[2] = data[2];
> +		} else if (chan->channel2 == IIO_MOD_TEMP_OBJECT) {
> +			ret = smi240_get_regs(SMI240_TEMP_CUR_REG, data, 1, 0,
> +					      dev);
> +
> +			if (ret)
> +				return -EIO;
> +
> +			data[0] >>= SMI240_TEMPERATURE_SHIFT;
> +			data[0] += SMI240_TEMPERATURE_BASE;
> +
> +			*val_len = 1;
> +			vals[0] = data[0];
> +		} else
> +			return -EINVAL;
> +
> +		return IIO_VAL_INT_MULTIPLE;
> +
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		ret = smi240_get_regs(SMI240_SOFT_CONFIG_REG, data, 1, 0, dev);
> +		if (ret)
> +			return -EIO;
> +
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			switch (GET_BITS(data[0], SMI240_ACC_BW)) {
> +			case 0:
> +				dev->accel_filter_freq = 400;
> +				break;
> +			case 1:
> +				dev->accel_filter_freq = 50;
> +				break;
> +			}
> +
> +			vals[0] = dev->accel_filter_freq;
> +			break;
> +		case IIO_ANGL_VEL:
> +			switch (GET_BITS(data[0], SMI240_GYR_BW)) {
> +			case 0:
> +				dev->anglvel_filter_freq = 400;
> +				break;
> +			case 1:
> +				dev->anglvel_filter_freq = 50;
> +				break;
> +			}
> +
> +			vals[0] = dev->anglvel_filter_freq;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		*val_len = 1;
Use read_raw rather than the multi version as you don't need the
extra complexity as your multi channel read approach is not part of
the IIO ABI.

Then return IIO_VAL_INT instead of breaking out above.

> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> 
> +}
> +
> +static int smi240_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)
> +{
> +	int ret, i;
> +	bool valid = false;
> +	struct smi240_device *dev = iio_device_get_drvdata(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		for (i = 0; i < ARRAY_SIZE(smi240_low_pass_freqs); ++i) {
i++ preferred. Makes not real difference but is more common in kernel.

> +			if (val == smi240_low_pass_freqs[i]) {
> +				valid = true;
> +				break;
> +			}
> +		}
> +
> +		if (!valid)
Can check if i == ARRAY_SIZE() to get same result I think and avoid
need for the boolean.

> +			return -EINVAL;
> +
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			dev->accel_filter_freq = val;
> +			break;
> +		case IIO_ANGL_VEL:
> +			dev->anglvel_filter_freq = val;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = smi240_soft_reset(dev);
Don't eat or combine errors.
If this soft reset is not very light weight it isn't really appropriate
for a filter change.   Normal assumption is that if someone is messing
with filters, they can wait for the data to stabilise with new values.
Is the reset really required?

> +	ret |= smi240_soft_config(dev);
> +	if (ret)
> +		ret = -EIO;
> +
> +	return ret;
> +}
> +
> +static int smi240_init(struct smi240_device *dev)
> +{
> +	int ret;
> +
> +	dev->accel_filter_freq = 400;
> +	dev->anglvel_filter_freq = 400;
> +	dev->sign_of_channels = 0x00;
> +	dev->bite_reps = 3;
> +
> +	ret = smi240_soft_config(dev);
> +	if (ret)
> +		pr_info("Soft Config failed.");
As everywhere else dev_err()


> +
> +	return ret;
> +}
> +
> +static ssize_t in_temp_accel_anglvel_capture_show(struct device *dev,
> +						  struct device_attribute *attr,
> +						  char *buf)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);
> +	int16_t data[7];
> +
> +	ret = smi240_get_regs(SMI240_TEMP_CAP_REG, data, 7, 1, smi240_dev);
> +
> +	data[0] >>= SMI240_TEMPERATURE_SHIFT;
> +	data[0] += SMI240_TEMPERATURE_BASE;
> +
> +	return snprintf(buf, PAGE_SIZE, "%hd %hd %hd %hd %hd %hd %hd\n",
> +			data[0], data[1], data[2], data[3], data[4], data[5],
> +			data[6]);
This looks like a multichannel read if so, we won't accept it.
If you need to do near simultaneous reads of multiple channel look
at the triggered buffer infrastructure.  That provides the reads via a character
device with a software fifo behind it.  It's a much lighter weight path than a sysfs
file and more suited to high speed data capture.

> +}
> +
> +static ssize_t self_test_show(struct device *dev, struct device_attribute *atrr,
> +			      char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);
> +
> +	if (smi240_self_test(smi240_dev))
> +		return snprintf(buf, PAGE_SIZE, "self test fail.\n");
> +	else
> +		return snprintf(buf, PAGE_SIZE, "self test success.\n");

Similar to reset.  We normally just make this something that happens in probe()
and so don't need a userspace interface. Is that sufficient here?

> +}
> +
> +static ssize_t soft_reset_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	bool success = true;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);
> +
> +	ret = smi240_soft_reset(smi240_dev);
Firstly as stated below, we don't provide interfaces for this because
it's a heavy weight process that is most of the effort of unbinding and
rebinding the driver. So if you need to reset, do that.

> +	if (ret) {
> +		dev_err(dev, "Soft reset failed.");
> +		success = false;
> +	}
> +
> +	ret = smi240_init(smi240_dev);
> +	if (ret) {
> +		dev_err(dev, "Device initialization failed.");
> +		success = false;
> +	}
> +
> +	if (!success)
> +		return snprintf(buf, PAGE_SIZE, "soft reset failed.\n");
> +	else
> +		return snprintf(buf, PAGE_SIZE, "soft reset performed.\n");
Reset via a read sysfs file is bad.  Permissions are usually more relaxed
for reading as it's expected to have no side effects.

So if we were going to support this it would need to be a write triggered
activity and success or not would be reported via count, or error code.

> +}
> +
> +static ssize_t sign_of_channels_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	uint16_t data;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);
> +
> +	ret = smi240_get_regs(SMI240_SIGN_SFT_CFG_REG, &data, 1, 0, smi240_dev);
> +	if (ret)
> +		return -EIO;
> +
> +	smi240_dev->sign_of_channels = data;
> +
> +	return snprintf(
> +		buf, PAGE_SIZE, "ax:%d,ay:%d,az:%d,gx:%d,gy:%d,gz:%d\n",
> +		GET_BITS(smi240_dev->sign_of_channels, SMI240_ACC_INVERTX),
> +		GET_BITS(smi240_dev->sign_of_channels, SMI240_ACC_INVERTY),
> +		GET_BITS(smi240_dev->sign_of_channels, SMI240_ACC_INVERTZ),
> +		GET_BITS(smi240_dev->sign_of_channels, SMI240_GYR_INVERTX),
> +		GET_BITS(smi240_dev->sign_of_channels, SMI240_GYR_INVERTY),
> +		GET_BITS(smi240_dev->sign_of_channels, SMI240_GYR_INVERTZ));

So I guess this is a device that provides a per channel invert.
I don't see any reason why a Linux driver should support this as it's trivial
for userspace to flip channels as needed.
My guess is this is to support the fact that microsoft and google disagree
on left vs right handed sensors.   Check out 
https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/mount-matrix.txt
for what Linux uses and provide a suitable mount matrix and default
settings of these invert bits to get there.
Whether the channels are inverted or not isn't of interest to userspace
which just cares about how to get screen orientation etc.


> +}
> +
> +static uint16_t calculate_sign_of_channels(const char *buf,
> +					   const uint16_t register_val,
> +					   size_t count)
> +{
> +	uint16_t sign_of_channels = register_val;
> +	char *sep = ",";
> +	char *config;
> +	char data[32];
> +
> +	char *input = data;
> +	char *sep2 = ":";
> +	char *value;
> +	char *channel;
> +
> +	if (count <= 30) {
> +		memset(data, 0, sizeof(data));
> +		memcpy(data, buf, count);
> +
> +		if (data[strlen(data) - 1] == '\n')
> +			data[strlen(data) - 1] = '\0';
> +
> +		config = strsep(&input, sep);
> +		while (config != NULL) {
> +			channel = strsep(&config, sep2);
> +			if (channel != NULL && strcmp(channel, "ax") == 0) {
> +				value = strsep(&config, sep2);
> +				if (value != NULL && strcmp(value, "0") == 0) {
> +					sign_of_channels =
> +						SET_BITS(sign_of_channels,
> +							 SMI240_ACC_INVERTX, 0);
> +				}
> +				if (value != NULL && strcmp(value, "1") == 0) {
> +					sign_of_channels =
> +						SET_BITS(sign_of_channels,
> +							 SMI240_ACC_INVERTX, 1);
> +				}
> +			}
> +			if (channel != NULL && strcmp(channel, "ay") == 0) {
> +				value = strsep(&config, sep2);
> +				if (value != NULL && strcmp(value, "0") == 0) {
> +					sign_of_channels =
> +						SET_BITS(sign_of_channels,
> +							 SMI240_ACC_INVERTY, 0);
> +				}
> +				if (value != NULL && strcmp(value, "1") == 0) {
> +					sign_of_channels =
> +						SET_BITS(sign_of_channels,
> +							 SMI240_ACC_INVERTY, 1);
> +				}
> +			}
> +			if (channel != NULL && strcmp(channel, "az") == 0) {
> +				value = strsep(&config, sep2);
> +				if (value != NULL && strcmp(value, "0") == 0) {
> +					sign_of_channels =
> +						SET_BITS(sign_of_channels,
> +							 SMI240_ACC_INVERTZ, 0);
> +				}
> +				if (value != NULL && strcmp(value, "1") == 0) {
> +					sign_of_channels =
> +						SET_BITS(sign_of_channels,
> +							 SMI240_ACC_INVERTZ, 1);
> +				}
> +			}
> +			if (channel != NULL && strcmp(channel, "gx") == 0) {
> +				value = strsep(&config, sep2);
> +				if (value != NULL && strcmp(value, "0") == 0) {
> +					sign_of_channels =
> +						SET_BITS(sign_of_channels,
> +							 SMI240_GYR_INVERTX, 0);
> +				}
> +				if (value != NULL && strcmp(value, "1") == 0) {
> +					sign_of_channels =
> +						SET_BITS(sign_of_channels,
> +							 SMI240_GYR_INVERTX, 1);
> +				}
> +			}
> +			if (channel != NULL && strcmp(channel, "gy") == 0) {
> +				value = strsep(&config, sep2);
> +				if (value != NULL && strcmp(value, "0") == 0) {
> +					sign_of_channels =
> +						SET_BITS(sign_of_channels,
> +							 SMI240_GYR_INVERTY, 0);
> +				}
> +				if (value != NULL && strcmp(value, "1") == 0) {
> +					sign_of_channels =
> +						SET_BITS(sign_of_channels,
> +							 SMI240_GYR_INVERTY, 1);
> +				}
> +			}
> +			if (channel != NULL && strcmp(channel, "gz") == 0) {
> +				value = strsep(&config, sep2);
> +				if (value != NULL && strcmp(value, "0") == 0) {
> +					sign_of_channels =
> +						SET_BITS(sign_of_channels,
> +							 SMI240_GYR_INVERTZ, 0);
> +				}
> +				if (value != NULL && strcmp(value, "1") == 0) {
> +					sign_of_channels =
> +						SET_BITS(sign_of_channels,
> +							 SMI240_GYR_INVERTZ, 1);
> +				}
> +			}
> +			config = strsep(&input, sep);
> +		}
> +	}
> +	return sign_of_channels;
> +}
> +
> +static ssize_t sign_of_channels_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);
> +
> +	if (count > 30)
> +		return -EINVAL;
> +
> +	smi240_dev->sign_of_channels = calculate_sign_of_channels(
> +		buf, smi240_dev->sign_of_channels, count);
	smi240_dev->sign_of_channels =
		calculate_sign_of_channels(buf, smi240_dev->sign_of_channels,
					   count);

would be a preferred wrapping.

> +
> +	ret = smi240_soft_reset(smi240_dev);
> +	if (ret) {
> +		pr_err("Soft Reset failed.");
> +		return -EIO;
> +	}
> +
> +	ret = smi240_soft_config(smi240_dev);
> +	if (ret) {
> +		pr_err("Soft Config failed.");
dev_err() always - so we know which device is reporting the error.

> +		return -EIO;
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t bite_repetitions_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	uint16_t data;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);

Better to get this via iio_priv() and a suitable dev pointer in that structure.

> +
> +	ret = smi240_get_regs(SMI240_SOFT_CONFIG_REG, &data, 1, 0, smi240_dev);
> +	if (ret)
> +		return -EIO;
> +
> +	smi240_dev->bite_reps = GET_BITS(data, SMI240_BITE_REP) + 1;
FIELD_GET()

> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", smi240_dev->bite_reps);
> +}
> +
> +static ssize_t bite_repetitions_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	int ret;
> +	uint8_t bite_reps;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);
> +
> +	ret = kstrtou8(buf, 10, &bite_reps);
> +	if (ret || bite_reps < SMI240_MIN_BITE_REPS ||
Always return ret if it is set as that may provide more useful debug
information than switching it to -EINVAL in all cases.

> +	    bite_reps > SMI240_MAX_BITE_REPS)
> +		return -EINVAL;
> +
> +	smi240_dev->bite_reps = bite_reps;
> +
> +	ret = smi240_soft_reset(smi240_dev);
Check each ret and return it if set.  
> +	ret |= smi240_soft_config(smi240_dev);
> +	if (ret)
Don't eat return values.

> +		return -EIO;
> +
> +	return count;
> +}
> +
> +static IIO_DEVICE_ATTR_RO(in_temp_accel_anglvel_capture, 0);
> +static IIO_DEVICE_ATTR_RO(self_test, 0);
> +static IIO_DEVICE_ATTR_RO(soft_reset, 0);
> +static IIO_DEVICE_ATTR_RW(sign_of_channels, 0);
> +static IIO_DEVICE_ATTR_RW(bite_repetitions, 0);
> +
> +static struct attribute *smi240_attrs[] = {
> +	&iio_dev_attr_in_temp_accel_anglvel_capture.dev_attr.attr,
No idea what this one is.

> +	&iio_dev_attr_self_test.dev_attr.attr,
> +	&iio_dev_attr_soft_reset.dev_attr.attr,
If the device needs a reset, unbind it and rebind it.
Same for self test assuming that doesn't require physical actions (putting
device a particular way up.   Just run a self test on every probe.

> +	&iio_dev_attr_sign_of_channels.dev_attr.attr,
> +	&iio_dev_attr_bite_repetitions.dev_attr.attr,
No idea what these might be.

Custom ABI must be documented.  Note that it is very hard to get it accepted
because custom ABI is effectively ABI that doesn't work for any standard userspace
tooling so isn't used.

If you really really need it to support something new then add a new file under
Documentation/ABI/testing/sysfs-bus-iio-smi240


> +	NULL,
> +};
> +
> +static const struct attribute_group smi240_attrs_group = {
> +	.attrs = smi240_attrs,
> +};
> +
> +static const struct iio_info smi240_info = {
> +	.read_raw_multi = smi240_read_raw_multi,
> +	.read_avail = smi240_read_avail,
> +	.write_raw = smi240_write_raw,
> +	.attrs = &smi240_attrs_group,
> +};
> +
> +int smi240_probe(struct device *dev, struct smi240_device *smi240_dev)
> +{
> +	int ret;
> +	int16_t response;
> +	struct iio_dev *indio_dev;
> +
> +	ret = smi240_get_regs(SMI240_CHIP_ID_REG, &response, 1, 0, smi240_dev);
> +	if (ret) {
> +		pr_err("Read chip id failed.");
> +		return ret;
> +	}
> +
> +	if (response == SMI240_CHIP_ID) {
> +		pr_info("SMI240 Chip ID: 0x%04x", response);
Too noisy.

> +	} else {
> +		pr_err("Unexpected Chip ID for SMI240: 0x%04x", response);
> +		return -ENODEV;

So we have this wrong in a lot of old drivers, but today the view is we never
fail a probe on a failure to match a who am I / chip ID value.
The reason is that it breaks typical use of fallback device tree compatible
entries that are used to allow an older kernel to support a compatible device
that was released after that kernel was released.

dev_info() to say it's not one we know about is fine then carry on anyway.


> +	}
> +
> +	ret = smi240_soft_reset(smi240_dev);
> +	if (ret) {
> +		pr_err("Soft Reset failed.");

return dev_err_probe(dev, ret, "Soft Reset Failed.\n");

Similar in any other cases where you return on error in probe and want to
print a message.

> +		return ret;
> +	}
> +
> +	ret = smi240_init(smi240_dev);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, 0);
Provide a structure per device which you access via iio_priv() and provide
the size of here.  This is how we get from iio_dev to data the driver is associating
with that iio device.   Things like the spi->dev, and the tx and rx buffers belong
in there.

There are a lot of drivers in the upstream kernel and only a couple of them have
0 size here (for various complex reasons that don't apply here!)

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	iio_device_set_drvdata(indio_dev, smi240_dev);
> +	dev_set_drvdata(dev, indio_dev);
This is a sign that your code is bouncing back and forwards between
devices. If you need to get form iio_dev to your spi dev or similar
add a field to your iio_priv() structure.

> +
> +	indio_dev->dev.parent = dev;
Set by the core - don't do it again.

> +	indio_dev->channels = smi240_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(smi240_channels);
> +	indio_dev->name = SENSOR_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &smi240_info;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "Register IIO device failed");
> +		goto exit_failure;
return dev_err_probe()
> +	}
> +
> +	return ret;
> +
> +exit_failure:
> +	smi240_remove(dev);
> +	return ret;
> +}
> +
> +int smi240_remove(struct device *dev)
> +{
> +	dev_info(dev, "unregister SMI240");
This is debug stuff that does not belong in an upstream driver.
Please make sure to cleanup before submitting.

> +	return 0;
> +}
> diff --git a/drivers/iio/imu/smi240/smi240_spi.c b/drivers/iio/imu/smi240/smi240_spi.c
> new file mode 100644
> index 00000000000..2be6320eaba
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/smi240_spi.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2024 Robert Bosch GmbH.
> + *
No need for this empty line.

> + */
> +
> +#include <linux/module.h>
#include <linux/mod_devicetable.h>

Maybe others are needed - I haven't checked closely.
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <generated/uapi/linux/version.h>

A linux driver module should never care what linux version is.
So we should never see this include.

> +
> +#include "smi240.h"
> +
> +#define SMI240_SPI_MAX_BUFFER_SIZE 32

What is this for?

> +
> +static uint8_t *rx_buf;
> +static uint8_t *tx_buf;
> +static struct spi_device *smi240_spi_dev;
> +static struct smi240_device smi240_dev;
These globals tend to break the case where you have multiple IMUs attached
to one host so look at how all the other drivers avoid this sort
of thing. All data needs to either be const or scoped to a single instance.
You can use a constant template that is copied into per instance cases
though if that reduces complexity of configuration.

> +
> +static int8_t smi240_spi_transfer(uint32_t request, uint32_t *response)
> +{
> +	int8_t ret;
> +	struct spi_message msg;
> +	struct spi_transfer xfer = {
> +		.tx_buf = tx_buf, .rx_buf = rx_buf, .len = 4,
> +		//.bits_per_word = 32,
commented out code does not belong in an upstream driver.

Also format as
	struct spi_transfer xfer = {
		.tx_buf = tx_buf,
		.rx_buf = rx_buf,
		.len = 4,
	};
Note that as this is an spi driver you will need DMA safe buffers
and given they can't have global scope (see above) you will need to
either allocate them and store them in iio_priv() or use the
__aligned(IIO_DMA_MINALIGN) marking that you will find in many other IIO drivers.


> +	};
> +
> +	if (smi240_spi_dev == NULL)
> +		return -ENODEV;
Pass this in from wherever the call is made.
> +
> +	tx_buf[0] = request >> 24;
> +	tx_buf[1] = request >> 16;
> +	tx_buf[2] = request >> 8;
> +	tx_buf[3] = request;

put_unaligned_be32() into a suitable __be32 that you then
pass to spi_write.  Though then you should use
cpu_to_be32() to fill it as it will be aligned.



> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +	ret = spi_sync(smi240_spi_dev, &msg);

spi_write()

> +
> +	if (ret)
> +		return ret;
> +
> +	if (response != NULL)
> +		*response = (rx_buf[0] << 24) | (rx_buf[1] << 16) |
> +			    (rx_buf[2] << 8) | rx_buf[3];
> +
get_unaligned_be32() or if you read into a __be32 (which you should)
be32_to_cpu()

> +	return ret;
> +}
> +
> +static int smi240_spi_probe(struct spi_device *device)
> +{
> +	int err;
> +
> +	device->bits_per_word = 8;
> +	device->max_speed_hz = 10000000;
> +	device->mode = SPI_MODE_0;
> +
> +	err = spi_setup(device);
> +	if (err < 0) {
> +		pr_err("spi_setup err!\n");
> +		return err;
> +	}
> +
> +	if (rx_buf == NULL)
> +		rx_buf = kmalloc(4, GFP_KERNEL);
> +	if (!rx_buf)
> +		return -ENOMEM;
> +
> +	if (tx_buf == NULL)
> +		tx_buf = kmalloc(4, GFP_KERNEL);
> +	if (!tx_buf)
didn't free rx_buf.  Anyhow this code is going away based on other suggestions.
> +		return -ENOMEM;

As elsewhere these need to be per device instance. Put some space
for them in iio_priv(). They aren't so big that we care if another
bus support driver doesn't use them.

> +
> +	smi240_spi_dev = device;
> +
> +	err = smi240_probe(&device->dev, &smi240_dev);
> +	if (err) {
> +		kfree(rx_buf);
> +		rx_buf = NULL;
> +		kfree(tx_buf);
> +		tx_buf = NULL;
You won't need to do most of this after the suggested changes to wehre they
are but if you did, use a goto.

> +		smi240_spi_dev = NULL;
> +		dev_err(&device->dev,
> +			"Bosch Sensor Device %s initialization failed %d",
> +			SENSOR_NAME, err);
> +	} else
> +		dev_info(&device->dev, "Bosch Sensor Device %s initialized",
> +			 SENSOR_NAME);

Too noisy. dev_dbg() at most.

> +
> +	return err;
> +}
> +
> +static void smi240_spi_remove(struct spi_device *device)
> +{
> +	if (rx_buf != NULL) {
> +		kfree(rx_buf);
> +		rx_buf = NULL;
> +	}
> +
> +	if (tx_buf != NULL) {
> +		kfree(tx_buf);
> +		tx_buf = NULL;
When you have these all per device as they must be, then either they will
get cleared up via the existing cleanup of the iio device (if in iio_priv())
or use devm_kzalloc() so they are scoped to the device driver being removed.

> +	}
> +	smi240_remove(&device->dev);
As above, get rid of this function. It does nothing useful.

> +}
> +
> +static const struct spi_device_id smi240_id[] = { { SENSOR_NAME, 0 }, {} };
Format of naming in spi_device_id is not the same as of_match.
Don't use a define for either. I want to see the actual strings here.

Style wise match hwo other drivers do it.
static const struct spi_device_id smi240_id[] = {
	{ SENSOR_NAME, 0 },
	{ }
};

> +
> +MODULE_DEVICE_TABLE(spi, smi240_id);
> +
> +static const struct of_device_id smi240_of_match[] = {
> +	{
> +		.compatible = SENSOR_NAME,
> +	},
> +	{}
trivial: Prefer space between {}
> +};
> +
> +MODULE_DEVICE_TABLE(of, smi240_of_match);
> +
> +static struct spi_driver smi240_driver = {
> +	.driver = {
> +		   .owner = THIS_MODULE,

The registration code handles this so you don't need
to set it manually.
See:
https://elixir.bootlin.com/linux/v6.10/source/include/linux/spi/spi.h#L375

> +		   .name = SENSOR_NAME,
String here as well..
> +		   .of_match_table = smi240_of_match,
> +		    },
	},
not over where you have it.

> +	.id_table = smi240_id,
> +	.probe = smi240_spi_probe,
> +	.remove = smi240_spi_remove,
> +};
> +
> +static int __init smi240_module_init(void)
> +{
> +	int err = 0;
> +
> +	smi240_dev.xfer = smi240_spi_transfer;
> +
> +	err |= spi_register_driver(&smi240_driver);
check each error after the call. Never or them together
as information is lost.  Linux kernel error codes are not
a bitmask.

However, given you shouldn't have that global use
the module_spi_driver() macro to get rid of this.



> +	return err;
> +}
> +
> +static void __exit smi240_module_exit(void)
> +{
> +	spi_unregister_driver(&smi240_driver);
> +}
> +
> +module_init(smi240_module_init);
> +module_exit(smi240_module_exit);
> +
> +MODULE_DESCRIPTION("SMI240 IMU SENSOR DRIVER");

Author?

> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_VERSION(DRIVER_VERSION);


