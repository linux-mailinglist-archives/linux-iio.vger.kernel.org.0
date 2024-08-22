Return-Path: <linux-iio+bounces-8692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A4D95BB1F
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 17:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D54A1C230C2
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7B11CDFBA;
	Thu, 22 Aug 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYoZ5STI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E61C9EC4;
	Thu, 22 Aug 2024 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342093; cv=none; b=WCfKP8sOJC7gIxD0rwAdQUWhAwdeoEJY8US+JTi3t+rcBIFSbcZQKq8r5dUgrflqviq9dDf2qUp1mvF0qFg+Cascg/WY/6zvIX/r0EWTjLXwrET6WT0BbgGRqMoIS7DHyDeDC9W1k2Q4gMmf2+EKXSGNnBliGtp/MZM01OIl9nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342093; c=relaxed/simple;
	bh=CuFH3tBMhYohUhhCIe2vOf1kYchFvArX2vYMNBabCxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwbhfJhLSDajmR0ZAvoIWHePjT98o1cY1h/wWwC7P/VVXYW0qnsBuXDRNfcSubLLHBa7BQoOYY9FLgWg4CVyAszjdLRrLLFrYui6xZ9bVvQg4ZZV4isxJf1sK+iY6hxK2rkZwX8ODXylL10C+C7CnJVzOkz+4/sJQqwjRGQ4mOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYoZ5STI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7594CC4AF0F;
	Thu, 22 Aug 2024 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724342092;
	bh=CuFH3tBMhYohUhhCIe2vOf1kYchFvArX2vYMNBabCxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYoZ5STIZ5A2yZp7xEq44ItAlR18bnDWTpUMjWt+HC/pmJXpl9Ukl9HhE7alpXu3c
	 cjzjd5gwoDSYgPbUlmlmkseqn6Smi0DJKP8+hGPdGzOJ9IopgCbb6Ahv59KKxmDA8L
	 xzI2vkP5dFRL1hmmA+keOTDoksICjai6yuoAAstdt/cWOkjL2drqDPlmVhfQyY7HcC
	 zMGknWMy6nWTFqnTM1Lbn37dDD8i8dwNdvaPwYjDqal8Sj0lED2dkulSAyoXhkgLNP
	 fJH5+NA4b7Es+IjtRrusqz3zRjJAv/FVk4+jsvd3AJXknzT/r7e90CL43FP/gBcpBV
	 BMVXmDJbLp8/w==
Date: Thu, 22 Aug 2024 16:54:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/6] iio: adc: ad4030: new driver for AD4030 and similar
 ADCs
Message-ID: <20240822-poser-durable-6a221451e512@spud>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G6T2XiZ7RWlNBZXv"
Content-Disposition: inline
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>


--G6T2XiZ7RWlNBZXv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 02:45:16PM +0200, Esteban Blanc wrote:
> This is adding DT bindings and a new driver for AD4030, AD4630 and
> AD4632 ADCs.
>=20
> This work is being done in collaboration with Analog Devices Inc.,
> hence they are listed as maintainers rather than me.
>=20
> The code has been tested on a Zedboard with an EVAL-AD4030-24FMCZ,
> an EVAL-AD4630-24FMCZ and an EVAL-AD4630-16FMCZ. As there is no eval
> board for AD4632 the support can't be tested at the moment. The main
> difference is the reduced throughput.
>=20
> To: Lars-Peter Clausen <lars@metafoo.de>
> To: Michael Hennerich <Michael.Hennerich@analog.com>
> To: Jonathan Cameron <jic23@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Nuno Sa <nuno.sa@analog.com>
> To: Jonathan Corbet <corbet@lwn.net>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
>=20
> Changes since RFC:

FYI, RFC is a state, not a version so this should be v2.

--G6T2XiZ7RWlNBZXv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsdfRwAKCRB4tDGHoIJi
0hPJAQC1TR18fFiWblscnQ85fJxh1Y26oc6HM56QMPkYQRStJAEA28iHLJDb2e2f
dCgVA7ijLfGeAmeuYS9xqDuZlLi8PwY=
=XVKz
-----END PGP SIGNATURE-----

--G6T2XiZ7RWlNBZXv--

