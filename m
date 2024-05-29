Return-Path: <linux-iio+bounces-5429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8178D30E9
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 10:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107641F2873D
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 08:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ABF16B758;
	Wed, 29 May 2024 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SxmSPn+O"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD716A367;
	Wed, 29 May 2024 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970425; cv=none; b=LMd60XGeErCd2qYYYKYle1+M+wlbviz15a2VooqP1Id8GtEfeSKQAD3ltAdq8cl1UCZNwVQ31fc1tthtTXHTDetWPeil+nrMDWtwsGb3CPdFj9o1gs0K3il2Tz/YFFBnZ5hz4Qj+xtbeRQuqQpy+aX35sydJEYBle6/lnRVEYbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970425; c=relaxed/simple;
	bh=72XwbfWX0JNfftZ8PPXFHNsSZEHdXiNIRoGnHXe6D44=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9U4yjF0NIDqRVtOFOaq9b1+5twmxF2aT+VtWlx2o43K6PtlcoK34PXGI4cLc+QyKDojNr5gT2WDSyEKfOH4hTpbnbeapj61dnf/3BIJLr7dtkY27eBq/qmh81ZW4YefaULEkKLpPJcT8K4EW1f6vz0AVlKkHNPetuA5aRdw818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SxmSPn+O; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716970422; x=1748506422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=72XwbfWX0JNfftZ8PPXFHNsSZEHdXiNIRoGnHXe6D44=;
  b=SxmSPn+O8tOjGwG8kwe/2/REZa1dwij+e1jxSmZeB/nZ09XTr7la4gsN
   DnEbdakaqO+2pxOTJeY8aOnvEGD8fL/asW/S9NqyijW39vXo0RLq/VYGO
   r50I1lTfPgOKK6o1ee5vjkkHp0jzoSiKjMTIgV3IchwADJw6UdZmLEjhK
   lwfz2neYEkB6NNj9OChzNgOcB7xcqK7GMwn6B5KSiNyw5QU9aj9Iw6fKr
   XDJTmTF6fVat+dIaMNJE8ORiO5uVHQOxdR4SDXG7G77a2pl0aX++GJNJC
   DRbvdCgZpLQ9G/lr1/YXAfwmjxsC+NSAVL29AzIFTsurAWSlHAu71fxK0
   Q==;
X-CSE-ConnectionGUID: 93YC8SPlT/GvXrqhb2YOdA==
X-CSE-MsgGUID: txZTcmdLTX6G4a1LPMLe5A==
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="asc'?scan'208";a="194082660"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2024 01:13:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 May 2024 01:13:28 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 29 May 2024 01:13:25 -0700
Date: Wed, 29 May 2024 09:33:10 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: Conor Dooley <conor@kernel.org>, David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nuno =?iso-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
Message-ID: <20240529-quicksand-pulp-9926fc45a294@wendy>
References: <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
 <20240526-peculiar-panama-badda4f02336@spud>
 <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rbQyeM2lc/f5W732"
Content-Disposition: inline
In-Reply-To: <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>

--rbQyeM2lc/f5W732
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:07:37AM +0200, Nuno S=E1 wrote:
> On Sun, 2024-05-26 at 18:35 +0100, Conor Dooley wrote:
> > On Thu, May 23, 2024 at 02:15:35PM +0200, Nuno S=E1 wrote:
> > > On Wed, 2024-05-22 at 19:24 +0100, Conor Dooley wrote:
> >=20
> > > >=20
> > > > To remind myself, "Application 2" featured an offload engine design=
ed
> > > > specifically to work with a particular data format that would strip=
 a
> > > > CRC byte and check the validity of the data stream.
> > > >=20
> > >=20
> > > I think the data manipulation is not really a property of the engine.=
 Typically
> > > data
> > > going out of the offload engine goes into another "data reorder" bloc=
k that is
> > > pure
> > > HW.
> > >=20
> > > > I think you're right something like that is a stretch to say that t=
hat
> > > > is a feature of the SPI controller - but I still don't believe that
> > > > modelling it as part of the ADC is correct. I don't fully understan=
d the
> > > > io-backends and how they work yet, but the features you describe th=
ere
> > > > seem like something that should/could be modelled as one, with its =
own
> > > > node and compatible etc. Describing custom RTL stuff ain't always
> > > > strightforward, but the stuff from Analog is versioned and document=
ed
> > > > etc so it shouldn't be quite that hard.
> > > >=20
> > >=20
> > > Putting this in io-backends is likely a stretch but one thing to add =
is that the
> > > peripheral is always (I think) kind of the consumer of the resources.
> >=20
> > Could you explain you think why making some additional processing done =
to
> > the data an io-backend is a stretch? Where else can this RTL be
> > represented? hint: it's not part of the ADC, just like how if you have
> > some custom RTL that does video processing that is not part of the
> > camera!
>=20
> Maybe we are speaking about two different things... I do agree with the v=
ideo
> processing example you gave but for this case I'm not sure there#s any da=
ta
> manipulation involved. i mean, there is but nothing controlled by SW at t=
his point.
> Or maybe there's already a future usecase that I'm not aware about (maybe=
 the CRC
> stuff David mentioned).

Yes, this was about the CRC or other additional processing - the quoted
text should really make this clear.

--rbQyeM2lc/f5W732
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlboQQAKCRB4tDGHoIJi
0kz3AP0Tzr065+W35OM/7KhesmbmeL+xHVzJPcC/rRlOigC+FAEA4EI9ewuesuPF
gSK62N0YxbrnLdbpWvhRMnxNLjRDlAs=
=Vc5B
-----END PGP SIGNATURE-----

--rbQyeM2lc/f5W732--

