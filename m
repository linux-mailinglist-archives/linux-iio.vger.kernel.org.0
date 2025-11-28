Return-Path: <linux-iio+bounces-26537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1191FC91995
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 11:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98032342A09
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6854F3054E6;
	Fri, 28 Nov 2025 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifBPtRcG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E9259CB9;
	Fri, 28 Nov 2025 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325293; cv=none; b=dtGaoPwRWHh66J9WQuh/FQCvR2YFaz8sB7paDtnJVR7qe3zrBBGrU7Wo3ptQnp4N+uF5InpDeqnXpvsbliMvU5ug7zVhp4R7d0yd4PBd8vFbXKhLUngXQ90Ok11a/XDdvrtHUdmH1b0GtnL8+FBb/vXixHjZA8mSjL8DUWO3/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325293; c=relaxed/simple;
	bh=kOe/1s0hdqDaNBZy/4f78rRvvI/lnNRtWB6p3AH2mIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqDrxEWilkrL+rxYTul46CTeYlo0wafH/+t4PxbqTyBoZa7U5jPArcoMNFPJ2MKozj2b2S6NPB+ul+SZPi/HyVkIH0khmgc/3wOWDzEiQAZjzbgqGsaX9B5BwyNmeGaub4FSrg3WWM9JuLMXT1XmUgTkmbSjwwXlWpq8LAkHoSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifBPtRcG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764325292; x=1795861292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kOe/1s0hdqDaNBZy/4f78rRvvI/lnNRtWB6p3AH2mIs=;
  b=ifBPtRcG5RMfQpBDncwy6QM1k2yGDr5c151wIGm35RzznxB9A5XzYEtq
   4pLSyh9OiiTwWzdBQkj44s1MgnSi4s7caJzbFu1gDYJv93nRhI1chREZv
   9DkZ44PW1Z+90QiE173jdUJaVKM6SCyl4auAuJa+VnuIRBUhEBzlPwoMd
   1/ArmaCrX0DDsd5SUxgsaU6LXhhQcj5L/UL2GJR6F3C/McRHe2kf74Ki+
   R7FtaOTxfphm95oZKIMlZK+N8Q1Z6Rh5hnDoj0BWVlUbFBnftquIC+jB1
   bkginrNyaIp2g5If/vne38tg5vyBme/DPbcsLftElInqlkW/y8iZF92xm
   Q==;
X-CSE-ConnectionGUID: QJh7IYN7Qu6Q0nNSfgIxsQ==
X-CSE-MsgGUID: 3pMB98jEQNy/iKZhj6IpxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="69977430"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="69977430"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 02:21:30 -0800
X-CSE-ConnectionGUID: pjgAiMPvTMecGsGo0QMyzA==
X-CSE-MsgGUID: MqUaZIdHRpij0Z2jje0lHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="216779731"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.154])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 02:21:26 -0800
Date: Fri, 28 Nov 2025 12:21:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <aSl3pFfXhNVFbjxX@smile.fi.intel.com>
References: <20251127-ads1x18-v2-0-2ebfd780b633@gmail.com>
 <20251127-ads1x18-v2-2-2ebfd780b633@gmail.com>
 <aSlxSj7XEq7PUxsk@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSlxSj7XEq7PUxsk@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 28, 2025 at 11:54:18AM +0200, Andy Shevchenko wrote:
> On Thu, Nov 27, 2025 at 10:37:11PM -0500, Kurt Borja wrote:

...

> 		for (unsigned int i = 0; i < info->num_pga_mode_to_gain; i++) {
> 			if (val == info->pga_mode_to_gain[i][0] ||
> 			    val2 == info->pga_mode_to_gain[i][1])
> 				break;
> 		}
> 		if (i == info->num_pga_mode_to_gain)
> 			return -EINVAL;
> 
> 		ads1018_set_pga_mode(ads1018, chan->scan_index, i);
> 		return 0;
> 
> This also will follow the traditional pattern: Check for the error cases first.

Just noticed that in this case the scope of iterator should be out of the loop.
Since you have it used more than once, move it to the top of the function.

> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		for (int i = 0; i < info->num_data_rate_mode_to_hz; i++) {
> 
> Ditto, same comments as per previous loop.
> 
> > +			if (val != info->data_rate_mode_to_hz[i])
> > +				continue;
> > +
> > +			ads1018_set_data_rate_mode(ads1018, chan->scan_index, i);
> > +			return 0;
> > +		}
> > +
> > +		return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko



