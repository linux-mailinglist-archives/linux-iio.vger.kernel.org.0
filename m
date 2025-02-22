Return-Path: <linux-iio+bounces-15982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB4EA40AC0
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 18:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CCF189FE4E
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7688D207E1C;
	Sat, 22 Feb 2025 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uufSI/Kj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2090F1DDE9;
	Sat, 22 Feb 2025 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740246534; cv=none; b=P1GwrsSGEeYVofZCNHCBVE+L5IP072iOTNIvSUQriio0dn6VpU+Q7VcPMYlYETPqjbpsr1VrbbwwbILjqFNR0YpZ8nfEyGv+mosFtCW4ZAvD3pATVC37gZSVw6Va6DiSsAGbnczYiBjJhiDBArvcX+9WqVas8kWp0vt0NqMb8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740246534; c=relaxed/simple;
	bh=5ybd0CwdvZUfkyyz0Lx7Y9BJ2t0H8wklafTIwBHYZX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3fO0zfIUx3VN8LiO+PO4BCr6V0fRSjnbsT5qRa7fhyPcZEHP19BF6n9vVsp6yfma1kkM2TkeM5dLN484vIrfV1ls+rFA3JeV7Uz66HXF+FjMaOH2q5ifSCfqzmWNnf2BQKzzmIR/79HfayHZCbprskDPhx4Xi3/yjzNe8Jx7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uufSI/Kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA5EC4CED1;
	Sat, 22 Feb 2025 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740246533;
	bh=5ybd0CwdvZUfkyyz0Lx7Y9BJ2t0H8wklafTIwBHYZX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uufSI/KjoYZSCRhv+C4yr4nbjcz3n9qgwzMQoRwTRyL8B/8ttuiTO1sMXR8737KGU
	 E3S7Fb6nbxerOzSpnbHY/a8LjQQu9xJJ1fUo+qryOIm0ePD8x+fWfaEAtniCtqqX4V
	 8VpMGn28m0hSkTmyGttS8fz36s8MLl0w9F4+xe6+QGVv5xHgH+eyD8D8O+hTOtSceH
	 2arfUBXfpA4pfsR4+bXXs7ThOjPXeiUiuZK347JJIYJM9mJancayUX2wexXgg3miHh
	 8GD6pUNITa9PUFgmzcN8mG3XMYAfPaDS6PAv2LZpB33d8z1bxYNajoOvrYl5qqCuHM
	 RnTHIUcGGd7/w==
Date: Sat, 22 Feb 2025 17:48:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 2/9] iio: adc: add helpers for parsing ADC nodes
Message-ID: <20250222174842.57c091c5@jic23-huawei>
In-Reply-To: <Z7isoU9hKXlgsu33@smile.fi.intel.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
	<6c5b678526e227488592d004c315a967b9809701.1739967040.git.mazziesaccount@gmail.com>
	<Z7ZB7RQhyI5Dohrq@smile.fi.intel.com>
	<b1c1ed68-2f4d-447c-9957-5a1bbc63ef6e@gmail.com>
	<Z7ci7tUlRQqZEZSN@smile.fi.intel.com>
	<ec76334b-bb13-4076-811d-9174170dd677@gmail.com>
	<Z7c2cBQpjoc9-Vyu@smile.fi.intel.com>
	<9018e23c-da28-41b0-b774-1598b946a2a1@gmail.com>
	<Z7dCnRzuQTaJXzmb@smile.fi.intel.com>
	<cb27d8b1-c978-4443-9ad2-96e930701976@gmail.com>
	<Z7isoU9hKXlgsu33@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 18:41:05 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Feb 21, 2025 at 12:10:23PM +0200, Matti Vaittinen wrote:
> > On 20/02/2025 16:56, Andy Shevchenko wrote:  
> > > On Thu, Feb 20, 2025 at 04:21:37PM +0200, Matti Vaittinen wrote:  
> > > > On 20/02/2025 16:04, Andy Shevchenko wrote:  
> > > > > On Thu, Feb 20, 2025 at 03:40:30PM +0200, Matti Vaittinen wrote:  
> > > > > > On 20/02/2025 14:41, Andy Shevchenko wrote:  
> > > > > > > On Thu, Feb 20, 2025 at 09:13:00AM +0200, Matti Vaittinen wrote:  
> > > > > > > > On 19/02/2025 22:41, Andy Shevchenko wrote:  
> > > > > > > > > On Wed, Feb 19, 2025 at 02:30:27PM +0200, Matti Vaittinen wrote:  
> 
> ...
> 
> > > > > > > > > > +EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);  
> > > > > > > > > 
> > > > > > > > > No namespace?  
> > > > > > > > 
> > > > > > > > I was considering also this. The IIO core functions don't belong into a
> > > > > > > > namespace - so I followed the convention to keep these similar to other IIO
> > > > > > > > core stuff.  
> > > > > > > 
> > > > > > > But it's historically. We have already started using namespaces
> > > > > > > in the parts of IIO, haven't we?  
> > > > > > 
> > > > > > Yes. But as I wrote, I don't think adding new namespaces for every helper
> > > > > > file with a function or two exported will scale. We either need something
> > > > > > common for IIO (or IIO "subsystems" like "adc", "accel", "light", ... ), or
> > > > > > then we just keep these small helpers same as most of the IIO core.  
> > > > > 
> > > > > It can be still pushed to IIO_CORE namespace. Do you see an issue with that?  
> > > > 
> > > > No. I've missed the fact we have IIO_CORE O_o. Thanks for pointing it out!
> > > >   
> > > > > Or a new opaque namespace for the mentioned cases, something like IIO_HELPERS.  
> > > > 
> > > > I am unsure if it really benefits to split this out of the IIO_CORE. I've a
> > > > feeling it falls into the category of making things harder for user with no
> > > > apparent reason. But yes, the IIO_CORE makes sense.  
> > > 
> > > Probably I was not clear, I mean to put this under a given namespace. There is
> > > no a such, we have currently:
> > > 
> > > IIO_BACKEND
> > > IIO_DMA_BUFFER
> > > IIO_DMAENGINE_BUFFER
> > > IIO_GTS_HELPER
> > > IIO_RESCALE  
> > 
> > Ah. So, the IIO core stuff is still not in a namespace. Those listed above
> > are all too specific (I believe, in general, and definitely to carry ADC
> > helpers).

Not yet. On todo list... Trick is working out what the correct break up is.

> > 
> > Adding 'ADC_HELPERS' would just add yet another way too specific one. So,
> > currently there is no suitable namespace for these helpers, and I still
> > believe they fit best to where the rest of the IIO-core stuff is.

Just add an IIO namespace.  That would be the one I'd expect a typical
driver to use.  We can move things into it later. The ones above are
more obscure functionality.  Avoid the IIO_CORE naming as I'd expect
that to be stuff the core alone should call and we shouldn't see in drivers.

> > 
> > If we want really play the namespace game, then the existing IIO stuff
> > should be put in a IIO_CORE-namespace instead of creating more new small
> > ones. I am afraid that adding all existing IIO core to a IIO_CORE namespace
> > and converting all existing users to use the IIO_CORE is not a reasonable
> > request for a person trying to:
> > 
> > 1. Write a driver
> > 2. Add a small helper to aid others (instead of just melding it all in the
> > given new driver - which does not benefit anyone else and just leads to code
> > duplication in the long run...)  
> 
> That's why more specific, but also a bit general might work, like IIO_HELPERS,
> considering that they may be used by many drivers.
> 
> While it may be not your call, somebody should do the job. Jonathan? :-)

It's on the list.  Not that near the top of it, but there to do at somepoint.

> 
> > > > > > > > (Sometimes I have a feeling that the trend today is to try make things
> > > > > > > > intentionally difficult in the name of the safety. Like, "more difficult I
> > > > > > > > make this, more experience points I gain in the name of the safety".)
> > > > > > > > 
> > > > > > > > Well, I suppose I could add a namespace for these functions - if this
> > > > > > > > approach stays - but I'd really prefer having all IIO core stuff in some
> > > > > > > > global IIO namespace and not to have dozens of fine-grained namespaces for
> > > > > > > > an IIO driver to use...  
> 
> ...
> 
> > > > > > foo &= (~bar);
> > > > > > 
> > > > > > is _much_ faster than seeing:  
> > > > > 
> > > > > Strongly disagree. One need to parse an additional pair of parentheses,
> > > > > and especially when it's a big statement inside with nested ones along
> > > > > with understanding what the heck is going on that you need them in the
> > > > > first place.
> > > > > 
> > > > > On top of that, we have a common practices in the LK project and
> > > > > with our history of communication it seems you are trying to do differently
> > > > > from time to time. Sounds like a rebellion to me :-)  
> > > > 
> > > > I only rebel when I (in my opinion) have a solid reason :)
> > > >   
> > > > > > foo &= ~bar;
> > > > > > 
> > > > > > and having to google the priorities.  
> > > > > 
> > > > > Again, this is something a (regular) kernel developer keeps refreshed.
> > > > > Or even wider, C-language developer.  
> > > > 
> > > > Ha. As I mentioned, I've been writing C on a daily bases for almost 25
> > > > years. I wonder if you intent to say I am not a kernel/C-language developer?
> > > > Bold claim.  
> > > 
> > > I'm just surprised by seeing that style from a 25y experienced C developer,
> > > that's all.  
> > 
> > I am not. If something, these 25 years have taught me to understand that
> > even if something is simple and obvious to me, it may not be simple and
> > obvious to someone else. Similarly, something obvious to someone else, is
> > not obvious to me. Hence, I am very careful when telling people that:
> >   
> > >>> Again, this is something a (regular) kernel developer keeps refreshed.
> > >>> Or even wider, C-language developer.  
> > 
> > I may however say that "this is something _I_ keep refreshed (as a
> > kernel/C-developer)".  
> 
> True.
> 
> > As an example,
> >   
> > >>>> foo &= (~bar);  
> > 
> > This is something _I_ find very clear and exact, with zero doubt if negation
> > is applied before &=. For _me_ the parenthesis there _help_, and for _me_
> > the parenthesis cause no confusion when reading the code.
> > 
> > I won't go and tell that I'd expect any C or kernel developer to be able to
> > fluently parse "foo &= (~bar)". (Whether I think they should is another
> > matter).  
> 
> > Oh well, let's wait and see what Jonathan thinks of these helpers in
> > general. We can continue the parenthesis discussion when we know whether the
> > code is going to stay.  
> 
> Sure, but it's not only about these helpers, it's about the style in general.
> Spreading unneeded characters in the code seems to me as an attempt to put
> _your_ rules over the subsytem's ones. Whatever, let's Jonathan to judge, we
> will never agree on a keep growing list of things anyway...
> 
I need to find some time to consider it a bit more and look at other users.
I'm not keen on this being 'general' if we only have one user in the short
term.

Jonathan



