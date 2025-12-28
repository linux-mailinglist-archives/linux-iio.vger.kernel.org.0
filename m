Return-Path: <linux-iio+bounces-27404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92519CE5460
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 18:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 089153007239
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 17:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88E42DC32A;
	Sun, 28 Dec 2025 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPTM3Q6p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC6F2DAFB9;
	Sun, 28 Dec 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766942666; cv=none; b=bFqxLV0sd0Olkx4gpNUzdb+JMty+6tpDmmpjNPft9zIIXy6euy1Lx1ydZdys6CoG1i9ThyYEhXHlFWRKoCO1Rgpp5IWXfXA84yo+8hIwrYmwMhWhSdMOawbDi2xx4Uifr+2OskHPh4wkFPqeGmtjdFAMA/LmvVgFyoTtQRgbue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766942666; c=relaxed/simple;
	bh=ISyMxDhvsduWXjuJq9jfud5UlXt9N0ziqYIz6cqyuDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTeY+hd3J6MJJnXUtm16Gjq41tuQ+khp3Oido1c+76xhPK7riy6caMG8WyhZg5DQvCfrhxxZ9DS78PA8ie+PL4hUzQlCno3ZPUpap5TOdkdwxc+ENf1DCGgef1n0IQWXxJ9BXWVfY0PWj9ZNLAQRxuI91gDIWAXJsh6qgRUhCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPTM3Q6p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766942664; x=1798478664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ISyMxDhvsduWXjuJq9jfud5UlXt9N0ziqYIz6cqyuDU=;
  b=hPTM3Q6pWhmNHdmyutYeipWBIeWXVETQqrQNkclGaBKhxvyEni5sLCmm
   cCa9ZVfFmEcwRdNdnQNJE0l5XH/Atuk0wEWxWCehhwhbi93H8Dbjm7t99
   WSE4sCmD+LmweiRNGljRP5Y7lWduxYGk+8bujrAldn6PdT9RzYSfmOE7w
   YuF6chJSKKwrDBtZMRzc1HlFVlX8ErjizKZ9dJXlZSGtA+nRlrOyCxj7N
   u1e31RcB6I767TZRu4NBXiD1y/Bz3orVJ0tGsX8UB6ia59w31Fk4lNTNk
   NSsDLR7EESWZUWiHVyXnny1rb0PVAwOii4rqsitDghS6sUZXHEuHr5t4h
   w==;
X-CSE-ConnectionGUID: 7FZNaBh4S3SKJrJ8aeWQFA==
X-CSE-MsgGUID: guc61jNHRY+9XjOTBEQ0hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="71164746"
X-IronPort-AV: E=Sophos;i="6.21,183,1763452800"; 
   d="scan'208";a="71164746"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 09:24:21 -0800
X-CSE-ConnectionGUID: kiozcs66StyNIKNK/WLYtA==
X-CSE-MsgGUID: DWXe1shURiGe/tn41iynYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,183,1763452800"; 
   d="scan'208";a="200378482"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 09:24:18 -0800
Date: Sun, 28 Dec 2025 19:24:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Shrikant Raskar <raskar.shree97@gmail.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, heiko@sntech.de,
	neil.armstrong@linaro.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: proximity: Add interrupt support for RFD77402
Message-ID: <aVFnwACvU_GJAFqs@smile.fi.intel.com>
References: <20251221083902.134098-1-raskar.shree97@gmail.com>
 <20251227174559.33539640@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227174559.33539640@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Dec 27, 2025 at 05:45:59PM +0000, Jonathan Cameron wrote:
> On Sun, 21 Dec 2025 14:08:58 +0530
> Shrikant Raskar <raskar.shree97@gmail.com> wrote:
> 
> > This patch series adds:
> >  - Add RF Digital vendor prefix
> >  - YAML binding for RFD77402
> >  - Add OF device ID for enumeration via DT
> >  - Use kernel helper for result polling
> >  - Interrupt handling support
> >  
> > These changes enable DT-based configuration and event-driven
> > operation for the RFD77402 Time-of-Flight sensor.
> 
> Hi Shrikant,
> 
> I'm only seeing this cover letter (and lore doesn't seem
> to have the patches either).  Probably need to resend them.

Same to me, please, figure out what's wrong and next time sent proper v4
to avoid confusion.


-- 
With Best Regards,
Andy Shevchenko



