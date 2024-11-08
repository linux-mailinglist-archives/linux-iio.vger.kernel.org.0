Return-Path: <linux-iio+bounces-12042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758929C2436
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 18:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A6D1C2554C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04911F26D3;
	Fri,  8 Nov 2024 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGUhZ/7E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BAB19A28D;
	Fri,  8 Nov 2024 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087829; cv=none; b=Ap8xczYH6LRB7wu0dQIrOkqonjIQB9TJO2rtlXJrGp8BNI+WG3pkXMxcI1Qi7KTkSkluLHr2nBBsiiQBZIqLjFyWaTiejBIt9zys+Zfh6ZYAsETHIbIGCE3fgTPWQa56oM01RKpND4sXCM24ma5W174P95HYrokJkaBQb+n+uBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087829; c=relaxed/simple;
	bh=5jcsNiZqvlTtsLk5+oQ0XvOrIrn4fADnlIzf99W7rHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzstbkYFuHIGC1DfIEhcEaiokNXy5brhtegjLWVrAnJ05UsJlje2likzE5W6nCnirMR5m3XFSl1XVbpSBB4Gnvswh2oqI61yAgzDVQ2OOHNYaTTpyMzHIg0NCdpudl3nd+BClgdYeQe6BDBCtxZO7BGfVQDihYw9mUgai+T5alQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGUhZ/7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3AFC4CECD;
	Fri,  8 Nov 2024 17:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731087829;
	bh=5jcsNiZqvlTtsLk5+oQ0XvOrIrn4fADnlIzf99W7rHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qGUhZ/7EDbdyXI9HVanwy+YIVahVhaGUHEmBGKgotZ49ahxIHq9KmTAl1UmfSu88T
	 T5Dh7BoNwmVz7d9cORPXowG3QoqZ2ipYUoPwsOs+vONH7GuWZGNeF2JmagY23B0kbH
	 9DUwo+7VWR+Tn4J59lH3NPJ8qmn6SHmtX2nXx/G9l//pqcEu0ZVx0/Z11O/HbzA9Kg
	 CKrFyRnzVbLY1vg5ZUOyhH3P3nZvLnekVloMwC6mgobb18leIKt6BU4aZk9tXxDO9r
	 pZ9Fkf5Vuk5pKstov95HbQ6iL5yb7J2qUg+e8SLdv4WkXVaNru1Ykb3TwDNP9MW82D
	 kaIWPnv33OyJw==
Date: Fri, 8 Nov 2024 17:43:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Darius Berghe <darius.berghe@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, alexandru.tachici@analog.com,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: adis16480: add devices to
 adis16480
Message-ID: <20241108-carol-embargo-32975b7cdabf@spud>
References: <20241108125814.3097213-1-darius.berghe@analog.com>
 <20241108125814.3097213-4-darius.berghe@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fFmz2P7jrMA88KY4"
Content-Disposition: inline
In-Reply-To: <20241108125814.3097213-4-darius.berghe@analog.com>


--fFmz2P7jrMA88KY4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 02:58:14PM +0200, Darius Berghe wrote:
=20
> adis16487 is fallback compatible with adis16485 and as a
> consequence, dt-bindings list was updated to use oneOf.
>=20
> adis16489 is similar to adis16488 but lacks the magnetometer
> and has a different accelerometer scale.
>=20
> Signed-off-by: Darius Berghe <darius.berghe@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--fFmz2P7jrMA88KY4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZy5NvQAKCRB4tDGHoIJi
0gqxAQCF571MEWIx+QEbwplM4g5wKOwaQHVnb3JjoorOaiUl4gD+KsxAKJHYZuGn
+6oRZwOjLKiVW692Y0P9Kw9aZ71VbAg=
=ScDg
-----END PGP SIGNATURE-----

--fFmz2P7jrMA88KY4--

