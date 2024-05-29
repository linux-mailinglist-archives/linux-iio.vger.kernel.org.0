Return-Path: <linux-iio+bounces-5465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DA68D3CF9
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 18:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70850285727
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE1194C80;
	Wed, 29 May 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC8nTQah"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B8187358;
	Wed, 29 May 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000642; cv=none; b=aUJk+Cvg3Zzii/dxIMv7YKru3wbmR96jfdMJKAU01FZWS2hiTxn6hEQi8nka6IBHZ7y7W6JS5A8uf+RGYBdOHJPtkTRsm9aa9dl6lV4TA7Kx47fmQhFuLNiWnVeIaFipR0qt2Bu/Zbs/Yafqm/D4+xSIc3xF8lSuVsJdqy76XFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000642; c=relaxed/simple;
	bh=esWq9H4hty5dSH/nOT2xawowKajsO0lRxJJT182X6JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrRwBSwjtdfVhbPoCmCEb+RZB5CI0o8Li8Djxd/3YUoETuz1/MRQ6X7370FsnRq+lm5u097jcxzV3rI0N1agwOi+N7wbYUSIIHYczcA1Q8U/a1NZlx1hJ4+vW+w3N5Fh2leRqWcmBdTBW2trFw5Q6jiEsVxadMRx+G9u68tpgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC8nTQah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84825C113CC;
	Wed, 29 May 2024 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717000641;
	bh=esWq9H4hty5dSH/nOT2xawowKajsO0lRxJJT182X6JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TC8nTQahSzyuISd1eK7NebqYQke29V4PrJEw3KBLundgxPEal2eCs3nTa2+IXcnD8
	 rflXKy9T3gf6aTRL/o5z2Q0RDEN6LavYyFT+Z7cefdjz9N8dwX4MTmsLQ26Trsa+3b
	 vEpGce265tpsuKvCWQ+jw7Mcz+BYshtStp76/l0wjkxzulzGBsHj5VyGtvQhtMgLrY
	 M36ltk6svsBAeyX8VHJdP2WG/G725ueg2bM1lqo0Uqlumxp42XET36xW0KT+fnvyxr
	 jE+jpqYJ9UW7dwcGVRQLqYmATKBll66P4EaL/S2tfYbHALbs4gAodSaYrq7fpZEdtM
	 F6/Eu11K9bkNg==
Date: Wed, 29 May 2024 17:37:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de, christophe.jaillet@wanadoo.fr,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: iio: chemical: add ENS160 sensor
Message-ID: <20240529-rule-asparagus-2e7015bdb50d@spud>
References: <20240529001504.33648-1-gustavograzs@gmail.com>
 <20240529001504.33648-2-gustavograzs@gmail.com>
 <20240529-upper-brisket-f326418bcfc2@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mchU/iPSqESQYkFa"
Content-Disposition: inline
In-Reply-To: <20240529-upper-brisket-f326418bcfc2@spud>


--mchU/iPSqESQYkFa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 05:36:38PM +0100, Conor Dooley wrote:
> > +      gas-sensor@0 {
> > +        compatible =3D "sciosense,ens160";
> > +        reg =3D <0>;
> > +        spi-max-frequency =3D <10000000>;
>=20
> If you want to include this, you need to add an
> allOf:
>   - $ref: /schemas/spi/spi-peripheral-props.yaml#
> above. Otherwise this looks pretty good, so with that added
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

(Please make sure to actually test it next time!)

--mchU/iPSqESQYkFa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZldZvQAKCRB4tDGHoIJi
0oyQAP0Vy1Y3GeC+tgVg0jyZVlJTVovd8NK4U0nma6olF6sDzQD/dYKtBtDji22/
XmzLEpgQOA46w7aMe7Ot+iVGu79BtAM=
=qwLB
-----END PGP SIGNATURE-----

--mchU/iPSqESQYkFa--

