Return-Path: <linux-iio+bounces-14475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAAAA15E56
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 18:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF331655B0
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0031B19CC24;
	Sat, 18 Jan 2025 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7LOg1UK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31E2913;
	Sat, 18 Jan 2025 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737221725; cv=none; b=mddqQBQXkf7LfJz5FBIZLykevcpRdzEPaKo3Ts/KOou3SzXy13O7jULl8Ummf+pfzjUM3Gbsn3rs/RP42QXgELDG3DVI/AFacRHdvxWzEPtrGNcR+pJxrdG+nJMPD7N0ZflI2Q+uFMtbdcUYNEFv+5Jp7sKsW5gymCwjQlDht+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737221725; c=relaxed/simple;
	bh=ZjAbuOIuOjrEJy8Qcfw/4zNEaXRurScLHYg9BNb9dus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2Q1+Z3X37xV2AONK9YfjHxP93/jzG1A4687a7g7RXjXALOIYSnegH9BPjvF8R8jazJCMQn73hZyBYVcKMVXr2nDxJwBlZvwcp7BwH/iFRqv5SlYhLGfBDqfSiO6Zuyu3IYKVOivqhBPOvn4x8X1j6Nz5g6f/IOoKJe0WVhiO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7LOg1UK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F251FC4CED1;
	Sat, 18 Jan 2025 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737221725;
	bh=ZjAbuOIuOjrEJy8Qcfw/4zNEaXRurScLHYg9BNb9dus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J7LOg1UKPsbzRp1Ds6DRmZ6g86DmaqBogBSba7pg8j+udz3PHNNPzD/Eel0WklxOF
	 Ac4ilAcNoyOUPV+wvZDjh8f1lU1a+zVFSzq3MKNJTT0SX2xB7LI9CvLLRiaxFnH7fU
	 EYZ2hZRH7Ux8v9nkmDHx47Kz5SlnqjUuRLdW5iFPDKgG4w7OKxeSh99bDBc4WTA+r0
	 ArVAFW6QmWm6Upqli+zaIByVbve9o4w61To2fRJpf8d4f/5un6IF152u+kArwNLysk
	 n9zHr3i/cvEt4J+X96ObxEbG5ka5UF1hbA+QYyKDWqdyYUA8kVV2FZI8Py/JlBwEy0
	 KYSAcDxaERB2w==
Date: Sat, 18 Jan 2025 17:35:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 1/1] Documentation: iio: Add ADC documentation
Message-ID: <20250118173516.130ca9fb@jic23-huawei>
In-Reply-To: <f3c1f7d2-3cc7-43b0-a166-e2053b2dabfa@baylibre.com>
References: <efa1dba23c38b207716883d6226ce9e9df5a51b8.1736862045.git.marcelo.schmitt@analog.com>
	<3bd58574-36c6-4102-ad7d-1aeff0e46a95@baylibre.com>
	<20250118155153.2574dbe5@jic23-huawei>
	<f3c1f7d2-3cc7-43b0-a166-e2053b2dabfa@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Jan 2025 11:03:26 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/18/25 9:51 AM, Jonathan Cameron wrote:
> > On Wed, 15 Jan 2025 11:23:24 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> >> On 1/14/25 7:53 AM, Marcelo Schmitt wrote: =20
>=20
> ...
>=20
> >>> +1.2.2 Differential Unipolar Channels
> >>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>> +
> >>> +For **differential unipolar** channels, the analog voltage at the po=
sitive input
> >>> +must also be higher than the voltage at the negative input. Thus, th=
e actual
> >>> +input range allowed to a differential unipolar channel is IN- to +VR=
EF. Because
> >>> +IN+ is allowed to swing with the measured analog signal and the inpu=
t setup must
> >>> +guarantee IN+ will not go below IN- (nor IN- will raise above IN+), =
most
> >>> +differential unipolar channel setups have IN- fixed to a known volta=
ge that does
> >>> +not fall within the voltage range expected for the measured signal. =
This leads
> >>> +to a setup that is equivalent to a pseudo-differential channel. Thus,
> >>> +differential unipolar channels are actually pseudo-differential unip=
olar
> >>> +channels.   =20
> >>
> >> I don't think this is equivalent to pseudo-differential unipolar. That=
 one has
> >> a common mode voltage supply on the negative input. This one has a ful=
l range
> >> signal on the negative input. This is the diagram I was expecting here.
> >>
> >> ::
> >>
> >>   -------- VREF -------
> >>     =C2=B4 `       =C2=B4 `               +-------------------+
> >>   /     \   /     \   /        /                    |
> >>          `-=C2=B4       `-=C2=B4    --- <  IN+                |
> >>   ------ GND (0V) -----        |                    |
> >>                                |            ADC     |
> >>   -------- VREF -------        |                    |
> >>         =C2=B4 `       =C2=B4 `     --- <  IN-                |
> >>   \   /     \   /     \        \       VREF         |
> >>    `-=C2=B4       `-=C2=B4                +-------------------+
> >>   ------ GND (0V) -----                  ^       =20
> >>                                          |      =20
> >>                                   External VREF =20
> >=20
> > If it's unipolar, output must be positive which isn't true here.
> > Do we actually see differential unipolar except for the pseudo case with
> > common mode voltage?   Seems like a weird device. =20
>=20
> OK, it sounds like you and Marcelo are considering bipolar to mean that t=
he
> difference is bipolar rather than the inputs. In that case, it doesn't se=
em like
> there would ever be such a thing as unipolar (true) differential.

You could build it, but it would indeed be odd.

  -------- VREF -------
     =C2=B4 `       =C2=B4 `               +-------------------+
   /     \   /     \   /        /                    |
          `-=C2=B4       `-=C2=B4    --- <  IN+                |
   ------    VREF- -----        |                    |
                                |            ADC     |
   -------- VREF -------        |                    |
     =C2=B4 `       =C2=B4 `         --- <  IN-                |
   /     \   /     \   /        \       VREF         |
          `-=C2=B4       `-=C2=B4          +-------------------+
   ------   VREF-  -----                  ^       =20
                                          |      =20
                                   External VREF =20

Where we constrain the negative to be higher that
the positive and it's that difference we are reading.

I'm stumped on what it is for though.  Maybe if vref is
0 some sort of current measurement?  Or just possibly
something odd with weighing cells (if there is a weird
data input rule, that's normally where I look for it!)


>=20
> I was looking at this from the point of view of only the inputs and not t=
he
> difference. I'm seeing that the input voltage can only be positive, so to=
 me
> that would be unipolar.
>=20
> So at the very beginning, when we first mention unipolar and bipolar, it =
would
> be helpful to add a bit making it clear exactly which point in the system=
 we
> are talking about, the input or the output.
>=20

Definitely good to have a definition.  I only care about data so the output
was what mattered to me.  Analog side is someone else's problem :)

Jonathan


