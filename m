Return-Path: <linux-iio+bounces-26681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1034CC9F639
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 15:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id EC67E30025AB
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F02C305E0D;
	Wed,  3 Dec 2025 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UY6MHgHp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD103305074;
	Wed,  3 Dec 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773778; cv=none; b=g4oXbweVcaFKvnjaPYyC8N6nFb83B1ygr1Oecse+qU3ErwBfn0ZgkY+xG6HtbyUF+clBtopiWNWmGgtjYFa9H4YBFKx+mkMaR9oCEl89CVflvTQ/fJeQc2xDi73rL0y9o91ha5Qxd+jXFLL2sug/Ouju3CDA009Wqkh6VkfBmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773778; c=relaxed/simple;
	bh=95R62c0rl9Xz8a36PrIyLInk2dnyvViYCKRZrPmY8zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk60Vo76OxSzlYxb0zzENKpAMpKsZjoTJyTH12ShBMmsyd7koSMOkYnHhWoelmBYeBWXljLTWQsGW6k8qsTeWbJDxhGIAaodOTrtNM9hJ9lu/pmJsg+wV8sJlPgLSvbUWkBv2vljoHCSaiRgJYunNVPwg5oOb9yk0LnPJ/2dDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UY6MHgHp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764773777; x=1796309777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=95R62c0rl9Xz8a36PrIyLInk2dnyvViYCKRZrPmY8zk=;
  b=UY6MHgHpfzVdk1tvVtGotH1bg2QvLhxwWYrnlO56JYQbqHkoW6y2sivG
   P3Kh8PeCPnidCR5bn+UGWPJKipzVkPkNGtgQmbqVVhfZ6lz+JiNT28P54
   GtZkTokSTX8vv/Nsq4BbAOS/GTiyqImWg7qzdcSMFi5Yt+if5b4jG1C44
   WuhEQRibFsSjSpQExR+8g9FErH1Myvg4K5yVqx6FHQsm9nqWYrqYdcDf6
   z7t4cdoPBr6gPlvsUw8HnXj9oy5DGd4f8mDTYgyYWDeptlsHSMEutehg7
   Fe4YjsjMmQNzQRcD0RIPzlPNhonIHvFzVOyIcDijK4ADz6Rl4v4YMPqW+
   A==;
X-CSE-ConnectionGUID: cKlyvhlUSOeikMAXIrKpwQ==
X-CSE-MsgGUID: Y3aL06NbR16T47bqgsyFpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66842742"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="66842742"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 06:56:16 -0800
X-CSE-ConnectionGUID: mkvnUAnsRc2QzCMrhwLO8g==
X-CSE-MsgGUID: jmBsO3FvQOmAOo+xLM/SgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="225665442"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 06:56:12 -0800
Date: Wed, 3 Dec 2025 16:56:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 2/3] iio: adc: Initial support for AD4134
Message-ID: <aTBPivrI7iy2cLQ1@smile.fi.intel.com>
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
 <c189c25b1c46f406c3f7942e5ac4cdb0b964ee52.1764708608.git.marcelo.schmitt@analog.com>
 <CAHp75Vf7p=aPy2ofC_zVz1PURA3R9i0WZCG63-dCEXO=xKJ0FA@mail.gmail.com>
 <daf53d16106f29a09134b2c2a5a2f4870a0bfbe1.camel@gmail.com>
 <aTA0LDYDzP8s__1V@smile.fi.intel.com>
 <c45e24e5edb3ea668accb608f6cdffff62592c74.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c45e24e5edb3ea668accb608f6cdffff62592c74.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 02:48:44PM +0000, Nuno Sá wrote:
> On Wed, 2025-12-03 at 14:59 +0200, Andy Shevchenko wrote:
> > On Wed, Dec 03, 2025 at 11:02:45AM +0000, Nuno Sá wrote:
> > > On Tue, 2025-12-02 at 23:26 +0200, Andy Shevchenko wrote:
> > > > On Tue, Dec 2, 2025 at 10:55 PM Marcelo Schmitt
> > > > <marcelo.schmitt@analog.com> wrote:

...

> > Nuno, may you please remove unrelated context when replying?
> 
> It was not that much. That is why I did not bothered :)

2 pages of text on my screen... We definitely have different metrics
for "too much" :-)

...

> > > Hmm, can you share why we should have a reset controller for the above? 
> > 
> > My point here is to have a standard way of handling "reset" pin independently
> > of what's beneath in the HW — GPIO or other means to assert/deassert it.
> 
> That makes sense.
> 
> > > Unless I'm missing something, even with the aux device, you'll need the code to
> > > optionally add it which (I think) will already force you to check the existence for
> > > the pin (which would be a bit odd IMO).
> > 
> > If this is the case, it needs to be fixed, but reset framework provides
> > _optional() API, that's what should be used for the cases where reset is
> > optional. Let reset framework to handle that.
> 
> Ok, I think I was also misunderstanding you. So you mean that instead of doing 
> devm_gpiod_get_optional() we should use one of the devm_reset_control_get_*() calls? 

Yep!

> Ok, I went to check the reset core implementation and with [1] I take back my comment. I can see now
> that the framework will automatically handle creating the auxdevice. So while I still think most of
> the times we'll still see reset-gpios in bindings, it makes sense to have this HW abstraction in the
> code.

...and standardisation.

> One thing to note is that the reset framework always enforces reset-gpios and we do have places
> where reset pins have different ids (just because that's how the datasheet defines them).

This might affect the decision. In any case, please consider using it and we
can see if it makes sense over open-coded approach.

-- 
With Best Regards,
Andy Shevchenko



