Return-Path: <linux-iio+bounces-15995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A3DA41B0A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 11:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCEAB7A5F33
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 10:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAD52566EE;
	Mon, 24 Feb 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VU+AI1l6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F02566D7;
	Mon, 24 Feb 2025 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392946; cv=none; b=ceWv4I/YMhexWK3mO++Wi+vqRU1hS9SumhEuVyp/Foe5S79KWvEFs+JQ+7n7qy9BYUwKsENj4Dn0wFn15/b3/lLlmQuHEKA+9K3cD96iq7AyTdGiU/2Zo4Hi4cLgLOhjW83kQ0ZzL1Kha3HvJIFS9iM10vbUr2HuWP1CpxXWEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392946; c=relaxed/simple;
	bh=CP0KX0I6NAiiu5eDDamsNgSBHLhb9+BF6VI5OfOdp9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLDYso5pgdRR205licqM28kYw82xFjec8Zu1Fai5PAhg247KdVfeMnv+oQXvP1u6xMBF3cP1HFZFuhQjtyxp82akqPTSkquBPShwNW9d9klNfhQI6lxArRLglqa2Wf2xChVUyaojbXVAVP94wJuH0qirjjtG2rDNh97PK18+tw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VU+AI1l6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740392945; x=1771928945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CP0KX0I6NAiiu5eDDamsNgSBHLhb9+BF6VI5OfOdp9Y=;
  b=VU+AI1l6UPSzNSrHJFPjMnWa9rnVx3hcxdodtKGBEcoHRAkAmS0CISS8
   4P9FwhVQIwqV6P6xEnx3EMnTjJ0YHx6LnsUO0XexQgvOw8K7V+8xUVTV3
   f0TT/JMd/rKGka21iqgag0KSczySSBwqP3Fe482npyvdcfHktT/IcJELb
   10gODM1pHjOSfDlPOWvAFhlskR3/U1eOzKl/K9wjoEEB9xFBp0c6CIS7Q
   0Yo2m3Z0vPyvk2FBiH+CHrXvxM6KzWo77e0SJ8i1+K3ZGUxm7lVjesNa8
   Q/Tdxd/MCcQ5lq34qiaW7wTWTKcaHc0R1IBheqg23LGywOD/nLYpPgyar
   w==;
X-CSE-ConnectionGUID: v1YiTDBES2adXhoItJH9Mw==
X-CSE-MsgGUID: wmKk+uiUS3myO+l60QJXdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40328552"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40328552"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:29:04 -0800
X-CSE-ConnectionGUID: chlxjm6uTEuANndZsQCVZQ==
X-CSE-MsgGUID: bRm10SqjT6K/0Wm9qth3FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121289979"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:29:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmVhq-0000000EfIt-3WP4;
	Mon, 24 Feb 2025 12:28:58 +0200
Date: Mon, 24 Feb 2025 12:28:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linux pin control <linux-gpio@vger.kernel.org>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] devres-iio-input-pinctrl-v6.15
Message-ID: <Z7xJ6gZ4fo2cu8_b@smile.fi.intel.com>
References: <Z7cqCaME4LxTTBn6@black.fi.intel.com>
 <Z7xD57sjj4sbwMv5@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7xD57sjj4sbwMv5@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 12:03:20PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 20, 2025 at 03:11:37PM +0200, Andy Shevchenko wrote:
> > 
> > Hi Linux kernel maintainers,
> > 
> > Here is an immutable tag of the "Split devres APIs to device/devres.h and
> > introduce devm_kmemdup_array()" series [1], please pull if needed.
> > 
> > Link: https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com [1]
> 
> Stephen reported that some of the commits miss my SoB tag (as the committer).
> I will issue another tag with than being fixed.

Done as https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com.

-- 
With Best Regards,
Andy Shevchenko



