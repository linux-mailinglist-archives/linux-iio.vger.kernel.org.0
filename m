Return-Path: <linux-iio+bounces-5784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3B28FBC9E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 21:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D950128412E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91E14B077;
	Tue,  4 Jun 2024 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbG8KyuU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE826B644;
	Tue,  4 Jun 2024 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529595; cv=none; b=niN4EUJWwdsR9Z1WXtuSwocaW9gN2V7UcmkhY9jbVW60g5Tt15Jnff0ldb48wnFkYpXsC1VfQHWFWaBy/tDf7alRpJs/9VVjLafwEdK4jPu98QekTeVgqs65PydfvgLb75f6BD+T2EmVYpiB0KYSpm5wWiR04a5exge6QzK8zYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529595; c=relaxed/simple;
	bh=45DGGWKPvD/N1GwT6qtTMsN66/rfanzNA+/y+7nFmzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyjZ9/vV4+y/hQmSTY+fqUQ2QBP50pc+eL07m9Olt5jJP9MOI3UBnAGkcXVggMWtCdwUhoGkq+O5t3GdrH45UpyrW5PPVqTxEg+kTI/0RD2TQ8v6na3aNZlU9zjDeUkHLPt9I1uTS2HYUZAbELJahVofbOAr7iyzegWC3PKZ3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbG8KyuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451D3C4AF08;
	Tue,  4 Jun 2024 19:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717529594;
	bh=45DGGWKPvD/N1GwT6qtTMsN66/rfanzNA+/y+7nFmzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbG8KyuUPE5BcI99P3dBIisDQwoa3qYmUVOTxlfE576mzDTlr3phZeOzW7nzHP8xK
	 9yiZ5+zjwiOy6LVEx6gEiZ/9U7Rvo4iRG8LcEzO3S4NPKqC/kcVVpfoUQbyGDNczNS
	 IJHUHx4Oonjh8wpNyDGhYCsBvB2cTr9d22WFHe/EVHZed6BsHe4UVWCq4tR8ay4wvm
	 OjLUxxj66+jdiPKeXRUNaZGDdgHQe/xZkFnJ+DF0g5516oDyiqz/JZBEEr94F6iH03
	 3keuXSG3PpCtq/lQhdeRwWm9oHLYvxQyxESc47mCzailSXEK4UMsfEFWM040eUFzSX
	 WoxNXjmp1h5Aw==
Date: Tue, 4 Jun 2024 20:33:09 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20240604-oink-recognize-682c553a18e5@spud>
References: <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
 <20240526-peculiar-panama-badda4f02336@spud>
 <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>
 <6db8ba66-841b-4425-9dd4-9d6e7b0463bf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GLR3h2moiGY7Pkex"
Content-Disposition: inline
In-Reply-To: <6db8ba66-841b-4425-9dd4-9d6e7b0463bf@baylibre.com>


--GLR3h2moiGY7Pkex
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 02:24:17PM -0500, David Lechner wrote:
> On 5/29/24 3:07 AM, Nuno S=E1 wrote:
> > On Sun, 2024-05-26 at 18:35 +0100, Conor Dooley wrote:
>=20
>=20
> >> It might be easy to do it this way right now, but be problematic for a
> >> future device or if someone wants to chuck away the ADI provided RTL a=
nd
> >> do their own thing for this device. Really it just makes me wonder if
> >> what's needed to describe more complex data pipelines uses an of_graph,
> >> just like how video pipelines are handled, rather than the implementat=
ion
> >> of io-backends that don't really seem to model the flow of data.
> >>
> >=20
> > Yeah, backends is more for devices/soft-cores that extend the functiona=
lity of the
> > device they are connected too. Like having DACs/ADCs hdl cores for conn=
ecting to high
> > speed controllers. Note that in some cases they also manipulate or even=
 create data
> > but since they fit in IIO, having things like the DMA property in the h=
dl binding was
> > fairly straight.
> >=20
> > Maybe having an offload dedicated API (through spi) to get/share a DMA =
handle would
> > be acceptable. Then we could add support to "import" it in the IIO core=
=2E Then it
> > would be up to the controller to accept or not to share the handle (in =
some cases the
> > controller could really want to have the control of the DMA transfers).
>=20
> I could see this working for some SPI controllers, but for the AXI SPI En=
gine
> + DMA currently, the DMA has a fixed word size, so can't be used as a gen=
eric
> DMA with arbitrary SPI xfers. For example, if the HDL is compiled with a =
32-bit
> word size, then even if we are reading 16-bit sample data, the DMA is goi=
ng to
> put it in a 32-bit slot. So one could argue that this is still doing some=
 data
> manipulation similar to the CRC checker example.
>=20
> >=20
> > Not familiar enough with of_graph so can't argue about it but likely is=
 something
> > worth looking at.
>=20
> I did try implementing something using graph bindings when I first started
> working on this, but it didn't seem to really give us any extra useful
> information. It was just describing connections (endpoints) that I thought
> we could just implicitly assume. After this discussion though, maybe worth
> a second look. I'll have to think about it more.

Could you elaborate on why you think you can assume the connections? What
happens when you have multiple stages of data processing and/or multiple
ADCs in your system? As I've previously said, I work on FPGA stuff, and
everyone here seems to fawn over having <insert custom DSP IP here> in
their data pipelines. I can't imagine it being any different for ADC data,
and an io-backend property that doesn't describe how the data flows is
gonna become lacklustre I think.

--GLR3h2moiGY7Pkex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9r9QAKCRB4tDGHoIJi
0tROAP95DZ+XUmcMDsCfW2HqdUY9Lf66eV6OgriwvanxoSvCXQD/RUTm1Y+CkknC
uxGCqCSsLwCd5Mp+7iBsw5m0OcfxBQ8=
=ZXDh
-----END PGP SIGNATURE-----

--GLR3h2moiGY7Pkex--

