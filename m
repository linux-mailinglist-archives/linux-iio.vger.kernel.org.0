Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C0C3FBAA1
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 19:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhH3RI7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 13:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231890AbhH3RI7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 13:08:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F37B460F42;
        Mon, 30 Aug 2021 17:08:03 +0000 (UTC)
Date:   Mon, 30 Aug 2021 18:11:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3.1 2/3] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <20210830181117.6808f085@jic23-huawei>
In-Reply-To: <20210830162051.rjqlhwvtguaivt3p@uno.localdomain>
References: <20210822184927.94673-3-jacopo@jmondi.org>
        <20210823073639.13688-1-jacopo@jmondi.org>
        <20210829175413.7ce30bfa@jic23-huawei>
        <20210830162051.rjqlhwvtguaivt3p@uno.localdomain>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Aug 2021 18:20:51 +0200
Jacopo Mondi <jacopo@jmondi.org> wrote:

> Hi Jonathan,
>    thanks for review
> 
> On Sun, Aug 29, 2021 at 05:54:13PM +0100, Jonathan Cameron wrote:
> > On Mon, 23 Aug 2021 09:36:39 +0200
> > Jacopo Mondi <jacopo@jmondi.org> wrote:
> >  
> > > Add support for the Senseair Sunrise 006-0-0007 driver through the
> > > IIO subsystem.
> > >
> > > Datasheet: https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/TDE5531.pdf
> > > Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> > > ---
> > > v3->v3.1  
> >
> > Always do a new version of the whole series.  The automated tools that maintainers
> > mostly use these days (e.g. b4) are pointed out a whole series when picking it up.
> >
> > This means we have to do it manually, one patch at a time I think which is annoying.
> >  
> 
> Right, sorry, it's pretty common in other subsystems for minor
> updates, but I understand it's more work on your side! Sorry about
> that!
> 
> >  
> > > - Remove debug leftover
> > > - Re-add commas at the end of arrays declarations
> > > ---
> > >  MAINTAINERS                        |   6 +
> > >  drivers/iio/chemical/Kconfig       |  13 +
> > >  drivers/iio/chemical/Makefile      |   1 +
> > >  drivers/iio/chemical/sunrise_co2.c | 448 +++++++++++++++++++++++++++++
> > >  4 files changed, 468 insertions(+)
> > >  create mode 100644 drivers/iio/chemical/sunrise_co2.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 90ca9df1d3c3..43f5bba46673 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -16544,6 +16544,12 @@ S:	Maintained
> > >  F:	drivers/misc/phantom.c
> > >  F:	include/uapi/linux/phantom.h
> > >
> > > +SENSEAIR SUNRISE 006-0-0007
> > > +M:	Jacopo Mondi <jacopo@jmondi.org>
> > > +S:	Maintained
> > > +F:	Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
> > > +F:	drivers/iio/chemical/sunrise_co2.c
> > > +
> > >  SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
> > >  M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > >  S:	Maintained
> > > diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> > > index 10bb431bc3ce..ee8562949226 100644
> > > --- a/drivers/iio/chemical/Kconfig
> > > +++ b/drivers/iio/chemical/Kconfig
> > > @@ -144,6 +144,19 @@ config SPS30
> > >  	  To compile this driver as a module, choose M here: the module will
> > >  	  be called sps30.
> > >
> > > +config SENSEAIR_SUNRISE_CO2
> > > +	tristate "Senseair Sunrise 006-0-0007 CO2 sensor"
> > > +	depends on OF  
> >
> > Not needed.
> >  
> 
> Well, the driver won't be probed as it doesn't have an i2c id table.
> But I guess it compiles fine

So you'd think.  But let me introduce you to ACPI PRP0001 which oddly uses
the of_device_id table to bind to a device in an ACPI DSDT table ;)

> > > +	depends on I2C  
> >
> > regmap_i2c select should bring that in.
> >  
> > > +	depends on SYSFS  
> >
> > I'd be surprised if this necessary...   Everything should be stubbed appropriately if
> > its' not there.  
> 
> I asked the same question as I didn't find any symbol related to
> iio/sysfs to depend on. I should have guessed it is not needed
> 
> > > +	select REGMAP_I2C
> > > +	help
> > > +	  Say yes here to build support for Senseair Sunrise 006-0-0007 CO2
> > > +	  sensor.
> > > +
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called sunrise_co2.
> > > +
> > >  config VZ89X
> > >  	tristate "SGX Sensortech MiCS VZ89X VOC sensor"
> > >  	depends on I2C
> > > diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> > > index fef63dd5bf92..d5e2a3331d57 100644
> > > --- a/drivers/iio/chemical/Makefile
> > > +++ b/drivers/iio/chemical/Makefile
> > > @@ -17,4 +17,5 @@ obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
> > >  obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
> > >  obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
> > >  obj-$(CONFIG_SPS30) += sps30.o
> > > +obj-$(CONFIG_SENSEAIR_SUNRISE_CO2) += sunrise_co2.o
> > >  obj-$(CONFIG_VZ89X)		+= vz89x.o
> > > diff --git a/drivers/iio/chemical/sunrise_co2.c b/drivers/iio/chemical/sunrise_co2.c
> > > new file mode 100644
> > > index 000000000000..84f19df6fc00
> > > --- /dev/null
> > > +++ b/drivers/iio/chemical/sunrise_co2.c
> > > @@ -0,0 +1,448 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Senseair Sunrise 006-0-0007 CO2 sensor driver.
> > > + *
> > > + * Copyright (C) 2021 Jacopo Mondi
> > > + *
> > > + * List of features not yet supported by the driver:
> > > + * - controllable EN pin
> > > + * - single-shot operations using the nDRY pin.
> > > + * - ABC/target calibration
> > > + */
> > > +
> > > +#include <linux/bitops.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/time64.h>
> > > +
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/sysfs.h>  
> >
> > What are you using from this header?
> >  
> 
> Leftover from when I used raw attributes. I'll drop
> 
> > > +
> > > +#define DRIVER_NAME "sunrise"
> > > +
> > > +#define SUNRISE_ERROR_STATUS_REG		0x00
> > > +#define SUNRISE_CO2_FILTERED_COMP_REG		0x06
> > > +#define SUNRISE_CHIP_TEMPERATURE_REG		0x08
> > > +#define SUNRISE_CALIBRATION_STATUS_REG		0x81
> > > +#define SUNRISE_CALIBRATION_COMMAND_REG		0x82
> > > +#define SUNRISE_CALIBRATION_FACTORY_CMD		0x7c02
> > > +#define SUNRISE_CALIBRATION_BACKGROUND_CMD	0x7c06
> > > +/*
> > > + * The calibration timeout is not characterized in the datasheet.
> > > + * Use 30 seconds as a reasonable upper limit.
> > > + */
> > > +#define SUNRISE_CALIBRATION_TIMEOUT_US		(30 * USEC_PER_SEC)
> > > +
> > > +enum sunrise_calib {
> > > +	SUNRISE_CALIBRATION_FACTORY,
> > > +	SUNRISE_CALIBRATION_BACKGROUND,
> > > +};
> > > +
> > > +struct sunrise_dev {
> > > +	struct device *dev;
> > > +	struct i2c_client *client;
> > > +	struct regmap *regmap;
> > > +	struct mutex lock;
> > > +	enum sunrise_calib calibration;
> > > +};
> > > +
> > > +static void sunrise_wakeup(struct sunrise_dev *sunrise)
> > > +{
> > > +	struct i2c_client *client = sunrise->client;
> > > +
> > > +	/*
> > > +	 * Wake up sensor by sending sensor address: START, sensor address,
> > > +	 * STOP. Sensor will not ACK this byte.
> > > +	 *
> > > +	 * The chip returns in low power state after 15msec without
> > > +	 * communications or after a complete read/write sequence.
> > > +	 */
> > > +	i2c_smbus_xfer(client->adapter, client->addr, I2C_M_IGNORE_NAK,
> > > +		       I2C_SMBUS_WRITE, 0, I2C_SMBUS_QUICK, NULL);
> > > +}
> > > +
> > > +static int sunrise_read_word(struct sunrise_dev *sunrise, u8 reg, u16 *val)
> > > +{
> > > +	__be16 be_val;
> > > +	int ret;
> > > +
> > > +	sunrise_wakeup(sunrise);
> > > +	ret = regmap_bulk_read(sunrise->regmap, reg, &be_val, 2);
> > > +	if (ret) {
> > > +		dev_err(sunrise->dev, "Read word failed: reg 0x%2x (%d)\n", reg, ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	*val = be16_to_cpu(be_val);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int sunrise_write_byte(struct sunrise_dev *sunrise, u8 reg, u8 val)
> > > +{
> > > +	int ret;
> > > +
> > > +	sunrise_wakeup(sunrise);
> > > +	ret = regmap_write(sunrise->regmap, reg, val);
> > > +	if (ret) {
> > > +		dev_err(sunrise->dev, "Write byte failed: reg 0x%2x (%d)\n", reg, ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int sunrise_write_word(struct sunrise_dev *sunrise, u8 reg, u16 data)
> > > +{
> > > +	__be16 be_data = cpu_to_be16(data);
> > > +	int ret;
> > > +
> > > +	sunrise_wakeup(sunrise);  
> >
> > Hmm. Technically there isn't anything stopping another user of the i2c bus sneaking in
> > between the wakeup and the following command.  That would make the device going back
> > to sleep a lot more likely.  I can't off the top of my head remember if regmap lets
> > you lock the bus.  If not, you'll have to use the underlying i2c bus locking functions.
> > https://elixir.bootlin.com/linux/latest/source/drivers/iio/temperature/mlx90614.c#L432
> > gives an example.  
> 
> Right, there might be another call stealing the wakeup session!
> 
> I should lock the underlying i2c bus, probably not root adapter like
> mlx90614 does but only the segment.

Ideally only segment as you say as could be some muxes involved.

> 
> >
> > Perhaps worth a look is the regmap-sccb implementation which has a dance that looks
> > a tiny bit like what you have to do here (be it for a different reason).
> > It might be nice to do something similar here and have a custom regmap bus which
> > has the necessary wakeups in the relevant places.
> >
> > Note I haven't thought it through in depth, so it might not work!  
> 
> the dance is similar if not regmap-sccb tranfers a byte instead of
> sending only the R/W bit (notice the usage of I2C_SMBUS_QUICK here and
> I2C_SMBUS_BYTE in regmap-sccb). Practically speaking it makes no
> difference as the sensor nacks the first message, so the underlying
> bus implementation bails out, but that's a bit of work-by-accident
> thing, isn't it ?
> 
> If fine with you, I would stick to this implementation and hold the
> segment locked between the wakup and the actual messages.

That's fine.  I was just thinking you could hid the magic in a custom regmap then
the rest of the driver would not have to be aware of it.  Slightly neater than
wrapping regmap functions with this extra call in the wrapper.

> 
> >  
> > > +	ret = regmap_bulk_write(sunrise->regmap, reg, &be_data, 2);
> > > +	if (ret) {
> > > +		dev_err(sunrise->dev, "Write word failed: reg 0x%2x (%d)\n", reg, ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + *  --- Calibration ---
> > > + *
> > > + *  Enumerate and select calibration modes, trigger a calibration cycle.
> > > + */
> > > +static const char * const sunrise_calibration_modes[] = {
> > > +	[SUNRISE_CALIBRATION_FACTORY] = "factory_calibration",
> > > +	[SUNRISE_CALIBRATION_BACKGROUND] = "background_calibration",
> > > +};
> > > +
> > > +static const struct sunrise_calibration_data {
> > > +	u16 calibration_cmd;
> > > +	u8 calibration_bit;
> > > +} sunrise_calibrations[] = {
> > > +	[SUNRISE_CALIBRATION_FACTORY] = {
> > > +		SUNRISE_CALIBRATION_FACTORY_CMD,
> > > +		BIT(2),
> > > +	},
> > > +	[SUNRISE_CALIBRATION_BACKGROUND] = {
> > > +		SUNRISE_CALIBRATION_BACKGROUND_CMD,
> > > +		BIT(5),
> > > +	},
> > > +};
> > > +
> > > +static int sunrise_calibrate(struct sunrise_dev *sunrise)
> > > +{
> > > +	const struct sunrise_calibration_data *data;
> > > +	unsigned int status;
> > > +	int ret;
> > > +
> > > +	/* Reset the calibration status reg. */  
> >
> > I was kind of assuming the locking around calibration mode was to avoid races
> > with this.  Hence, why no lock here?
> >  
> 
> As I assumed that as long as the write on the sysfs file does not
> return all other attempts would have to wait. And this function only
> returns when calibration is completed. However one can open a file
> with O_NONBLOCK, does this apply to a syfs attribute as well ? In that
> case yes, I should lock here.

IIRC sysfs doesn't have any such protections, particularly not if multiple
files are involved.

> 
> > > +	ret = sunrise_write_byte(sunrise, SUNRISE_CALIBRATION_STATUS_REG, 0x00);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Write a calibration command and poll the calibration status bit. */
> > > +	data = &sunrise_calibrations[sunrise->calibration];
> > > +	ret = sunrise_write_word(sunrise, SUNRISE_CALIBRATION_COMMAND_REG,
> > > +				 data->calibration_cmd);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	dev_dbg(sunrise->dev, "%s in progress\n",
> > > +		sunrise_calibration_modes[sunrise->calibration]);
> > > +
> > > +	return regmap_read_poll_timeout(sunrise->regmap,
> > > +					SUNRISE_CALIBRATION_STATUS_REG,
> > > +					status, status & data->calibration_bit,
> > > +					100, SUNRISE_CALIBRATION_TIMEOUT_US);
> > > +}
> > > +
> > > +static ssize_t sunrise_calibration_write(struct iio_dev *iiodev,
> > > +					 uintptr_t private,
> > > +					 const struct iio_chan_spec *chan,
> > > +					 const char *buf, size_t len)
> > > +{
> > > +	struct sunrise_dev *sunrise = iio_priv(iiodev);
> > > +	bool calibrate;
> > > +	int ret;
> > > +
> > > +	ret = kstrtobool(buf, &calibrate);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (!calibrate)
> > > +		return 0;  
> >
> > return len or an error code.  Not 0,
> >  
> 
> Ack
> 
> > > +
> > > +	ret = sunrise_calibrate(sunrise);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return len;
> > > +}
> > > +
> > > +static int sunrise_set_calibration_mode(struct iio_dev *iiodev,
> > > +					const struct iio_chan_spec *chan,
> > > +					unsigned int mode)
> > > +{
> > > +	struct sunrise_dev *sunrise = iio_priv(iiodev);
> > > +
> > > +	mutex_lock(&sunrise->lock);
> > > +	sunrise->calibration = mode;
> > > +	mutex_unlock(&sunrise->lock);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int sunrise_get_calibration_mode(struct iio_dev *iiodev,
> > > +					const struct iio_chan_spec *chan)
> > > +{
> > > +	struct sunrise_dev *sunrise = iio_priv(iiodev);
> > > +	int mode;
> > > +
> > > +	mutex_lock(&sunrise->lock);
> > > +	mode = sunrise->calibration;
> > > +	mutex_unlock(&sunrise->lock);
> > > +
> > > +	return mode;
> > > +}
> > > +
> > > +static const struct iio_enum sunrise_calibration_modes_enum = {
> > > +	.items = sunrise_calibration_modes,
> > > +	.num_items = ARRAY_SIZE(sunrise_calibration_modes),
> > > +	.set = sunrise_set_calibration_mode,
> > > +	.get = sunrise_get_calibration_mode,
> > > +};
> > > +
> > > +/* --- Error status---  
> > /*
> >  * --- Error status ---
> >
> > If you really want to do the heading.  I'm not sure it adds anything over
> > the fairly short description that follows, so I'd just have
> >
> > /* Enumerate and retrieve the chip error status */
> >  
> 
> Ok, I'll keep my comment headers style for me next time :)
> 
> > > + *
> > > + * Enumerate and retrieve the chip error status.
> > > + */
> > > +enum {
> > > +	SUNRISE_ERROR_FATAL,
> > > +	SUNRISE_ERROR_I2C,
> > > +	SUNRISE_ERROR_ALGORITHM,
> > > +	SUNRISE_ERROR_CALIBRATION,
> > > +	SUNRISE_ERROR_SELF_DIAGNOSTIC,
> > > +	SUNRISE_ERROR_OUT_OF_RANGE,
> > > +	SUNRISE_ERROR_MEMORY,
> > > +	SUNRISE_ERROR_NO_MEASUREMENT,
> > > +	SUNRISE_ERROR_LOW_VOLTAGE,
> > > +	SUNRISE_ERROR_MEASUREMENT_TIMEOUT,
> > > +};
> > > +
> > > +static const char * const sunrise_error_statuses[] = {
> > > +	[SUNRISE_ERROR_FATAL] = "error_fatal",
> > > +	[SUNRISE_ERROR_I2C] = "error_i2c",
> > > +	[SUNRISE_ERROR_ALGORITHM] = "error_algorithm",
> > > +	[SUNRISE_ERROR_CALIBRATION] = "error_calibration",
> > > +	[SUNRISE_ERROR_SELF_DIAGNOSTIC] = "error_self_diagnostic",
> > > +	[SUNRISE_ERROR_OUT_OF_RANGE] = "error_out_of_range",
> > > +	[SUNRISE_ERROR_MEMORY] = "error_memory",
> > > +	[SUNRISE_ERROR_NO_MEASUREMENT] = "error_no_measurement",
> > > +	[SUNRISE_ERROR_LOW_VOLTAGE] = "error_low_voltage",
> > > +	[SUNRISE_ERROR_MEASUREMENT_TIMEOUT] = "error_measurement_timeout",
> > > +};
> > > +
> > > +static const u8 error_codes[] = {
> > > +	SUNRISE_ERROR_FATAL,
> > > +	SUNRISE_ERROR_I2C,
> > > +	SUNRISE_ERROR_ALGORITHM,
> > > +	SUNRISE_ERROR_CALIBRATION,
> > > +	SUNRISE_ERROR_SELF_DIAGNOSTIC,
> > > +	SUNRISE_ERROR_OUT_OF_RANGE,
> > > +	SUNRISE_ERROR_MEMORY,
> > > +	SUNRISE_ERROR_NO_MEASUREMENT,
> > > +	SUNRISE_ERROR_LOW_VOLTAGE,
> > > +	SUNRISE_ERROR_MEASUREMENT_TIMEOUT,
> > > +};
> > > +
> > > +static const struct iio_enum sunrise_error_statuses_enum = {
> > > +	.items = sunrise_error_statuses,
> > > +	.num_items = ARRAY_SIZE(sunrise_error_statuses),
> > > +};
> > > +
> > > +static ssize_t sunrise_error_status_read(struct iio_dev *iiodev,
> > > +					 uintptr_t private,
> > > +					 const struct iio_chan_spec *chan,
> > > +					 char *buf)
> > > +{
> > > +	struct sunrise_dev *sunrise = iio_priv(iiodev);
> > > +	const unsigned long *errors;
> > > +	ssize_t len = 0;
> > > +	u16 value;
> > > +	int ret;
> > > +	u8 i;
> > > +
> > > +	ret = sunrise_read_word(sunrise, SUNRISE_ERROR_STATUS_REG, &value);
> > > +	if (ret)
> > > +		return -EINVAL;
> > > +
> > > +	errors = (const unsigned long *)&value;  
> >
> > Copy it to an unsigned long as discussed in other branch of this thread.
> >  
> 
> Ack, done in v3.1
> 
> > > +	for_each_set_bit(i, errors, ARRAY_SIZE(error_codes))  
> >
> > Unless I'm going crazy, ARRAY_SIZE(sunrise_error_statuses) == ARRAY_SIZE(error_codes)
> > and so there isn't any point in having the error_codes array.
> >  
> 
> Uh, you're right. I thought I had to layout error bits in an array to
> cycle on them, but what I care about is the size only, so
> sunrise_error_statuses will do just fine. I'll drop
> 
> > > +		len += sysfs_emit_at(buf, len, "%s ", sunrise_error_statuses[i]);
> > > +
> > > +	if (len)
> > > +		buf[len - 1] = '\n';
> > > +
> > > +	return len;
> > > +}
> > > +
> > > +static const struct iio_chan_spec_ext_info sunrise_concentration_ext_info[] = {
> > > +	/* Calibration modes and calibration trigger. */
> > > +	{
> > > +		.name = "calibration",
> > > +		.write = sunrise_calibration_write,
> > > +		.shared = IIO_SEPARATE,
> > > +	},
> > > +	IIO_ENUM("calibration_mode", IIO_SEPARATE,
> > > +		 &sunrise_calibration_modes_enum),  
> >
> > I'll comment on this ABI in the docs patch rather than here.
> > Given you asked somewhere about ext_info vs explicit attrs.
> > In theory we always prefer ext_info because it provides a way to access them from
> > in kernel consumers + enforces naming etc.  However as we have a massive number
> > of legacy attributes I haven't yet started insisting on it, even for new drivers.
> >
> > Good to see it here though!
> >  
> 
> Good! I'll keep using ext_info and update the ABI as you suggested.
> Be aware though that the chip supports up to 5 calibration modes, and
> we'll have one attribute for each of them, that's why I thought having
> 2 only was better. With an ack to potentially have 5 attrs, I'll
> change the ABI
5 clearly defined atts is fine.  If it was 100s I might have a different opinion!

> 
> >  
> > > +	IIO_ENUM_AVAILABLE("calibration_mode",
> > > +			   &sunrise_calibration_modes_enum),
> > > +
> > > +	/* Error statuses. */
> > > +	{
> > > +		.name = "error_status",
> > > +		.read = sunrise_error_status_read,
> > > +		.shared = IIO_SEPARATE
> > > +	},
> > > +	IIO_ENUM_AVAILABLE("error_status", &sunrise_error_statuses_enum),
> > > +	{}
> > > +};
> > > +
> > > +static const struct iio_chan_spec sunrise_channels[] = {
> > > +	{
> > > +		.type = IIO_CONCENTRATION,
> > > +		.modified = 1,
> > > +		.channel2 = IIO_MOD_CO2,
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > +		.ext_info = sunrise_concentration_ext_info,
> > > +		.scan_index = 0,
> > > +		.scan_type =  {
> > > +			.sign = 's',
> > > +			.realbits = 16,
> > > +			.storagebits = 16,
> > > +			.endianness = IIO_CPU,
> > > +		},
> > > +	},
> > > +	{
> > > +		.type = IIO_TEMP,
> > > +		.info_mask_separate =  BIT(IIO_CHAN_INFO_RAW) |
> > > +				       BIT(IIO_CHAN_INFO_SCALE),
> > > +		.scan_index = 1,
> > > +		.scan_type =  {
> > > +			.sign = 's',
> > > +			.realbits = 16,
> > > +			.storagebits = 16,
> > > +			.endianness = IIO_CPU,
> > > +		},
> > > +	},
> > > +};
> > > +
> > > +static int sunrise_read_raw(struct iio_dev *iio_dev,
> > > +			    const struct iio_chan_spec *chan,
> > > +			    int *val, int *val2, long mask)
> > > +{
> > > +	struct sunrise_dev *sunrise = iio_priv(iio_dev);
> > > +	u16 value;
> > > +	int ret;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		mutex_lock(&sunrise->lock);
> > > +
> > > +		switch (chan->type) {
> > > +		case IIO_CONCENTRATION:
> > > +			ret = sunrise_read_word(sunrise, SUNRISE_CO2_FILTERED_COMP_REG,
> > > +						&value);
> > > +			*val = value;
> > > +			mutex_unlock(&sunrise->lock);
> > > +
> > > +			return ret ?: IIO_VAL_INT;  
> >
> > I mentioned in a late response to an earlier one that I'm not overly keen on this form, but
> > I can live with it if you prefer it.
> >  
> 
> Whatever, really, I've done a few back and forth already. I'm more
> accustomed to the canonical if (ret) return ret; as well fwiw
> > > +
> > > +		case IIO_TEMP:
> > > +			ret = sunrise_read_word(sunrise, SUNRISE_CHIP_TEMPERATURE_REG,
> > > +						&value);
> > > +			*val = value;
> > > +			mutex_unlock(&sunrise->lock);
> > > +
> > > +			return ret ?: IIO_VAL_INT;
> > > +
> > > +		default:
> > > +			mutex_unlock(&sunrise->lock);  
> >
> > Move the locks into the two case statements, then you won't have to unlock here which
> > will be cleaner.  
> 
> Ack
> 
> >  
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		/* Chip temperature scale = 1/100 */  
> >
> > IIO temperatures are measured in milli degrees.  1lsb = 1/100*1000 degrees centigrade seems very accurate
> > for a device like this!  I'm guessing this should be 10.  
> 
> Ah yes, I thought it had to be given in the chip's native format,
> which is 1/100 degree.
> 
> I guess I should then multiply by 10 the temperature raw read and
> return IIO_VAL_INT here.

You could do that, but can cause a mess if buffered support comes along later as
it is then not a whole number of bits for putting in the buffer.

> 
> >  
> > > +		*val = 1;
> > > +		*val2 = 100;
> > > +		return IIO_VAL_FRACTIONAL;
> > > +
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static const struct iio_info sunrise_info = {
> > > +	.read_raw = sunrise_read_raw,
> > > +};
> > > +
> > > +static struct regmap_config sunrise_regmap_config = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +};
> > > +
> > > +static int sunrise_probe(struct i2c_client *client)
> > > +{
> > > +	struct sunrise_dev *sunrise;
> > > +	struct iio_dev *iio_dev;
> > > +
> > > +	iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*sunrise));
> > > +	if (!iio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	i2c_set_clientdata(client, iio_dev);  
> >
> > Why?  I'm not immediately spotting where this is used.
> >  
> 
> Probably a leftover since when I used raw attrs ?
> 
> > > +
> > > +	sunrise = iio_priv(iio_dev);
> > > +	sunrise->client = client;
> > > +	sunrise->dev = &client->dev;  
> >
> > Why carry this around when you can get it from client->dev?
> >  
> 
> Andy had the same comment. I think it's very cheap and makes the error
> printing more compact. But if it bothers both of you I can drop it.

I'd drop it, but if you have a particular function with multiple prints
then have a local struct device *dev in that function.  The compiler will
tidy that up so it makes no difference and it will be even neater at
call sites.

> 
> Thanks
>    j
> 
> > > +	mutex_init(&sunrise->lock);
> > > +
> > > +	sunrise->regmap = devm_regmap_init_i2c(client, &sunrise_regmap_config);
> > > +	if (IS_ERR(sunrise->regmap)) {
> > > +		dev_err(&client->dev, "Failed to initialize regmap\n");
> > > +		return PTR_ERR(sunrise->regmap);
> > > +	}
> > > +
> > > +	iio_dev->info = &sunrise_info;
> > > +	iio_dev->name = DRIVER_NAME;
> > > +	iio_dev->channels = sunrise_channels;
> > > +	iio_dev->num_channels = ARRAY_SIZE(sunrise_channels);
> > > +	iio_dev->modes = INDIO_DIRECT_MODE;
> > > +
> > > +	return devm_iio_device_register(&client->dev, iio_dev);
> > > +}
> > > +
> > > +static const struct of_device_id sunrise_of_match[] = {
> > > +	{ .compatible = "senseair,sunrise-006-0-0007" },
> > > +	{}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, sunrise_of_match);
> > > +
> > > +static struct i2c_driver sunrise_driver = {
> > > +	.driver = {
> > > +		.name = DRIVER_NAME,
> > > +		.of_match_table = sunrise_of_match,
> > > +	},
> > > +	.probe_new = sunrise_probe,
> > > +};
> > > +module_i2c_driver(sunrise_driver);
> > > +
> > > +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
> > > +MODULE_DESCRIPTION("Senseair Sunrise 006-0-0007 CO2 sensor IIO driver");
> > > +MODULE_LICENSE("GPL v2");
> > > --
> > > 2.32.0
> > >  
> >  

