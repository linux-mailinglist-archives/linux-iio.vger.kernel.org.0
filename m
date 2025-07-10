Return-Path: <linux-iio+bounces-21545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA96B00BDD
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 21:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B76E5C3CD5
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F21E2FD586;
	Thu, 10 Jul 2025 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IiGtVdm/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EE2FCFFA
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174598; cv=none; b=GWAijaVALPbCNuicKkFn8K2zCbL6QdoJAc5j5/xUQ8WokzoyaRUXvZDY83iT+D6BCkId5lh5Nnjfs/UQYBUf1K1zxqhBCsn91zwtRB0+1SCh1J4UpCVEicX6R7qfAfrFBvCKnA6VZXWQ70pxKuCa9F/QF4ZnBnuhcSLd5TPMRTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174598; c=relaxed/simple;
	bh=vuxID88Mm6AqLti+nkltCmHl3PcHZ54KBHBfX3cMjho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEnv3V/YGyIHQ5whJcYHIrGSo/gmkeQE204bN98HYm7PZ6w3Iz67EYEDjpt3M04y0A7D5u2k4YKFuEV0BCzExVl/R2gPGN2AGC7mc+YJ2jAhp9tdCtxluV35qNt72Al4yCge1l71LvaGQGEjDQpGtqwAaKQXgLibuWtx8metrgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IiGtVdm/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752174596; x=1783710596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vuxID88Mm6AqLti+nkltCmHl3PcHZ54KBHBfX3cMjho=;
  b=IiGtVdm/Ho9rCVE2u0AYElXw4T2GplAyxd6Itqr+VKutYN8jHGJs3IwS
   5FlxztsojrNtZwKH24kPszldKUXQJGtFofp6y7UcIjYKjqnRIP11zH+oj
   Rhx0baXiELrG/yWxmS7YMMKs6LCPubGT7PUtjdsT3K5uIhA/tp1/PMr8k
   U8SF+64t8HyB0MLzBg8dIog5RGEMCTPiWTYiov3pstgSzoEGCWYuwpK2J
   hIzY7+JmqCXjZDwFgIMFnDKrMo+jQOpksdUasoZStbo6OAypKtsml5h3P
   2+CZwOytYh4niO0f7yE3TzXAFqBW93oOnlbZTZHE0IRVSQ3vDk6LXB1Pc
   g==;
X-CSE-ConnectionGUID: 7C75KEtvRe+iRmkjGu0XWw==
X-CSE-MsgGUID: amOZY5FZTay+lA3CGDUT8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65048569"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="65048569"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 12:09:56 -0700
X-CSE-ConnectionGUID: ESZpsnasS42W6ywOBwJ/vA==
X-CSE-MsgGUID: OKaEq2mjQ9iYmntx7UUI1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="155592109"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 12:09:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZweU-0000000EJ7F-0nN3;
	Thu, 10 Jul 2025 22:09:50 +0300
Date: Thu, 10 Jul 2025 22:09:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/7] iio: pressure: bmp280: Apply iwyu principles to
 includes.
Message-ID: <aHAP_c_7huR3igPC@smile.fi.intel.com>
References: <20250710171107.443790-1-jic23@kernel.org>
 <20250710171107.443790-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710171107.443790-2-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 10, 2025 at 06:11:01PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The recent introduction of a warning on missing include of
> linux/export.h when W=1 motivated revisiting the includes in affected
> drivers.  In general IWYU principles avoid complex include paths that
> make it hard to refactor headers.
> 
> - Move linux/unaligned.h entry to appropriate place.
> - Drop comment on linux/irq.h as we don't generally keep a record
>   in code of why includes are there.
> 
> Remove
> - linux/device.h from bmp280-regmap.c as struct device forwards definition
>   is enough.
> - linux/module.h from bmp280-regmap.c as the module stuff is all in the
>   other files.
> Add all of:
> - linux/array_size.h for ARRAY_SIZE()
> - linux/device.h in the i2c and spi drivers
> - linux/err.h for PTR_ERR() etc and also assume includes errno.h
> - linux/export.h for EXPORT_SYMBOL*()
> - linux/jiffies.h for msecs_to_jiffies
> - linux/log2.h for ilog2()
> - linux/math64.h for div64_s64
> - linux/minmax.h for clamp_val()
> - linux/mod_devicetable.h for spi_device_id etc
> - linux/mutex.h for various mutex calls
> - linux/pm.h for pm_ptr()
> - linux/stddef.h for false / true
> - linux/string.h for memcpy
> - linux/string_choices.h for str_enable_disable
> - linux/time.h for USEC_PER_MSEC
> - linux/types.h for local bool definition.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> I'm not sure on whether we should bother with stddef.h or types.h
> Looking for feedback on any others.

types.h is superior.

-- 
With Best Regards,
Andy Shevchenko



