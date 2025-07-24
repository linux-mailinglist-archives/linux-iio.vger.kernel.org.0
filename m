Return-Path: <linux-iio+bounces-21965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76280B10A33
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 14:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233AB1C25BCF
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2292D12F6;
	Thu, 24 Jul 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjVqDsVU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B62254844;
	Thu, 24 Jul 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360191; cv=none; b=sFhKmDkGoz0GK5xY/sKFUoZC2ylQ0tYgZWJ4mcyHA7GgPIMoSPVQRJ9c4JhWcc3A+yfpj1Tg1TZ6sl9WcQVERmAiWMEdiUyLCvJjT70qLnRKAiu5J4O6f5dIX7qjssr8iFmiAf9kW3OvWhNOgtuAxC5ngmKalH/3cUMMZQINpQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360191; c=relaxed/simple;
	bh=jWGlUrRiCp7OJvkVdFAnx8S5ROKoO7p1IB4tSAjpwhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYZVSfB/OXyXg795Hit7h5hg4dokpD/VMEC0Off/Ar5Pim7w9cSbw2BAfVkYSo2xc7mjFVLPE5SveIL2k9XvlfWEHNE/NO9eW6M7hZIw8Q89ptS5/O+EfUpjki6P6K3EV4o77zRur9t5YKJlx4TEk16Pedegm37RoiXbbhIQdq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjVqDsVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196B6C4CEED;
	Thu, 24 Jul 2025 12:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753360191;
	bh=jWGlUrRiCp7OJvkVdFAnx8S5ROKoO7p1IB4tSAjpwhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tjVqDsVU/VZhNBig1nx/VGJg4CU0nC69jNk+6HHY2J6YjB4GBJqmrkdzj0h2ca2Uk
	 z02AkASTEFir4Afa6Lsi+ktT/fTyfWQr/GeWg+U8/zlTA+gaGWT1u3S7T6gsu83AGr
	 gExlFVg/EFHbaXFkcpyXNbejinZ99f/LbQZQtfGyxlsDEG+HnXZQNTy7gE+X9Mriw4
	 9YjVWWdedRZumGD5VtR+MP653q5f90UN50fZzFqCJ2U8SBhPw5U51rAUbvcSmybQMX
	 ieolUuutM4KGNCBVNJ0UdmYkhovhiclRqDflbsP3kqpDZibn9ziJWvqfAoUm+uFsvq
	 JB/JM8hn2yCiA==
Date: Thu, 24 Jul 2025 13:29:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lakshay Piplani <lakshay.piplani@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt1@gmail.com, gregkh@linuxfoundation.org,
 viro@zeniv.linux.org.uk, peterz@infradead.org, jstephan@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, vikash.bansal@nxp.com, priyanka.jain@nxp.com,
 shashank.rebbapragada@nxp.com, Frank.Li@nxp.com, carlos.song@nxp.com,
 xiaoning.wang@nxp.com, haibo.chen@nxp.com
Subject: Re: [PATCH 2/2] iio: temperature: Add driver for NXP P3T175x
 temperature sensor.
Message-ID: <20250724132940.21d0011c@jic23-huawei>
In-Reply-To: <20250724083951.2273717-2-lakshay.piplani@nxp.com>
References: <20250724083951.2273717-1-lakshay.piplani@nxp.com>
	<20250724083951.2273717-2-lakshay.piplani@nxp.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Jul 2025 14:09:51 +0530
Lakshay Piplani <lakshay.piplani@nxp.com> wrote:

> Add support for the NXP P3T175x (P3T1755/P3T1750)
> family of temperature sensor devices. These devices
> communicates via both I2C or I3C interfaces.

Short wrap. Aim for 75ish chars for patch descriptions vs 80 chars
for code.

>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Various comments inline.  In many cases I've called out a few of things
that occur many times.  Tidy them all up for v2

Biggest thing is that the driver must be buildable for bother i3c and i2c
at the same time.  Otherwise distros will not know how to make the choice
as they have no idea what might show up on the systems they run on.

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/p3t/Kconfig        |  89 ++++
>  drivers/iio/temperature/p3t/Makefile       |   5 +
>  drivers/iio/temperature/p3t/p3t1755.h      |  60 +++
>  drivers/iio/temperature/p3t/p3t1755_core.c | 513 +++++++++++++++++++++
>  drivers/iio/temperature/p3t/p3t1755_i2c.c  | 142 ++++++
>  drivers/iio/temperature/p3t/p3t1755_i3c.c  | 147 ++++++
>  6 files changed, 956 insertions(+)
>  create mode 100644 drivers/iio/temperature/p3t/Kconfig
>  create mode 100644 drivers/iio/temperature/p3t/Makefile
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755.h
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755_core.c
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755_i2c.c
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755_i3c.c
>=20
> diff --git a/drivers/iio/temperature/p3t/Kconfig b/drivers/iio/temperatur=
e/p3t/Kconfig
> new file mode 100644
> index 000000000000..258ff77a0b2d
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/Kconfig
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +menuconfig IIO_P3T1755
> +	tristate "NXP P3T1755 temperature sensor support"
> +	help
> +	  Enable support for the NXP P3T1755 digital temperature sensor family.
> +
> +	  The P3T1755 is a high-accuracy temperature sensor with programmable
> +	  alert limits and fault queue settings. It supports both I2C and I3C
> +	  interfaces for communication and can be used in a variety of embedded
> +	  and industrial applications where precise thermal monitoring is requi=
red.
> +
> +	  This option enables common functionality shared across all supported
> +	  variants and interfaces. You must also select the appropriate interfa=
ce
> +	  (I2C or I3C) and corresponding driver to enable full support
> +
> +
> +if IIO_P3T1755
> +
> +choice
> +	prompt "Interface for P3T1755"
> +	help
> +	  Select the hardware interface used to communicate with the NXP P3T1755
> +	  temperature sensor.
> +
> +	  The P3T1755 supports both I2C and I3C interfaces. Choose the interface
> +	  that matches your hardware configuration. Only one interface can be
> +	  selected at a time. You must also enable the corresponding driver opt=
ion
> +	  to build support for the selected interface

I don't understand this comment.  Are you saying that at build time it
is necessary to pick I2C or I3C?    If that's what this means, fix that as
that's not an acceptable choice.  Where the device is connected is how your
driver chooses which interface to use.

Many drivers manage to do this.  If you can't solve a particular case then
call it out so we can help you figure out how to do it.

> +
> +
> +config IIO_P3T1755_I2C
> +	bool "Use I2C interface"
> +	depends on I2C
> +	help
> +	  Select this option if the P3T1755 temperature sensor is connected via
> +	  the I2C bus.
> +
> +	  This enables support for configuring and communicating with the sensor
> +	  over the I2C interface. You must also enable the corresponding I2C dr=
iver
> +	  (IIO_P3T1755_I2C_DRIVER) to build full support for this interface.
> +
> +
> +config IIO_P3T1755_I3C
> +	bool "Use I3C interface"
> +	depends on I3C
> +	help
> +	  Select this option if the P3T1755 temperature sensor is connected via
> +	  the I3C bus.
> +
> +	  This enables support for configuring and communicating with the sensor
> +	  over the I3C interface. I3C offers improved performance and lower pow=
er
> +	  consumption compared to I2C, making it suitable for advanced applicat=
ions.
> +
> +	  You must also enable the corresponding I3C driver (IIO_P3T1755_I3C_DR=
IVER)
> +	  to build full support for this interface.
> +
> +endchoice
> +
> +config IIO_P3T1755_I2C_DRIVER
> +	tristate "Build I2C driver"
> +	depends on IIO_P3T1755_I2C
> +	select REGMAP_I2C
> +	help
> +	  Enable this option to build the I2C driver for the NXP P3T1755 temper=
ature sensor.
> +
> +	  This driver provides support for communication with the P3T1755 sensor
> +	  over the I2C bus, allowing temperature data to be read and configurat=
ion
> +	  registers to be accessed via the Industrial I/O (IIO) subsystem.
> +
> +	  Select this if your hardware connects the sensor using I2C and you wa=
nt
> +	  to include the driver either built-in or as a loadable module.
> +
> +
> +config IIO_P3T1755_I3C_DRIVER
> +	tristate "Build I3C driver"
> +	depends on IIO_P3T1755_I3C
> +	select REGMAP_I3C
> +	help
> +	  Enable this option to build the I3C driver for the NXP P3T1755 temper=
ature sensor.
> +
> +	  This driver provides support for communication with the P3T1755 sensor
> +	  over the I3C bus, allowing temperature readings and configuration acc=
ess
> +	  through the Industrial I/O (IIO) subsystem.
> +
> +	  Select this if your hardware connects the sensor using I3C and you wa=
nt
> +	  to include the driver either built-in or as a loadable module
> +
> +endif

> diff --git a/drivers/iio/temperature/p3t/p3t1755.h b/drivers/iio/temperat=
ure/p3t/p3t1755.h
> new file mode 100644
> index 000000000000..d71a78460239
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * NXP P3T175x Temperature Sensor Driver
> + *
> + * Copyright 2025 NXP
> + */
> +#ifndef P3T1755_H
> +#define P3T1755_H
> +
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +
> +#define P3T1755_REG_TEMP		0x0
> +#define P3T1755_REG_CFGR		0x1
> +#define P3T1755_REG_LOW_LIM		0x2
> +#define P3T1755_REG_HIGH_LIM		0x3
> +
> +#define P3T1755_SHUTDOWN_BIT		BIT(0)
> +#define P3T1755_TM_BIT			BIT(1)
> +#define P3T1755_POL_BIT			BIT(2)
> +#define P3T1755_R0_BIT			BIT(5)
> +#define P3T1755_R1_BIT			BIT(6)
IS this just a two bit field?  (I don't care if the datasheet describes
it different - if you always  set them together it should be a 2 bit
field via GENMASK(6, 5) in the driver and set with FIELD_PREP()
etc.

> +#define P3T1755_ONE_SHOT_BIT		BIT(7)
> +
> +#define P3T1755_FAULT_QUEUE_SHIFT	3
> +#define P3T1755_FAULT_QUEUE_MASK	GENMASK(4, 3)

> diff --git a/drivers/iio/temperature/p3t/p3t1755_core.c b/drivers/iio/tem=
perature/p3t/p3t1755_core.c
> new file mode 100644
> index 000000000000..8ffa7bb09ca5
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755_core.c
> @@ -0,0 +1,513 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NXP P3T175x Temperature Sensor Driver
> + *
> + * Copyright 2025 NXP
> + */
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/regmap.h>
> +#include <linux/device.h>
> +#include <linux/limits.h>
> +#include <linux/iio/events.h>
> +
> +#include "p3t1755.h"

> +int p3t1755_get_temp_and_limits(struct p3t1755_data *data,
> +				int *temp_mc, int *thigh_mc, int *tlow_mc)
> +{
> +	u8 buf[2];
Probably __be16
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(data->regmap, P3T1755_REG_TEMP, buf, 2);
> +	if (ret) {
> +		dev_dbg(data->dev, "Failed to read TEMP register: %d\n", ret);
> +		return ret;
> +	}
> +	*temp_mc =3D (((buf[0] << 8) | buf[1]) >> 4) * P3T1755_RESOLUTION_10UC =
/ 1000;

All this stuff wants to be in the same units as _RAW not _PROCESSED
and using endian conversion calls.

> +	dev_dbg(data->dev, "TEMP raw: 0x%02x%02x, temp_mc: %d\n",
> +		buf[0], buf[1], *temp_mc);
> +
> +	ret =3D regmap_bulk_read(data->regmap, P3T1755_REG_HIGH_LIM, buf, 2);
> +	if (ret) {
> +		dev_dbg(data->dev, "Failed to read HIGH_LIM register: %d\n", ret);
> +		return ret;
> +	}
> +	*thigh_mc =3D (((buf[0] << 8) | buf[1]) >> 4) * P3T1755_RESOLUTION_10UC=
 / 1000;
> +	dev_dbg(data->dev, "HIGH_LIM raw: 0x%02x%02x, thigh_mc: %d\n",
> +		buf[0], buf[1], *thigh_mc);
> +
> +	ret =3D regmap_bulk_read(data->regmap, P3T1755_REG_LOW_LIM, buf, 2);
> +	if (ret) {
> +		dev_dbg(data->dev, "Failed to read LOW_LIM register: %d\n", ret);
> +		return ret;
> +	}
> +	*tlow_mc =3D (((buf[0] << 8) | buf[1]) >> 4) * P3T1755_RESOLUTION_10UC =
/ 1000;
> +	dev_dbg(data->dev, "LOW_LIM raw: 0x%02x%02x, tlow_mc: %d\n",
> +		buf[0], buf[1], *tlow_mc);
> +
> +	dev_dbg(data->dev, "Successfully read all temperature values\n");
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(p3t1755_get_temp_and_limits, IIO_P3T1755);
> +
> +void p3t1755_push_thresh_event(struct iio_dev *indio_dev)
> +{
> +	struct p3t1755_data *data =3D iio_priv(indio_dev);
> +	enum iio_event_direction dir;
> +	int ret, temp, thigh, tlow;
> +	unsigned int cfgr;
> +
> +	/* Read CFGR register to both check device mode
	/*
	 * Read CFGR ..

and wrap to 80 chars, not 60ish.

> +	 * and implicitly clear the ALERT latch.
> +	 * As per Datasheet: "Any register read will
> +	 * clear the interrupt"
> +	 */
> +	ret =3D regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr);
> +	if (ret) {
> +		dev_dbg(data->dev, "Failed to read CFGR register: %d\n", ret);

Error, so dev_err() appropriate for these if you want to print anything at =
all.

> +		return;
> +	}
> +
> +	if (cfgr & P3T1755_SHUTDOWN_BIT) {

FIELD_GET()

> +		dev_dbg(data->dev, "Device is in shutdown mode, skipping event push\n"=
);
> +		return;
> +	}
> +
> +	ret =3D p3t1755_get_temp_and_limits(data, &temp, &thigh, &tlow);
> +	if (ret) {
> +		dev_dbg(data->dev, "Failed to get temperature and limits: %d\n", ret);
> +		return;
> +	}
> +
> +	// Determine event direction based on threshold crossing
> +	if (temp >=3D thigh) {

For cases where we don't have a flag to tell us what triggered it we can ju=
st report
the direction as 'DIR_EITHER' and let userspace figure it out.

> +		dir =3D IIO_EV_DIR_RISING;
> +	} else if (temp <=3D tlow) {
> +		dir =3D IIO_EV_DIR_FALLING;
> +	} else {
> +		dev_dbg(data->dev, "Temperature within limits: no event triggered (T=
=3D%d, TH=3D%d, TL=3D%d)\n",
> +			temp, thigh, tlow);
> +		return;
> +		}
Check patch and fix all warnings.

> +
> +	dev_dbg(data->dev, "Threshold event: %s (T=3D%d, TH=3D%d, TL=3D%d)\n",
> +		dir =3D=3D IIO_EV_DIR_RISING ? "RISING" : "FALLING",
> +		temp, thigh, tlow);
> +
> +	iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_TEMP, 0, IIO_NO_MOD,
> +						     IIO_EV_TYPE_THRESH, dir),
> +		       iio_get_time_ns(indio_dev));
> +}
> +EXPORT_SYMBOL_NS_GPL(p3t1755_push_thresh_event, IIO_P3T1755);
> +
> +static int p3t1755_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct p3t1755_data *data =3D iio_priv(indio_dev);
> +	u8 buf[2];
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		// Read raw 12-bit temperature register (two bytes)
> +		ret =3D regmap_bulk_read(data->regmap, P3T1755_REG_TEMP, buf, 2);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to read temperature register\n");
> +			return ret;
> +		}
> +		*val =3D ((buf[0] << 8) | buf[1]) >> 4;

As in cases below, endian conversion then shift, so buf should be __be16 I =
think
and then you convert to cpu endian and shift it.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_ENABLE:
> +		// Read configuration register to check shutdown bit
> +		ret =3D regmap_read(data->regmap, P3T1755_REG_CFGR, val);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to read configuration register\n");
> +			return ret;
> +		}
> +		dev_dbg(data->dev, "Read CONFIG: 0x%02x\n", *val);

Excessive even as debug bring.

> +		*val =3D !(*val & P3T1755_SHUTDOWN_BIT); // Return 1 if enabled, 0 if =
shutdown
FIELD_GET()

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		// Read temperature and convert to celsius using resolution
> +		ret =3D regmap_bulk_read(data->regmap, P3T1755_REG_TEMP, buf, 2);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to read temperature register\n");
> +			return ret;
> +		}
> +		*val =3D (((buf[0] << 8) | buf[1]) >> 4) *

As below.  Drop this and add the appropriate _SCALE attribute so userspace =
can
perform the calculation. Lots of reasons for this, but simplest might be th=
at
userspace gets to user floating point.


> +		       P3T1755_RESOLUTION_10UC / 1000;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		unsigned int cfgr;
> +		int ret =3D regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr);

shadowing ret defined above.  Just use that one.

> +
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to read configuration register\n");
> +			return ret;
> +		}
> +
> +		u8 sel =3D (cfgr >> 5) & 0x03; // Extract R1:R0 sampling rate bits

Use a mask as mentioned above and FIELD_GET()

> +
> +		if (sel >=3D ARRAY_SIZE(p3t1755_samp_freqs))
> +			return -EINVAL;
> +
> +		*val =3D p3t1755_samp_freqs[sel].freq_hz;
> +		return IIO_VAL_INT;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int p3t1755_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct p3t1755_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_ENABLE:
> +		// Toggle shutdown bit to enable/disable sensor
> +		ret =3D regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +					 P3T1755_SHUTDOWN_BIT,
> +					 val =3D=3D 0 ? P3T1755_SHUTDOWN_BIT : 0);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to update SHUTDOWN bit\n");
> +			return ret;
		if (ret) is fine for all regmap calls I think.

> +		}
> +		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		u8 sel =3D 0xFF;
> +
> +		// Match desired frequency with supported values
> +		for (int i =3D 0; i < ARRAY_SIZE(p3t1755_samp_freqs); i++) {
> +			if (p3t1755_samp_freqs[i].freq_hz =3D=3D val) {
> +				sel =3D i;
> +				break;
> +			}
> +		}
> +		if (sel =3D=3D 0xFF)
Common approach for a 'I didn't match' that is a little cleaner and makes
less use of local vars is.

		for (i =3D 0; i < ARRAY_SIZE(p3t1755_samp_freqs); i++) {
			if (p3t1755_samp_freqs[i].freq_hz =3D=3D val)
				break;
		}
		if (i =3D=3D ARRAY_SIZE(P3t1755_samp_freqs))
			return -EINVAL;

		return regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
					  P3T1755_R0_BIT | P3T1755_R1_BIT,
					  i << 5);

> +			return -EINVAL;
> +
> +		// Update conversion rate bits R1:R0 in CFGR register
> +		return regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +					  P3T1755_R0_BIT | P3T1755_R1_BIT,
> +					  sel << 5);
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int p3t1755_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int *val,
> +				    int *val2)
> +{
> +	struct p3t1755_data *data =3D iio_priv(indio_dev);
> +	unsigned int reg;
> +	u8 buf[2];
> +	int ret;
> +
> +	if (type !=3D IIO_EV_TYPE_THRESH || info !=3D IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	/* Select high or low limit register based on direction */
> +	reg =3D (dir =3D=3D IIO_EV_DIR_RISING) ? P3T1755_REG_HIGH_LIM :
> +					   P3T1755_REG_LOW_LIM;
> +
> +	/* Convert raw register value to temperature in milli=C2=B0C */
> +	ret =3D regmap_bulk_read(data->regmap, reg, buf, 2);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Failed to read Thigh or Tlow register\n");
> +		return ret;
> +	}
> +	*val =3D (((buf[0] << 8) | buf[1]) >> 4) * P3T1755_RESOLUTION_10UC / 10=
00;

Even thresholds are in raw units if raw is provided (and as below that is a=
ll
that should be provided).  So you may need to unwind scaling if different
to the _RAW channel.

Also, endian conversion then a following shift.  So read it into a __be16
and then use be16_to_cpu() >> 4;

Specific endian calls and types ensure we don't miss a conversion +
may well be more efficient on some CPUs.=20


> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int p3t1755_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info, int val,
> +				     int val2)
> +{
> +	struct p3t1755_data *data =3D iio_priv(indio_dev);
> +	unsigned int reg;
> +	u8 buf[2];
> +	int regval;
> +
> +	if (type !=3D IIO_EV_TYPE_THRESH || info !=3D IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	/* Select high or low limit register based on direction */
> +	reg =3D (dir =3D=3D IIO_EV_DIR_RISING) ? P3T1755_REG_HIGH_LIM :
> +					   P3T1755_REG_LOW_LIM;
> +
> +	/* Convert temperature in milli=C2=B0C to register format */
> +	regval =3D DIV_ROUND_CLOSEST(val * 1000, P3T1755_RESOLUTION_10UC) << 4;
> +	buf[0] =3D regval >> 8;
> +	buf[1] =3D regval & 0xff;

This is an endian conversion.  Use
	cpu_to_be16()
for it and a __be16 for the storage.


> +
> +	return regmap_bulk_write(data->regmap, reg, buf, 2);

sizeof(buf) instead of 2.  Saves a reviewer sanity checking the size.

> +}
> +
> +static int p3t1755_trigger_one_shot(struct p3t1755_data *data)
> +{
> +	unsigned int config;
> +	int ret;
> +
> +	ret =3D regmap_read(data->regmap, P3T1755_REG_CFGR, &config);
 +	if (ret < 0) {
> +		dev_err(data->dev, "Failed to read configuration register\n");
> +		return ret;
> +	}
> +
> +	/* One-shot mode is only allowed when the device is in shutdown mode */

Any locking?  If not this is going to race.

> +	if (!(config & P3T1755_SHUTDOWN_BIT))
> +		return -EBUSY;
> +	/* Set the one-shot bit to trigger a single temperature conversion */
> +	config |=3D P3T1755_ONE_SHOT_BIT;
> +
> +	return regmap_write(data->regmap, P3T1755_REG_CFGR, config);
> +}

> +
> +static ssize_t p3t1755_attr_store(struct device *dev, struct device_attr=
ibute *attr,
> +				  const char *buf, size_t count)
If we keep these attributes, don't share this function. It is very different
for each of the attributes, so just have separate callbacks for each one.

> +{
> +	struct iio_dev_attr *iattr =3D to_iio_dev_attr(attr);
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct p3t1755_data *data =3D iio_priv(indio_dev);
> +	int ret, val;
> +	bool enable;
> +
> +	switch (iattr->address) {
> +	case P3T1755_ATTR_TRIGGER_ONE_SHOT:
> +		/* Trigger a one-shot conversion if input is '1' */
> +		ret =3D kstrtobool(buf, &enable);
> +		if (ret || !enable)
> +			return ret ? ret : -EINVAL;
		if (ret)
			return ret;
		if (!enable)
			return -EINVAL;

Is probably easier to read as checking unrelated conditions.
=20
> +		ret =3D p3t1755_trigger_one_shot(data);
> +		return ret ?: count;
I think I'd prefer the long hand
		if (ret)
			return ret;
		return count;
here as as well.

> +	case P3T1755_ATTR_FAULT_QUEUE_LENGTH:
> +		/* Set fault queue length if input matches supported values */
> +		ret =3D kstrtoint(buf, 10, &val);
> +		if (ret)
> +			return ret;
> +		for (int i =3D 0; i < ARRAY_SIZE(p3t1755_fault_queue_values); i++) {
> +			if (val =3D=3D p3t1755_fault_queue_values[i]) {
Given deep nesting, flip the condition and a continue can help
			if (val !=3D p3t1755_fault_queue_values[i])
				continue;

			ret =3D ...

> +				ret =3D regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +							 P3T1755_FAULT_QUEUE_MASK,
> +							 i << P3T1755_FAULT_QUEUE_SHIFT);
> +				return ret ?: count;
And here.

> +			}
> +		}
> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +		}
> +	}

> +
> +static const struct iio_chan_spec p3t175x_channels[] =3D {
> +	{
> +		.type =3D IIO_TEMP,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_PROCESSED) |
There are only a few reasons we'd have both RAW and PROCESSED in a channel
description.

1. Mistake that we can't fix cleanly - typically we introduced PROCESSED
   only to discover we need RAW when we add buffered support.
2. Non linear transform + need to see raw values for setting thresholds.

Looks linear to me, so _RAW + _SCALE and maybe _OFFSET.
Not _PROCESSED.


> +				      BIT(IIO_CHAN_INFO_ENABLE) |
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.event_spec =3D p3t1755_events,
> +		.num_event_specs =3D ARRAY_SIZE(p3t1755_events),
> +	},
> +};
> +
> +const struct p3t17xx_info p3t1755_channels_info =3D {

Avoid wild cards even in internal struct names.  They break far too often
when manufacturers decide to use the 'gaps' in a number sequence.
Pick one device and name after that.

> +	.name =3D "p3t1755",
> +	.channels =3D p3t175x_channels,
> +	.num_channels =3D ARRAY_SIZE(p3t175x_channels)
> +};
> +EXPORT_SYMBOL_NS(p3t1755_channels_info, IIO_P3T1755);
> +
> +const struct p3t17xx_info p3t1750_channels_info =3D {
> +	.name =3D "p3t1750",
> +	.channels =3D p3t175x_channels,
> +	.num_channels =3D ARRAY_SIZE(p3t175x_channels)
> +};
> +EXPORT_SYMBOL_NS(p3t1750_channels_info, IIO_P3T1755);
> +
> +const struct p3t17xx_info p3t175x_channels_info =3D {
> +	.name =3D "p3t175x",
> +	.channels =3D p3t175x_channels,
> +	.num_channels =3D ARRAY_SIZE(p3t175x_channels)
> +};
> +EXPORT_SYMBOL_NS(p3t175x_channels_info, IIO_P3T1755);
> +
> +static struct attribute *p3t1755_attributes[] =3D {
> +	&iio_dev_attr_thermostat_mode.dev_attr.attr,
> +	&iio_dev_attr_trigger_one_shot.dev_attr.attr,

This one looks like the sort of thing that should be a simple sysfs read
or handled via an IIO trigger (possibly the sysfs trigger).

> +	&iio_dev_attr_fault_queue_length.dev_attr.attr,
> +	NULL,
No comma on terminator + custom ABI.  Needs documentation before we'll cons=
ider it.
Note that custom ABI is nearly unusued ABI, so we are very reluctant to
take it without a strong argument.  If it is something generic then we
figure out how to extend the standard ABI to cover it.

Anyhow, if you really want this stuff then
Documentation/ABI/testing/sysfs-bus-p3t1755


> +};
> +
> +static const struct attribute_group p3t1755_attr_group =3D {
> +	.attrs =3D p3t1755_attributes,
> +};
;
> +
> +int p3t1755_probe(struct device *dev, const struct p3t17xx_info *chip,
> +		  struct regmap *regmap, bool tm_mode, bool alert_active_high, int fq_=
bits)
> +{
> +	struct p3t1755_data *data;
> +	struct iio_dev *iio_dev;
> +	int ret;
> +
> +	iio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(iio_dev);
> +	data->dev =3D dev;
> +	data->regmap =3D regmap;
> +	data->tm_mode =3D tm_mode;
> +	data->alert_active_high =3D alert_active_high;
> +
> +	iio_dev->name =3D chip->name;
> +	iio_dev->modes =3D INDIO_DIRECT_MODE;
> +	iio_dev->info =3D &p3t1755_info;
> +	iio_dev->channels =3D chip->channels;
> +	iio_dev->num_channels =3D chip->num_channels;
> +
> +	dev_set_drvdata(dev, iio_dev);
> +
> +	/* Configure thermostat mode and alert polarity and (optional) fault qu=
eue */
> +	ret =3D regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +				 P3T1755_TM_BIT | P3T1755_POL_BIT,
> +				(tm_mode ? P3T1755_TM_BIT : 0) |
> +				(alert_active_high ? P3T1755_POL_BIT : 0));
> +	if (ret) {
> +		dev_err_probe(data->dev, ret, "Failed to update TM and POL bits\n");
> +		return ret;
> +	}
> +
> +	if (fq_bits >=3D 0) /* -1 means "leave reset default" */
> +		regmap_update_bits(data->regmap, P3T1755_REG_CFGR, P3T1755_FAULT_QUEUE=
_MASK,
> +				   fq_bits << P3T1755_FAULT_QUEUE_SHIFT);
> +
> +	ret =3D devm_iio_device_register(dev, iio_dev);
> +	if (ret)
> +		dev_info(dev, "Temperature sensor failed to register: %d\n", ret);

If this happens then return dev_err_probe()

> +	else
> +		dev_info(dev, "Temperature sensor registered successfully\n");

and nothing here.

> +
> +	return ret;
> +}

> diff --git a/drivers/iio/temperature/p3t/p3t1755_i2c.c b/drivers/iio/temp=
erature/p3t/p3t1755_i2c.c
> new file mode 100644
> index 000000000000..3be8bc8b5e2d
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755_i2c.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NXP P3T175x Temperature Sensor Driver
> + *
> + * Copyright 2025 NXP
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
As below.
> +
> +#include "p3t1755.h"
> +
> +static const struct regmap_config p3t1755_i2c_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +};
> +
> +static irqreturn_t p3t1755_irq_handler(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev =3D dev_id;
> +
> +	dev_dbg(&indio_dev->dev, "IRQ triggered, processing threshold event\n");
> +
> +	// Handle threshold event via helper
As below.

> +	p3t1755_push_thresh_event(indio_dev);
> +
> +	return IRQ_HANDLED;
> +}

> +
> +static int p3t1755_i2c_probe(struct i2c_client *client)
> +{
> +	struct device_node *np =3D client->dev.of_node;

Don't use of specific code anywhere.  property.h stuff always.

> +	bool alert_active_high =3D false;
> +	const struct p3t17xx_info *chip;
> +	struct p3t1755_data *data;
> +	struct iio_dev *iio_dev;
> +	unsigned long irq_flags;
> +	struct regmap *regmap;
> +	bool tm_mode =3D false;
> +	int fq_bits =3D -1;
> +	int ret;
> +
> +	regmap =3D devm_regmap_init_i2c(client, &p3t1755_i2c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err_probe(&client->dev, PTR_ERR(regmap),
> +			      "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	/* Parse optional device tree property for alert polarity */
> +	alert_active_high =3D of_property_read_bool(np, "nxp,alert-active-high"=
);
> +
> +	/* Parse optional device tree property for thermostat mode */
> +	tm_mode =3D of_property_read_bool(np, "nxp,interrupt-mode");
Is your thought that this is wired to something other than the host CPU?

If so things get a little tricky but we should still be able to control this
with standard userspace interfaces.  We enable the event an then don't nece=
ssarily
see it.

> +
> +	/* Optional fault queue length */
> +	if (np) {
> +		u32 fq;
> +
> +		if (!of_property_read_u32(np, "nxp,fault-queue", &fq)) {
> +			fq_bits =3D p3t1755_fault_queue_to_bits(fq);
> +			if (fq_bits < 0) {
> +				dev_err_probe(&client->dev, fq_bits,
> +					      "invalid nxp,fault-queue %u (1/2/4/6)\n", fq);
> +				return fq_bits;
> +			}
> +		}
> +	}
> +
> +	dev_info(&client->dev, "Using TM mode: %s\n",
> +		 tm_mode ? "Interrupt" : "Comparator");
> +	dev_info(&client->dev, "Alert polarity: %s\n",
> +		 alert_active_high ? "Active-High" : "Active-Low");

As below. Drop prints like this.

> +
> +	chip =3D device_get_match_data(&client->dev);

i2c_get_match_data()  The reason being it will first try of_match_id table =
then
fallback to the i2c_device_id table only if necessary.


> +	if (!chip)
> +		chip =3D (const struct p3t17xx_info *)i2c_match_id(p3t1755_i2c_id_tabl=
e,
> +			client)->driver_data;
> +
> +	dev_info(&client->dev, "Registering p3t175x temperature sensor");
> +
> +	ret =3D p3t1755_probe(&client->dev, chip, regmap,
> +			    tm_mode, alert_active_high, fq_bits);
> +
> +	if (ret) {
> +		dev_err_probe(&client->dev, ret, "p3t175x probe failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Setup IRQ if available */
> +	if (client->irq > 0) {

I'd push this irq setup into the core code.  Even though it's not used from=
 i3c
the fact it needs to run late in probe is complicating your handling for no=
 good
reason.  Just pass the irq into p3t1755_probe().  If it's <=3D 0 treat it a=
s no
irq. =20

> +		iio_dev =3D dev_get_drvdata(&client->dev);
> +		data =3D iio_priv(iio_dev);
> +
> +		if (tm_mode)
> +			irq_flags =3D alert_active_high ? IRQF_TRIGGER_RISING : IRQF_TRIGGER_=
FALLING;

This should be coming from DT, not set by the driver based on a different d=
t value.

Have you tried just not setting it?  You may want to query it to set the po=
larity on the
device side though.

> +		else
> +			irq_flags =3D (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING);

() not useful here.

> +
> +		ret =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +						p3t1755_irq_handler, irq_flags | IRQF_ONESHOT,
> +						"p3t175x", iio_dev);
> +		if (ret)
> +			dev_err_probe(&client->dev, ret, "Failed to request IRQ: %d\n", ret);
			return dev_err_probe(dev, ret, "Failed to request IRQ\n");

> +		}
> +
> +		return ret;

		return 0;
	=09
> +}

> diff --git a/drivers/iio/temperature/p3t/p3t1755_i3c.c b/drivers/iio/temp=
erature/p3t/p3t1755_i3c.c
> new file mode 100644
> index 000000000000..37e782241c9a
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755_i3c.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NXP P3T175x Temperature Sensor Driver
> + *
> + * Copyright 2025 NXP
> + */
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>

As below, use accessors in property.h, include it here and you shouldn't
need the of specific header.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
Check all these. Not seeing events.h used in here.

> +
> +#include "p3t1755.h"
> +
> +static void p3t1755_ibi_handler(struct i3c_device *dev,
> +				const struct i3c_ibi_payload *payload)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(&dev->dev);
> +
> +	dev_dbg(&dev->dev, "IBI received, handling threshold event\n");
> +
> +	// Handle threshold event via helper
Fairly obvious comment. Also for IIO all comments in traditional c style.
	/* Handle threshold event via helper */

But I'd drop it as not adding value.

> +	p3t1755_push_thresh_event(indio_dev);
> +}
> +
> +/*
> + * Both P3T1755 and P3T1750 share the same I3C
> + * PID (0x011B:0x152A), making runtime differentiation

Wrap to 80 chars.

> + * impossible, so a common "p3t175x" name in sysfs

What is the point of the dt-binding if we ignore it? Should be able to
first match on a compatible there. =20

Wild cards are a bad idea though so if you can't pick one part and call it
that.  At least avoids potential for something that matches the wild card
but isn't compatible!


> + * and IIO for I3C based instances.
> + */
> +static const struct i3c_device_id p3t1755_i3c_ids[] =3D {
> +	I3C_DEVICE(0x011B, 0x152A, (void *)&p3t175x_channels_info),

Drop the void * cast.  You are casting way from const which we probably don=
't do
and should be no need to cast to void * anwyay.

> +	{ /* sentinel */ },
No trailing comma and these are so common we usually just go with
	{ }
but if you want the comment I don't care that mcuh.

> +};
> +
> +MODULE_DEVICE_TABLE(i3c, p3t1755_i3c_ids);
> +
> +static int p3t1755_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	const struct regmap_config p3t1755_i3c_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
		.reg_bits =3D 8,
		.val_bits =3D 8,
> +	};
> +
> +	const struct i3c_device_id *id =3D i3c_device_match_id(i3cdev, p3t1755_=
i3c_ids);

Seems i3c doesn't yet have equivalent of i2c_get_match_data()

Add one please as that greatly cleans up drivers that just want to get the
data (which is by far the most common case for wanting to get to the device=
_id)

> +	const struct p3t17xx_info *chip =3D &p3t175x_channels_info;
> +	struct device_node *np =3D i3cdev->dev.of_node;
> +	bool alert_active_high =3D false;
> +	struct i3c_ibi_setup ibi_setup;
> +	struct regmap *regmap;
> +	bool tm_mode =3D false;
> +	int fq_bits =3D -1;
> +	int ret;
> +
> +	regmap =3D devm_regmap_init_i3c(i3cdev, &p3t1755_i3c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err_probe(&i3cdev->dev, PTR_ERR(regmap),
> +			      "Failed to register I3C regmap %ld\n", PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	/* Parse optional device tree property for alert polarity */
> +	alert_active_high =3D of_property_read_bool(np, "nxp,alert-active-high"=
);

For all IIO code, use property.h accessors, not the device tree specific on=
es.
That enables this to be used with things like PRP0001 on ACPI platforms.

However, as noted this is a property of the interrupt.  Query that - plenty
of examples in tree of polarity control

> +
> +	/* Parse optional device tree property for thermostat mode */
> +	tm_mode =3D of_property_read_bool(np, "nxp,interrupt-mode");

As observed in the binding review Krzysztof did, why do we need this if
it should always work for i3c?  If there is a requirement on the controller
end that might not be met, that is what we should query, not a dt property.

> +
> +	/* Optional fault queue length */
> +	if (np) {
> +		u32 fq;
> +
> +		if (!of_property_read_u32(np, "nxp,fault-queue", &fq)) {

'smells' like the _period control (though you will need to convert to secon=
ds)
used by userspace to set how long an even must remain true before triggerin=
g an interrupt.

> +			fq_bits =3D p3t1755_fault_queue_to_bits(fq);
> +			if (fq_bits < 0) {
> +				dev_err_probe(&i3cdev->dev, fq_bits,
> +					      "invalid nxp,fault-queue %u (1/2/4/6)\n", fq);
> +				return fq_bits;
> +			}
> +		}
> +	}
> +
> +	dev_info(&i3cdev->dev, "Using TM mode: %s\n", tm_mode ? "Interrupt" : "=
Comparator");
> +	dev_info(&i3cdev->dev, "Alert polarity: %s\n",
> +		 alert_active_high ? "Active-High" : "Active-Low");

All this should be dev_dbg() and only present at all if there is no easy wa=
y to find
it from userspace.

> +
> +	if (id && id->data)
> +		chip =3D (const struct p3t17xx_info *)id->data;
As above. We need a standard helper for i3c to get to the data directly.
Also, id->data is a const void * so no cast is needed here (see the C spec
wrt to casting to and from void pointers).

> +
> +	ret =3D p3t1755_probe(&i3cdev->dev, chip, regmap, tm_mode, alert_active=
_high, fq_bits);

Quite a bit of use of i3cdev->dev, so a local
struct device *dev =3D &i3cdev->dev;
is probably worthwhile to improve readability of all these lines.

> +	if (ret) {
> +		dev_err_probe(&i3cdev->dev, ret, "p3t175x probe failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!tm_mode) {
> +		dev_warn(&i3cdev->dev, "IBI not supported in comparator mode, skipping=
 IBI registration\n");

Not an appropriate warning as lack of functionality should make it clear an=
yway (make sure to not
register events etc if you can't report them). Mind you, not clear why you =
need this anyway
(questions in binding).

> +		return 0;
> +	}
> +
> +	ibi_setup.handler =3D p3t1755_ibi_handler;
> +	ibi_setup.num_slots =3D 4;
> +	ibi_setup.max_payload_len =3D 0;
	ibi_setup =3D (struct i3c_ibi_setup) {
		.handler =3D p3t1755_ibi_handler,
		.slots =3D 4,
		.max_payload_len =3D 0,
	};
> +
> +	ret =3D i3c_device_request_ibi(i3cdev, &ibi_setup);
> +	if (ret) {
> +		dev_err_probe(&i3cdev->dev, ret, "Failed to request IBI: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D i3c_device_enable_ibi(i3cdev);
> +	if (ret) {
> +		dev_err_probe(&i3cdev->dev, ret, "Failed to enable IBI: %d\n", ret);

Look at what dev_err_probe() prints. Don't do your own print of ret.

> +		i3c_device_free_ibi(i3cdev);
With devm as below, this will get cleaned up automatically on returning an =
error.

> +		return ret;
> +	}
> +
> +	dev_info(&i3cdev->dev, "IBI successfully registered\n");

Already called out - don't print on success.  dev_dbg() at most (probably n=
othing is better
still).

> +	return 0;
> +}
> +
> +static void p3t1755_i3c_remove(struct i3c_device *i3cdev)
> +{
> +	/* Unwind IBI registration to ensure clean shutdown */
> +	i3c_device_disable_ibi(i3cdev);
Use devm for this stuff.  Either add
devm_i3c_device_enable_ibi() to the i3c core or if you prefer to keep it lo=
cal

use devm_add_action_or_reset() and a suitable local callback.

> +	i3c_device_free_ibi(i3cdev);
Same here.

Then get rid of remove() callback.

> +}
> +
> +static struct i3c_driver p3t1755_driver =3D {
> +	.driver =3D {
> +		.name =3D "p3t175x_i3c",
> +	},
> +	.probe =3D p3t1755_i3c_probe,
> +	.remove =3D p3t1755_i3c_remove,
> +	.id_table =3D p3t1755_i3c_ids,
> +};
> +module_i3c_driver(p3t1755_driver);

