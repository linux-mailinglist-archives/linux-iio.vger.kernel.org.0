Return-Path: <linux-iio+bounces-337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF8D7F8AB2
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 13:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26FD628168E
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 12:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297EFBF2;
	Sat, 25 Nov 2023 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZn1Thnd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E3B539F;
	Sat, 25 Nov 2023 12:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEFDC433C7;
	Sat, 25 Nov 2023 12:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700914889;
	bh=NokKKbjP7/sQSnXyJk7VS1kmyB9mZyNesxHCciD9GTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZn1ThndkOxaashwIdkq7g0vJIDCBIrMA6MwUpzzpcR2SEnw0+PJRhbP/Lo128eId
	 EUM5asAXzdU38JeWM1oGUECkoCOzVjIiP+O32x05fHTVuLAPr+Eg2dAHeIGtPrNH8l
	 Fro+ofqk2VSxRF57cijh2a1U9QTzUvs5i0qmzj0hrRKLQ2fWz7xKHMkvURudMokFVd
	 xC55+IbcYeMw8AEVGXiQcRlbeiJc+dzMSI8oM8XBwAXmr67PXGWJ2n3FL35oFo/sEx
	 sSGp08vzujBog9qZ7cllzcegwoz1S9W5fMPxy1DFU/WwYoNnJlgfqJLRZvvtQzufKE
	 1Wb5BZgnf8jGg==
Date: Sat, 25 Nov 2023 12:21:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: paul.cercueil@analog.com, Michael.Hennerich@analog.com, lars@metafoo.de,
	jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] dt-bindings: iio: Add binding documentation for
 AD7091R-8
Message-ID: <20231125-pennant-untie-90b5f0828258@spud>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
 <8ce972a3708f7789237c86c44e23cdcb23a35103.1700751907.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PpbYFIjhbA0yHs/g"
Content-Disposition: inline
In-Reply-To: <8ce972a3708f7789237c86c44e23cdcb23a35103.1700751907.git.marcelo.schmitt1@gmail.com>


--PpbYFIjhbA0yHs/g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 23, 2023 at 01:42:21PM -0300, Marcelo Schmitt wrote:

> +  spi-max-frequency: true

This is not needed, since you have unevaluatedProperties: false &
include the spi periph props.

> +  adi,conversion-start-gpios:
> +    description:

> +      Device tree identifier of the CONVST pin.

"gpio connected to the CONVST pin".

> +      This logic input is used to initiate conversions on the analog
> +      input channels.
> +    maxItems: 1

This looks pretty decent to be overall though.

--PpbYFIjhbA0yHs/g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWHmxAAKCRB4tDGHoIJi
0p1xAQCpqjmqfhVCI9G10fGp0R0KaL5NUz2lINY4C7iNmT/CfAEAuBsu2q+bVFVP
hMsHHj47qNHfR+n8TOZtwwVR460T3Aw=
=fPlx
-----END PGP SIGNATURE-----

--PpbYFIjhbA0yHs/g--

