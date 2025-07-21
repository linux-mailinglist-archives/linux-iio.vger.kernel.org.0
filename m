Return-Path: <linux-iio+bounces-21834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE82B0C950
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 19:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941131C21361
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDDB2E11D6;
	Mon, 21 Jul 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KoUHjnpC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD8328F95E;
	Mon, 21 Jul 2025 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118099; cv=none; b=O3aOURKazZTlf2uRIbjAjAeaag5hYyi8Bj7VDXyod2jPits6FiMPBroP0xiD5BF1FyypSEVudmhuPHHWns9BOVIXlDZoH++0Y71GLLrBRLCwdki19Ji/sAm0YMPHYe1rJiFIW/xmGvoeYxXbYplTr9Pi4KasIKGPXb61SRefhqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118099; c=relaxed/simple;
	bh=EDwVEG1YcLrzyGWM3/+Lk5Mp3z0nij43S1kN6uWIoBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwTvXc8uZE+EFuXNf951t2oV+OgQ5fW4BVgkpMzmeeMHEdcdVome5kBB+uk611/3ntpnzeqDyhbxUnb83iazxtsGdYpMFahb029KDwB6L1wDxHovcwZSObDbRxkdTqZeuQZGdsOT5/y7CVZsfK4El+HT8Mb5L5olY0kYb2ZHRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KoUHjnpC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753118099; x=1784654099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EDwVEG1YcLrzyGWM3/+Lk5Mp3z0nij43S1kN6uWIoBs=;
  b=KoUHjnpCEyHwO+V6s+lsdpf28u1D1Lj7JBw2Dxrz9KP/5w8i4L1HEWWz
   FmDyMHEpxbp8RCGiD6f0HyZDkuGGUdQNqvl1yYou2mwaq5/4pA2cCburR
   SlTNi4KDGNcfnO1axOS+RnMiH8NG5k8EXpVJJ4XFuSmP+hUfunKdEpCA3
   FGfr2aNOTFTHFALwGwBGSMyQdnwiSZZPtUabmawvNAOiVbB7+xznaM6UM
   QBtHeq3XZSZj/AeiNSfts3VbTDsWECCyX8S/KrBhwZJRrpv1RWF6IY7ge
   j14q80skWN0ZjxO4/4l4F97V/9d7EaHbnISyimQXJFihCRg7XXbw7Qq0k
   g==;
X-CSE-ConnectionGUID: +v+C/ls0TviENcPYHlAQ6w==
X-CSE-MsgGUID: gQAA4+yhQnKsFW4cvNSwzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="65909270"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="65909270"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:14:58 -0700
X-CSE-ConnectionGUID: mE54dbTTSJWW6EhWVJ6OfA==
X-CSE-MsgGUID: xIwlqI3hRfmb47Xue2ydPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="163196999"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:14:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1udu6D-0000000HOKx-2u52;
	Mon, 21 Jul 2025 20:14:49 +0300
Date: Mon, 21 Jul 2025 20:14:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	kernel@collabora.com, wenst@chromium.org
Subject: Re: [PATCH v1 3/7] power: reset: qcom-pon: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <aH51idxbwW1SAExG@smile.fi.intel.com>
References: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
 <20250721075525.29636-4-angelogioacchino.delregno@collabora.com>
 <aH4mWfgQt_Q0O-7S@smile.fi.intel.com>
 <f5d529c3-b898-48ac-8e5a-f587db72dc82@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5d529c3-b898-48ac-8e5a-f587db72dc82@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 21, 2025 at 03:05:46PM +0200, AngeloGioacchino Del Regno wrote:
> Il 21/07/25 13:36, Andy Shevchenko ha scritto:
> > On Mon, Jul 21, 2025 at 09:55:21AM +0200, AngeloGioacchino Del Regno wrote:

...

> > > +	if (!pdev->dev.parent)
> > > +		return -ENODEV;
> > 
> > You can start using
> > 
> > 	struct device *dev = &pdev->dev;
> > 
> > here and perhaps one may convert the rest to it...
> > 
> > ...
> > 
> > >   	error = of_property_read_u32(pdev->dev.of_node, "reg",
> > 
> > ...including, but not limited to, use of device_property_read_u32(dev, ...) here.
> > 
> 
> I didn't do that for one single reason: I did not want to add noise to the commits
> and wanted those to exclusively migrate the drivers to the new API, literally
> without doing *anything* else unnecessary, even if I have located some almost
> effortless improvements that I could've done to those drivers.
> 
> Please - I prefer to keep it this way: these are the first commits that add the
> usage of the new functions and of the concept of SPMI subdevices, and I really
> want those to contain just that and nothing else - because I suspect that these
> will be taken as example and will be read by the next person that is implementing
> a new SPMI (sub)driver or converting any remaining ones to subdevice.

You can introduce a temporary variable in this change and use it only in the
lines you have added/touched. We have similar approach in several drivers.
Then somebody (not specifically should be you) can move it forward.

-- 
With Best Regards,
Andy Shevchenko



