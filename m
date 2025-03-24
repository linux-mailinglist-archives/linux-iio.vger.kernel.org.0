Return-Path: <linux-iio+bounces-17236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD09CA6D82E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 11:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5760216E69E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F233325DAEF;
	Mon, 24 Mar 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axKC2kFi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500325D8E1;
	Mon, 24 Mar 2025 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742811684; cv=none; b=Oxc9XShpHkzgHxGFdFCpVx+ZxyWzuenqVGo/kiLtIOmDkhduXHj3A3ojB56sxeziAO7mCjHW3v6lIORWfxhNub7YLCMIjOSnTVqfKZP+C4vokDr1PInrRFASc5KV9fQtq/X8WUGxQPAOCzcHoJeOjmX6US3Sepw16E6diQ+lImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742811684; c=relaxed/simple;
	bh=PWcff70uYRGeT65DOi87ho91eVgfvmx3lFZ5193ituU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As/jc9p6JrTcbbRNG5nrqBZiTJnCsVvlnpCteoA3DimTeFtAqkFsbZEwfI5wZgH4x5o5toJHqJXjPyxF5NQEz+aPSlhFackzzw+0fqnZ+QpN3pbsgd8c5SH0CjGOI/XeCIU62WCRedQkeVYZBREmahpzYGlXNjE7YfgLviKISUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axKC2kFi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742811684; x=1774347684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PWcff70uYRGeT65DOi87ho91eVgfvmx3lFZ5193ituU=;
  b=axKC2kFiCVZzvwUJFbfRdYSCh8zdPLfnKzsNeN15haFh+tVlqGlx0Ic/
   CeutQN+M+x2QtzXwgoR0ov3BRTpbxX2S+MxNuXifIaGoGtdwVZKDGBA7O
   lGRLjMcupaTOVtOy2c3Jm7fHyZFhDbmDbF1U8el6ki9rAadTEmOQM8G6S
   hM3I1ZCkoZ69BAlr4Ggx2s82AerlHU86u6/ctFEndzqchH2lAKOGWgOE0
   sVqzO2ZGujeMGfEAz9aLHujWDDG4yggdW9UnwfVTuAw3oKaefNnHt8YLJ
   At0AdAf+H8vBBRGfE2zjSIp25mpFxcXbsW6+M8Du58EFuvvoayvS8RX4j
   w==;
X-CSE-ConnectionGUID: 3JTNAvFgTva7CXOTysIGrw==
X-CSE-MsgGUID: Rm5fp37aTrKkkewD1LcgvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="43895170"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="43895170"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 03:21:23 -0700
X-CSE-ConnectionGUID: XNOMQ1H/Q7GZRb74Gm5BHQ==
X-CSE-MsgGUID: jvHZhpUkTNidwGl+cyC7Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="124169532"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 03:21:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1twevi-00000005JJX-01o8;
	Mon, 24 Mar 2025 12:21:14 +0200
Date: Mon, 24 Mar 2025 12:21:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Michael Walle <michael@walle.cc>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: adc: ad7405: add ad7405 driver
Message-ID: <Z-EyGWpu_hjgEUYO@smile.fi.intel.com>
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
 <20250324090813.2775011-6-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324090813.2775011-6-pop.ioan-daniel@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 24, 2025 at 11:08:00AM +0200, Pop Ioan Daniel wrote:
> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order Σ-Δ modulator that converts an
> analog input signal into a high speed, single-bit data stream.

Datasheet: tag?

> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>

...

The list of headers is semi-random and unordered. Please, follow IWYU principle
and fix the ordering as well.

> +#include <linux/module.h>
> +#include <linux/log2.h>
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>

> +#include <linux/of.h>

No of.h in the new code, please.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/backend.h>

Move this group...

> +#include <linux/util_macros.h>
> +#include <linux/regulator/consumer.h>
> +

...somewhere here as other (recent) drivers do.

...

> +#define AD7405_DEFAULT_DEC_RATE 1024

What is the units?

...

> +const unsigned int ad7405_dec_rates[] = {
> +		4096, 2048, 1024, 512, 256, 128, 64, 32,

Too much TABbed.

> +};

...

> +struct ad7405_chip_info {
> +	const char *name;
> +	unsigned int num_channels;
> +	unsigned int max_rate;
> +	unsigned int min_rate;
> +	struct iio_chan_spec channel[3];
> +	const unsigned long *available_mask;

`pahole` has been run and this is the best choice, right?

> +};
> +
> +struct ad7405_state {

Ditto.

> +	struct iio_backend *back;
> +	struct clk *axi_clk_gen;
> +	/* lock to protect multiple accesses to the device registers */
> +	struct mutex lock;
> +	struct regmap *regmap;
> +	struct iio_info iio_info;
> +	const struct ad7405_chip_info *info;
> +	unsigned int sample_frequency_tbl[ARRAY_SIZE(ad7405_dec_rates)];
> +	unsigned int sample_frequency;
> +	unsigned int ref_frequency;
> +};

...

> +static void ad7405_fill_samp_freq_table(struct ad7405_state *st)
> +{
> +	int i;

Why signed.

> +
> +	for (i = 0; i < ARRAY_SIZE(ad7405_dec_rates); i++)
> +		st->sample_frequency_tbl[i] = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, ad7405_dec_rates[i]);

This is too long even for relaxed mode...

> +}

...

> +static int ad7405_set_sampling_rate(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    unsigned int samp_rate)
> +{
> +	struct ad7405_state *st = iio_priv(indio_dev);
> +	unsigned int dec_rate, idx;
> +	int ret;
> +
> +	dec_rate = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, samp_rate);
> +
> +	idx = find_closest_descending(dec_rate, ad7405_dec_rates,
> +				      ARRAY_SIZE(ad7405_dec_rates));
> +
> +	    dec_rate = ad7405_dec_rates[idx];

Something happened there...

> +	ret = iio_backend_set_dec_rate(st->back, dec_rate);
> +	if (ret)
> +		return ret;
> +
> +	st->sample_frequency = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, dec_rate);
> +
> +	return 0;
> +}

...

Okay, I'll stop here, this driver is not ready for upstream. Please, consult
with your colleagues and do round of internal review before sending a new
version.

-- 
With Best Regards,
Andy Shevchenko



