Return-Path: <linux-iio+bounces-16933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26930A6447B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 08:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129313A80BB
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C231A21B9C5;
	Mon, 17 Mar 2025 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/XHcPjx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407721ADB2;
	Mon, 17 Mar 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198279; cv=none; b=ezHpJlHaC25t1XhBYVk+JV9ab0k8GdK1xe9VA3/PwWvMwzhm8kzkUoOJM4JINWA4nLvCDah8ty5hvNeKtgSGnCEq2RWOwJ2ScJv8B+r0tRiXY1f9PQpETooSU9+ec2RDRuy7de3c35Sjn4JwXfXM9VU+mTEOgsnBo5XkL2pArkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198279; c=relaxed/simple;
	bh=1N4ogF1zsSftp1nn8/OPNBUjUZ1Jvt8iznodaw5rx7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMVhc2sa5R1FVk+Yp97r7i4o9ln8+OWr98VNoRLE05nUG/LK6E7jdDQkZdYjuiX3cEd3ZX6n6t7jj7sIrqw8Kra2IqukrVrTUoYF8K5psyfE2I6iucVxDens77RXVNoEUsuQIG4NFMkZqY5mMocF0E5uO1HoKaJfCzLCB1cUJ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/XHcPjx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742198278; x=1773734278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1N4ogF1zsSftp1nn8/OPNBUjUZ1Jvt8iznodaw5rx7U=;
  b=D/XHcPjx6uJiiueqjPDWOcLHXmtKTWQctRtvot5jFD6Cw5fhH88hkby6
   Q0aLspUOiYS3DwB29Xh+y1mR/FDYvdRPHxitmobkMyTG+qcvQhpyPNzDW
   OtCemoGLs3A73uX6Kjf9Ay5rfel+ROdI/68xQJco2MRU0cN3gkFSdDXay
   FSsPanUcyQRq9XUES2lHY5lr6Z9UKGaMdDP/cRlD7y6oXhNMzEWY+7GGR
   vjOIofdSEDLlTEtVd8dkgub4GP64k4i4gZLsbsIonWO7RdPMISWCSkNFh
   A5MUn47cVDCIU7UpAcs1xco/6JeLRkcMqCeZ/q7I1xIzs3EAm6vGQR0jA
   g==;
X-CSE-ConnectionGUID: Fpz6ABVuSiulmb3jbY4Lnw==
X-CSE-MsgGUID: A1Bt9rqCRAC3JRbyFJ/OBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="68639309"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="68639309"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:57:57 -0700
X-CSE-ConnectionGUID: uoBX8/JBQnWgVlArKAJpXQ==
X-CSE-MsgGUID: UEAWNra2Q9GE+GVlE8hGww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="122612233"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:57:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tu5M6-00000003FHH-3JDY;
	Mon, 17 Mar 2025 09:57:50 +0200
Date: Mon, 17 Mar 2025 09:57:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <Z9fV_lNgLaXXG2-j@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
 <Z9LbT1BvPEIp7U2N@smile.fi.intel.com>
 <0d7b37fd-be93-42d7-9610-d2184c601981@gmail.com>
 <Z9Q_GK0_4J6ga1or@smile.fi.intel.com>
 <fb0cee75-30aa-4175-b518-cbf9f3b7d46c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb0cee75-30aa-4175-b518-cbf9f3b7d46c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 17, 2025 at 09:07:30AM +0200, Matti Vaittinen wrote:
> On 14/03/2025 16:37, Andy Shevchenko wrote:
> > On Fri, Mar 14, 2025 at 11:22:37AM +0200, Matti Vaittinen wrote:

...

> > Okay, it seems I misinterpreted the values you have in regmap configuration,
> > I was under the impression that regmap is 16-bit data, but it is about address.
> > 
> > So, we need to know why the heck HW has sparse registers
> 
> We don't know. And we really don't even need to know it. We can just use
> this device knowing there are some.

Don't you have a channel to ask HW engineers about this?

> > for what is supposed
> > to be sequential. This needs a good comment.
> 
> I think it is quite usual that devices contain undocumented registers. Not
> sure having a comment that this device also has some, adds much of value? I
> suppose I can add a comment that we can't use bulk_write because registers
> aren't in subsequent addresses - but having just removed bunch of
> unnecessary comments from the code (as requested), I'm not sure adding this
> one really improves situation... When one sees separate reads/writes for
> data spread to multiple registers, he is likely to assume addresses aren't
> subsequent.

From HW design perspective it's silly to sparse hi and lo part of
the semantically same entity. So, either the (undocumented) register
is also part of the soup, or the registers have different semantics.

This what needs to be commented in my opinion.

-- 
With Best Regards,
Andy Shevchenko



