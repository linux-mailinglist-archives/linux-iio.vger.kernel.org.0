Return-Path: <linux-iio+bounces-6977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA93C919ACD
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 00:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F90A283ABE
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 22:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04C6193075;
	Wed, 26 Jun 2024 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDBoWElI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946EDBE71;
	Wed, 26 Jun 2024 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719441749; cv=none; b=ZcDeXQMXdDNxq0pFGFI5lstpHPsJBmOno+vB+A3pIAH9zGrqemisiNiKdxoIDzrcanE1UvYVvHdqBA/DjAb5zzZPLCet9DgNJig/DK8vAtPgS92Vk/mD2wqlFN/ZBN469djL9SJ7VILkf2EHqlA/9gDE4DB4jTEPk6N4QgeliaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719441749; c=relaxed/simple;
	bh=vVkRE+alcbTOcriSkJLSL0UYLeb3jLd4R/4hVTPm+cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0raGKSalS1Rs63/kmBbFvaJ4sXaisD5zpTBQJkMIifojygFUOp0Z7mSBVTLMODCpHwMeSSx7H5TGqYElGwRD2hpZAJJ8TleNYfwv1zN062sZO/jdkUSxhycx3SQh8WNvjRRGw48WkywrqhA6p5IqyrCx4h6Fjsxd7CxgGYlaFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDBoWElI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69EAC116B1;
	Wed, 26 Jun 2024 22:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719441749;
	bh=vVkRE+alcbTOcriSkJLSL0UYLeb3jLd4R/4hVTPm+cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDBoWElIK6TEniDFyXB3zogWOlXI0WLGdSfQkoL2CHSJ2Gw8jbd20xdDkv18IPByq
	 DgK35cJCgZ9kxoM8+zn98B4JD7WkYc4FVPce8ouatDP8jpe526+OoHu5Gv77394631
	 A+JLcQ6iPLP/gO4S74aCafl6h2nXUgyRgCEDYCNPvxe9o8vcjmjGmTQIIVRtcjPnaS
	 m6Oyv4WODNWlvJjfVHV/fM+8/1nozAjNzpSQ6v0zntPkHfgResF0Y4pGUBYmwdhOb+
	 LNNY4bGnaxCtsJUYJIPFyrMMKewHhjGcSlhrrnGfk/qIvVRjR1fYhAYiSqng4305uU
	 ljQydzvU9mFJg==
Date: Thu, 27 Jun 2024 07:42:22 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Judith Mendez <jm@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	David Lechner <david@lechnology.com>
Subject: Re: [PATCH v5 1/8] dt-bindings: counter: Add new ti,am62-eqep
 compatible
Message-ID: <ZnyZTq0rEFP_eWCw@ishi>
References: <20240612135538.2447938-1-jm@ti.com>
 <20240612135538.2447938-2-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y+Bq0nMuvXuDdwIF"
Content-Disposition: inline
In-Reply-To: <20240612135538.2447938-2-jm@ti.com>


--Y+Bq0nMuvXuDdwIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 08:55:31AM -0500, Judith Mendez wrote:
> Add new compatible ti,am62-eqep for TI K3 devices. If a device
> uses this compatible, require power-domains property.
>=20
> Since there is only one functional and interface clock for eqep,
> clock-names is not really required, so removed from required
> section, make it optional for ti,am3352-eqep compatible, and
> update the example.
>=20
> The clock-name also changed for TI K3 SoCs so do not allow
> clock-names property for the new compatible.
>=20
> Signed-off-by: Judith Mendez <jm@ti.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> ---
> Changes since v4:
> - Drop the new example from binding
> ---

Hi Krzysztof,

Are you satisfied with the changes made for this version of the patch?

Thanks,

William Breathitt Gray

--Y+Bq0nMuvXuDdwIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZnyZTgAKCRC1SFbKvhIj
K9HXAQD3x7tR9Vhiw9coPPjp1PstCBStW6WMDhUMC74gBq/nxQEAubW67M/VMqAv
rrr11jrRmcp4qcXAVIHCygc9wPJ/xw8=
=kn0L
-----END PGP SIGNATURE-----

--Y+Bq0nMuvXuDdwIF--

