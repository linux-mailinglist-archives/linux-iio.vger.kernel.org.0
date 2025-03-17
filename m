Return-Path: <linux-iio+bounces-16949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5996A64B32
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 11:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E473B5902
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FF3233127;
	Mon, 17 Mar 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFm+2aEo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376638DD8;
	Mon, 17 Mar 2025 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208770; cv=none; b=LQ+x4tzosvbw+afpL7ZZHqR2N4CwUznienwmgil1tfqSl6jHVJMekvNj8FwfVHnZk+2G5rHYrAxMHZShGylYav/dmTlBsFN+2Ogfy9nKpE+E9fMqweLIPEocE98m+SScP2Ax4zEuqtw+BRVOCYYY4oA0yJL/mywbxpVDrt8fKu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208770; c=relaxed/simple;
	bh=kWFacTmKPeuzPlFoGJUAB4q5hG090ZFXstlYFgBniR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrIGDndx6e0hB61+/WPkigm0zAKasFQ+eT9oXP/euZWoOnoPMX8ZhzNJHR/uCsZNzq8u1j9nWk3qxHXl+Hobna0U0Drq1C0wCx+M+B05queEPfBitxIlvZfr0I2c0VCEKx8WteTx5rxF8xNZxKtwCvFACj1ZlVLOzesAXjPhL4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFm+2aEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4162C4CEE3;
	Mon, 17 Mar 2025 10:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742208770;
	bh=kWFacTmKPeuzPlFoGJUAB4q5hG090ZFXstlYFgBniR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IFm+2aEonTB1ieoX54REeZYdG2KwGsNMZo0SxL73j4j0GNdAvVlMtzwQi9zgTqSrb
	 Z9Mk9sJIlqEpIveodXRIIwX7wGCCYCYMHta/rTQZJ+2pASPLuQBCfEcXy6mMCQgpJP
	 MWKUJx9Dc53eglOoPi4urLKbpuYQCmPuryF692oJWdJjNSYN9j9CBf48ZifxqDm/0U
	 BvRFrkXdBb+os3a8besKXoj4bDLsFa0/n8ClYBfyKlrqWGDqm3c2onmGVFpmgqPhXF
	 78eS1nYffzEUn6ESino4Bk0qKk/LHjp5zDZGgYDTYTkwME2QDGnGphVW6vtFTMJLVo
	 UcqAQs36w+OHw==
Date: Mon, 17 Mar 2025 10:52:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Matti Vaittinen
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
Message-ID: <20250317105216.22a0275f@jic23-huawei>
In-Reply-To: <c7ef9333-c044-4640-b126-7771a1135d87@gmail.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
	<b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
	<Z9LbT1BvPEIp7U2N@smile.fi.intel.com>
	<bb403ddb-5c6f-4286-8d80-3ede40f94dc2@gmail.com>
	<Z9Q-KcadLHdDLxVc@smile.fi.intel.com>
	<20250316095233.20d1a134@jic23-huawei>
	<c7ef9333-c044-4640-b126-7771a1135d87@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 08:52:09 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 16/03/2025 11:52, Jonathan Cameron wrote:
> > On Fri, 14 Mar 2025 16:33:13 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> >> On Fri, Mar 14, 2025 at 09:31:58AM +0200, Matti Vaittinen wrote:  
> >>> On 13/03/2025 15:19, Andy Shevchenko wrote:  
> >>>> On Thu, Mar 13, 2025 at 09:19:03AM +0200, Matti Vaittinen wrote:  
> >>
> >> ...  
> > Picking out a few things to comment on...  
> >>  
> >>>>> +#define BD79124_MASK_HYSTERESIS GENMASK(3, 0)
> >>>>> +#define BD79124_LOW_LIMIT_MIN 0
> >>>>> +#define BD79124_HIGH_LIMIT_MAX GENMASK(11, 0)  
> >>>>
> >>>> These masks are not named after registers (or I don't see it clearly),  
> >>>
> >>> Naming is hard. I usually try to make a balance between:
> >>>
> >>> 1) using names which explain the purpose when seen in the code (at call
> >>> site)
> >>> 2) keeping names short enough
> >>> 3) following the naming convention in the data sheet
> >>> 4) maintain relation to the register.
> >>>
> >>> I put most emphasis to the 1, while 2 is important to me as well. 3 is
> >>> _very_ nice to have, but it is often somehow contradicting with 1 and 2. 4
> >>> is IMO just nice to have. The register is usually clearly visible at call
> >>> site, and if someone adds new functionality (or checks the correctness of
> >>> the masks/registers), then 3 is way more important.
> >>>
> >>> I am open to any concrete suggestions though.  
> >>
> >>  From my point of view the starting point is 3, then one may apply 2 and 4,
> >> the 1 may mangle the name so much that register data field name becomes quite
> >> abstract.
> >>  
> >>>> it's
> >>>> hard to understand which one relates to which register. Also, why not using
> >>>> bitfield.h?  
> >>>
> >>> I saw no need for it?  
> >>
> >> Hmm... Okay, I think Jonathan will ask that if really needed.
> >>  
> > 
> > I won't as I'm not a huge fan of bitfield.h. In many cases they bloat the code
> > and increase the writes that go over the bus.  Don't get me wrong, there
> > are good usecases, but it's not a universal thing (unlike PREP_FIELD()
> > etc which I love :)
> > 
> > I do favour burning a few characters to make field / register relationship
> > clear though.  A few things can help I think.
> > 
> > Structuring defines and naming:
> > I like using whitespace in subtle ways for this.
> > 
> > #define PREFIX_REGNAME_REG				0x00
> > #define  PREFIX_REGNAME_FIELDNAME_MSK			GENMASK(X, Y)
> > #define  PREFIX_REGNAME_FIELDNAME_FILEVALNAME  		0x3
> > etc  
> 
> This is close to my usual way, but not quite. I most often do:
> 
> PREFIX_REG_REGNAME
> PREFIX_MASK_FIELDNAME
> PREFIX_FIELDNAME_FIELDVALUE.
> 
> Problem with
> PREFIX_REGNAME_FIELDNAME_MSK
> compared to
> PREFIX_MASK_FIELDNAME
> 
> tends to be the length of the define. Also, sometimes registers contain 
> field(s) which have nothing to do with the register name. Sometimes it 
> results confusing definitions. (Confusing meaning that seeing the actual 
> read/write makes one to wonder what the register field is supposed to do).

The key reason to keep that regname in there is it lets the reader
scan the register defines for oddities then, having done that read the
code without having to go look to see if the field is infact in this
register.  So having the name in there in a fixed location tends to
help with whole case of fields shoved in corners of unconnected registers.

> 
> > Makes it easy to see if we have a mismatch going on
> > 
> > However, I don't insist on this in all cases as it is one of those
> > "don't let perfect be the enemy of good" cases I think.
> > 
> > So Matti, good to have one last look at the defines and see if they
> > can be wrangled into a slightly better form.  
> 
> I can at least change the MASK to MSK and save one letter :) What comes 
> to the ordering, I see you prefer having MSK / REG suffix at the end - 
> while I like having it right after the prefix (just because it makes the 
> MSK / REG to stay aligned - which in my eyes looks a little bit better). 
> So, I'm not sure if I change it to your preference (which may end up 
> being more common in IIO if it's what you prefer), or if I keep it the 
> way I am used to.

That choice is up to you.  If the clarity is there, I'm not fussed
on ordering.

> 
> >> ...
> >>  
> >>>>> +static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> >>>>> +				    unsigned long *bits)  
> >>>>
> >>>> Ditto, .set_multiple_rv().  
> >>>
> >>> As you know, this started at v6.14 cycle which is still ongoing. I don't
> >>> think .set_rv() and .set_multiple_rv() are available?  
> >>
> >> You mean that you are still hope to have this series to be squeezed for
> >> v6.15-rc1? That's not me who decides, but if not, those APIs will be part of
> >> the v6.15-rc1 (at least they are pending in GPIO subsystem).
> >>  
> > I'd vote for a rebase on rc1 that should be really easy to for me to pick
> > up.  
> 
> I sure can rebase if the series is not merged before the rc1 is out. I, 
> however, rather not delay versions (unless explicitly asked to).
> 
> Sometimes postponing things to wait dependencies to get merged backfires 
> due to some 'last minute' delays. Hence, I don't usually adapt to new 
> APIs until they are in the rc1 or target subsystem's 'for-next' (or 
> other suitable) -branch.

If we were a little later in the coming cycle I'd agree, but
risk factor for a rebase around rc1/2 is very low.
That often needs doing anyway because of in kernel ABI changes etc.

> 
> > I'd accept a follow up series though.   Ultimately won't affect
> > when this series lands as very unlikely Linus will delay the release
> > long enough for me to do another pull request this cycle,  
> 
> No problem. You'll pick this when you think it's ready - and I'll rebase 
> if new rc1 is out before that (and convert to set_rv() and 
> set_multiple_rv() if they are included in the rc1).
> 
> If you merge before the set_rv() and set_multiple_rv() are in your tree, 
> then a follow-up will be done when they emerge. :)

Either path is fine for me.  Let's see where we end up!
Even fine to not wait for the rc1 rebase, but just mention the
dependency.  That way your code can be on list for final reviews
and ready to pick up after rc1 is there.

Jonathan

> 
> Yours,
> 	-- Matti


