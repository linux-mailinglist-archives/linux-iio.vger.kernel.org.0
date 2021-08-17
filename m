Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554673EF085
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 18:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhHQQ7T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 12:59:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:65423 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhHQQ7T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Aug 2021 12:59:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="213025298"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="213025298"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 09:58:45 -0700
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="531149381"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 09:58:44 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mG2QA-00AoTg-Bv; Tue, 17 Aug 2021 19:58:38 +0300
Date:   Tue, 17 Aug 2021 19:58:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: chemical: Add Senseair Sunrise 006-0-007 driver
Message-ID: <YRvqvt4qVVe1+K1/@smile.fi.intel.com>
References: <20210817154951.50208-1-jacopo@jmondi.org>
 <20210817154951.50208-3-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210817154951.50208-3-jacopo@jmondi.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 17, 2021 at 05:49:51PM +0200, Jacopo Mondi wrote:
> Add support for the Senseair Sunrise 006-0-0007 driver through the
> IIO subsystem.

Datasheet tag / link?

...

> +config SUNRISE
> +	tristate "Senseair Sunrise 006-0-0007 CO2 sensor"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for Senseair Sunrise 006-0-0007 CO2
> +	  sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sunrise.

Too generic name for configuration and module,

...

> + * iio/co2/sunrise-006-0-0007.c
> + *

Redundant noise.

...

> + * TODO: Add support for controllable EN pin
> + * TODO: Add support for single-shot operations by using the nDRY pin.

Ditto.

If it's not ready, then make it ready.

...


> +#include <linux/of_device.h>

Why? Perhaps mod_devicetable,h is what you had in mind.

...

> +	i2c_smbus_read_byte(client);

Can you use regmap I²C API?

...

> +#define sunrise_readb_client(client, addr)	\
> +({						\
> +	u8 _val;				\
> +	sunrise_read_byte(client, addr, &_val); \
> +	_val;					\
> +})
> +#define sunrise_readb(addr)	sunrise_readb_client(client, addr)

Drop ugly macros and use read_poll_timeout() below.

> +#define sunrise_poll_register(reg, val, cond)	\
> +	readx_poll_timeout(sunrise_readb, reg, val, cond, 100, 0)


...

> +static int sunrise_read_raw(struct iio_dev *iio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct sunrise_dev *sunrise = iio_priv(iio_dev);
> +	struct i2c_client *client = sunrise->client;

+ u16 value;

> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +
> +		mutex_lock(&sunrise->lock);
> +
> +		switch (chan->type) {
> +		case IIO_CONCENTRATION: {
> +			u16 co2;

Reuse value.

> +			ret = sunrise_read_co2_filtered(client, &co2);
> +			*val = co2;
> +			mutex_unlock(&sunrise->lock);
> +
> +			return ret ? ret : IIO_VAL_INT;

Can be written as

			return ret ?: IIO_VAL_INT;

but up to maintainers.

> +		}
> +
> +		case IIO_TEMP: {
> +			u16 temp;

Reuse value.

> +			ret = sunrise_read_word(client,
> +						SUNRISE_CHIP_TEMPERATURE_REG,
> +						&temp);
> +			*val = temp;
> +			mutex_unlock(&sunrise->lock);
> +
> +			return ret ? ret : IIO_VAL_INT;
> +		}
> +
> +		default:
> +			mutex_unlock(&sunrise->lock);
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Chip temperature scale = 1/100 */
> +		*val = 1;
> +		*val2 = 100;
> +		return IIO_VAL_FRACTIONAL;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

...

> +	return sunrise_poll_register(SUNRISE_CALIBRATION_STATUS_REG, status,
> +				     (status & BIT(5)));

Too many parentheses.

-- 
With Best Regards,
Andy Shevchenko


