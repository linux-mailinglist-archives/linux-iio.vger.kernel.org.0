Return-Path: <linux-iio+bounces-10389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE3399882A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 15:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27AA1F24719
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 13:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404651CBEB1;
	Thu, 10 Oct 2024 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ewn3faXq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59D1CB304;
	Thu, 10 Oct 2024 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567990; cv=none; b=V4X6IN7NMNxeVm9WH28wjcWIUM/I/H3gA0YK7yc2oSiXxk/+gMhqEPPtFYQLqPhK98ehrEhfsf9a3/Z5qKLbvil2sXmjnHUjWjkWgNeWvb5M92PxEtjzJ1Yz14RQWxPnE65lzGmwSokPRxLGEFX24vy5D5L9MLgY3wMF/2/C6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567990; c=relaxed/simple;
	bh=Zv36Sz4kmZesLSQInOSEBvZIeQ+0R6ln789nlNcRn1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBJittKdYCv+dZanApzLgnJo7HGTAKesb6SbzH/gC8ufvTD0GCxqo62xa+QBvEiil66Q0MK/pfmkCefwqyCNX1x7ngGD6eDgjzrPHD3QtPNbM9AVAYbZOylDlk19LCvsLAhhfWc4byU7T19oUkuEY3+dGKZd92mdG4v4ZOXbRH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ewn3faXq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728567989; x=1760103989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zv36Sz4kmZesLSQInOSEBvZIeQ+0R6ln789nlNcRn1w=;
  b=Ewn3faXq+s/Vo+fLSIL1zlhOZ60WEVCICyQcvIqbFdAaJQRZ/c4TiVcy
   b2MNfEp2KMzXztvAXovwZFXsRWlKEe2nlEfsglpr2J+D8nfKdpWKjN7MQ
   SrbAwfyy1kDBaWNzhzHecOfAGAtj9+1Nt6VNlJCHdsn1UNnHtkbqA1M1a
   zMAhZC01Kufo+DjuCqtCTY6/48F3/9RaNZbGkPYf6qQ1kW7SNVVJixqV6
   WDLtUq/JJ5YAka7AsqskoS2rTKLAMZWyWaXAx3Q9fFNipe3KqFa1mjWvx
   nrYKYW6LXzggrJhwl+zisobrmia+BaR0EfoQXeMAiJF0UGEMe6bmerJYF
   g==;
X-CSE-ConnectionGUID: NbZRYQfyTBi31PBKmaAuYQ==
X-CSE-MsgGUID: jNc43U0RQFuAJH0/qT8Jhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28039270"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28039270"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:46:28 -0700
X-CSE-ConnectionGUID: 43kSRddNQ1mwdZClHH19OQ==
X-CSE-MsgGUID: B1Nue7CTTCyNbpnF5WxeOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76253153"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:46:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sytUh-00000001YBT-2LVL;
	Thu, 10 Oct 2024 16:46:19 +0300
Date: Thu, 10 Oct 2024 16:46:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Alexandru Ardelean <ardeleanalex@gmail.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Shoji Keita <awaittrot@shjk.jp>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH 12/13] iio: pressure: bu1390: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <Zwfaq4GlYtQV3TTs@smile.fi.intel.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
 <20241003-iio-select-v1-12-67c0385197cd@gmail.com>
 <20241005190147.084dd468@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005190147.084dd468@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Oct 05, 2024 at 07:01:47PM +0100, Jonathan Cameron wrote:
> On Thu, 03 Oct 2024 23:04:58 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

...

> > Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
> Seems unlikely in the bm1390 driver. Huh. It is accurate, but I'll fix the
> patch description to refer to the bm1390 which seems to be the right
> name and add a note on this as it looks suspect otherwise.

Fixes tag shouldn't be mangled, even if it has a typo.

-- 
With Best Regards,
Andy Shevchenko



