Return-Path: <linux-iio+bounces-7018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A049091C301
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 17:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24441C22A03
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE8E1C68BC;
	Fri, 28 Jun 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTzHK5yg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D61DDCE;
	Fri, 28 Jun 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590142; cv=none; b=t4UwuRVZItlbZdu4QxL3I3dczJpUgEOwxMwMjOzswgQxx0gY9cuzROOQ3y+jyPgHkDMUwVIWI6IX4Ct+XpfdZfUzc75ZQoqUl5EPfBLDGnUI1mfDUTcxngftft8/mUIJsUl68wiDVnNXNPTLt796q+u5B+qoWTaT7OQIi8kcFZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590142; c=relaxed/simple;
	bh=URRi992TQ7aXCtyL2imN9bCzmKL0wiYUQpclACuFpEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOeB/qw4kdaPFZKiQUmSGmn+bsnMmZKUsy+keIY55zfiQtIZuv2J5gqfD8Gvyyd53JaekN1wja+WjXRN8z3eQ/G3qfAzpZamYsezn96SHA3MGzOvrSzBakwz1LkxiUDfesRWU7y4SSbfu9Gw8zpch8tTZLlSxREDWxa5URjVz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTzHK5yg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31636C116B1;
	Fri, 28 Jun 2024 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719590142;
	bh=URRi992TQ7aXCtyL2imN9bCzmKL0wiYUQpclACuFpEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iTzHK5ygWsirW9aK+43y3X2uup/IgkEIgGiT6SOMnRcuS1up+rXFY1e31RrM2FFKy
	 87LrJamCoDHm3W4b64NwOZYrUepnuYJhSTdN++BNwYUGDGMb/Px7Wu1F795fLkx2eI
	 8re0TJd6xIzEYmrHzJvoRocU4tn8HoY51lrvqTbL50r52QkbWd2AXtwuolpe8NhFni
	 H5cRIgOfOsX+/VWhVMmXqqqRurvYKyy5x9Z5ojjuhNO4VQVoZdmNPZ7gmD0QpXqYMd
	 GWTa0eRb4WWyVmty/HNHpzkaZ7cXzQFvAoa8byXGYG/3lolo/9a2BD5tEDXlfGV/UR
	 t46LBkQytKbqw==
Date: Fri, 28 Jun 2024 16:55:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Beniamin Bia <beniamin.bia@analog.com>,
	Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH v2 00/10] iio: adc: ad7606: Improvements
Message-ID: <20240628-postwar-scaling-cb7d7b1f4f3c@spud>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
 <20240628-trustful-urchin-741943d2e98d@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1r0wTlUg045hSqKl"
Content-Disposition: inline
In-Reply-To: <20240628-trustful-urchin-741943d2e98d@spud>


--1r0wTlUg045hSqKl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 04:53:50PM +0100, Conor Dooley wrote:
> On Fri, Jun 28, 2024 at 02:48:18PM +0000, Guillaume Stols wrote:
> > This series adds the following improvements over the current AD7606's
> > driver implementation:
> >=20
> > - Fix wrong usage of gpio array
> > - Fix standby that was documented as ACTIVE_LOW but handled in the
> >   driver as if it was ACTIVE_HIGH
> > - Improve dt-bindings documentation
> > - Switch mutex lock to scoped guard
> >=20
> > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
>=20
> You missed Acks from Rob on several patches that he gave yesterday:
> https://lore.kernel.org/all/171952025424.477297.14698127361119381011.robh=
@kernel.org/

You also seem to be missing acks from me..


--1r0wTlUg045hSqKl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn7c+QAKCRB4tDGHoIJi
0m6MAP0Z9O5/rr2y0HYTaG/DQiDb7KpCDtJscXb2HxZbtv54xwEAxfmNZrMiAyj9
92XZNTRo0wEO6Q0WpkCrc2aMweGrSAk=
=I6rP
-----END PGP SIGNATURE-----

--1r0wTlUg045hSqKl--

