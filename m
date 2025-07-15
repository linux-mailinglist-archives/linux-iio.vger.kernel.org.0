Return-Path: <linux-iio+bounces-21665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA7B05509
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 10:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC65188DC8E
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08082D29C6;
	Tue, 15 Jul 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2JJ/2KP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5EC274FFB;
	Tue, 15 Jul 2025 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568522; cv=none; b=UuatEInEz+07s4zjr9UMnCZPzHC/KoJUTFgcApH25Xf3faS66Q8jiZvdmsA3auN5SH69JzE6D0qdZWnUxvG07LmREf/EpE1nPeJWTU7SrVBSdlyb6TYZbPDS2jhtLEAU9cJr74WW4TebExCSHoepTiawEpRAPGtqyZfu6mZc7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568522; c=relaxed/simple;
	bh=FC833BzUIk5qRL90xtZ2unLYkvMRE9s4KPrfvPMPxIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1E7hzwxn6cqiPxfixeZkQfS2phMfe7a/qurJxmtsjRKg27nB5jMu4YQDzCIORcXFnrpjeUfrsNdb9nAv45GuZS05t7WZt068B0y19Avcul8VjYrhp/saB0jDfGr7DAOT1YclnOL86YGV4ljPITahJp4RqhXG8yt7VoPNkU4u24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2JJ/2KP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752568521; x=1784104521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FC833BzUIk5qRL90xtZ2unLYkvMRE9s4KPrfvPMPxIw=;
  b=h2JJ/2KPMhN8Nnf9lf+9OvvGghdHNiX5NfljGHS3QTMD2JrTi/5MDeq9
   8bGZt84eVM3NPMZ8yh+gOYHl9FAIOd0GzJQJrkM0rK8L90c4iBMxHIBXD
   9jNff58/iDcMfn9eZSRv2iBkeGnKEMCJN8l8YDQnPthJR6kV+SfuLKMmo
   3kBkS1CC+IfJvUA8f3YxtKelM9pvKTv15qbik2ljU+PLyK3E5gAXFJS1N
   AlyPyTrRUW6QlUQ1bW41/O4VdhPFB/IgNMQWC1AnNWfGHm1plcRTrhlIH
   WtvJFlPFrHK9yvCAUCJ1XbyHfXj7zd/LA4sB8URao9UAvokKi92fVIHS5
   Q==;
X-CSE-ConnectionGUID: bTuLo2UkQ6KE529vRCYpsA==
X-CSE-MsgGUID: v8Yilnu+R9yOv18IQHmzJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54933042"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54933042"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:35:21 -0700
X-CSE-ConnectionGUID: Nqrc97v8QjCZGBg+WB0WUQ==
X-CSE-MsgGUID: MpPdwxiwRe+mPUoM393Y5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="161474806"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:35:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubb86-0000000FbCc-0mbc;
	Tue, 15 Jul 2025 11:35:14 +0300
Date: Tue, 15 Jul 2025 11:35:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 4/7] hwmon: iio: Refactor scale calculation into helper
Message-ID: <aHYSwVeC33qvb_-o@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-5-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715012023.2050178-5-sean.anderson@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 14, 2025 at 09:20:20PM -0400, Sean Anderson wrote:
> Add a function to determine the scale parameter, since it will soon be
> used in several places.

...

> + * Return: scale of @chan

Needs a bit of elaboration. Can it be negative? What is the unit of scale
(just plain integer multiplier)? Should it be (always) signed?

...

> +	/* mili-Watts to micro-Watts conversion */
> +	if (type == IIO_POWER)
> +		return 1000;

MICROWATT_PER_MILLIWATT ?

-- 
With Best Regards,
Andy Shevchenko



