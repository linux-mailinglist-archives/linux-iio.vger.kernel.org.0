Return-Path: <linux-iio+bounces-25260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 249E0BEDA77
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 21:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFA224EDE79
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D1225CC79;
	Sat, 18 Oct 2025 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmjSKpoH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D571EA7D2;
	Sat, 18 Oct 2025 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815822; cv=none; b=NA+E7MgqJyqMu1mKFEAbQ7HkhMQI3PnltMid2wIhCN9n1NbiYg18Kn+wJl+I40euiyqpFtcyp3t7iJ4IKk0+v8jRyCsPhGz3Pg7BnYh0YgibkfQhR8d+kYf/Oqtm2fXhYjjygS6p+kbSdW4zqnaTTO/DR7rlzul9oQUQH2jnK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815822; c=relaxed/simple;
	bh=Te2nZ0oEObsS/v6p5DTbuHeyiExqTwAbCG9MPQyDdjA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kiZEsrpN3pgRFgCt5t5ZiszmxJKISCiwl934wNwqUyZrjVegHWw/rKdmcWlDigXYLuLNMBXRfuXLJL6Sjmz9Zt/o9WHTUAKJqEzpJeKKCCA2Z//ijtFTkwVrcVoj3vGpo17Y6nIY2MPxl2/YlODSEkzuZdHdNZ0zPlS95dpwZ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmjSKpoH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760815821; x=1792351821;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Te2nZ0oEObsS/v6p5DTbuHeyiExqTwAbCG9MPQyDdjA=;
  b=GmjSKpoH/a5s5LaqCegBx9pKukA9vV2lQLq1MW4umZKb+XJYM2rhCziP
   roVWKiFlnejkamdw3rRGkmZ0zNkrx2BTtreVn0WKbVfyAAYqjxaGe/n1p
   GN36cTrCM7nY5McOKAWgEUpuuiV6PajDIXptxSzm+/E4ZB1T9nI1XJ+5o
   luqKjGWAdxnaN8R6dxL3Pvu1l1XeKsBsdXZX+drE4+CdODoscEU9eExL4
   SLAtvC0TmqhXqx1MZ8mDp3i8TzW1ycr0QWm2316TxYNgkWDnr3uK2EcBx
   eO8mmQVPfok7GmON1hYghpVdfTtImaPjJBfOJbVj4bRt7wfoc379fLo02
   A==;
X-CSE-ConnectionGUID: nm+QFIY4SF+qBaDCMhl8uw==
X-CSE-MsgGUID: jk2b2IqBQxWLC7XdVItiCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62209271"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="62209271"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:30:20 -0700
X-CSE-ConnectionGUID: q7ZRlu7UTJqqA1DbsYmARg==
X-CSE-MsgGUID: Vu5vx8+1RHu2OgbewwJIQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="188087098"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:30:17 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vACd4-00000000xYO-1p2c;
	Sat, 18 Oct 2025 22:30:14 +0300
Date: Sat, 18 Oct 2025 22:30:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] regulator: ltm8054: Support output current limit
 control
Message-ID: <aPPqxsU43npNC_v0@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 25, 2025 at 09:54:19AM +0200, Romain Gantois wrote:
> On Tuesday, 16 September 2025 16:27:25 CEST Romain Gantois wrote:
> > On Tuesday, 16 September 2025 15:19:16 CEST Andy Shevchenko wrote:
> > > On Tue, Sep 16, 2025 at 12:24:09PM +0200, Romain Gantois wrote:
...
> > > > CTL pin voltage */ +	vdac_uV = (u64)min_uA * LTM8054_MAX_CTL_V;
> > > > +	do_div(vdac_uV, priv->max_uA);
> > > > +
> > > > +	dev_dbg(&rdev->dev,
> > > > +		"Setting current limit to %duA, CTL pin to %duV\n", min_uA,
> > > > (int)vdac_uV);
> > > 
> > > Why casting?
> > 
> > This one is indeed unnecessary.
> 
> My mistake, this cast is required to avoid a compiler warning;

THen provide a proper specifier instead. Casting in printf() is in 99.9% cases
just a pure mistake.

-- 
With Best Regards,
Andy Shevchenko



