Return-Path: <linux-iio+bounces-11441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67169B2BCF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 10:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AB71C21727
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237521CC16A;
	Mon, 28 Oct 2024 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aiSwxHHG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17219A59;
	Mon, 28 Oct 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108898; cv=none; b=MRYRjGaK+nr6ui0/QAilZyece+k384Xhyz9rW+bJAFwWYVRnPRD22GQDfVy9+Q6oxYauD/YFRVQcTXpcpuAZmuGkRDfLSWfuboHHX9z0+xHQCBTxtRRIA1uLljMCxOJGUGG3oV9kJ8HynWVZ0ihHlxBiuy6Hgn9vgb5Yoe59tGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108898; c=relaxed/simple;
	bh=rh07UDCzEyL18Z+zxG4VMkJW3Ao7Ja2X9CP/jHWMTOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5M5uN0fYdCP8QIoa43UbhPrRdH60LAnRFavDGP9uE636bGqPVoANO5ftfcZhNq/PSwasX1tBzeUYjeo2pwaTRKiJM3P+KQ73tuYiJ932k8jMuMJ/xwZC44PnE7Ia0iKFlCJmr2ZoUFbPV+AkOA+E55Q/1xAAd10VPs1NbnzL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aiSwxHHG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730108897; x=1761644897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rh07UDCzEyL18Z+zxG4VMkJW3Ao7Ja2X9CP/jHWMTOw=;
  b=aiSwxHHGkrNJaHpFtzc6pbNEEkSGgYmGhmgjibiIbgmH41bLcKg7bvnt
   WTEFQkOeQco7oxU9hMSjgibYOUVzfopwKNIhvPDG1uc99rBxzb3a4Npih
   2Zux6svnLECzIksa4bTSxkE0tnX3PtcjcJkUq0InMdcTPY3Sg67fTmSzP
   cbMdAcDPdmcEFhjAxIjO3QAbFxhlQNoX+7knZTtudh4DnFJG8M+As0Pbc
   xIJLtDwiVPMH7p7dRwmZQMjEsX3Y01kGv1p5Yr55klaCNPAzt872ehsEL
   FIk0lTM67iKZ2DwbUIcZUmptm4WUg8qlxkwXpxPlhnvLDtOmInJDBJeAr
   g==;
X-CSE-ConnectionGUID: knroarZBS3eJ9ANyjEFmBw==
X-CSE-MsgGUID: CLfR2jcpQ8yQ2mrGYNwlCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40320163"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="40320163"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:48:16 -0700
X-CSE-ConnectionGUID: dDSPrsXpRH+k8byLplXkgA==
X-CSE-MsgGUID: nWMzGgyJR2qCtvoCAXoSgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81616557"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:48:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5MM7-00000007tkD-2Nhg;
	Mon, 28 Oct 2024 11:48:11 +0200
Date: Mon, 28 Oct 2024 11:48:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 11/24] iio: accel: kxcjk-1013: Start using chip_info
 variables instead of enum
Message-ID: <Zx9d2_timtAOYqSI@smile.fi.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
 <20241024191200.229894-12-andriy.shevchenko@linux.intel.com>
 <20241026122605.0ea7188c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026122605.0ea7188c@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Oct 26, 2024 at 12:26:13PM +0100, Jonathan Cameron wrote:
> On Thu, 24 Oct 2024 22:05:00 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Instead of having a enum and keeping IDs as driver data pointers,
> > just have a chip_info struct per supported device.
> I'm not keen longer term on acpi_type, as the various bits dependent on that
> should probably be done via optional callbacks in the kx_chipset_info
> structure, but this is a sensible intermediate step.

Yeah, I decided to postpone that because the main point of this series is to
clean up acpi_match_device(). And indeed I was thinking about callbacks and
other things (flags, string literals, etc) to be moved to chip_info.

> I see the chipset one goes away later hence no comment on that.
> 
> I did a bit of white space massaging whilst applying this.
> Hopefully that won't make me mess up applying the following patches.

Thanks!

(OTOH I'm not sure what spacing you meant because in the result it still seems
 slightly inconsistent.)

-- 
With Best Regards,
Andy Shevchenko



