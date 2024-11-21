Return-Path: <linux-iio+bounces-12473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719639D53AB
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 20:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3780C282B7F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 19:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5791C9B7A;
	Thu, 21 Nov 2024 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqRrkQzQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27831A9B38;
	Thu, 21 Nov 2024 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732218905; cv=none; b=KQraG1/KoEMZL7cqFwPjtbBxLlyboKlU8gEC/psHC+Madu8vIDZYnfwjbBYtxQLCG47/cVhJLmDMrTUbWESdZf2kQkMwax5vYemW/vVMtwtdglKWDojdyUKEpOLCX2+ny+3TESyG67UAIwAS0oacHW682MBH4wq0qSOYgHseInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732218905; c=relaxed/simple;
	bh=BLDURJQuaJE6CdUYhXoo882bVGpvfxGv7BbisL0OcQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIhDSG6AohJyu44eafdcVnlw2HGOLY1WO+9szX1B97tbyvUM1tL1cn81lRKg6uk6e2mb/ffMkV2ybp6DrSj8lm0LS+XDgB20FexTY6SbgiA4WbUZ5u5eZExw2hdoovqKSn7dJJLNWoYsLJS+NXopQSxrMOOBUdlYDPxrdoSsIUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqRrkQzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECD1C4CECC;
	Thu, 21 Nov 2024 19:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732218904;
	bh=BLDURJQuaJE6CdUYhXoo882bVGpvfxGv7BbisL0OcQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqRrkQzQzzHdw5i46MMKOcakw7F/5EM7rjjaNI9xAoMLC8SzScIgNd+MG4SbeOyKx
	 ess/xmVA50JO9vddJxaynSsS5YMgn8x58RiXyeSPbreWW2vdz4uOaB9DnHcPIpaRYg
	 yjU0XYvfk60tghTYlvjubs6J1uZox7H3p4UWbjXAcD0TVDeRg/Zzly+/+Hns3qUGdd
	 NCaht+Ai1wW5/Vv74u8Yi5WJE0t7Qqhny9C306cefqQgeF1doJ+WWi6vqkqkHboG+L
	 3LkZWkOh9aTadS62Ubc6j3xqqMbiY+sxW7lHFJ2TPyYKWL4tQb15K5s9jAu5AQOQhY
	 Rc3C1GLta6aNQ==
Date: Thu, 21 Nov 2024 19:55:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] dt-bindings: iio: kx022a: Support KX134-1211
Message-ID: <20241121-broiling-clean-dce6722ae819@spud>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
 <8d0ae2f58678f4daf2e24c8f4a8419cd5d225db8.1732105157.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/MuaecG4mGmdS9GJ"
Content-Disposition: inline
In-Reply-To: <8d0ae2f58678f4daf2e24c8f4a8419cd5d225db8.1732105157.git.mazziesaccount@gmail.com>


--/MuaecG4mGmdS9GJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 10:21:30AM +0200, Matti Vaittinen wrote:
> The ROHM KX134-1211 is very similar to KX132-1211. The main difference is
> supported g-ranges. The KX132-1211 can measure ranges from +/- 2g to
> +/-16g where the KX134-1211 supports measuring ranges +/- 8g to +/- 64g.
>=20
> Support the ROHM KX134-1211.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--/MuaecG4mGmdS9GJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZz+QFAAKCRB4tDGHoIJi
0k2pAQDVBVILsnR7IF3BVuuOETSeWKryHealsHgshy2M13uIpwEArRFfY8d2uj3d
j3bC7jrNQ0xQFDOvhs5uLGxh/JWJYwM=
=07oy
-----END PGP SIGNATURE-----

--/MuaecG4mGmdS9GJ--

