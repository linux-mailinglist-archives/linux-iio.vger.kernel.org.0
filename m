Return-Path: <linux-iio+bounces-25091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BBEBDE5EC
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 14:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496E2480E7D
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 12:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BACF3233F5;
	Wed, 15 Oct 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnenWbwb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBEB21323C;
	Wed, 15 Oct 2025 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529694; cv=none; b=EXiI3C/qxwFpk0w2bRu6XeGQxeDS+r15steHDJVIbTKG7G0P/7z0YetJ9R6s2ZpU/oMl209A3zrLyJ2tWVkJ4ZR+sjDa/PlVJG/EqjQbH+Z08G42VFkerCPziNz6t8cNOlo5lrOwa1BCcbFNsbojFnoe8JCZxgzyUjx9rc3Ocyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529694; c=relaxed/simple;
	bh=8s7fvMHxfTzM3EvYSwYFuo1FYbApecy9Axtad/xbwF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0ktPTY63627rWyGY3DzCOgvZIRNxMJ34GzeO/2DJRKjKGM5/sIizmWC/cbX/XkL0nsA4hSbVie41rtZx49Tgg3VJ1v9b7ONb2YBEcfY15Pe9hcVBj1o8nAAL1+B2f2rnQ4cWXT+L1mkVb0a0Jm2tao0thorRmNhEBEc6JQV9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnenWbwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A904C4CEF8;
	Wed, 15 Oct 2025 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760529693;
	bh=8s7fvMHxfTzM3EvYSwYFuo1FYbApecy9Axtad/xbwF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnenWbwbRYAwQnGlnDiEWfsP5P1Y0vu7dJcIutQilEDGqNQiTjIOiA2isbC6SO+ne
	 AFW/Ntp0NL+PkJLkoAT/vmw+scXjLjUZJfxbNcctuf3BD8lji3tOsnOdtF4HzOXBvq
	 IOkLK0ADuQexcABtAxOWCqJdZ7sWqtYzHcny9HE3Z79bW0Aq1ialA8DnoHQX4ZlZam
	 n4C0cMl0SDDVcI3QBGggJXvPjgTmbuTE8f9cdCwh84H9tV5bbCGpGMdxvXdOLtD5ru
	 i+s60/aHGEa0CaGHIvTxOVyuIp/Cq60blCDCyVUSaxTqxwv4hRN5DGny4/oIg2nkRs
	 ocaTioFYt6OBg==
Date: Wed, 15 Oct 2025 13:01:23 +0100
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
Message-ID: <409ad505-8846-443e-8d71-baca3c9aef21@sirena.org.uk>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
 <9269eadc1ea593e5bc8f5cad8061b48220f4d2b2.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ujXhcrR05EXINnYo"
Content-Disposition: inline
In-Reply-To: <9269eadc1ea593e5bc8f5cad8061b48220f4d2b2.camel@gmail.com>
X-Cookie: Long life is in store for you.


--ujXhcrR05EXINnYo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 11:16:01AM +0100, Nuno S=E1 wrote:
> On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:

> > =A0=A0=A0=A0=A0=A0=A0 controller=A0=A0=A0 < data bits <=A0=A0=A0=A0 per=
ipheral
> > =A0=A0=A0=A0=A0=A0=A0 ----------=A0=A0 ----------------=A0=A0 ----------
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SDI 0=A0=A0=A0 0-0-0-1-0-0-0-1=A0=A0=
=A0 SDO 0
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SDI 1=A0=A0=A0 1-0-0-0-1-0-0-0=A0=A0=
=A0 SDO 1

> Out of curiosity, how does this work for devices like AD4030 where the sa=
me word
> is kind of interleaved between SDO lines? I guess it works the same (in t=
erms of
> SW) and is up to some IP core (typically in the FPGA) to "re-assemble" th=
e word?

So combined with the existing parallel SPI support?

--ujXhcrR05EXINnYo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjvjRIACgkQJNaLcl1U
h9CF1wf/dUWV9762+d8pAi8WCNY/L16hRGTQEWpyX0h5rV275wGLwBXjSQ+yyTAz
pgmyxhAnLdiNaIL39xa+Ri2xEYBxIGMrwk7KdPBDbioZRAP+niC8yTjPdK2wm5Ex
wVTP6376LsvDGLD50I0k+MHAYNiCOYlWXqiwBMIwMrwhWeEY3wzKC1hvdWyEkSA9
m1Ecl+TmfJaT5UvO/lxMU8WRttC5kOZysC/yBPffrWE325P7negBBypwTuP5vIXZ
eii0rnPykREF4clc3d1R79kZPjyytBywvD4lmQQcDWd1jGNCqjHDgdBqFBeJpKC4
Qo48A0C8QxFmE0E3LICNJcau0QtZHA==
=P/qz
-----END PGP SIGNATURE-----

--ujXhcrR05EXINnYo--

