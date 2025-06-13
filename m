Return-Path: <linux-iio+bounces-20582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AC6AD85AC
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 10:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E7516A37B
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224762727E2;
	Fri, 13 Jun 2025 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWfrl/oR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E51FBEB6;
	Fri, 13 Jun 2025 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803487; cv=none; b=o/eIK4r8Iw7Hf2udvSClhZYzwcTbPhJvW2VQqGUn+dD2hwRwK0T8OcmRvQqa6ZDVYviGJD5pMC4fnrWiRb6bD3KR75WP/qHAexfcLB5ZdndqlESqnFeWobAO/9X4BolgGnXAvs80VuUCaBKqBKW+yn/h24BDx/ej55vKZCcTAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803487; c=relaxed/simple;
	bh=Rbr/uIjKmKxHPF1slzCRVnx/DBinaNLmmxueq70Wyp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhhIgUwJChOqhG+qglYiB7oksMLLeYnONvPHk2Qg/ynGbD3RsMfMfUrhZciHoYHal0GRPs77EuY78I9Vfe6fNjEVCRAoBhXk5kfw5UMED0rY0Z2moPCEvl98BkdrUaDHhMy+XRbh3TUqXObYzZAOyuqohEWlmFvGAlo5mQ8r3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWfrl/oR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749803487; x=1781339487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rbr/uIjKmKxHPF1slzCRVnx/DBinaNLmmxueq70Wyp4=;
  b=XWfrl/oRB5lUzSsxDk2wnyhe5cCrdFX33xP21FrrqivdgdR2zZWsKNWB
   IZp34X4Eltw3xR0AfsF3GxODl4+4F7flcHB4kZgpujR3iLcelZJ0Qm8T9
   TFiJN7ueME6SEION7MaqpeFnzxtGn+EgL7pIGPxz+r5E2e5Y11Sy32Q0w
   mNq10XhwFMTqGtm6LaqRWRTNFP2IqQXjAJ4H6j5m49o9Adjn9FFNKzqCN
   Nr0S86lDvkHS6zW41EjIznWknaEjOQ77srlE9rAJ9S75PpVmd590WR49f
   gbuJlroq1qMAS+XCn+GMDIszTuyq1BwQMhvbUqDWHvV/fW5BDJearV2CZ
   A==;
X-CSE-ConnectionGUID: PAIZjVz9Q7yuRSCYIMOvSg==
X-CSE-MsgGUID: C5/xsoHTQ6WjhmWHaAjCBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="63048837"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="63048837"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 01:31:26 -0700
X-CSE-ConnectionGUID: yB47difmSwC//XrYW1M1ww==
X-CSE-MsgGUID: 6n0HPOVwQTmjGKTHEMqU2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="185014561"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 01:31:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPzom-00000006Bgv-3CHX;
	Fri, 13 Jun 2025 11:31:20 +0300
Date: Fri, 13 Jun 2025 11:31:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: imu: inv_icm42600: add wakeup functionality
 for Wake-on-Motion
Message-ID: <aEvh2My32K9us0Tc@smile.fi.intel.com>
References: <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-2-7e5f554201bf@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613-losd-3-inv-icm42600-add-wom-support-v4-2-7e5f554201bf@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 13, 2025 at 09:34:27AM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> When Wake-on-Motion is on, enable system wakeup and keep the chip on
> for waking up the system with an interrupt.

...

> +	/* accel events are wakeup capable */
> +	devm_device_init_wakeup(&indio_dev->dev);

No checking for return code? Why is it okay? This needs a really good comment,
and even better a (info / debug) message when it fails if it's not a fatal
error.

-- 
With Best Regards,
Andy Shevchenko



