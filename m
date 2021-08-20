Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941DE3F2E48
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbhHTOn0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 10:43:26 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:33965 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbhHTOn0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 10:43:26 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2352010000E;
        Fri, 20 Aug 2021 14:42:43 +0000 (UTC)
Date:   Fri, 20 Aug 2021 16:43:31 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: chemical: Add Sensteair Sunrise 006-0-007
 driver
Message-ID: <20210820144331.h6kfsdr6d6tskoon@uno.localdomain>
References: <20210820133821.159239-1-jacopo@jmondi.org>
 <20210820133821.159239-3-jacopo@jmondi.org>
 <CAHp75Vej52puQ6jTvxoMDnfJc82Sg1u53Y=2_qquvkZf8Khpxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vej52puQ6jTvxoMDnfJc82Sg1u53Y=2_qquvkZf8Khpxg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,
   thanks for the quick review

On Fri, Aug 20, 2021 at 05:21:30PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 20, 2021 at 4:38 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
> >
> > Add support for the Senseair Sunrise 006-0-0007 driver through the
> > IIO subsystem.
>
> ...
>
> > +config SENSEAIR_SUNRISE_CO2
> > +       tristate "Senseair Sunrise 006-0-0007 CO2 sensor"
>
> > +       depends on I2C
>
> Actually
>
> select REGMAP_I2C

Ugh, thanks

>
> ...
>
> > + * List of features not yet supported by the driver:
> > + * - support for controllable EN pin
>
> To avoid tautology
>
> * - controllable EN pin
>
>
> > + * - support for single-shot operations using the nDRY pin.
>
> Ditto.
>
> * - single-shot operations using the nDRY pin.

Right :)

>
> > + * - ABC/target calibration
>
> ...
>
> > +#include <linux/i2c.h>
>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
>
> Can you move this as a separate group...
>
> > +#include <linux/kernel.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/sysfs.h>
>
> ...here ?

Ah, is this customary in the subsystem ?

>
> ...
>
> > +#define SUNRISE_CALIBRATION_TIMEOUT_US         30000000
>
> 30 * USEC_PER_SEC ?
>

ack

> ...
>
> > +static void sunrise_wakeup(struct sunrise_dev *sunrise)
> > +{
> > +       struct i2c_client *client = sunrise->client;
> > +
> > +       /*
> > +        * Wake up sensor by sending sensor address: START, sensor address,
> > +        * STOP. Sensor will not ACK this byte.
> > +        *
> > +        * The chip returns in low power state after 15msec without
> > +        * communications or after a complete read/write sequence.
> > +        */
>
> I'm wondering if there is a better way to perform this.
>

Do you mean using a different API instead of i2c_smbus_xfer()?

In v1 I had smbus_read_byte(), which expects a reply. The sensor sends
a NACK so the communication is interrupted and the effect is actually
the same but it seemed a little abuse to me.

The i2c documentation describes

SMBus Quick Command
===================

This sends a single bit to the device, at the place of the Rd/Wr bit::

  S Addr Rd/Wr [A] P

Functionality flag: I2C_FUNC_SMBUS_QUICK

Which is exactly what I want, but there's no API (or I have found
none) to perform that (I haven't looked at logs, but I suspect it has
been removed?). So I went and call i2c_smbus_xfer() by hand with the
opportune flags. It feels kind of a layering violation, as ideally
this should go through an i2c_smbus_send_bit() or something, but if
it's not there there might be a reason ?


> > +       i2c_smbus_xfer(client->adapter, client->addr, I2C_M_IGNORE_NAK,
> > +                      I2C_SMBUS_WRITE, 0, I2C_SMBUS_QUICK, NULL);
> > +}
>
> ...
>
> > +               dev_err(sunrise->dev, "Read word failed: reg 0x%2x (%d)\n",
> > +                       reg, ret);
>
> One line?

Goes over 80, as all the other identical comments below.

>
> ...
>
> > +               dev_err(sunrise->dev, "Write byte failed: reg 0x%2x (%d)\n",
> > +                       reg, ret);
>
> One line?
>
> ...
>
> > +               dev_err(sunrise->dev, "Write word failed: reg 0x%2x (%d)\n",
> > +                       reg, ret);
>
> One line?
>
> ...
>
> > +       /* Write calibration command and poll the calibration status bit. */
>
> Write a calibration

Ack

>
> ...
>
> > +static ssize_t sunrise_calibration_write(struct iio_dev *iiodev,
> > +                                        uintptr_t private,
> > +                                        const struct iio_chan_spec *chan,
> > +                                        const char *buf, size_t len)
> > +{
> > +       struct sunrise_dev *sunrise = iio_priv(iiodev);
> > +       bool calibrate;
> > +       int ret;
> > +
> > +       ret = kstrtobool(buf, &calibrate);
> > +       if (ret)
>
> > +               return -EINVAL;
>
> Shadowed return code.
>

ok

> > +       if (!calibrate)
> > +               return 0;
> > +
> > +       ret = sunrise_calibrate(sunrise);
> > +
> > +       return ret ?: len;
>
> In this case
>
>   if (ret)
>     return ret;
>
> return len;
>
> will look more natural.

I had this and I switched before sending. Matter of tastes I guess.
I actually changed this as I thought it would have pleased you :)


>
> > +}
>
> ...
>
> > +static ssize_t sunrise_error_status_read(struct iio_dev *iiodev,
> > +                                        uintptr_t private,
> > +                                        const struct iio_chan_spec *chan,
> > +                                        char *buf)
> > +{
> > +       struct sunrise_dev *sunrise = iio_priv(iiodev);
> > +       ssize_t len = 0;
> > +       u16 value;
> > +       int ret;
> > +       u8 i;
> > +
> > +       ret = sunrise_read_word(sunrise, SUNRISE_ERROR_STATUS_REG, &value);
> > +       if (ret)
> > +               return -EINVAL;
>
> > +       for (i = 0; i < ARRAY_SIZE(error_codes); ++i) {
> > +               if (!(value & BIT(error_codes[i])))
> > +                       continue;
>
> for_each_set_bit()

only 12 bits are valid, the top 4 are undocumented. They -should- be
zeroed but who knows.

>
> > +               len += sysfs_emit_at(buf, len, "%s ",
> > +                                    sunrise_error_statuses[i]);
>
> One line?

way more than 80 cols!
I know there were discussions on dropping this as an hard limit, but
when possible shouldn't we strive to respect it ?

>
> > +       }
> > +
> > +       if (len)
> > +               buf[len - 1] = '\n';
> > +
> > +       return len;
> > +}
>
> ...
>
> > +static const struct iio_chan_spec_ext_info sunrise_concentration_ext_info[] = {
> > +       /* Calibration modes and calibration trigger. */
> > +       {
> > +               .name = "calibration",
> > +               .write = sunrise_calibration_write,
> > +               .shared = IIO_SEPARATE,
> > +       },
>
> > +       IIO_ENUM("calibration_mode", IIO_SEPARATE,
> > +                &sunrise_calibration_modes_enum),
>
> One line?
>
> > +       IIO_ENUM_AVAILABLE("calibration_mode",
> > +                          &sunrise_calibration_modes_enum),
>
> One line?
>
> > +       /* Error statuses. */
> > +       {
> > +               .name = "error_status",
> > +               .read = sunrise_error_status_read,
> > +               .shared = IIO_SEPARATE,
> > +       },
> > +       IIO_ENUM_AVAILABLE("error_status", &sunrise_error_statuses_enum),
>
> > +       {},
>
> No comma for terminator entries.
>
> > +};
>
> ...
>
> > +static int sunrise_read_raw(struct iio_dev *iio_dev,
> > +                           const struct iio_chan_spec *chan,
> > +                           int *val, int *val2, long mask)
> > +{
> > +       struct sunrise_dev *sunrise = iio_priv(iio_dev);
> > +       u16 value;
> > +       int ret;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
>
> > +
>
> Redundant blank line.
>
> > +               mutex_lock(&sunrise->lock);
> > +
> > +               switch (chan->type) {
> > +               case IIO_CONCENTRATION: {
> > +                       ret = sunrise_read_word(sunrise,
> > +                                               SUNRISE_CO2_FILTERED_COMP_REG,
> > +                                               &value);
> > +                       *val = value;
> > +                       mutex_unlock(&sunrise->lock);
> > +
> > +                       return ret ?: IIO_VAL_INT;
> > +               }
>
> You don't need {} anymore.

Correct!

>
> > +               case IIO_TEMP: {
> > +                       ret = sunrise_read_word(sunrise,
> > +                                               SUNRISE_CHIP_TEMPERATURE_REG,
> > +                                               &value);
> > +                       *val = value;
> > +                       mutex_unlock(&sunrise->lock);
> > +
> > +                       return ret ?: IIO_VAL_INT;
> > +               }
>
> Ditto.
>
> > +               default:
> > +                       mutex_unlock(&sunrise->lock);
> > +                       return -EINVAL;
> > +               }
> > +
> > +       case IIO_CHAN_INFO_SCALE:
> > +               /* Chip temperature scale = 1/100 */
> > +               *val = 1;
> > +               *val2 = 100;
> > +               return IIO_VAL_FRACTIONAL;
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }
>
> > +
> > +       return 0;
>
> Dead code?

It is, but it seems nicer :) Should I drop it ? I recall I've been
asked to add it to the end of switch() in other drivers in this
subsystem...

Thanks again for the review
    j

>
> > +}
>
>
> --
> With Best Regards,
> Andy Shevchenko
