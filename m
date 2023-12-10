Return-Path: <linux-iio+bounces-803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5642A80BB84
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 15:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA38BB20AC6
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA185125D7;
	Sun, 10 Dec 2023 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVPAySGe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B831170D;
	Sun, 10 Dec 2023 14:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448C4C433C8;
	Sun, 10 Dec 2023 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702217096;
	bh=lVPE/Le+aoNzulgdaViip541AUaXVauyBYjq7TKNphQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVPAySGesyIctT8PT4TyCRB7G6Jf4OLhwoTuOOCUCxpBRQSZ0Mj5V3rmrybikpwzc
	 qlKi0wb5fsYdoXzQ869lZYK8+3519NDkr0xjcEsPzF8PNjGXWS7XcAHXolIO7b2h8S
	 rwfxIAh+5HA8/1bnJLx4YucrJSBvYFXTb6H1Ua1S2wCsbnS8IFxE5NzaXQ/ozwmpy3
	 b/VNxi9v8kqG3nkbNJ29llHuY5PdaeeU3myfLvSMHqW6XYf9ujcHpmRMsscknVlrzm
	 5wUUWNIplIMjaEDKqhJcNv+foVFOVk8Eq1HbuAYvhEVC/RDAV6sv3pl9XTD5veGB/C
	 QDMyINM+oUwMA==
Date: Sun, 10 Dec 2023 14:04:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 0/8] iio: add new backend framework
Message-ID: <20231210-salvation-ascend-8d10ab098f56@spud>
References: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
 <20231208-corridor-outfit-ae0314b29186@spud>
 <a59232317228f2d459a9c3fba63596daec988520.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SRj99OmUyFA8ISeq"
Content-Disposition: inline
In-Reply-To: <a59232317228f2d459a9c3fba63596daec988520.camel@gmail.com>


--SRj99OmUyFA8ISeq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 03:32:33PM +0100, Nuno S=E1 wrote:
> On Fri, 2023-12-08 at 15:30 +0000, Conor Dooley wrote:
> > On Fri, Dec 08, 2023 at 04:14:07PM +0100, Nuno Sa via B4 Relay wrote:
> > > This series depends on [1] and it only build on top of it. The point =
is
> > > to already speed up the reviewing of the framework. That obviously me=
ans
> > > that all those pacthes were dropped in v2.
> > >=20
> > > v1:
> > > =A0
> > > https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawe=
i/T/#m222f517
> > > 5273b81dbfe40b7f0daffcdc67d6cb8ff
> > >=20
> > > Changes in v2:
> > > =A0- Patch 1-2 and 5
> > > =A0=A0 * new patches.
> > > =A0- Patch 6:
> > > =A0=A0 * Fixed some docs failures;
> > > =A0=A0 * Fixed a legacy 'conv' name in one of the function parameters;
> > > =A0=A0 * Added .request_buffer() and .free_buffer() ops;
> > > =A0=A0 * Refactored the helper macros;
> > > =A0=A0 * Added Olivier as Reviewer.
> > > =A0- Patch 7:
> > > =A0=A0 * Use new devm_iio_backend_request_buffer().
> > > =A0- Patch 8:
> > > =A0=A0 * Implement new .request_buffer() and .free_buffer() ops;
> > >=20
> > > Also would like to mention that in v2 I'm experimenting in having the
> > > DMA on the backend device (as discussed with David in v1). Does not l=
ook
> > > to bad but as I said before, I'm not seeing a big issue if we end up
> > > having the buffer allocation in the frontend.
> > >=20
> > > For the bindings folks:
> > >=20
> > > I'm introducing a new io-backends property in the ad9467 bindings but=
 I'm
> > > not sure this is the way to do it. Ideally that new property become a
> > > generic schema and I'm guessing I should send a PULL to?
> > >=20
> > > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schema=
s/iio/iio-consumer.yaml
> >=20
> > That seems like the right thing to do to me, depending on how widespread
> > the use of these backends might be. What is seemingly missing though,
> > from this cover and from the bindings patch in the series in particular,
> > is an explanation of what the "iio-backends" hardware actually is.
> >=20
>=20
> Yeah, sorry about the bindings patch but I was already with the feeling t=
hat a PR in
> devicetree-org to be the right place. I'll be adding more drivers needing=
 that
> property and STM also wants make use this.
>=20
> I'll improve on the explanation and send a PR for a generic schema.
>=20
> > There is some text below, but it does not seem complete to me. Is the
> > idea that this "backend" is shared between multiple frontend consumers?
> > The one example is described as being "highly focused on ADI usecases"
> >=20
>=20
> For now it cannot really be shared. The code is not prepared for it (we w=
ould need to
> keep enable/disable counters etc...). For now, I'm just adding the simple=
r cases of
> 1:1 and 1:n (1 frontend for multiple backends). Internally we do have 1:n=
 designs
> that I definitely want (in time) to bring upstream.

TBH, I am not really interested in whether or not the drivers support it
at the moment, it just be great if the explanation of how these backends
work (the hardware, not the linux implementation) included that detail.
>=20
> That said, having a usecase for it in the future, it is something that ca=
n be added,
> yes...
>=20
> Thanks for the feedback!
> - Nuno S=E1
> >=20
>=20

--SRj99OmUyFA8ISeq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXXFggAKCRB4tDGHoIJi
0qcXAP97NN3400TlUtWmsLQXBVSV1zQfyQQn/OigWuf7ZduymgEAlD68YUmEcmpS
P3uBB8ksI6Kni1XVB/n607GLolQBjQc=
=zPa1
-----END PGP SIGNATURE-----

--SRj99OmUyFA8ISeq--

