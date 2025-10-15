Return-Path: <linux-iio+bounces-25101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8A7BDF4F2
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 17:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C828A19A0DCF
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15042FB0B5;
	Wed, 15 Oct 2025 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUxnLGGL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7C2FABE6;
	Wed, 15 Oct 2025 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541492; cv=none; b=PBWJXppEjA5zS7yULwPL/4i6rbsq5r1nJvZHMvn/OYbnZR8RBCfu/xP4fasydZbYznXylz6EFxtCYaGXd/MFONEa2Q+HeL4NV1DeyBoyCwZenTc5GBDa0q6HvWzOBV0yTSKRyFwOlI3qCjsx3ZjVGyKqGgZypMFdHceJbxJIfmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541492; c=relaxed/simple;
	bh=uHPoJ+XDxm8fGAJXTft1xVTIPKhJBvXP8Sgc89WODPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4xp7d6apGQImFgqSVQW8KxKmHMAiViWXD3AFk2DWpZpNxmFw/yoYV/I6P8qH7ULZs0/m2ZtsiPrt6pW/P30ZnFnOxO42s1Ghtg7Y/zOW5aKTpcBzLtQG3DMtHFjiBVzu77QbgLoYsxLtxXsOh4n2/7tkyN02OOLPmmVHYjUFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUxnLGGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E183AC4CEF8;
	Wed, 15 Oct 2025 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760541492;
	bh=uHPoJ+XDxm8fGAJXTft1xVTIPKhJBvXP8Sgc89WODPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUxnLGGLil/hEpoJqMgZ2OU0Oq1DxrcBFu8qHeOnFR6DywRGzVOJ0GZfueGloi6nS
	 dPzchaDG9Ffni0l81PSeXK7ho4BLvP5c3YDqBNvRI6zXeELo4jpKDHvbP48agC/QqO
	 7st+K+XEC1MGM/wklzp/OLZ+or+GUgVo0mEprFm2+n8ut1qwITWkP6UXxcd2AULuol
	 /uOdGIO+zib/asGLzxNLPsAcYWUhsvxM/QpI9nI2BC+V3ZLshTEhtsLrHzJ0i5lvqj
	 IvgoS46dqIGnF+Bcv6cbhiURtoOTuIBsS3vOifSPBcGbDk9cvSU80AHyf6926rPAcq
	 z93MGIGHJOWkQ==
Date: Wed, 15 Oct 2025 16:18:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/6] spi: add multi_bus_mode field to struct spi_transfer
Message-ID: <8c7bf62a-c5dc-4e4d-8059-8abea15ba94e@sirena.org.uk>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
 <9269eadc1ea593e5bc8f5cad8061b48220f4d2b2.camel@gmail.com>
 <409ad505-8846-443e-8d71-baca3c9aef21@sirena.org.uk>
 <12db0930458ceb596010655736b0a67a0ad0ae53.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VydopxqU1EZbMNWE"
Content-Disposition: inline
In-Reply-To: <12db0930458ceb596010655736b0a67a0ad0ae53.camel@gmail.com>
X-Cookie: Long life is in store for you.


--VydopxqU1EZbMNWE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 03:43:09PM +0100, Nuno S=E1 wrote:
> On Wed, 2025-10-15 at 13:01 +0100, Mark Brown wrote:
> > On Wed, Oct 15, 2025 at 11:16:01AM +0100, Nuno S=E1 wrote:
> > > On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:

> > > > =A0=A0=A0=A0=A0=A0=A0 controller=A0=A0=A0 < data bits <=A0=A0=A0=A0=
 peripheral
> > > > =A0=A0=A0=A0=A0=A0=A0 ----------=A0=A0 ----------------=A0=A0 -----=
-----
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SDI 0=A0=A0=A0 0-0-0-1-0-0-0-1=A0=
=A0=A0 SDO 0
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SDI 1=A0=A0=A0 1-0-0-0-1-0-0-0=A0=
=A0=A0 SDO 1

> > > Out of curiosity, how does this work for devices like AD4030 where th=
e same
> > > word
> > > is kind of interleaved between SDO lines? I guess it works the same (=
in
> > > terms of
> > > SW) and is up to some IP core (typically in the FPGA) to "re-assemble=
" the
> > > word?

> > So combined with the existing parallel SPI support?

> Not sure if this is meant for me :). parallel SPI is for parallel memorie=
s and
> the spi_device multi cs support stuff right? I tried to track it down but=
 it's
> not clear if there are any users already upstream (qspi zynqmp and the nor
> flashes). It looks like it's not in yet but not sure.

There's multi-CS stuff but what I was thinking about was the stuff for
parallel memories, I was trying to clarify what cases you were talking
about with "interleaved between SDO lines".

> Anyways, IIUC, it seems we could indeed see the device I mentioned as a p=
arallel
> kind of thing as we have one bit per lane per sclk. However, the multi_cs
> concept does not apply (so I think it would be misleading to try and hack=
 it
> around with tweaking cs_index_mask and related APIs).

OK, so either just the parallel SPI or possibly that composed with this
(fun!).

--VydopxqU1EZbMNWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjvuy0ACgkQJNaLcl1U
h9A9fwf9HKFZXnDsRgTgE9HMei//SyHircumbi19Y5BgrFH1ZuEgJQvO+txFYloA
+1MW1ydyFc2X3hPQJfCGPjdiOA2YBhdl83Jm5n5YODHjzD25r23QHkFx7ipDqHcq
sEXXHF3Ti7Tw5WONXObua6+ieJg/4VlUd0dWiF9OcLBqOi8AJl43bpxvKv94aPHx
RTh/Q/SHiHX5agKXCdlmwwfDTfvYi8oTYTxWL/M55pWol1AWb2SHi/2+eHTOr6t+
BmWzfqNvz6LUPBYLA2uvTAJGSdSoEy0nsrKjbQsqU+kd93hozZFYyIDkc6MraVbH
7YuuL+JhnF8YJgk14gxdsRJkNC65+Q==
=v7SV
-----END PGP SIGNATURE-----

--VydopxqU1EZbMNWE--

