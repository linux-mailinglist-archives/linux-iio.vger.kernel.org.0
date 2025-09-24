Return-Path: <linux-iio+bounces-24420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBEAB9BA6F
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 21:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC9F1BC0119
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 19:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E81425D533;
	Wed, 24 Sep 2025 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tANQCKvQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BBB259C80;
	Wed, 24 Sep 2025 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741430; cv=none; b=K09a7JxLMSCT5G5f2kipYUYigb7eGGeINaskfx5YEsU/jeRAhmSD5XEnFryz49kWSO0kmRAIIbNVWsQELYopVI7ANZ4zIti7pbSQaDj0akjgLI6FS2BmnLFLheJxQoqKZUxSVmQu6nG/2yK5SZ7MmRFPQHG+G8mV+4c7LfvNOw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741430; c=relaxed/simple;
	bh=ZD8l345rxHyUebeYppxZuoDqXvIY4A9imateg/VG7sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqwTbkt+Y22bT1ITrlodV16zfcT0TE6cI18qMHZ/IDaxGIHFHP4++cEHY8TF4TVhjUYksnpGr92pbrBS/ElGd7s8WJRoTWxvkVUIkEwBoRRFhe1CikhlWHHcjiy1f/mVRCy5JegC0nw+85X3d48yCB0nG7oPzLSXDbPSv8Nqeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tANQCKvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA59C4CEE7;
	Wed, 24 Sep 2025 19:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758741430;
	bh=ZD8l345rxHyUebeYppxZuoDqXvIY4A9imateg/VG7sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tANQCKvQ3d0KlU3vlpt1l3pldk/xoRTc3g732/UKYvRW0vAiGT7DaPjAsy35TAlma
	 BJ9e8/dof7equpJqhrYPlt9QTNVtFa995K4q6gM8edbJDsGJ3pUS4h22cIKSa83Ie8
	 FRRiPdnbrePYoplqK+MsDT6hAY7YGtN/SQtRxcxna289zbJsvK8UoaoPGSvBvAhnQ5
	 dNdDqwal8ngqjZy2cyiwvYuej7F/wLQq+5fq1LsjaajI7Ydvz8l5dd3fem2VLsreBU
	 uxzxsZKoAFVz4hRhmvqYm033IKIDy7dMhT3OZEaGnIWt6wThalMUMN+opbR3oHMKe0
	 iDnBRQkKaF9Tw==
Date: Wed, 24 Sep 2025 20:17:06 +0100
From: Conor Dooley <conor@kernel.org>
To: remi.buisson@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/9] dt-bindings: iio: imu: Add inv_icm45600
Message-ID: <20250924-improving-directly-32653a1a3ff6@spud>
References: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
 <20250924-add_newport_driver-v6-1-76687b9d8a6e@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nIchMCo+j1dNfmaJ"
Content-Disposition: inline
In-Reply-To: <20250924-add_newport_driver-v6-1-76687b9d8a6e@tdk.com>


--nIchMCo+j1dNfmaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 09:23:54AM +0000, Remi Buisson via B4 Relay wrote:
> From: Remi Buisson <remi.buisson@tdk.com>
>=20
> Document the ICM-45600 devices devicetree bindings.

> +properties:
> +  compatible:
> +    enum:
> +      - invensense,icm45605
> +      - invensense,icm45606
> +      - invensense,icm45608
> +      - invensense,icm45634
> +      - invensense,icm45686
> +      - invensense,icm45687
> +      - invensense,icm45688p
> +      - invensense,icm45689

With a note in your commit message explaining why you cannot use
fallbacks,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--nIchMCo+j1dNfmaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNRDsQAKCRB4tDGHoIJi
0gqmAQCxdNGk/1YT46ujjoqm5x82KSyGYKiX0YxLTcm0btm44QEAxJps14IShznT
KrE3VecolTMwk/fLcNILWGtwnYT/LA4=
=/Kkg
-----END PGP SIGNATURE-----

--nIchMCo+j1dNfmaJ--

