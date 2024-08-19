Return-Path: <linux-iio+bounces-8618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7D3957223
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 19:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 638FBB2CD1C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020BD187854;
	Mon, 19 Aug 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGHhgwcM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C8185E6E;
	Mon, 19 Aug 2024 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087607; cv=none; b=sEDTtmL1Rv7KFrZ+pk4ngpoObIWVpGyV7a5CEcE8JLldsUhTow7AZHcZh4n0WrHvA/5FrMIjPqKiZnXR1doJW6mnK3zCFxCSlCVGlqHQeo0PETJ5+RykKtek8dD1Ip06M5uOpy/Kqnk1dW8x6XmHXQdvJTqp+EKwVeFbi63jUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087607; c=relaxed/simple;
	bh=rdULt6pgnvPdbgLF9J0oo7ynjstIM78aVEn7qoTMvlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJMEFmK7TfQ6gW0ZcikPY8eVbdzzlf+o3puaOqq1fRul2XweBdtOYAqMAacxnLsgdDjGCKL3fs5wyUWmt3LumdoENGgD2IRrSrS+Hyts+UhOo3RO9QXPOc2RKDwohWo1DvC6a9z0R5ikKw9PUf1MAZnqUyvdnpR/YFoLiKbZh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGHhgwcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EE3C4AF0E;
	Mon, 19 Aug 2024 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724087607;
	bh=rdULt6pgnvPdbgLF9J0oo7ynjstIM78aVEn7qoTMvlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGHhgwcM5zdbEbDwWVOPRrGY+xiK7S9IECv7bn41EQee+3AciVq4D4+usNFP7lZU8
	 d+dQ9UkCqNzKGLOLquIMhQeveDC7s9ZD0j7TThhbVP7IZcB376EJBTBitm02Qfz3iB
	 hJc+ahNk7ZDm8svys76EeRB2fHeF+bY0KjwxLHrx2XikIIOFKofmFLTrG49CIx8L6G
	 NLsVYskRSsgArVMOWiFILC7f/69wrk7Z54VibC6Fy7CUUQXecgXBBzYmOGVYysQo6Z
	 xqAA1oG5/jfnOxLb1V3JctQ39GWo9CaEvZ4mwxvBurm9HX8KFXS65NrtlsBlas7I4f
	 qhvVYjg1Tyf4A==
Date: Mon, 19 Aug 2024 18:13:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: st,stm32-adc: add top-level constraints
Message-ID: <20240819-outflank-variety-3fcb7ca0338a@spud>
References: <20240818172951.121983-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y0beHK2OB/Ya0e9O"
Content-Disposition: inline
In-Reply-To: <20240818172951.121983-1-krzysztof.kozlowski@linaro.org>


--Y0beHK2OB/Ya0e9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 07:29:51PM +0200, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clock-names.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Conor Dooley <conor.dooley@microchip.com>

>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml =
b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> index ec34c48d4878..ef9dcc365eab 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> @@ -54,7 +54,9 @@ properties:
>            It's not present on stm32f4.
>            It's required on stm32h7 and stm32mp1.
> =20
> -  clock-names: true
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> =20
>    st,max-clk-rate-hz:
>      description:
> --=20
> 2.43.0
>=20

--Y0beHK2OB/Ya0e9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsN9MgAKCRB4tDGHoIJi
0lWSAP4r3VaV8vxUGxyk/Gd68syU0Qbdc0hMEQWz/zPKArLpjgEAkmLmOnGOUeXx
T1faMHwgTOz4iMURjAUYjB9JJX301wI=
=/tpI
-----END PGP SIGNATURE-----

--Y0beHK2OB/Ya0e9O--

