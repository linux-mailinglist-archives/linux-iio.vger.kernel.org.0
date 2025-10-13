Return-Path: <linux-iio+bounces-25041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3081CBD6026
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 21:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635414023BC
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 19:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6332DAFC3;
	Mon, 13 Oct 2025 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRWa/P81"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B42D9ED5;
	Mon, 13 Oct 2025 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385071; cv=none; b=pA39VzwA0VPByIqgXz8pxXealIbVuwpJeels9yX6PeGo3VH23dK3dRWBkAtx6P/p+9rxv5yLFCXeuzKXRZNTv/MDcKIXDTCWhU3d/YsZm3RxxkctcRvmpl2bbxouyne2ffXXUx2lJTmBTvFv34o8yRwqL9Hkn326SID1BppSjBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385071; c=relaxed/simple;
	bh=k1p5K4U/ovoo+UpHT8ErVNp472bmdWcOZdyUDjpjbhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bte63SKv6ZMLcH/S2OSABKDzrVDe0sSASdrbSbZ2qRtkmOPEoUqwycBq/X96GP5FMEnG38Jt6RgpdFpWeZomtQnMOi5CraVTPNH6FxEkR3/kWf6yEkQuUZmIIbDQNFMnMchcrf21FYndZZMDWme5Fy73A8pyk+xxHnb+Fk5TBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRWa/P81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A661AC4CEE7;
	Mon, 13 Oct 2025 19:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760385070;
	bh=k1p5K4U/ovoo+UpHT8ErVNp472bmdWcOZdyUDjpjbhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRWa/P81p8llnWWoFLPBN5UnrXWemVckmupDsG78PDFdEMxyd98ysW5pD9wgbF/v/
	 FJSzEVF9Q34uQ6pV2W77R0HdhLWJIgQnctg0LwPutG8Gm16czS0htzLAeWGBez08PH
	 ypJolhs88jUZeXeRNWtbg2kD8nYKOklmt8HoK5mGLLvYLUZIV+mpbi5wuIHxEbjnBm
	 bWolqHcA4iHwPjOIV/2KBJ41vbHEiJerDSNtON+PSDoSRiaHqOVIY8NkWrZVBxHIEs
	 n7pukqQeRagT5EsMD7d+DYoKphpGCc31tMVEWfsit1Sn8GbUqAdWR03ro0tr1YsYG2
	 vtDLjPdpx+BPg==
Date: Mon, 13 Oct 2025 20:51:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: accel: adxl345: document second
 interrupt
Message-ID: <20251013-reexamine-sniff-55195ddb2254@spud>
References: <20251011210513.3253-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j21nQ4iPt+JAD0/p"
Content-Disposition: inline
In-Reply-To: <20251011210513.3253-2-wsa+renesas@sang-engineering.com>


--j21nQ4iPt+JAD0/p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--j21nQ4iPt+JAD0/p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO1YKQAKCRB4tDGHoIJi
0vPqAPkBHQUL26yeKmn9wazXmFHm9AioUS8kPIUecVnVuqLPRQEA/tAKbowp2brn
7wKBpGQBn0L1PK4TmrzX8zy3QneQugw=
=TWKQ
-----END PGP SIGNATURE-----

--j21nQ4iPt+JAD0/p--

