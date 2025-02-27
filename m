Return-Path: <linux-iio+bounces-16147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DF3A486C8
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 18:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3843B69CA
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE421DE4E1;
	Thu, 27 Feb 2025 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DIvKo15a"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE521DDC29;
	Thu, 27 Feb 2025 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677817; cv=none; b=mH32EgEN1yvxA3YASSkD6c02upIoD9lnqaBbqNFdZKgeHtIglLxJwoivnFv7AhKD6VcEVBKJX0myYXSq1LTge4hhv2/rFaYjE0IthGfoXsU9PaaEFLkcB8OHMIWFzsoF3IEFpyJxKeWkvHerqezw8Tj9ggYL8wGYEQv5lozmhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677817; c=relaxed/simple;
	bh=HU/ZgWB55HHOxXUiyhhiiBr4JziGCTmAXOKdugCeFFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcSvXarCklOy0RNbE0MUD2TLleWC46ndmrzZxhcXi4jUpX4o34EiDS7NZeygAcFtYjW/lwGBDJjTe19DrG2O/ygly1mF+hfIDUXVatPsQS8Vj6e75hJ74L4rO/OqqGkI88TZwA6CbAxVS5+ezRUBJQWDndlV1R4Ciey47MaOcuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DIvKo15a; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D57C144517;
	Thu, 27 Feb 2025 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740677812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSkiEkBXDYScEZ5ofMG9zWS4tKdrzFrmkGZ34AMFarA=;
	b=DIvKo15afjSNGSOcvCupB0MV/J3WwoCrlldJWszOmh/qtQDfA/7dL5t8NYBJeTk7Dd7vQN
	vQs+JEPAWAg5ux9R8tmZ0xGdcsrPOmqMT9GoqFHIOnOaDaEMvlfLFufaKH0kQahQiCCS30
	mZWUhQkuAdu6cPTv2PCEL1A2NUe9Ux7+Ued0hAFNm+mMsvX786rZPfMFuNkIVTN3YAkCk6
	Z3eze4n9SwXeuv8pUIK2hXAtECFqjLpdW9wRv+Li0ecCaT2K/GkPAVW1CAgIZF4413DC3x
	hfvt3FGGI1ms4pxOirPcPIZZWMPD46L7Oqrm6oSW2OJa1A2Wr277sHHwJCC0Vg==
Date: Thu, 27 Feb 2025 18:36:51 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>,
	=?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dharma.B@microchip.com,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 0/2] microchip-tcb-capture: Add Capture, Compare,
 Overflow etc. events
Message-ID: <202502271736515748ffda@mail.local>
References: <Z7h0AXV1zlgp9Nw-@ishi>
 <8fb9f188-3065-4fdc-a9f1-152cc5959186@prolan.hu>
 <Z7vihBqOgP3fBUVq@ishi>
 <bfa70e78-3cc3-4295-820b-3925c26135cb@prolan.hu>
 <Z7_xTQeTzD-RH3nH@ishi>
 <20250227135330.GC182392@tpx1.home>
 <Z8B1LDT-n2XTTp8q@ishi>
 <202502271437280a6701d8@mail.local>
 <Z8CA9RTZWChh9cJW@ishi>
 <Z8CKQvRjqH9lwzgO@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8CKQvRjqH9lwzgO@ishi>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegieduueethefhkeegjeevfefhiedujeeuhffgleejgfejgeekueejuefgheeggfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmegukeejvgemudgsudgsmeeltdekgeemtggtfhgtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmegukeejvgemudgsudgsmeeltdekgeemtggtfhgtpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopeifsghgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghsohhkrghsr
 dgsvghntggvsehprhholhgrnhdrhhhupdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeffhhgrrhhmrgdrueesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopehluhguohhvihgtrdguvghsrhhotghhvghssehmihgtrhhotghhihhprdgtohhm
X-GND-Sasl: alexandre.belloni@bootlin.com

On 28/02/2025 00:52:34+0900, William Breathitt Gray wrote:
> On Fri, Feb 28, 2025 at 12:13:00AM +0900, William Breathitt Gray wrote:
> > On Thu, Feb 27, 2025 at 03:37:28PM +0100, Alexandre Belloni wrote:
> > > On 27/02/2025 23:22:36+0900, William Breathitt Gray wrote:
> > > > Skimming through the driver, it looks like what we'll need is for
> > > > mchp_tc_counts[] to have all three TCCs defined, then have
> > > > mchp_tc_probe() match on a TCB node and configure each TCC. Once that's
> > > > setup, then whenever we need to identify which TCC a callback is
> > > > exposing, we can get it from count->id.
> > > > 
> > > > So for example, the TC_CV register offset is calculated as 0x00 +
> > > > channel * 0x40 + 0x10. In the count_read() callback we can leverage
> > > > count->id to identify the TCC and thus get the respective TC_CV register
> > > > at offset + count->id * 0x40 + 0x10.
> > > > 
> > > 
> > > We can't do that because the TCC of a single TCB can have a mix of
> > > different features. I struggled with the breakage to move away from the
> > > one TCB, one feature state we had.
> > > Be fore this, it was not possible to mix features on a single TCB, now,
> > > we can have e.g. the clocksource on TCC 0 and 1 of TCB0 and a PWM on
> > > TCC 2. mchp_tc_probe must not match on a TCB node...
> > 
> > Okay I see what you mean, if we match on a TCB mode then we wouldn't be
> > able to define the cases where one TCC is different from the next in the
> > same TCB.
> > 
> > The goal however isn't to support all functionality (i.e. PWM-related
> > settings, etc.) in the counter driver, but just expose the TCB
> > configuration options that affect the TCCs when configured for counter
> > mode. For example, the sysfs attributes can be created, but they don't
> > have to be available until the TCC is in the appropriate mode (e.g.
> > return -EBUSY until they are in a counter mode).
> > 
> > Is there a way to achieve that? Maybe there's a way we can populate the
> > sysfs tree on the first encountered TCC, and then somehow indicate when
> > additional TCCs match. Attributes can become available then dynamically
> > based on the TCCs that match.
> > 
> > William Breathitt Gray
> 
> Sorry, let me step back for a moment because maybe I'm trying to solve
> a problem that might not actually be a problem.
> 
> I see functionality settings available in the TC Block Mode Register
> (BMR) that can affect multiple TCCs at a time. Are these BMR settings
> exposed already to users in someway? If not, do we have a way to
> introduce these settings if someone wants them; e.g. would the
> AutoCorrection function enable bit be exposed as a sysfs attribute, or
> configured in the devicetree?

BMR is already available and used by the individual drivers. The current
microchip-tcb-capture already uses it to enable qdec mode.
timer-atmel-tcb uses it to chain timers.

Note that we already have a driver for the pwm function too in
drivers/pwm/pwm-atmel-tcb.c. In fact all the other TCB drivers predate
the microchip-tcb-capture driver.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

