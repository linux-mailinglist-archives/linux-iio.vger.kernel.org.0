Return-Path: <linux-iio+bounces-24569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81468BAA2C9
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 19:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FB819232AA
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 17:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16802304BC7;
	Mon, 29 Sep 2025 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUM3SFEx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67E308F09;
	Mon, 29 Sep 2025 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166957; cv=none; b=qREuKY7oXISkW6wJR7t1UTIt879lfwfGToprMKrbwZOQgzm7KB9mZgncHJevkB2/vNgfMfZ6AHIsRjssuCcx88LMF28RnXIdudPWm6nWHFpUSFTG5cJ09EQdzShzFbQgMH2VKSyIRU5y8khcGSgc6/7ccCRH99PVsRRbokag7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166957; c=relaxed/simple;
	bh=T7b26ymhGrr0CuvS4bOYGG9EXhXN31gT+FlbOyKE0w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShxfSdPS+DlkYKRYAclZAzS7eIrB6+vCV2R348KhF26l0arEglEIfwCv07HkzHL7IDQyDjfYqrXymI/DQFli1LRqW9lYOTSmYlGu7+4/OaXfxb0CBMpa6gOs5ftqef6oC31lSJ2iy0QNKbKWjnD5yY+qK0iuAuq8T78ZpRcWg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUM3SFEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DDCC4CEF4;
	Mon, 29 Sep 2025 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759166955;
	bh=T7b26ymhGrr0CuvS4bOYGG9EXhXN31gT+FlbOyKE0w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FUM3SFExxYzFqhMUO+Wodu4lxR5ldPeUyDKBv4WeWhsTcDb6gY71DRv2rEYMXelJE
	 YSph3lllN4r58/9ur51RBjRB3eafFPT93aG9o/JcWjbTspLyu6VCcr2L0htE/I940n
	 fDJzoCb1AKIXpyZr1k821TvCAlMM8UPvYASSIdir5r2SkqhMtBCmiA3HvvxKS2z4wp
	 I/CISHU9B5KABuZY04/oq6FG9WziNe5bL4WBlnNQmqkhcANiE84W0aWv6wC+u66DXS
	 C0L7TDUDJOt2XPnLu+HD4nGB2IRh3dSSvAJwAABnAACRM+twD2x884s6lEFuvY0yuj
	 ekpnWO7Uv4GWQ==
Date: Mon, 29 Sep 2025 18:29:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: iio: adc: adi,ad4080: add support for
 AD4084
Message-ID: <20250929-walrus-expediter-1f5b0a3621c6@spud>
References: <20250929145909.111243-1-antoniu.miclaus@analog.com>
 <20250929145909.111243-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yGk/ti+m3vjLzL8i"
Content-Disposition: inline
In-Reply-To: <20250929145909.111243-2-antoniu.miclaus@analog.com>


--yGk/ti+m3vjLzL8i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 02:59:06PM +0000, Antoniu Miclaus wrote:
> Add device tree binding support for the AD4084 16-bit SAR ADC.
> Add adi,ad4084 to the compatible enum.

Both this and the other bindings patch need to say why a fallback is not
usable.

>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> index ed849ba1b77b..c4c5d208f502 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> @@ -26,6 +26,7 @@ properties:
>    compatible:
>      enum:
>        - adi,ad4080
> +      - adi,ad4084
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.43.0
>=20

--yGk/ti+m3vjLzL8i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNrB5wAKCRB4tDGHoIJi
0pm6AP9BirZI676kQL9GzcRnEAWdufUSjz7iXx7ASPoQ3uc6YgD9HGCVrBrF2GaA
l/5K/fa/HLbP6thYVvcjaTQCjc5mVQc=
=Xzcl
-----END PGP SIGNATURE-----

--yGk/ti+m3vjLzL8i--

