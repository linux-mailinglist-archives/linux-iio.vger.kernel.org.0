Return-Path: <linux-iio+bounces-8417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCC694EE0B
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 15:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DEF282C78
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 13:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9ED17C21C;
	Mon, 12 Aug 2024 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfPjNBzg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0063F17C20E;
	Mon, 12 Aug 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469068; cv=none; b=itERutEjs2SVArWJni6VxZG8eSSmlFKAoLWY4g2AToGA/AI5KL9mBN5BBoTXiYqojHS89SautJ+FqNeBDgGpQT0/nZYIO9r8bipsIzn9oBjLWwYPxEBylc+aETGjhdq/sucU0LlPW2rz9oOAY+Ty0w0dVURLFX195+wnfHpkDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469068; c=relaxed/simple;
	bh=1CknMoutWVAbnf7wb6UnVxhtG6Hf1UOhEOA6ITYyQ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdk9HdQ6YBz91RUCLVzWa9XvYso0yV6qe5nPwjZQtCs0Hfm3lb6fDtUEEqfTM4K5uF4P7OfjYqBnCIkalM36jyeTQaPU3dSmSlU+sNtElZ3XfXAou8Q1HU/XVuTVEnQuLT9CQmikfkhH4Gb+tkQ2ihDIOPu++0uwJreRGuaVzj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfPjNBzg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723469067; x=1755005067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1CknMoutWVAbnf7wb6UnVxhtG6Hf1UOhEOA6ITYyQ8g=;
  b=OfPjNBzgNJs8c2cuvI7/pREha0n4DyLj/66c7QAbQIRfgQTcbi/qz3zE
   8pqutmRIxoiSTyR1lz8yGN5kvrXj29JiVY+5XVo8Lbr6IseJLK8AXvrkg
   BbGTFHn5xnyFUByZlwTvvQp+XrYv8CJsf5UUH2EwoEZghCdNTUVCHV9x4
   ac0hjdBFC2k8zTwANpTrn5MUogsWbpHRkSx3AXqAQc28KySFRpV5YA6XU
   PjD5PfQ683u0/J6ObkuSnGmAafn+kRP4eaf1uxOCvFccyoF7lGnmL1jg3
   o++t/p1px4PHN+wjo0Vr+Uv7jLCtI1y9dQOT+eh30OIAm3uSSejqLB4LI
   g==;
X-CSE-ConnectionGUID: UFIwpEJgTXKXDSAxNWmdVQ==
X-CSE-MsgGUID: xZTIHBs6QrKAvDFFdKnv9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32969233"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="32969233"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:24:26 -0700
X-CSE-ConnectionGUID: OngugKMXTUq71g3EqpSX2A==
X-CSE-MsgGUID: tGuFKrb0TwKzUW3LsMva4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58842187"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:24:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdV24-0000000EMAk-2E8D;
	Mon, 12 Aug 2024 16:24:20 +0300
Date: Mon, 12 Aug 2024 16:24:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] iio: light: ltrf216a: Drop undocumented ltr,ltrf216a
 compatible string
Message-ID: <ZroNBIx61KKzcKQc@smile.fi.intel.com>
References: <20240705095047.90558-1-marex@denx.de>
 <3b2ca0-6687ce00-3-4dab7280@52083650>
 <98992b1d-c94a-4053-a755-32a25d7fdc46@kernel.org>
 <20240707143759.7718e0f3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707143759.7718e0f3@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Jul 07, 2024 at 02:37:59PM +0100, Jonathan Cameron wrote:
> On Sun, 7 Jul 2024 14:02:39 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:

...

> So, I don't see this as a deliberate attempt to bypass a maintainer Nack.
> I'd love to be in a position to say no on ACPI bindings that are garbage
> (there are a lot of them) but Windows is dominant in that space so
> we get stuck with their mess.

...and we are trying hard to avoid this mess in the future (e.g., what is
happening to MIPI I3C case nowadays).

Unfortunately Linux world seems not being so interested in this topic either
(as my proposal to discuss the ACPI ID topic on LPC has been rejected).

> On server's it is a different game
> and the kernel community regularly gets significant changes made.

-- 
With Best Regards,
Andy Shevchenko



