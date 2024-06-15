Return-Path: <linux-iio+bounces-6298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876E690984D
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 14:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C36B1C211EA
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11004642D;
	Sat, 15 Jun 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNBwABJ2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F453C062;
	Sat, 15 Jun 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718454320; cv=none; b=LAUUYXQ89XIvEkoYtXxifxR1rzzob40fcHvwiTl/zQLOxv2Qe5qdDAzOGp2IYVa7sEnEgCQpRZyiWvNy/sjl7RlDSvwsBVXmdREuMrii42TVAAp5UxzbnxgFuGFeJtxuq714NaavldYAHXmWb5WcxW27voHcTIYKET+Kg+g8jAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718454320; c=relaxed/simple;
	bh=ISVbu2fxZ1eV2uEqGAczzn9y7Z8gAktw7YuOOBLJ0/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5eyTMqfOol8AFaBwTC4Q1E/IBjJYKKC5JP2brbJoh1fs+YGJtAInjYeRIKkMOm/eZcimOjGwRNp3EgpkUJPMJTKp4Fbl5XAGv8RezORh9UlWdxc6Fo6SzBs/JLlPf3+nNrPExMjEk2oQR+8lD/wawZn16yzhc++UWMzCwgZ7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNBwABJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749AAC116B1;
	Sat, 15 Jun 2024 12:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718454320;
	bh=ISVbu2fxZ1eV2uEqGAczzn9y7Z8gAktw7YuOOBLJ0/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tNBwABJ2oDk9VHb+Z0px0Kw7I7IDolqlz/RlhNdk5Scfth6uJX/MjndFF5MnzWiv2
	 7PuMRFdxklKAqxN272F8XBrWQgunsSa5x80VTCr1okVpkjub3Z7immYWPrY2ou4f7W
	 ueWqgb8tdne8zvFFqTK7zDdjlH7YjGlkX6slkbjhuHiL26Ss9awVaFsQLi+BQi7OIP
	 oFwD7QYYz/GIfEnQYzpYwRYrXqbMFJbiAvDsx/4FlshZMXO3AwTPMNjKK4KsuWfyTx
	 ChCaxri55Dx1TdW6I6VYJVYEXYLK+jcJSqwexyYhG0kGJEZRRIREnUeU7X9Fa1Dxh2
	 wYpGDoMMa5ckw==
Date: Sat, 15 Jun 2024 13:25:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michael
 Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add AD4695 and similar ADCs
Message-ID: <20240615132510.2575b65a@jic23-huawei>
In-Reply-To: <d802086d-5f88-49c3-996c-ada251043187@baylibre.com>
References: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
	<20240612-iio-adc-ad4695-v1-1-6a4ed251fc86@baylibre.com>
	<94448c2c-e7b2-4191-858c-529b254994f1@kernel.org>
	<f765ef30-a777-4dfc-8f93-0f15b46f91ae@baylibre.com>
	<e09fecf4-bde2-4feb-8312-22c530c6a960@kernel.org>
	<b6b52b1e-847b-44ca-87f9-095a78164771@baylibre.com>
	<5f0776ba5163578453e26352763ff1b4687bcf87.camel@gmail.com>
	<20240613194324.GA2352022-robh@kernel.org>
	<d802086d-5f88-49c3-996c-ada251043187@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2024 15:09:40 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/13/24 2:43 PM, Rob Herring wrote:
> > On Thu, Jun 13, 2024 at 05:11:48PM +0200, Nuno S=C3=A1 wrote: =20
> >> On Thu, 2024-06-13 at 09:39 -0500, David Lechner wrote: =20
> >>> On 6/13/24 9:18 AM, Krzysztof Kozlowski wrote: =20
> >>>> On 13/06/2024 15:57, David Lechner wrote: =20
> >>>>> =20
> >>>>>> =20
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
adi,ad4695
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
adi,ad4697-wlcsp
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
adi,ad4697
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # same chips with higher max samp=
le rate =20
> >>>>>
> >>>>> I suppose one could make the argument that the programming model is
> >>>>> the same on these too, but the maximum sampling frequency does seem
> >>>>> like an important bit of information so that you don't try to set
> >>>>> the conversion trigger rate too high.
> >>>>> =20
> >>>>
> >>>> which property is that? I don't see differences in the driver, so I
> >>>> don't get how these wlcsp compatibles allow you to control value of
> >>>> conversion trigger. =20
> >>>
> >>> This comment is unrelated to the package type (WLCSP or LFCSP).
> >>>
> >>> What I mean is that e.g. AD4695 and AD4696 are virtually identical
> >>> other than the maximum allowable sample rate (500 kSPS or 1 MSPS).
> >>>
> >>> So my thinking was that it would make sense to have:
> >>>
> >>> 	compatible =3D "ad4695";
> >>>
> >>> for the lower sample rate chip and
> >>>
> >>> 	compatible =3D "ad4696", "ad4695";
> >>>
> >>> for the higher sample rate chip since ad4696 can do everything
> >>> that ad4695 does plus a bit more.
> >>> =20
> >>
> >> IMO, that would make sense yes. If the higher sample rate chip fallsba=
ck, it will
> >> still work but not at full speed. The other way around is the one that=
 we can't allow
> >> naturally.
> >>
> >> But possibly dumb question now... since both devices will be supported=
 at the same
> >> time, do we actually care about having the fallback compatible? My und=
erstanding of
> >> the fallback story is that we may load a DTS in an older kernel where =
chip A is
> >> supported but chip B is not and it is ok for chip B to fallback to chi=
p A. Since
> >> these devices will be supported at the same time, do we need to care? =
Unless out of
> >> tree stuff enters the equation? =20
> >=20
> > Yeah, it doesn't really matter much in that case.
> >  =20
> >> Or is there another usecase that I'm not aware about (or maybe it just=
 makes sense to
> >> document properly...)? =20
> >=20
> > Somewhat I guess. Perhaps if there's a 3rd chip with higher rate, then=
=20
> > it will be more obvious what to do and we don't have to have this=20
> > discussion again for it. :)
> >=20
> > Rob =20
>=20
> It sounds like maybe the best thing to do here then is just keep it simpl=
e?
>=20
> Like this:
>=20
>   compatible:
>     enum:
>       - adi,ad4695
>       - adi,ad4696
>       - adi,ad4697
>       - adi,ad4698
>=20
Quick comments late in discussion.=20

Simply compatible list is fine as they are all coming together (though that
may in theory not be true on some other OS!)

I'm also fine with the fallback as you discussed so less capable
chip is the one we fall back to.

Definitely need to differentiate chips with different possible ranges of
a parameter as that goes straight through to userspace as
sampling_frequency_available and userspace is going to get confused
if it gets told it can do things that silently don't work.

This sort of thing is why I always want to see chip IDs listed even
if we think they'll just work with another one.
a) Documents hardware right and people expect to see the ID of the chip
   on the BoM
b) Lets us deal with cases where we have missed subtle differences
   in capabilities because the driver didn't support them yet.

So in conclusion either option you proposed is fine (as above, or
fallback to the part we think is a subset of functionality.)

Jonathan
 =20

