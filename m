Return-Path: <linux-iio+bounces-21305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F67AAF76F5
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DE6188805C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7FE2E9756;
	Thu,  3 Jul 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIq5Jukm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47402E7185;
	Thu,  3 Jul 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552003; cv=none; b=mKMiiOU9rcXwmndj+Lsh6FdKtpfK+CRfAd5cGVOIGw6tp0Ynk1HFYaxjB6/yZDkGx64y1vn7k+SsFR4VwNNrCo+FGl/xmdJ6MztWbuvTmVresZUheG779AJePlCdUS8gvjTNo9+bLMpNDjPZZvFHpfI5wewb22UXCNedNouTNBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552003; c=relaxed/simple;
	bh=kniA2y4sfnQQJjmDImSGwZ+VaTRUH/11XdXtDWuFZGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlnHddsf+TuVL9LNsvtP6zmSL8IQSbu2/s0Uz8SToHa7wB9139szOF4SsOQ8tbRWUThWevtdG6zs6HoLKGEBMohnkSl5rosunYGUMP1cB4i+5lQ/dbKzbzzv4OpMAIrkay+3K5mQY7AN4FnJmlATqd1yJ+eDN5lDCJxTyOOrODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIq5Jukm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751552002; x=1783088002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kniA2y4sfnQQJjmDImSGwZ+VaTRUH/11XdXtDWuFZGo=;
  b=oIq5Jukm1GB6/tfNCu6xIPQXDuhoG38nkZ7j2iUJYPN6Btx2N/NQh7+o
   V7WzkdVcIcfgKWLAQ7ZWhtJEbKhL1ckoYHZU9Uwpnwm2Kh8jMQuFqmhcN
   JI/2MM5jCGi7ouRc3DwH3ZtRjpIJLJ8jaUdbaSuFdI/LkIRt/MaeW0MDt
   TCgQ9W9fTMtIhf13Jw3jezF2iTpa8Ca4nxeLzbiKj0XmVeNdaiIqN/CHc
   Dk+teQ4/FbBPMVcuB3DjjgORU6r5ZdCw5serGlbdBRuMtAsiTAsoQCNmO
   vaW8YNZjrhbUmxxdTibmI0OX8TvvC3h6Q5n10HuzGH4Q3D8Ze2DaNWRQx
   A==;
X-CSE-ConnectionGUID: TV1K1VmdSV2qg4XXK3nGWA==
X-CSE-MsgGUID: o1dk5BMsT5GDdMejljUVBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65334240"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="65334240"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:13:22 -0700
X-CSE-ConnectionGUID: lqSfQKoTSWO2KNjJam8cyw==
X-CSE-MsgGUID: HBd5YVVnREKQ3M2sJmueEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="153792421"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:13:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uXKgb-0000000CDxx-0vDp;
	Thu, 03 Jul 2025 17:13:13 +0300
Date: Thu, 3 Jul 2025 17:13:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, broonie@kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH v7 00/12] iio: adc: Add support for AD4170 series of ADCs
Message-ID: <aGaP-HBbIbfEoKlo@smile.fi.intel.com>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
 <aGTpNNaW7cXC18Jt@smile.fi.intel.com>
 <aGUfapky2uh2tsFt@debian-BULLSEYE-live-builder-AMD64>
 <aGUi7r2dgnbqLOAH@smile.fi.intel.com>
 <aGWBgLLtOzVGwXek@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGWBgLLtOzVGwXek@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 03:59:12PM -0300, Marcelo Schmitt wrote:
> On 07/02, Andy Shevchenko wrote:
> > On Wed, Jul 02, 2025 at 09:00:42AM -0300, Marcelo Schmitt wrote:
> > > On 07/02, Andy Shevchenko wrote:
> > > > On Mon, Jun 30, 2025 at 10:57:32AM -0300, Marcelo Schmitt wrote:

...

> > > > >  6 files changed, 3601 insertions(+)
> > > > 
> > > > This is weird. At least patches 11 & 12 have '-' lines...
> > > > 
> > > Yeah, sorry about that. These ADCs are fancy such that the base driver is about
> > > 1500 LoCs due to channel setup handling and support for multiple combinations of
> > > voltage references and channel setups.
> > > 
> > > About the '-' lines, I will rework ad4170_parse_channel_node() on earlier
> > > patches to avoid 3 line removals in patch 11. Patch 12 is only makes sense
> > > after patch 7 and I think it would lead to '-' lines if coming before patch 10
> > > since both increment the number of IIO channels. Anyway, I'll see how to further
> > > reduce the number of lines being removed.
> > 
> > My point is that the above statistics is mangled and I don't know how I can
> > trust the contents of this series if it already lied about that.
> 
> Looks like git format-patch summarizes the changes from all patches when
> printing the statistics to the cover letter. Also, git format-patch doc [1]
> says the 'changes' dirstat option (default behavior) doesn't count
> rearranged lines as much as other changes.

TIL. Thanks for pointing that out.

> There are cover letters of other
> patch sets where the number of '-' lines don't match the sum of lines
> removed by each patch. [2] and [3] are examples of that.

That's different I believe due to the diff algorithm in use
(btw, do you use histogramm?).

> [1]: https://git-scm.com/docs/git-format-patch
> [2]: https://lore.kernel.org/linux-iio/20250630-losd-3-inv-icm42600-add-wom-support-v6-0-5bb0c84800d9@tdk.com/
> [3]: https://lore.kernel.org/linux-iio/20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com/
> 
> This set doesn't remove stuff that existed prior to it so I think it makes
> sense the cover letter to show that lines are only being added.
> 
> I'll send v8 with the change I mentioned earlier. Unless patches 11 and 12
> already look good the way they are in v7.

-- 
With Best Regards,
Andy Shevchenko



