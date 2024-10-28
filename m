Return-Path: <linux-iio+bounces-11446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BEE9B2C0B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 10:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11FDFB2436F
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B021D0E38;
	Mon, 28 Oct 2024 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkmupxBl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC131CDA36;
	Mon, 28 Oct 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109178; cv=none; b=Z9TNAOBUr3vTAh4nz9w/7o226V2HBVcV3vNEv8VuiKgSh0Nuq7UZT/rQqfwKwfc9xjxs6gXQ/srz2NVGtIN6AvKXzbb2GUE01ozw+X5rCM7UWuFK0K7mtEJ9cpn3lYpFZamq3fYgaN9Iu15Xvl4Z+//V3lbkh2kTn6oYHvj/yDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109178; c=relaxed/simple;
	bh=S+NlMziBUAk9wc3ggAJOARFmJJN+vcycBfoS2t0FAJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEUJIFfyZWys9N4UsEGUN7UK1BYww7C0/6ip1SlMqAhG54E8X0ulAA583QO738Ad0ZwvlaFsJvpEe4Cz6mzsmo4zB7PW5w69VoKW4uhvokm2oNVQq08KnxMGxKZ7VKVq1PdcAK07/r9vIr8bYVsH8Q5G4Ara9B3RraESGhYUoV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkmupxBl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730109176; x=1761645176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S+NlMziBUAk9wc3ggAJOARFmJJN+vcycBfoS2t0FAJo=;
  b=IkmupxBlv29fn7WvOFhX0lSS2NSXpI3V7DDAM60voCx/QckmD/Bh4t/B
   /X//sG9nmOpPVegaWVOfycou3l16zqglPyYU8GiH/gemoHMecPBAsGXCg
   sSATmgX+BdupVEXdlZ7vLJoorfXsRDF2UXlygspptVrs84BbS/7dvr9Be
   ldiL7kxffogzRFADJyAqgKIiRsE7rDXx4QP92Z3FBJwnkhNAoa9NgVzwk
   yvgoWkuN5HNtJSmTjdVT6EJKkQlwUjZIoff1xEddnvG0xoIccX0j850j3
   1qITXE49A0Ia8pAhxehGd1X1aURZtMJMM8av3p/TuBJkkDRbZwn7K6HcC
   g==;
X-CSE-ConnectionGUID: Wjqkoo+PTvO/fqCfu6fdZw==
X-CSE-MsgGUID: Uhs4WF81RYKIbcdUmJzEZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40320586"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="40320586"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:52:55 -0700
X-CSE-ConnectionGUID: 16n/ny2PRuebzTFEWhQK+Q==
X-CSE-MsgGUID: 2Jgk5r/3SVivbokRIFHAaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81618192"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:52:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5MQc-00000007tot-2yFE;
	Mon, 28 Oct 2024 11:52:50 +0200
Date: Mon, 28 Oct 2024 11:52:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 23/24] iio: light: ltr501: Add LTER0303 to the
 supported devices
Message-ID: <Zx9e8ogA9IKBzOJz@smile.fi.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
 <20241024191200.229894-24-andriy.shevchenko@linux.intel.com>
 <20241026125643.36237f7e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026125643.36237f7e@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Oct 26, 2024 at 12:56:43PM +0100, Jonathan Cameron wrote:
> On Thu, 24 Oct 2024 22:05:12 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > It has been found that the (non-vendor issued) ACPI ID for Lite-On
> > LTR303 is present in Microsoft catalog. Add it to the list of the
> > supported devices.

> I'm not totally happy that the MS catalog is enough to justify inclusion.
> Would prefer to have an actual device.

Me to, but I trust Hans' intuition in this case.

> I'll take it anyway as better to have a policy on this than make it up
> each time. So for now I want:
> 1) A device name or
> 2) Entry in the MS catalog.
> 
> Not
> 3) Entry in a driver on random vendor website that we have no evidence
>    is in their products. (the Bosch one the other day).

Agree.

-- 
With Best Regards,
Andy Shevchenko



