Return-Path: <linux-iio+bounces-7787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B7E93927B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E510E281F84
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB79316EB4E;
	Mon, 22 Jul 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stthm30L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7481B16419;
	Mon, 22 Jul 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665602; cv=none; b=KDxXgaJqHFuBJhiEO8BiDVAJ59mCe80it3+AhN1ILurJ12RuqZk2eywoZ13bdFXOi2wDvcfgToeJhyjjSGwpU0E3kFLjUPTaDjVqumv40XYv5R6MBis/4U6iIPGiTXDl0s4S406as1y4PN6KkCjX6eITiBbF3z+Iu3ibkTh9YBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665602; c=relaxed/simple;
	bh=UDqBe1b077LvJtEdbbfQEQg4LEyCvgzmG0eD9KFM+KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMYsctXI/PLkhKXKp+xlatcxxgZ8xu5feoF497Vqtex/Qzo40Knp60mDlDlFQF7xlVUPfI6yjKr1wxXhpr6Zol5e85P/OBUTQ0X8mdyJYBnYr6aYY5sn5BKLUmq/A58NGSMS4NyVPpSY80bqGDNajWL3m9tOA3xkRbcbnPFD+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stthm30L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBABC116B1;
	Mon, 22 Jul 2024 16:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721665601;
	bh=UDqBe1b077LvJtEdbbfQEQg4LEyCvgzmG0eD9KFM+KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stthm30L5JEShKSTa5HS8I2Nt4Jd+QP5IKZauoHxw4C2Y3mXQxxNVXy1e231xnikX
	 VP8usJbX18NAl/WUxKOl9sz9QTl9Xj5tN0ebdHsEaRy2u6mDfPbtsCJf2UKY40CL5o
	 R/MDDS2Yh0nfYdCFwfAzz64WRQD+VQu45On/HPqX9NItu7O1Rx6eHP94BSwEvWp8cD
	 RUX3ptCLbZiWOKZaaPQfzkUJxWBKBIJN2hliYy76HRNdfiXclMgkHDJVHBEqOmrtUc
	 mx0Wm4gmfYRBnJ9pmif/msiD78yYPMbS+t10a1mIRNkmqGwugxoRPO3nUnVEad8Wkd
	 5q2A3KORlcKPg==
Date: Mon, 22 Jul 2024 17:26:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adf4377: add adf4378 support
Message-ID: <20240722-legibly-senator-db5651fb279b@spud>
References: <20240722134508.25234-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5g+/csKuU79US8qj"
Content-Disposition: inline
In-Reply-To: <20240722134508.25234-1-antoniu.miclaus@analog.com>


--5g+/csKuU79US8qj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 04:45:05PM +0300, Antoniu Miclaus wrote:
> Add porperty conditions for the adf4378.
> Add product link for the adf4378.

I can see this from the diff. You need to explain /why/ this gpio is not
valid for use on this device.

>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - use property conditions for clk2 gpio
> Note: the compatible is already available from the firs iteration of the =
driver
> where these particularities weren't available for adf4378
>  .../devicetree/bindings/iio/frequency/adi,adf4377.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.=
yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> index aa6a3193b4e0..5f950ee9aec7 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> @@ -17,6 +17,7 @@ description: |
>     applications.
> =20
>     https://www.analog.com/en/products/adf4377.html
> +   https://www.analog.com/en/products/adf4378.html
> =20
>  properties:
>    compatible:
> @@ -73,6 +74,15 @@ required:
> =20
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adf4378
> +    then:
> +      properties:
> +        clk2-enable-gpios: false
> =20
>  unevaluatedProperties: false
> =20
> --=20
> 2.45.2
>=20

--5g+/csKuU79US8qj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp6IPQAKCRB4tDGHoIJi
0txGAP0ZdtczeTowZG72UHj2+WEbvBL/WcR1eq9pizIyQbcIngEA9ACer00fE6oB
mlb4kTva2zT/5Z/Rig5WgyWWiSWgLA0=
=evtU
-----END PGP SIGNATURE-----

--5g+/csKuU79US8qj--

