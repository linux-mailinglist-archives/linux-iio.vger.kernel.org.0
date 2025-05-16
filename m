Return-Path: <linux-iio+bounces-19588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A392AB9909
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 11:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E717F7A3446
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C07B230BEE;
	Fri, 16 May 2025 09:38:38 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B11922FA;
	Fri, 16 May 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388318; cv=none; b=cINEnA/5T5yEmkCptiBGWI7VtSgf8P5MPvxCM2H4PRxSf92AMzvSadKgYrlXDg8dcu+2fMRddPMMJYBn0ku/WHa73vJrdV+orz5xyYFmxS92njW+ayJ3dEaFVlckjgrwY+lfwpd3QtIvlssY4yQIKx+iGFu3Cxje9k4YztSAnbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388318; c=relaxed/simple;
	bh=59zsdEdxzDy5BJsnQBMJMTL7R201gGm0SirPB3vYRN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE+cc84TALqYbcx3hj26FilxP1bHcG/tLcMTwS76t+bdeSsk0To5nIVsHXl1E2/vrkuVprEgAOaaAgHHdccMboUTgyUmsLzGOAQrDF1vtlu7BJhil13dYIdH0kk4sgdskFgH0MnmIygQqUv+VLUv/bTqArEwNwaXSAswZ8+uD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: tDLSnDDwQ4+OqZHOx26gug==
X-CSE-MsgGUID: jVNW1K6pQSeaFk/7c1Qm8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="71860039"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="71860039"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:38:36 -0700
X-CSE-ConnectionGUID: NBuM9J3uT5C+jmHiOau6Gw==
X-CSE-MsgGUID: A80O8IrXTmWSyJF9zXKB8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143527551"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:38:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uFrWO-000000026GK-188w;
	Fri, 16 May 2025 12:38:28 +0300
Date: Fri, 16 May 2025 12:38:28 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v8 11/11] iio: adc: ad7768-1: add low pass -3dB cutoff
 attribute
Message-ID: <aCcHlAE8LvO_fLxQ@smile.fi.intel.com>
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
 <42dc4d7722996a8d64a1bbafd8848609c9e435d8.1747175187.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42dc4d7722996a8d64a1bbafd8848609c9e435d8.1747175187.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 15, 2025 at 06:14:33PM -0300, Jonathan Santos wrote:
> Ad7768-1 has a different -3db frequency multiplier depending on
> the filter type configured. The cutoff frequency also varies according
> to the current ODR.
> 
> Add a readonly low pass -3dB frequency cutoff attribute to clarify to
> the user which bandwidth is being allowed depending on the filter
> configurations.

...

>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> -					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> +					    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),

You can make the diff looking better and easier to review if squeeze the new
bit in between of the existing one, this will remove +- LoC here.

-- 
With Best Regards,
Andy Shevchenko



