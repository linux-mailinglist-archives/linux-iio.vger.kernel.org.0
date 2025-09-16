Return-Path: <linux-iio+bounces-24152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4598B594F5
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 13:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EC34E11ED
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 11:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634932D5C92;
	Tue, 16 Sep 2025 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G65cqdPg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F5F2D46B6;
	Tue, 16 Sep 2025 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021558; cv=none; b=dMZJP82q40btNCgJ1XnkDIOjW7BA5BspNXm/EGQSrX2H3YvN3jef2plxhw+T5IQ6RsPxFS06CKaN6hZuW0R61OE9E3AwAe5VgPwzfiBvme68QzfZ2mJC/TG7cY3a5hZfMJcJ4JzT9XjpK+qEIoHrvWoUD4WQKNcewdWpx9ykGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021558; c=relaxed/simple;
	bh=h3QHa+7pUL0eyFT9zKSxUDYj07fVGoExcdeVN2+uMuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctbFnI0pAxrcxsV0MMJbPkVoZINMmeqBFnmutfqj6q4/ObYw138W/z0Sv/kgR5P36qejgupmY3lDgwmi1AOu3mokrQJ274pyiOJuqX4hWG42Qe6yiARTcYF9wWtxLLHXEb8WYYNuWlp4+nOOCL8XS/9/9Z1WWoX5vHR9AMENoiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G65cqdPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A41FC4CEF0;
	Tue, 16 Sep 2025 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758021555;
	bh=h3QHa+7pUL0eyFT9zKSxUDYj07fVGoExcdeVN2+uMuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G65cqdPg55ZeCRfuKY3dDofW+3CXzUS4E44yG6TAJI6sb7VX1BqbSq/3yQMqak9J1
	 7YP91GfqfS4yWRIS7JL7d6OnrfTML2V6CsoVXzTDTp3fkL58i2RbtohJv0Ce2VmtB/
	 TVHirJm4OFwZcqtRPiVLiCeEbuEUL2LFBaUJUSRk76prGPJIMQRW4OjbNYx0t2mIdS
	 ez/kFgA3qXa2F49OTtGnc/LBd5Zd0MCfqPW+pNTLhJjJ/crMWi9rwcFQhgNUjI6NOH
	 YQJYuclOqW+JtxbkvM/q2zv1DphMPMEVLvovMVFDZNqOof2EspUFaeXoI/y6E83k3u
	 G2nQKlW0mYfxQ==
Date: Tue, 16 Sep 2025 12:19:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: add processed write API
Message-ID: <ecdce9fe-dcb0-46e0-8913-d733040a74c5@sirena.org.uk>
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-2-fd4e781d33b9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NaaEyeMGCXItHdyp"
Content-Disposition: inline
In-Reply-To: <20250916-ltm8054-driver-v1-2-fd4e781d33b9@bootlin.com>
X-Cookie: The people rule.


--NaaEyeMGCXItHdyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 16, 2025 at 12:24:07PM +0200, Romain Gantois wrote:
> Add a function to allow IIO consumers to write a processed value to a
> channel.

This seems unrelated to the rest of the series?

--NaaEyeMGCXItHdyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjJR60ACgkQJNaLcl1U
h9AZ4Af/V+o5xEgGh1Fyarj8hqlyHjIUT65TfmeDxJST34i1/XHSictl5u0SlY25
mOrGy+F6RFUOfHdjYtQ+eXi4nCQIb8+/p4EiivRGSxEOqqfoUVxOLWdLy96LzAji
dMFJ5GPQ4p4uSfGvcyja41lgJ1BgmmU9CEDPzVz01V9uG+9j2ZPHtrUS3eFGTRRq
Z32TYoYr9pH/I/DVYtDvNqjRgyDFVMUjeqqc+WIHh5z+oQfZvqa/nR9/mN1A/YjO
DI9oZCsw+nq/uhMkDbqWCZ3qoUXkgu6Tr6IaOqNogzHK+CSYacYtP73wMrmWV8zp
Nz/2X/jJwC+DvOf5GXs+z6kJPwDmew==
=gddA
-----END PGP SIGNATURE-----

--NaaEyeMGCXItHdyp--

