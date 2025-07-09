Return-Path: <linux-iio+bounces-21472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B61CAFE331
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 10:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAB5564293
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 08:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A95327EFE9;
	Wed,  9 Jul 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODaX+gjq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8C272E63;
	Wed,  9 Jul 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051089; cv=none; b=ssmfZMKY7JAhTSPGAiuh+Uu9IfZt4xw/TqFtOP2esoBd0txO/tHyUTH8QER0PlScp3Wh1HdCVyUaPNcrcBk5GS9OcUtTTQzZ13nIzsBl9EAJRSBcKxovlC1KDZ+NLKB7DOkjta/vqDX82e6qZumwxdo8UQzuTS/cl/STyZ3j1rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051089; c=relaxed/simple;
	bh=JQTxYbGVI0kyMgtWKjaALo2ip/NPE/mLIqYCKujmZFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7OMmSOSLx8oZJCQanjXjJbI/ZaHuacIVjWtOOqgheSkyCdVYt47GlJ0HUOLsXhjuHiCgH0G272USC4MhCjYOK56Lq0ZUmM8huq/cOm0T9j8r57WqZeimcYpVyyVvPvfQ8UVWWjgDbBwOPTwxDTU1+xU7KmGyYuBAuTlXyD3F2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODaX+gjq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752051088; x=1783587088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JQTxYbGVI0kyMgtWKjaALo2ip/NPE/mLIqYCKujmZFk=;
  b=ODaX+gjq2nmiSlaDYubf75A5fiTD/otSDEJxXYLt7rUimTG51N61SN87
   +o+JhyzDvdwp/oKKLXX1xegq3+Z6Wg4CId7/k8sk+Iq1TRsnUz6/VmFVb
   YbRhf73jmh0npv9qKqe9U1tNiLacHLyz/Sk2vF/VH30+Ks9g+JmpkII2r
   zD0wN1CttAm/PtzS69Q0UFzBM+aq16Uq+KH2y51AyHXRXNST49RtkY8Md
   gy3W1c4eq6ihtCfsnKOaxNBOIadic7dpjN4R1HdCkk47bm+LTDlziMWNY
   ZcObg6PgNbRrDqU2/VUhHmygO2qIfU5/WwPw3N3WJR5fnZ9kQYCKEvvzH
   g==;
X-CSE-ConnectionGUID: Bm5BYVqVTSOSjKzvoMvmzw==
X-CSE-MsgGUID: k7zCvnS8RZSf1vVFv+GDDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54394492"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54394492"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:51:27 -0700
X-CSE-ConnectionGUID: 9WrJdixiThSvKGCMCgv5Hw==
X-CSE-MsgGUID: dbVU3s+USEGesKmij1EbLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="159758771"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:51:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZQWQ-0000000DoU0-0RFl;
	Wed, 09 Jul 2025 11:51:22 +0300
Date: Wed, 9 Jul 2025 11:51:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Julien Stephan <jstephan@baylibre.com>,
	Waqar Hameed <waqar.hameed@axis.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/12] iio: gyro: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <aG4tiRHySSsQq_KN@smile.fi.intel.com>
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
 <20250708231152.971602-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708231152.971602-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 09, 2025 at 02:11:52AM +0300, Sakari Ailus wrote:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().

...

>  	if (on)
>  		ret = pm_runtime_get_sync(dev);
> -	else {
> -		pm_runtime_mark_last_busy(dev);
> +	else
>  		ret = pm_runtime_put_autosuspend(dev);
> -	}
>  
>  	if (ret < 0) {

More potential users! So, perhaps introduce a helper and then convert
altogether to use a new

/// choose better name
static inline int pm_runtime_toggle_sync(dev, on)
{
	if (on)
		return pm_runtime_get_sync(dev);
	else // yes, I know it's redundant, just for the better view
		return pm_runtime_put_autosuspend(dev);
}

-- 
With Best Regards,
Andy Shevchenko



