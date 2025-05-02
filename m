Return-Path: <linux-iio+bounces-18994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB2AA73FC
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE67188596C
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 13:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C7F255E30;
	Fri,  2 May 2025 13:39:27 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A31255251;
	Fri,  2 May 2025 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193167; cv=none; b=Bam3lhzHKPzn88pWemCQRl2gwmQ2MgEI4eMBESmZwTSuO4uLlry3S+yXeE3GWQBTs1xfqJzEoU2dx+3S54UTj0mOWtJhLGcFQ/2dg+qCEXPn+kmJPkKugaZ+g84zXTSoFZYb08fh01stDkO6A0Djw5HYNJD2M4JJLZnD6HdlKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193167; c=relaxed/simple;
	bh=4yziH8gPQQjHep6jRBqts+aOq1QN1siEDXOnHepEN28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC1XdAr61HbeCsdEa/2yx9dvUZYRDTud+lYiuCQjHu9LFrpB8UDxrPdyJxcT2ovGzNKLqk3TKs5ufJfuwO3398s/IHC+QR5/41kJ1xbEAJskBh5RmYKByR7AJi33fERDNRnGDVJ98yxHQ7rUFVw/fl1Dh1mgqfnzgTyiCDHMDOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 2h+AXFqpRgSgmte5Fa7qsw==
X-CSE-MsgGUID: 9v4xbTIdRMiPWD0cFvFi4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="58540234"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="58540234"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 06:39:24 -0700
X-CSE-ConnectionGUID: IIxyxQM+QOmUH/rgTMx5hQ==
X-CSE-MsgGUID: ZPGrgnO0T06p2/rhG8urrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="139782666"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 06:39:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uAqbn-00000002DDD-005d;
	Fri, 02 May 2025 16:39:19 +0300
Date: Fri, 2 May 2025 16:39:18 +0300
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
Message-ID: <aBTLBvw_88hQBbns@smile.fi.intel.com>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
 <20250502-wip-bl-ad7606-calibration-v2-3-174bd0af081b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502-wip-bl-ad7606-calibration-v2-3-174bd0af081b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 02, 2025 at 03:27:00PM +0200, Angelo Dureghello wrote:
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
> +
> +	*val = st->chip_info->calib_offset_avail[0] +
> +		ret * st->chip_info->calib_offset_avail[1];

Something wrong with the indentation.

> +	return 0;
> +}

...

> +static int ad7606_set_calib_offset(struct ad7606_state *st, int ch, int val)
> +{
> +	int start_val, step_val, stop_val;

All need to be signed?

> +	start_val = st->chip_info->calib_offset_avail[0];
> +	step_val = st->chip_info->calib_offset_avail[1];
> +	stop_val = st->chip_info->calib_offset_avail[2];
> +
> +	if (val < start_val || val > stop_val)
> +		return -EINVAL;
> +
> +	val -= start_val;
> +	val /= step_val;
> +
> +	return st->bops->reg_write(st, AD7606_CALIB_OFFSET(ch), val);
> +}

...

> +static int ad7606_set_calib_phase(struct ad7606_state *st, int ch, int val,
> +				  int val2)
> +{
> +	int wreg, start_ns, step_ns, stop_ns;

Ditto.

> +	if (val != 0)
> +		return -EINVAL;
> +
> +	start_ns = st->chip_info->calib_phase_avail[0][1];
> +	step_ns = st->chip_info->calib_phase_avail[1][1];
> +	stop_ns = st->chip_info->calib_phase_avail[2][1];
> +
> +	/*
> +	 * ad7606b: phase dielay from 0 to 318.75 μs in steps of 1.25 μs.
> +	 * ad7606c-16/18: phase delay from 0 µs to 255 µs in steps of 1 µs.
> +	 */
> +	if (val2 < start_ns || val2 > stop_ns)
> +			return -EINVAL;

Wrong indentation. Please fix in all places where it happens.

> +	wreg = val2 / step_ns;
> +
> +	return st->bops->reg_write(st, AD7606_CALIB_PHASE(ch), wreg);
> +}

-- 
With Best Regards,
Andy Shevchenko



