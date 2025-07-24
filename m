Return-Path: <linux-iio+bounces-21980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0ACB10BDC
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC5C87B5752
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4299D2DA757;
	Thu, 24 Jul 2025 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrRHwbsv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71C2D6614;
	Thu, 24 Jul 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364965; cv=none; b=sNZo4dyfZ85OtYdRo7TP2d27/Nkh6Hv/pcwkSGENruN7howaQbi4IhGf0IqSvVGPwZcq7CdwNGSgsMyFXbdNrwJOALGn1FJBm1MwxMnox7XgSHv+oxAIplDi284evUh2jdn+0PMBvqLbEVq3j+jr5WBkoEyR03xrXabZZ9wPfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364965; c=relaxed/simple;
	bh=C+VK9E45zhavmmZ7zZic1kk5tDmpgiK9enCL/Nt6HJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPB66f+9jGPIJbztIDv/6sxpuWkTthwyqOuIa1FPR4gPirUQkzW8eOJUpp1oL1sHBsa6yi3bFZznfJ2SIhkEc3OJyhJ9k+wXeNlsZCKDGno/j2lup+WtgB9/7MoswUR1JPUpr4hdBHYLLPMrffpHIOHG+qWCj7kwi/+jHQAjZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrRHwbsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85087C4CEED;
	Thu, 24 Jul 2025 13:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753364964;
	bh=C+VK9E45zhavmmZ7zZic1kk5tDmpgiK9enCL/Nt6HJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rrRHwbsvmewjuO2ODNtc+AEDzbQmkZsspvR0lgt22HLbV72077LKMYJGX6N9SYQzv
	 tEoOom6onnC92EgJrJsjklwRNA/6swPlLgGR+YD6ElI1ggekTURly1ra10+fPAagIG
	 c3WZftDOL/IfhCaqUdlvL1jVs2vD2xd6ZCkYcZI1aHqvaji7sFsB7CwsTW2w1FOB5r
	 Px+MvvORNXGm08eSC+VF+F0L/ehJaP7OSBRRSUZOdZkpZMZkwmPCxrYv+NI4hcIdy7
	 /lE4WqXD39vBvdp6NoO9zSmi+87F9d2XW1O6+9haPIlDEWzmzUbHOemlP5uIVZLkpa
	 KwV1Y2wxeDVag==
Date: Thu, 24 Jul 2025 14:49:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, Greg KH <greg@kroah.com>, Arnd Bergmann
 <arnd@arndb.de>, David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Jonathan Santos
 <Jonathan.Santos@analog.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, linux-iio@vger.kernel.org
Subject: Re: linux-next: manual merge of the iio tree with the spi tree
Message-ID: <20250724144916.436a29b3@jic23-huawei>
In-Reply-To: <20250721125545.6db07df5@canb.auug.org.au>
References: <20250703163824.2f08d866@canb.auug.org.au>
	<20250703093122.00000684@huawei.com>
	<b0b0443d-143f-4e41-b8b8-91c6726e838f@baylibre.com>
	<20250706115053.368ce9e9@jic23-huawei>
	<ca0be466-6673-425d-97ab-292791253a63@baylibre.com>
	<20250721125545.6db07df5@canb.auug.org.au>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 12:55:45 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Sun, 6 Jul 2025 11:15:14 -0500 David Lechner <dlechner@baylibre.com> wrote:
> >
> > On 7/6/25 5:50 AM, Jonathan Cameron wrote:  
> > > On Thu, 3 Jul 2025 07:28:07 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >     
> > >> On 7/3/25 3:31 AM, Jonathan Cameron wrote:    
> > >>> On Thu, 3 Jul 2025 16:38:24 +1000
> > >>> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >>>       
> > >>>> Today's linux-next merge of the iio tree got a conflict in:
> > >>>>
> > >>>>   MAINTAINERS
> > >>>>
> > >>>> between commit:
> > >>>>
> > >>>>   e47a324d6f07 ("dt-bindings: trigger-source: add ADI Util Sigma-Delta SPI")
> > >>>>
> > >>>> from the spi tree and commit:
> > >>>>
> > >>>>   0dd88eaa7126 ("dt-bindings: trigger-source: add generic GPIO trigger source")
> > >>>>
> > >>>> from the iio tree.
> > >>>>
> > >>>> I fixed it up (see below) and can carry the fix as necessary. This
> > >>>> is now fixed as far as linux-next is concerned, but any non trivial
> > >>>> conflicts should be mentioned to your upstream maintainer when your tree
> > >>>> is submitted for merging.  You may also want to consider cooperating
> > >>>> with the maintainer of the conflicting tree to minimise any particularly
> > >>>> complex conflicts.
> > >>>>      
> > >>> Thanks Stephen,
> > >>>
> > >>> David, do you prefer these merged or kept as separate entries?      
> > >>
> > >> Ah, shoot, I forgot that we had added the gpio one and just made
> > >> one section like this.
> > >>
> > >> I think it would make sense to also merge the new adi one with
> > >> the reset to keep things compact.
> > >>    
> > > Is there a path to do that cleanly given the multiple trees things are
> > > coming from?  Maybe this is a let things resolve whatever way this cycle
> > > and tidy up next?    
> > 
> > Agree, waiting seems the simplest option.
> >   
> > >     
> > >>>
> > >>> I don't think it matters either way in practice though this is the
> > >>> more complex merge (the other being just putting the blocks in order.
> > >>>
> > >>> We can put a note in the pull request on preference but ultimately Linus
> > >>> will resolve this however he prefers! 
> > >>>
> > >>> Jonathan
> > >>>
> > >>>       
> > >>>> -- 
> > >>>> Cheers,
> > >>>> Stephen Rothwell
> > >>>>
> > >>>> diff --cc MAINTAINERS
> > >>>> index dd764b947dab,d0809d62ff48..000000000000
> > >>>> --- a/MAINTAINERS
> > >>>> +++ b/MAINTAINERS
> > >>>> @@@ -25333,19 -25201,15 +25341,20 @@@ TRADITIONAL CHINESE DOCUMENTATIO
> > >>>>   M:	Hu Haowen <2023002089@link.tyut.edu.cn>
> > >>>>   S:	Maintained
> > >>>>   W:	https://github.com/srcres258/linux-doc
> > >>>>  -T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
> > >>>>  +T:	git https://github.com/srcres258/linux-doc.git doc-zh-tw
> > >>>>   F:	Documentation/translations/zh_TW/
> > >>>>   
> > >>>> + TRIGGER SOURCE
> > >>>> + M:	David Lechner <dlechner@baylibre.com>
> > >>>> + S:	Maintained
> > >>>> + F:	Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
> > >>>> + F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
> > >>>> + 
> > >>>>  +TRIGGER SOURCE - ADI UTIL SIGMA DELTA SPI
> > >>>>  +M:	David Lechner <dlechner@baylibre.com>
> > >>>>  +S:	Maintained
> > >>>>  +F:	Documentation/devicetree/bindings/trigger-source/adi,util-sigma-delta-spi.yaml
> > >>>>  +
> > >>>> - TRIGGER SOURCE - PWM
> > >>>> - M:	David Lechner <dlechner@baylibre.com>
> > >>>> - S:	Maintained
> > >>>> - F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
> > >>>> - 
> > >>>>   TRUSTED SECURITY MODULE (TSM) INFRASTRUCTURE
> > >>>>   M:	Dan Williams <dan.j.williams@intel.com>
> > >>>>   L:	linux-coco@lists.linux.dev      
> 
> This is now a conflict between the char-misc tree and the spi tree.

Ah. Sorry Greg, I meant to mention this in the pull request.
In earlier discussion we concluded that best bet was to let it resolve as
separate entries (as Stephen has) and then we'll clean it up next cycle
if it makes sense to unify more of them.

Thanks Stephen for dealing with our mess!

Jonathan

> 


