Return-Path: <linux-iio+bounces-27357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B09FCDFDDC
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 15:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 753683017F0C
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB22C31AAB0;
	Sat, 27 Dec 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQ3ACtem"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E58313E23;
	Sat, 27 Dec 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766846602; cv=none; b=LtjNxDs8jBvfyXqxXchWSqSEeIAGhX1D5blbkv8hnBPKV6ENtQZeAg0p+h3VCm+24kmy/Ag9gaz+Kz6JJZjeaeGW4cYHPJeAKPpDyL5pjr0hzF0MySygibPWAdhvQyx7GqRd5jKh86v7mj/9jh431MYTX1iLnrboKAkw2wCHhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766846602; c=relaxed/simple;
	bh=jRhpJFBeIQCwSY+eClJhUGsIi2sH9CCSnImmG2fb1U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcPLMp/dj6BM3kSbADXqiptHf1UwBkWfmNRZTzm/wLITYqirta3V/MjaAatwKTFxEtrvoAPBcOEU8aETfRFxcIl8uyInRp4+oK3Hb1Se6RTUZFAuMk8bNdGdzpCiszglVRx7KL/EtB/he+FL+w1t1jjMK/C0v2ZKRdGCQ1u0Qkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQ3ACtem; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766846601; x=1798382601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jRhpJFBeIQCwSY+eClJhUGsIi2sH9CCSnImmG2fb1U0=;
  b=fQ3ACtem/o8EHREFPvS6vRP8Lj6K2ZGo4nLn61jYsRiaikU4CW41xQah
   ZbplKt8K/x9Xna6BuJXfjZzTPFsAp/3hl4tDfRyXug9yLQwyJgvILvmLU
   uNz23VebQZ7+/HGarIUvF3ujkvs8McQKQ+8z5U3VjAgs4O4gu7iYP5iYz
   r0HtRqekBKyf8cAgt0WJzd1jB+m8Vttvtc5YB6hxM9v67ctX6mzgN0AcF
   FT05/V81r4FUPmdlH/sg7MWxQll8aeozOOkwJyPpERgXzcf3onUHC68Xa
   yDMD1Vs1ViNU3kJ9yf9xzDTygPL3n4Oh5dWHNWbw2ojg5pGYG4k7GYSu6
   w==;
X-CSE-ConnectionGUID: z3OZm2QJSzurEHqpdI1Yyg==
X-CSE-MsgGUID: C5m9ZvhbTpOMSWpUMZ9Dcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="68430878"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="68430878"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 06:43:20 -0800
X-CSE-ConnectionGUID: 6PIyJQj5TU6SVL89rK3TGQ==
X-CSE-MsgGUID: 2E9D1v96Tb6jgF4ZnYd5Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="205094746"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.211])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 06:43:15 -0800
Date: Sat, 27 Dec 2025 16:43:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>, nuno.sa@analog.com,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	duje@dujemihanovic.xyz, herve.codina@bootlin.com,
	Rodolfo Giometti <giometti@enneenne.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] iio: adc: add driver for Texas Instruments TLA2528
 adc
Message-ID: <aU_wgM_gNvxOLNLM@smile.fi.intel.com>
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
 <20251223155534.220504-3-maxime.chevallier@bootlin.com>
 <3e9a5df0-c650-46dc-8b64-b8708099262e@bootlin.com>
 <b2ecbe6f-aed3-44de-b094-022e52d3e5a4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ecbe6f-aed3-44de-b094-022e52d3e5a4@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 23, 2025 at 11:33:02AM -0600, David Lechner wrote:
> On 12/23/25 11:12 AM, Maxime Chevallier wrote:
> > On 23/12/2025 16:55, Maxime Chevallier wrote:
> >> This adds a new driver for the TI TLA2528 ADC chip. It ha 8 12-bit
> >> channels, that can also be configured as 16-bit averaging channels.
> >>
> >> Add a very simple driver for it, allowing reading raw values for each
> >> channel.
> >>
> >> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> > 
> > Looking closer at this, Rodolfo hasn't seen this patch prior to me
> > sending it, so it should rather be :
> > 
> > Orginally-by: Rodolfo Giometti <giometti@enneenne.com>
> 
> I think the usual way would be to keep the Signed-off-by: and add
> Co-developed-by:.
> 
> See https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Hmm... I think the Originally-by is used when the contributor gave
a PoC / basic idea in a form of code that was (heavily?) rewritten.

The only documentation mentions this tag is
Documentation/process/maintainer-tip.rst.

-- 
With Best Regards,
Andy Shevchenko



