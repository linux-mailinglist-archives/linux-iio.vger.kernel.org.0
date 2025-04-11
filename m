Return-Path: <linux-iio+bounces-17973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E846A8633F
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 18:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C8F7A84A7
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FC221CC51;
	Fri, 11 Apr 2025 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkw92rw0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2F42A9E;
	Fri, 11 Apr 2025 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389043; cv=none; b=K9T4DQcsyibzWpB0uk2DGYxMpWm6ZF08LPaR2mDjV4PfasGj8wnT4GiByDEMj+BO6IsY6A2PVjpB5SYXwc1JRFu7pq42OuWkiqnB011w2KA8HN7wuQdgBr4U6P/wZx/ZeiOoN9mnxJBslJnQWMo0FxCHzTVVzodzYNQTMlwSDsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389043; c=relaxed/simple;
	bh=rzA7OGbtaGWb2WWzawEPMwlOzKb3C8vVer76BVGZ5/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8euq32hpn4ypPleqzEOGttWK5dTI4lqjmxDiQiOvrr5x0LNN3++uJ6rRX32c/pXHOuNOtenjhDLLzQNCo08h7Vl3Cvy5q55h44UhzsxiN4UFXa8qd+NhsNyAwBs1N3bsFsrCSFhfO+pda9guAGHBrVVJ2gmRqoFthf81JmyffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkw92rw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80555C4CEE2;
	Fri, 11 Apr 2025 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744389043;
	bh=rzA7OGbtaGWb2WWzawEPMwlOzKb3C8vVer76BVGZ5/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkw92rw0oSBr7Q4D5ORKQ99/EScOtdSFJRONN57Hlsa5NaN4IjbbL7N2fP5bxRhUG
	 weKelRi/nOZx4FXifMq3tvcdrT26dprksCAaELhuWhTv/M/s83YJ+xZa1Oo3vFPUTP
	 uNk5UMQGYPMXh38E5W3G0LZGxN5eCiohMTB4ZlaGx5Q1tK7f1XXeu2PGVmutO9L/ti
	 3GkkPikaB91IJT1PViIabzuJRmVriVXjNhwpAOV65SssvXo7D4GIWM4gsEF+4O0TVl
	 kx9LR7U3JVn8R4Feerd1ZcInOzbFlObeeOhLsq/feUNZg/5bNy269SffP6HzkIhyKl
	 VNkVwGfFhuTAA==
Date: Fri, 11 Apr 2025 17:30:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v5 02/14] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <20250411-borax-shortlist-3a8511a09393@spud>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
 <35481552e9ce39a24a0257ab001c0bcfea1a23be.1744325346.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rkFrUhyQNNaycNfc"
Content-Disposition: inline
In-Reply-To: <35481552e9ce39a24a0257ab001c0bcfea1a23be.1744325346.git.Jonathan.Santos@analog.com>


--rkFrUhyQNNaycNfc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 12:56:17PM -0300, Jonathan Santos wrote:
> In addition to GPIO synchronization, The AD7768-1 also supports
> synchronization over SPI, which use is recommended when the GPIO
> cannot provide a pulse synchronous with the base MCLK signal. It
> consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> a command via SPI to trigger the synchronization.
>=20
> Introduce the 'trigger-sources' property to support SPI-based
> synchronization, along with additional optional entries for the SPI
> offload trigger and the START signal via GPIO3.
>=20
> While at it, add description to the interrupts property.
>=20
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v5 Changes:
> * Include START pin and DRDY in the trigger-sources description.
> * Fixed "#trigger-source-cells" value and description.
> * sync-in-gpios is represented in the trigger-sources property.
>=20
> v4 Changes:
> * none
>=20
> v3 Changes:
> * Fixed dt-bindings errors.
> * Trigger-source is set as an alternative to sync-in-gpios, so we
>   don't break the previous ABI.
> * increased maxItems from trigger-sources to 2.
>=20
> v2 Changes:
> * Patch added as replacement for adi,sync-in-spi patch.
> * addressed the request for a description to interrupts property.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 38 +++++++++++++++++--
>  1 file changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index 3ce59d4d065f..4c58dbe8f749 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -26,7 +26,30 @@ properties:
>    clock-names:
>      const: mclk
> =20
> +  trigger-sources:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 3
> +    description: |
> +      A list of phandles referencing trigger source devices or GPIOs.
> +      Supports up to three entries, each representing a different type of
> +      trigger:
> +
> +        - First entry specifies the device responsible for driving the
> +          synchronization (SYNC_IN) pin, as an alternative to adi,sync-i=
n-gpios.
> +          This can be a `gpio-trigger` or another `ad7768-1` device. If =
the
> +          device's own SYNC_OUT pin is internally connected to its SYNC_=
IN pin,
> +          reference the device itself or omit this property.
> +        - Second entry optionally defines a GPIO3 pin used as a START si=
gnal trigger.
> +        - Third entry specifies a GPIO line to act as a trigger for SPI =
offload.
> +
> +      Use the accompanying trigger source cell to identify the type of e=
ach entry.
> +
>    interrupts:
> +    description:
> +      Specifies the interrupt line associated with the ADC. This refers
> +      to the DRDY (Data Ready) pin, which signals when conversion result=
s are
> +      available.
>      maxItems: 1
> =20
>    '#address-cells':
> @@ -57,6 +80,15 @@ properties:
>    "#io-channel-cells":
>      const: 1
> =20
> +  "#trigger-source-cells":
> +    description: |
> +      Indicates the trigger source type for each entry:
> +      0 =3D Synchronization GPIO-based trigger
> +      1 =3D Synchronization device trigger (e.g., another ad7768-1)
> +      2 =3D GPIO3 pin acting as START signal
> +      3 =3D DRDY pin acting as SPI offload trigger

I think the description here makes little sense, when the value is
required to be 1 by the following line. If these are permitted values
for things consuming this adc as a trigger source, you should specify
that IMO.

--rkFrUhyQNNaycNfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/lDrQAKCRB4tDGHoIJi
0lOeAQCIpBe2H2YHSkd/Lfb6Cx1zeHJwglNtZkxl4phdFgVaYgD+ODa4HlGnx2rv
Pp+s4z/0PXnJK76WrjgwzM6xlGI/DAY=
=YLRC
-----END PGP SIGNATURE-----

--rkFrUhyQNNaycNfc--

