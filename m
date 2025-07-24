Return-Path: <linux-iio+bounces-21979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF39B10BD5
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6CA51CC73B0
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7612D8367;
	Thu, 24 Jul 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANbxX7AD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941F42405F5;
	Thu, 24 Jul 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364865; cv=none; b=UncfJSA45EGNRN3EH0/aF8o3w3fRHRlMEa47fc10gKkg8LvppIwCLThkdY37l9AQGa3a4dHz2Fd0FGth9XlcPlNG0BMhwh9dLZUHG2VAx6vTbjpFpRrlwN+PR2aQIwzFd1ceIa5Yy6jxCE8obSWFhT927jJPkt3h4u1t0AlZbxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364865; c=relaxed/simple;
	bh=T7mTc756K4A4iujyDowIYqpyD7zuMTFqZk+H5sCd9/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nfek8EiayjMbP/c2N1FEuyiv1wo+dtSPid0jlwh9AusQSrcf+w6UHgMl1qNHt1Mip30qnuQL6oGd9YjiOanjI7zrLOk4lMJ6+oaykyMJqbqD9d00OGGEuTN9cRRh1PZY4NaFFpzTSVQsxt58RbSdaSWaEMq602kBxysnAq+j6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANbxX7AD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A507C4CEED;
	Thu, 24 Jul 2025 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753364865;
	bh=T7mTc756K4A4iujyDowIYqpyD7zuMTFqZk+H5sCd9/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ANbxX7ADhECryySFBP6Lbo6hXw00bnr60O1SLhbyGIdn3fuCEPBB4cwgsBhfE1Qs6
	 23PvilF4IcqHqi0D76bPutdiWojfGuSfLgV/jFuGr6voE6hK4ZQmC3WF5tpK1wnmbG
	 j+6qN8KsHokjUCRlUzjTR2m3CcOGOiTiZ3MBkoPtek0dv0DMwMPTNg98/z+ZQLNyBM
	 5h3KLV7iDjNF9WFEisjObrZcXbm2NrRmuNDBjwenyYHkhi+/qgD6jRJzAmve3vy2fo
	 cTEM/970d9ChAgOXIPeqQG+CWz73/I8y5EA57cS1Raa1m9RNW2PYofEPOUsUJeqwZM
	 7PWqFSz9FKPeA==
Date: Thu, 24 Jul 2025 14:47:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: eraretuya@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 8/8] docs: iio: describe inactivity and free-fall
 detection on the ADXL345
Message-ID: <20250724144738.77024c1d@jic23-huawei>
In-Reply-To: <CAFXKEHa4M-Tp-y4dvNeWgYtUGo_ymyS7kqGbkhf+NJnmrrRxqg@mail.gmail.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
	<20250702230315.19297-9-l.rubusch@gmail.com>
	<20250706171611.7b4ae1a1@jic23-huawei>
	<CAFXKEHa4M-Tp-y4dvNeWgYtUGo_ymyS7kqGbkhf+NJnmrrRxqg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Jul 2025 20:49:48 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi
>=20
> On Sun, Jul 6, 2025 at 6:16=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Wed,  2 Jul 2025 23:03:15 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Describe the inactivity detection additionally using the free-fall
> > > register. Due to the controversial discussions on the mailing list, t=
his
> > > section of the documentation will be committed separately to allow fo=
r a
> > > more focused and detailed elaboration of the topic.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  Documentation/iio/adxl345.rst | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl34=
5.rst
> > > index 8ee01b8b87f4..c5525267ea12 100644
> > > --- a/Documentation/iio/adxl345.rst
> > > +++ b/Documentation/iio/adxl345.rst
> > > @@ -150,6 +150,31 @@ functions, so that one follows the other. The au=
to-sleep function puts the
> > >  sensor into sleep mode when inactivity is detected, reducing power c=
onsumption
> > >  to the sub-12.5=E2=80=AFHz rate.
> > >
> > > +The inactivity time is configurable between 1 and 255 seconds. In ad=
dition to
> > > +inactivity detection, the sensor also supports free-fall detection, =
which, from
> > > +the IIO perspective, is treated as a fall in magnitude across all ax=
es. In
> > > +sensor terms, free-fall is defined using an inactivity period rangin=
g from 0.000
> > > +to 1.000 seconds.
> > > +
> > > +The driver behaves as follows:
> > > +* If the configured inactivity period is 1 second or more, the drive=
r uses the
> > > +  sensor's inactivity register. This allows the event to be linked w=
ith
> > > +  activity detection, use auto-sleep, and be either AC- or DC-couple=
d.
> > > +
> > > +* If the inactivity period is less than 1 second, the event is treat=
ed as plain
> > > +  inactivity or free-fall detection. In this case, auto-sleep and co=
upling
> > > +  (AC/DC) are not applied.
> > > +
> > > +* If an inactivity time of 0 seconds is configured, the driver selec=
ts a
> > > +  heuristically determined default period (greater than 1 second) to=
 optimize
> > > +  power consumption. This also uses the inactivity register.
> > > +
> > > +Note: It is recommended to use the activity, inactivity, or free-fal=
l registers
> > > +when operating with an ODR between 12.5=E2=80=AFHz and 400=E2=80=AFH=
z. =20
> >
> > This seems a tiny bit backwards.   It is recommend that the activity, i=
nactivity or
> > free-fall registers are only used when operating with an ODR...
> > =20
>=20
> Ehm, Doesn't the sensor always have an ODR?=20
I was lazy. The ODR... was meant to be ODR between 12.5 Hz and 400 Hz (so o=
riginal text
for that bit).

> The real question is which
> ODR should be configured. There are recommendations for specific
> features. I may have either misunderstood or misdocumented this part.
>=20
> > As currently written it seems to be recommending that if you want those=
 sampling
> > frequencies you should also enable one of these detectors.
> > =20
>=20
> Ah, no. The other way around, when someone wants one of events
> detected, the recommended frequencies should be used. I'll have a look
> at it.

Sounds like you got my rubbish explanation.

>=20
> > Reminds me of the classic London underground sign that said "Dogs must =
be
> > carried." which raised the question of how people with out dogs were me=
ant to travel.
> >
> > Otherwise this new section looks good to me.  Thanks,
> >
> > Jonathan
> >... =20
>=20
> Best,
> Lothar


