Return-Path: <linux-iio+bounces-26696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B1AC9FF2B
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 17:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6FC33006E37
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2CC3557F0;
	Wed,  3 Dec 2025 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JiP3+xXI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B224350D6F
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778643; cv=none; b=jYQH2v2jJ/pNr43ozjs04Eq8ZbMeuwbXsOqaiZu535fryuY1xxc7zEiaF/TOqUmDtMbCXWuSUkWOQaUz8RqJTosLXfMl2Si/mvraq5WB98wqQ+Lm4MpRLsWliAHJcgK27eOID3Y2l38uKU6lY4pw7GjhZnKIEAi3zVQb6TBGnXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778643; c=relaxed/simple;
	bh=cTxNsjzTmC6dxhdnwP39o7kkXccjL7BadJYBSPMoCp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lN8AFCEtbR+d4FmUdVqqKQ94ISoTFIpOPj6miMGfW/66HYurVuUattmjES+LPdjW7+6b4Tke/rprIShsF6j1uyyoHt+SR2lFYWFeWJrTl0sVlNck2vVGPC+GkowXmg5jh2WLIs625RTZaBtWIpZcBwrvjneZuFk2Dm04BwSuV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JiP3+xXI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764778642; x=1796314642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cTxNsjzTmC6dxhdnwP39o7kkXccjL7BadJYBSPMoCp8=;
  b=JiP3+xXIL/FDNnJUVhcfaikum0AjDmsjYBtsIZ/5/W9jXU6Nv1PK7ha+
   BQxperp2yzKkHYDt/7v7tFMQBQtyp9lNjeK/yJoMIS7tVsuAKpbgesHN0
   7MiFAY2XvVKBkE5AH6xH7t5A45mOI5R+H6D11b1Gm/daGtVk66L0nWyq/
   8TKBIlPiCIVkZXHJ0c3/cJHCOkaAWQn0fbjPr2v53yh6lUBH5+4+33Qz/
   KmAPIbw45iSp2QM3xZP46nxpjscClbc9ut7c57OACdTSsBP6OsnPkr5P5
   BU5YTmDI2khr44fcXM49AmsyQOsmOCO1QeSRy/78h4pKSRFnx4BX2fYI/
   w==;
X-CSE-ConnectionGUID: F96fz1WxQTuO7qIvY2D/yw==
X-CSE-MsgGUID: 3lFVqxukQ16CRwSZ583T2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="70394593"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="70394593"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:17:21 -0800
X-CSE-ConnectionGUID: 6D7RfhLRTw+5bleRIFnpeQ==
X-CSE-MsgGUID: hXx8r8G8SuGOZt4hk/uG4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="194834792"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:17:20 -0800
Date: Wed, 3 Dec 2025 18:17:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: adi-axi-dac: Turn dev_info() into dev_dbg()
Message-ID: <aTBijcMzzC9i7qbt@smile.fi.intel.com>
References: <20251203-iio-axi-dac-minor-changes-v1-0-b54650cbeb33@analog.com>
 <20251203-iio-axi-dac-minor-changes-v1-2-b54650cbeb33@analog.com>
 <a17f410b-17b3-4abd-98c0-be6952894eaf@baylibre.com>
 <13c8796d8c24f2d0eefd99e6529bc91d448243b8.camel@gmail.com>
 <44640683-de26-492f-a7ef-6af4a61518f3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44640683-de26-492f-a7ef-6af4a61518f3@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 10:14:41AM -0600, David Lechner wrote:
> On 12/3/25 10:10 AM, Nuno Sá wrote:
> > On Wed, 2025-12-03 at 10:05 -0600, David Lechner wrote:
> >> On 12/3/25 9:53 AM, Nuno Sá via B4 Relay wrote:

...

> >>> -	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
> >>> -		 ADI_AXI_PCORE_VER_MAJOR(ver),
> >>> -		 ADI_AXI_PCORE_VER_MINOR(ver),
> >>> -		 ADI_AXI_PCORE_VER_PATCH(ver));
> >>> +	dev_dbg(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
> >>
> >> Didn't ADI HDL versioning policy change to semver so that the last number
> >> is no longer necessarily an ASCII character?
> >>
> >> We could probably change this to %d.%.d.%d while here.

I believe you don't want %.d and it was just a typo.

> > Honestly, I'm not sure how that settled up. I'll check and if that's the case I can change it.
> > But then it will be a bit messy with older IPs. Maybe moving this into debugfs and handle the format
> > there would make sense.
> 
> If it was still an ASCII value, it would just look like an unusually
> high bug fix number, but I don't think that hurts much. I don't think
> we need to go as far as changing it to debugfs. It should be pretty
> obvious if that is the case and people can figure out how to convert
> the number to a character.

One can always use a %pE for that. But if version grows up to printable
character... this all become screwed.

> The dev_err_probe() function in the previous patch in this series
> also has the same issue.

-- 
With Best Regards,
Andy Shevchenko



