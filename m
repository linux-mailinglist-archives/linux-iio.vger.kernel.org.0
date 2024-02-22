Return-Path: <linux-iio+bounces-2908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3826985FCB8
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 16:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4604B26DF7
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A79A15099C;
	Thu, 22 Feb 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAvZKL/z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550481B7E6;
	Thu, 22 Feb 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616439; cv=none; b=XJHtShOozDPnC7KFdloqMzmchtn4p+3iXHajkHhCnbNsKlO0P4Jrn9TgS2EWFEyJ/l4jDc4tUeQyYZiItGw3g4oWuBB4of4GL9w2HHADdNDpz7xzIqinR12wUtqI4tFSfe4htfkFLR45ig/n2lHS0GzoW1Cqf89nn8rGQQJLmHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616439; c=relaxed/simple;
	bh=xc07QGkepUAGGcDE2z3e5aOhvw7tXF1qa6A82GqprFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZjoTLUy8D/B53kEdEbbi0ts64vetvKmD/oO/RYW31gLd9hohvSqLmkscktWE5UQWEBi3DaU/b8E7rssEo36WASgJeUbLm84lqiCJaLm0c7JPm1JM6sRUgN65SVmtrBpuR5qustOl0AVt1Zdj1c0H77H9CopR1n6AFyMVG3WXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAvZKL/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2EBC433C7;
	Thu, 22 Feb 2024 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616438;
	bh=xc07QGkepUAGGcDE2z3e5aOhvw7tXF1qa6A82GqprFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sAvZKL/zErRTChJH+5+VlA8B4Sj4bBpztoBx/4wBbhusDuPrYf14Uv1l5TpBrwwSI
	 PaWcDlm64yVHcCL1VoMokXRWwJdZEJ5io+Q7MBPsE+cluKRYo5eanIswjcpU6zjrjZ
	 xD/5MPJZNPJWoOg8qP7eX7+K6qmWfZd5OhM+19M0zJvt1QdIwFvdZ17dGSRm7r++PK
	 oj0lHr/raFp08ItKhQodXYaRYct9w8paZ8lFkY46OaRzO/Z1wLrmAniXU5ioZbcTcv
	 0fgONqVqyynW+IoL01ubF5Ea6zbFqlNa5xdtGeZDNBQH6odMNAJY7sEgRUy7Xe6+J8
	 027i7X98Q2J4Q==
Date: Thu, 22 Feb 2024 15:40:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: iio: temperature: ltc2983: document
 power supply
Message-ID: <20240222-component-stiffen-d046386433b3@spud>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
 <20240222-ltc2983-misc-improv-v1-5-cf7d4457e98c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FdbL3WJlakIndfR1"
Content-Disposition: inline
In-Reply-To: <20240222-ltc2983-misc-improv-v1-5-cf7d4457e98c@analog.com>


--FdbL3WJlakIndfR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 01:55:56PM +0100, Nuno Sa wrote:
> Add a property for the VDD power supply regulator.
>=20
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc298=
3.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> index dbb85135fd66..8aae867a770a 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> @@ -57,6 +57,8 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  vdd-supply: true

Although technically an ABI break, should we make this supply required?
It is, at the end of the day, required by the hardware for operation.

> +
>    adi,mux-delay-config-us:
>      description: |
>        Extra delay prior to each conversion, in addition to the internal =
1ms
>=20
> --=20
> 2.43.2
>=20

--FdbL3WJlakIndfR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZddq8gAKCRB4tDGHoIJi
0nnFAQC2H7lqeY7aI5oJlOwOs78r2LlF1Qhqa1z9Umxt2l37BAEAsbgxlVhtSoqg
KhXR0NV/1sCXBFgT29Sm8SaduDmOnAE=
=9wDI
-----END PGP SIGNATURE-----

--FdbL3WJlakIndfR1--

