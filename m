Return-Path: <linux-iio+bounces-14127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2842AA0A3A1
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 13:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00512188A911
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 12:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A6D19DF98;
	Sat, 11 Jan 2025 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="civnTNW/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36644192B60;
	Sat, 11 Jan 2025 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736599478; cv=none; b=O0c4IAjJFd/3B2eNp+JwJe5/o2lugA/I/1QgTASClkCKdcI7iVR/pC1Nt2DzSOj453d7ASqicPc5QeJ1AFdlOFLErKV+BKBKcgz9ZMRVWAweWrUupF7/uv4U9OcUyU/+eGE3QrfzR4s5H0SaOvA4u7B4ign/8PPx4KB4OuZCU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736599478; c=relaxed/simple;
	bh=tQcVwlo2u3//JG8JQtOodY8LIoRtg90t3uirSSRjluc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEKc5mBy0gicZF+9ZnFUcCp69P/XBvyx67AJBcIuQYV7cA+TZqT08r98mLEULbmRK0BJBxZwXIcUDxnN8H6A+6uB/xXhDyk9LgGWGBAOkmvCA1RJghZDZRk6qmf2teH9LLkaysmkMTTdzze2yq8GreHXV716AM5K5RXOvKhNTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=civnTNW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4620CC4CED2;
	Sat, 11 Jan 2025 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736599477;
	bh=tQcVwlo2u3//JG8JQtOodY8LIoRtg90t3uirSSRjluc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=civnTNW/4yOV4xUOGYZD972N+8E8Oc6E8yMB4WiCTtlrChn6U33F08S6Gz7RkBXaS
	 kZXdzCweZihsU7cpG3JJOtNQwIunpVwoU7A66Okxb14EC4G2Ri/7VbQ+zwHSEoG6nI
	 znRFtXnTE1EqFoWnf9+0VrnFV4DwfXGmCOSyxZ6Uveh7VfLV7kWI/4Omv16W1NgTmH
	 sMiXgFAstlGJugsVaBwQbMN5p/79fEqJygwK2bZYC7PYEPJ6e/hSPygo2oHWDwXXR7
	 cSvjw4SaJ+GpNC/IEbeyn+YiFZiZ+PwnUiI3U4XlRTNZQ1bJE8IpV/ZwDqIC5cO1g+
	 04jYfz5ctYLuQ==
Date: Sat, 11 Jan 2025 12:44:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: hid-sensor-prox: Split difference from multiple
 channels
Message-ID: <20250111124428.4cb4d0d8@jic23-huawei>
In-Reply-To: <CANiDSCvkKX68UqSuKiGiys8nwm5BX-FbKmHPtxJK=Hh=B4RqZQ@mail.gmail.com>
References: <20241216-fix-hid-sensor-v2-1-ff8c1959ec4a@chromium.org>
	<20241219171718.2af17d6d@jic23-huawei>
	<CANiDSCvkKX68UqSuKiGiys8nwm5BX-FbKmHPtxJK=Hh=B4RqZQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 10:17:27 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Hi Jonathan
> 
> Happy new year!
> 
> Friendly ping about this patch so we can change the ABI before the
> kernel release happens

We might not quite make that :(  Srinivas, Jiri I'm looking for your
input on this.

I'm fine with us taking this as a fix that goes into an early point
release on basis only crazy people base products on a version that hasn't
gotten the fixes that inevitably only go in a few weeks later.

Jonathan

> 
> On Thu, 19 Dec 2024 at 18:17, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 16 Dec 2024 10:05:53 +0000
> > Ricardo Ribalda <ribalda@chromium.org> wrote:
> >  
> > > When the driver was originally created, it was decided that
> > > sampling_frequency and hysteresis would be shared_per_type instead
> > > of shared_by_all (even though it is internally shared by all). Eg:
> > > in_proximity_raw
> > > in_proximity_sampling_frequency
> > >
> > > When we introduced support for more channels, we continued with
> > > shared_by_type which. Eg:
> > > in_proximity0_raw
> > > in_proximity1_raw
> > > in_proximity_sampling_frequency
> > > in_attention_raw
> > > in_attention_sampling_frequency
> > >
> > > Ideally we should change to shared_by_all, but it is not an option,
> > > because the current naming has been a stablished ABI by now. Luckily we
> > > can use separate instead. That will be more consistent:
> > > in_proximity0_raw
> > > in_proximity0_sampling_frequency
> > > in_proximity1_raw
> > > in_proximity1_sampling_frequency
> > > in_attention_raw
> > > in_attention_sampling_frequency
> > >
> > > Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more channels")
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>  
> >
> > I got lost somewhere in the discussion.  This is still an ABI change compared
> > to original interface at the top (which is the one that has been there
> > quite some time).
> >
> > However we already had to make one of those to add the index that wasn't there
> > for _raw. (I'd missed that in earlier discussion - thanks for laying out the
> > steps here!)  Srinivas, Jiri, do you think we are better off just assuming users
> > of this will be using a library that correctly deals with sharing and just
> > jump to
> > in_proximity0_raw
> > in_proximity1_raw
> > in_attention_raw
> > (should have indexed that but it may never matter) and
> > sampling_frequency
> >
> > Which is what I think Ricardo originally asked.
> >
> > Do we have any guarantee the sampling_frequency will be shared across the
> > sensor channels?  It may be the most common situation but I don't want to
> > wall us into a corner if it turns out someone runs separate sensors at
> > different rates (no particularly reason they should be one type of sensor
> > so this might make sense).  If we don't have that guarantee
> > then this patch is fine as far as I'm concerned.
> >
> > Jonathan
> >
> >
> >  
> > > ---
> > > Changes in v2:
> > > - Use separate
> > > - Link to v1: https://lore.kernel.org/r/20241205-fix-hid-sensor-v1-1-9b789f39c220@chromium.org
> > > ---
> > >  drivers/iio/light/hid-sensor-prox.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> > > index c83acbd78275..71dcef3fbe57 100644
> > > --- a/drivers/iio/light/hid-sensor-prox.c
> > > +++ b/drivers/iio/light/hid-sensor-prox.c
> > > @@ -49,9 +49,10 @@ static const u32 prox_sensitivity_addresses[] = {
> > >  #define PROX_CHANNEL(_is_proximity, _channel) \
> > >       {\
> > >               .type = _is_proximity ? IIO_PROXIMITY : IIO_ATTENTION,\
> > > -             .info_mask_separate = _is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
> > > -                                   BIT(IIO_CHAN_INFO_PROCESSED),\
> > > -             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |\
> > > +             .info_mask_separate = \
> > > +             (_is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
> > > +                             BIT(IIO_CHAN_INFO_PROCESSED)) |\
> > > +             BIT(IIO_CHAN_INFO_OFFSET) |\
> > >               BIT(IIO_CHAN_INFO_SCALE) |\
> > >               BIT(IIO_CHAN_INFO_SAMP_FREQ) |\
> > >               BIT(IIO_CHAN_INFO_HYSTERESIS),\
> > >
> > > ---
> > > base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
> > > change-id: 20241203-fix-hid-sensor-62e1979ecd03
> > >
> > > Best regards,  
> >  
> 
> 


