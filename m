Return-Path: <linux-iio+bounces-14908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F45A25806
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 12:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B611883DD4
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D160202F67;
	Mon,  3 Feb 2025 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xenh+X6A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AF8202C48;
	Mon,  3 Feb 2025 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738581801; cv=none; b=awZhVLJikv4HjAegvBGtglkFoz32qc9LGEAhitPEIbVrAM+ZmoQChcnCbshEQ0YAKljxANrl7FKcMZq93RZ4vj83HGR/0VYqSeu8ws9ogwRh7DNQm/YnizudTiISmpHcWdtHY3MYp5bOC3s0jn7Aps3K/bCuqrV6QSmp2rX/omo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738581801; c=relaxed/simple;
	bh=dak8ipRwbVtzkMauOnkZ93orNltxQIIyMt8SKoEo6bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqEMlWfqKFHCKUm5GSY/JM+xm9HJKQVsWZ2rv/BgiBIzdX1s/rTmQ6rHVhkf2FYxNTunGFWd1JFQiNGb6mbPFZUkhrFwajK1XgVxUL95Hlna+lxe69HAg5FQeiZEu6lmYGeWMs5T2lWCn2skpzIozKD+NcxlgV8Akf2WFZVnuec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xenh+X6A; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738581800; x=1770117800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dak8ipRwbVtzkMauOnkZ93orNltxQIIyMt8SKoEo6bQ=;
  b=Xenh+X6ATgeb/mmwSCN1ZtJ2tc9jGzdQd81zTRX+/TpB2/FmfYUj2o7O
   C+tNl9IUaXNRj0YykMElr0KczCPwN+PAZzvi42GInJ/UVG3PknVWMe7U9
   aN7YST+6uPfotdPZ5uaPGkqzmxaJz0wfu2VIJEacDV4vnhwt8zRBZzsEZ
   Xyyu9jGzeXnG8OSdcVdj4FG0VInKz5QuQuuvBXMw4u9sbvaA3ERl3MAYG
   fxsbztJr9oWKMtEhcJEmKbcOLBVf0hz8CxlN1d3GJbFesKjcG/ddoMI2R
   fwr+Rtpc/mSQQYobhyCPkHpai9tVjYbtvHy5evEgaSVFnAnZjeKWIT3vt
   w==;
X-CSE-ConnectionGUID: nyw0FZrHTpyi59VDmaCNcw==
X-CSE-MsgGUID: +OT7AEp7Q4edCg4ldK1ZOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="38975341"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="38975341"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 03:23:19 -0800
X-CSE-ConnectionGUID: 6aQhP+P2R3q8WQxoKZKZkg==
X-CSE-MsgGUID: NFZKZdwvSLy6JV3v2RFqPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110085550"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 03:23:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1teuXn-00000007oOb-2YSh;
	Mon, 03 Feb 2025 13:23:11 +0200
Date: Mon, 3 Feb 2025 13:23:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 12/20] regulator: cros-ec: use devm_kmemdup_array()
Message-ID: <Z6CnH8nDLPlgAlmW@smile.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
 <20250203080902.1864382-13-raag.jadav@intel.com>
 <Z6CRjgG7y7YOiGpV@smile.fi.intel.com>
 <Z6CdF2OQQcP76_bi@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6CdF2OQQcP76_bi@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 12:40:23PM +0200, Raag Jadav wrote:
> On Mon, Feb 03, 2025 at 11:51:10AM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 03, 2025 at 01:38:54PM +0530, Raag Jadav wrote:
> > > Convert to use devm_kmemdup_array() which is more robust.

...

> > >  	data->voltages_mV =
> > > -		devm_kmemdup(dev, resp.voltages_mv,
> > > -			     sizeof(u16) * data->num_voltages, GFP_KERNEL);
> > > +		devm_kmemdup_array(dev, resp.voltages_mv, data->num_voltages,
> > > +				   sizeof(u16), GFP_KERNEL);
> > 
> > Wondering if this can be sizeof(*data->voltages_mV) that makes code robust
> > against type changes.
> 
> True, but I opted for a blind treewide conversion that is consistent with
> existing driver conventions. Perhaps a better place for it is a separate
> filewide series?

I think an additional series is just an increased churn. In this you are
changing an API in use, it's completely fine to update a parameter in
accordance with new API. I.o.w. I consider these two are coupled enough
to be semantically and logically in a single change along with the fact
that in all such case you are touching the same line(s).

-- 
With Best Regards,
Andy Shevchenko



