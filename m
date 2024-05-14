Return-Path: <linux-iio+bounces-5048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B1B8C5B55
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 20:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039C6B22363
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE9753E15;
	Tue, 14 May 2024 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMzyuieV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379F18AEA;
	Tue, 14 May 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712416; cv=none; b=IzhfopQz1Df/mW3T6+frXHWt0M9XTGKV94Ba8Stm6K1cfYEsABkMIVLABpYujqVXvUXnRZ3/pAjI6kkC+GFTNaTxO1ZA+/n9rLbBo0VCdddR/bfLt9IKXIkcy2SpEP+m++6F3e6u0kLdVPAnxz2SB2dax4j2mHK9k7ViEQURyC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712416; c=relaxed/simple;
	bh=UyU5amjgg2PHF9aBCOdyNsPAT8YCHB5QaFm6JaD7EXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONl0WISzsGFRke4AQV8LrxWtbiVKxKv9+uHUL+AQRH30EUMsqG2sTndFxwjvS/jBtMW53NhF8U6o7PUy6CEEm8V2DKfbu0qFxqDmKE+m7QKrM7F1TiiLVRpTxSkyEEvcw6F23GQmXmPI6H2HBkdCN6rFU6fgk64+2UXA80znVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMzyuieV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5610AC2BD10;
	Tue, 14 May 2024 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715712416;
	bh=UyU5amjgg2PHF9aBCOdyNsPAT8YCHB5QaFm6JaD7EXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMzyuieVUnps5Btmqr0nBxxgElHV7q4hzaDiPfr/fbaxy6GYC70ZNJAg/xwGo/MJA
	 HLdmVCw5BNYoOSspqUDi2syDeAomf2UEikDfPOxipcG9PNt25RGX5LTKC8xC50Jy/z
	 u8VnWQJccvBC0sUas/jRP3yIj2A4gp5mlrZAQTJ2g3pNxXMyXUeWzyBNCuctoL7Yp4
	 CZdQtb2/3xEeotue8J6AA+h9kMcvKPFlFcbPuYJMpQ/5/Nf8m9Z8EofuwVrOPdX7qw
	 S3SOq//QKzNNaYshFy6MYhWnXGd2rPFzIb0/5onZePi+YdTRINqnaH3AwTflegrCbQ
	 Bus5huDTVQeLw==
Date: Tue, 14 May 2024 19:46:51 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
Message-ID: <20240514-aspire-ascension-449556da3615@spud>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
 <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>
 <20240513-headsman-hacking-d51fcc811695@spud>
 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YoB/os18honPkEB1"
Content-Disposition: inline
In-Reply-To: <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>


--YoB/os18honPkEB1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 12:06:17PM -0500, David Lechner wrote:
> On Mon, May 13, 2024 at 11:46=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Fri, May 10, 2024 at 07:44:24PM -0500, David Lechner wrote:
> > > This adds a new property to the spi-peripheral-props binding for use
> > > with peripherals connected to controllers that support offloading.
> > >
> > > Here, offloading means that the controller has the ability to perform
> > > complex SPI transactions without CPU intervention in some shape or fo=
rm.
> > >
> > > This property will be used to assign controller offload resources to
> > > each peripheral that needs them. What these resources are will be
> > > defined by each specific controller binding.
> > >
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > >
> > > v2 changes:
> > >
> > > In v1, instead of generic SPI bindings, there were only controller-
> > > specific bindings, so this is a new patch.
> > >
> > > In the previous version I also had an offloads object node that descr=
ibed
> > > what the offload capabilities were but it was suggested that this was
> > > not necessary/overcomplicated. So I've gone to the other extreme and
> > > made it perhaps over-simplified now by requiring all information about
> > > how each offload is used to be encoded in a single u32.
> >
> > The property is a u32-array, so I guess, not a single u32?
>=20
> It is an array to handle cases where a peripheral might need more than
> one offload. But the idea was it put everything about each individual
> offload in a single u32. e.g. 0x0101 could be offload 1 with hardware
> trigger 1 and 0x0201 could be offload 1 with hardware trigger 2. Then
> a peripheral could have spi-offloads =3D <0x0101>, <0x0201>; if it
> needed to select between both triggers at runtime.
>=20
> >
> > > We could of course consider using #spi-offload-cells instead for
> > > allowing encoding multiple parameters for each offload instance if th=
at
> > > would be preferable.
> >
> > A -cells property was my gut reaction to what you'd written here and
> > seems especially appropriate if there's any likelihood of some future
> > device using some external resources for spi-offloading.
> > However, -cells properties go in providers, not consumers, so it wouldn=
't
> > end up in spi-periph-props.yaml, but rather in the controller binding,
> > and instead there'd be a cell array type property in here. I think you
> > know that though and I'm interpreting what's been written rather than
> > what you meant.
>=20
> Indeed you guess correctly. So the next question is if it should be
> the kind of #-cells that implies a phandle like most providers or
> without phandles like #address-cells?

I'm trying to understand if the offload could ever refer to something
beyond the controller that you'd need the phandle for. I think it would
be really helpful to see an example dt of a non-trivial example for how
this would work. The example in the ad7944 patch has a stub controller
node & the clocks/dmas in the peripheral node so it is difficult to
reason about the spi-offloads property there.

> Asking because I got pushback on
> v1 for using a phandle with offloads (although in that case, the
> phandle was for the offload instance itself instead for the SPI
> controller, so maybe this is different in this case?).

Do you have a link to this v1 pushback? I had looked at the v1's binding
comments and didn't see that type of property being resisted - although
I did see some resistance to the spi peripheral node containing any of
the information about the offloads it had been assigned and instead
doing that mapping in the controller so that the cs was sufficient. I
don't think that'd work with the scenario you describe above though
where there could be two different triggers per device tho.

Cheers,
Conor.

--YoB/os18honPkEB1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkOxmwAKCRB4tDGHoIJi
0sUTAP4khgtxC6wlzfwZElyG7iZX6IfaDBVnABDW8tZkvQb02QEAnHyPkOG/dtFW
Y3rBnT0cU80kpSZ/14hIBFDSyGmrtgg=
=C158
-----END PGP SIGNATURE-----

--YoB/os18honPkEB1--

