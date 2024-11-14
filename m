Return-Path: <linux-iio+bounces-12265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF2B9C92ED
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 21:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F0B24F0E
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 20:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0121A76B7;
	Thu, 14 Nov 2024 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr68bQ/W"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482BEEDE;
	Thu, 14 Nov 2024 20:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614896; cv=none; b=Tq+hByc84PTV7NZnMC8W0X3NzIXn74gsX7SismFLahsh7rrLQl50qSqxXVw4brPs/moCHpDZYowytSJo6Ear0/prrxNPBa2hmomtDADXXjVxmWuruqfhXlAi9rMx9K1ZBv7Xq7sTNMDcoCCVM01tdXoXaHxbAbpN+PLmW0BL0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614896; c=relaxed/simple;
	bh=NzlbnN8BaEoLy9B2Ja8SYEmYIQlp6KJJrgv1nfOktN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYfw3+oR6yTPBNGkzwhJSs7X2kFhVIwBZSsdeAjBSEL8LDJzSy3ihonLyhmMH3sDtKi9UUH+VQInTKJJ09OHdDC7FooGSf1/2XI8WywsyPupTpMGnT46n+v+YZTHmaeXrSVadzvgTJ/zYryYX25nPt1240ClcLAoz+5sOawCB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr68bQ/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3135CC4CECF;
	Thu, 14 Nov 2024 20:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731614895;
	bh=NzlbnN8BaEoLy9B2Ja8SYEmYIQlp6KJJrgv1nfOktN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sr68bQ/WqOKiEEq+gReLgmOp4xdVPORXObT4ZeqJN5eIYNIz47AD+Rpvs8huoXxj1
	 RJXgx3iImf8JmGT3sxAQS611SCa1NCfvbaRxSAjovQhfIbjJXpa6ru+BQCvrnVPmx8
	 33M5ThAYyAASrhCHi8fgMyWh8606W+2LpP40cFQuDgTbgIvaGD96pgwzX1o+0fdSqv
	 eNJlO7SzDt7NafJo26yWGbL+5dxfmKOegBZgXiJ1lCs7NpUsq9GnPcfFxdO4r4b8ft
	 KzW1FSCsQDVXtLvdawQEtfkRhsGaf+9zupUOjWJtXPqOCb0l/+58Rj/sfEZd65MpKH
	 5+LXvbe+s9GCQ==
Date: Thu, 14 Nov 2024 20:08:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH 2/4] dt-bindings: iio: accel: fxls8962af: add compatible
 string 'nxp,fxls8974cf'
Message-ID: <20241114-avert-overexert-71ef5039ccf5@spud>
References: <20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com>
 <20241113-fxls-v1-2-5e48ff1b1fb8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VkpH5g+Uk9QDYRpI"
Content-Disposition: inline
In-Reply-To: <20241113-fxls-v1-2-5e48ff1b1fb8@nxp.com>


--VkpH5g+Uk9QDYRpI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 12:54:40PM -0500, Frank Li wrote:
> From: Han Xu <han.xu@nxp.com>
>=20
> Add compatible string 'nxp,fxls8974cf' for the NXP FXLS8974CF acceleromet=
er
> sensor.
>=20
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.y=
aml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> index c375ef1bd083f..93985f670aa7b 100644
> --- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> @@ -15,6 +15,7 @@ description: |
>      https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
>      https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
>      https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
> +    https://www.nxp.com/docs/en/data-sheet/FXLS8974CF.pdf
> =20
>  properties:
>    compatible:
> @@ -24,6 +25,7 @@ properties:
>        - nxp,fxls8962af
>        - nxp,fxls8964af
>        - nxp,fxls8967af
> +      - nxp,fxls8974cf

Ditto here.

--VkpH5g+Uk9QDYRpI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZYqgAKCRB4tDGHoIJi
0nBeAQDdhSLj3wA6hYnXyzpD9ACnUMe6z/v6y6i4KFGTGKhuKwEAvu/rdyFn6a+d
YDNVotbRfTd5nSaOvH7YOp7jTqJ/zQA=
=9tIQ
-----END PGP SIGNATURE-----

--VkpH5g+Uk9QDYRpI--

