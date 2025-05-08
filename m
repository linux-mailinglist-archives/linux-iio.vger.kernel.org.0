Return-Path: <linux-iio+bounces-19336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D67D6AB0309
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 20:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF769E8129
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCB12874FE;
	Thu,  8 May 2025 18:39:47 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063CB286D61;
	Thu,  8 May 2025 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729587; cv=none; b=UPEQl7bfOUv2cYUPyR/wgD1ZR0Ap3rB7BtsjX54VKweaThxfHqSlU56dFH1M3cHp8c/YnzYkpsIsTk8LaPxOg5ApE8vFQVTWKcsndTKcLoizHb/mVD+t9qaxl3Hz0AOq70rwPVsVuIU3J1VfOttCBrrihw72i1+b8GV0JFxwSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729587; c=relaxed/simple;
	bh=XijhJI+zS6x49k5yeDbJQm7J5mBLadnfpbOoE7T0cAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9rHOEsgP+yRb5wKsULjCSIp9qMPq7uRWUKQIxNNcv4p4VS0KNnGZfvaNeXgWeNk9RBycpX6GpRdmDRlaLwtREE8G8CGCATHt/JIpNwRo296/6m63/FDgsogvYh1FvtOmvBEoiDl4yV11E9Ro1ioKBibQj1jAqJJ0C+b2KdnAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: vJRmdyLwS1qP5DKFV9naaA==
X-CSE-MsgGUID: PUd5gPIuQQ2R3697Jx6qVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="58748091"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58748091"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:39:45 -0700
X-CSE-ConnectionGUID: FXSPScreQhqUZAukaZ7+HQ==
X-CSE-MsgGUID: JAmpC+y1QTqKYbV4vkHXXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167321959"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:39:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uD69i-00000004CG8-44NK;
	Thu, 08 May 2025 21:39:38 +0300
Date: Thu, 8 May 2025 21:39:38 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: adc: ad7606: add offset and phase
 calibration support
Message-ID: <aBz6am83scKywvkn@smile.fi.intel.com>
References: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
 <20250508-wip-bl-ad7606-calibration-v4-3-91a3f2837e6b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508-wip-bl-ad7606-calibration-v4-3-91a3f2837e6b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 08, 2025 at 12:06:07PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add support for offset and phase calibration, only for
> devices that support software mode, that are:
> 
> ad7606b
> ad7606c-16
> ad7606c-18

...

> +static int ad7606_get_calib_offset(struct ad7606_state *st, int ch, int *val)
> +{
> +	int ret;
> +
> +	ret = st->bops->reg_read(st, AD7606_CALIB_OFFSET(ch));
> +	if (ret < 0)
> +		return ret;

> +	*val = st->chip_info->calib_offset_avail[0] + ret *
> +		st->chip_info->calib_offset_avail[1];

You are too fast with new versions... As I pointed out, this is not a logical
split. My only concern was the column, i.e. to be as

	*val = st->chip_info->calib_offset_avail[0] +
	       ret * st->chip_info->calib_offset_avail[1];

> +	return 0;
> +}

...

> +	val -= start_val;
> +	val /= step_val;

Hmm...

To me the

	val = (val - start_val) / step_val;

looks better as it immediately gives an idea of the initial content of the val.
Ideally I would even add a new temporary variable for this, so the operand and
the assignee won't be the same variable.

> +	return st->bops->reg_write(st, AD7606_CALIB_OFFSET(ch), val);

-- 
With Best Regards,
Andy Shevchenko



