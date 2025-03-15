Return-Path: <linux-iio+bounces-16870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB5A63158
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4834189314A
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DEA204C35;
	Sat, 15 Mar 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQWGdM26"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B10204F8C;
	Sat, 15 Mar 2025 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742062509; cv=none; b=msRsg0/282Te9SQ/ErY32VCqOFDX0y8cLS5H/LoZ3AJWt/uDsHDVRTkeugA4gnvrqezTcGvvy/S7y8Nm5o+1NXK/Iq9gwMyVcnpLgT8Y4vxMbwLqWlAs7Ctatnu3GT3jjQDnX2ZrapjEgyGQqBV0k4wHCjr8UhpS9ARbjwzpC58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742062509; c=relaxed/simple;
	bh=0rV5Mefa2Roe82MtrfOgwhXvRd/JrjMahcExnemSFno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7hBxk0gTkdZelCd2Rwqqv7NM/GFXhzbTLqorqnbO6HWofn87uhFbbQ3XGXQB8FJrIGfSkyT26k9zVnCziTeMWJcCeXRBs3pV+uquza5rhkhavJHSoRVI/qXOtX0Yeesp6YuSCkswzoNpCXXWNcLTaWzqfP5hWIRjvVQ2M5Pzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQWGdM26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D5EC4CEE5;
	Sat, 15 Mar 2025 18:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742062508;
	bh=0rV5Mefa2Roe82MtrfOgwhXvRd/JrjMahcExnemSFno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OQWGdM26thnDsFacwa0gai8PBvRQQ7YNxIPkBQaWRhOCDBUG4X8srE6/KB4FraDzu
	 /s+FExoZ8mOScMjsXCQKspmmdbuO7A20WDFqdhwcY6zikHl2yyOTWPyJhw7KkZaG4C
	 uyHux4qT3LTyW0k6r0T6p5RLTOIxg2cMXwmhLHTNwlF/JWWxaQ6J38Wor362y+t6wp
	 pdSHK8uzrhyFk5l0pG/vu/OxuoN8WudFjZHcK3MAtLapehz2s5LKBD0BQLQQqeyeEK
	 Oh/QPXPGpQzWKjsCC58K/XqdxL+43734ePro+XYKljEuxdz5StwNa+LAhJy0dAY9Tz
	 eBmBpu9kadN5A==
Date: Sat, 15 Mar 2025 18:15:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ad7380: add support for SPI offload
Message-ID: <20250315181500.588512ea@jic23-huawei>
In-Reply-To: <177eb738-fe13-43ae-a02a-7c6b026536ef@baylibre.com>
References: <20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com>
	<7b64c6a9-0606-45ba-be45-7ae11c4fdf39@baylibre.com>
	<177eb738-fe13-43ae-a02a-7c6b026536ef@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 15:03:43 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 2/22/25 11:31 AM, David Lechner wrote:
> > On 2/20/25 12:03 PM, Angelo Dureghello wrote:  
> >> From: Angelo Dureghello <adureghello@baylibre.com>
> >>
> >> Add support for SPI offload to the ad7380 driver. SPI offload allows
> >> sampling data at the max sample rate (2MSPS with one SDO line).
> >>
> >> This is developed and tested against the ADI example FPGA design for
> >> this family of ADCs [1].
> >>
> >> [1]: http://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html
> >>
> >> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> >> ---  
> >   
> 
> ...
> 
> >> +#define _AD7380_OFFLOAD_CHANNEL(index, bits, diff, sign, gain) {		\
> >> +	.type = IIO_VOLTAGE,							\
> >> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |                          \
> >> +		((gain) ? BIT(IIO_CHAN_INFO_SCALE) : 0) |			\
> >> +		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),			\
> >> +	.info_mask_shared_by_type = ((gain) ? 0 : BIT(IIO_CHAN_INFO_SCALE)) |   \
> >> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
> >> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\  
> > 
> > Not sure if this is worth troubling with, but it might make more sense to make
> > IIO_CHAN_INFO_SAMP_FREQ info_mask_separate instead of info_mask_shared_by_type,
> > at least in the case of the single-ended chips.
> > 
> > This family of chips does simultaneous conversions so shared_by_type (or shared_by_all)
> > would typically be the right thing to do here. However, the single-ended versions
> > of these chips also have a multiplexer, so there are 2 banks of simultaneously
> > sampled inputs. So the effective sample rate as far as IIO is concerned would
> > actually be 1/2 of the sampling_frequency attribute value.
> > 
> > Since we have a channel mask restriction where we force all channels in a bank
> > to be enabled at once, I think it would work to make IIO_CHAN_INFO_SAMP_FREQ
> > info_mask_separate where the reported sampling frequency is the conversion rate
> > divided by the number of channels in a bank.


> >   
> 
> Hi Jonathan,
> 
> You might have missed this since v2 was sent before you had a chance to review
> v1. I am testing the chip with the mux now, so I was curious if you had any
> wisdom to add here. The way we implemented it feels a little odd to me with
> sampling_frequency as info_mask_shared_by_type instead of info_mask_separate
> or info_mask_shared_by_all like on most other chips I've worked with so far.

I saw the message and decided not to comment as I'd not really had
time to think about it.

There is a messy corner here with the forced enabling that might bite us in
future that I've not really thought about before.  It would give a non-intuitive
result.

If we had that situation for a non SPI offload case (i.e. going through the
iio_push_to_buffers* path (not sure if we do) then the driver might enable multiple
channels when only one is turned on by userspace and where userspace then
mysteriously sees half the frequency of what it expects. In that case the
only scheme that I think works is to do shared_by_all and have it update depending
on underlying enabled channels.

Not sure that applies here or not though.  It is definitely always valid to
do a single attribute sampling_frequency, if that reflects how often we get
a full scan.  It may not provide as much information or fine grained enough
control in some cases though.  We have support for more complex sequencers that
leave gaps where this is the only option. I.e. they take all N channels in
a burst then sleep for P usecs before doing it again.  

I've wondered a few times if we should describe the sampling points in
a scan in some fashion. Would anything use that info?  It wouldn't help
for control though as the constraints would be too hard to describe
for anything other than read only report of what is configured.

There are really fun devices with say 2 simultaneous sampling ADCs that can
measure any of X channels (including in theory the same one). When a complex
sequencer is present or we have software based sequencing, then that gets
really hard to describe.

Jonathan

> 
> I found a bug in this series that I need to send a fix for, so if we decide
> there is a better way here, now would be a good time to do it.
> 
> >> +	.info_mask_shared_by_type_available =					\
> >> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
> >> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\
> >> +	.indexed = 1,                                                           \
> >> +	.differential = (diff),                                                 \
> >> +	.channel = (diff) ? (2 * (index)) : (index),                            \
> >> +	.channel2 = (diff) ? (2 * (index) + 1) : 0,                             \
> >> +	.scan_index = (index),                                                  \
> >> +	.has_ext_scan_type = 1,                                                 \
> >> +	.ext_scan_type = ad7380_scan_type_##bits##_##sign##_offload,            \
> >> +	.num_ext_scan_type =                                                    \
> >> +		ARRAY_SIZE(ad7380_scan_type_##bits##_##sign##_offload),		\
> >> +	.event_spec = ad7380_events,                                            \
> >> +	.num_event_specs = ARRAY_SIZE(ad7380_events),                           \
> >> +}
> >> +  
> 


