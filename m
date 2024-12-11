Return-Path: <linux-iio+bounces-13337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C89ED4C6
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 19:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327811888147
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C061C209F31;
	Wed, 11 Dec 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZVesVr+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D3207A34;
	Wed, 11 Dec 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942428; cv=none; b=mHIwU/OSEg27ttqZuMUBZe6gqn9KkeYQ9vCb7Lztw9QQEJ2oeSjdVZqP9YzramnpcrMuK7pAi8/k+RZnfT2B+Gn+IpcEvif413GiQtgJMAO1uAoIcVXw+6nuqz5B330jZCELWaq8vtKtXDVBBkcaVwFBZKAXujLnPOWjy8Z5d+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942428; c=relaxed/simple;
	bh=DD1ATiyq+MUP4nNC0ELhKq9NNjpdIqoXvFhou9QcdcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Luas3odyzzhSIuwVpymlOmpoPZ1DDON94zGnEqJ9k9zVixBmg2qFjPLd7B5vBrZMCRSnuWs9DyDDRrbPtRAH32HruRG55QxJOR3RweW1giGAeAHZZLZ5rYSEynue2mcm5L74hSfAlbC1/m3CC4KAFgSZ3g0u83qhqwuTSC1gMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZVesVr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58C9C4CED2;
	Wed, 11 Dec 2024 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733942427;
	bh=DD1ATiyq+MUP4nNC0ELhKq9NNjpdIqoXvFhou9QcdcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PZVesVr+ITLBfqzci9dF1v6QaeigSH/0aPPowMrJoerulrSrb3x3PjzSz8U58gEYV
	 35TT+D2cioxtGu/g5oF1AMihiYgDeZdfeACtXlKbKuqj+6L1jHD5FIPKHNZQVppO1x
	 2xlIfcuQAT2QsBgywetv5tAeffS6CXwUUJw0N6z8ZFTyev+wmxEqf78uwHLFe4xAHd
	 2TnitdzrR5tjwicPQoeVnMqY1iWpUigvEXtYHanGnzw4Zm+wRZ0t/WoB5FusxPHXXW
	 KIWok87/ZRyfhRD35JTuYz2ZwSXcbf1rpYlQES63xQCrzvgEHB4LTtpe5kvKbTAUeq
	 E2O4aKN32FZhg==
Date: Wed, 11 Dec 2024 18:40:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensor-prox: Merge information from different
 channels
Message-ID: <20241211184018.063e4534@jic23-huawei>
In-Reply-To: <CANiDSCsD2gGBPVaFMU4uhtpWf3dUr4-MA5MpcjZRcLMgBmtjZg@mail.gmail.com>
References: <20241205-fix-hid-sensor-v1-1-9b789f39c220@chromium.org>
	<20241208163851.41c47c3f@jic23-huawei>
	<CANiDSCsD2gGBPVaFMU4uhtpWf3dUr4-MA5MpcjZRcLMgBmtjZg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Dec 2024 21:09:16 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Hi Jonathan
> 
> 
> On Sun, 8 Dec 2024 at 17:39, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Thu, 05 Dec 2024 12:59:20 +0000
> > Ricardo Ribalda <ribalda@chromium.org> wrote:
> >  
> > > The device only provides a single scale, frequency and hysteresis for
> > > all the channels. Fix the info_mask_* to match the reality of the
> > > device.
> > >
> > > Without this patch:
> > > in_attention_scale
> > > in_attention_hysteresis
> > > in_attention_input
> > > in_attention_offset
> > > in_attention_sampling_frequency
> > > in_proximity_scale
> > > in_proximity_sampling_frequency
> > > in_proximity_offset
> > > in_proximity0_raw
> > > in_proximity_hysteresis
> > >
> > > With this patch:
> > > hysteresis
> > > scale
> > > sampling_frequency
> > > in_attention_input
> > > in_attention_offset
> > > in_proximity0_offset
> > > in_proximity0_raw
> > >
> > > Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more channels")
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>  
> >
> > whilst perhaps not ideal use of the ABI, what is there today is not wrong
> > as such.  If the ABI above was all introduce in the recent patch I might
> > be fine adjusting it as you suggestion. However it wasn't, in_proximity_scale
> > has been there a long time so this would be an ABI change.
> > Those are generally only ok if there is a bug.
> >
> > Drivers are always allowed to provide finer granularity than necessary
> > so in this case I don't see this as a bug.  
> 
> Is it ok that changing the attention_sampling frequency the
> proximity_sampling frequency changes as well?
> (Just asking for my own education, not complaining :) )

Yes.  In general the ABI has always had to allow for interactions because
there are lots of non obvious ones between attributes for different channels
as well as those for the same channels.

> 
> Also, what about ?:
> in_attention_scale
> in_attention_hysteresis
> in_attention_input
> in_attention_offset
> in_attention_sampling_frequency
> in_proximity0_scale
> in_proximity0_sampling_frequency
> in_proximity0_offset
> in_proximity0_raw
> in_proximity0_hysteresis
> 
> Would that be acceptable? I think that if we are giving the false
> impression that every sampling frequency is independent we should go
> all the way in. WDYT?

It's indeed far from ideal, but so is changing an ABI we've exposed to
userspace. We definitely can't touch anything in a release kernel but if
there are clear improvements to be made on stuff that we can sort of term
a fix we can maybe get away with it.


> 
> Thanks!
> 
> ps: this patch is in the queue in case you missed it
> https://lore.kernel.org/linux-iio/20241122-fix-processed-v2-1-b9f606d3b519@chromium.org/
It's in patchwork so i'll get to it. Not sure why I haven't applied it, maybe a tree
management thing and lack of time last weekend to check for what was unblocked by
the rebase.  I'll catch up soon.

Jonathan

> 
> That one is a real fix for the driver :)
> 
> >
> > Jonathan
> >
> >  
> > > ---
> > >  drivers/iio/light/hid-sensor-prox.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> > > index e8e7b2999b4c..f21d2da4c7f9 100644
> > > --- a/drivers/iio/light/hid-sensor-prox.c
> > > +++ b/drivers/iio/light/hid-sensor-prox.c
> > > @@ -49,9 +49,11 @@ static const u32 prox_sensitivity_addresses[] = {
> > >  #define PROX_CHANNEL(_is_proximity, _channel) \
> > >       {\
> > >               .type = _is_proximity ? IIO_PROXIMITY : IIO_ATTENTION,\
> > > -             .info_mask_separate = _is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
> > > -                                   BIT(IIO_CHAN_INFO_PROCESSED),\
> > > -             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |\
> > > +             .info_mask_separate = \
> > > +             (_is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
> > > +                             BIT(IIO_CHAN_INFO_PROCESSED)) |\
> > > +             BIT(IIO_CHAN_INFO_OFFSET),\
> > > +             .info_mask_shared_by_all = \
> > >               BIT(IIO_CHAN_INFO_SCALE) |\
> > >               BIT(IIO_CHAN_INFO_SAMP_FREQ) |\
> > >               BIT(IIO_CHAN_INFO_HYSTERESIS),\
> > >
> > > ---
> > > base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > > change-id: 20241203-fix-hid-sensor-62e1979ecd03
> > >
> > > Best regards,  
> >  
> 
> 


