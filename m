Return-Path: <linux-iio+bounces-25550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B0C13708
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9306B50284F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 08:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BAD25C6FF;
	Tue, 28 Oct 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqEu3dvf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2733C38;
	Tue, 28 Oct 2025 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638678; cv=none; b=JKTgMzlV0r8fL3RUm8KlZ1zErxD3OH8NgqylkFBf1iVAkM8oB+5b9EYjF+eWCpBxKADUAJTOZg86SBLJiiMpGy4geqT2uAnpPUZ34vrK8kKVS5LaRi206fZQjsHwqqu02l0Jv4bO9Ev2oaeCqvJ/zZjX0u4WOt9pMDUzK3kBAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638678; c=relaxed/simple;
	bh=1GBmAMPbA3Sf+YSCcerbg00fQYlt9Ato3JL5CPDHuds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVEzQGNe8KMJsEGV/76l5efaT92e05oCNrpchsKcz4e0lDi/OTcRjeju4dWIXjSGhD5kcbWta8x2UyVuQAm6PlyAv3Mvr/i/PH6Caxj3Bvy+R8jOjccLqiE4381M96FUhgTJ2HOmTiqQmkK6CMdz2RAyQAnfmb0R9wDUZ/0WnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqEu3dvf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761638677; x=1793174677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1GBmAMPbA3Sf+YSCcerbg00fQYlt9Ato3JL5CPDHuds=;
  b=JqEu3dvfTTZizqeoenHElrRJ2xUoArTf/HQTvVkZHR0SpB4ARq1qak7m
   W1GzJgUZ2DxVCPKwN8dOnWV5fmECSM5RGSusR8v6SzpE6wsMpP9PkBt6e
   WEZvlAX6qk366QULQzisyQyoVUkBFPcRbHV4z4uaOfwjxelAUskK74XF7
   7QPBMfENHrYvidoeIHOPfG1+r72GwZcLpWYTaqWRFheLvYyduLJm2q6eL
   4mm+cBqrbqS4D9xvJSc6BYDRAHw0ITILZ1jD155MBK1ipSB+py26sYHws
   B+azFvPIrN2VpOie9LTnCdpJGuzMQBEGflJVhjRrCtrmlXIcqBwy5GOGn
   A==;
X-CSE-ConnectionGUID: BHblaZxGSjiJaQZ1kmgwTQ==
X-CSE-MsgGUID: u7kfjwX3Ss2yKkA6geJ9vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81153138"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="81153138"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 01:04:36 -0700
X-CSE-ConnectionGUID: bTE9dfNqSCqPV4RY+ITyvw==
X-CSE-MsgGUID: PXn/OT/IR+SgH4ewt7p+ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185609813"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 01:04:34 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDegx-00000003FDa-2oym;
	Tue, 28 Oct 2025 10:04:31 +0200
Date: Tue, 28 Oct 2025 10:04:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: Use datasheet name as fallback for label
Message-ID: <aQB5Dw2Eg0tVdNow@smile.fi.intel.com>
References: <20251027124210.788962-1-wens@kernel.org>
 <20251027144327.09f59982@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027144327.09f59982@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 02:43:27PM +0000, Jonathan Cameron wrote:
> On Mon, 27 Oct 2025 20:42:09 +0800
> Chen-Yu Tsai <wens@kernel.org> wrote:
> 
> > Some IIO drivers do not provide labels or extended names for their
> > channels. However they may provide datasheet names. axp20x-adc is
> > one such example.
> > 
> > Use the datasheet name as a fallback for the channel label. This mainly
> > benefits iio-hwmon by letting the produced hwmon sensors have more
> > meaningful names rather than in_voltageX.
> 
> I definitely don't want to have different behaviour for in kernel requests
> and for people reading the _label attributes.  
> https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/iio/industrialio-core.c#L1232
> would need modifying to allow for the sysfs attributes to be created.
> 
> In general I'm not sure I want to do this.  Datasheet names can be exceptionally
> obscure which is why we've kept them hidden from userspace.  At least dts writers
> tend to have those names on their circuit diagrams and tend to have datasheet access.
> 
> Let's see if anyone else has feedback on this suggestion over next week or so.

This is an ABI change without
1) proper documentation;
2) backward compatibility (i.e. there is no knob to opt-out the change, or make
it opt-in).

In this form is definitely NAK.

If you wish something like this, better to have a separate attribute. But the
problem maybe also that the same component (or 100% compatible one) made by
different vendors and have different datasheet names. This means that the new
attribute may still be ambiguous. Hence I see a little sense to have it, rather
better to have these links / names to be put in DT schema. At least there we
have different vendors and compatibility mappings.

-- 
With Best Regards,
Andy Shevchenko



