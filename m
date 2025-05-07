Return-Path: <linux-iio+bounces-19245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F85AAE375
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 16:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BAE3AAE42
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0989289811;
	Wed,  7 May 2025 14:45:12 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2231328031D;
	Wed,  7 May 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629112; cv=none; b=uKOAfKV0aDB63v6dVI7KCra2QZhdUdzvKKOhsN5vLbx5ovN7GmbwwH/rzrHvLZoILOIrC797XQisEVWFXJapMT3FaIj2+0RCRUN71piY/oVcu19npAGxiWZrEHMXBJy9u6q04Y9GeNOcZsHu8mGiDfpMPLk6AaNE4A4e7xc22Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629112; c=relaxed/simple;
	bh=Zpmdie7FozxakGeKgHKI8fEBnBpA41Ht5ZOwoa/WN4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWc5D77cXaSzdieYu3KvIcdW4K6Dq4b2uub//fh6v1oo5CNTKInPhBXGx1uaDyk827ZhFAYsH6RMcghyo0XaI8KgFv1jgq6aIKbkTvJ98jX3ve2kkCUvoMxN90L5i2AdNUXi/ThsP1i2BQycpzDZKISRUe9Tm3uQX48J1ybJX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: OzNrNAnkSnSkOp4Drjj/vA==
X-CSE-MsgGUID: /LWSEVMbRNGgnJ/3rKczhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48072387"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="48072387"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 07:45:11 -0700
X-CSE-ConnectionGUID: zjSFZbuyTfWgfvpJzhyVNQ==
X-CSE-MsgGUID: WTBPqSc1RyOyINhhQpPy3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="136989800"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 07:45:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uCg1A-00000003l8n-3Cbw;
	Wed, 07 May 2025 17:45:04 +0300
Date: Wed, 7 May 2025 17:45:04 +0300
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
Subject: Re: [PATCH v2 3/5] iio: adc: ad7606: add offset and phase
 calibration support
Message-ID: <aBtx8OwUXnx4d90M@smile.fi.intel.com>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
 <20250502-wip-bl-ad7606-calibration-v2-3-174bd0af081b@baylibre.com>
 <aBTLBvw_88hQBbns@smile.fi.intel.com>
 <k235e2mj4od3cll5wstpl4oethlkd6d6xytow4d4wzfcsxkx7y@wj7dh3zhn2sh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <k235e2mj4od3cll5wstpl4oethlkd6d6xytow4d4wzfcsxkx7y@wj7dh3zhn2sh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 06, 2025 at 02:59:50PM +0200, Angelo Dureghello wrote:
> On 02.05.2025 16:39, Andy Shevchenko wrote:
> > On Fri, May 02, 2025 at 03:27:00PM +0200, Angelo Dureghello wrote:

...

> > > +static int ad7606_get_calib_offset(struct ad7606_state *st, int ch, int *val)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = st->bops->reg_read(st, AD7606_CALIB_OFFSET(ch));
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	*val = st->chip_info->calib_offset_avail[0] +
> > > +		ret * st->chip_info->calib_offset_avail[1];
> > 
> > Something wrong with the indentation.
> > 
> > > +	return 0;
> > > +}

...

> > > +static int ad7606_set_calib_phase(struct ad7606_state *st, int ch, int val,
> > > +				  int val2)
> > > +{
> > > +	int wreg, start_ns, step_ns, stop_ns;
> > 
> > > +	if (val != 0)
> > > +		return -EINVAL;
> > > +
> > > +	start_ns = st->chip_info->calib_phase_avail[0][1];
> > > +	step_ns = st->chip_info->calib_phase_avail[1][1];
> > > +	stop_ns = st->chip_info->calib_phase_avail[2][1];
> > > +
> > > +	/*
> > > +	 * ad7606b: phase dielay from 0 to 318.75 μs in steps of 1.25 μs.
> > > +	 * ad7606c-16/18: phase delay from 0 µs to 255 µs in steps of 1 µs.
> > > +	 */
> > > +	if (val2 < start_ns || val2 > stop_ns)
> > > +			return -EINVAL;
> > 
> > Wrong indentation. Please fix in all places where it happens.
> 
> as already said, my code is correct,

Evidently no.

> 1 tab after the if, anywone knows why git formats the patch this way ?  

It's you, who should answer this and fix it.

> > > +	wreg = val2 / step_ns;
> > > +
> > > +	return st->bops->reg_write(st, AD7606_CALIB_PHASE(ch), wreg);
> > > +}

-- 
With Best Regards,
Andy Shevchenko



