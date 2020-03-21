Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5918E4F6
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCUV4a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:56:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:52636 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgCUV4a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 17:56:30 -0400
IronPort-SDR: TpR6iY2wseZt+2/PQmzTfMLcfIkHGREpXlMpmotomSRAltSbaoRQlZN4hIpw2s9wG81HJ0yvFr
 833tH8gWYhwg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2020 14:56:29 -0700
IronPort-SDR: cgTcSgZrPiurxit+x25KUlqG1UBg26PwgbfjGoi45zQyUDXcXkcb/Ekr58mapPHUsd54tmBDgc
 XgGkMadd7jrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,290,1580803200"; 
   d="scan'208";a="325206721"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2020 14:56:26 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jFm6W-00BpXb-S8; Sat, 21 Mar 2020 23:56:28 +0200
Date:   Sat, 21 Mar 2020 23:56:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Alexandru Lazar <alazar@startmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v4 2/2] iio: adc: Add MAX1241 driver
Message-ID: <20200321215628.GA2819421@smile.fi.intel.com>
References: <20200320150114.9297-1-alazar@startmail.com>
 <20200320150114.9297-3-alazar@startmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320150114.9297-3-alazar@startmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 20, 2020 at 05:01:15PM +0200, Alexandru Lazar wrote:
> Add driver for the Maxim MAX1241 12-bit, single-channel ADC. The driver
> includes support for this device's low-power operation mode.

...

> +#include <linux/regulator/consumer.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>

I think you can keep them sorted.

...

> +#define MAX1241_VAL_MASK 0xFFF

GENMASK() ?

...

> +		if (adc->shdn) {
> +			gpiod_set_value(adc->shdn, 0);
> +			udelay(MAX1241_SHDN_DELAY_USEC);
> +		}
> +
> +		ret = max1241_read(adc);
> +
> +		if (adc->shdn)
> +			gpiod_set_value(adc->shdn, 1);

I guess easier to read in a way

		if () {
			gpio...
			read();
			gpio...
		} else {
			read();
		}

Or actually introduce runtime PM and move these gpio calls there.


...

> +static int max1241_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct max1241 *adc;

> +	int ret = 0;

Redundant assignment.

> +	ret = regulator_enable(adc->reg);
> +	if (ret)
> +		return ret;
> +

> +	ret = devm_add_action_or_reset(&spi->dev, max1241_disable_reg_action,
> +					adc);

Introducing
	struct device *dev = &spi->dev;
will simplifies such lines like above by making them on one line.

> +	if (ret) {
> +		dev_err(&spi->dev, "could not set up regulator cleanup action!\n");
> +		return ret;
> +	}

> +	adc->shdn = devm_gpiod_get_optional(&spi->dev, "shdn", GPIOD_OUT_HIGH);

> +

Redundant blank line.

> +	if (IS_ERR(adc->shdn))
> +		return PTR_ERR(adc->shdn);

> +	if (!adc->shdn)

Why not to use positive conditional?

> +		dev_dbg(&spi->dev, "no shdn pin passed, low-power mode disabled");
> +	else
> +		dev_dbg(&spi->dev, "shdn pin passed, low-power mode enabled");

> +}

...

> +static const struct spi_device_id max1241_id[] = {
> +	{ "max1241", max1241 },

> +	{},

Terminators better w/o comma.

> +};
> +
> +static const struct of_device_id max1241_dt_ids[] = {
> +	{ .compatible = "maxim,max1241" },

> +	{},

Ditto.

> +};

-- 
With Best Regards,
Andy Shevchenko


