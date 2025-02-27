Return-Path: <linux-iio+bounces-16127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E9BA481E3
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 15:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260F31884860
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34103235BEE;
	Thu, 27 Feb 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dk0X7NKE"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426FB2356CA;
	Thu, 27 Feb 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667054; cv=none; b=moZs+DAxyZhTImljYZBnnwV4gnrF6nq1jO52dRyM7+dBqOM9DGfuTFf9xl+ZfbxY1UftlWo0Z1GTgaMYVmIL4Py3YTP+WcRmRKvxF3+GyuB8OkOOUhfUrXULZJv05ZXloYK2SnXrapDuYs6Ti1I3ThPa/7lx43CN+upcGDcazS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667054; c=relaxed/simple;
	bh=XoPiiNKyVbGU9l3AkYImqQNUtvdpaiQjzVjwiRb8ZnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn7sJFVj4AjTVLACWI7s9HuaZPpMsREuGPBmA8I9TeQUbYSj814DZna8rYc9YdXr5yu6fwqLw0v2XoSInYmLxhB0dQNwvEUMLP9sIzwYefvZS95vEBE0xOKfarxyMps9JEVtQIXPrzI9M0cs1RbRnmhrd/HVYtch2S3fcurMEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dk0X7NKE; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A3E5344409;
	Thu, 27 Feb 2025 14:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740667049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=33Zkbezka9OfCIWTsVns3mWdwFBxDhYSMXVDe6+Lw0k=;
	b=dk0X7NKEVYsxppSgwZJT9Cl4v6bC+OLX5Vmx2gRds6URW2FtlH7DWtL/ktNKz6Hfn5iVom
	qzhJfN8BZtIq81Hy14qu4NFA6a4ujjeC16dxfAOp0pnNU6caLcYUxx5ee/UNVATfVm2/V7
	bN3/2JcK42wVnTgELIJlBivuHQ4e8++8vOVn2m1Io5EoL9zn5RJckYSt9jZfgcTO2kNE4G
	GQAjfAEZD7OQGN8usEeKYCS92aFwnHcbdc/uiRMSYGwW6zn5j7VqbasUEAH9m4Am/WQd76
	nmjx7ywjfblHHfh+pHpUcuwVs8WqzngBqMYmOTry8btQ1NscKXTD5xhOn2I9WQ==
Date: Thu, 27 Feb 2025 15:37:28 +0100
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
Message-ID: <202502271437280a6701d8@mail.local>
References: <20250211151914.313585-3-csokas.bence@prolan.hu>
 <Z7h0AXV1zlgp9Nw-@ishi>
 <8fb9f188-3065-4fdc-a9f1-152cc5959186@prolan.hu>
 <Z7vihBqOgP3fBUVq@ishi>
 <bfa70e78-3cc3-4295-820b-3925c26135cb@prolan.hu>
 <Z7_xTQeTzD-RH3nH@ishi>
 <20250227135330.GC182392@tpx1.home>
 <Z8B1LDT-n2XTTp8q@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8B1LDT-n2XTTp8q@ishi>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegieduueethefhkeegjeevfefhiedujeeuhffgleejgfejgeekueejuefgheeggfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmegukeejvgemudgsudgsmeeltdekgeemtggtfhgtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmegukeejvgemudgsudgsmeeltdekgeemtggtfhgtpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopeifsghgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghsohhkrghsr
 dgsvghntggvsehprhholhgrnhdrhhhupdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeffhhgrrhhmrgdrueesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopehluhguohhvihgtrdguvghsrhhotghhvghssehmihgtrhhotghhihhprdgtohhm
X-GND-Sasl: alexandre.belloni@bootlin.com

On 27/02/2025 23:22:36+0900, William Breathitt Gray wrote:
> On Thu, Feb 27, 2025 at 02:53:30PM +0100, Kamel Bouhara wrote:
> > On Thu, Feb 27, 2025 at 01:59:57PM +0900, William Breathitt Gray wrote:
> > > Let me make sure I understand the situation correctly. This SoC has two
> > > Timer Counter Blocks (TCB) and each TCB has three Timer Counter Channels
> > > (TCC); each TCC has a Counter Value (CV) and three general registers
> > > (RA, RB, RC); RA and RB can store Captures, and RC can be used for
> > > Compare operations.
> > >
> > > If that is true, then the correct way for this hardware to be exposed is
> > > to have each TCB be a Counter device where each TCC is exposed as a
> > > Count. So for this SoC: two Counter devices as counter0 and counter1;
> > > count0, count1, and count2 as the three TCC; i.e. counter0/count{0,1,2}
> > > and counter1/count{0,1,2}.
> 
> [...]
> 
> > > Kamel, what would it take for us to rectify this situation so that the
> > > TCC are organized together by TCB under the same Counter devices?
> > 
> > Hello,
> > 
> > Indeed, each TCC operates independently except when quadrature mode is
> > enabled. I assume this approach was taken to provide more flexibility by
> > exposing them separately.
> > 
> > Currently only one channel is configured this would need to rework the
> > driver to make the 3 TCCs exposed.
> > 
> > Greetings,
> > Kamel
> 
> Skimming through the driver, it looks like what we'll need is for
> mchp_tc_counts[] to have all three TCCs defined, then have
> mchp_tc_probe() match on a TCB node and configure each TCC. Once that's
> setup, then whenever we need to identify which TCC a callback is
> exposing, we can get it from count->id.
> 
> So for example, the TC_CV register offset is calculated as 0x00 +
> channel * 0x40 + 0x10. In the count_read() callback we can leverage
> count->id to identify the TCC and thus get the respective TC_CV register
> at offset + count->id * 0x40 + 0x10.
> 

We can't do that because the TCC of a single TCB can have a mix of
different features. I struggled with the breakage to move away from the
one TCB, one feature state we had.
Be fore this, it was not possible to mix features on a single TCB, now,
we can have e.g. the clocksource on TCC 0 and 1 of TCB0 and a PWM on
TCC 2. mchp_tc_probe must not match on a TCB node...

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

