Return-Path: <linux-iio+bounces-6007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE262900714
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C2F1F2155C
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A83A19B582;
	Fri,  7 Jun 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTlnrC4Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC119B3D8;
	Fri,  7 Jun 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771246; cv=none; b=idfnPlb3my9P6p0W6/VdaGOmThU3zYD0cvjfVwgDTPi596bRCq6EyipCl/2witCQbqHKHKt85gUCkh2o1dwG4VNE5Klbw0cJcYe1t0c+mDNcSC2Ihtf6WeIKyrng0/9bc2MdmCw0Hgp7trmLNPQlc5+M0xq+SVD0dqNun2znpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771246; c=relaxed/simple;
	bh=VQCVVnxbbm8joBfmb7fj7T0RW/52mB15i6mWXazrQK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGweM2GhBRxjMisWyyi917CDGLemD86VdgPVsWm/G4c69XURkzSwq4YYVlx0+3DO5bUFylo6OSLr3s1SfaAM8u7QIlohWyVClwJKJved9Jwq/if8Al5uBKecSb6yIDgXeoW6pjppjKYzfI5RAY38nLJLEYwXw4yQ4bOvM01C0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTlnrC4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40A1C4AF0A;
	Fri,  7 Jun 2024 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717771246;
	bh=VQCVVnxbbm8joBfmb7fj7T0RW/52mB15i6mWXazrQK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTlnrC4Z/4rul5wzpzkhX9FIkH8AtNR8c7yZhNw2cs0aTwb/EaOm+p6Wbe+Ip+hU0
	 g/eld4/HuPRG569CiK6uIOl82Edw8PZN1unWwpScN1WwNezOSs+WKdpPqHI6K0NGkL
	 S1KjviM5T0Cx6S0rXIbv5iJPIoEzCvC1ckmZAVze8fDMH2aNHG7q8+ezXhpPgA5vFn
	 JnU6yg3gLliFjlV2r6VQvvuPTahYpSYAx4UdpNVKsSEfr1RGh2XNs3eH7DtXibBua0
	 adEhqGc8PASWHLdDXD+j5tY6uC4dLmZbKtdLIQSZHn5EGfJOW2HGhVW1TmaWjQfCS8
	 DwLSYBrM3OIjw==
Date: Fri, 7 Jun 2024 15:40:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Konstantin Porotchkin <kostap@marvell.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-phy@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/7] dt-bindings: iio: adc: ti,ads1015: add compatible
 for tla2021
Message-ID: <20240607-extended-unseated-33ee0e5c7825@spud>
References: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
 <20240602-cn9130-som-v6-3-89393e86d4c7@solid-run.com>
 <20240604-suspend-schnapps-191d2c1ad53e@spud>
 <20240606211222.3b0f7a01@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MA/zUUjP3tmJsJYa"
Content-Disposition: inline
In-Reply-To: <20240606211222.3b0f7a01@jic23-huawei>


--MA/zUUjP3tmJsJYa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 09:12:22PM +0100, Jonathan Cameron wrote:
> On Tue, 4 Jun 2024 18:42:46 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Sun, Jun 02, 2024 at 05:49:38PM +0200, Josua Mayer wrote:
> > > TI tla2021 is a limited single-channel variant of tla2024 which is
> > > similar enough to be easily supportable through the same driver.
> > >=20
> > > Add compatible string for tla2021 so boards may describe it in
> > > device-tree.
> > >=20
> > > Signed-off-by: Josua Mayer <josua@solid-run.com> =20
> >=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> This binding has per channel descriptions. Perhaps for this device
> it should be updated to include a restriction on number of
> such sub nodes (probably via the reg value in them) ?

Oh yeah, it probably should be, using an enum of permitted values.

> Mind you it's currently 8 and the ti,tla2024 only has 4.
> So a possible job for another day, hopefully alongside the
> driver support and the tla2022 which seems to be the 2 channel
> version.

Or a follow-up from Josua if they want, don't think it'd be too hard
to add restrictions for these two tla devices.

--MA/zUUjP3tmJsJYa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmMb5wAKCRB4tDGHoIJi
0hzTAQDcuCMGXDnmZL5drZ69sO2c4SqM0W5MS7H1bNF122pnZwD/d5DBjkFqVgBO
Bm9FxlFfKn1HWM9DUUIri+fvaVaywAg=
=MqsB
-----END PGP SIGNATURE-----

--MA/zUUjP3tmJsJYa--

