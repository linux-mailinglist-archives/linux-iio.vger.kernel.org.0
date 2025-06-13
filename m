Return-Path: <linux-iio+bounces-20606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E185AAD90DE
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 17:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4543D3BAA66
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C891E0DB0;
	Fri, 13 Jun 2025 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRAeVeQn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92EE1ADC90;
	Fri, 13 Jun 2025 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827411; cv=none; b=KOxwLRp1BMXIOzy1Wt8hXJUjCqhbE+RsVQNmOKeDiJI03zx4KvWSJtSSJI38tzg7nY9gGXbd766Br+ICEhBZ7x6FONmDX321JrsoHBlP6s9gsIwtfTHUC6y6eAUXAoaQwpSZIfx4o/6vMFNnys73XRNkLCKXOxFiWBU/DiVD6Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827411; c=relaxed/simple;
	bh=1q4LLuNBoOm7qovwVHckGrY6ZpW00QK+k9OVNRIclGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7tzW/eYBMPWY02shKnIYArdq5JErDH5uriC5i5cynLRxg3tI3Q1bUNNkz6El5bAzFYCkK6sZqA1uk49HomR1iQgosUhmig7FQfdc2dd9CIg/cPTu8fyx6i8M9zeUh7S6pmjQRTFAhYIfah7i8DrLziCnGatwn8Bp3tm4gsunS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRAeVeQn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749827410; x=1781363410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1q4LLuNBoOm7qovwVHckGrY6ZpW00QK+k9OVNRIclGg=;
  b=JRAeVeQnD6ILSm4bLYF6Wmobp/bbtUxuPsUb/KwI6l0yOYQEm5gxN87t
   mVFR3/W7KSj5/s/H3mgcSfCTxCTga7OoG/1pXrwU7atZMFmtCdFKuyZge
   NY4PdE5bg8QRuFNCUilcy3RQRWnhn6zJy05+pOJ7WCoeIELB3DJClI/W1
   r0F2g2muyIVnrkAfJe0NsmktdNmT1EUF0kgWuNKWe2W0g/r6Ck/n8mm9P
   kFdHVBn2nCPFgGH8+j/XpKQckguYj05Vnm263/Wpt0UrbKQ7ohqsaSAKH
   usVN0AfJDYg/uo1pKChIPL3q/MhjvIaLflC82fHH3lRsodygig29f5qPd
   w==;
X-CSE-ConnectionGUID: lLbb/PvwQ7yo2fCf7CSo2A==
X-CSE-MsgGUID: paVMZ5ygRE2jqH/kjrLf/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="62322705"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="62322705"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:10:01 -0700
X-CSE-ConnectionGUID: st1U9hqITMex1xpYW26LNw==
X-CSE-MsgGUID: OsGMEyXwS2eq+wa2xAy8Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="147689565"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:09:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uQ62V-00000006HOU-0Xmv;
	Fri, 13 Jun 2025 18:09:55 +0300
Date: Fri, 13 Jun 2025 18:09:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>, Hans de Goede <hansg@kernel.org>
Cc: Marek Vasut <marek.vasut+bmc150@mailbox.org>, linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Julien Stephan <jstephan@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
Message-ID: <aEw_QrVk9m1TJof3@smile.fi.intel.com>
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <8f7656ed-0a28-4ba0-accc-b19817bbb38b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f7656ed-0a28-4ba0-accc-b19817bbb38b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

 +Hans here as well.

On Fri, Jun 13, 2025 at 10:03:34AM -0500, David Lechner wrote:
> On 6/13/25 7:45 AM, Marek Vasut wrote:
> > The BMC150 on Onemix 2S does not have IRQ line described in ACPI tables,
> > which leads to bmc150_accel_core_probe() being called with irq=0, which
> > leads to bmc150_accel_interrupts_setup() never being called, which leads
> > to struct bmc150_accel_data *data ->interrupts[i].info being left unset
> > to NULL. Later, userspace can indirectly trigger bmc150_accel_set_interrupt()
> > which depends on struct bmc150_accel_data *data ->interrupts[i].info being
> > non-NULL, and which triggers NULL pointer dereference. This is triggered
> > e.g. from iio-sensor-proxy.
> 
> Is the interrupt not wired up or is it just missing from the table?

Same Q I just asked :-)

-- 
With Best Regards,
Andy Shevchenko



