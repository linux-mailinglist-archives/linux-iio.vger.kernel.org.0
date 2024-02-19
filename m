Return-Path: <linux-iio+bounces-2763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9882285A269
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 12:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB27D1C21E76
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 11:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A233F2E3F3;
	Mon, 19 Feb 2024 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8/s33Q9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934D2D05B;
	Mon, 19 Feb 2024 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343319; cv=none; b=oQQL8sVpcdJcaW5VLpMtFXSpYapQrRBJaFwuFGUhLzBpru0eUO5vVUCjf1dBrvmB/kqhfuFIGWavgsZOecwVZ4dEOZ8c3SpzKR5lkqDYxQfmwLJ9Oj64o/BT4ppr2hR+TFdEp8SkPyCAknTZjRpU0O6HPm7czyDcN4vAi/6KlXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343319; c=relaxed/simple;
	bh=wJCEPtWGbeCztYBK1IUKMqu+7BjVXhNtG27wTmOSQ0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQn9T72fGBzWDqEpsVJDa5NMTx80IC3xG+HfEbAN8hO+rd8vdHJ7Wr+wyfN7X8hcigfGxuEigUx7+0TN8BzqVzd/myckYw7qQow+lNQHJUhOHta1mBqx5EDQQzfw5vU/7+OKWYgVyEA9vu/l8f8ZnIfw7Oo7F5nUJeCdZL2+NlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8/s33Q9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708343318; x=1739879318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wJCEPtWGbeCztYBK1IUKMqu+7BjVXhNtG27wTmOSQ0M=;
  b=g8/s33Q9Vm2D24FdPNDrwiPtO5oaE8SofrAgT3Vz/6u/UcufrJwf8EfR
   DGlL6qE3ye/mSPjQZj9nO/XSFU7URIg1uCLyjEUyNdeFBlWi/E4rr8SOP
   ZiHP7cnNqGfjDYsVDy9mOm0Yj9VpzIr5hqRKWuZjQn+UysnipPxHXEISy
   Ig2UdaYqhOxMZM8wA+aFz7qLrInZ1AFOuJZRw6VXdTThWUCXq+UF8DgSw
   TTJQCZJw0PCGbH2mEo7nKPJcHNvqfLIDKCNaLI6/DLFU0WX4gdOwIvdLN
   SiHw8Ki3wT6c7ZsAKwnwMOhyU3fDpSpZ07bPhinEXmRHIwkmulL49x4m2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="19949893"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19949893"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:48:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912861827"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912861827"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:48:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc28J-00000005oKW-2pGb;
	Mon, 19 Feb 2024 13:48:27 +0200
Date: Mon, 19 Feb 2024 13:48:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 15/15] iio: dac: ltc2688: Use
 device_for_each_child_node_scoped()
Message-ID: <ZdNACyMUH6Lk749H@smile.fi.intel.com>
References: <20240217164249.921878-1-jic23@kernel.org>
 <20240217164249.921878-16-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217164249.921878-16-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Feb 17, 2024 at 04:42:49PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Switching to the _scoped() version removes the need for manual
> calling of fwnode_handle_put() in the paths where the code
> exits the loop early. In this case that's all in error paths.

...

>  			span = ltc2688_span_lookup(st, (int)tmp[0] / 1000,
>  						   tmp[1] / 1000);
> -			if (span < 0) {
> -				fwnode_handle_put(child);
> +			if (span < 0)
>  				return dev_err_probe(dev, -EINVAL,
>  						     "output range not valid:[%d %d]\n",
>  						     tmp[0], tmp[1]);

Last minute observation, should not we return span instead of -EINVAL?
(Haven't checked the semantics of the former though.)

...

> +		if (ret)
>  			return dev_err_probe(dev, -EINVAL,
>  					     "failed to set chan settings\n");

Ditto.


-- 
With Best Regards,
Andy Shevchenko



