Return-Path: <linux-iio+bounces-7106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C8891E7D8
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 20:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902D42867C3
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 18:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9F716F27F;
	Mon,  1 Jul 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSyHjfU9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1416F26C;
	Mon,  1 Jul 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859093; cv=none; b=lanjaAkTIOil6i1oQSKx8IORRxDiDitnVBS31QcgY84ztupfZUy3ISCo9ciQ2pirzbI1xJ6a45RQ2F0KwqSup7uD0PFhwwds7GkZclw10/Gh/vPEWLW0XRO2RSrqSSJsPYQR4oyP+VMOFLiWJohMa/eFAfWBWaLRBu9l6NBPsoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859093; c=relaxed/simple;
	bh=AX3Burc+jVtSsnnqyFaj57eodtlYTSR/s+lG7Ov1sgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWE/V2RxJ1vL8SR/AyHbXYLFY4Rq+Jfwc7jZdwmQ7GF5x94t3oezgury6fI2UtGnU+209BLJnuiNjrAq94Kvy9udj+3XEWjR6CW3Hlno/1Plx8OS1kD29FdFAXBdBDgTx5jc8f+Z/4MU7Hlcj3DpPiPi2pqSB/ahvflxrXPmrQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSyHjfU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DF2C116B1;
	Mon,  1 Jul 2024 18:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719859093;
	bh=AX3Burc+jVtSsnnqyFaj57eodtlYTSR/s+lG7Ov1sgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSyHjfU9W8vGs6ErMsERYxc7l6R+5ipDNqZ2WOFY+pAntHp9Bru4N7DeebcQRYEKt
	 MPVB3gx2g7JV7UY08ap+VjNYlDzPqSlchKb+9IyVZznt9glZbc1NMUNlicbbRKPyj/
	 i2VT46ecWjmXTYRbFT2ozagHlpJ+a4bhmRELY0Sazw7jl6Bf/uKprk8QKN9P0jzFf5
	 3TDY1AE9UK9ftqm6Kyf+HhV8UKpbyRjR5u9Oom0AOI+xJ6zY5/CuibBvgcU76J+oO3
	 KOkRtB0c2HuN9gWL7PKTw4WxuCpVBbrcTVnPZac6/3zrnwn0spvX9z8OVnnVUM0r8g
	 1Hgp+uo4Vxcmw==
Date: Mon, 1 Jul 2024 19:38:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, corbet@lwn.net,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] iio: adc: Add support for AD4000
Message-ID: <152ba099-7610-478b-8465-49d9e5adffd0@sirena.org.uk>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
 <628a85cb8cbee32ea7d2930c63e73f2ef449a800.1719686465.git.marcelo.schmitt@analog.com>
 <20240630121726.5d75578e@jic23-huawei>
 <ZoLxLgpy44S38nSe@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vlIPlvW+fKtcuuHS"
Content-Disposition: inline
In-Reply-To: <ZoLxLgpy44S38nSe@debian-BULLSEYE-live-builder-AMD64>
X-Cookie: Microwaves frizz your heir.


--vlIPlvW+fKtcuuHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 03:10:54PM -0300, Marcelo Schmitt wrote:
> On 06/30, Jonathan Cameron wrote:
> > Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> > > +	struct spi_transfer t =3D {
> > > +		.tx_buf =3D st->tx_buf,
> > > +		.rx_buf =3D st->rx_buf,
> > > +		.len =3D 2,
> > > +	};

> > I'd be tempted to do

> > 	ssize_t ret;
> >=20
> > 	ret =3D spi_w8r8(AD4000_READ_COMMAND);

> I tried this when working on v6. Only difference was I had declared ret a=
s int.
> Then reg values were not read correctly with spi_w8r8().
> I'm either missing something or reg access must be 16-bit transfer.
> Datasheet sais:
> "The AD4000/AD4004/AD4008 configuration register is read from and written=
 to
> with a 16-bit SPI instruction."
> Yet, besides possible delay between first and last 8 SCLK pulses, I don't=
 see
> any transfer level differences between current and spi_w8r8() versions.

It is possible the chip gets upset with the state of the idle line
during the RX only or TX only portion of the transfer.

>=20
> >=20
> >=20
> ...
> > > +			ret =3D ad4000_write_reg(st, reg_val);
> > > +			if (ret < 0)
> > > +				return ret;
> > > +
> > > +			st->span_comp =3D span_comp_en;
> > > +			return ret;
> >=20
> > If you are spinning for another reason, make it clear this is always go=
od.
> > The spi_write() never returns positive so current code is correct but I=
 had
> > to go check which this would have avoided.
> >=20
> > 			return 0;
>=20
> Ack
> >=20
> > If nothing else comes up, I'll probably tweak whilst applying.
> >=20
> > J
> >=20
> > > +		}
> > > +		unreachable();
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> >=20

--vlIPlvW+fKtcuuHS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaC944ACgkQJNaLcl1U
h9D8mwf/fLAAQ6d+jz6IWF9+lHbZcHpYz4U1qtMVOTEwlcyyObhiyLG+zZFIRrrZ
80bLCIzF1ST4jCHXer4FT2bmwK0ItVpV7DR1n+YfXIu/4Zt8TISh4ViHHa6gZKNo
Ggxvea/jOMcToMTpIqj4el5fvIM2MgozOiaNxDgUlBHG5Edu4BAPCy13AQdvfJ2/
thc6NoeBrY70l/l5L/PWJBkJdXt8yh/4H5MocWtr9SQYhHwWRiQoyftYbDrakNby
CfcD63Uh3WrEtWvdgYjwjUgg7yPdx5kQCFbpGXu4NA86Gh1V1oW14mk3s0WObxa+
ha3wV0ZtQKfaYElnEtfG2iL+mab5Xw==
=FfdN
-----END PGP SIGNATURE-----

--vlIPlvW+fKtcuuHS--

