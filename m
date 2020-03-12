Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D909183804
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 18:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCLRxI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 13:53:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:31843 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgCLRxI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Mar 2020 13:53:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 10:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="354183796"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2020 10:53:02 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jCS11-00947a-BG; Thu, 12 Mar 2020 19:53:03 +0200
Date:   Thu, 12 Mar 2020 19:53:03 +0200
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
Subject: Re: [PATCH 3/5] iio: adc: mp2629: Add support for mp2629 ADC driver
Message-ID: <20200312175303.GK1922688@smile.fi.intel.com>
References: <20200312172649.13702-1-sravanhome@gmail.com>
 <20200312172649.13702-4-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312172649.13702-4-sravanhome@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 12, 2020 at 06:26:47PM +0100, Saravanan Sekar wrote:
> Add support for 8-bit resolution ADC readings for input power
> supply and battery charging measurement. Provides voltage, current
> readings to mp2629 power supply driver.

...

> +	struct mp2629_info *info = adc_info->info;
> +	unsigned int rval;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = mp2629_get_value(info->regmap, chan->address, &rval);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (chan->address == MP2629_INPUT_VOLT)
> +			rval &= 0x7f;
> +		*val = rval;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->channel) {
> +		case MP2629_BATT_VOLT:
> +		case MP2629_SYSTEM_VOLT:
> +			*val = 20;
> +			return IIO_VAL_INT;
> +
> +		case MP2629_INPUT_VOLT:
> +			*val = 60;
> +			return IIO_VAL_INT;
> +
> +		case MP2629_BATT_CURRENT:
> +			*val = 175;
> +			*val2 = 10;
> +			return IIO_VAL_FRACTIONAL;
> +
> +		case MP2629_INPUT_CURRENT:
> +			*val = 133;
> +			*val2 = 10;
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +		break;
> +
> +	default:

> +		ret = -EINVAL;
> +		break;

return -EINVAL;

> +	}
> +

> +	return ret;

	return 0;
?

What is default case for wrong channel in INFO_SCALE?

> +}

...

> +static const struct of_device_id mp2629_adc_of_match[] = {
> +	{ .compatible = "mps,mp2629_adc"},

> +	{},

No comma needed.

> +};

-- 
With Best Regards,
Andy Shevchenko


