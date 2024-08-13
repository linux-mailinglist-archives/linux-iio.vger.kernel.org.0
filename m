Return-Path: <linux-iio+bounces-8440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A4B950344
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 13:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925921F239AD
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 11:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EDE198A35;
	Tue, 13 Aug 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZR7rP3GO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED2198A05;
	Tue, 13 Aug 2024 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547209; cv=none; b=DQXv9eoggmqb8T9Unkt5UnKdkUr08eABxPk2HWZpCideG1oBh3pUUADHBWNq3kVIVvh7HwIEY+5L+BFlgDit6WqFEEapxhE9DFJ9ytKSKyOJ97SCLabZPr1aFlAyIcwRKdpL56TZoIu85FsG7ZJQc0BBfytaADC0RkmkJpr14C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547209; c=relaxed/simple;
	bh=ecC8fTAmiz1HxGR6Ja05qAtWqbB+IKJQljZIIPuUt08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3PEhQOcHmAcHPsOGex9JeT9kIgYKLBMJaVzZU21vi0u6KLa30CDCWLmJ97/zr/AiP4UORXYZiS4lkRTH+KUGH8mCzgyL+R+3ipazRiWPryaz7IRfGBovWRHupuXhSiSicFEHXF/NUC6dEUSE62lJr1sK/mXiXhAbwlBbRwU+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZR7rP3GO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723547208; x=1755083208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ecC8fTAmiz1HxGR6Ja05qAtWqbB+IKJQljZIIPuUt08=;
  b=ZR7rP3GO0bh96Gg+g+ePvFG1sf5a/r5CqMaGqL2uPJACvFFDHAFHHjsD
   2xurueqYJG+v8msxEEcQvkx2FuOKrkE3WxmMYxFFJeAFvMvX+ktR/pp7F
   TE8so3StfSBQSfsLw7SSh/CaP2KJdh08o83trYVXaqGAFBEalHZ05d+Ar
   cRvIRfp0EPw2kMLScJMfIJOH0L5CSsGcw0i9kOpVphEzZfCDvZxMQOsUC
   mFHiJnfEEEs41QZj/4zx1UKw/Sh8RSkMtq4cO3TGxTPCsrQCjDQzADF+2
   F4Ve33gekguV3AKONPrl8onFJtaLU4aCyvMzUiJxPbU7fg6ybxHdF8NfQ
   A==;
X-CSE-ConnectionGUID: M0D0j1ApQ+qq+sEfInVKUA==
X-CSE-MsgGUID: 7xgO+LLhSHKtyrvd/MkrSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21676129"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21676129"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:06:47 -0700
X-CSE-ConnectionGUID: k7YHe4RWRGKGxsspcQ2+lQ==
X-CSE-MsgGUID: KdgWFSyGQGWxhUvH8ySm/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63026283"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:06:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdpMN-0000000Ehbe-2IsC;
	Tue, 13 Aug 2024 14:06:39 +0300
Date: Tue, 13 Aug 2024 14:06:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <Zrs-P_dBMXDAz-Dz@smile.fi.intel.com>
References: <20240724155517.12470-1-ramona.nechita@analog.com>
 <20240724155517.12470-5-ramona.nechita@analog.com>
 <7d474c3d-22ed-45d5-8224-caaf124b72a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d474c3d-22ed-45d5-8224-caaf124b72a0@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jul 24, 2024 at 06:14:52PM +0200, Krzysztof Kozlowski wrote:
> On 24/07/2024 17:54, Ramona Alexandra Nechita wrote:

...

> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.

I would be more precise

  `git log --oneline --no-merges -- DIRECTORY_OR_FILE`

-- 
With Best Regards,
Andy Shevchenko



