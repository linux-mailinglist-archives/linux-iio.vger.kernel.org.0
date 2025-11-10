Return-Path: <linux-iio+bounces-26153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 394ACC48ED2
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 20:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BD614ECFFA
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 19:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF12232A3DA;
	Mon, 10 Nov 2025 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqw7NMWP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A297A320A10;
	Mon, 10 Nov 2025 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762801875; cv=none; b=u0EDvFvCum/10A88Yh/w2K+dAMVSuuKK1B4wqfXjCzDB+X44F40PcUA7upqJsANHYoVBzjSz/0bg9+t7zFUEex+wtFRAOhgR96vdZDGGO3K2VPo99pjdIk3dw3qoB+IzscThguTCJzvwMHO7HGL73k2FuFhXSSHWlSCBSTFlhyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762801875; c=relaxed/simple;
	bh=4xtpdZqP7qlBWq1FJ4j1oAwsxkHN4/xEN7o0xy/g6sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuFZhGwKneyNhTprrI2rUqZlwkrgvYfp5ssc5pccuxuSi/Eg+BFMzpqis/0M4hPgCgx8/hhoXi/szmabPhCk+fFToydZ13hLx1QUFsX36RveJfcOLmcTc8FHQc3qXPHq5UzPdMzTjP6lAWktgXEoAfqu5TunTez/52pP1UP+xYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqw7NMWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4925C4CEFB;
	Mon, 10 Nov 2025 19:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762801875;
	bh=4xtpdZqP7qlBWq1FJ4j1oAwsxkHN4/xEN7o0xy/g6sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gqw7NMWPqEbjILjwj7RNoCuFNgaVKzAHGY70xSIudtO6B/wQWZNI3RJ06V+F+AJwM
	 h5k4uL0ErB3pXuBvOvyP1f2hxpAxvbePLwc/W9rKl7R55CXx1kNtsZTFSlj98Bmb2S
	 syJYopyTibRkpGCSuLLW9qFPwVfOBwQMvFMrMuhue8JODFgx9ZJgkzgbg7YVF0941p
	 1DJLMouoaPJ2zOJkH2AkWJNM5hcMDh6rp6la3zq51tzPbgnxcgjWj2GC0EtS1p+8B9
	 D/kEdZuYLtzGZ+iPWTqEyJFhHu5q2/d1oLU8yt7fYTDwGSTgnhZeZphivXeVmy2Eyj
	 4jLwTi5Qr5UNw==
Date: Mon, 10 Nov 2025 19:11:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 1/2] bindings: iio: adc: Add bindings for TI ADS131M0x
 ADCs
Message-ID: <20251110-feminine-vineyard-8015082dab35@spud>
References: <20251110061409.726028-1-o.rempel@pengutronix.de>
 <20251110061409.726028-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P7W2lCZtskYuirUH"
Content-Disposition: inline
In-Reply-To: <20251110061409.726028-2-o.rempel@pengutronix.de>


--P7W2lCZtskYuirUH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2025 at 07:14:08AM +0100, Oleksij Rempel wrote:
> +patternProperties:
> +  "^channel@([0-7])$":

This looks okay to me. One thing to mention is that you alternate
between using channel@[] and channel@([]). The ()s are not needed, as
evidenced by the former working ;)
With those made consistent
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

--P7W2lCZtskYuirUH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRI4zgAKCRB4tDGHoIJi
0tLEAP9RrLy7Xpr4zfSpCBhDA400xcH8tCqfSWnE/BddvBVXvAEAmTxUzq3UoJqE
DBoCEVf1Jjqu53MXlbVvUhjt51/KuwA=
=MALT
-----END PGP SIGNATURE-----

--P7W2lCZtskYuirUH--

