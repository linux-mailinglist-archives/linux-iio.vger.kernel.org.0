Return-Path: <linux-iio+bounces-239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188A07F35A6
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 19:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A731C20CD6
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A8522095;
	Tue, 21 Nov 2023 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ad33/xWL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1AC193;
	Tue, 21 Nov 2023 10:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700590153; x=1732126153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yHEC4S+USi7PSchgfSRakwc7J069NWU7+11K8utmgL8=;
  b=ad33/xWLrDe9kUH6f8H0YvAtdwjeUOY1lwT8n1eL7jszyIDoAvmFXUbd
   qUrD3vSm4pnwOAMf2X5EfNiGxPUKUS34RYfQsdrmmGb2Kbc7n5pgf7Wbs
   Do5Sc1OQ3bD7f7QIVj336HG4xwegokrrnV9rERLaijlogJ/KdtkI9+GFJ
   TTmxvGYqmhCFC+iVY91vecAtxqG84eyEcW/YySaRZkcTAMs8eCkCaxtWu
   HmI0a6Db5SAri+nvvbg2wXHRfveV4X5fDAijTNxeoz46DqobayYv767tg
   DiXyAMkpJzdRYyRKm/chPj6+B8grXl/7ccwhR3E3bBGNYS4wlfZoMVkz+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5025674"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="5025674"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:09:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910537274"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="910537274"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:09:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r5VBH-0000000FsqJ-3cGH;
	Tue, 21 Nov 2023 20:09:03 +0200
Date: Tue, 21 Nov 2023 20:09:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andre Werner <andre.werner@systec-electronic.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Rob Herring <robh+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	Vincent Tremblay <vincent@vtremblay.dev>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <ZVzyP0Oj1J0efmGO@smile.fi.intel.com>
References: <20231121031043.327614-1-marex@denx.de>
 <20231121031043.327614-2-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121031043.327614-2-marex@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 21, 2023 at 04:10:40AM +0100, Marek Vasut wrote:
> The ISL76682 is very basic ALS which only supports ALS or IR mode
> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> other fancy functionality.

...

> +	for (i = 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
> +		if (chan->type == IIO_LIGHT) {
> +			if (val2 != isl76682_range_table[i].als)
> +				continue;
> +		} else if (chan->type == IIO_INTENSITY) {
> +			if (val2 != isl76682_range_table[i].ir)
> +				continue;
> +		}

Redundant 'else' and you can combine if:s.

		if (chan->type == IIO_LIGHT && val2 != isl76682_range_table[i].als)
			continue;
		if (chan->type == IIO_INTENSITY && val2 != isl76682_range_table[i].ir)
			continue;

But it's up to you and Jonathan.

> +		scoped_guard(mutex, &chip->lock)
> +			chip->range = isl76682_range_table[i].range;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}

...

> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = isl76682_get(chip, false, val);
> +			return (ret < 0) ? ret : IIO_VAL_INT;
> +		case IIO_INTENSITY:
> +			ret = isl76682_get(chip, true, val);
> +			return (ret < 0) ? ret : IIO_VAL_INT;

> +		default:
> +			break;
> +		}
> +
> +		return -EINVAL;

		default:
			return -EINVAL;

...

> +static const struct of_device_id isl76682_of_match[] = {
> +	{ .compatible = "isil,isl76682", },

Inner comma is not needed.

> +	{ }
> +};

...

> +
> +module_i2c_driver(isl76682_driver);
> +MODULE_DESCRIPTION("ISL76682 Ambient Light Sensor driver");

...other way around:

};
module_i2c_driver(isl76682_driver);

MODULE_DESCRIPTION("ISL76682 Ambient Light Sensor driver");

...

Assuming you address all these,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko



