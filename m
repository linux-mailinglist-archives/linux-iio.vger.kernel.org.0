Return-Path: <linux-iio+bounces-7637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F067C932E4A
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 18:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8846C1F227F4
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3B919E7D8;
	Tue, 16 Jul 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzuZwuXD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26711DFDE;
	Tue, 16 Jul 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147312; cv=none; b=WwHmGWzrQ25mudOESPy/LKZHQUgHi/eQn2KkmP7Y+5roZokVcSQK+uVuKPRxSvO8NcV7MVYoy7Yyq0R3rM+wh+JndNaSTWeEaQh/sW3ztsieA9rMfDwhCVbwsCC06yu1H2YHMbvBXyTaRd5wDi+Gf8LFJCu3Cz+XCkeMJOsLPms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147312; c=relaxed/simple;
	bh=RgQT5cQ2M/Pr3td1yEhvTzpnWteXm56CUxfKnuWVZ/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkzzLr4X1ekmVnmqITJ09uR6D1WP92gjS4wU0LePf9/dSX/S4hqXtq+1Yxqex/gPjVHpTDJZJxrdEtlRp+nblSwuX+vrGaezoq2dykCed3EHBwbID3TIe0orzsyuZh0xpU7LyXobl0GZBfBaXhSDJ963TFx8/0RW6l7BI9IDnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzuZwuXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954C1C4AF0B;
	Tue, 16 Jul 2024 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721147311;
	bh=RgQT5cQ2M/Pr3td1yEhvTzpnWteXm56CUxfKnuWVZ/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzuZwuXDj3AeYZNmNf4qm53Jmq0NskziRyyu+Xnb3del36Z9mIqs/SzyFjDR9VQ16
	 wEWe3kh1mfLBBEJXgD3RZo/y2QMMraSJ2/8MtKAL7RVoV8gPsURFuJlJjRPGum9e4e
	 aIUtynmUYpN3VGujwa0d+8/8phh8g3hXucByb04KlnRyMOUFkoxrkS4A6iihxD2jnJ
	 xopO8pW6mOqmEX00MUNUh2GA0WR5X4PtkpjeJ+hbpApD8rm+9lJNgh7KYZNMg7EBgb
	 5PxZv82MbzjxuLIvtjapUmlE8L8Ppx+beWEmomaVOooea1Xdj3JkhojROYkDGeu8Ql
	 6oDuAOpaAsrbQ==
Date: Tue, 16 Jul 2024 17:28:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Rayyan Ansari <rayyan.ansari@linaro.org>
Cc: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: magnetometer: bmc150: Document
 mount-matrix
Message-ID: <20240716-constant-underline-b6ad3e2cb571@spud>
References: <20240716132512.80337-1-rayyan.ansari@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cAKuj4M+rxN3rVll"
Content-Disposition: inline
In-Reply-To: <20240716132512.80337-1-rayyan.ansari@linaro.org>


--cAKuj4M+rxN3rVll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 02:25:09PM +0100, Rayyan Ansari wrote:
> Document the mount-matrix property, which is used in device trees such
> as msm8916-samsung-fortuna-common.dtsi, and supported by the driver.
>=20
> Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--cAKuj4M+rxN3rVll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpafqwAKCRB4tDGHoIJi
0mcWAQCqkJGK1cHztBMlGXWivHsZc7XNeCfTcsBAQCeT5aGvhgD/Zkg9J7Qoao6H
gKdxHLnwRX+6ob7yCImvu/Xr76wuCgc=
=U2zY
-----END PGP SIGNATURE-----

--cAKuj4M+rxN3rVll--

