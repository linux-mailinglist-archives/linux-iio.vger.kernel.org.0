Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B31B1BB817
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgD1Hwi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 03:52:38 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:35297 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbgD1Hwh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 03:52:37 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.16.180])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 5383F4FEEA72;
        Tue, 28 Apr 2020 09:52:30 +0200 (CEST)
Received: from localhost (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 28 Apr
 2020 09:52:29 +0200
Date:   Tue, 28 Apr 2020 09:51:01 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH 1/6] iio: chemical: scd30: add core driver
Message-ID: <20200428075101.GA6908@arch>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
 <20200422141135.86419-2-tomasz.duszynski@octakon.com>
 <20200425195534.2ac91fe6@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200425195534.2ac91fe6@archlinux>
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG2EX2.emp2.local (172.16.2.12) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 16194381311685057618
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedriedtgdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecukfhppedtrddtrddtrddtpdekledrjedtrdefuddrvddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 25, 2020 at 07:55:34PM +0100, Jonathan Cameron wrote:
> On Wed, 22 Apr 2020 16:11:30 +0200
> Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:
>
> > Add Sensirion SCD30 carbon dioxide core driver.
> >
> > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> Hi Tomasz
>
> As you've probably guessed the big questions are around the custom ABI.
>
> Few other things inline.
>
> Jonathan
>
> > ---
> >  drivers/iio/chemical/Kconfig      |  11 +
> >  drivers/iio/chemical/Makefile     |   1 +
> >  drivers/iio/chemical/scd30.h      |  72 +++
> >  drivers/iio/chemical/scd30_core.c | 796 ++++++++++++++++++++++++++++++
> >  4 files changed, 880 insertions(+)
> >  create mode 100644 drivers/iio/chemical/scd30.h
> >  create mode 100644 drivers/iio/chemical/scd30_core.c
> >
> > diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> > index 0b91de4df8f4..55f249333fa2 100644
> > --- a/drivers/iio/chemical/Kconfig
> > +++ b/drivers/iio/chemical/Kconfig
> > @@ -74,6 +74,17 @@ config PMS7003
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
> > index 33d3a595dda9..54abcb641262 100644
> > --- a/drivers/iio/chemical/Makefile
> > +++ b/drivers/iio/chemical/Makefile
> > @@ -11,6 +11,7 @@ obj-$(CONFIG_BME680_SPI) += bme680_spi.o
> >  obj-$(CONFIG_CCS811)		+= ccs811.o
> >  obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
> >  obj-$(CONFIG_PMS7003) += pms7003.o
> > +obj-$(CONFIG_SCD30_CORE) += scd30_core.o
> >  obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
> >  obj-$(CONFIG_SPS30) += sps30.o
> >  obj-$(CONFIG_VZ89X)		+= vz89x.o
> > diff --git a/drivers/iio/chemical/scd30.h b/drivers/iio/chemical/scd30.h
> > new file mode 100644
> > index 000000000000..814782f5e71a
> > --- /dev/null
> > +++ b/drivers/iio/chemical/scd30.h
> > @@ -0,0 +1,72 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _SCD30_H
> > +#define _SCD30_H
> > +
> > +#include <linux/completion.h>
> > +#include <linux/device.h>
> > +#include <linux/i2c.h>
>
> Doesn't make much sense to have an i2c header included here.
>

Will drop.

> > +#include <linux/mutex.h>
> > +#include <linux/pm.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/types.h>
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
> > +	int (*command)(struct scd30_state *state, enum scd30_cmd cmd, u16 arg,
> > +		       char *rsp, int size);
> > +};
> > +
> > +int scd30_suspend(struct device *dev);
> > +int scd30_resume(struct device *dev);
> > +
> > +static SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend, scd30_resume);
> > +
> > +int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
> > +		int (*command)(struct scd30_state *state, enum scd30_cmd cmd,
> > +			       u16 arg, char *rsp, int size));
> > +
> > +#endif
> > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> > new file mode 100644
> > index 000000000000..4dc7e8f9a4f1
> > --- /dev/null
> > +++ b/drivers/iio/chemical/scd30_core.c
> > @@ -0,0 +1,796 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Sensirion SCD30 carbon dioxide sensor core driver
> > + *
> > + * Copyright (c) Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > + */
> > +#include <asm/byteorder.h>
> > +#include <linux/bits.h>
> > +#include <linux/compiler.h>
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
> > +
> > +#include "scd30.h"
> > +
> > +/* pressure compensation in millibars */
> > +#define SCD30_PRESSURE_COMP_MIN 700
> > +#define SCD30_PRESSURE_COMP_MAX 1400
> > +#define SCD30_PRESSURE_COMP_DEFAULT 1013
> > +/* measurement interval in seconds */
> > +#define SCD30_MEAS_INTERVAL_MIN 2
> > +#define SCD30_MEAS_INTERVAL_MAX 1800
> > +#define SCD30_MEAS_INTERVAL_DEFAULT SCD30_MEAS_INTERVAL_MIN
> > +/* reference CO2 concentration in ppm */
> > +#define SCD30_FRC_MIN 400
> > +#define SCD30_FRC_MAX 2000
> > +
> > +enum {
> > +	CONC,
> > +	TEMP,
> > +	HR,
> > +};
> > +
> > +static int scd30_command(struct scd30_state *state, enum scd30_cmd cmd, u16 arg,
> > +			 char *rsp, int size)
> > +{
> > +	int ret;
> > +
> > +	ret = state->command(state, cmd, arg, rsp, size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * assumption holds that response buffer pointer has been already
> > +	 * properly aligned so casts are safe
> > +	 */
> > +	while (size >= sizeof(u32)) {
> > +		*(u32 *)rsp = be32_to_cpup((__be32 *)rsp);
> > +		rsp += sizeof(u32);
> > +		size -= sizeof(u32);
> > +	}
> > +
>
> It's more than a little nasty to rely on the readout either being
> a set of __be32s or a single __be16.
>
> I would break this function into two options and then you can have
> the relevant sized pointer for rsp and drop the various casts.
>
> Alternatively just do the endian conversions where they are needed
> and call the state->command directly.
>

Okay, will rework that.

> > +	if (size)
> > +		*(u16 *)rsp = be16_to_cpup((__be16 *)rsp);
> > +
> > +	return 0;
> > +}
> > +
> > +static int scd30_reset(struct scd30_state *state)
> > +{
> > +	int ret;
> > +	u16 val;
> > +
> > +	ret = scd30_command(state, CMD_RESET, 0, NULL, 0);
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
> > +	scd30_command(state, CMD_MEAS_READY, 0, (char *)&val, sizeof(val));
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
> > +	ret = scd30_command(state, CMD_READ_MEAS, 0, (char *)state->meas,
> > +			    sizeof(state->meas));
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(state->meas); i++)
> > +		state->meas[i] = scd30_float_to_fp(state->meas[i]);
>
> We have previously discussed proving direct floating point channel types
> for the rare devices that actually provide floating point data in
> a standard format.
>
> I'm happy to revisit that if you would like to.
>

Thanks for reminding me :).

In that case I admit that some float helper in iio would be a good thing to
have. Especially that there will be at least 2 sensors using it.

I'd work on that after this driver makes it into the tree.

How does it sound?

> > +
> > +	/*
> > +	 * Accuracy within calibrated operating range is
> > +	 * +-(30ppm + 3% measurement) so fractional part does
> > +	 * not add real value. Moreover, ppm is an integer.
> > +	 */
> > +	state->meas[CONC] /= 100;
> > +
> > +	return 0;
> > +}
> > +
> > +static int scd30_wait_meas_irq(struct scd30_state *state)
> > +{
> > +	int ret, timeout = msecs_to_jiffies(state->meas_interval * 1250);
> > +
> > +	reinit_completion(&state->meas_ready);
> > +	enable_irq(state->irq);
>
> So this is just 'grab the next one'?
>

Yes, grab the fresh one. Moreover enabling interrupts only when necessary can
limit pointless buss traffic. Reason being irq is acknowledged by reading data
from sensor.

> > +	ret = wait_for_completion_interruptible_timeout(&state->meas_ready,
> > +							timeout);
> > +	if (ret > 0)
> > +		ret = 0;
> > +	else if (!ret)
> > +		ret = -ETIMEDOUT;
> > +
>
> I suppose a race here doesn't matter?  Additional interrupt is safe if not
> efficient?
>

Correct. Timeout should not harm anybody.

> > +	disable_irq(state->irq);
> > +
> > +	return ret;
> > +}
> > +
> > +static int scd30_wait_meas_poll(struct scd30_state *state)
> > +{
> > +	int tries = 5;
> > +
> > +	while (tries--) {
> > +		int ret;
> > +		u16 val;
> > +
> > +		ret = scd30_command(state, CMD_MEAS_READY, 0, (char *)&val,
> > +				    sizeof(val));
> > +		if (ret)
> > +			return -EIO;
> > +
> > +		/* new measurement available */
> > +		if (val)
> > +			break;
> > +
> > +		msleep_interruptible(state->meas_interval * 250);
> > +	}
> > +
> > +	if (tries == -1)
> > +		return -ETIMEDOUT;
> > +
> > +	return 0;
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
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		ret = iio_device_claim_direct_mode(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		mutex_lock(&state->lock);
> > +		ret = scd30_read(state);
> > +		memcpy(meas, state->meas, sizeof(meas));
> > +		mutex_unlock(&state->lock);
> > +		iio_device_release_direct_mode(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		switch (chan->type) {
> > +		case IIO_CONCENTRATION:
> > +			*val = meas[chan->address] / 10000;
> > +			*val2 = (meas[chan->address] % 10000) * 100;
> > +			return IIO_VAL_INT_PLUS_MICRO;
> > +		case IIO_TEMP:
> > +		case IIO_HUMIDITYRELATIVE:
> > +			*val = meas[chan->address] * 10;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->type) {
> > +		case IIO_CONCENTRATION:
> > +			*val = 0;
> > +			*val2 = 100;
> > +			return IIO_VAL_INT_PLUS_MICRO;
> > +		case IIO_TEMP:
> > +		case IIO_HUMIDITYRELATIVE:
> > +			*val = 10;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static ssize_t pressure_comp_show(struct device *dev,
> > +				  struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&state->lock);
> > +	ret = sprintf(buf, "%d\n", state->pressure_comp);
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static ssize_t pressure_comp_store(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   const char *buf, size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +	u16 val;
> > +
> > +	if (kstrtou16(buf, 0, &val))
> > +		return -EINVAL;
> > +
> > +	if ((val < SCD30_PRESSURE_COMP_MIN) || (val > SCD30_PRESSURE_COMP_MAX))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&state->lock);
> > +	ret = scd30_command(state, CMD_START_MEAS, val, NULL, 0);
> > +	if (ret)
> > +		goto out;
> > +
> > +	state->pressure_comp = val;
> > +out:
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret ?: len;
> > +}
> > +
> > +static ssize_t pressure_comp_available_show(struct device *dev,
> > +					    struct device_attribute *attr,
> > +					    char *buf)
> > +{
> > +	return sprintf(buf, "[%d %d %d]\n", SCD30_PRESSURE_COMP_MIN, 1,
> > +		       SCD30_PRESSURE_COMP_MAX);
> > +}
> > +
> > +static ssize_t meas_interval_show(struct device *dev,
> > +				  struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +	u16 val;
> > +
> > +	mutex_lock(&state->lock);
> > +	ret = scd30_command(state, CMD_MEAS_INTERVAL, 0, (char *)&val,
> > +			    sizeof(val));
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret ?: sprintf(buf, "%d\n", val);
> > +}
> > +
> > +static ssize_t meas_interval_store(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   const char *buf, size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +	u16 val;
> > +
> > +	if (kstrtou16(buf, 0, &val))
> > +		return -EINVAL;
> > +
> > +	if ((val < SCD30_MEAS_INTERVAL_MIN) || (val > SCD30_MEAS_INTERVAL_MAX))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&state->lock);
> > +	ret = scd30_command(state, CMD_MEAS_INTERVAL, val, NULL, 0);
> > +	if (ret)
> > +		goto out;
> > +
> > +	state->meas_interval = val;
> > +out:
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret ?: len;
> > +}
> > +
> > +static ssize_t meas_interval_available_show(struct device *dev,
> > +					    struct device_attribute *attr,
> > +					    char *buf)
> > +{
> > +	return sprintf(buf, "[%d %d %d]\n", SCD30_MEAS_INTERVAL_MIN, 1,
> > +		       SCD30_MEAS_INTERVAL_MAX);
> > +}
> > +
> > +static ssize_t asc_show(struct device *dev, struct device_attribute *attr,
> > +			char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +	u16 val;
> > +
> > +	mutex_lock(&state->lock);
> > +	ret = scd30_command(state, CMD_ASC, 0, (char *)&val, sizeof(val));
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret ?: sprintf(buf, "%d\n", val);
> > +}
> > +
> > +static ssize_t asc_store(struct device *dev, struct device_attribute *attr,
> > +			 const char *buf, size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +	u16 val;
> > +
> > +	if (kstrtou16(buf, 0, &val))
> > +		return -EINVAL;
> > +
> > +	val = !!val;
> > +	mutex_lock(&state->lock);
> > +	ret = scd30_command(state, CMD_ASC, val, NULL, 0);
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret ?: len;
> > +}
> > +
> > +static ssize_t frc_show(struct device *dev, struct device_attribute *attr,
> > +			char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	u16 val;
> > +	int ret;
> > +
> > +	mutex_lock(&state->lock);
> > +	ret = scd30_command(state, CMD_FRC, 0, (char *)&val, sizeof(val));
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret ?: sprintf(buf, "%d\n", val);
> > +}
> > +
> > +static ssize_t frc_store(struct device *dev, struct device_attribute *attr,
> > +			 const char *buf, size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +	u16 val;
> > +
> > +	if (kstrtou16(buf, 0, &val))
> > +		return -EINVAL;
> > +
> > +	if ((val < SCD30_FRC_MIN) || (val > SCD30_FRC_MAX))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&state->lock);
> > +	ret = scd30_command(state, CMD_FRC, val, NULL, 0);
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret ?: len;
> > +}
> > +
> > +static ssize_t frc_available_show(struct device *dev,
> > +				  struct device_attribute *attr, char *buf)
> > +{
> > +	return sprintf(buf, "[%d %d %d]\n", SCD30_FRC_MIN, 1, SCD30_FRC_MAX);
> > +}
> > +
> > +static ssize_t temp_offset_show(struct device *dev,
> > +				struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +	u16 val;
> > +
> > +	mutex_lock(&state->lock);
> > +	ret = scd30_command(state, CMD_TEMP_OFFSET, 0, (char *)&val,
> > +			    sizeof(val));
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret ?: sprintf(buf, "%d\n", val);
> > +}
> > +
> > +static ssize_t temp_offset_store(struct device *dev,
> > +				 struct device_attribute *attr, const char *buf,
> > +				 size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +	u16 val;
> > +
> > +	if (kstrtou16(buf, 0, &val))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Manufacturer does not explicitly specify min/max sensible values
> > +	 * hence check is omitted for simplicity.
> > +	 */
> > +	mutex_lock(&state->lock);
> > +	ret = scd30_command(state, CMD_TEMP_OFFSET, val, NULL, 0);
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret ?: len;
> > +}
> > +
> > +static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
> > +			   const char *buf, size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct scd30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&state->lock);
> > +	/* after reset previous sensor state will be restored automatically */
> > +	ret = scd30_reset(state);
> > +	mutex_unlock(&state->lock);
> > +
> > +	return ret ?: len;
> > +}
> > +
> > +static IIO_DEVICE_ATTR_RW(pressure_comp, 0);
> > +static IIO_DEVICE_ATTR_RO(pressure_comp_available, 0);
> > +static IIO_DEVICE_ATTR_RW(meas_interval, 0);
> > +static IIO_DEVICE_ATTR_RO(meas_interval_available, 0);
> > +static IIO_DEVICE_ATTR_RW(asc, 0);
> > +static IIO_DEVICE_ATTR_RW(frc, 0);
> > +static IIO_DEVICE_ATTR_RO(frc_available, 0);
> > +static IIO_DEVICE_ATTR_RW(temp_offset, 0);
> > +static IIO_CONST_ATTR(temp_offset_available, "[0 1 65535]");
> > +static IIO_DEVICE_ATTR_WO(reset, 0);
> > +
> > +static struct attribute *scd30_attrs[] = {
>
> As mentioned previously all of these need documentation.
> I'll take a guess at what they are and offer some quick comments though
>
> > +	&iio_dev_attr_pressure_comp.dev_attr.attr,
> > +	&iio_dev_attr_pressure_comp_available.dev_attr.attr,
> These look to be pressure values to allow for compensation?
> Hmm. There is some similar ABI in a few drivers but I'm not sure anything
> exactly matches that one.  We could do it as an output channel.
>
> > +	&iio_dev_attr_meas_interval.dev_attr.attr,
> > +	&iio_dev_attr_meas_interval_available.dev_attr.attr,
>
> Interval is inverse of sampling freqency?
> Do the maths to use that instead.
>
> > +	&iio_dev_attr_asc.dev_attr.attr,
> This is very device specific so may needs special ABI. However
> definitely needs to be written out long hand rather than an acronym
> that will have people reaching for the manual.
>
> > +	&iio_dev_attr_frc.dev_attr.attr,
> > +	&iio_dev_attr_frc_available.dev_attr.attr,
>
> > +	&iio_dev_attr_temp_offset.dev_attr.attr,
> This one looks like a calibration parameter on the temperature
> measurement. We have standard ABI for that.
> > +	&iio_const_attr_temp_offset_available.dev_attr.attr,
> > +	&iio_dev_attr_reset.dev_attr.attr,
>
> Need a strong reason to support reset as a userspace ABI.
> Normally we restrict that to device startup.
>
>
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
> > +};
> > +
> > +#define SCD30_CHAN(_type, _index) \
> > +	.type = _type, \
> > +	.address = _index, \
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> > +	.scan_index = _index
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
> > +		SCD30_CHAN(IIO_CONCENTRATION, CONC),
> > +		SCD30_CHAN_SCAN_TYPE('u', 16),
> > +	},
> > +	{
> > +		SCD30_CHAN(IIO_TEMP, TEMP),
> > +		SCD30_CHAN_SCAN_TYPE('s', 14),
> > +	},
> > +	{
> > +		SCD30_CHAN(IIO_HUMIDITYRELATIVE, HR),
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
> > +	ret = scd30_command(state, CMD_STOP_MEAS, 0, NULL, 0);
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
> > +	return scd30_command(state, CMD_START_MEAS, state->pressure_comp,
> > +			     NULL, 0);
> > +}
> > +EXPORT_SYMBOL(scd30_resume);
> > +
> > +static void scd30_exit(void *data)
> > +{
> > +	struct scd30_state *state = data;
> > +
> > +	scd30_command(state, CMD_STOP_MEAS, 0, NULL, 0);
> > +	regulator_disable(state->vdd);
> > +}
> > +
> > +static irqreturn_t scd30_irq_handler(int irq, void *priv)
> > +{
> > +	struct iio_dev *indio_dev = priv;
> > +
> > +	if (iio_buffer_enabled(indio_dev)) {
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
> > +	/* co2 concentration, temperature, rh, padding, timestamp */
> > +	int data[SCD30_MEAS_COUNT + 1 + 2], ret = 0;
> > +
> > +	mutex_lock(&state->lock);
> > +	if (!iio_trigger_using_own(indio_dev))
> > +		ret = scd30_read_poll(state);
> > +	else
> > +		ret = scd30_read_meas(state);
> > +	memcpy(data, state->meas, sizeof(state->meas));
> > +	mutex_unlock(&state->lock);
> > +	if (ret)
> > +		goto out;
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, data,
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
>
> I'm guessing this is a device without any means to disable the interrupt
> being generated?  In which case are you safe against a race before you
> disable here?
>

IRQs can be actually disabled by telling device to stop taking measurements.
There is dedicated command for that. If irq fires off before being disabled
nothing bad should happen as everything necessary is in place already.

Another thing is that without disabling interrupt here we would get warning
about unbalanced irq whilst enabling trigger.

> > +
> > +	disable_irq(state->irq);
> > +
> > +	return ret;
> > +}
> > +
> > +int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
> > +		int (*command)(struct scd30_state *state, enum scd30_cmd cmd,
> > +			       u16 arg, char *rsp, int size))
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
> > +	dev_set_drvdata(dev, indio_dev);
> > +
> > +	state = iio_priv(indio_dev);
> > +	state->dev = dev;
> > +	state->priv = priv;
> > +	state->irq = irq;
> > +	state->pressure_comp = SCD30_PRESSURE_COMP_DEFAULT;
> > +	state->meas_interval = SCD30_MEAS_INTERVAL_DEFAULT;
> > +	state->command = command;
> > +	mutex_init(&state->lock);
> > +	init_completion(&state->meas_ready);
> > +
> > +	indio_dev->dev.parent = dev;
> > +	indio_dev->info = &scd30_info;
> > +	indio_dev->name = name;
> > +	indio_dev->channels = scd30_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(scd30_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->available_scan_masks = scd30_scan_masks;
> > +
> > +	state->vdd = devm_regulator_get(dev, "vdd");
> > +	if (IS_ERR(state->vdd)) {
>
> This is very noisy if we have deferred probing going on.
> Either explicitly check for that case or just don't bother
> with an error message in this path.
>

Okay.

> > +		dev_err(dev, "failed to get vdd regulator\n");
> > +		return PTR_ERR(state->vdd);
> > +	}
> > +
> > +	ret = regulator_enable(state->vdd);
> > +	if (ret) {
> > +		dev_err(dev, "failed to enable vdd regulator\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_add_action_or_reset(dev, scd30_exit, state);
> > +	if (ret)
>
> This should match exactly against the item above it. Whilst stop
> measurement may be safe from here on, it is not easy to review
> unless we can clearly see where the equivalent start is.
>

Well, naming might be confusing. The thing is that sensor after being
powered up reverts itself to the much the same state it left.

If we have real regulator then scd30_exit would disable regulator and
that's it. But, in case of a dummy one and sensor starting in
continuous mode we waste power for no real reason (for example 19mA
at 0.5Hz).

So it's explanation for doing 2 things inside early on but not excuse
for unintuitive naming.

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
> > +	ret = scd30_command(state, CMD_FW_VERSION, 0, (char *)&val,
> > +			    sizeof(val));
> > +	if (ret) {
> > +		dev_err(dev, "failed to read firmware version: %d\n", ret);
> > +		return ret;
> > +	}
> > +	dev_info(dev, "firmware version: %d.%d\n", val >> 8, (char)val);
> > +
> > +	ret = scd30_command(state, CMD_MEAS_INTERVAL, state->meas_interval,
> > +			    NULL, 0);
> > +	if (ret) {
> > +		dev_err(dev, "failed to set measurement interval: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = scd30_command(state, CMD_START_MEAS, state->pressure_comp,
> > +			    NULL, 0);
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
>
