Return-Path: <linux-iio+bounces-5786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054178FBCB4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 21:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359191C2297A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416914B094;
	Tue,  4 Jun 2024 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4+7ieW2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8AB644;
	Tue,  4 Jun 2024 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717530181; cv=none; b=g8AZF5uHFtkgRMaVtcVHh8KrVJ2H66JniaUxhkHwntFQMCa7befMX8R0z1qUFvVAUTB/vJ+dM2X1JmAFxsQWPj90eC97yIPWOSRcgcnxvJfJYl3rZMbwhlE2+yTqMFC8Pv24FuOaQ9zfZXz10vBC8Ku3plxrIhwLpcoiTBsmC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717530181; c=relaxed/simple;
	bh=ldmOMzI6JKAvFAm66/33xSFPao4cv5kL7TgZC2bsqb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj/BoE+oDiRF8IxFHX2qxaNXRpQZWD390WnFRmkD+wBRJixl0LJeBKLLdSfTvaMw+DRQymLgBSIMM2ts/5ar9/fRunG6O/xJQ5W6I7ahv+VtJ4jWtKSHPhUVjA6Rsh4MMM+O5GORf/7E9wD8WibfThP1215DwdP4CDlJ14cUZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4+7ieW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2104CC2BBFC;
	Tue,  4 Jun 2024 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717530181;
	bh=ldmOMzI6JKAvFAm66/33xSFPao4cv5kL7TgZC2bsqb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4+7ieW2lrkBPI/ORGDstBDLJ0waUKV/32518A4MoIvMgYZ1saGUFqsnuNVYM+GKd
	 RT+nVsbnCMGYM5UsUxzels6jUFEXQ1UadoCsarf1vPNGan3+4lO/D0TkHOppUl0Y/W
	 nNkvlf1wYGrp4WG42l0x4QG/IPr0HgXyGtk/9nfeZYPjGBbRLqd/aOUYG1oIGPBfl3
	 GO7aYTFhY6z6btrIMDeqWn93aWjURud6vd/SlTcosNuPVSOFvEJR42HelD/eYzg1P9
	 lJJ7EUXgGdNiNf/dxPjzCnuBGOD4Bm+erVO3pcArVzpG6+9R3xNXNiF55MLj+8VHkD
	 Bsdtd+IfQRM0w==
Date: Tue, 4 Jun 2024 20:42:55 +0100
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
Message-ID: <20240604-awry-container-a8c12f421a81@spud>
References: <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
 <20240526-peculiar-panama-badda4f02336@spud>
 <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>
 <6db8ba66-841b-4425-9dd4-9d6e7b0463bf@baylibre.com>
 <20240604-oink-recognize-682c553a18e5@spud>
 <97246fdc-bb33-45bc-a24a-c2595920421f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N7XUnDPkHiYJyKjd"
Content-Disposition: inline
In-Reply-To: <97246fdc-bb33-45bc-a24a-c2595920421f@baylibre.com>


--N7XUnDPkHiYJyKjd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 02:39:18PM -0500, David Lechner wrote:
> On 6/4/24 2:33 PM, Conor Dooley wrote:
> > On Thu, May 30, 2024 at 02:24:17PM -0500, David Lechner wrote:
> >> On 5/29/24 3:07 AM, Nuno S=E1 wrote:
> >>> On Sun, 2024-05-26 at 18:35 +0100, Conor Dooley wrote:
> >>
> >>
> >>>> It might be easy to do it this way right now, but be problematic for=
 a
> >>>> future device or if someone wants to chuck away the ADI provided RTL=
 and
> >>>> do their own thing for this device. Really it just makes me wonder if
> >>>> what's needed to describe more complex data pipelines uses an of_gra=
ph,
> >>>> just like how video pipelines are handled, rather than the implement=
ation
> >>>> of io-backends that don't really seem to model the flow of data.
> >>>>
> >>>
> >>> Yeah, backends is more for devices/soft-cores that extend the functio=
nality of the
> >>> device they are connected too. Like having DACs/ADCs hdl cores for co=
nnecting to high
> >>> speed controllers. Note that in some cases they also manipulate or ev=
en create data
> >>> but since they fit in IIO, having things like the DMA property in the=
 hdl binding was
> >>> fairly straight.
> >>>
> >>> Maybe having an offload dedicated API (through spi) to get/share a DM=
A handle would
> >>> be acceptable. Then we could add support to "import" it in the IIO co=
re. Then it
> >>> would be up to the controller to accept or not to share the handle (i=
n some cases the
> >>> controller could really want to have the control of the DMA transfers=
).
> >>
> >> I could see this working for some SPI controllers, but for the AXI SPI=
 Engine
> >> + DMA currently, the DMA has a fixed word size, so can't be used as a =
generic
> >> DMA with arbitrary SPI xfers. For example, if the HDL is compiled with=
 a 32-bit
> >> word size, then even if we are reading 16-bit sample data, the DMA is =
going to
> >> put it in a 32-bit slot. So one could argue that this is still doing s=
ome data
> >> manipulation similar to the CRC checker example.
> >>
> >>>
> >>> Not familiar enough with of_graph so can't argue about it but likely =
is something
> >>> worth looking at.
> >>
> >> I did try implementing something using graph bindings when I first sta=
rted
> >> working on this, but it didn't seem to really give us any extra useful
> >> information. It was just describing connections (endpoints) that I tho=
ught
> >> we could just implicitly assume. After this discussion though, maybe w=
orth
> >> a second look. I'll have to think about it more.
> >=20
> > Could you elaborate on why you think you can assume the connections? Wh=
at
> > happens when you have multiple stages of data processing and/or multiple
> > ADCs in your system? As I've previously said, I work on FPGA stuff, and
> > everyone here seems to fawn over having <insert custom DSP IP here> in
> > their data pipelines. I can't imagine it being any different for ADC da=
ta,
> > and an io-backend property that doesn't describe how the data flows is
> > gonna become lacklustre I think.
>=20
> I was more ignorant back then. :-)
>=20
> That is is why I said "thought" instead of "think". I am more enlightened=
 now.

Heh, I didn't mean it in a bad way. I just wanted to flesh out why you
thought that way.


--N7XUnDPkHiYJyKjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9uPwAKCRB4tDGHoIJi
0gwfAP0Q76wab6QDgYXt0Men77yN9JCHnEby3Na84zUrczGQrwD/Xx9CS+IrehyC
9K6TFblM4VF6C/kX3HPENblvp8eKvw4=
=LGFO
-----END PGP SIGNATURE-----

--N7XUnDPkHiYJyKjd--

