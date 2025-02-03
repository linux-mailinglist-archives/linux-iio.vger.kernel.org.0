Return-Path: <linux-iio+bounces-14911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA941A2582F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 12:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB3E188939B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 11:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03283202F99;
	Mon,  3 Feb 2025 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpUzQHv6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38553202C45;
	Mon,  3 Feb 2025 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738582200; cv=none; b=m12cibs2AmHK3UrFCCejZxLAB/EzWLL6g44KpRxgzzYb62jSIkrnnHJrZEcb3fcXNSW7XnXZT7yv3zAfLh0W7TnqaYPfDeM+oFAWSWobgFX/PFZOQOnKuixzH6tqWCnIbNOZLFSoZXgXilHJzvkIw4ob2+p0f1AnvVZYxrqeqLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738582200; c=relaxed/simple;
	bh=zU6C8PMSaf7d2L+2vDg6ZpHqQ4i/CwNFkGr/V1AYSRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkRq0WbAaoQyfEBIOLR+4skmK8Tjyeyx5McPfq/KJGVUncjg9qsJReaazy/BmcHyZDABYLpXpu9ViIC+djB8NErXek+DYHvZSUP8EXWMGJaQVguyuSL1L9UNfcVCO2wFA7FFG5Bb9OL1ev1hB5IBHmcI+UnrTTHtX6EMxwTvjOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpUzQHv6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738582199; x=1770118199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zU6C8PMSaf7d2L+2vDg6ZpHqQ4i/CwNFkGr/V1AYSRI=;
  b=IpUzQHv69K1K9wwLhXT0aO1HoUYcJG63BU73HFyUm7dbzQCzPkaIg9EV
   1998qhwlr7HrThUNc8K7mfPW566EaOabJUivRx5FMawWTrgfF17eeBo28
   cdqtMRU4cqNR30jd8Vf8//CAJ2cvxJ5AioS7MOyGMTszper+mDd/M+vFn
   +Az7+z0XtypzdKHnwfhLh6vaLX1Ezs7t0hrBfOmvPNe5csn4pzDqRM2i2
   q63H8yhqpaQpMz3QqhPOqbyzRSyqSnWz4Q0UpVdA6TTcrnR+V4Pr7+T1i
   EBRzxDuT6/nwh3zOBG6/oWRZF4l+uU4UHxrIszf1dabBxixLxYCc5AxSZ
   A==;
X-CSE-ConnectionGUID: 5lEJac38RICZ18+xCZ0SSQ==
X-CSE-MsgGUID: QlhHwAKwRAShvZJ8vIV+uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="38777843"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="38777843"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 03:29:58 -0800
X-CSE-ConnectionGUID: +c1qlMQ/ThKf6agLJ7MEvw==
X-CSE-MsgGUID: IWYnO/GNQVidhJnUapXmVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110216485"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 03:29:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1teueF-00000007oU2-4B1n;
	Mon, 03 Feb 2025 13:29:51 +0200
Date: Mon, 3 Feb 2025 13:29:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 00/20] Split devres APIs to device/devres.h and
 introduce devm_kmemdup_array()
Message-ID: <Z6Cor4FvFK65XUd3@smile.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
 <Z6CRBDpXpPha07mf@smile.fi.intel.com>
 <Z6Cbm3XAG-8XPvoU@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6Cbm3XAG-8XPvoU@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 12:34:03PM +0200, Raag Jadav wrote:
> On Mon, Feb 03, 2025 at 11:48:52AM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 03, 2025 at 01:38:42PM +0530, Raag Jadav wrote:
> > > This series
> > > 
> > > 1. Splits device/devres.h for the users that are only interested in devres APIs.
> > >    Original work by Andy Shevchenko:
> > >    https://lore.kernel.org/r/20241203195340.855879-1-andriy.shevchenko@linux.intel.com
> > > 
> > > 2. Introduces a more robust and cleaner devm_kmemdup_array() helper and uses it
> > >    across drivers.
> > > 
> > > The idea behind embedding both work into a single series is to reduce conflicts
> > > and dependencies while merging.
> > > 
> > > v2: Use size_mul() for multiplication (Dmitry)
> > >     Update commit message (Dmitry)
> > > 
> > > v3: Embed devres.h work by Andy
> > 
> > >     Add more users of devm_kmemdup_array()
> > 
> > I understand the desire to cover as much as possible, but it becomes much
> > harder to coordinate.
> 
> I have a few more patches which I'm delaying to reduce dependency.

So, let's focus on the IIO/pin control ones only for the starter? With the
produced immutable tag you may convince the respective maintainers to pull
that tag along with the patches to their subsystems. It will be much easier
to coordinate and execute.

-- 
With Best Regards,
Andy Shevchenko



