Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C58183838
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 19:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCLSG5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 14:06:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:38573 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCLSG5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Mar 2020 14:06:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 11:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="277909647"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 12 Mar 2020 11:06:51 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jCSEO-0094JE-Gf; Thu, 12 Mar 2020 20:06:52 +0200
Date:   Thu, 12 Mar 2020 20:06:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, fabrice.gasnier@st.com,
        beniamin.bia@analog.com, linus.walleij@linaro.org,
        u.kleine-koenig@pengutronix.de, fabrizio.castro@bp.renesas.com,
        info@metux.net, hancock@sedsystems.ca, gregory.clement@bootlin.com,
        renatogeh@gmail.com, plr.vincent@gmail.com,
        miquel.raynal@bootlin.com, marcelo.schmitt1@gmail.com,
        paul@crapouillou.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/5] power: supply: Add support for mps mp2629 battery
 charger
Message-ID: <20200312180652.GL1922688@smile.fi.intel.com>
References: <20200312172649.13702-1-sravanhome@gmail.com>
 <20200312172649.13702-5-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312172649.13702-5-sravanhome@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 12, 2020 at 06:26:48PM +0100, Saravanan Sekar wrote:
> The mp2629 provides switching-mode battery charge management for
> single-cell Li-ion or Li-polymer battery. Driver supports the
> access/control input source and battery charging parameters.

...

>  drivers/power/supply/Kconfig          |  14 +-

Why unrelated changes here?

...

> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/types.h>
> +#include <linux/power_supply.h>
> +#include <linux/workqueue.h>

All of them are needed?

...

> +enum mp2629_source_type {
> +	MP2629_SOURCE_TYPE_NO_INPUT,
> +	MP2629_SOURCE_TYPE_NON_STD,
> +	MP2629_SOURCE_TYPE_SDP,
> +	MP2629_SOURCE_TYPE_CDP,
> +	MP2629_SOURCE_TYPE_DCP,
> +	MP2629_SOURCE_TYPE_OTG = 7

 + comma? (It is not obvious there will be no extension in the future)

> +};
> +
> +enum {
> +	INPUT_ILIM,
> +	INPUT_VLIM,
> +	CHARGE_ILIM,
> +	CHARGE_VLIM,
> +	PRECHARGE,

> +	TERM_CURRENT

Ditto.

> +};

...

> +static enum power_supply_usb_type mp2629_usb_types[] = {
> +	POWER_SUPPLY_USB_TYPE_SDP,
> +	POWER_SUPPLY_USB_TYPE_DCP,
> +	POWER_SUPPLY_USB_TYPE_CDP,
> +	POWER_SUPPLY_USB_TYPE_PD_DRP,

> +	POWER_SUPPLY_USB_TYPE_UNKNOWN,

Here it seems other way around, i.e. no comma.

> +};
> +
> +static enum power_supply_property mp2629_charger_usb_props[] = {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,

> +	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT

...but here again, it can be extended.

> +};
> +
> +static enum power_supply_property mp2629_charger_bat_props[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,

> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX

Ditto.

> +};
> +
> +static struct mp2629_prop props[] = {
> +	MP2629_PROPS(INPUT_ILIM, 100000, 3250000, 50000, 0),
> +	MP2629_PROPS(INPUT_VLIM, 3800000, 5300000, 100000, 0),
> +	MP2629_PROPS(CHARGE_ILIM, 320000, 4520000, 40000, 0),
> +	MP2629_PROPS(CHARGE_VLIM, 3400000, 4670000, 10000, 1),
> +	MP2629_PROPS(PRECHARGE, 120000, 720000, 40000, 4),

> +	MP2629_PROPS(TERM_CURRENT, 80000, 680000, 40000, 0)

Ditto.

> +};

...

> +static char *adc_chan_name[] = { "mp2629-batt-volt", "mp2629-system-volt",
> +				 "mp2629-input-volt", "mp2629-batt-current",
> +				 "mp2629-input-current" };

One item per line, please. And comma in the last, new compatible hw might have
more channels.

> +	ret = mp2629_get_value(map, prop->reg, &rval);
> +	if (!ret) {
> +		rval = (rval & prop->mask) >> prop->shift;
> +		val->intval = (rval * prop->step) + prop->min;
> +	}

Sounds like regmap field operation...
Ditto for similar code.

> +
> +	return ret;
> +}

...


> +	default:
> +		ret = -EINVAL;
> +		break;

return -EINVAL;

...

> +	default:
> +		ret = -EINVAL;
> +		break;

Ditto.

...

> +	default:
> +		ret = -EINVAL;
> +		break;

Ditto.

...

> +	return (psp == POWER_SUPPLY_PROP_PRECHARGE_CURRENT ||
> +		psp == POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT ||
> +		psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT ||
> +		psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE);

Too many parentheses.

...

> +	return (psp == POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT ||
> +		psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT);

Ditto.

...

> +	if (kstrtol(buf, 10, &val) < 0)
> +		return -EINVAL;

Don't shadow the actual error code.

> +
> +	if (val < 0 && val > 140)

> +		return -EINVAL;

ERANGE is better.

...

> +static DEVICE_ATTR(batt_impedance_compensation, 0644,
> +		mp2629_sysfs_impedance_show, mp2629_sysfs_impedance_store);

DEVICE_ATTR_RW()

> +static struct attribute *mp2629_charger_sysfs_attrs[] = {
> +	&dev_attr_batt_impedance_compensation.attr,

> +	NULL,

No comma.

> +};

...

> +static int mp2629_charger_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mp2629_charger *charger;
> +	struct mp2629_info *info;
> +	struct power_supply_config psy_cfg = {0};
> +	int ret, i;

> +	platform_set_drvdata(pdev, charger);

> +	info = dev_get_drvdata(dev->parent);

Could be assigned in definition block above.

> +	charger->info = info;
> +	charger->dev = dev;
> +
> +	for (i = 0; i < MP2629_ADC_CHAN_END; i++) {
> +		charger->iiochan[i] = iio_channel_get(dev, adc_chan_name[i]);
> +		if (IS_ERR(charger->iiochan[i])) {
> +			ret = PTR_ERR(charger->iiochan[i]);
> +			goto iio_fail;
> +		}
> +	}

> +	return 0;
> +
> +iio_fail:

> +	for (i = 0; i < MP2629_ADC_CHAN_END; i++) {
> +		if (charger->iiochan[i] && !(IS_ERR(charger->iiochan[i])))
> +			iio_channel_release(charger->iiochan[i]);
> +	}

	while (i--)
		iio_channel_release(charger->iiochan[i]);

> +
> +	dev_err(dev, "driver register fail: %d\n", ret);
> +	return ret;
> +}

...

> +	for (i = 0; i < MP2629_ADC_CHAN_END; i++) {

> +		if (charger->iiochan[i])

When this is possible?
And shouldn't iio_channel_release() take care of NULL pointer? If it doesn't,
fix it in preparatory patch.

> +			iio_channel_release(charger->iiochan[i]);
> +	}

...

> +static const struct of_device_id mp2629_charger_of_match[] = {
> +	{ .compatible = "mps,mp2629_charger"},

> +	{},

No comma.

> +};


-- 
With Best Regards,
Andy Shevchenko


