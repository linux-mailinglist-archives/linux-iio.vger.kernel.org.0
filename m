Return-Path: <linux-iio+bounces-14909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25194A25810
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 12:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D02F188781E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F032202F79;
	Mon,  3 Feb 2025 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEfS8avt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DC8202C45;
	Mon,  3 Feb 2025 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738581869; cv=none; b=HJfwMJk9p0WXWcIhQ0bv/X4nYMR+iXIVdP4PRXhulngkKxIojXF6KBiGXm2+IjhxDEdWKCEqrUTsmukwSNJ4dhBUpkz/86W4P+MnJBh850H8tDXDZyGQKDBjFVwtC1O0/K3SV0Qa6I9XEWYe3nAzV453K69i0ltfzLtz9gxK4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738581869; c=relaxed/simple;
	bh=ervF+ft4H9WX12aEQK8vH8+ne/48MCxXw8PWJDQXgUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzeIivGMehmuBuozwMhb1wY3Z1gNKJNxreKPBbOe5m2h2QFDkkzUTK+bMLBRB0G1nRm7pl0xVcXl2jIiOjeMSCqU+kn+aCv4yVEARMMyWoFwBYX4ZqG5KgrGAzJ7EcbaXZSESq9RkS9Kx2X3po0DjXAJPQjiEQTVZ9vQC6ph0bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEfS8avt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738581868; x=1770117868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ervF+ft4H9WX12aEQK8vH8+ne/48MCxXw8PWJDQXgUY=;
  b=jEfS8avtc+EQq5QTLK9pXEieGGKvXW82pE5F63iFHNSer7MBULCOiq/e
   xr0OLhYGeL/U3u9H7xLNY6C0auS11Fxs+YNa2gyhlv2qRMQwkceIw/ub7
   vYmIx4TYTIhhW0WInsEgphu6j4XVgAA46hNuK1bbMXyLRTljgdLXt1H2U
   hXSsn/zYRxPk/NbUlqtaL3RnKcJ9B/8l3M94ns4M9Dtc4wJdp4i0F25Gp
   tvB8ZZmNsTaXgy/5yd5RbTyJ2qYZO8LjlkiLxocIC+ll6NECb5UD02vUc
   s60RwIODq1/mLR4ASIarhpdcrvCrmvsB9P98j9i6p8PKkMUqDgrJqxCN1
   w==;
X-CSE-ConnectionGUID: WTDK3Y6kTMqGDq9nuhrSGQ==
X-CSE-MsgGUID: GgBTfpDKSTStkdHo087Qiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49673405"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49673405"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 03:24:27 -0800
X-CSE-ConnectionGUID: bEbEQw4ZS3WxviqLAfL5fQ==
X-CSE-MsgGUID: f9DNY+3+RWC/9fIy3kEkpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="115268510"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 03:24:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1teuYt-00000007oPP-3Dqe;
	Mon, 03 Feb 2025 13:24:19 +0200
Date: Mon, 3 Feb 2025 13:24:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 14/20] iio: adc: xilinx-xadc-core: use
 devm_kmemdup_array()
Message-ID: <Z6CnY7sAIP5M8NWe@smile.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
 <20250203080902.1864382-15-raag.jadav@intel.com>
 <Z6CSYn7ZDVNELIIv@smile.fi.intel.com>
 <Z6CdnPryJkBHO9PK@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6CdnPryJkBHO9PK@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 12:42:36PM +0200, Raag Jadav wrote:
> On Mon, Feb 03, 2025 at 11:54:42AM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 03, 2025 at 01:38:56PM +0530, Raag Jadav wrote:
> > > Convert to use devm_kmemdup_array() which is more robust.
> > 
> > ...
> > 
> > > -	channels = devm_kmemdup(dev, channel_templates,
> > > -				sizeof(channels[0]) * max_channels, GFP_KERNEL);
> > > +	channels = devm_kmemdup_array(dev, channel_templates, max_channels,
> > > +				      sizeof(channels[0]), GFP_KERNEL);
> > 
> > I would use more regular sizeof(*channels)
> 
> This might get confusing since we're assigning it back to channels.

Then it should be sizeof(*channel_templates) ?

Now since you mention this, in all other suggested cases it may need to be
carefully chosen.

-- 
With Best Regards,
Andy Shevchenko



