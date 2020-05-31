Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7021E9A10
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 21:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgEaTYI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 15:24:08 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:53537 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbgEaTYH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 May 2020 15:24:07 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.146.176])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 4544A54BDBBB;
        Sun, 31 May 2020 21:24:02 +0200 (CEST)
Received: from localhost (89.70.180.118) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 31 May
 2020 21:24:01 +0200
Date:   Sun, 31 May 2020 21:21:52 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/4] iio: chemical: scd30: add core driver
Message-ID: <20200531192152.GC27246@arch>
References: <20200530213630.87159-1-tomasz.duszynski@octakon.com>
 <20200530213630.87159-2-tomasz.duszynski@octakon.com>
 <20200531105840.27e17f3d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200531105840.27e17f3d@archlinux>
X-Originating-IP: [89.70.180.118]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 311311328455187538
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeffedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfhfgggtuggjihesthdtredttddtjeenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtheevtefhffduteejfedtkeeuheejgeejvdetfffgveekffefgeffueeghefgjeenucfkpheptddrtddrtddrtddpkeelrdejtddrudektddruddukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehpmhgvvghrfiesphhmvggvrhifrdhnvght
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 31, 2020 at 10:58:40AM +0100, Jonathan Cameron wrote:
> On Sat, 30 May 2020 23:36:27 +0200
> Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:
>
> > Add Sensirion SCD30 carbon dioxide core driver.
> >
> > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
>
> Hi Tomasz
>
> A few things inline.  Includes the alignment issue on
> x86_32 that I fell into whilst trying to fix timestamp
> alignment issues.  Suggested resolution inline for that.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio-scd30 |  20 +
> >  MAINTAINERS                                   |   6 +
> >  drivers/iio/chemical/Kconfig                  |  11 +
> >  drivers/iio/chemical/Makefile                 |   1 +
> >  drivers/iio/chemical/scd30.h                  |  75 ++
> >  drivers/iio/chemical/scd30_core.c             | 764 ++++++++++++++++++
> >  6 files changed, 877 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
> >  create mode 100644 drivers/iio/chemical/scd30.h
> >  create mode 100644 drivers/iio/chemical/scd30_core.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-scd30 b/Documentation/ABI/testing/sysfs-bus-iio-scd30
> > new file mode 100644
> > index 000000000000..a05b1d28e94a
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-scd30
> > @@ -0,0 +1,20 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/calibration
> > +Date:		June 2020
> > +KernelVersion:	5.8
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Contaminants build-up in the measurement chamber or optical
> > +		elements deterioration leads to sensor drift.
> > +
> > +		One can compensate for sensor drift by using either automatic
> > +		self calibration (asc) or forced recalibration (frc). If used
> > +		at once one will overwrite the other.
> > +
> > +		Writing 1 or 0 to this attribute will respectively activate or
> > +		deactivate asc.
> > +
> > +		Picking value from the range [400 1 2000] and writing it to the
> > +		sensor will set frc.
> Seems to me like this would be more intuitive as two separate parameters
> perhaps:
> calibration_auto_enable
> calibration_forced_value
> ?
>

Fine.

> > +
> > +		Upon reading current asc status and frc value are returned
> > +		respectively.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 60ed2963efaa..41a509cca6f1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15137,6 +15137,12 @@ S:	Maintained
> >  F:	drivers/misc/phantom.c
> >  F:	include/uapi/linux/phantom.h
> >
> > +SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
> > +M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > +S:	Maintained
> > +F:	drivers/iio/chemical/scd30.h
> > +F:	drivers/iio/chemical/scd30_core.c
> > +
> >  SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
> >  M:	Tomasz Duszynski <tduszyns@gmail.com>
> >  S:	Maintained
> > diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> > index 7f21afd73b1c..99e852b67e55 100644
> > --- a/drivers/iio/chemical/Kconfig
> > +++ b/drivers/iio/chemical/Kconfig
> > @@ -85,6 +85,17 @@ config PMS7003
> >  	  To compile this driver as a module, choose M here: the module will
> >  	  be called pms7003.
> >
> > +config SCD30_CORE
> > +	tristate "SCD30 carbon dioxide sensor driver"
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	help
> > +	  Say Y here to build support for the Sensirion SCD30 sensor with carbon
> > +	  dioxide, relative humidity and temperature sensing capabilities.
> > +
> > +	  To compile this driver as a module, choose M here: the module will
> > +	  be called scd30_core.
> > +
> >  config SENSIRION_SGP30
> >  	tristate "Sensirion SGPxx gas sensors"
> >  	depends on I2C
> > diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> > index aba4167db745..c9804b041ecd 100644
> > --- a/drivers/iio/chemical/Makefile
> > +++ b/drivers/iio/chemical/Makefile
> > @@ -12,6 +12,7 @@ obj-$(CONFIG_BME680_SPI) += bme680_spi.o
> >  obj-$(CONFIG_CCS811)		+= ccs811.o
> >  obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
> >  obj-$(CONFIG_PMS7003) += pms7003.o
> > +obj-$(CONFIG_SCD30_CORE) += scd30_core.o
> >  obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
> >  obj-$(CONFIG_SPS30) += sps30.o
> >  obj-$(CONFIG_VZ89X)		+= vz89x.o
> > diff --git a/drivers/iio/chemical/scd30.h b/drivers/iio/chemical/scd30.h
> > new file mode 100644
> > index 000000000000..9b25f7423142
> > --- /dev/null
> > +++ b/drivers/iio/chemical/scd30.h
> > @@ -0,0 +1,75 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _SCD30_H
> > +#define _SCD30_H
> > +
> > +#include <linux/completion.h>
> > +#include <linux/device.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pm.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/types.h>
> > +
> > +struct scd30_state;
> > +
> > +enum scd30_cmd {
> > +	/* start continuous measurement with pressure compensation */
> > +	CMD_START_MEAS,
> > +	/* stop continuous measurement */
> > +	CMD_STOP_MEAS,
> > +	/* set/get measurement interval */
> > +	CMD_MEAS_INTERVAL,
> > +	/* check whether new measurement is ready */
> > +	CMD_MEAS_READY,
> > +	/* get measurement */
> > +	CMD_READ_MEAS,
> > +	/* turn on/off automatic self calibration */
> > +	CMD_ASC,
> > +	/* set/get forced recalibration value */
> > +	CMD_FRC,
> > +	/* set/get temperature offset */
> > +	CMD_TEMP_OFFSET,
> > +	/* get firmware version */
> > +	CMD_FW_VERSION,
> > +	/* reset sensor */
> > +	CMD_RESET,
> > +	/*
> > +	 * Command for altitude compensation was omitted intentionally because
> > +	 * the same can be achieved by means of CMD_START_MEAS which takes
> > +	 * pressure above the sea level as an argument.
> > +	 */
> > +};
> > +
> > +#define SCD30_MEAS_COUNT 3
> > +
> > +typedef int (*scd30_command_t)(struct scd30_state *state, enum scd30_cmd cmd,
> > +			       u16 arg, void *response, int size);
> > +
> > +struct scd30_state {
> > +	/* serialize access to the device */
> > +	struct mutex lock;
> > +	struct device *dev;
> > +	struct regulator *vdd;
> > +	struct completion meas_ready;
> > +	void *priv;
> > +	int irq;
> > +	/*
> > +	 * no way to retrieve current ambient pressure compensation value from
> > +	 * the sensor so keep one around
> > +	 */
> > +	u16 pressure_comp;
> > +	u16 meas_interval;
> > +	int meas[SCD30_MEAS_COUNT];
> > +
> > +	scd30_command_t command;
> > +};
> > +
> > +int scd30_suspend(struct device *dev);
> > +int scd30_resume(struct device *dev);
> > +
> > +static __maybe_unused SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend,
> > +					scd30_resume);
> > +
> > +int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
> > +		scd30_command_t command);
> > +
> > +#endif
> > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> > new file mode 100644
> > index 000000000000..3b7d0a7ea7ae
> > --- /dev/null
> > +++ b/drivers/iio/chemical/scd30_core.c
> > @@ -0,0 +1,764 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Sensirion SCD30 carbon dioxide sensor core driver
> > + *
> > + * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > + */
> > +#include <linux/bits.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/export.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/types.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irqreturn.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/string.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/types.h>
> > +#include <asm/byteorder.h>
> > +
> > +#include "scd30.h"
> > +
> > +#define SCD30_PRESSURE_COMP_MIN_MBAR 700
> > +#define SCD30_PRESSURE_COMP_MAX_MBAR 1400
> > +#define SCD30_PRESSURE_COMP_DEFAULT 1013
> > +#define SCD30_MEAS_INTERVAL_MIN_S 2
> > +#define SCD30_MEAS_INTERVAL_MAX_S 1800
> > +#define SCD30_MEAS_INTERVAL_DEFAULT SCD30_MEAS_INTERVAL_MIN_S
> > +#define SCD30_FRC_MIN_PPM 400
> > +#define SCD30_FRC_MAX_PPM 2000
> > +#define SCD30_TEMP_OFFSET_MAX 655360
> > +#define SCD30_EXTRA_TIMEOUT_PER_S 250
> > +
> > +enum {
> > +	SCD30_CONC,
> > +	SCD30_TEMP,
> > +	SCD30_HR,
> > +};
> > +
> > +static int scd30_command_write(struct scd30_state *state, enum scd30_cmd cmd,
> > +			       u16 arg)
> > +{
> > +	return state->command(state, cmd, arg, NULL, 0);
> > +}
> > +
> > +static int scd30_command_read(struct scd30_state *state, enum scd30_cmd cmd,
> > +			      u16 *val)
> > +{
> > +	int ret;
> > +
> > +	ret = state->command(state, cmd, 0, val, sizeof(*val));
> > +	*val = be16_to_cpup((__be16 *)val);
>
> Please use a local variable for the __be16 as it makes thing more readable
> and easier to check for endian problems.
>

Okay.

> > +
> > +	return ret;
> > +}
> > +
> > +static int scd30_reset(struct scd30_state *state)
> > +{
> > +	int ret;
> > +	u16 val;
> > +
> > +	ret = scd30_command_write(state, CMD_RESET, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* sensor boots up within 2 secs */
> > +	msleep(2000);
> > +	/*
> > +	 * Power-on-reset causes sensor to produce some glitch on i2c bus and
> > +	 * some controllers end up in error state. Try to recover by placing
> > +	 * any data on the bus.
> > +	 */
> > +	scd30_command_read(state, CMD_MEAS_READY, &val);
> > +
> > +	return 0;
> > +}
> > +
> > +/* simplified float to fixed point conversion with a scaling factor of 0.01 */
> > +static int scd30_float_to_fp(int float32)
> > +{
> > +	int fraction, shift,
> > +	    mantissa = float32 & GENMASK(22, 0),
> > +	    sign = float32 & BIT(31) ? -1 : 1,
> > +	    exp = (float32 & ~BIT(31)) >> 23;
> > +
> > +	/* special case 0 */
> > +	if (!exp && !mantissa)
> > +		return 0;
> > +
> > +	exp -= 127;
> > +	if (exp < 0) {
> > +		exp = -exp;
> > +		/* return values ranging from 1 to 99 */
> > +		return sign * ((((BIT(23) + mantissa) * 100) >> 23) >> exp);
> > +	}
> > +
> > +	/* return values starting at 100 */
> > +	shift = 23 - exp;
> > +	float32 = BIT(exp) + (mantissa >> shift);
> > +	fraction = mantissa & GENMASK(shift - 1, 0);
> > +
> > +	return sign * (float32 * 100 + ((fraction * 100) >> shift));
> > +}
> > +
> > +static int scd30_read_meas(struct scd30_state *state)
> > +{
> > +	int i, ret;
> > +
> > +	ret = state->command(state, CMD_READ_MEAS, 0, state->meas,
> > +			     sizeof(state->meas));
> > +	if (ret)
> > +		return ret;
> > +
> > +	be32_to_cpu_array(state->meas, state->meas, ARRAY_SIZE(state->meas));
> > +
> > +	for (i = 0; i < ARRAY_SIZE(state->meas); i++)
> > +		state->meas[i] = scd30_float_to_fp(state->meas[i]);
> > +
> > +	return 0;
> > +}
> > +
> > +static int scd30_wait_meas_irq(struct scd30_state *state)
> > +{
> > +	int ret, timeout;
> > +
> > +	timeout = state->meas_interval * (1000 + SCD30_EXTRA_TIMEOUT_PER_S);
> > +	timeout = msecs_to_jiffies(timeout);
> > +	reinit_completion(&state->meas_ready);
> > +	enable_irq(state->irq);
> > +	ret = wait_for_completion_interruptible_timeout(&state->meas_ready,
> > +							timeout);
> > +	if (ret > 0)
> > +		ret = 0;
> > +	else if (!ret)
> > +		ret = -ETIMEDOUT;
> > +
> > +	disable_irq(state->irq);
> > +
> > +	return ret;
> > +}
> > +
> > +static int scd30_wait_meas_poll(struct scd30_state *state)
> > +{
> > +	int timeout = state->meas_interval * SCD30_EXTRA_TIMEOUT_PER_S;
> > +	int tries = 5;
> > +
> > +	do {
> > +		int ret;
> > +		u16 val;
> > +
> > +		ret = scd30_command_read(state, CMD_MEAS_READY, &val);
> > +		if (ret)
> > +			return -EIO;
> > +
> > +		/* new measurement available */
> > +		if (val)
> > +			break;
> > +
> > +		msleep_interruptible(timeout);
> > +	} while (--tries);
> > +
> > +	return tries ? 0 : -ETIMEDOUT;
> > +}
> > +
> > +static int scd30_read_poll(struct scd30_state *state)
> > +{
> > +	int ret;
> > +
> > +	ret = scd30_wait_meas_poll(state);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return scd30_read_meas(state);
> > +}
> > +
> > +static int scd30_read(struct scd30_state *state)
> > +{
> > +	if (state->irq > 0)
> > +		return scd30_wait_meas_irq(state);
> > +
> > +	return scd30_read_poll(state);
> > +}
> > +
> > +static int scd30_read_raw(struct iio_dev *indio_dev,
> > +			  struct iio_chan_spec const *chan,
> > +			  int *val, int *val2, long mask)
> > +{
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret, meas[SCD30_MEAS_COUNT];
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		ret = iio_device_claim_direct_mode(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		mutex_lock(&state->lock);
> > +		ret = scd30_read(state);
> > +		memcpy(meas, state->meas, SCD30_MEAS_COUNT * sizeof(*meas));
>
> The local copy seems a bit excessive.  This isn't likely to be a particularly
> fast path so perhaps skip the copy but hold the locks until we are
> done with the buffer?
>

Okay.

> > +		mutex_unlock(&state->lock);
> > +		iio_device_release_direct_mode(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		switch (chan->type) {
> > +		case IIO_CONCENTRATION:
> > +			*val = meas[chan->address] / 1000000;
> > +			*val2 = meas[chan->address] % 1000000;
> > +
> > +			return IIO_VAL_INT_PLUS_MICRO;
> > +		case IIO_TEMP:
> > +		case IIO_HUMIDITYRELATIVE:
> > +			*val = meas[chan->address] * 10;
> > +
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->type) {
> > +		case IIO_CONCENTRATION:
> > +			*val = 0;
> > +			*val2 = 1;
> > +
> > +			return IIO_VAL_INT_PLUS_MICRO;
> > +		case IIO_TEMP:
> > +		case IIO_HUMIDITYRELATIVE:
> > +			*val = 10;
> > +
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		*val = 0;
> > +		*val2 = 0;
> > +
> > +		mutex_lock(&state->lock);
> > +		ret = scd30_command_read(state, CMD_MEAS_INTERVAL, (u16 *)val2);
>
> See below. I'll assume you'll fix all of these.
>
> > +		mutex_unlock(&state->lock);
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val2 = 1000000000 / *val2;
> > +
> > +		return IIO_VAL_INT_PLUS_NANO;
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		mutex_lock(&state->lock);
> > +		*val = state->pressure_comp / 10;
> > +		*val2 = (state->pressure_comp % 10) * 100000;
> > +		mutex_unlock(&state->lock);
> > +
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		*val = 0;
> > +		mutex_lock(&state->lock);
> > +		ret = scd30_command_read(state, CMD_TEMP_OFFSET, (u16 *)val);
>
> Reading a u16 directly into a int is not a good idea.  What you get will
> depend  on the endianness of the machine.
>

Right, that would obviously break on BE. Sometimes trying to keep number
of local variables low simply stops paying off :).

> Use an intermediate variable of the right size.
>
> > +		mutex_unlock(&state->lock);
> > +
> > +		return IIO_VAL_INT;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int scd30_write_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int val, int val2, long mask)
> > +{
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret = -EINVAL;
> > +
> > +	mutex_lock(&state->lock);
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		if (val)
> > +			break;
> > +
> > +		val = 1000000000 / val2;
> > +		if (val < SCD30_MEAS_INTERVAL_MIN_S ||
> > +		    val > SCD30_MEAS_INTERVAL_MAX_S)
> > +			break;
> > +
> > +		ret = scd30_command_write(state, CMD_MEAS_INTERVAL, val);
> > +		if (ret)
> > +			break;
> > +
> > +		state->meas_interval = val;
> > +		break;
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		val = (val * 1000000 + val2) / 100000;
> > +		if (val < SCD30_PRESSURE_COMP_MIN_MBAR ||
> > +		    val > SCD30_PRESSURE_COMP_MAX_MBAR)
> > +			break;
> > +
> > +		ret = scd30_command_write(state, CMD_START_MEAS, val);
> > +		if (ret)
> > +			break;
> > +
> > +		state->pressure_comp = val;
> > +		break;
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		if (val < 0 || val > SCD30_TEMP_OFFSET_MAX)
> > +			break;
> > +		/*
> > +		 * Manufacturer does not explicitly specify min/max sensible
> > +		 * values hence check is omitted for simplicity.
> > +		 */
> > +		ret = scd30_command_write(state, CMD_TEMP_OFFSET / 10, val);
> > +	}
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int scd30_write_raw_get_fmt(struct iio_dev *indio_dev,
> > +				   struct iio_chan_spec const *chan, long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		return IIO_VAL_INT_PLUS_NANO;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static const int scd30_pressure_calibscale_available[] = {
> > +	SCD30_PRESSURE_COMP_MIN_MBAR / 10, 0,
> > +	0, 100000,
> > +	SCD30_PRESSURE_COMP_MAX_MBAR / 10, 0,
> > +};
> > +
> > +static const int scd30_temp_calibbias_available[] = {
> > +	0, 10, SCD30_TEMP_OFFSET_MAX,
> > +};
> > +
> > +static int scd30_read_avail(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, const int **vals,
> > +			    int *type, int *length, long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		*vals = scd30_pressure_calibscale_available;
> > +		*type = IIO_VAL_INT_PLUS_MICRO;
> > +
> > +		return IIO_AVAIL_RANGE;
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		*vals = scd30_temp_calibbias_available;
> > +		*type = IIO_VAL_INT;
> > +
> > +		return IIO_AVAIL_RANGE;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static ssize_t sampling_frequency_available_show(struct device *dev,
> > +						 struct device_attribute *attr,
> > +						 char *buf)
> > +{
> > +	int i = SCD30_MEAS_INTERVAL_MIN_S;
> > +	ssize_t len = 0;
> > +
> > +	do {
> > +		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
> > +				 1000000000 / i);
> > +		/*
> > +		 * Not all values fit PAGE_SIZE buffer hence print every 6th
> > +		 * (each frequency differs by 6s in time domain from the
> > +		 * adjecent). Unlisted but valid ones are still accepted.
>
> adjacent
>
> Hmm. Maybe we need to think about some description for inverse of linear
> cases as they are likely to be fairly common.
> This will work in meantime.
>
> > +		 */
> > +		i += 6;
> > +	} while (i <= SCD30_MEAS_INTERVAL_MAX_S);
> > +
> > +	buf[len - 1] = '\n';
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t calibration_show(struct device *dev,
> > +				struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	u16 asc, frc;
> > +	int ret;
> > +
> > +	mutex_lock(&state->lock);
> > +	ret = scd30_command_read(state, CMD_ASC, &asc);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = scd30_command_read(state, CMD_FRC, &frc);
> > +out:
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret ?: sprintf(buf, "%d %d\n", asc, frc);
> > +}
> > +
> > +static ssize_t calibration_store(struct device *dev,
> > +				 struct device_attribute *attr, const char *buf,
> > +				 size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +	u16 val;
>
> As commented above, this interface doesn't win on the
> obvious front so needs a rethink!
>
> > +
> > +	ret = kstrtou16(buf, 0, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_lock(&state->lock);
> > +	if (val == 0 || val == 1)
> > +		ret = scd30_command_write(state, CMD_ASC, val);
> > +	else if (val >= SCD30_FRC_MIN_PPM && val <= SCD30_FRC_MAX_PPM)
> > +		ret = scd30_command_write(state, CMD_FRC, val);
> > +	else
> > +		ret = -EINVAL;
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret ?: len;
> > +}
> > +
> > +static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
> > +static IIO_DEVICE_ATTR_RW(calibration, 0);
> > +
> > +static struct attribute *scd30_attrs[] = {
> > +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> > +	&iio_dev_attr_calibration.dev_attr.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group scd30_attr_group = {
> > +	.attrs = scd30_attrs,
> > +};
> > +
> > +static const struct iio_info scd30_info = {
> > +	.attrs = &scd30_attr_group,
> > +	.read_raw = scd30_read_raw,
> > +	.write_raw = scd30_write_raw,
> > +	.write_raw_get_fmt = scd30_write_raw_get_fmt,
> > +	.read_avail = scd30_read_avail,
> > +};
> > +
> > +#define SCD30_CHAN_SCAN_TYPE(_sign, _realbits) .scan_type = { \
> > +	.sign = _sign, \
> > +	.realbits = _realbits, \
> > +	.storagebits = 32, \
> > +	.endianness = IIO_CPU, \
> > +}
> > +
> > +static const struct iio_chan_spec scd30_channels[] = {
> > +	{
> > +		.type = IIO_PRESSURE,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE),
> > +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBSCALE),
> > +		.scan_index = -1,
> > +	},
> > +	{
> > +		.type = IIO_CONCENTRATION,
> > +		.channel2 = IIO_MOD_CO2,
> > +		.address = SCD30_CONC,
> > +		.scan_index = SCD30_CONC,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +		.modified = 1,
> > +
> > +		SCD30_CHAN_SCAN_TYPE('u', 16),
> > +	},
> > +	{
> > +		.type = IIO_TEMP,
> > +		.address = SCD30_TEMP,
> > +		.scan_index = SCD30_TEMP,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > +				      BIT(IIO_CHAN_INFO_CALIBBIAS) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
>
> Combination of processed and scale is unusual.  Normally scale provides
> a conversion factor or a _RAW reading.

Right that's pointless. Scales were for raw measurements inside buffer.
Somehow I failed to realize that only co2 concentration is raw.

>
> I 'think' these units are otherwise fine (milli degrees centigrade)
>
>
> > +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBBIAS),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +
> > +		SCD30_CHAN_SCAN_TYPE('s', 14),
> > +	},
> > +	{
> > +		.type = IIO_HUMIDITYRELATIVE,
> > +		.address = SCD30_HR,
> > +		.scan_index = SCD30_HR,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
>
> As above. Not normal to see scale and processed.
>
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +
> > +		SCD30_CHAN_SCAN_TYPE('u', 14),
> > +	},
> > +	IIO_CHAN_SOFT_TIMESTAMP(3),
> > +};
> > +
> > +int __maybe_unused scd30_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct scd30_state *state  = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = scd30_command_write(state, CMD_STOP_MEAS, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return regulator_disable(state->vdd);
> > +}
> > +EXPORT_SYMBOL(scd30_suspend);
> > +
> > +int __maybe_unused scd30_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = regulator_enable(state->vdd);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return scd30_command_write(state, CMD_START_MEAS, state->pressure_comp);
> > +}
> > +EXPORT_SYMBOL(scd30_resume);
> > +
> > +static void scd30_stop_meas(void *data)
> > +{
> > +	struct scd30_state *state = data;
> > +
> > +	scd30_command_write(state, CMD_STOP_MEAS, 0);
> > +}
> > +
> > +static void scd30_disable_regulator(void *data)
> > +{
> > +	struct scd30_state *state = data;
> > +
> > +	regulator_disable(state->vdd);
> > +}
> > +
> > +static irqreturn_t scd30_irq_handler(int irq, void *priv)
> > +{
> > +	struct iio_dev *indio_dev = priv;
> > +
> > +	if (iio_buffer_enabled(indio_dev)) {
>
> There is a potential quirk here.  It's possible that
> this device is using a different trigger, but another device
> is registered to use this one.  If that happens this check
> will be a bit counter intuitive.
>
> As such you might want to provide the validate callback so
> that this device is the only device allowed to use it's
> own trigger.
>

Right. This needs to be fixed.

> > +		iio_trigger_poll(indio_dev->trig);
> > +
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	return IRQ_WAKE_THREAD;
> > +}
> > +
> > +static irqreturn_t scd30_irq_thread_handler(int irq, void *priv)
> > +{
> > +	struct iio_dev *indio_dev = priv;
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = scd30_read_meas(state);
> > +	if (ret)
> > +		goto out;
> > +
> > +	complete_all(&state->meas_ready);
> > +out:
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t scd30_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	struct {
> > +		int data[SCD30_MEAS_COUNT];
> > +		u64 ts;
>
> Turns out I was wrong when suggesting this approach for drivers.  On x86_32
> this will result in there not being any padding between the
> data and the timestamp (and in IIO rule of naturally aligned there
> needs to be 4 bytes there).  Result is that this structure is
> too short.  (thanks btw to Andy who pointed out this issue!)
>
> So, to force that my current preference is.
>
> 	struct {
> 		int data[SCD30_MEAS_COUNT];
> 		s64 ts __aligned(8);
> 	} scan;
>

Ah, so x86_32 aligns s64 to 4 bytes.

> However, given we do have a hole in the structure there is
> a kernel data leak.  So either you need to zero it here,
> or move it into the iio_priv() structure.  Doing that
> will ensure it is zeroed at allocation.
>
> > +	} scan;
> > +	int ret;
> > +
> > +	mutex_lock(&state->lock);
> > +	if (!iio_trigger_using_own(indio_dev))
> > +		ret = scd30_read_poll(state);
> > +	else
> > +		ret = scd30_read_meas(state);
> > +	memcpy(scan.data, state->meas, sizeof(state->meas));
> > +	mutex_unlock(&state->lock);
> > +	if (ret)
> > +		goto out;
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> > +					   iio_get_time_ns(indio_dev));
> > +out:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int scd30_set_trigger_state(struct iio_trigger *trig, bool state)
> > +{
> > +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > +	struct scd30_state *st = iio_priv(indio_dev);
> > +
> > +	if (state)
> > +		enable_irq(st->irq);
> > +	else
> > +		disable_irq(st->irq);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct iio_trigger_ops scd30_trigger_ops = {
> > +	.set_trigger_state = scd30_set_trigger_state,
> > +};
> > +
> > +static int scd30_setup_trigger(struct iio_dev *indio_dev)
> > +{
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	struct device *dev = indio_dev->dev.parent;
> > +	struct iio_trigger *trig;
> > +	int ret;
> > +
> > +	trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> > +				      indio_dev->id);
> > +	if (!trig) {
> > +		dev_err(dev, "failed to allocate trigger\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	trig->dev.parent = dev;
> > +	trig->ops = &scd30_trigger_ops;
> > +	iio_trigger_set_drvdata(trig, indio_dev);
> > +
> > +	ret = devm_iio_trigger_register(dev, trig);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->trig = iio_trigger_get(trig);
> > +
> > +	ret = devm_request_threaded_irq(dev, state->irq, scd30_irq_handler,
> > +					scd30_irq_thread_handler,
> > +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > +					indio_dev->name, indio_dev);
> > +	if (ret)
> > +		dev_err(dev, "failed to request irq\n");
> > +
> > +	disable_irq(state->irq);
>
> Given there is a gap between the request above and this disable, this
> disable needs a comment explaining why it is here.
>
> I'm assuming it's an optimization?
>

Interrupt is enabled just before taking measurement to grab the fresh
data and disabled afterwards. Not disabling it here would produce fat warning
about unbalanced irqs.

And that is because sensor takes measurements continuously. On demand
mode, even though possible, doesn't work reliably. Sensor (at least the one
sitting on my desk) needs way too much time to wakeup and grab measurement which
makes the whole point of adjustable sampling frequency pointless :).

> > +
> > +	return ret;
> > +}
> > +
> > +int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
> > +		scd30_command_t command)
> > +{
> > +	static const unsigned long scd30_scan_masks[] = { 0x07, 0x00 };
> > +	struct scd30_state *state;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +	u16 val;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	state = iio_priv(indio_dev);
> > +	state->dev = dev;
>
> Doesn't seem to be used.
>
> > +	state->priv = priv;
>
> What's this for?  At least at first glance I can't find it being used
> anywhere.
>
> > +	state->irq = irq;
> > +	state->pressure_comp = SCD30_PRESSURE_COMP_DEFAULT;
> > +	state->meas_interval = SCD30_MEAS_INTERVAL_DEFAULT;
> > +	state->command = command;
> > +	mutex_init(&state->lock);
> > +	init_completion(&state->meas_ready);
> > +
> > +	dev_set_drvdata(dev, indio_dev);
> > +
> > +	indio_dev->dev.parent = dev;
>
> Side note that there is a series moving this into the core under revision at
> the moment.  Hopefully I'll remember to fix this up when applying your patch
> if that one has gone in ahead of it.
>
> > +	indio_dev->info = &scd30_info;
> > +	indio_dev->name = name;
> > +	indio_dev->channels = scd30_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(scd30_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->available_scan_masks = scd30_scan_masks;
> > +
> > +	state->vdd = devm_regulator_get(dev, "vdd");
> > +	if (IS_ERR(state->vdd)) {
> > +		if (PTR_ERR(state->vdd) == -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +
> > +		dev_err(dev, "failed to get regulator\n");
> > +		return PTR_ERR(state->vdd);
> > +	}
> > +
> > +	ret = regulator_enable(state->vdd);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_add_action_or_reset(dev, scd30_disable_regulator, state);
> > +	if (ret)
> > +		return ret;
> > +
>
> A comment here on why it makes sense to register this here.  What
> started mesurement? It seems that happens well below here so
> we should really call this after that start all.
>

Sensor after being powered up starts in mode it was left in.
Chances are it was continuous mode and we want to shut it down.

> > +	ret = devm_add_action_or_reset(dev, scd30_stop_meas, state);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = scd30_reset(state);
> > +	if (ret) {
> > +		dev_err(dev, "failed to reset device: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	if (state->irq > 0) {
> > +		ret = scd30_setup_trigger(indio_dev);
> > +		if (ret) {
> > +			dev_err(dev, "failed to setup trigger: %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +					      scd30_trigger_handler, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = scd30_command_read(state, CMD_FW_VERSION, &val);
> > +	if (ret) {
> > +		dev_err(dev, "failed to read firmware version: %d\n", ret);
> > +		return ret;
> > +	}
> > +	dev_info(dev, "firmware version: %d.%d\n", val >> 8, (char)val);
> > +
> > +	ret = scd30_command_write(state, CMD_MEAS_INTERVAL,
> > +				  state->meas_interval);
> > +	if (ret) {
> > +		dev_err(dev, "failed to set measurement interval: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = scd30_command_write(state, CMD_START_MEAS, state->pressure_comp);
> > +	if (ret) {
> > +		dev_err(dev, "failed to start measurement: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> > +EXPORT_SYMBOL(scd30_probe);
> > +
> > +MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
> > +MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor core driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.26.2
> >
>
