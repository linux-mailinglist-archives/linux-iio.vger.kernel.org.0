Return-Path: <linux-iio+bounces-19945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAE0AC421E
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 17:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7FB3A4FE0
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B73A211A3D;
	Mon, 26 May 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDq8X7SL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DBA1FCF41;
	Mon, 26 May 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748272217; cv=none; b=nBm2C+DrYmHpMKre6ll+SCNbAqevZV2KJoYGdsqyWYUZhyf0Lp5jULa4YYppBh628LO/P+DHuAsyscdpfCKw4V+Ad0UNFO+/oZ9dyA5fJgpPovSMP4vrDu6ypKJBDWwAp3u7ErPBFCo5f2XMcYp2WYh+eo4IsAhuIrmGggyzNbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748272217; c=relaxed/simple;
	bh=t8DyhwSvrHrndgCFWTpxwuKS78RJvgE3OL1d/UezY04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnFMohNW45X05f4NJEidQXQY6T5wTzgOcfdikp9m3UvaDAyEND7j8F6gNioZ3QTrFf7CEhHLilenSR10lQYoJq0SKDGPU2h2cc79JAbhYH5cyDV3kTtdBeSCOlaXTBnar3cDK1EpPkjbulYYEEg+P/lmWx38JPVAaJJUD+nfS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDq8X7SL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F68C4CEE7;
	Mon, 26 May 2025 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748272215;
	bh=t8DyhwSvrHrndgCFWTpxwuKS78RJvgE3OL1d/UezY04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDq8X7SLVJAQZLOaICO4neyZ6IGi8PTyeQMj8XDUoy441aZ9o4qewQ433d8bd1mak
	 ToCvnIrgB/8FSERGi34KABew7xbdzUwm6j9/EOuYoNQqRA4OMXj/3izkkiTDMyupd8
	 uZqwHqE/uLgd+rtqGPRNbjKuZ1fK7C07ZRQjWRxOk1lbzoxQK2+DwIvWRAG7b6v9Nd
	 PITIv3TEnPVb4DjrrlZRsZzdXQLPPOff0iOu1u8agdHxzkpyQuDwf2PsUoG8oWjKnT
	 EuOGFrFSpGwdntHy+Xhn+0bzV60MdvDuVKhLhH49RmNU9+oTVtshjWIhZYwvCESnoE
	 FmORZ9FN11BHQ==
Date: Mon, 26 May 2025 16:10:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: adc: adi,ad7606: fix dt_schema
 validation warning
Message-ID: <20250526-moaner-hassle-816968c2e63d@spud>
References: <20250526-wip-bl-ad7606-dtschema-fixes-v2-1-9bd56d039489@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+ULwQ2yavHF/YWAl"
Content-Disposition: inline
In-Reply-To: <20250526-wip-bl-ad7606-dtschema-fixes-v2-1-9bd56d039489@baylibre.com>


--+ULwQ2yavHF/YWAl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 03:19:08PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Fix following dt_schema warning when offload is used:
>=20
>   DTC [C] arch/arm/boot/dts/xilinx/zynq-zed-adv7511-ad7606.dtb
> /home/angelo/dev-baylibre/linux-iio/arch/arm/boot/dts/xilinx/zynq-zed-adv=
7511-ad7606.dtb: adc@0: 'oneOf' conditional failed, one must be fixed:
> 	'interrupts' is a required property
> 	'io-backends' is a required property
> 	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#
>=20
> There isn't any reason that we couldn't have interrupts wired up at the
> same time we are using io-backends or SPI offload, so dropping off the
> related "oneOf" block entirely.
>=20
> Fixes: ccf8c3f106a2 ("dt-bindings: iio: adc: adi,ad7606: add SPI offload =
properties")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
> Fix dt_schema validation warning.
>=20
> Link: https://lore.kernel.org/linux-iio/20250408-wip-bl-ad3552r-fixes-v4-=
0-b33c0264bd78@baylibre.com
> ---
> Changes in v2:
> - Change removing the related oneOf block.=20
> - Link to v1: https://lore.kernel.org/r/20250523-wip-bl-ad7606-dtschema-f=
ixes-v1-1-d9147fb2a199@baylibre.com
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 29f12d650442b8ff2eb455306ce59a0e87867ddd..1a5209139e1338f803c66ad2b=
4d63ad53cc11d96 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -223,12 +223,6 @@ allOf:
>        - required:
>            - pwms
> =20
> -  - oneOf:
> -      - required:
> -          - interrupts
> -      - required:
> -          - io-backends
> -
>    - if:
>        properties:
>          compatible:
>=20
> ---
> base-commit: 3964c6e5877f054497ffccc7d00f8f7add307d0d
> change-id: 20250523-wip-bl-ad7606-dtschema-fixes-5e6ab342e043
>=20
> Best regards,
> --=20
> Angelo Dureghello <adureghello@baylibre.com>
>=20

--+ULwQ2yavHF/YWAl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDSEUgAKCRB4tDGHoIJi
0j2wAQD5AfCRUPpKLmj2M1u1ve5izNl9I19KzSdHNySeO2hH4gEArxDQXrhAXXnO
SXXYYGUr6IyIlN2Ruceocxb8DOo5bA0=
=nsA6
-----END PGP SIGNATURE-----

--+ULwQ2yavHF/YWAl--

