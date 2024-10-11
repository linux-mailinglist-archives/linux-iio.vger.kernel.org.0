Return-Path: <linux-iio+bounces-10448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D3099A19B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 12:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B10F2860B9
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0CE1E379F;
	Fri, 11 Oct 2024 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R1W8q/2B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4320FA83;
	Fri, 11 Oct 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643176; cv=none; b=iYOhoo6lKpc+uA2YohcD3CSQZk1hjFHXoOt9mBNFkXPX9Sf0Dsoh13hwJCwSDdcBrYmDJgkSX4eXNLZVdnSjAqwu8XHZ6r/KDMnCXO/QCbKWuvw8rOO/bJGPs38RtqikbN29JGaFYnq1CSYEuaG/F7T0wHPANRckIANTFjxKnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643176; c=relaxed/simple;
	bh=QNV6+hfo8+uIipAV1Xpk/BTtDZyc+iyhhES32I67r64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyWEMpAn99d1XvV3Ks6twouIL9Mdasv4An1sYYwljQsmH60OtnWK8OIOlgbTZXU54tuH9B87/VDUANqslntbz5vYHA7JvUVuHurHPeJPif1sMpWbnnXyNdrEYHSNLjzSLhqQ59VfL8o6oXnx+vLv1ijY/s6VOfvNTgeLtpY8z1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R1W8q/2B; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728643175; x=1760179175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QNV6+hfo8+uIipAV1Xpk/BTtDZyc+iyhhES32I67r64=;
  b=R1W8q/2BIogQ5qOfdex7WGJpKvLkn5WXwnameTD8fAyJq39YBiiquXpc
   xpqFqtqHiMsd/Of3dvWBUpjADI9KZQbHKQv+Ot+VdkVFMrvWWSXvqz5bS
   FogwbHVO7Tc69OfvZEWCeZiKVZXiCDtTtHd69unUL9Q6dxiRP5QgKfddU
   LzLSkpo6rKSO/YDi7zleQ6Aal/zlk5yWzyxX09eybOa0LlW5atfOu5YvO
   krUMhVIorGs1dXibRwl2sbxEKbqAImU4GPNd/UY+2Cyes42XB4K2a83/6
   xkju6fTnmk5bN3nK3yoJfetqdvRbDpqecRO8Z59PWq70k5v9Lphrk010s
   w==;
X-CSE-ConnectionGUID: AAb1g4quQLC9yKhYQhQ76g==
X-CSE-MsgGUID: iXEX02sfSb+CQeA0i9mk1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27909114"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="27909114"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:39:34 -0700
X-CSE-ConnectionGUID: OZPGtiSzRw+cIRxNOYW7Zg==
X-CSE-MsgGUID: yAaSVd2iT0eQApQQShi01A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="80885286"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:39:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szD3R-00000001rTw-1LAS;
	Fri, 11 Oct 2024 13:39:29 +0300
Date: Fri, 11 Oct 2024 13:39:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: vamoirid <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/13] iio: chemical: bme680: Add support for preheat
 current
Message-ID: <ZwkAYSvmYyu1F5dU@smile.fi.intel.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-14-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010210030.33309-14-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 11:00:30PM +0200, vamoirid wrote:
> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Add functionality to inject a specified amount of current to the heating
> plate before the start of the gas measurement to allow the sensor to reach
> faster to the requested temperature.

...

> +	data->preheat_curr = 0; /* milliamps */

Instead of the comment, make it better to any appearance of the variable in the
code by adding unit suffix.

	data->preheat_curr_mA = 0;

(yes, capital 'A').

-- 
With Best Regards,
Andy Shevchenko



