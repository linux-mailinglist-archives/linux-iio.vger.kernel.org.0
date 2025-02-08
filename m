Return-Path: <linux-iio+bounces-15156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D822A2D623
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 13:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7785D188CB76
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531BB246349;
	Sat,  8 Feb 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju0DQVie"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66119F101;
	Sat,  8 Feb 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739019460; cv=none; b=seTdsCfW4C1I4prpRUjX92OQbPtiDYKWWd0o5j+BukYWI+vaQQj0OmNfFwoTP2hNjl0nAEbKprtbyCxOmSd50i5PGa4ep5g7dFYvAu9S63paYY1WNRhipTV0STq17UPVRE4ddc5eSvH9RTB5o0SDSJqxXVs5z3URQlQMLsaZ+lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739019460; c=relaxed/simple;
	bh=Zka+OzwmFgDte5OLmQ4mhALoPsxT7ivBjfyEsSpZcIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2n9ZCzMYrHk0NVFGB90Faw/DnC+Bm3ZXSBYuwrj5XeYRejKW8mRuP0aPvODYY0Xz91vVnPMZyxQikcizpY/Mrnk9jdh26D+CHH2ldrqXHz949BVljxEhaI6+sONHlLIVsrxqUlDsNBascXPXiB8wZfiF5gOQ11ZZp3Cg4WzugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju0DQVie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3D4C4CED6;
	Sat,  8 Feb 2025 12:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739019459;
	bh=Zka+OzwmFgDte5OLmQ4mhALoPsxT7ivBjfyEsSpZcIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ju0DQViedXMjG6gJHs/atYn3kFxxA03Uml7e5BoIr3RINHMA4uguWe1SFNy9S7IPN
	 ya530ZxP1vsi8Y+0MsNXgUDWqmz+IAgnl+5KcHrSnExojObWBMLCqOTxQye2boobip
	 u8gmuMTavCLLpTGt4FQQir9ZuqrJWhOyUuK9vYr7iiAP/L8EX+98snXQzpASYOWgxg
	 Z2QjS8ldr/7nYH8QZv7ybroG3wK8QyLjVleOhXyCeP25/7aEy1eKJRVhi9BUvBEPPI
	 Nc3WGWpoNQ9+9s3qVAdM4Sy+gILKjl2+O/D0vegQYlHchkwa03DD2dYkGcRy55p4H+
	 5ZJKqpNZKSiAQ==
Date: Sat, 8 Feb 2025 12:57:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v1 00/12] iio: accel: adxl345: add interrupt based
 sensor events
Message-ID: <20250208125732.2a41961a@jic23-huawei>
In-Reply-To: <CAFXKEHbuJkG1Ptjz03-ZhfLQB6PuYk47BMKKPTN9mFnXsnF3kw@mail.gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
	<20250201174818.26dcc646@jic23-huawei>
	<CAFXKEHbuJkG1Ptjz03-ZhfLQB6PuYk47BMKKPTN9mFnXsnF3kw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Feb 2025 14:40:17 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Jonathan, please find my answers below.
>=20
> On Sat, Feb 1, 2025 at 6:48=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Tue, 28 Jan 2025 12:00:48 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add several interrupt based sensor detection events:
> > > - single tap
> > > - double tap
> > > - free fall
> > > - activity
> > > - inactivity
> > >
> > > All the needed parameters for each and methods of adjusting them, and
> > > forward a resulting IIO event for each to the IIO channel. =20
> >
> > So my main feedback here is to be much more reluctant to add new ABI.
> > Anything you add is unused by all existing code and if it is unique
> > to a driver probably never going to be used by anyone other than you.
> >
> > We have a bunch of accelerometers in tree and as they go wrt to events
> > this one isn't even particularly complex.  The existing ABI covers
> > their events reasonably well so take a look at how they do it.  Often
> > it's a case of mapping names for the application of an event (free fall
> > detection, activity detection etc) to what what they are actually detec=
ting.
> > Those generalize a lot better across different sensor types.  It's almo=
st
> > always a threshold of some type. The tap / double tap are more complex
> > but we put quite a lot of effort into coming up with a general
> > description a year or so back.  There may new things but most of the
> > ABI is already there.
> > =20
> Please, understand my patches in "v1" rather as a huge set of questions,
> than a proposal of reinventing the IIO ABI :)
> My intention is actually not to extend/rewrite the ABI. It rather shows m=
y lack
> of knowledge combined with the curiosity of how to actually use the
> (IIO) APIs for
> such implementation. I know this is still tedious, but I'm sure it will b=
ecome
> better.
>=20
> My dilemma was/is the following: I did an initial implementation more sim=
ilar
> to e.g. ADXL380 for such events, and the sca3000.c for the freefall event.
> IMHO the names for the sysfs handles were not at all intuitively mappable=
 to the
> fields I liked to operate, such as tap duration, window, latent, etc.
> The other alternative I saw, was setting up sysfs myself, IMHO clearer na=
ming
> but actually not really using IIO's event_config/event_value.
>=20
> Personally, I don't have any preference. If there really is no way to cha=
nge
> naming of the sysfs handles, then it's probably a question of
> documentation. If I
> can make it more intuitive for a user who knows the sensor, but not
> the internals
> of IIO, then I'd prefer to use the names referred and documented in the s=
ensor's
> datasheet.

ABI has to be consistent across lots of different device types.  Things
that on accelerometers mean freefall are totally different for ADCs etc.
That's one of the challenges of an ABI that is meant to cover many devices.
There is also the challenge that one devices idea of how to detect what see=
ms
like a common thing can be totally different to another with controls
that don't line up at all.  By targetting what is actually being measured
rather than what the device datasheet says it is for, we tend to get better
generalisation and more meaningful control parameters.  It gets fiddly
around things that are sort of dumb classifiers like tap detectors
or more complex activity classifiers as we don't always get useful
documentation on what the controls are doing.

Many users will make use of userspace libraries. If they are focused on
just accelerometers they get to present an interface to the next layer
up that is accelerometer specific.


>=20
> In summary, I see your point. So, I redo this patch set as I did in the i=
nitial
> approach to show better what I mean. Probably I'm just using it in a wron=
g way.
> Thank you for the feedback so far, I'll try to use it where it still appl=
ies.

Feel free to send out an ABI RFC in cases where it's not obvious.  That
can save some time by getting at least outline agreement on the direction
before code is ready.


Jonathan

