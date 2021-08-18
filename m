Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424273EFE8A
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 10:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbhHRICX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 04:02:23 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:41321 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbhHRICD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 04:02:03 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0BDE11BF206;
        Wed, 18 Aug 2021 08:01:25 +0000 (UTC)
Date:   Wed, 18 Aug 2021 10:02:13 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: chemical: Add Senseair Sunrise 006-0-007 driver
Message-ID: <20210818080213.d56phfmjlwbgzlca@uno.localdomain>
References: <20210817154951.50208-1-jacopo@jmondi.org>
 <20210817154951.50208-3-jacopo@jmondi.org>
 <YRvqvt4qVVe1+K1/@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRvqvt4qVVe1+K1/@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy, thanks for review

On Tue, Aug 17, 2021 at 07:58:38PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 17, 2021 at 05:49:51PM +0200, Jacopo Mondi wrote:
> > Add support for the Senseair Sunrise 006-0-0007 driver through the
> > IIO subsystem.
>
> Datasheet tag / link?

It's reported in the bindings document, I can copy it here

>
> ...
>
> > +config SUNRISE
> > +	tristate "Senseair Sunrise 006-0-0007 CO2 sensor"
> > +	depends on I2C
> > +	help
> > +	  Say yes here to build support for Senseair Sunrise 006-0-0007 CO2
> > +	  sensor.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called sunrise.
>
> Too generic name for configuration and module,

I got the same feeling but at the same time SUNRISE_006_0_0007 seems a
bit too long. Would you suggest to go for that one ? Should I also
rename the .c file accordingly ?

>
> ...
>
> > + * iio/co2/sunrise-006-0-0007.c
> > + *
>
> Redundant noise.
>
> ...
>
> > + * TODO: Add support for controllable EN pin
> > + * TODO: Add support for single-shot operations by using the nDRY pin.
>
> Ditto.
>
> If it's not ready, then make it ready.

If I place myself in the perspective of someone interested in
verifying support for this chip in linux, I would first be happy I
found a driver for it, then I would even be happier if I got a clear
notice of what features the driver supports and which ones are missing.
Even more so if I look at bindings and find mention of two GPIO lines
which I don't see handled in the driver. A TODO note would make it
clear that those features are missing.

The "make it ready" it's a little bit a non-sense to me, can you count
how many drivers support -all- the features a device provides ? In the
test board I'm using those lines are not even wired, should I throw
around code I cannot even test ?

>
> ...
>
>
> > +#include <linux/of_device.h>
>
> Why? Perhaps mod_devicetable,h is what you had in mind.
>

Ah yes indeed. I got it wrong in so many places in the past !

> ...
>
> > +	i2c_smbus_read_byte(client);
>
> Can you use regmap I²C API?
>

Do you think it's worth it ?
I admit I never used regmap API so far, but I always got the
impression that for such simple devices it's a bit an overkill. What
benefit would it bring here ?

> ...
>
> > +#define sunrise_readb_client(client, addr)	\
> > +({						\
> > +	u8 _val;				\
> > +	sunrise_read_byte(client, addr, &_val); \
> > +	_val;					\
> > +})
> > +#define sunrise_readb(addr)	sunrise_readb_client(client, addr)
>
> Drop ugly macros and use read_poll_timeout() below.

Ah! Thanks a lot, I missed the fact read_poll_timeout() accepts
a variable number of arguments...
However, the API of the driver i2c read function is:

        int sunrise_read_byte(client, reg, *val);

while read_poll_timeout() expects

        int read(client, reg);

I know the answer already: change your i2c accessor to comply.
As it is only used by read_poll_timeout() I'll do so :)

>
> > +#define sunrise_poll_register(reg, val, cond)	\
> > +	readx_poll_timeout(sunrise_readb, reg, val, cond, 100, 0)
>
>
> ...
>
> > +static int sunrise_read_raw(struct iio_dev *iio_dev,
> > +			    const struct iio_chan_spec *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct sunrise_dev *sunrise = iio_priv(iio_dev);
> > +	struct i2c_client *client = sunrise->client;
>
> + u16 value;
>
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +
> > +		mutex_lock(&sunrise->lock);
> > +
> > +		switch (chan->type) {
> > +		case IIO_CONCENTRATION: {
> > +			u16 co2;
>
> Reuse value.
>

Ack

> > +			ret = sunrise_read_co2_filtered(client, &co2);
> > +			*val = co2;
> > +			mutex_unlock(&sunrise->lock);
> > +
> > +			return ret ? ret : IIO_VAL_INT;
>
> Can be written as
>
> 			return ret ?: IIO_VAL_INT;
>
> but up to maintainers.
>

You know I never saw this syntax before ? :D
I'll use it!

> > +		}
> > +
> > +		case IIO_TEMP: {
> > +			u16 temp;
>
> Reuse value.
>

ack

> > +			ret = sunrise_read_word(client,
> > +						SUNRISE_CHIP_TEMPERATURE_REG,
> > +						&temp);
> > +			*val = temp;
> > +			mutex_unlock(&sunrise->lock);
> > +
> > +			return ret ? ret : IIO_VAL_INT;
> > +		}
> > +
> > +		default:
> > +			mutex_unlock(&sunrise->lock);
> > +			return -EINVAL;
> > +		}
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		/* Chip temperature scale = 1/100 */
> > +		*val = 1;
> > +		*val2 = 100;
> > +		return IIO_VAL_FRACTIONAL;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
>
> ...
>
> > +	return sunrise_poll_register(SUNRISE_CALIBRATION_STATUS_REG, status,
> > +				     (status & BIT(5)));
>
> Too many parentheses.

Right!

Thanks for review!

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
