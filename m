Return-Path: <linux-iio+bounces-16578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405BCA57C53
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 18:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CEB716B51B
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 17:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B4F1E520C;
	Sat,  8 Mar 2025 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko6CAKs8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E4EBA49;
	Sat,  8 Mar 2025 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741454745; cv=none; b=j5S7njP4gPgh0MWTVvyPJAPrXBlG39sE+XzM2nfiYxaB5RxDCWRH6HJgH5QCWa2Xbjob5av9HnUW7zEISvh33qkHXTztXQzR9DOSLNjEvSxMN2pfDQxhs2ThhtwK9daRgQ8801btleH36IHQ9/8lpIe1VWOF2SAtbZ7Dmxdfdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741454745; c=relaxed/simple;
	bh=rDpyzLuOGQ9vhoXNk1PBzh+HBgo/29DvH9RSc9qi/jI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gv4v2Ow0v2/NYTKBWNpsSXWTJKm0y5jpoVMaSD5VQNp/2AFuQvzqaG3KH3NiR3zuTF2Ug/zKpUbtV6JQdx7edcSFWHj4ZFDWm9L7pN4+OCtBYj7g3qS2k5w5o1iULDL7jIBZxOxlpLAwzdwYgL7wMIVzr8nOG+O5pBxumpx6K9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko6CAKs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85619C4CEE0;
	Sat,  8 Mar 2025 17:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741454744;
	bh=rDpyzLuOGQ9vhoXNk1PBzh+HBgo/29DvH9RSc9qi/jI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ko6CAKs8jrRI3vihYFZhuFCVC+gWko4DW9YC1u108+nP9DqKlM95L9KTnkW8QtGf3
	 8aEeptstxr9xOQXYui5NfiotyHprgRKJgVySw6GJHcyiHqTyDy9IcJweFCrcWjRz/V
	 wXa0Zwa81oZkHS8lTOX1HybZuQqgfRDKhGjUJNQsykLpSZYYHTjkLAZw65yKQK9HSr
	 YrQbdVQdHh3YTeCKWVY+8WnJYVLLHUEXuVxIGqWFYB8Sx7DNQCuSUykDI9aEP08ZtO
	 We1n8uz2NR6yJlMPw5b4IX+aBbx7tAg0iaMg2kkdKwdAAGs1CryEFp++waqyc6oQgX
	 0zL/e4XyO5qjg==
Date: Sat, 8 Mar 2025 17:25:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: filter: admv8818: fix range calculation
Message-ID: <20250308172535.7b75359d@jic23-huawei>
In-Reply-To: <Z8hKbxWT--0lMHao@65YTFL3.secure.tethers.com>
References: <20250225134612.577022-1-sam.winchenbach@framepointer.org>
	<20250304235502.4d0342a1@jic23-huawei>
	<Z8hKbxWT--0lMHao@65YTFL3.secure.tethers.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 07:58:23 -0500
Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:

> On Tue, Mar 04, 2025 at 11:55:02PM +0000, Jonathan Cameron wrote:
> > On Tue, 25 Feb 2025 08:46:11 -0500
> > Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:
> > 
> > Hi Sam,
> > 
> > Various comments inline.
> > 
> > Jonathan
> > 
> >   
> > > Corrects the upper range of LPF Band 4 from 18.5 GHz to 18.85 GHz per
> > > the ADMV8818 datasheet  
> > This feels like a first fix...  
> 
> Agreed. This should be broken out. For discussion let's call this PATCH_1.
> 
> > > 
> > > Search for the minimum error while ensuring that the LPF corner
> > > frequency is greater than the target, and the HPF corner frequency
> > > is lower than the target
> > > 
> > > This fixes issues where the range calculations were suboptimal.  
> > This feels like a 2nd one.  Maybe two patches appropriate.
> >  
> 
> Agreed. For discussion let's call this PATCH_2.
> 
> > > 
> > > Add two new DTS properties to set the margin between the input frequency
> > > and the calculated corner frequency  
> > And this feels like a feature.  So 3rd patch that we don't necessarily
> > backport.  For earlier stages we just use the default values that
> > you have in the binding.
> >  
> 
> Hmm. This is interesting.  I propose that PATCH_1 is a fix, and both PATCH_2 and this DTS change are treated as a feature. The reason I am suggesting this is that PATCH_2 changes the behavior of the corner frequency and if we backport that then some users may find that their devices no longer function as they used to. Another way of saying this is that PATCH_2 really should include the DTS changes for those users that depended on the old corner calculation algorithm. Does this sound reasonable?

Sure. I'm fine going with your judgement on what is a fix and what isn't.

Jonathan

>  
> > > 
> > > Below is a generated table of the differences between the old algorithm
> > > and the new. This is a sweep from 0 to 20 GHz in 10 MHz steps.  
> > 
> > So, these are just the entries where the 3db point changes?
> > All the others are same?
> >   
> 
> With a 10 MHz resolution, yes. It was an attempt to show that if the user selected a corner frequency that in many cases there was a better option. The code, as it exists, uses the same algortihm for finding the corner frequency when in either manual or auto mode - There are two problems with this approach:
> 1. If you are using manual mode, you can't select a specific corner frequency without subtracting 1 from your target frequency. This highlights problem number 2.
> 2. If you are in automatic mode and your fundamental frequency is 1 Hz below a corner - that corner will be selected. This will efectively put the corner frequency/3db point at the fundamental frequency. This will cut your signal power in half.
> 
> Perhaps there is a better way to show this? Conveying this without images is challenging.

Agreed.  Ascii art is always an option but obviously limited.

> 
> Here is an example of where both algorithms agree (1 Hz resolution):
> freq = 1750000001 Hz, 3db: 1750000000 (old algorithm) => 1750000000 (new algorithm) Hz
> 
> Note that if the user is in `auto` mode then the corner frequency will be put almost exactly on their fundamental frequency.
> The same will happen with the new algorithm, but the user has the ability to select a minimum margin using DTS.
> 

> > Multiline comment in IIO (and most of kernel for that matter) is
> > /*
> >  * This...
> >  
> 
> Shoot, I figured check_patch would have caught that. Noted for v5

Unfortunately it's not a consistent requirement across the kernel.
networking still likes the style you used I think.


> > > @@ -242,16 +280,28 @@ static int admv8818_lpf_select(struct admv8818_state *st, u64 freq)
> > >  static int admv8818_rfin_band_select(struct admv8818_state *st)
> > >  {
> > >  	int ret;
> > > +	u64 hpf_corner_target, lpf_corner_target;
> > >  
> > >  	st->cf_hz = clk_get_rate(st->clkin);
> > >  
> > > +	// Check for underflow  
> > 
> > No C++ style comments in IIO code.  This is just a consistency thing rather than
> > really matter. We have lots of code that predates those being at all acceptable
> > in the kernel and a mixture of the two styles is messy!
> >  
> 
> Bugger. check_patch failed me again :)
> Noted. I will go through and address all comments to make sure they fit the style.  

Likewise, not a hard rule in all of the kernel.

> 
> > > +	if (st->cf_hz > st->hpf_margin_hz)

> > 	st->lpf_margin_hz = 0;
> > 	device_property_read_u64(...)
> > 
> > and no explicit error checking.
> > 
> > If you really want to retain the protection against wrong formats etc, then fair enough.  
> 
> My only concern that the user will have no feedback that his or her filter settings are not being used which could lead to subtle, hard to track down frequency responses. Would it be more appropriate here to print a warning instead of returning an error?

Just stick to an error. I'd hope they test enough to know their
DT is broken even without the error messages but i guess maybe not.

Jonathan
  


