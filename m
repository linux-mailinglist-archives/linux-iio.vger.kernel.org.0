Return-Path: <linux-iio+bounces-19039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991DEAA8736
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D5F177955
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75CA1581EE;
	Sun,  4 May 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUUMNi6Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9292DC799;
	Sun,  4 May 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746371086; cv=none; b=iLRBfJLdMKCx21uLFy9FCZ9UWUqamT+58Z1oFGB8in7PQSSM3lE+5qpgcoJWcLdT5Rpgij9t3pB0K+k6GfhK2wEpOex5T7aQi/R1Ks+WBJuJ3QaXLtRWzmFnhxPpRbcwEVvskIJC0TDQToOXa49oOI37MmiIw9c5kPtc0C5kUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746371086; c=relaxed/simple;
	bh=2EfXC6JzwMjtzR1Uhw+hjMRWBxN9P0Ufuf+HDxP31Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6iICCq9jV1wqDlahNpqYx8/CCpMUXHUNHxuY/cZtuv+61VaP+sKyTPyc0YKROUxfQvP0y32HWdov9/CqMvrFpmji+6SZmIY/+gBQQXBCHRG2+T5uKmsmOvI+CrKpCqgPVnHYdhEZnIk+Yd263XHRQCCOfReuif+uQtvodpdjrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUUMNi6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308F5C4CEE7;
	Sun,  4 May 2025 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746371086;
	bh=2EfXC6JzwMjtzR1Uhw+hjMRWBxN9P0Ufuf+HDxP31Rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PUUMNi6Z3UyrhM47ffRfQX4WY5hLtx+2C9Ri1CeNCyvuCcQjTMwCozr7an9PS4/OY
	 8CAuly4ACDcsZ2ww6fG4XSyE6ShUesWlckac8OicetDh6fViZIF+zYXiq6K8vpy9oE
	 6A7G4yzTsIvZ+TIIuDZFpZgJbY9jBwEND1nbXCvs/IQOfY3tCLmv/AXhx8nPSnHGXZ
	 on8XEZjwnTnMw4XZgtyd0/vi3NWDkn3NqUJBTLdu/t+g0NRSezojQHzQeMtnjwgUIa
	 Z0+5sJhDu5SXfKQsV6GTEgOtDXvobIuwbrjr//dYilNZ5Ht4eOARjsgSXAaGOJy5KB
	 iNerrcUcg4zGg==
Date: Sun, 4 May 2025 16:04:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] Documentation: ABI: IIO: add calibphase_delay
 documentation
Message-ID: <20250504160437.33116d5a@jic23-huawei>
In-Reply-To: <0c7e4efc-7c2a-46ac-b970-4134c386bc71@baylibre.com>
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
	<20250429-wip-bl-ad7606-calibration-v1-1-eb4d4821b172@baylibre.com>
	<4645ae3e0c3bb1ada9d4cadce77b64fe5e651596.camel@gmail.com>
	<070b269c-c536-49c5-a11d-7e23653613f9@baylibre.com>
	<aBI3eUPirZEXpZgG@smile.fi.intel.com>
	<896023ae-c279-4201-a7a8-dfd9b33fe0e5@baylibre.com>
	<7fe18625-3a25-40c8-bfb7-a7a22a3eccff@baylibre.com>
	<jvhwdzmruov3je7qvsncn4naxg2cbbset27vr6tfjl3fumw7es@v3ho7m6iwaqp>
	<0c7e4efc-7c2a-46ac-b970-4134c386bc71@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 1 May 2025 09:44:51 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/1/25 7:33 AM, Angelo Dureghello wrote:
> > On 30.04.2025 10:04, David Lechner wrote: =20
> >> On 4/30/25 9:56 AM, David Lechner wrote: =20
> >>> On 4/30/25 9:45 AM, Andy Shevchenko wrote: =20
> >>>> On Wed, Apr 30, 2025 at 09:21:28AM -0500, David Lechner wrote: =20
> >>>>> On 4/30/25 12:40 AM, Nuno S=C3=A1 wrote: =20
> >>>>>> On Tue, 2025-04-29 at 15:06 +0200, Angelo Dureghello wrote: =20
> >>>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
> >>>>>>>
> >>>>>>> Add new IIO calibphase_delay documentation.
> >>>>>>>
> >>>>>>> The delay suffix is added to specify that the phase, generally in
> >>>>>>> radiants, is for this case (needed from ad7606) in nanoseconds. =
=20
> >>>>
> >>>> ...
> >>>> =20
> >>>>>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibphase_d=
elay =20
> >>>>>>
> >>>>>> Not sure if I'm too convinced on the _delay suffix
> >>>>>> =20
> >>>>> Phase is measured in radians, not seconds, so it seems wrong to use=
 it here.
> >>>>>
> >>>>> https://en.wikipedia.org/wiki/Phase_(waves)
> >>>>>
> >>>>> And the delay here is with respect to individual samples in a simul=
taneous
> >>>>> conversion without regard for a sampling frequency, so I don't see =
how we could
> >>>>> convert the time to radians in any meaningful way. =20
> >>>>
> >>>> And how this delay is aplicable to the phase in the hardware? Sounds=
 to me that
> >>>> HW has some meaningful way of such a conversion?
> >>>> =20
> >>>
> >>> It is a calibration to account for a phase difference between two inp=
ut signals.
> >>> This is a simultaneous sampling ADC, so all channels normally sample =
at exactly
> >>> the same time. This phase delay calibration factor can introduce a sm=
all delay
> >>> on an individual channel so that it starts it's conversion some micro=
seconds
> >>> after the others.
> >>>
> >>> There is a nice diagram here:
> >>>
> >>> https://www.analog.com/media/en/technical-documentation/data-sheets/a=
d7606c-18.pdf#%5B%7B%22num%22%3A113%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%2=
2XYZ%22%7D%2C34%2C594%2C0%5D
> >>>
> >>> To convert the phase delay to a phase angle and back would require al=
so knowing
> >>> the frequency of the input voltage signals. =20
> >>
> >> Maybe calling it "conversion delay" would make more sense? Since the p=
hase part
> >> of it is really referring to the application rather than to what we ar=
e actually
> >> adjusting. =20
> >=20
> > Are there examples of a phase calibration in iio ? Becouse apply a radi=
ans=20
> > calibration seems complicated and maybe non approrpiate for non-periodi=
c=20
> > signals as often used in real world applications.
> >=20
> > So another viable idea could be to use a IIO_CHAN_INFO_CALIBDELAY inste=
ad.
> >=20
> > Regards,
> > angelo =20
>=20
> I was looking at the datasheet on another ADC that popped up on the maili=
ng list
> today. https://www.ti.com/product/ADS1262
>=20
> It has a "conversion delay" register that does basically the same thing. =
So I'm
> liking that name even more now. Just calling it "delay" seems a bit too v=
ague.
> We could make it IIO_CHAN_INFO_CALIBCONV_DELAY to try to keep it shorter.

This is wondering into a long term gap in IIO ABI.  Even if we ignore this =
particular
usecase, it could potentially be useful to indicate the timing offsets betw=
een the
sampling of specific channels.  In simultaneous sampling case we'd normally=
 assume
0 (subject to tweaks like this one) whereas in a sequencer type situation i=
t can get
complex.  IIRC there are sequencers that allow insertions of extra delays a=
s well
as the simpler ones where it is just dependent on the previous channel samp=
ling times.
What you have here is a relatively simple time delay control but I'd like
to cover the full gamut of things we might see.

To me it's really not got much to do with calibration so I'd drop the calib=
 bit.
Define a baseline for all channels (which should probably be an arbitrary p=
eriod
after trigger as measuring trigger to first sample gets complicated in some=
 devices.)

Anyhow, I'll comment on v2 and point back at this.



