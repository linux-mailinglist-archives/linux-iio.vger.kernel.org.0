Return-Path: <linux-iio+bounces-466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E045D7FBFBF
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 17:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C48D1C20C6A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5FC5C064;
	Tue, 28 Nov 2023 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPvN2BhZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DE9D4B;
	Tue, 28 Nov 2023 08:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701190458; x=1732726458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rBLBZwxnwboOcGZ4yYzLMiS1WGPL9Qxe1NKjYqK/J1k=;
  b=LPvN2BhZiVKBbfz2LNVQfTAzlginOXjDmUqAoEHZ4MNGmPlggcJAehyN
   Nn1UhJCQrG4yYVpDqmrj0edjNlMDCpLw3lNYMcGcHEou813i/3PDoW/Ls
   9VV5In49z1kdivfRo5jIeHgYp6eb7U+6iyq22YbHkKcFO8qjPRCGTSkSf
   fmxxcMFiEAPlt2BDx9iOBUJ+CRSwLiM+r24MKEpX3DHgMOnPYM8JKbo5A
   Bh/T6N7YFe1yT+cn4S3bcUaMdqaKMb2/MvFQ2yAYO378FGM5qNpcsmV9m
   UvulclWskwm7NSDUUabMxx5b0dfn3IsgUqgAeqMRkg9Kuj6+QE7kUeAm7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="457294935"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="457294935"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:54:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="859480364"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="859480364"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:54:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r81Lf-00000000DKX-15Dq;
	Tue, 28 Nov 2023 18:54:11 +0200
Date: Tue, 28 Nov 2023 18:54:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <ZWYbMnYEDmwNteEy@smile.fi.intel.com>
References: <20231128124103.22765-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128124103.22765-1-petre.rodan@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 28, 2023 at 02:40:58PM +0200, Petre Rodan wrote:
> Adds driver for digital Honeywell TruStability HSC and SSC series
> pressure and temperature sensors. 

Trailing white space.

> Communication is one way. The sensor only requires 4 bytes worth of
> clock pulses on both i2c and spi in order to push the data out.
> The i2c address is hardcoded and depends on the part number.
> There is no additional GPIO control.

...

> +	default:
> +		return -EINVAL;
> +	}

> +	return -EINVAL;

Dead code.

...

> +int hsc_common_probe(struct device *dev, void *client,
> +	    int (*recv_fct)(struct hsc_data *data), const char *name)

Make it a typedef

typedef int (*hsc_recv_fn)(struct hsc_data *);

(note the fn suffix as standard in such cases).

...

> +	ret = device_property_read_u32(dev,
> +				       "honeywell,transfer-function",
> +				       &hsc->function);

Strange indentation.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			    "honeywell,transfer-function could not be read\n");

...

> +	ret = device_property_read_string(dev,
> +		"honeywell,pressure-triplet", &triplet);

Strange indentation.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			"honeywell,pressure-triplet could not be read\n");

...

> +	if (strncmp(triplet, "NA", 2) == 0) {
> +		/* "not available" in the nomenclature
> +		   we got a custom-range chip so extract pmin, pmax from dt */

Wrong comment style. And I believe I already said, respect English grammar
and punctuation! Ditto for other multi-line comments in this patch.

> +		ret = device_property_read_u32(dev,
> +					       "honeywell,pmin-pascal",
> +					       &hsc->pmin);

Strange indentation.

> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"honeywell,pmin-pascal could not be read\n");
> +		ret = device_property_read_u32(dev,
> +					       "honeywell,pmax-pascal",

Strange indentation.

> +					       &hsc->pmax);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"honeywell,pmax-pascal could not be read\n");
> +	} else {
> +		/* chip should be defined in the nomenclature */
> +		for (index = 0; index < ARRAY_SIZE(hsc_range_config); index++) {
> +			if (strncmp(hsc_range_config[index].triplet,
> +					triplet,
> +					HSC_PRESSURE_TRIPLET_LEN - 1) == 0) {
> +				hsc->pmin = hsc_range_config[index].pmin;
> +				hsc->pmax = hsc_range_config[index].pmax;
> +				found = 1;
> +				break;
> +			}
> +		}
> +		if (hsc->pmin == hsc->pmax || !found)
> +			return dev_err_probe(dev, -EINVAL,
> +				"honeywell,pressure-triplet is invalid\n");
> +	}

...

> +	tmp = div_s64(((s64)(hsc->pmax - hsc->pmin)) * MICRO,
> +		      (hsc->outmax - hsc->outmin));

Too many parentheses (denominator).

...

> +#include <linux/property.h>
> +#include <linux/types.h>

Missing mutex.h (in the common header file).

...

> +	int (*recv)(struct hsc_data *data);

See about typedef above.

...

> +int hsc_common_probe(struct device *dev, void *client,
> +	    int (*recv_fct)(struct hsc_data *data), const char *name);

Ditto.

...

> +#include <linux/i2c.h>
> +#include <linux/module.h>

Missing mod_devicetable.h, errno.h (I�C driver).

...

> +#include <linux/module.h>
> +#include <linux/spi/spi.h>

Missing mod_devicetable.h (SPI driver).
See below as well.

...

> +		.tx_buf = NULL,

NULL is defined via types.h IIRC.

...

> +static struct spi_driver hsc_spi_driver = {
> +	.driver = {
> +		.name = "hsc030pa",
> +		.of_match_table = hsc_spi_match,
> +		},

Wrong indentation.

> +	.probe = hsc_spi_probe,
> +	.id_table = hsc_spi_id,
> +};

-- 
With Best Regards,
Andy Shevchenko



