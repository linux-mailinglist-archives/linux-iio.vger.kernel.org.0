Return-Path: <linux-iio+bounces-15989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C71A413E0
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 04:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73CE1891EFB
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 03:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA59219F11F;
	Mon, 24 Feb 2025 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpEcIqG2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5DB157A5C;
	Mon, 24 Feb 2025 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740366475; cv=none; b=TOSogWMiFAadTTqT24NPLvqBmXn0f4tREoYo7KdfxOxcW80aG2dzEqj+fFiuAqzgRpioVRbTatmy/ZmZLR5UYudu1g0AOEaq9ifQJIe3pZa81cCZA6qj3CuFP9m4DpdGHy7h8Cbt8Z+aQnlwex2tljCPRhvZ0MEmDJm5iGMYEug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740366475; c=relaxed/simple;
	bh=Ba3wMsdsMZt4q0+MdOQd3tGZpmRW5h3c/acmhZctCSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwrucgE41uyE//RTQBB3Tfww3zdOfLjuPXH8k2tnViNq6EB4g28+LIYQi3bvKDvA/6wc+XykjWX2a5P46wdkg3+mb9WthwQ7FhZBwuL3TNhx6tb4KpUVv/HIR+JM0s6b2hgPnrWk3rPifaiiM9XZx3v3GbRkyZFfQFxYoV51LvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpEcIqG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E53DC4CEDD;
	Mon, 24 Feb 2025 03:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740366475;
	bh=Ba3wMsdsMZt4q0+MdOQd3tGZpmRW5h3c/acmhZctCSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpEcIqG2zo2PySpCB2ecwND0bLf3YDv19Z47qbF4Kb68l5SU0LTrKOmqNUw/GhMeY
	 Ueeyf3/B/s0+KG+uRb5tPlLt/ddF+0hHBXzb7L0K7YLcc7SE7sh/QQc67RGuDk9dLw
	 owDmBIAgqVw6FlN8F2+1NFRP12DJBvcdu9qGxMj+rjcFE0SR02HzqLVu+ff9EUiV5g
	 Y40i1uT9KIVYoVHMZjqF9Ig/e2zjoCiu0IYP34LgSfcEKj7ImNLXtK8iCGtsJ4GVBn
	 o04oaGim9Osi8DkBzGqUQxDrqBF4HrCnL4A1zAvTNbt+/ooHRU9Lwq9VMw9u0Okh2G
	 l3XpDnrc8MK3g==
Date: Mon, 24 Feb 2025 12:07:48 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Dharma.B@microchip.com
Subject: Re: [PATCH v4 0/2] microchip-tcb-capture: Add Capture, Compare,
 Overflow etc. events
Message-ID: <Z7vihBqOgP3fBUVq@ishi>
References: <20250211151914.313585-3-csokas.bence@prolan.hu>
 <Z7h0AXV1zlgp9Nw-@ishi>
 <8fb9f188-3065-4fdc-a9f1-152cc5959186@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Tmqyh1uo1sTZuwD"
Content-Disposition: inline
In-Reply-To: <8fb9f188-3065-4fdc-a9f1-152cc5959186@prolan.hu>


--/Tmqyh1uo1sTZuwD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 03:14:44PM +0100, Cs=F3k=E1s Bence wrote:
> On 2025. 02. 21. 13:39, William Breathitt Gray wrote:
> > First, register RC seems to serve only as a threshold value for a
> > compare operation. So it shouldn't be exposed as "capture2", but rather
> > as its own dedicated threshold component. I think the 104-quad-8 module
> > is the only other driver supporting THRESHOLD events; it exposes the
> > threshold value configuration via the "preset" component, but perhaps we
> > should introduce a proper "threshold" component instead so counter
> > drivers have a standard way to expose this functionality. What do you
> > think?
>=20
> Possibly. What's the semantics of the `preset` component BTW? If we can
> re-use that here as well, that could work too.

You can find the semantics of each attribute under the sysfs ABI doc
file located at Documentation/ABI/testing/sysfs-bus-counter. For the
`preset` component, its essential purpose is to configure a value to
preset register to reload the Count when some condition is met (e.g.
when an external INDEX/SYNC trigger line goes high).

In the 104-quad-8 module,  the `preset` component is used for a number
of threshold-like purposes; you can see some of the uses by reading the
description of the /sys/bus/counter/devices/counterX/countY/count_mode
attribute. Of relevance to the SAMA5D2, the 104-quad-8 has a mode where
the current Count value is compared against the preset register and an
interrupt is fired when they match (i.e. our Counter THRESHOLD event).

I think it'll be fine to use the preset component to expose the RC
register because the 104-quad-8 already uses the preset component in a
similar fashion; also I would like to keep things simple in this
patchset to avoid the complexities of introducing a new `threshold`
component interface, at least until we get the rest of the capture
functionality in this driver merged.

So for now, use COUNTER_COMP_PRESET() to expose the RC register as a
`preset` component. In the next patchset revision, put this code in its
own patch after the capture components patch, so that we can review the
RC register code separately.

In the same vein, move the uapi header introduction to its own patch.
That will separate the userspace-exposed changes and make things easier
for future users when bisecting the linux kernel history when tracking
down possible bugs.
=20
> > Regarding registers RA and RB, these do hold historic captures of count
> > data so it does seem appropriate to expose these as "capture0" and
> > "capture1". However, I'm still somewhat confused about why there are two
> > registers holding the same sampled CV (or do RA and RB hold different
> > values from each other?). Does a single external line trigger the sample
> > of CV to both RA and RB, or are there two separate external lines
> > triggering the samples independently; or is this a situation where it's
> > a single external line where rising edge triggers a sample to RA while
> > falling edge triggers a sample to RB?
>=20
> It is exactly the latter. And you can configure which edge should sample
> which register; you can also set them to the same edge in which case they
> would (presumably) hold the same value, but as you said, it wouldn't be
> practical.

Ah okay, I think I understand now. Thank you for clarifying.

> > Next, the driver right now has three separate event channels, but I
> > believe you only need two. The purpose of counter event channels is to
> > provide a way for users to differentiate between the same type of event
> > being issued from different sources. An example might clarify what I
> > mean.
>=20
> Yeah true, I could shove the RC compare event to event channel 0. It just
> made more sense to have event channels 0, 1, 2 correspond to RA, RB and R=
C.
> And it's not like we're short on channels, it's a u8, and we have 5 event=
s;
> if we wanted to, we could give each a channel and still have plenty left
> over. I also thought about separating RA capture from channel 0, but I
> figured it would be fine, as you said, the event type would differentiate
> among them.
>=20
> The reason I did not put the RC compare event to channel 0 as well is tha=
t I
> only have the SAMA5D2, and I don't know whether other parts are capable of
> generating other events related to RC, potentially clashing with other
> channel 0 use, if we later decide to support them. One channel per
> event-sourcing register seems like a safe bet; having CV and RA on the sa=
me
> channel still seems to be an acceptable compromise (but again, I don't kn=
ow
> about the other parts' capabilities, so it _might_ still lead to clashes).

I can see your rationale, and I don't have too strong of an opinion
either way, so I'll leave it up to your best judgement. Ultimately, as
you point out we do have a large enough availability of channels that
will accommodate future introductions, which can be abstracted to users
via the uapi header, so we should be fine.

Regarding future additions, I took a look at the Microchip SAMA5D2
datasheet[^1] (is the right document?) and it looks like this chip has
three timer counter channels described in section 54. Currently, the
microchip-tcb-capture module is exposing only one timer counter channel
(as Count0), correct? Should this driver expose all three channels (as
Count0, Count1, and Count2)?

> > Suppose a hypothetical counter device has two independent timers. When
> > either timer overflows, the device fires off a single interrupt. We can
> > consider this interrupt a counter OVERFLOW event. As users we can watch
> > for COUNTER_EVENT_OVERFLOW to collect these events. However, a problem
> > arises: we know an OVERFLOW event occurred, but we don't know which
> > particular timer is the source of the overflow. The solution is to
> > dedicate each source to its own event channel so that users can
> > differentiate between them (e.g. channel 0 are events sourced from the
> > first timer whereas channel 1 are events sourced from the second timer).
> >=20
> > Going back to your driver, there seems to be no ambiguity about the
> > source of the CHANGE-OF-STATE, THRESHOLD, and OVERFLOW events, so these
> > events can all coexist in the same event channel. The only possible
> > ambiguity I see is regarding the CAPTURE events, which could be sourced
> > by either a sample to RA or RB. Given this, I believe all your events
> > could go in channel 0, with channel 1 serving to simply differentiate
> > CAPTURE events that are sourced by samples to RB.
> >=20
> > Finally, you mentioned that this device supports a PWM mode that also
> > makes use of the RA, RB, and RC registers. To prevent globbering the
> > registers when in the wrong mode, you should verify the device is in the
> > counter capture mode before handling the capture components (or return
> > an appropriate "Operation not support" error code when in PWM mode). You
> > don't need to worry about adding these checks for now because it looks
> > like this driver does not support PWM mode yet, but it's something to
> > keep in mind if you do add support for it in the future.
>=20
> The `mchp_tc_count_function_write()` function already disables PWM mode by
> clearing the `ATMEL_TC_WAVE` bit from the Channel Mode Register (CMR).

So capture mode is unconditionally set by mchp_tc_count_function_write()
which means the first time the user sets the Count function then PWM
mode will be disabled. However, what happens if the user does not set
the Count function? Should PWM mode be disabled by default in
mchp_tc_probe(), or does that already happen?

William Breathitt Gray

[^1] https://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf

--/Tmqyh1uo1sTZuwD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ7vihAAKCRC1SFbKvhIj
K0AEAQDJspkJEtu7+1N2PmNO7mzKvaWSEPhzCTQUbAYZILYDYAEAuzh92eO/ENSb
SaJWYNoXvQdyag5Hw+MTo7vm2P7vdA4=
=1lMt
-----END PGP SIGNATURE-----

--/Tmqyh1uo1sTZuwD--

