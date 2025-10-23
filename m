Return-Path: <linux-iio+bounces-25392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E3C02DEA
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 20:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA163AEC18
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 18:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27832224891;
	Thu, 23 Oct 2025 18:16:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA7153BED;
	Thu, 23 Oct 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243397; cv=none; b=SeAEN03psbpVo6GozIgL79qwN0I63YDjAfEwyrVROjtG56jiaqaJnduN5s2Ukpf6L3dpvfDJjI7yiKKk1qcvnzHgoXs2SPLKpXuNd6Wp5lD/s87K3I9+5IvefWEdoj57INu/8HozwlfLwOrsOSmEPwzGaJCJJ4jo24NPxtnqKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243397; c=relaxed/simple;
	bh=L8dU4HjuuI95mGr+wkCxWgUAWVgxK9kNikgME4ulavM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQSCdQWpBnWwupYo9LsVg6WHDz80VJ8YfvVrjtbOw3WvD9Tn324gTc9AKMPnpsUhsQAWx9qh/FK9w8xIWRfaHGb0rQ3VfVZETZIK2kxTkxi/RlcgF41CbGGFz3z6UT0fQeemirOQ01R6G0Rk1i0qkCM5AwNhjVu1jsbQt63k63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4csvKP6LChz6L4ys;
	Fri, 24 Oct 2025 02:13:13 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id F30691402FD;
	Fri, 24 Oct 2025 02:16:29 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 19:16:28 +0100
Date: Thu, 23 Oct 2025 19:16:27 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Aditya Dutt <duttaditya18@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Frank Zago <frank@zago.net>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: position: Add support for ams AS5600 angle
 sensor
Message-ID: <20251023191627.00003b52@huawei.com>
In-Reply-To: <20251020201653.86181-3-duttaditya18@gmail.com>
References: <20251020201653.86181-1-duttaditya18@gmail.com>
	<20251020201653.86181-3-duttaditya18@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 21 Oct 2025 01:46:53 +0530
Aditya Dutt <duttaditya18@gmail.com> wrote:

> The AS5600 is a Hall-based rotary magnetic position sensor using
> planar sensors that convert the magnetic field component perpendicular
> to the surface of the chip into a voltage, or a numerical value
> available through i2c.
> 
> The driver registers the chip as an IIO_ANGL device.
> It also exposes the raw registers through debugfs for further configuration.
> 
> Datasheet: https://ams-osram.com/products/sensor-solutions/position-sensors/ams-as5600-position-sensor
> Co-developed-by: Frank Zago <frank@zago.net>
> Signed-off-by: Frank Zago <frank@zago.net>
> Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>

Hi Aditya, Great to see this driver moving forwards.

A few comments inline on specifics but one thing I'm not sure on is whether
it is actually useful to expose the raw angle channel in real applications.
I'd kind of assume the limits etc would be programmed for a given physical
configuration so it might be sensible to just expose that scaled channel
instead?

Jonathan

> ---
>  Documentation/iio/as5600.rst  |  84 ++++++++
>  Documentation/iio/index.rst   |   1 +
>  MAINTAINERS                   |   8 +
>  drivers/iio/position/Kconfig  |  10 +
>  drivers/iio/position/Makefile |   1 +
>  drivers/iio/position/as5600.c | 373 ++++++++++++++++++++++++++++++++++
>  6 files changed, 477 insertions(+)
>  create mode 100644 Documentation/iio/as5600.rst
>  create mode 100644 drivers/iio/position/as5600.c
> 
> diff --git a/Documentation/iio/as5600.rst b/Documentation/iio/as5600.rst
> new file mode 100644
> index 000000000000..d74c4052e590
> --- /dev/null
> +++ b/Documentation/iio/as5600.rst
> @@ -0,0 +1,84 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=================
> +ams AS5600 driver
> +=================
> +
> +
One blank line is probably enough for readability.

> +Overview
> +========
> +
> +The ams AS5600 is a 12-Bit Programmable Contactless Potentiometer. Its
> +i2c address is 0x36.
> +
> +For more information, see the datasheet at
> +
> +  https://ams-osram.com/products/sensor-solutions/position-sensors/ams-as5600-position-sensor
> +
One blank line here as well.

> +
> +Channels
> +========
> +
> +The driver provides **two channels**:
> +
> +- **Channel 0**: raw, unscaled angle measurement
> +- **Channel 1**: scaled angle measurement according to the configured
> +  ``ZPOS`` / ``MPOS`` range
> +
> +``ZPOS`` and ``MPOS`` let a user restrict the angle returned, which improves
> +the precision returned, since the angle returned is still in the 0 to
> +4095 range. The minimal angle recommended is 18 degrees.
> +
> +The following files are exposed under ``/sys/bus/iio/devices/iio:deviceX``
> +where X is the IIO index of the device.
> +
> ++----------------+-------------------------------------------------+
> +| File           | Description                                     |
> ++================+=================================================+
> +| in_angl0_raw   | Raw angle measurement                           |
> ++----------------+-------------------------------------------------+
> +| in_angl0_scale | Scale for channel 0                             |
> ++----------------+-------------------------------------------------+
> +| in_angl1_raw   | Adjusted angle measurement, scaled by ZPOS/MPOS |
> ++----------------+-------------------------------------------------+
> +| in_angl1_scale | Scale for channel 1                             |
> ++----------------+-------------------------------------------------+
> +
> +
> +Accessing the device registers
> +==============================
> +
> +The driver exposes direct register access via debugfs. This allows reading and
> +writing I2C registers for debugging or configuration.
> +
> +Assuming the device is iio:deviceX, its debugfs path will be:
> +
> +.. code-block:: sh
> +
> +  $ AS5600=/sys/kernel/debug/iio/iio:deviceX/direct_reg_access
> +
> +Locate the index of a register to access in the datasheet, then use
> +the following commands to read a value:
> +
> +.. code-block:: sh
> +
> +  $ echo <reg> > $AS5600/direct_reg_access
> +  $ cat $AS5600/direct_reg_access
> +
> +or this to write a value:
> +
> +.. code-block:: sh
> +
> +  $ echo <reg> <value> > $AS5600/direct_reg_access
> +
> +For instance, this would return the lower byte of RAW ANGLE.
> +
> +.. code-block:: sh
> +
> +  $ echo 0x0D > $AS5600/direct_reg_access
> +  $ cat $AS5600/direct_reg_access
> +
> +.. warning::
> +
> +   Register ``BURN`` (0xFF) permanently modifies device behavior.
> +   Use with caution after reading the datasheet carefully.

Great to have this documentation of useful stuff for a user. Thanks for
including it!
> diff --git a/drivers/iio/position/as5600.c b/drivers/iio/position/as5600.c
> new file mode 100644
> index 000000000000..fe716d521548
> --- /dev/null
> +++ b/drivers/iio/position/as5600.c
> @@ -0,0 +1,373 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ams AS5600 -- 12-Bit Programmable Contactless Potentiometer
> + *
> + * Copyright (c) 2021 Frank Zago
> + * Copyright (c) 2025 Aditya Dutt
> + *
> + * datasheet
> + *    https://ams-osram.com/products/sensor-solutions/position-sensors/ams-as5600-position-sensor
> + *
> + * The rotating magnet is installed from 0.5mm to 3mm parallel to and
> + * above the chip.
> + *
> + * The raw angle value returned by the chip is [0..4095]. The channel
> + * 0 (in_angl0_raw) returns the unscaled and unmodified angle, always
> + * covering the 360 degrees. The channel 1 returns the chip adjusted
> + * angle, covering from 18 to 360 degrees, as modified by its
> + * ZPOS/MPOS/MANG values,

I raise the question below on whether there is value in exposing the raw
angle.  Is userspace ever going to use it?
> + *
> + * ZPOS and MPOS can be programmed through their debugfs entries. The
> + * MANG register doesn't appear to be programmable without flashing
> + * the chip.
Whilst true that you can program them I'd not mention it explicitly. That's
kind of advanced usage that requires someone to really know what they are
doing.

> + *
> + * If the DIR pin is grounded, angles will increase when the magnet is
> + * turned clockwise. If DIR is connected to Vcc, it will be the opposite.
We need a way to know that state I think. So belongs in DT. 
We've had some recent discussions on how to handle tied GPIOs on devices
but for now you'll have to do a property for this.

> + *
> + * The i2c address of the device is 0x36.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>

Follow include what you use principles (mainly - there are a few headers
where we can always assume they should include via another).
e.g. mutex.h should be here.

> +
> +/* Register definitions */
> +#define AS5600_REG_ZMCO              0x00
> +#define     AS5600_MASK_ZMCO         GENMASK(1, 0)
> +#define AS5600_REG_ZPOS_H            0x01
> +#define     AS5600_MASK_ZPOS_H       GENMASK(3, 0) /* bits 11:8 */
Some of these will go away with simplified (less protective) debugfs
interfaces.  Probably you only need to keep the base register and the
mask of the whole thing that you have below.

> +#define AS5600_REG_ZPOS_L            0x02
> +#define AS5600_REG_MPOS_H            0x03
> +#define     AS5600_MASK_MPOS_H       GENMASK(3, 0) /* bits 11:8 */
> +#define AS5600_REG_MPOS_L            0x04
> +#define AS5600_REG_MANG_H            0x05
> +#define     AS5600_MASK_MANG_H       GENMASK(3, 0) /* bits 11:8 */
> +#define AS5600_REG_MANG_L            0x06
> +#define AS5600_REG_CONF_H            0x07
> +#define     AS5600_MASK_CONF_H       GENMASK(5, 0)
> +#define     AS5600_MASK_SF           GENMASK(1, 0)
> +#define     AS5600_MASK_FTH          GENMASK(4, 2)
> +#define     AS5600_MASK_WD           BIT(5)
> +#define AS5600_REG_CONF_L            0x08
> +#define     AS5600_MASK_PM           GENMASK(1, 0)
> +#define     AS5600_MASK_HYST         GENMASK(3, 2)
> +#define     AS5600_MASK_OUTS         GENMASK(5, 4)
> +#define     AS5600_MASK_PWMF         GENMASK(7, 6)
> +#define AS5600_REG_STATUS            0x0B
> +#define     AS5600_MASK_STATUS       GENMASK(5, 3)
These masks will probably go away anyway with simplified debugfs, but
if you had them, they should be built up from the sub fields that follow.

> +#define     AS5600_MASK_MH           BIT(3)
Make the field names include which register they are in. e.g.
#define		AS6500_STATUS_MH
No need to mention mask in a single bit, but do include that
or multi bit fields.


> +#define     AS5600_MASK_ML           BIT(4)
> +#define     AS5600_MASK_MD           BIT(5)
> +#define AS5600_REG_RAW_ANGLE_H       0x0C
> +#define     AS5600_MASK_RAW_ANGLE_H  GENMASK(3, 0) /* bits 11:8 */
> +#define AS5600_REG_RAW_ANGLE_L       0x0D
> +#define AS5600_REG_ANGLE_H           0x0E
> +#define     AS5600_MASK_ANGLE_H      GENMASK(3, 0) /* bits 11:8 */
> +#define AS5600_REG_ANGLE_L           0x0F
> +#define AS5600_REG_AGC               0x1A
> +#define AS5600_REG_MAGN_H            0x1B
> +#define     AS5600_MASK_MAGN_H       GENMASK(3, 0) /* bits 11:8 */
> +#define AS5600_REG_MAGN_L            0x1C
> +#define AS5600_REG_BURN              0xFF
> +
> +/* Combined 16-bit register addresses for clarity */

Don't bother with this.  Just use the starting address defined
above for the calls.  These to my mind just confuse things
by implying there are 16 bit registers when there aren't.

> +#define AS5600_REG_ZPOS              0x01
> +#define AS5600_REG_MPOS              0x03
> +#define AS5600_REG_RAW_ANGLE         0x0C
> +#define AS5600_REG_ANGLE             0x0E
> +
> +/* Field masks for the entire 2 byte */

As above, these are the only ones you should need for these
(after stopping masking in debugfs interfaces).

> +#define AS5600_FIELD_ZPOS            GENMASK(11, 0)
> +#define AS5600_FIELD_MPOS            GENMASK(11, 0)
> +#define AS5600_FIELD_RAW_ANGLE       GENMASK(11, 0)
> +#define AS5600_FIELD_ANGLE           GENMASK(11, 0)
> +
> +struct as5600_priv {
> +	struct i2c_client *client;
> +	struct mutex lock;
> +	u16 zpos;
> +	u16 mpos;
> +};
> +
> +static int as5600_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct as5600_priv *priv = iio_priv(indio_dev);
> +	u16 bitmask;
> +	s32 ret;
> +	u16 reg;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->channel == 0) {
> +			reg = AS5600_REG_RAW_ANGLE;
> +			bitmask = AS5600_FIELD_RAW_ANGLE;

What is the usecase for exposing this RAW angle?

We often decide not to expose channels if they are just there
for debug and aren't useful to userspace code. I'm not sure if
that is true here or not.

> +		} else {
> +			reg = AS5600_REG_ANGLE;
> +			bitmask = AS5600_FIELD_ANGLE;
> +		}
> +		ret = i2c_smbus_read_word_swapped(priv->client, reg);
> +
> +		if (ret < 0)
> +			return ret;
> +		*val = ret & bitmask;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Always 4096 steps, but angle range varies between
Wrap comments at 80 chars, not less than 70. Also
		/*
		 * Always 4096 ...
		 * ...
		 */

For multiline comments in IIO (and most of the rest of the kernel).

> +		 * 18 and 360 degrees.
> +		 */
> +		if (chan->channel == 0) {
> +			/* Whole angle range = 2*pi / 4096 */
> +			*val = 2 * 3141592;
> +			*val2 = 4096000000;
> +		} else {
> +			s32 range;
> +
> +			/* MPOS - ZPOS defines the active angle selection */
> +			/* Partial angle = (range / 4096) * (2*pi / 4096) */
Use multi line comment syntax for htis.
> +			mutex_lock(&priv->lock);
> +			range = priv->mpos - priv->zpos;

As mentioned below. I think reading these back form the device here makes more
sense than caching them.  This is not normally a fast path as typically a userspace
program only does this occasionally.


> +			mutex_unlock(&priv->lock);
> +			if (range <= 0)
> +				range += 4096;
> +
> +			*val = range * 2 * 314159;
> +			*val /= 4096;

Why not push that 4096 into val2? Overflow or something else?  If its overflow
state that here and provide a little info on why.

> +			*val2 = 409600000;
> +		}
> +
> +		return IIO_VAL_FRACTIONAL;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t as5600_reg_access_read( as5600_reg_access_readstruct as5600_priv *priv,
> +				      unsigned int reg, unsigned int *val)
> +{
> +	int ret;
> +	u8 mask;
> +
> +	switch (reg) {
> +	case AS5600_REG_ZMCO:
> +		mask = AS5600_MASK_ZMCO;
> +		break;
> +	case AS5600_REG_ZPOS_H:
> +		mask = AS5600_MASK_ZPOS_H;
> +		break;
> +	case AS5600_REG_MPOS_H:
> +		mask = AS5600_MASK_MPOS_H;
> +		break;
> +	case AS5600_REG_MANG_H:
> +		mask = AS5600_MASK_MANG_H;
> +		break;
> +	case AS5600_REG_CONF_H:
> +		mask = AS5600_MASK_CONF_H;
> +		break;
> +	case AS5600_REG_STATUS:
> +		mask = AAS5600_MASK_STATUSS5600_MASK_STATUS;
> +		break;
> +	case AS5600_REG_RAW_ANGLE_H:
> +		mask = AS5600_MASK_RAW_ANGLE_H;
> +		break;
> +	case AS5600_REG_ANGLE_H:
> +		mask = AS5600_MASK_ANGLE_H;
> +		break;
> +	case AS5600_REG_MAGN_H:
> +		mask = AS5600_MASK_MAGN_H;
> +		break;
> +	case AS5600_REG_ZPOS_L:
> +	case AS5600_REG_MPOS_L:
> +	case AS5600_REG_MANG_L:
> +	case AS5600_REG_CONF_L:
> +	case AS5600_REG_RAW_ANGLE_L:
> +	case AS5600_REG_ANGLE_L:
> +	case AS5600_REG_AGC:
> +	case AS5600_REG_MAGN_L:
> +		mask = 0xFF;
> +		break;
> +	default:
> +		/* Not a readable register */
> +		return -EINVAL;
> +	}
> +
> +
> +	ret = i2c_smbus_read_byte_data(priv->client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* because the chip may return garbage data in the unused bits */
> +	*val = ret & mask;

It's a debug interface only.  I don't think we care if unused bits
are garbage.  More to the point they almost certainly are not. They
are just undocumented. Potentially tied to 0 by maybe not.


> +	return 0;
> +}
> +
> +static ssize_t as5600_reg_access_write(struct as5600_priv *priv,
> +				       unsigned int reg, unsigned int writeval)
> +{
> +	int ret;
> +	u8 mask;
> +
> +	if (writeval > 0xFF)
> +		return -EINVAL;
> +
> +	switch (reg) {
> +	case AS5600_REG_ZPOS_H:
> +		mask = AS5600_MASK_ZPOS_H;

For debug write, this isn't our problem.  Also it is entirely possible someone
wants to write to bits that aren't documented and we shouldn't prevent that.

Debug interfaces let you poke things that are dangerous.


> +		break;
> +	case AS5600_REG_MPOS_H:
> +		mask = AS5600_MASK_MPOS_H;
> +		break;
> +	case AS5600_REG_MANG_H:
> +		mask = AS5600_MASK_MANG_H;
> +		break;
> +	case AS5600_REG_CONF_H:
> +		mask = AS5600_MASK_CONF_H;
> +		break;
> +	case AS5600_REG_ZPOS_L:
> +	case AS5600_REG_MPOS_L:
> +	case AS5600_REG_MANG_L:
> +	case AS5600_REG_CONF_L:
> +	case AS5600_REG_BURN:
> +		mask = 0xFF;
> +		break;
> +	default:
> +		/* Not a writable register */
> +		return -EINVAL;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(priv->client, reg, writeval & mask);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* update priv->zpos and priv->mpos */
> +	mutex_lock(&priv->lock);
guard(mutex)(&priv->lock);
simplifies this a little. Remember to include linux/cleanup.h as well as mutex.h for
that.

> +	switch (reg) {
> +	case AS5600_REG_ZPOS_H:
> +		priv->zpos = (priv->zpos & 0x00FF) | ((writeval & mask) << 8);

This caching in driver seems like potential overkill for the relatively slow
path places I think it is read back. Can you just query the hardware for these?
Of if you need to cache it consider regmap/ regcache for doing so.

> +		break;
> +	case AS5600_REG_ZPOS_L:
> +		priv->zpos = (priv->zpos & 0xFF00) | (writeval & mask);
> +		break;
> +	case AS5600_REG_MPOS_H:
> +		priv->mpos = (priv->mpos & 0x00FF) | ((writeval & mask) << 8);
> +		break;
> +	case AS5600_REG_MPOS_L:
> +		priv->mpos = (priv->mpos & 0xFF00) | (writeval & mask);
> +		break;
> +	}
> +	mutex_unlock(&priv->lock);
with guard() this goes).

> +	return 0;
> +}
> +
> +static int as5600_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval)
> +{
> +	struct as5600_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (readval) {
> +		ret = as5600_reg_access_read(priv, reg, readval);

Might as well return rather than having a local variable.

> +	} else {
> +		ret = as5600_reg_access_write(priv, reg, writeval);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_chan_spec as5600_channels[] = {
> +	{
> +		.type = IIO_ANGL,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
Trivial but nice to align as.
		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
				      BIT(IIO_CHAN_INFO_SCALE),

as helps readability a tiny bit.

> +		.indexed = 1,
> +		.channel = 0,
> +	},
> +	{
> +		.type = IIO_ANGL,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
Same here.

> +		.indexed = 1,
> +		.channel = 1,
> +	},
> +};

> +
> +static int as5600_probe(struct i2c_client *client)
> +{
> +	struct as5600_priv *priv;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

I don't think this is every used.  If not drop setting it.

> +	priv->client = client;
> +	mutex_init(&priv->lock);
For new code please use
	ret = devm_mutex_init(&priv->lock);
	if (ret)
		return ret;

Very small advantage if particular lock debugging is turned on.
It used to not be worth the effort of calling mutex_destroy() but now
there is this devm_ initializer it adds so little complexity we might
as well enable that.

> +
> +	indio_dev->info = &as5600_info;
> +	indio_dev->name = "as5600";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = as5600_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(as5600_channels);
> +
> +	ret = i2c_smbus_read_byte_data(client, AS5600_REG_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* No magnet present could be a problem. */

Seems a bit more than could be.  Does it make sense to carry on if this
happens?  I guess maybe there are physical systems in which the magnet
is only sometime present? If there are then the warning is going to be
a bit noisy.


> +	if ((ret & AS5600_MASK_MD) == 0)
> +		dev_warn(&client->dev, "Magnet not detected\n");
> +
> +	ret = i2c_smbus_read_word_swapped(client, AS5600_REG_ZPOS);
> +	if (ret < 0)
> +		return ret;
> +	priv->zpos = ret & AS5600_FIELD_ZPOS;
Prefer FIELD_GET() for this as then I don't need to check it is in lowest
bits.
> +
> +	ret = i2c_smbus_read_word_swapped(client, AS5600_REG_MPOS);
> +	if (ret < 0)
> +		return ret;
> +	priv->mpos = ret & AS5600_FIELD_MPOS;
FIELD_GET() here as well.

> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id as5600_id[] = {
> +	{ "as5600" },
> +	{}
	{ }

To be consistent and in general this is the standard formatting I'm
trying to encourage in IIO.

> +};
> +MODULE_DEVICE_TABLE(i2c, as5600_id);
> +
> +static const struct of_device_id as5600_match[] = {
> +	{ .compatible = "ams,as5600" },
> +	{ },
No trailing comma for these 'terminating' entries as nothing
should ever come after them.
> +};
> +MODULE_DEVICE_TABLE(of, as5600_match);
> +
> +static struct i2c_driver as5600_driver = {
> +	.driver = {
> +		.name = "as5600",
> +		.of_match_table = as5600_match,
> +	},
> +	.probe = as5600_probe,
> +	.id_table   = as5600_id,

I'd prefer just using a single space before = as it is much
easier to be consistent and void weird looking formatting like
this.

> +};
> +
> +module_i2c_driver(as5600_driver);
> +
> +MODULE_AUTHOR("Frank Zago <frank@zago.net>");
> +MODULE_AUTHOR("Aditya Dutt <duttaditya18@gmail.com>");
> +MODULE_DESCRIPTION("ams AS5600 Position Sensor");
> +MODULE_LICENSE("GPL");


