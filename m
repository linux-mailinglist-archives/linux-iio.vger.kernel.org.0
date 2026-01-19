Return-Path: <linux-iio+bounces-27952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E02ADD3A584
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 11:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31E153065DDE
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D5D30AAD6;
	Mon, 19 Jan 2026 10:42:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83325308F02;
	Mon, 19 Jan 2026 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768819327; cv=none; b=I1qQgQCFCo24aN6eK07dOqCXwk8maShMN1U8rsoCLjRZDvIgHC3ZQmqMmYXMEw4Y5IMzypqWV1WVQxofhLCL3zEAOLQSoYTA2/F+ZcVbBFNKe2GNSTTb2R77LhYyq2sFDWfMPXdkjGzHCL0ry1hET3daE1qj/aLIyVIsUa/0R6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768819327; c=relaxed/simple;
	bh=qenx5N2waJdC9QQIVsp9hQNVuZ57Bzo2azojkGh3inA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pio6DrFjO0vBGCkMV+yy/F8sqctlEUGVY38UY6iBqbGwrQ27DWwrpzzqElsRoJOX0yUB432VeUUkGNEM2TeWQ0PGoImH3ZRD5POyE6P71KAqM8JO6XZfdmxpEzasQo49odkoQcxd/kL7UWJw+EJeBqEOvzkHqR/Dl+ssnv3uBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvn7l1RtNzJ46fh;
	Mon, 19 Jan 2026 18:41:39 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id D94FC40573;
	Mon, 19 Jan 2026 18:42:01 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Jan
 2026 10:42:01 +0000
Date: Mon, 19 Jan 2026 10:41:59 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Rodrigo Alencar
	<455.rodrigo.alencar@gmail.com>, <rodrigo.alencar@analog.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>, David Lechner
	<dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 4/6] iio: frequency: adf41513: features on frequency
 change
Message-ID: <20260119104159.000025f7@huawei.com>
In-Reply-To: <aW3fYYK4ywhwOZv9@smile.fi.intel.com>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
	<20260108-adf41513-iio-driver-v3-4-23d1371aef48@analog.com>
	<aWFR2wTSWLydGN5O@smile.fi.intel.com>
	<ptyn5x7qkmbakkompmijo6xeego2xrhjoeyomkgrytwgwcsaid@heiq3ilnx5ky>
	<aWTS-npPY6yPARZH@smile.fi.intel.com>
	<20260116175743.169eb595@jic23-huawei>
	<aW3fYYK4ywhwOZv9@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 19 Jan 2026 09:38:09 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Jan 16, 2026 at 05:57:43PM +0000, Jonathan Cameron wrote:
> > On Mon, 12 Jan 2026 12:54:50 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Mon, Jan 12, 2026 at 09:45:49AM +0000, Rodrigo Alencar wrote:  
> > > > On 26/01/09 09:07PM, Andy Shevchenko wrote:    
> > > > > On Thu, Jan 08, 2026 at 12:14:53PM +0000, Rodrigo Alencar via B4 Relay wrote:    
> 
> ...
> 
> > > > > > +	bleed_value = div64_u64(st->settings.pfd_frequency_uhz * bleed_value,
> > > > > > +				1600ULL * HZ_PER_MHZ * MICROHZ_PER_HZ);    
> > > 
> > > You multiply Hz * Hz. One of them should be simply SI multiplier.
> > > To me it sounds like one of
> > > 
> > > 				1600ULL * MEGA * MICROHZ_PER_HZ);
> > > 				1600ULL * HZ_PER_MHZ * MICRO);
> > > 
> > > will be the correct one (and I lean towards the first one as you want units
> > > to match).  
> > 
> > I don't really care, but... They are Hz * Hz / Hz * Hz / Hz = HZ
> > if we assume the first number is in Hz.  The others are all ratios.
> >  
> > So original is fine as far as I can tell.  
> 
> I don't see it like this. I consider that we should have only one meaningful
> units as the rest is just a value. What you wrote above has a little sense
> to me, sorry.
> 

I agree, but none of those XHZ PER HZ is mathematically valid way of applying a unit.
This is because the per means divide so the units cancel out.
Literally it's  (0.0000001Hz / 1Hz) 
So using them to assign a unit is meaningless.  All they are doing is hinting
that we are manipulating values already in some scaling of Hz.

Personally I'm not sure there is value in the unit specific defines given
this. They kind of hint we are dealing with frequencies, but that's it.

Jonathan



