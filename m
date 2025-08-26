Return-Path: <linux-iio+bounces-23304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DE0B36DE2
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 17:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCA12A2E78
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E071C2C324C;
	Tue, 26 Aug 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCP32JBn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F92C28FD;
	Tue, 26 Aug 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222366; cv=none; b=YH7eyW05vJQKJg+nTeRldaf5k8oVUQktzflkEqmuwLasjYLEsVETaY6xQbW7UEqNwVKUf78B+LIH80eQDs7V5fhB1OK6iTJ70HVt2PGuHDwnw0F/E9wCp2TCn31OAHXmg5NeQPBW5B6hHzV8cE1HcPmFzZIgYzpFrbMpF/HwVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222366; c=relaxed/simple;
	bh=TAYYpAtHa61yBvFqqxbwrXU7NW9PVovvDsBEjdO1LzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIrSzdTTpbJD6WIh1aYX80cdu3cCddl5AZsoGlO2bHNDHDom4j6KeAnv+KHE697vm+GmeiJ89ENJsHNhjMWE/A2/yPQcRIK0gTKmInfE/jyGPSEAsTsTWTaQPsKBi9yVYgu4AO0FmZi+//lmEhwNVLSX6YVYw0YCTdlgS7PRdrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCP32JBn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756222365; x=1787758365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TAYYpAtHa61yBvFqqxbwrXU7NW9PVovvDsBEjdO1LzE=;
  b=cCP32JBnFdoxtRaQnuT+uFk1uEPISgpk1PEz9POfSNZqNHXZfEGURYxt
   367Gr6xGzktpOxV9/5ARKov5LbshMcBrCssfOvKDY66weOrYh7wew8z7B
   Sl0/IwWbWAxuHRlk4pFtkxxoAQJPd70MSeyGF19NF2wQKG8DjqWncXz7F
   d22R6JwdEZ1h45hqmTuuTYB8VbLV1qzO5U+SbhFdJqOjqLE4zfmrOU3Vh
   JAUd3FysGHNPuq+qFMlf1MsIwXGyzWp9liT+U0uxC/DSrmcu6+hQt7tDX
   J87IGFpf0grdUf44F/LrnMioIMMW3MJrXG2HYqNcZqaw3xwWYjCePc0R9
   g==;
X-CSE-ConnectionGUID: lUwMOMmhSU+Zzkt1QwbuhA==
X-CSE-MsgGUID: YVByeyigTSC3wwALCFFpfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69175533"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69175533"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:32:44 -0700
X-CSE-ConnectionGUID: xlxD6XWbS/6fW1IR4f6iGw==
X-CSE-MsgGUID: 71tY312RTcG8XHM16Sk7Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="174005637"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:32:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uqvf4-00000008odv-20z5;
	Tue, 26 Aug 2025 18:32:38 +0300
Date: Tue, 26 Aug 2025 18:32:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: adc: ad7124: add clock output support
Message-ID: <aK3TlqSTo2AXbB1K@smile.fi.intel.com>
References: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
 <20250825-iio-adc-ad7124-proper-clock-support-v2-4-4dcff9db6b35@baylibre.com>
 <CAHp75VeAMNp8gARndVRnh3EwrTb65MNFXL7pCThR+Ghd_+yHDw@mail.gmail.com>
 <181dafaa-ec04-43cd-b0a4-208da8cd89e9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <181dafaa-ec04-43cd-b0a4-208da8cd89e9@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 26, 2025 at 10:11:09AM -0500, David Lechner wrote:
> On 8/26/25 3:13 AM, Andy Shevchenko wrote:
> > On Tue, Aug 26, 2025 at 1:55 AM David Lechner <dlechner@baylibre.com> wrote:

...

> >>  static const int ad7124_master_clk_freq_hz[3] = {
> >> -       [AD7124_LOW_POWER] = 76800,
> >> -       [AD7124_MID_POWER] = 153600,
> >> -       [AD7124_FULL_POWER] = 614400,
> >> +       [AD7124_LOW_POWER] = AD7124_INT_CLK_HZ / 8,
> >> +       [AD7124_MID_POWER] = AD7124_INT_CLK_HZ / 4,
> >> +       [AD7124_FULL_POWER] = AD7124_INT_CLK_HZ,
> > 
> > Perhaps / 1 ?
> 
> Seems redundant.

Yes and no. I think that it makes sense to put for the consistency as it makes
reader aware of the divisors. 1 is also valid divisor after all.

-- 
With Best Regards,
Andy Shevchenko



