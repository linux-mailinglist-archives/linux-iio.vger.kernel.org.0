Return-Path: <linux-iio+bounces-5050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D38078C5B6A
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 20:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BD32833F2
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 18:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC386180A8E;
	Tue, 14 May 2024 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocUslbOM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823011442FD;
	Tue, 14 May 2024 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713120; cv=none; b=kV2SpYuw+PzEUMTHsTcYNvrINd2jQEthVIJWXrjK1yS7IryWkzdWZPJ6OX2/3YB/Iqo+Uvn9XVbr3Z5sqCubbAY8txEj46taQwLN8bUGmBe3VeDbcvOGqQVNunjBDC7KpMLFGng611KBE8aKj2VZ+x+hG0wEY0nRxXCwwTWjN0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713120; c=relaxed/simple;
	bh=mPcZc2wKh0qkyf+Id66XVkXDp7xJpa4HJRjeCfn0rPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOthwWuucqLjwS884hs3zCULijUImirII09sf+Es0LhuvCf7ahKkMLOek9xg64jLjCF5QVMvP8RPYleInPRtbAVdttY5fQ7fxoXmPs020GsW4+mVHIYlTpqOjQjzhRG8R5lqw+XcyIrpQ5ud8kUHLsn8g7aW27UsmO+Yh5x9ebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocUslbOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494F5C2BD10;
	Tue, 14 May 2024 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715713120;
	bh=mPcZc2wKh0qkyf+Id66XVkXDp7xJpa4HJRjeCfn0rPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocUslbOMejfrrXxytVweuLRmTAlEBJ+fb3bysBulzwGHY7+GnhOvgMpGeriYY7vCQ
	 YTdj2HaI7oZ9XGygi35x0z65M9FBqQrZbrO4y2St36AlXU8MZpIjDIwjvAJFD7/ghF
	 JiEFLMX1zJKdlss96SzyuZiEISdwE9n0HSmw7f5DA2s5/dJJfayWeJB/rOcUarH73p
	 J4Xc+UyiJGeEWLroJLq8VXdu8hUG3y/m/ZnVzk5Vc+adGn37el5GD9zQsD1IUIOp8W
	 vANfEVneDltvo+kjWY+ps2n+hoX9l3YLrIw9e43CRE66GkZJkCjlskN20xZBcjk3tr
	 2x0QhhxijN5JA==
Date: Tue, 14 May 2024 19:58:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, jic23@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
	nuno.sa@analog.com, marcelo.schmitt@analog.com,
	bigunclemax@gmail.com, dlechner@baylibre.com, okan.sahin@analog.com,
	fr0st61te@gmail.com, alisa.roman@analog.com,
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: Re: [PATCH v8 5/6] dt-bindings: iio: adc: ad7192: Add AD7194 support
Message-ID: <20240514-shivering-glowing-d7cb5a4e65bc@spud>
References: <20240514120222.56488-1-alisa.roman@analog.com>
 <20240514120222.56488-6-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rJzWoxvwFNVgONpQ"
Content-Disposition: inline
In-Reply-To: <20240514120222.56488-6-alisa.roman@analog.com>


--rJzWoxvwFNVgONpQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 03:02:21PM +0300, Alisa-Dariana Roman wrote:
> Unlike the other AD719Xs, AD7194 has configurable channels. The user can
> dynamically configure them in the devicetree.
>=20
> Also add an example for AD7194 devicetree.
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--rJzWoxvwFNVgONpQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkO0WAAKCRB4tDGHoIJi
0p/6AQCiXnslN7WHaX0u7q/nVkWblH5UDuhEcGUy81izDKm99gEA+2wFAv6lofqC
CKi13qgPoa3UM6EN+qfhdeA8/p3fEAI=
=n0dc
-----END PGP SIGNATURE-----

--rJzWoxvwFNVgONpQ--

