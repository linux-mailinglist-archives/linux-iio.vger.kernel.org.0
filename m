Return-Path: <linux-iio+bounces-20571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200D6AD7A47
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 20:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53C83B5F47
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 18:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5E72D3235;
	Thu, 12 Jun 2025 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEg1rSys"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580CC2D3232;
	Thu, 12 Jun 2025 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754693; cv=none; b=AA4wEWMHWqvUHuDSoJZqBlZmS/bjXUPbi4VtFDsl4Za7M24OCKLBozcpxqUw9D+mTjVFeCq3E6f3XtIg3AXqkCuJpz0QaY9xj9RolNGyQgc1hB1q0VudB+SvpT5RB+x76JWsqiODyGpte+HwwluV1djwbg2fXBZ83MLkgzg0CNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754693; c=relaxed/simple;
	bh=zaz/qKtnA1eAwQLge9799svVuaz0bK6tpHPHFb9I4nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/LXU7PQ+5KhQfzIxPS1+lGnTbS/aeohLDpYXp6MdIvKXvJN8U8ESF2alWa52yqg/0o9qoVnTrgkZ5x30yL5qHiMABUE6R6d7NjxvnT4FcVL0jdfo0m7h5Q+Flc+Ik/zcgpkb5NAo1annXNcWuVZCRW1r6NEsLn3jL1DAFtW/lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEg1rSys; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749754691; x=1781290691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zaz/qKtnA1eAwQLge9799svVuaz0bK6tpHPHFb9I4nM=;
  b=CEg1rSys/Y2NLC4wWixgGwXmLlSPQWQhLb7m094voWW5DimLs1UjmQic
   XACSHgiYE1D+OsEqq9fBKm6Sx9iVbuzS+/2D99zrcFl4zhHlrGc1TJ6Cr
   S1Ybh+SWqfeyLtu5gpCASIuqecEtyg9e1X7QElulhJlt1omm4io8cbKDt
   EdiDS0drTUj6PVTfWIxbih1+NL0Bmao56oaVZjnFHHaO3DwbjqAFTjVpt
   wJF7KObc6rz2bm3gM8ve6oWgoQrF6l4wItGSBPW6WWeDBLXO7QF0Azdvj
   mWTzxOMzmaVUArNzR7s5A/twIkbyjsHZGPeR7FQKimQg+HD6FTiAJe2cd
   Q==;
X-CSE-ConnectionGUID: HW4d9bCOTKSQF9iiyuHR4Q==
X-CSE-MsgGUID: wo45PT2mQKOpJu4BfxfbiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55627070"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55627070"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 11:58:11 -0700
X-CSE-ConnectionGUID: lqZL7g11Tj2E3L7ZXAXFgg==
X-CSE-MsgGUID: yTjIVX5zS5G2SFZ75CZymQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="152766963"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 11:58:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPn7l-000000061eI-2CMG;
	Thu, 12 Jun 2025 21:58:05 +0300
Date: Thu, 12 Jun 2025 21:58:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] iio: amplifiers: ada4250: move offset_uv in struct
Message-ID: <aEsjPffnVdhMXXFK@smile.fi.intel.com>
References: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
 <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-4-bf85ddea79f2@baylibre.com>
 <aErQVKul7Gnxvu3F@smile.fi.intel.com>
 <275cf035-f0ca-4aa6-a41f-b0c21d7c9374@baylibre.com>
 <CAHp75VeewKdOQk9qoO-2Ann90hwAGE0goOtiOG9BRjJ4cn6h=g@mail.gmail.com>
 <846f5979-778a-41f0-b5d2-52d639607315@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <846f5979-778a-41f0-b5d2-52d639607315@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 12, 2025 at 01:45:16PM -0500, David Lechner wrote:
> On 6/12/25 1:34 PM, Andy Shevchenko wrote:
> > On Thu, Jun 12, 2025 at 6:31 PM David Lechner <dlechner@baylibre.com> wrote:
> >> On 6/12/25 8:04 AM, Andy Shevchenko wrote:
> >>> On Wed, Jun 11, 2025 at 04:33:04PM -0500, David Lechner wrote:
> >>>> Move offset_uv in struct ada4250_state. This keeps things logically
> >>>> grouped and reduces holes in the struct.
> >>>
> >>> Can the (smallest part of) the diff for `pahole` runs be added here?
> >>
> >> Well, I didn't use pahole. I could just tell by looking at it. There
> >> was int followed by two u8 followed by int, so we know there was a 2
> >> byte hole before the last int.
> > 
> > Yes, but since we have a tool for such cases, why not use it?
> 
> In cases like this, I don't think the we are getting much value
> from it compared to the amount of time it would take me to do it.

It helps reviewers to see the difference without checking themselves.
Also, it's not a waste of 15 minutes (that's my experience with pahole
when I started it first time), it's an investment to the future similar
changes by you or others. Believe me, as a reviewer you will find this tool
very helpful.

So, please try it once and then you will know how to do that again much
quicker.

-- 
With Best Regards,
Andy Shevchenko



