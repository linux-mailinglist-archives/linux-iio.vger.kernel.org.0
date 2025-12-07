Return-Path: <linux-iio+bounces-26920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A38E3CABA97
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 23:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 119FA3012752
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 22:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A662E7F21;
	Sun,  7 Dec 2025 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPpVu/tY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85C1CAB3;
	Sun,  7 Dec 2025 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765148357; cv=none; b=KbgZZVrBooP7zx4PvbWND9FNQg+iZSMiuZGefv57sp18Ukm0od2I0BG7Kcq3hrNX8oas1g2zX/3a1WZW/0z+D5uxI0e22oHxQJSh6cZVhU9klwsr8CTJNLwDZLeooLt2wm4IU2BqOBMpj7iL8IZ47NmLam9zlR3y25vkZ7TFtJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765148357; c=relaxed/simple;
	bh=FEv6zAY3Ed6Y+5nAgheHYpX+ARG1CmuK+Q9fnS4hZjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxObgXmCqAI5vompNNVzp0QGO6Nat0bqR2NFDDSZ/fdrrfRODJZjyX4YZMRlV9yAcrEX1bghMhBN6F3V1rW19NINm5QLiKru73iUTZf6WDnBmYYlFA1iJgivqTqrbL+5h7Si8qEpn4i/9hSxcsW7b8Vdq2e98njHQcAOG/TR8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPpVu/tY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765148356; x=1796684356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FEv6zAY3Ed6Y+5nAgheHYpX+ARG1CmuK+Q9fnS4hZjY=;
  b=kPpVu/tYUFNZWcEE3MixtQZPrqDInrBFMCQRSvMApEzrfBresQVcioG7
   o0/lOXzSFQN9oizua2YjXSwVU+AYPr3SsfZ94XHe4KnHiIg+dnY0tR4+J
   4vAB+b7ycW+ddQNqLt9YnyO4H+RcSEs5MbEe3Eam94ObW3UDPH7V9UYzC
   DzLyLPsaqOqeZ/2POLTdTje6jhnKadWpbCPgQ5s36/KsJwV0pnhtYMCmt
   zYgowj4dDmguRcrf2IrsYViFMEUW7vYxrbm69ASkYKa9716brwJgRk5vQ
   t6u76mP9zXgMiNa/YJqvvYe80fX0j8uF/SHSR0ZvicaMEEQJeBM9iR95f
   A==;
X-CSE-ConnectionGUID: 8P1daA/YRaOrSig5Ougsrw==
X-CSE-MsgGUID: kbd3QLXFT8iBH6+7oOV9oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="84696863"
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="84696863"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 14:59:15 -0800
X-CSE-ConnectionGUID: chtK0cbOQbi0uF5bOHt0nQ==
X-CSE-MsgGUID: HM0iQ8BIQYy/W46zMgm0oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="200914356"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.218])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 14:59:12 -0800
Date: Mon, 8 Dec 2025 00:59:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Jander <david@protonic.nl>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v4 2/2] iio: adc: Add TI ADS131M0x ADC driver
Message-ID: <aTYGvaZk_PzouTRf@smile.fi.intel.com>
References: <20251118141821.907364-1-o.rempel@pengutronix.de>
 <20251118141821.907364-3-o.rempel@pengutronix.de>
 <20251207193313.794ea339@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207193313.794ea339@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Dec 07, 2025 at 07:33:13PM +0000, Jonathan Cameron wrote:
> On Tue, 18 Nov 2025 15:18:21 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:

...

> > +	clk = devm_clk_get_enabled(dev, NULL);
> 
> This surprised me, so I went digging.  Anyone know why
> the stub returns NULL?  Given that the normal function doesn't have
> that as an allowed return value that seems really odd.
> 
> Still, it does, so this code is fine if odd.

I believe it has to do something with an optional clocks or so, but OTOH
I think it's so odd that may be considered as a bug in CCF APIs.

> > +	if (IS_ERR_OR_NULL(clk)) {
> > +		if (IS_ERR(clk))
> > +			ret = PTR_ERR(clk);
> > +		else
> > +			ret = -ENODEV;
> > +
> > +		return dev_err_probe(dev, ret, "clk get enabled failed\n");
> > +	}

-- 
With Best Regards,
Andy Shevchenko



