Return-Path: <linux-iio+bounces-890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1545A811487
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 15:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB2B1C20F61
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1170F2E852;
	Wed, 13 Dec 2023 14:24:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD94B9;
	Wed, 13 Dec 2023 06:24:15 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8330526"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="8330526"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 06:24:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="897344794"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="897344794"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 06:24:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rDQ9e-00000005Xtn-0GjE;
	Wed, 13 Dec 2023 16:24:06 +0200
Date: Wed, 13 Dec 2023 16:24:05 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>, Arnd Bergmann <arnd@arndb.de>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <ZXm-hf8UQ3VEyP-2@smile.fi.intel.com>
References: <20231212104451.22522-1-mitrutzceclan@gmail.com>
 <20231212104451.22522-2-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212104451.22522-2-mitrutzceclan@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 12, 2023 at 12:44:36PM +0200, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.

I do not see any major problem in the code,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

Some nit-picks below, but it's fine if it get addressed later on. Up to you
and Jonathan.

...

> +static const unsigned int ad7173_sinc5_data_rates[] = {
> +	6211000, 6211000, 6211000, 6211000, 6211000, 6211000, 5181000, 4444000,
> +	3115000, 2597000, 1007000, 503800,  381000,  200300,  100500,  59520,
> +	49680,	 20010,	  16333,   10000,   5000,    2500,    1250,
> +};
> +
> +static const unsigned int ad7175_sinc5_data_rates[] = {
> +	50000000, 41667000, 31250000, 27778000, 20833000, 17857000, 12500000,

I would add a comment with offsets, like

	... /* 0-6 */

But better to make it power of two, like each 4 on one line or 8.

> +	10000000, 5000000,  2500000,  1000000,	500000,	  397500,   200000,
> +	100000,	  59920,    49960,    20000,	16666,	  10000,    5000,
> +};

Not that I insist, just consider readability of these tables.

...

> +		if (chan->type == IIO_TEMP) {
> +			temp = ((u32)AD7173_VOLTAGE_INT_REF_uV) * MILLI;

Hmm... Is the casting mandatory here?

> +			temp /= AD7173_TEMP_SENSIIVITY_uV_per_C;
> +			*val = temp;
> +			*val2 = chan->scan_type.realbits;
> +		} else {
> +			*val = ad7173_get_ref_voltage_milli(st, ch->cfg.ref_sel);
> +			*val2 = chan->scan_type.realbits - !!(ch->cfg.bipolar);
> +		}

...

> +		if (chan->type == IIO_TEMP)
> +			*val = -874379; //-milli_kelvin_to_millicelsius(0)/scale

Hmm... Besides C99 comment format, can we actually use the mentioned API?
In such a case the comment won't be needed and the value semantics is better
to get.

> +		else
> +			*val = -BIT(chan->scan_type.realbits - 1);

...

> +static int ad7173_debug_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +				   unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	u8 reg_size;
> +
> +	if (reg == 0)

0 does not have its definition, does it?

> +		reg_size = 1;
> +	else if (reg == AD7173_REG_CRC || reg == AD7173_REG_DATA ||
> +		 reg >= AD7173_REG_OFFSET(0))
> +		reg_size = 3;
> +	else
> +		reg_size = 2;
> +
> +	if (readval)
> +		return ad_sd_read_reg(&st->sd, reg, reg_size, readval);
> +
> +	return ad_sd_write_reg(&st->sd, reg, reg_size, writeval);
> +}

...

> +	channels_st_priv_arr = devm_kcalloc(dev, num_channels,
> +					    sizeof(*channels_st_priv_arr),
> +					    GFP_KERNEL);
> +	if (!channels_st_priv_arr)
> +		return -ENOMEM;

The variable name can be made shorter and hence the above will take less LoCs.

-- 
With Best Regards,
Andy Shevchenko



