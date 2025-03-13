Return-Path: <linux-iio+bounces-16774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E24EA5F48C
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 13:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53081697E0
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 12:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4943267728;
	Thu, 13 Mar 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgzDi35J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1321423A;
	Thu, 13 Mar 2025 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869090; cv=none; b=WXWxQiTDr0E5JZU8zF9FlYals5pmRZFj+DI0MwLnpqoUekmbX8Cl7nyGloQBozFC6dtGNid2cIgs2ZSP4WzPzFqJA9NLwEw3IdWX1BTwRKKDJtsX5MMXAijNZ5XtKDuiDLR079NRfZICpO6Wz/baF3viBkptH+bRuK3FnF33le0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869090; c=relaxed/simple;
	bh=SaIYexesddvO0UWpmRz0MzTzyVkL/mdX/8rqZt/hSb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+iVaCgqNkMABbgeCcY0KkPuHMJscZ8Kz8ofCo+wpGSXweRsEXcOKcYchNY78TMCIV+r+S5IzdiOyPq04zryFD3aLvpqZmtLtmGnd4aEwnQtTtXbU5ReluuH1hkMtmTLCbJ35JFAtxUpX+2fmeO1RN3PUBg2hTmg8Frt4rVZqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgzDi35J; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869088; x=1773405088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SaIYexesddvO0UWpmRz0MzTzyVkL/mdX/8rqZt/hSb4=;
  b=hgzDi35JTJqmywopeUpr27IGiRGw+iv7PXHfmbkxZ046+ozsxLa3p/Cq
   EA2qdB0CNqz6vjEXghAGAOXpWWWt/KxsbnZ62vlrwNZevf8EUtDyjEwA8
   Xi8EOmEzMAsC7htI+X+1FrgKNgw+WPl4E0ePSZjsfH2x4zglyPgMmnSH+
   eaaZZkPiSd6GmyJOXniR8pMhjbmceq7iOOFvBNis8LpWekPI3Qs1seoy7
   H+YbDAQ0Cg50lNavFiqUOQZNTVdD7VC5MXeL4G4dWkPooqhES31Y+MNNr
   H4AUHGfn/INIhEM4x+NKWHAnSN4Ww8bxz4j5NvIneQRtbGaUwpqP1FgTa
   w==;
X-CSE-ConnectionGUID: hcG73BDfTHy3C8i7AnXEAQ==
X-CSE-MsgGUID: JJemP9z0S9iepOLkuY1qrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="30571962"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="30571962"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:31:27 -0700
X-CSE-ConnectionGUID: jQelpd4eTZ2rpBfxbdM9hA==
X-CSE-MsgGUID: JO4NOY5VRgq94b7DdOX/ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121441131"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:31:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tshiY-00000002Aba-2whI;
	Thu, 13 Mar 2025 14:31:18 +0200
Date: Thu, 13 Mar 2025 14:31:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v7 03/10] iio: adc: add helpers for parsing ADC nodes
Message-ID: <Z9LQFqSweiV-zT3b@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <c8899e8c535a1d93cd7588b7c160eb0fae5d26d2.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8899e8c535a1d93cd7588b7c160eb0fae5d26d2.1741849323.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 09:18:18AM +0200, Matti Vaittinen wrote:
> There are ADC ICs which may have some of the AIN pins usable for other
> functions. These ICs may have some of the AIN pins wired so that they
> should not be used for ADC.
> 
> (Preferred?) way for marking pins which can be used as ADC inputs is to
> add corresponding channels@N nodes in the device tree as described in
> the ADC binding yaml.
> 
> Add couple of helper functions which can be used to retrieve the channel
> information from the device node.

...

> +int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
> +					  const struct iio_chan_spec *template,
> +					  int max_chan_id,
> +					  struct iio_chan_spec **cs)
> +{
> +	struct iio_chan_spec *chan_array, *chan;
> +	int num_chan = 0, ret;

Unneeded assignment.

> +	num_chan = iio_adc_device_num_channels(dev);
> +	if (num_chan < 1)
> +		return num_chan;

This is really interesting code. So, if the above returns negative error code,
we return it, if it returns 0, we return success (but 0 channels)?

Shouldn't we do *cs = NULL; at the case of 0 channels if it's a success?
(Under success I assume that returned values are okay to go with, and cs in
your case will be left uninitialised or contain something we don't control.

> +	chan_array = devm_kcalloc(dev, num_chan, sizeof(*chan_array),
> +				  GFP_KERNEL);
> +	if (!chan_array)
> +		return -ENOMEM;
> +
> +	chan = &chan_array[0];
> +
> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> +		u32 ch;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			return ret;

> +		if (max_chan_id != -1 && ch > max_chan_id)
> +			return -ERANGE;

Hmm... What if max_chan_id is equal to an error code?
Or in other words, why -1 is special and not all negative numbers?

Also note, you used unsigned type and compare it to int which,
in case of being negative will give promotion. The ch will not be
big enough in most cases (unless it's great than (INT_MAX + 1).

TL;DR: you have a potential integer overflow here.

> +		*chan = *template;
> +		chan->channel = ch;
> +		chan++;
> +	}
> +
> +	*cs = chan_array;
> +
> +	return num_chan;
> +}

-- 
With Best Regards,
Andy Shevchenko



