Return-Path: <linux-iio+bounces-6757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34221913BC6
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A8AB219D9
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6405D18130F;
	Sun, 23 Jun 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqBVCtSf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3291EB25;
	Sun, 23 Jun 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719153027; cv=none; b=Mr+LjSZdd6YGXly3ZilnTT/xfeEvlslvpAuR5UVpplaMqpY8w8LnHt5pY4AIxmscpiqLTqB/6ViQdIKPHjw/BBHBUQmQ3WRw2OZ9up2EaHfy/rj2UzX2ThqPorJDfUK6ETbpzj8tSx3M7kMCiKnYQ6oc4bYVagrwEyxgZ0oqHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719153027; c=relaxed/simple;
	bh=JeDwnT/5o/t4SulflNylysZnroxPO1yMnY77AG2371A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4lTO5ZIF2bnBMjQxBRlWrVJfJPiRhfuQeHM4Sczgly9AWYgC3wQBKU2JcacinaVdjN2q9wSmuqKaO/y+VXwm4VerHx4SAL3iX0ctzxZ2ycw2P6x7nHX7b0cARhTMrr6VY/bgGgnWhgvmKuKdnlNP361ZzvNT2ic53FFl8H3Bz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqBVCtSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F8AC2BD10;
	Sun, 23 Jun 2024 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719153026;
	bh=JeDwnT/5o/t4SulflNylysZnroxPO1yMnY77AG2371A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqBVCtSf3tjapxospQEitqB5uuhOSm4oGAc1Ni+y2Rys1edgdAKLj+JaB08lprST1
	 qkSXfGGjdWmXUJYlykuN9lXzjiip2fWrWNUAPz4ImJLoJHSA8HpJtIZ2LE4+OalJCI
	 GlTRVLwec7QN9icUAXUX0iGUPiINVHC39FO+lSGRiTaNLxwz1/sfjXjRDPyg3PoYWg
	 oUYVz+xJN9I61XouX9Xx1R95LKe60Q7wlmsIn5yahzXiI8/fTs/cda70Iw0yRpuJhH
	 YSKZauQfLmiNFP31GxuOTSCJ4eMwOfZp3/WNu+1aPIpyD5iOUcCfvZlVe3mGT/M6gt
	 0+BrPo78XOR0g==
Date: Sun, 23 Jun 2024 15:30:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
	linux-iio@vger.kernel.org, denis.ciocca@st.com,
	devicetree@vger.kernel.org, linus.walleij@linaro.org,
	robh+dt@kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: iio: st-sensors: add LIS2DS12
 accelerometer
Message-ID: <20240623-lure-rubber-27c1f8f7ec66@spud>
References: <20240622123520.39253-1-kauschluss@disroot.org>
 <20240622123520.39253-2-kauschluss@disroot.org>
 <20240623110305.5d961052@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N3AVEEhuL/WRSAO2"
Content-Disposition: inline
In-Reply-To: <20240623110305.5d961052@jic23-huawei>


--N3AVEEhuL/WRSAO2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 11:03:05AM +0100, Jonathan Cameron wrote:
> On Sat, 22 Jun 2024 18:03:46 +0530
> Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
>=20
> > LIS2DS12 is an accelerometer by STMicroelectronics. It is identifiable =
by
> > its WhoAmI value 0x43.
> >=20
> > Its register interface is not compatible with existing parts. For examp=
le:
> >=20
> > - The full-scale values are present in register 0x20, in bits 2 and 3
> >   (mask 0x0c). Most other supported sensors have the register address s=
et
> >   to 0x21, 0x23, 0x24, or 0x25. There is one sensor setting though
> >   (bearing WhoAmI 0x3b) which has it's address set to 0x20, but the mas=
k is
> >   set to 0x20, not 0x0c.
> >=20
> > - The full-scale values 2G, 4G, 8G, and 16G correspond to the register
> >   values 0x00, 0x02, 0x03, 0x01 respectively. None of the sensor settin=
gs
> >   have the value 0x01 associated with 16G.
> >=20
> > Add the compatible string without any fallback.
> >=20
> > Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> Given the only requested change was this description and everyone seemed
> happy with it in previous thread, I'll pick this series up now.

ye, fine in my books. I should've prob acked explicitly when I assented
to the wording on the previous version.

--N3AVEEhuL/WRSAO2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZngxfgAKCRB4tDGHoIJi
0prlAP9WTLKrzFB6YvuKX+72fa1nL+hHQqEIJZPBPwETp0JN8wEA52l724nen/9Z
htbZbuUUNvAmtYwn1ng3PA1CE2wZcwM=
=+j52
-----END PGP SIGNATURE-----

--N3AVEEhuL/WRSAO2--

