Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F1240472A
	for <lists+linux-iio@lfdr.de>; Thu,  9 Sep 2021 10:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhIIInf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Sep 2021 04:43:35 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60535 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhIIInf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Sep 2021 04:43:35 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 6F5F040010;
        Thu,  9 Sep 2021 08:42:21 +0000 (UTC)
Date:   Thu, 9 Sep 2021 10:43:07 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <20210909084307.y3xsq5ps446fhsvc@uno.localdomain>
References: <20210903144828.497166-1-jacopo@jmondi.org>
 <20210903144828.497166-3-jacopo@jmondi.org>
 <CAJCx=g=qOtG4+Z7k4aWX+xFg=-No3u=z2=iuRxKS2BOFHjiNdg@mail.gmail.com>
 <20210908124836.4ojinf65x6nfyd44@uno.localdomain>
 <20210908175634.08055502@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210908175634.08055502@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Wed, Sep 08, 2021 at 05:56:34PM +0100, Jonathan Cameron wrote:
> On Wed, 8 Sep 2021 14:48:36 +0200
> Jacopo Mondi <jacopo@jmondi.org> wrote:
>
> > Hi Matt,
> >
> > On Sun, Sep 05, 2021 at 02:10:43PM -0700, Matt Ranostay wrote:
> > > On Fri, Sep 3, 2021 at 7:48 AM Jacopo Mondi <jacopo@jmondi.org> wrote:
> > > >
> > > > Add support for the Senseair Sunrise 006-0-0007 driver through the
> > > > IIO subsystem.
> > > >
> > > > Datasheet: https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/TDE5531.pdf
> > > > Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> > > > ---
> > > >  MAINTAINERS                        |   6 +
> > > >  drivers/iio/chemical/Kconfig       |  10 +
> > > >  drivers/iio/chemical/Makefile      |   1 +
> > > >  drivers/iio/chemical/sunrise_co2.c | 487 +++++++++++++++++++++++++++++
> > > >  4 files changed, 504 insertions(+)
> > > >  create mode 100644 drivers/iio/chemical/sunrise_co2.c
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index d7b4f32875a9..a8b859297e9e 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -16723,6 +16723,12 @@ S:     Maintained
> > > >  F:     drivers/misc/phantom.c
> > > >  F:     include/uapi/linux/phantom.h
> > > >
> > > > +SENSEAIR SUNRISE 006-0-0007
> > > > +M:     Jacopo Mondi <jacopo@jmondi.org>
> > > > +S:     Maintained
> > > > +F:     Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
> > > > +F:     drivers/iio/chemical/sunrise_co2.c
> > > > +
> > > >  SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
> > > >  M:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > > >  S:     Maintained
> > > > diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> > > > index a4920646e9be..5155ab2caed4 100644
> > > > --- a/drivers/iio/chemical/Kconfig
> > > > +++ b/drivers/iio/chemical/Kconfig
> > > > @@ -159,6 +159,16 @@ config SPS30_SERIAL
> > > >           To compile this driver as a module, choose M here: the module will
> > > >           be called sps30_serial.
> > > >
> > > > +config SENSEAIR_SUNRISE_CO2
> > > > +       tristate "Senseair Sunrise 006-0-0007 CO2 sensor"
> > > > +       select REGMAP_I2C
> > > > +       help
> > > > +         Say yes here to build support for Senseair Sunrise 006-0-0007 CO2
> > > > +         sensor.
> > > > +
> > > > +         To compile this driver as a module, choose M here: the
> > > > +         module will be called sunrise_co2.
> > > > +
> > > >  config VZ89X
> > > >         tristate "SGX Sensortech MiCS VZ89X VOC sensor"
> > > >         depends on I2C
> > > > diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> > > > index 4898690cc155..61e8749a84f3 100644
> > > > --- a/drivers/iio/chemical/Makefile
> > > > +++ b/drivers/iio/chemical/Makefile
> > > > @@ -15,6 +15,7 @@ obj-$(CONFIG_PMS7003) += pms7003.o
> > > >  obj-$(CONFIG_SCD30_CORE) += scd30_core.o
> > > >  obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
> > > >  obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
> > > > +obj-$(CONFIG_SENSEAIR_SUNRISE_CO2) += sunrise_co2.o
> > > >  obj-$(CONFIG_SENSIRION_SGP30)  += sgp30.o
> > > >  obj-$(CONFIG_SPS30) += sps30.o
> > > >  obj-$(CONFIG_SPS30_I2C) += sps30_i2c.o
> > > > diff --git a/drivers/iio/chemical/sunrise_co2.c b/drivers/iio/chemical/sunrise_co2.c
> > > > new file mode 100644
> > > > index 000000000000..cf15cdbaa24a
> > > > --- /dev/null
> > > > +++ b/drivers/iio/chemical/sunrise_co2.c
> > > > @@ -0,0 +1,487 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Senseair Sunrise 006-0-0007 CO2 sensor driver.
> > > > + *
> > > > + * Copyright (C) 2021 Jacopo Mondi
> > > > + *
> > > > + * List of features not yet supported by the driver:
> > > > + * - controllable EN pin
> > > > + * - single-shot operations using the nDRY pin.
> > > > + * - ABC/target calibration
> > > > + */
> > > > +
> > > > +#include <linux/bitops.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/mod_devicetable.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/time64.h>
> > > > +
> > > > +#include <linux/iio/iio.h>
> > > > +
> > > > +#define DRIVER_NAME "sunrise_co2"
> > > > +
> > > > +#define SUNRISE_ERROR_STATUS_REG               0x00
> > > > +#define SUNRISE_CO2_FILTERED_COMP_REG          0x06
> > > > +#define SUNRISE_CHIP_TEMPERATURE_REG           0x08
> > > > +#define SUNRISE_CALIBRATION_STATUS_REG         0x81
> > > > +#define SUNRISE_CALIBRATION_COMMAND_REG                0x82
> > > > +#define SUNRISE_CALIBRATION_FACTORY_CMD                0x7c02
> > > > +#define SUNRISE_CALIBRATION_BACKGROUND_CMD     0x7c06
> > > > +/*
> > > > + * The calibration timeout is not characterized in the datasheet.
> > > > + * Use 30 seconds as a reasonable upper limit.
> > > > + */
> > > > +#define SUNRISE_CALIBRATION_TIMEOUT_US         (30 * USEC_PER_SEC)
> > > > +
> > > > +struct sunrise_dev {
> > > > +       struct i2c_client *client;
> > > > +       struct regmap *regmap;
> > > > +       /* Protects access to IIO attributes. */
> > > > +       struct mutex lock;
> > > > +       /* Protects chip's wakup session. */
> > > > +       struct mutex wakeup_lock;
> > > > +};
> > > > +
> > > > +static void sunrise_wakeup(struct sunrise_dev *sunrise)
> > > > +{
> > > > +       struct i2c_client *client = sunrise->client;
> > > > +
> > > > +       /*
> > > > +        * Wake up sensor by sending sensor address: START, sensor address,
> > > > +        * STOP. Sensor will not ACK this byte.
> > > > +        *
> > > > +        * The chip returns in low power state after 15msec without
> > > > +        * communications or after a complete read/write sequence.
> > > > +        */
> > > > +       i2c_smbus_xfer(client->adapter, client->addr, I2C_M_IGNORE_NAK,
> > > > +                      I2C_SMBUS_WRITE, 0, I2C_SMBUS_QUICK, NULL);
> > > > +}
> > > > +
> > > > +static int sunrise_read_byte(struct sunrise_dev *sunrise, u8 reg)
> > > > +{
> > > > +       unsigned int val;
> > > > +       int ret;
> > > > +
> > > > +       /*
> > > > +        * Lock the 'wakeup' session.
> > > > +        *
> > > > +        * If another read/write call sneaks in between the wakeup message
> > > > +        * and the i2c transaction, the chip goes back in sleep state.
> > > > +        */
> > > > +       mutex_lock(&sunrise->wakeup_lock);
> > > > +       sunrise_wakeup(sunrise);
> > > > +       ret = regmap_read(sunrise->regmap, reg, &val);
> > > > +       mutex_unlock(&sunrise->wakeup_lock);
> > > > +       if (ret) {
> > > > +               dev_err(&sunrise->client->dev,
> > > > +                       "Read byte failed: reg 0x%2x (%d)\n", reg, ret);
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       return val;
> > > > +}
> > > > +
> > > > +static int sunrise_read_word(struct sunrise_dev *sunrise, u8 reg, u16 *val)
> > > > +{
> > > > +       __be16 be_val;
> > > > +       int ret;
> > > > +
> > > > +       mutex_lock(&sunrise->wakeup_lock);
> > > > +       sunrise_wakeup(sunrise);
> > > > +       ret = regmap_bulk_read(sunrise->regmap, reg, &be_val, 2);
> > > > +       mutex_unlock(&sunrise->wakeup_lock);
> > > > +       if (ret) {
> > > > +               dev_err(&sunrise->client->dev,
> > > > +                       "Read word failed: reg 0x%2x (%d)\n", reg, ret);
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       *val = be16_to_cpu(be_val);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int sunrise_write_byte(struct sunrise_dev *sunrise, u8 reg, u8 val)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       mutex_lock(&sunrise->wakeup_lock);
> > > > +       sunrise_wakeup(sunrise);
> > > > +       ret = regmap_write(sunrise->regmap, reg, val);
> > > > +       mutex_unlock(&sunrise->wakeup_lock);
> > > > +       if (ret) {
> > > > +               dev_err(&sunrise->client->dev,
> > > > +                       "Write byte failed: reg 0x%2x (%d)\n", reg, ret);
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int sunrise_write_word(struct sunrise_dev *sunrise, u8 reg, u16 data)
> > > > +{
> > > > +       __be16 be_data = cpu_to_be16(data);
> > > > +       int ret;
> > > > +
> > > > +       mutex_lock(&sunrise->wakeup_lock);
> > > > +       sunrise_wakeup(sunrise);
> > > > +       ret = regmap_bulk_write(sunrise->regmap, reg, &be_data, 2);
> > > > +       mutex_unlock(&sunrise->wakeup_lock);
> > > > +       if (ret) {
> > > > +               dev_err(&sunrise->client->dev,
> > > > +                       "Write word failed: reg 0x%2x (%d)\n", reg, ret);
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +/* Trigger a calibration cycle. */
> > > > +
> > > > +enum {
> > > > +       SUNRISE_CALIBRATION_FACTORY,
> > > > +       SUNRISE_CALIBRATION_BACKGROUND,
> > > > +};
> > > > +
> > > > +static const struct sunrise_calib_data {
> > > > +       u16 cmd;
> > > > +       u8 bit;
> > > > +       const char * const name;
> > > > +} calib_data[] = {
> > > > +       [SUNRISE_CALIBRATION_FACTORY] = {
> > > > +               SUNRISE_CALIBRATION_FACTORY_CMD,
> > > > +               BIT(2),
> > > > +               "factory_calibration",
> > > > +       },
> > > > +       [SUNRISE_CALIBRATION_BACKGROUND] = {
> > > > +               SUNRISE_CALIBRATION_BACKGROUND_CMD,
> > > > +               BIT(5),
> > > > +               "background_calibration",
> > > > +       },
> > > > +};
> > > > +
> > > > +static int sunrise_calibrate(struct sunrise_dev *sunrise,
> > > > +                            const struct sunrise_calib_data *data)
> > > > +{
> > > > +       unsigned int status;
> > > > +       int ret;
> > > > +
> > > > +       /* Reset the calibration status reg. */
> > > > +       ret = sunrise_write_byte(sunrise, SUNRISE_CALIBRATION_STATUS_REG, 0x00);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       /* Write a calibration command and poll the calibration status bit. */
> > > > +       ret = sunrise_write_word(sunrise, SUNRISE_CALIBRATION_COMMAND_REG,
> > > > +                                data->cmd);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       dev_dbg(&sunrise->client->dev, "%s in progress\n", data->name);
> > > > +
> > > > +       /*
> > > > +        * Calibration takes several seconds, so the sleep time between reads
> > > > +        * can be pretty relaxed.
> > > > +        */
> > > > +       return read_poll_timeout(sunrise_read_byte, status,
> > > > +                                status & data->bit, 200000,
> > > > +                                SUNRISE_CALIBRATION_TIMEOUT_US, false,
> > > > +                                sunrise, SUNRISE_CALIBRATION_STATUS_REG);
> > > > +}
> > > > +
> > > > +static ssize_t sunrise_cal_read(const char *buf, size_t len)
> > > > +{
> > > > +       bool enable;
> > > > +       int ret;
> > > > +
> > > > +       ret = kstrtobool(buf, &enable);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       if (!enable)
> > > > +               return len;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static ssize_t sunrise_cal_factory_write(struct iio_dev *iiodev,
> > > > +                                        uintptr_t private,
> > > > +                                        const struct iio_chan_spec *chan,
> > > > +                                        const char *buf, size_t len)
> > > > +{
> > > > +       struct sunrise_dev *sunrise = iio_priv(iiodev);
> > > > +       int ret;
> > > > +
> > > > +       mutex_lock(&sunrise->lock);
> > > > +       ret = sunrise_cal_read(buf, len);
> > > > +       if (ret) {
> > > > +               mutex_unlock(&sunrise->lock);
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       ret = sunrise_calibrate(sunrise,
> > > > +                               &calib_data[SUNRISE_CALIBRATION_FACTORY]);
> > > > +       mutex_unlock(&sunrise->lock);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       return len;
> > > > +}
> > > > +
> > > > +static ssize_t sunrise_cal_background_write(struct iio_dev *iiodev,
> > > > +                                           uintptr_t private,
> > > > +                                           const struct iio_chan_spec *chan,
> > > > +                                           const char *buf, size_t len)
> > > > +{
> > > > +       struct sunrise_dev *sunrise = iio_priv(iiodev);
> > > > +       int ret;
> > > > +
> > > > +       mutex_lock(&sunrise->lock);
> > > > +       ret = sunrise_cal_read(buf, len);
> > > > +       if (ret) {
> > > > +               mutex_unlock(&sunrise->lock);
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       ret = sunrise_calibrate(sunrise,
> > > > +                               &calib_data[SUNRISE_CALIBRATION_BACKGROUND]);
> > > > +       mutex_unlock(&sunrise->lock);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       return len;
> > > > +}
> > > > +
> > > > + /* Enumerate and retrieve the chip error status. */
> > > > +enum {
> > > > +       SUNRISE_ERROR_FATAL,
> > > > +       SUNRISE_ERROR_I2C,
> > > > +       SUNRISE_ERROR_ALGORITHM,
> > > > +       SUNRISE_ERROR_CALIBRATION,
> > > > +       SUNRISE_ERROR_SELF_DIAGNOSTIC,
> > > > +       SUNRISE_ERROR_OUT_OF_RANGE,
> > > > +       SUNRISE_ERROR_MEMORY,
> > > > +       SUNRISE_ERROR_NO_MEASUREMENT,
> > > > +       SUNRISE_ERROR_LOW_VOLTAGE,
> > > > +       SUNRISE_ERROR_MEASUREMENT_TIMEOUT,
> > > > +};
> > > > +
> > > > +static const char * const sunrise_error_statuses[] = {
> > > > +       [SUNRISE_ERROR_FATAL] = "error_fatal",
> > > > +       [SUNRISE_ERROR_I2C] = "error_i2c",
> > > > +       [SUNRISE_ERROR_ALGORITHM] = "error_algorithm",
> > > > +       [SUNRISE_ERROR_CALIBRATION] = "error_calibration",
> > > > +       [SUNRISE_ERROR_SELF_DIAGNOSTIC] = "error_self_diagnostic",
> > > > +       [SUNRISE_ERROR_OUT_OF_RANGE] = "error_out_of_range",
> > > > +       [SUNRISE_ERROR_MEMORY] = "error_memory",
> > > > +       [SUNRISE_ERROR_NO_MEASUREMENT] = "error_no_measurement",
> > > > +       [SUNRISE_ERROR_LOW_VOLTAGE] = "error_low_voltage",
> > > > +       [SUNRISE_ERROR_MEASUREMENT_TIMEOUT] = "error_measurement_timeout",
> > > > +};
> > > > +
> > > > +static const struct iio_enum sunrise_error_statuses_enum = {
> > > > +       .items = sunrise_error_statuses,
> > > > +       .num_items = ARRAY_SIZE(sunrise_error_statuses),
> > > > +};
> > > > +
> > > > +static ssize_t sunrise_error_status_read(struct iio_dev *iiodev,
> > > > +                                        uintptr_t private,
> > > > +                                        const struct iio_chan_spec *chan,
> > > > +                                        char *buf)
> > > > +{
> > > > +       struct sunrise_dev *sunrise = iio_priv(iiodev);
> > > > +       unsigned long errors;
> > > > +       ssize_t len = 0;
> > > > +       u16 value;
> > > > +       int ret;
> > > > +       u8 i;
> > > > +
> > > > +       mutex_lock(&sunrise->lock);
> > > > +       ret = sunrise_read_word(sunrise, SUNRISE_ERROR_STATUS_REG, &value);
> > > > +       if (ret) {
> > > > +               mutex_unlock(&sunrise->lock);
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > > +       errors = value;
> > > > +       for_each_set_bit(i, &errors, ARRAY_SIZE(sunrise_error_statuses))
> > > > +               len += sysfs_emit_at(buf, len, "%s ", sunrise_error_statuses[i]);
> > > > +
> > > > +       if (len)
> > > > +               buf[len - 1] = '\n';
> > > > +
> > > > +       mutex_unlock(&sunrise->lock);
> > > > +
> > > > +       return len;
> > > > +}
> > > > +
> > > > +static const struct iio_chan_spec_ext_info sunrise_concentration_ext_info[] = {
> > > > +       /* Calibration triggers. */
> > > > +       {
> > > > +               .name = "calibration_factory",
> > > > +               .write = sunrise_cal_factory_write,
> > > > +               .shared = IIO_SEPARATE,
> > > > +       },
> > > > +       {
> > > > +               .name = "calibration_background",
> > > > +               .write = sunrise_cal_background_write,
> > > > +               .shared = IIO_SEPARATE,
> > > > +       },
> > > > +
> > > > +       /* Error statuses. */
> > > > +       {
> > > > +               .name = "error_status",
> > > > +               .read = sunrise_error_status_read,
> > > > +               .shared = IIO_SHARED_BY_ALL,
> > > > +       },
> > > > +       {
> > > > +               .name = "error_status_available",
> > > > +               .shared = IIO_SHARED_BY_ALL,
> > > > +               .read = iio_enum_available_read,
> > > > +               .private = (uintptr_t)&sunrise_error_statuses_enum,
> > > > +       },
> > > > +       {}
> > > > +};
> > > > +
> > > > +static const struct iio_chan_spec sunrise_channels[] = {
> > > > +       {
> > > > +               .type = IIO_CONCENTRATION,
> > > > +               .modified = 1,
> > > > +               .channel2 = IIO_MOD_CO2,
> > > > +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > >
> > > Why isn't there a IIO_CHAN_INFO_SCALE for the CO2 channel?  Raw units
> > > between different CO2 sensors aren't always in ppm
> >
> > Good point, I should add one. The reson I didn't do so is that
> > Documentation/ABI/testing/sysfs-bus-iio doesn't report any
> > in_concentration_co2_scale attribute. Should it be added ?
>
> yes.  We don't have any automated testing on this yet so I don't always
> catch ABI that isn't documented if it is 'standard' in the sense that
> it is built by the core.  Good to add it thourgh.
>

Thanks, will add it to the list of _scale attributes as part of the
'standard' ones.

> >
> > Although I see this:
> >
> > static IIO_CONST_ATTR(in_concentration_co2_scale, "0.00000698689");
> > static IIO_CONST_ATTR(in_concentration_voc_scale, "0.00000000436681223");
> >
> > in drivers/iio/chemical/vz89x.c (I wonder why it goes through an IIO
> > const attributes instead than using the channel scale).
> >
> > Another question is where the standard IIO units are defined for each
> > channel type ?
>
> Should be in sysfs-bus-iio as above.  Usually in the relevant _raw
> description.
>
> Might be missing though for some unit types. If they are we should fix
> it!

Actually for concentration values the unit is reported and it is
expressed as percentage (10.000 ppm = 1%) so there shouldn't be
anything to add there.

Thanks
   j

>
> Jonathan
> >
> > Thanks
> >    j
> >
> > >
> > > Thanks,
> > >
> > > Matt
> > >
> > > > +               .ext_info = sunrise_concentration_ext_info,
> > > > +               .scan_index = 0,
> > > > +               .scan_type =  {
> > > > +                       .sign = 's',
> > > > +                       .realbits = 16,
> > > > +                       .storagebits = 16,
> > > > +                       .endianness = IIO_CPU,
> > > > +               },
> > > > +       },
> > > > +       {
> > > > +               .type = IIO_TEMP,
> > > > +               .info_mask_separate =  BIT(IIO_CHAN_INFO_RAW) |
> > > > +                                      BIT(IIO_CHAN_INFO_SCALE),
> > > > +               .scan_index = 1,
> > > > +               .scan_type =  {
> > > > +                       .sign = 's',
> > > > +                       .realbits = 16,
> > > > +                       .storagebits = 16,
> > > > +                       .endianness = IIO_CPU,
> > > > +               },
> > > > +       },
> > > > +};
> > > > +
> > > > +static int sunrise_read_raw(struct iio_dev *iio_dev,
> > > > +                           const struct iio_chan_spec *chan,
> > > > +                           int *val, int *val2, long mask)
> > > > +{
> > > > +       struct sunrise_dev *sunrise = iio_priv(iio_dev);
> > > > +       u16 value;
> > > > +       int ret;
> > > > +
> > > > +       switch (mask) {
> > > > +       case IIO_CHAN_INFO_RAW:
> > > > +               switch (chan->type) {
> > > > +               case IIO_CONCENTRATION:
> > > > +                       mutex_lock(&sunrise->lock);
> > > > +                       ret = sunrise_read_word(sunrise, SUNRISE_CO2_FILTERED_COMP_REG,
> > > > +                                               &value);
> > > > +                       *val = value;
> > > > +                       mutex_unlock(&sunrise->lock);
> > > > +
> > > > +                       if (ret)
> > > > +                               return ret;
> > > > +
> > > > +                       return IIO_VAL_INT;
> > > > +
> > > > +               case IIO_TEMP:
> > > > +                       mutex_lock(&sunrise->lock);
> > > > +                       ret = sunrise_read_word(sunrise, SUNRISE_CHIP_TEMPERATURE_REG,
> > > > +                                               &value);
> > > > +                       *val = value;
> > > > +                       mutex_unlock(&sunrise->lock);
> > > > +
> > > > +                       if (ret)
> > > > +                               return ret;
> > > > +
> > > > +                       return IIO_VAL_INT;
> > > > +
> > > > +               default:
> > > > +                       return -EINVAL;
> > > > +               }
> > > > +
> > > > +       case IIO_CHAN_INFO_SCALE:
> > > > +               /* x10 to comply with IIO scale (1/1000 degress celsius). */
> > > > +               *val = 10;
> > > > +               return IIO_VAL_INT;
> > > > +
> > > > +       default:
> > > > +               return -EINVAL;
> > > > +       }
> > > > +}
> > > > +
> > > > +static const struct iio_info sunrise_info = {
> > > > +       .read_raw = sunrise_read_raw,
> > > > +};
> > > > +
> > > > +static struct regmap_config sunrise_regmap_config = {
> > > > +       .reg_bits = 8,
> > > > +       .val_bits = 8,
> > > > +       /*
> > > > +        * Access to the i2c bus is locked by the driver to preserve the
> > > > +        * 'wakeup' session.
> > > > +        */
> > > > +       .disable_locking = true,
> > > > +};
> > > > +
> > > > +static int sunrise_probe(struct i2c_client *client)
> > > > +{
> > > > +       struct sunrise_dev *sunrise;
> > > > +       struct iio_dev *iio_dev;
> > > > +
> > > > +       iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*sunrise));
> > > > +       if (!iio_dev)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       sunrise = iio_priv(iio_dev);
> > > > +       sunrise->client = client;
> > > > +       mutex_init(&sunrise->lock);
> > > > +       mutex_init(&sunrise->wakeup_lock);
> > > > +
> > > > +       sunrise->regmap = devm_regmap_init_i2c(client, &sunrise_regmap_config);
> > > > +       if (IS_ERR(sunrise->regmap)) {
> > > > +               dev_err(&client->dev, "Failed to initialize regmap\n");
> > > > +               return PTR_ERR(sunrise->regmap);
> > > > +       }
> > > > +
> > > > +       iio_dev->info = &sunrise_info;
> > > > +       iio_dev->name = DRIVER_NAME;
> > > > +       iio_dev->channels = sunrise_channels;
> > > > +       iio_dev->num_channels = ARRAY_SIZE(sunrise_channels);
> > > > +       iio_dev->modes = INDIO_DIRECT_MODE;
> > > > +
> > > > +       return devm_iio_device_register(&client->dev, iio_dev);
> > > > +}
> > > > +
> > > > +static const struct of_device_id sunrise_of_match[] = {
> > > > +       { .compatible = "senseair,sunrise-006-0-0007" },
> > > > +       {}
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, sunrise_of_match);
> > > > +
> > > > +static struct i2c_driver sunrise_driver = {
> > > > +       .driver = {
> > > > +               .name = DRIVER_NAME,
> > > > +               .of_match_table = sunrise_of_match,
> > > > +       },
> > > > +       .probe_new = sunrise_probe,
> > > > +};
> > > > +module_i2c_driver(sunrise_driver);
> > > > +
> > > > +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
> > > > +MODULE_DESCRIPTION("Senseair Sunrise 006-0-0007 CO2 sensor IIO driver");
> > > > +MODULE_LICENSE("GPL v2");
> > > > --
> > > > 2.32.0
> > > >
>
