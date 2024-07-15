Return-Path: <linux-iio+bounces-7622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0336A93185A
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 18:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFCC1F21EEA
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E35A1C687;
	Mon, 15 Jul 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESSJwEPL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E520DD2;
	Mon, 15 Jul 2024 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060296; cv=none; b=XcbVaRnlEpwrxMWzwFwbZXhtoINtv5Dv/iPwxMqY984wm/oTF87gWaETZ2TgkqJXdFeYu0uygKduIyLPNrNsXF6xstudo6R49vCGn1/KesDIW4LceYuNfIx3Z5XEG8cHVZB47PSvul4pqweDkEv/lHaQU6n3QtbZNVLC8xkaPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060296; c=relaxed/simple;
	bh=SlbZJguYwfxug9j7CRmKTzJxXhAX2PYOpYdUXDXVaJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2FUfeod92WNqIWB2IR5t4DTmwCj59hvdbECYpieLlico3ie2TJyuTzdNP7E7ackt8P8LQC8AviRgBai5lWg+UP0WjVhUzvKfryDQo7dH0vqq8PUisAsp5C+aF0CtIDDwU/OAbdm12ye2hRfmv8DwRUm6XLMa2T3RJDMtajr8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESSJwEPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD39C32782;
	Mon, 15 Jul 2024 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721060295;
	bh=SlbZJguYwfxug9j7CRmKTzJxXhAX2PYOpYdUXDXVaJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESSJwEPL7zSZ7KCNS9Fx7UTn1F54PxhZC/Gjc/VfQw6fAQ7lqjpcIFtpC4k9IohQ7
	 iA/nA18qn03zIUzY6osQZnRPEyPs1a7CJFdajbkkGQPucSeDPIjYwtb26ZPdDnMfvh
	 lOlkaC4DXYGyLE1lRk2LDzFTs+O6txysmiOzzKf8cGePsf39ZeVSwxc08bv6Rhij40
	 jl+W0pff2Vz1Ho8iFebV87deda+NroiUvZQMv6y8YECoh3JnY9Z9Qupb2GS5Y/gETc
	 Ifb2c+O6BwO37BmY6DN5bVUM7xhHiX5xitAjdXhg08/v+OClCoJ+ZX56U22Gv6ZJwF
	 eJHNlkqbRtXPg==
Date: Mon, 15 Jul 2024 17:18:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v7 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Message-ID: <20240715-numbness-chooser-d1bcb0438ba5@spud>
References: <20240714133000.5866-1-kimseer.paller@analog.com>
 <20240714133000.5866-5-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZaKZiRJHLYmUF2t"
Content-Disposition: inline
In-Reply-To: <20240714133000.5866-5-kimseer.paller@analog.com>


--YZaKZiRJHLYmUF2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 09:29:58PM +0800, Kim Seer Paller wrote:
> Add documentation for ltc2664.
>=20
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

IIRC I gave you a reviewed-by on v5, was there a particular reason you
didn't add it?

--YZaKZiRJHLYmUF2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpVLwgAKCRB4tDGHoIJi
0nzYAQDKnRL+UdMt1djaNT558PsyTo9/NzlQaGZx66/fMGR3/wEA6YsC+rp1DpD2
Mbh2mAT3Sc4FptgNIhTIH/4CtTJksgQ=
=kQRU
-----END PGP SIGNATURE-----

--YZaKZiRJHLYmUF2t--

