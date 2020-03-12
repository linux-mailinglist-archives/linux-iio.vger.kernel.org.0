Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407C11837FC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 18:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgCLRtk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 13:49:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:16068 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgCLRtj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Mar 2020 13:49:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 10:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="246448945"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 12 Mar 2020 10:49:32 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jCRxd-00944x-F9; Thu, 12 Mar 2020 19:49:33 +0200
Date:   Thu, 12 Mar 2020 19:49:33 +0200
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
Subject: Re: [PATCH 2/5] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200312174933.GJ1922688@smile.fi.intel.com>
References: <20200312172649.13702-1-sravanhome@gmail.com>
 <20200312172649.13702-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312172649.13702-3-sravanhome@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 12, 2020 at 06:26:46PM +0100, Saravanan Sekar wrote:
> mp2629 is a highly-integrated switching-mode battery charge management
> device for single-cell Li-ion or Li-polymer battery.
> 
> Add MFD core enables chip access for ADC driver for battery readings,
> and a power supply battery-charger driver

...

>  drivers/mfd/Kconfig        |  43 +++++----------

Why do you have unrelated changes here?

...

> +int mp2629_set_value(struct regmap *map, u8 reg, u8 mask, unsigned int val)
> +{
> +	return regmap_update_bits(map, reg, mask, val);
> +}
> +EXPORT_SYMBOL(mp2629_set_value);
> +
> +int mp2629_get_value(struct regmap *map, u8 reg, unsigned int *val)
> +{
> +	return regmap_read(map, reg, val);
> +}
> +EXPORT_SYMBOL(mp2629_get_value);

I'm wondering why a child can get access to parent's regmap?
I.o.w. why is this being exported?

...

> +static int mp2629_probe(struct i2c_client *client)
> +{
> +	struct mp2629_info *info;
> +	int ret;
> +

> +	info = devm_kzalloc(&client->dev, sizeof(struct mp2629_info),
> +					 GFP_KERNEL);

	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);

will be shorter.

> +	if (!info)
> +		return -ENOMEM;


> +	ret = devm_mfd_add_devices(info->dev, -1, mp2629mfd,
> +				ARRAY_SIZE(mp2629mfd), NULL,
> +				0, NULL);

-1 has a defined name in this case.

> +	if (ret)
> +		dev_err(info->dev, "Failed to add mfd %d\n", ret);
> +
> +	return ret;
> +}

...

> +static const struct of_device_id mp2629_of_match[] = {
> +	{ .compatible = "mps,mp2629"},

> +	{},

Terminator line doesn't require comma.

> +};

...

> +static const struct i2c_device_id mp2629_id[] = {
> +	{ "mp2629", },

> +	{ },

Ditto.

> +};
> +MODULE_DEVICE_TABLE(i2c, mp2629_id);

...

> +		.of_match_table = of_match_ptr(mp2629_of_match),

of_match_ptr() is redundant and even might provoke compiler warning...

> +	.probe_new	= mp2629_probe,

...especially taking into consideration ->probe_new().

...

> +#include <linux/platform_device.h>

No user here. (Hint: Use forward declaration of struct device instead)

> +#include <linux/i2c.h>

Ditto.

> +#include <linux/regmap.h>

Ditto. (Hint: Use forward declaration of struct regmap instead)

But linux/types.h is actually missed.

> +int mp2629_set_value(struct regmap *map, u8 reg, u8 mask, unsigned int val);
> +int mp2629_get_value(struct regmap *map, u8 reg, unsigned int *val);

-- 
With Best Regards,
Andy Shevchenko


