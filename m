Return-Path: <linux-iio+bounces-15438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F83DA32407
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 11:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA415188443E
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 10:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AFE209F35;
	Wed, 12 Feb 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjI8xcfI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF0209691;
	Wed, 12 Feb 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357768; cv=none; b=f71TnFG+yHEQrCzeEXgpn7xowyr6ltx1Sw8TdyxP9GsWFqxoa7q7C2cVU8Tjl3SzjSDKhpuEL1hJrNDEMaBk3Tdf74uOn9ZHm3wTj1gGTzPhmVyFsuIXYClzWTwK5QNoOAZXfrq61T+8Dsel/F9UWqOQIIBaskCsMmgMLQOeCY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357768; c=relaxed/simple;
	bh=2r6FCD9tYnKCQgTgvsOVi2Kr4w/PAVQ+9aVyTlNzHHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0B8xE+ngTxs5lyaJj+Z8TcKWjH7HnyMNII5XJ3mLv79FhjVEq2+Q9KbgnTgA4GdvoZIaATAj8AzmwmZgq8IPBVdfsYcNeOk6y22pedHneICKM6gERRxo/G9Vty4S1Yh3Utlio7W4BvJEs6wzwBlUFWy0TiULxjwufbxHMS6x14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjI8xcfI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739357767; x=1770893767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2r6FCD9tYnKCQgTgvsOVi2Kr4w/PAVQ+9aVyTlNzHHo=;
  b=BjI8xcfIym1W51kz7DWHmTiVxv4AEVv6q+hFwZyb5lm/c5CynLzc8gw0
   MVUy4SZeEMLFHg+po/uml6XhyqLp57jhqPA4nedKwMGXygofIYZ6dBU5k
   8LlHI+bsdNpvEF06GZv0LpW27Q8nk135KNr0AAo7fHBLrXgn8/tpfuigI
   CVUbDqkMWMwvnpdmy45goj2xedk4naW8MdWAKxu1/xap05AnnuhwJ25JR
   Lc0eKSmlzCOmBPEp3ssyCHg6n4QXxyu4RKqfVdwxJG9HMM5b3Emfq/39q
   SU+53Rengy2jNonryNIGCmZP1i71llxeJjWbvTvGfS79RUe5JxCVFBuBC
   g==;
X-CSE-ConnectionGUID: qL2HY3TVRu+YW8UhrYn1EQ==
X-CSE-MsgGUID: DQcIkJkHTGOAW0JjlmePDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39932018"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39932018"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:56:06 -0800
X-CSE-ConnectionGUID: /G4BxvpUQfCcCLUxRAdjrA==
X-CSE-MsgGUID: IkewcdcZTYuh3nm6eRM76g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117802484"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:56:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tiAPO-0000000AoJz-0anG;
	Wed, 12 Feb 2025 12:55:58 +0200
Date: Wed, 12 Feb 2025 12:55:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 01/17] spi: add basic support for SPI offloading
Message-ID: <Z6x-PVheAMz8dA6l@smile.fi.intel.com>
References: <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
 <Z6pim_nLct33LzfN@smile.fi.intel.com>
 <b000d3fd-754a-43e8-ab10-82677eeee1d2@sirena.org.uk>
 <Z6tcwg7QgQwytoSb@smile.fi.intel.com>
 <Z6tezVXVxVCwXuds@smile.fi.intel.com>
 <Z6tfUfHilO2KLmxv@smile.fi.intel.com>
 <Z6tgNjH6Qq5pe9Gt@smile.fi.intel.com>
 <tnjsrq3trijh4agmbhrfnqeq4iojhwybtg45bwt5n7mg7qqgcx@s7gw7idjuxgd>
 <Z6uhHssgIvI2DJ4c@smile.fi.intel.com>
 <57swm23ik5kyzcjvnhkizctnemtlqf3duhrd5u3n6yelxkerxt@6akfoqmyqsup>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57swm23ik5kyzcjvnhkizctnemtlqf3duhrd5u3n6yelxkerxt@6akfoqmyqsup>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 09:52:37AM +0100, Uwe Kleine-König wrote:
> On Tue, Feb 11, 2025 at 09:12:30PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 11, 2025 at 07:45:30PM +0100, Uwe Kleine-König wrote:
> > > I have no problem here. If the header becomes stale we will most
> > > probably notice that eventually and remove it.
> > 
> > Lol. Look at the header hell we have now. 98% code in the drivers/ just show
> > that the developers either don't care or do not understand C (in terms of
> > what headers are for and why it's important to follow IWYU principle).
> 
> Yeah, there is a problem. The source is that we have a metric ton of
> recursive includes (i.e. headers that include other headers that include
> still more headers). Even if you care, its sometimes hard to know which
> headers you actually need. One idea on my long-term list is to add a
> machine-parsable info to header files about the list of symbols that the
> given file is responsible for. With that in place we could create a
> linter that tells you that this source file doesn't use any symbols from
> <linux/of_irq.h> and it should #include <linux/of.h> directly instead to
> make use of symbols defined there.
> 
> > > Maybe the unused namespace even makes it easier to spot that issue.
> > 
> > Do we have an existing tools for that?
> 
> There is https://lore.kernel.org/all/20250123110951.370759-2-u.kleine-koenig@baylibre.com/

But it was rejected.  So, the answer is "we currently do not have tools".

-- 
With Best Regards,
Andy Shevchenko



