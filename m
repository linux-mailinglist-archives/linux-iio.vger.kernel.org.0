Return-Path: <linux-iio+bounces-21470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C726CAFE313
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 10:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201864A50FB
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E96280004;
	Wed,  9 Jul 2025 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmPBx8B7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96A272E63;
	Wed,  9 Jul 2025 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050800; cv=none; b=hEM13mqmRBiQve+aFBccZ7UUxkBfPIUePQY85x8sih5iLuJS/HCGpMNOnyIJE6PkKjQJW9H+U7Pn1N/jMeqJzaftPaId4CjiDCIMwz9b/2iz3eCn+NHGoB3NHO9uwzN+Qsv/HQ9MV3DH6OB4x9x94x+rktpp19jXhCaQuVUgyA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050800; c=relaxed/simple;
	bh=WS+qRyxh1kNap86kDD/wFR6fyhvdeuNitOmkN2MO010=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFzh7Cavs8CruvGL17ALkF6WgMvGW8qRto+kt0ggSytU9HyCb9VERnKRm+dwRKpSUY04gEnQiP2s3xhAfEznIKDwX5xETM8fYdnvxvk+R/tSHzJnbzKbLBn5kBoWgK5b88XJOHl4uSmcCOm2MShChD/DOaEdzqqu7hLjvwg4yK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmPBx8B7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752050800; x=1783586800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WS+qRyxh1kNap86kDD/wFR6fyhvdeuNitOmkN2MO010=;
  b=jmPBx8B7a+lHLOqvL3ipntwBxmhLT3N0I45DrKXZm0p2lYUlXVgqKkza
   MDtp5JOX9GSa/ClDpnxqRO9aZCabFxzEWe8hodOTlOYyV+g8oeyQwMeda
   CCzMdnYwcs9UUgl3aHM5RyrvVPYGaz0BQvkN78NZMkEdUZeRn75Kr65FN
   KlvIStp0Q+ifM+tmQtD5fNrjnptvIvn9DKEkOLYwe53jaKWVg3Nmj+uck
   HvB6z2YT3R5O+yVxJJ0rqiQT9e/SIXK3fv8dB8dauntibb1vAsUu7d0RH
   DZs0KBZ15CJONAf1hvCVzERzgJ4Zyl24CBPhdJmo3p8EfypcHVf/mJKTJ
   w==;
X-CSE-ConnectionGUID: xUIQRpPkSBeoiRM6l8w2tg==
X-CSE-MsgGUID: Y/hmbzUqSiqQmcjd/wt4BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54022534"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54022534"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:46:39 -0700
X-CSE-ConnectionGUID: Y8lLoT0AQ+iouRRWSvPTGw==
X-CSE-MsgGUID: FjKb1E+PREKHQ02KgOGBQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155354781"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:46:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZQRi-0000000DoPn-1Cxv;
	Wed, 09 Jul 2025 11:46:30 +0300
Date: Wed, 9 Jul 2025 11:46:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Julien Stephan <jstephan@baylibre.com>, Bo Liu <liubo03@inspur.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Sean Nyekjaer <sean@geanix.com>,
	Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>,
	Francisco Henriques <franciscolealhenriques@usp.br>,
	Gustavo Vaz <gustavo.vaz@usp.br>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/12] iio: accel: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <aG4sZohbXE6kmq2G@smile.fi.intel.com>
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
 <20250708231151.971256-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708231151.971256-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 09, 2025 at 02:11:51AM +0300, Sakari Ailus wrote:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().

...

> -	if (on) {
> +	if (on)
>  		ret = pm_runtime_resume_and_get(dev);
> -	} else {
> -		pm_runtime_mark_last_busy(dev);
> +	else
>  		ret = pm_runtime_put_autosuspend(dev);
> -	}

The following blank line can be removed as it's done in the other file.

...

Side note: Looking at this, perhaps we can also have a helper to toggle state?

...

>  	if (on)
>  		ret = pm_runtime_resume_and_get(&data->client->dev);
> -	else {
> -		pm_runtime_mark_last_busy(&data->client->dev);
> +	else
>  		ret = pm_runtime_put_autosuspend(&data->client->dev);
> -	}

So, already two users of the potential new helper :-)

...

> -	if (on) {
> +	if (on)
>  		ret = pm_runtime_resume_and_get(&client->dev);
> -	} else {
> -		pm_runtime_mark_last_busy(&client->dev);
> +	else
>  		ret = pm_runtime_put_autosuspend(&client->dev);
> -	}
>  

No blank line?

Three!

>  	if (ret < 0) {

...

>  	if (on)
>  		ret = pm_runtime_resume_and_get(&client->dev);
> -	else {
> -		pm_runtime_mark_last_busy(&client->dev);
> +	else
>  		ret = pm_runtime_put_autosuspend(&client->dev);
> -	}
>  
>  	if (ret < 0) {

As per above and counting...

-- 
With Best Regards,
Andy Shevchenko



