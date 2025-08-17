Return-Path: <linux-iio+bounces-22862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC6B293A9
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 16:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D81172630
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC30618DF9D;
	Sun, 17 Aug 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKpNZSor"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19214B086
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755442285; cv=none; b=rETnXspwlXBe1DOyiEI01uN8AJQxTETWrZ0Guk6DWEKuqaUpBqi91JXaxKq+0Fn1IcIy8a2qjqmtgiRcfuDMgWRN0VvWySUDyOuYOdlS954LIAah7BPwtuj+H1Zd77fyDMmHlzoP9wO1E/3OHIlhiKifiySxHmh37y/UYOabZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755442285; c=relaxed/simple;
	bh=EkJSHCvAkFjQGKkITacBbmj6pCBgIaLeRRuk9p/dmI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4Szlfatz1T6gjYj9O4kmz8A90rlaBqEL20aAxMiz+TKKR3e3OI+6A8DeZhoUpj5yyrnwbsvkhcAVrwfRQ5BXOH0MUSFmmWkHp2tI+4UINqI4SGtFC+DXZG/3INUhzw2lhmoHAQ8BPz2Vvm2ptgb1KUtJlKPzVrvWEM1opcUg98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKpNZSor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E32C4CEEB;
	Sun, 17 Aug 2025 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755442285;
	bh=EkJSHCvAkFjQGKkITacBbmj6pCBgIaLeRRuk9p/dmI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fKpNZSor590s/PBpLc9dLTogD22+XxiR6+nb+Ntvm/KEn0VfjrsLV7novXf3tdJrl
	 5K9GYNQhzNshkFdSRS1J6oGRT/qhUiKO1yiC4Y95DeNrkCcUjSJ41TpmEWYNd5Hpo3
	 RK4Bk3OfUOhpeVTSLdI7gbgEKW4w48hz+TApK+KLFhCHDtG4YI6oFlbd1PCzf8LoLP
	 JM2IsHV+TLzsjLr+vzN84+ue+F+vd97yl9aZL5OvskEKHlajHXtdeq5krIKnEegvWC
	 G4ac3zXd0RC9QAgqrRARJ1oi9SL/eVjgESuh97hQWy5BrZLDyn3NLKDomy5rOP1bAU
	 tbL0FY1bb/WaQ==
Date: Sun, 17 Aug 2025 15:51:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: ASSI <Stromeko@nexgo.de>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bmp280 v1 4/6] iio: pressure: bmp280: enable filter settings
 for BMx280
Message-ID: <20250817155119.2271d8e0@jic23-huawei>
In-Reply-To: <87pld0nxkk.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-5-Achim.Gratz@Stromeko.DE>
	<20250810191338.12b568df@jic23-huawei>
	<87bjonf1bv.fsf@Gerda.invalid>
	<20250811211423.3e52a67a@jic23-huawei>
	<87pld0nxkk.fsf@Gerda.invalid>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Aug 2025 21:34:35 +0200
ASSI <Stromeko@nexgo.de> wrote:

> Jonathan Cameron writes:
> > We stuck to 3DB point for these because all most anything else is annoy=
ingly
> > filter type dependent with no real consistency of meaning.  At least 3d=
B is
> > something you can establish if you have a reasonable amount of info abo=
ut the
> > filter (or a plot!) =20
>=20
> If you look at my .sig you might glean I probably know the odd thing or
> two about filters=E2=80=A6 and 3dB frequency is just as meaningless witho=
ut
> knowing the filter type even before one enters into whether or not there
> is peaking and resonance.

I have no problem with proposals to enhance the filter description, but
in general on the basis of the sort of filters that get applied to
reduce sensor noise, their primary job is either high or low pass filtering.
In both those cases 3dB point gives a useful single number indication.

If you know your signal is expected to change at a particular maximum frequ=
ency
and want to be sure to not filter that excessively set the 3dB point beyond=
 it
and for (most) filters that will work fine, if not necessarily being the id=
eal choice.


>=20
> > Obviously they are almost always effected by sampling frequency so that=
 maths
> > can be rather non trivial.
> >
> > Vs a completely misleading tap length control, an approx 3dB eyeballed
> > off a plot is an improvement.  =20
>=20
> Donning my hat as a user: I beg to differ.  I know this device has 8
> different settings for the tap length of some otherwise unspecified
> filter (you can deduce that it must be a a recursive shift and
> accumulate type thing) and more taps mean larger timeconstant / somewhat
> better smoothing. =20

As user of 'this specific device that decided to read the datasheet' then
yes I agree with you.  Most users aren't in that category.  They have
no interest in opening a datasheet.  They just want to run generic software
that offers them settings that are moderately generic.

Key here is a major / the main purpose of the IIO subsystem is generalizati=
on
of interfaces across many devices where the datasheets choose different
descriptions. Note that 3dB frequencies are a common filter parameter found
on datasheets.  Unfortunately, filters are one of the fiddliest things to
describe in succinct fashion.

> I really just want to chose among these eight
> settings and not calculate a 3dB frequency that isn't in the datasheet
> (and maybe even a different one depending on the four other three-bit
> choices I have w.r.t. device settings).
>=20
> I imagine the reason this particular device uses this attribute is
> purely due to the fact that it was already available and corresponds
> roughly to what the control does.

The ABI documents are clear on how we describe filter controls.
Any misuse of that is simply a bug.  Unfortunately in some cases we=20
missed that bug in review.

>=20
> > Adding more filter parameters is likely to end up with a very complex
> > userspace, so if we have any way to get an approx 3dB point, stick to
> > that. =20
>=20
> Filter settings: 0, 2, 4, 8, 16 (see datasheet, that's 2**i below)
>=20
> That's the simplest I can think of, really.  Per the datasheet, the
> actual filter is:
>=20
>   y(t) =3D ( (y(t-1) << i) - y(t-1) + x(t) ) >> i
>        =3D 2**-i * x(t) (2**i-1)*2**-i * y(t-1) )
>=20
> The canonical recursive single-pole LP has two coefficients, which
> should be 1-d and d (d because it's the sample decay).
>=20
>    2**-i + (2**i-1)*2**-i =3D 2**-1 * ( 1 + 2**i - 1 ) =3D 1
>=20
> so check that.  The time constant (rise time to 63%) is then
>=20
>   tau =3D -1/ln(d)
>=20
> Oddly enough the data sheet gives time to >75%, but that is just a
> scaling factor of ln(0.25) on the tau.  The nomalized corner frequency th=
en is:
>=20
>   fc/fs =3D -ln(d)/(2pi)
>=20
> So lets check that:
>=20
> |---+--------+--------+--------+--------+-----------+----------|
> | i |    1-d |      d |    tau |  t>75% | datasheet |    fc/fs |
> |---+--------+--------+--------+--------+-----------+----------|
> | 0 |      1 |      0 |    --- |    --- |         1 |        1 |
> | 1 |    0.5 |    0.5 |  1.443 |  2.000 |     1.443 | 0.110318 |
> | 2 |   0.25 |   0.75 |  3.476 |  4.819 |     3.476 | 0.045786 |
> | 3 |  0.125 |  0.875 |  7.489 | 10.382 |     7.489 | 0.021252 |
> | 4 | 0.0625 | 0.9375 | 15.495 | 21.481 |    15.495 | 0.010272 |
> |---+--------+--------+--------+--------+-----------+----------|
>=20
> > Been way to long since I last did any digital filter stuff, but poking =
google
> > ai thing with "IIR filter y_t =3D (a -1)/a * y_(t-1) + x_t/a"
> > came back with 3dB in digital angular frequency as
> >
> > w_c =3D arccos ((2a^2 - 2a - 1) / (2a(a - 1))=20
> > Which might be right. =20
>=20
> Given that it says w_c and said angular frequency, I'd wager a guess
> that there's a factor 2pi that needs to go.  Yep, close enough
> numerically.  Next time I'm bored I will whip out the trigonometric
> identities table in Bronstein/Semendjajew and see why that arccos
> espression is the same as -ln(d).
>=20
> I'd still rather specify the filter as integers than having to enter
> those floating-point numbers to get the device set up.
>=20

Sorry, the ABI has been there a long time and we aren't changing it now.

If you want to propose additional filter description (which to avoid
breaking userspace software would most likely be dependent read only
attributes - i.e. 3dB remains the control but we can provide
informative other values if they generalize to a wideish class of filters)
then I'm happy to consider it and maybe even dig my filter books
out the garage if I can't find a good online reference.

Jonathan

>=20
> Regards,
> Achim.


