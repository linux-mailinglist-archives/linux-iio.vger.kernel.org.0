Return-Path: <linux-iio+bounces-16887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28320A634E0
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 10:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F3416ECB3
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 09:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CD419D082;
	Sun, 16 Mar 2025 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjfobbrH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD49739ACC;
	Sun, 16 Mar 2025 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742118764; cv=none; b=f6+I8ZoaTyzS9SgnVf8kYGdd4vkrcrX2l9IlOxT6Br+r2fbE1Hvtp9dJEGYJfUstTG1w8Q+mkK7odrVPtvhWq18GbhcHWH6Olrq6KTS63M3ZFu1GcbAo7ZXfr+FRcMiaX+wyOi/FHIOSA6I+3jkqkKOJE4kdBtXt2Yx0REOkSgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742118764; c=relaxed/simple;
	bh=9Aj1RfBAi8t/f93C+aSgagstTgV2xhkQ6oHtR1PzL/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nfn6PJ3kidSyCe3kUZR1L0gIX2P70zYHO7DG2nt9xjD1mKbuqhv0VUrdQIo6rmyCRebatEnXSbXyzv+cmRux+AQeH2tBruIy1T7+/FHdhzqiaeVXp2Sgn3603wh0faE1+MH7lpUPlNTdav958I8pg2CGQB10aqqpk0EUJ3t+QI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjfobbrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C271C4CEDD;
	Sun, 16 Mar 2025 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742118764;
	bh=9Aj1RfBAi8t/f93C+aSgagstTgV2xhkQ6oHtR1PzL/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IjfobbrHzETYxUSD5FABCQbDjNu45n2vi4KD2fceWoE5L7kzOpIn0db0ZPimbcpJ4
	 Og8jBuzYNEk/XBaMtLRrCwske7zsa18wAhjdbEeFGojJOK7+gXrf8y/tPkWDr5Elpu
	 fVNbA499qzfzM2LDbTPq89n+MvRdg8pGutWB2/hdhZPwi1gkbYJqizlrjHOccuObAZ
	 5is4Ku9RohcjgL6+iWm0HR0WaXA+VV89fkVTHpG4Ynu2GpMqnRaCE20BHhxkn1X5/Z
	 gwgxR+a1Z1EnpSv5GIXduBAb0cfbkx93p144abZtIemCaSq/WSPgtuYzpkku0AqUR6
	 nB1vCJYJJRy3g==
Date: Sun, 16 Mar 2025 09:52:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250316095233.20d1a134@jic23-huawei>
In-Reply-To: <Z9Q-KcadLHdDLxVc@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
	<b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
	<Z9LbT1BvPEIp7U2N@smile.fi.intel.com>
	<bb403ddb-5c6f-4286-8d80-3ede40f94dc2@gmail.com>
	<Z9Q-KcadLHdDLxVc@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 16:33:13 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Mar 14, 2025 at 09:31:58AM +0200, Matti Vaittinen wrote:
> > On 13/03/2025 15:19, Andy Shevchenko wrote:  
> > > On Thu, Mar 13, 2025 at 09:19:03AM +0200, Matti Vaittinen wrote:  
> 
> ...
Picking out a few things to comment on...
> 
> > > > +#define BD79124_MASK_HYSTERESIS GENMASK(3, 0)
> > > > +#define BD79124_LOW_LIMIT_MIN 0
> > > > +#define BD79124_HIGH_LIMIT_MAX GENMASK(11, 0)  
> > > 
> > > These masks are not named after registers (or I don't see it clearly),  
> > 
> > Naming is hard. I usually try to make a balance between:
> > 
> > 1) using names which explain the purpose when seen in the code (at call
> > site)
> > 2) keeping names short enough
> > 3) following the naming convention in the data sheet
> > 4) maintain relation to the register.
> > 
> > I put most emphasis to the 1, while 2 is important to me as well. 3 is
> > _very_ nice to have, but it is often somehow contradicting with 1 and 2. 4
> > is IMO just nice to have. The register is usually clearly visible at call
> > site, and if someone adds new functionality (or checks the correctness of
> > the masks/registers), then 3 is way more important.
> > 
> > I am open to any concrete suggestions though.  
> 
> From my point of view the starting point is 3, then one may apply 2 and 4,
> the 1 may mangle the name so much that register data field name becomes quite
> abstract.
> 
> > > it's
> > > hard to understand which one relates to which register. Also, why not using
> > > bitfield.h?  
> > 
> > I saw no need for it?  
> 
> Hmm... Okay, I think Jonathan will ask that if really needed.
> 

I won't as I'm not a huge fan of bitfield.h. In many cases they bloat the code
and increase the writes that go over the bus.  Don't get me wrong, there
are good usecases, but it's not a universal thing (unlike PREP_FIELD()
etc which I love :)

I do favour burning a few characters to make field / register relationship
clear though.  A few things can help I think.

Structuring defines and naming:
I like using whitespace in subtle ways for this.

#define PREFIX_REGNAME_REG				0x00
#define  PREFIX_REGNAME_FIELDNAME_MSK			GENMASK(X, Y)
#define  PREFIX_REGNAME_FIELDNAME_FILEVALNAME  		0x3
etc

Makes it easy to see if we have a mismatch going on

However, I don't insist on this in all cases as it is one of those
"don't let perfect be the enemy of good" cases I think.

So Matti, good to have one last look at the defines and see if they
can be wrangled into a slightly better form.


.
> ...
> 
> > > > +static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> > > > +				    unsigned long *bits)  
> > > 
> > > Ditto, .set_multiple_rv().  
> > 
> > As you know, this started at v6.14 cycle which is still ongoing. I don't
> > think .set_rv() and .set_multiple_rv() are available?  
> 
> You mean that you are still hope to have this series to be squeezed for
> v6.15-rc1? That's not me who decides, but if not, those APIs will be part of
> the v6.15-rc1 (at least they are pending in GPIO subsystem).
> 
I'd vote for a rebase on rc1 that should be really easy to for me to pick
up.   I'd accept a follow up series though.   Ultimately won't affect
when this series lands as very unlikely Linus will delay the release
long enough for me to do another pull request this cycle,

Jonathan

