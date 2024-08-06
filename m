Return-Path: <linux-iio+bounces-8285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C046949531
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E141F274A8
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB991448F6;
	Tue,  6 Aug 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPhIXBCX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C757CB6;
	Tue,  6 Aug 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960174; cv=none; b=LO40Vvwd5e5Byy8LzKJxv+K48FEgst6idN8gvqqGVuvVGGbPKPmn6uco0i4zcsrUrCYzqJiJ18eZKzXnoKV/PnHNmmonLJzk0n7uZgPW35R6hybauTge1dzNeVhebcuhpel4e93FMeK9d9vz61wL9BQlLB+6thDrPHk9iAE2TJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960174; c=relaxed/simple;
	bh=mmE7nISQTlHs947A97FdBg7xigtB23cUKh5sgLHolgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uegmPSWxMS2iTUoprqO6IXBH9YS8aH2/nIQn284UfllkHHrjPR7K3s2MKE2WXPkTLhnzhRggT1QvVEWor+2iUoPsK+wEa/6XN3fi5UkHt9KoiDZYkha+YypbEpNFhKccUw8G90DF3LuK3kdSUM9vycW4xJQS/cYIzXohgXr9H6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPhIXBCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3070C32786;
	Tue,  6 Aug 2024 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960174;
	bh=mmE7nISQTlHs947A97FdBg7xigtB23cUKh5sgLHolgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPhIXBCXI33QPugi2D9Jlz4hqEF2gKNiU2ugmF1kYMp8V95UyDvXXVWqfWT0ToFTE
	 J6xAqGPsVJWwNykht7Vzo3sulNV2OIToNeXX2uaEut6/KdKDowOnQsdCbBCcbBeakt
	 TVprYuslljLuM4x4XKCWtMQtiJZ3aZYRfycwWvB6zj2iYQSq02MdXns+DABFa8DU7q
	 hoDcneldpEoAvSIVJtUWNykW2QmDY+e2S5O9SDy3SiydJHXFhzuop7HWr0sOrRZeVP
	 Jyej7a25HUaKdWuG+xIHpHi7blUVBTLOEr9KhSsBpjXQiJn6pabNpsILYp5QQdjDh5
	 NN2SzcBdZHjPA==
Date: Tue, 6 Aug 2024 17:02:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Albrieux <jonathan.albrieux@gmail.com>,
	Matt Ranostay <matt@ranostay.sg>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: asahi-kasei,ak8975: drop incorrect
 AK09116 compatible
Message-ID: <20240806-unlocked-womankind-f9e5e1d19055@spud>
References: <20240806053016.6401-1-krzysztof.kozlowski@linaro.org>
 <20240806053016.6401-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L3aXUt6Qton7WWzl"
Content-Disposition: inline
In-Reply-To: <20240806053016.6401-2-krzysztof.kozlowski@linaro.org>


--L3aXUt6Qton7WWzl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 07:30:16AM +0200, Krzysztof Kozlowski wrote:
> All compatibles in this binding without prefixes were deprecated, so
> adding a new deprecated one after some time is not allowed, because it
> defies the core logic of deprecating things.
>=20
> Drop the AK09916 vendorless compatible.
>=20
> Fixes: 76e28aa97fa0 ("iio: magnetometer: ak8975: add AK09116 support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> Offending commit did not even bother to Cc devicetree mailing list and
> DT maintainers... Lovely. Let's ignore submitting patches and
> maintainers just to sneak my important patch into the kernel.

:/

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kas=
ei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-k=
asei,ak8975.yaml
> index 9790f75fc669..fe5145d3b73c 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak89=
75.yaml
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak89=
75.yaml
> @@ -23,7 +23,6 @@ properties:
>            - ak8963
>            - ak09911
>            - ak09912
> -          - ak09916
>          deprecated: true
> =20
>    reg:
> --=20
> 2.43.0
>=20

--L3aXUt6Qton7WWzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrJJKQAKCRB4tDGHoIJi
0jiaAP9wMLcJ67g8LCyxoJaqYfWHGDNN3yG3hKLzSLeFVelfLAEAhfOBz/tBDM8q
gtSKmUsVG6aX0tCjuGebpTCc+WVj8gI=
=ICw5
-----END PGP SIGNATURE-----

--L3aXUt6Qton7WWzl--

