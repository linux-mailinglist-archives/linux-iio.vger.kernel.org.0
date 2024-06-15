Return-Path: <linux-iio+bounces-6279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAAF909672
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 09:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB66C283A9E
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 07:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221C014AB8;
	Sat, 15 Jun 2024 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+f6apqH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D174C4A1E;
	Sat, 15 Jun 2024 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718434922; cv=none; b=HzW0IM87aymn/fiHPm7UWX1JTDq1dZB/LO0oN/7pV3SfsRfghSCslM5YSGFGRVxljXoDhCXBb+swDuole1qHCEoVGAevfBLrUYzLTdisfE6LTsuxzFZvoCqNnS0SgVChtd/NL2ZplRDhWQTSM9xICmHNRlai34uiV0aCVpRZ6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718434922; c=relaxed/simple;
	bh=mGIFGMyiEP8UcVLdrTaxuW57+qpdlEUzjb0401iGIqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fADHAGHJrtChYHH5HRH10kd/AWF6n0nHjKSodJDcVdxfYpOBKxaWJui3YUUIvN/Lk/OObMeLHRzUvUjccGo2RwsKq0kjPxSDiBJdQJBQJ0d0F8NTtFgjY3bKvRK5LMlkNQQrnYnb+5u59ivb+RjuZ27TqTolUxDaghECn8ETLTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+f6apqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386EFC116B1;
	Sat, 15 Jun 2024 07:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718434922;
	bh=mGIFGMyiEP8UcVLdrTaxuW57+qpdlEUzjb0401iGIqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+f6apqHc7fD94GdW3X2oI9/CYR868p9GFFnIldPxv/rwD8/l8q7VAULcBBfalm5t
	 78uvdkfCi07ZT6PMAqZEdW8V8e9SsJaqa5x9+CBCu9dRKtcVCeWjiEfa+DTOD8XwD6
	 knCdpZNy/3f+EaICXaK7J0CF5XBdNRy4yvvyATrY6SJsSZpJ61I1VC0oioi3sT7jTg
	 D9fdFj8b6G+5E6f3dQ9EFXV5/X5eOptkjDXbRIKmQ2cqO9Sr8F0YfyZMhQfrzCjgXo
	 00R9bvqu19VEOc+G3CBWDex6vVznRKruD3Hnq5VET2x3I1iYmvv5tI8S4D0lhNQtn+
	 cUWKmh4uTSlyA==
Date: Sat, 15 Jun 2024 16:01:58 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Judith Mendez <jm@ti.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: ti-eqep: implement over/underflow events
Message-ID: <Zm08ZiyXEgWYLZbc@ishi>
References: <20240609-counter-ti-eqep-over-under-events-v1-1-74fe1632f5ab@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5rDbGY9WaoBneDXG"
Content-Disposition: inline
In-Reply-To: <20240609-counter-ti-eqep-over-under-events-v1-1-74fe1632f5ab@baylibre.com>


--5rDbGY9WaoBneDXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 09, 2024 at 04:49:33PM -0500, David Lechner wrote:
> This adds support to the TI eQEP counter driver for subscribing to
> overflow and underflow events using the counter chrdev interface.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This is split out from a series that was sent a few years back [1] that
> I never finished, so I'm calling it v2. This was tested on a BeagleBone
> Blue using LEGO MINDSTORMS EV3 motors and this script[2].
>=20
> [1]: https://lore.kernel.org/linux-iio/20211017013343.3385923-2-david@lec=
hnology.com/
> [2]: https://github.com/dlech/linux-counter-ti-eqep-python/blob/3745b0840=
736248d8e60cc675a0f43558fcbb2af/test.py
>=20
> v2 changes:
> * Only clear interrupts that were handled.
> * Don't set default QPOSMAX value.
> * Don't error when setting QPOSMAX to 0.
> * Use regmap_write() when appropriate.
> * Validate watch channel.
> * Use counter_priv().

Hi David,

It's nice to see progress on this again. I remember there being some
sort of interrupt storm if QPOSMAX was set to 0. Is that still the case,
or was it resolved with the changes in this version?

Willia Breathitt Gray

--5rDbGY9WaoBneDXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZm08ZgAKCRC1SFbKvhIj
KyjmAP9nNugcU2bKySz+yH49JaVB3/oK58jNapUVdysZL/9jlgD7BFQtFn76eBzf
9qFFPWxCic7ze1h/MK2usH9pMwgYYgE=
=qEE6
-----END PGP SIGNATURE-----

--5rDbGY9WaoBneDXG--

