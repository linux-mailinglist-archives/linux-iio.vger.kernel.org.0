Return-Path: <linux-iio+bounces-14910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A54A25818
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 12:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E54E18886F2
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 11:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435D5202F8E;
	Mon,  3 Feb 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbDrnwAb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB9202C48;
	Mon,  3 Feb 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738581953; cv=none; b=oXs81A91UfOQ2mN98gko26rag5WfEbmCxmoKsXG8hEzBC3AFtrFlEKwdnBKfd3XB56olpSvYDxGJ2CirNEHb2uhScbFygCWKyK6N59+2NfthU8vCIEbrDk1s0fYXwYOt4PeFRQg80lsQuLhY9YtXExrNy8qJLfVCSlmpNQREt4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738581953; c=relaxed/simple;
	bh=fsC4d4CPyz4U4znMRSKBx4Zpj6ie0HUSZhmKr2yZ9nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWd8sJUTP67lDT2quwsEI9bDX+hKVKlsqwo+1k4oJ8xI4JScWgNTkq0qmxQXu0khZtB9jHD+VX+F4ph0ffw9LJqA1kfN8pwlFx7I0uZ8KXXmvVGJru1a6LX9QUPrE4j4WrzOus3DEUolYBM8oD5fC48/txPEJ3re+DDtNcf8vsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbDrnwAb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738581952; x=1770117952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fsC4d4CPyz4U4znMRSKBx4Zpj6ie0HUSZhmKr2yZ9nA=;
  b=VbDrnwAbR8TDtEp1sVkrdkLEZVwe6dJ5yrK87wM2d0jURMzSycoU7VMz
   IVZVUvF3RcFZS0M1djl0ZclyBrHlCHmLabTyfaVhcgXsvYomZBod/Swbp
   XkuqmvZOjzyxW11PIm3vbdtPMn1l94D7+9LdE8GCOwjMW9IJcA5ozee+g
   mPeOGOySJAs/J6kW0rasyqbTn55ONVA8+W5eCHHUaOmnio//SHukCsgeh
   z4FBtSCHgxeyhajG+Qm5y6md2jMOqjovn3iARFg3qeq3urCeBDcjyl66g
   l1mPm7iSe6+YX6uff591QjFgsKtV7hAWs/FB0QoQmXyiWCVniq/2Y2Fpv
   g==;
X-CSE-ConnectionGUID: 7l7TxaZESUqiy73ryGZpRg==
X-CSE-MsgGUID: zCO210ffSImpd4MqqhAsHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="61541290"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="61541290"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 03:25:51 -0800
X-CSE-ConnectionGUID: HkaO6USTRaGtKING1Jh64A==
X-CSE-MsgGUID: 4+nMsmgiSdGPcW5MCRxISw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114883986"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 03:25:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1teuaF-00000007oQP-2zRj;
	Mon, 03 Feb 2025 13:25:43 +0200
Date: Mon, 3 Feb 2025 13:25:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Raag Jadav <raag.jadav@intel.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 14/20] iio: adc: xilinx-xadc-core: use
 devm_kmemdup_array()
Message-ID: <Z6Cnt-bkOEOsUVtG@smile.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
 <20250203080902.1864382-15-raag.jadav@intel.com>
 <Z6CSYn7ZDVNELIIv@smile.fi.intel.com>
 <Z6CdnPryJkBHO9PK@black.fi.intel.com>
 <20250203111458.00002a5d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203111458.00002a5d@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 11:14:58AM +0000, Jonathan Cameron wrote:
> On Mon, 3 Feb 2025 12:42:36 +0200
> Raag Jadav <raag.jadav@intel.com> wrote:
> > On Mon, Feb 03, 2025 at 11:54:42AM +0200, Andy Shevchenko wrote:
> > > On Mon, Feb 03, 2025 at 01:38:56PM +0530, Raag Jadav wrote:  
> > > > Convert to use devm_kmemdup_array() which is more robust.  

...

> > > > -	channels = devm_kmemdup(dev, channel_templates,
> > > > -				sizeof(channels[0]) * max_channels, GFP_KERNEL);
> > > > +	channels = devm_kmemdup_array(dev, channel_templates, max_channels,
> > > > +				      sizeof(channels[0]), GFP_KERNEL);  
> > > 
> > > I would use more regular sizeof(*channels)  
> > 
> > This might get confusing since we're assigning it back to channels.
> > 
> It looks like standard pattern.  Assign X * the thing to the thing.
> 
> So I'd prefer sizeof(*channels) here as well.

Yeah, but the problem with kmemdup() family of APIs is that we need to pass
the source size if we want to have 1:1 copy. So, sizeof(*channel_templates)
is more accurate in my opinion.

-- 
With Best Regards,
Andy Shevchenko



