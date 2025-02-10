Return-Path: <linux-iio+bounces-15287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9AA2F5C8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 18:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAFE162D45
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 17:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7325B68C;
	Mon, 10 Feb 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEFH8HRW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1026E25B691;
	Mon, 10 Feb 2025 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209687; cv=none; b=LhyvP5bt3W+vzk6jnlHqUB8KsU8OwGFE40sBL7or7Wx2dUeOTRHAp7nvMlFXMyLQAwRueLAfX910Rw9athTbO6m7WAFj/Tu7jNWyzI+49RqLX4a/NiTyPP0OpAqBSJoLXaD+CnxNeyNQgHzpXWRVEUMq9wBLKZpAFVD8wvA4L9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209687; c=relaxed/simple;
	bh=UqTuJyZrX1F27jfw6wIG3TWPnFiVOeJcCadbDkztkqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzmcVnTTZty27/2ZkcDda5P1Zp71Pt6KxnVTdnRSz/sKfXYH+KtHb+pPNO7FAxosxsyMMlXiWQ3e3KiL+8xRTR9OZ9RIlMDdGVDZtbXac3JrMfFHJj2QgtwUX5h41mobs89ypBJ68uwrFpmOHrRlM4evOqVJQB+ggYbWZGNAcdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEFH8HRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6738C4CED1;
	Mon, 10 Feb 2025 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739209686;
	bh=UqTuJyZrX1F27jfw6wIG3TWPnFiVOeJcCadbDkztkqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEFH8HRWaOEYHoBVAWOHHJ6u9TMwuMIzTDUXYq0Xxeo/5aZPDA5M9ffddnIeZbfPk
	 RAGOx6ZIe13llS5edd/uuqvKPU9uo+EhJqsPt1PIeqA38NxMgb011FVkQPkHpM+mzP
	 ZNeCk+0om5TIA7fZ1XeFT4LOSB8BjETCf9hvtEFtIt3C6Wv0n9FCve9kU1ngtpPNBq
	 pVdUBVCB+epDTKqVgA6PGP1VHxmVeVGzuC47HK3F5I5xn0hoHfu5yitDj15rPEiyXY
	 NooqULqyNt3EnfFYpklWrQgRldAdAbSCHGpyad/fjECxJDwLRtGVRLwyvJRZXqiIZY
	 JPbEynPw5jgBQ==
Date: Mon, 10 Feb 2025 17:48:00 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 01/17] spi: add basic support for SPI offloading
Message-ID: <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
 <20250207-dlech-mainline-spi-engine-offload-2-v8-1-e48a489be48c@baylibre.com>
 <Z6otFlsmEikIbI__@black.fi.intel.com>
 <27d2a88c-b44a-4712-b066-b999e41774f0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QDYpO5gEOaeXSXfw"
Content-Disposition: inline
In-Reply-To: <27d2a88c-b44a-4712-b066-b999e41774f0@baylibre.com>
X-Cookie: A beer delayed is a beer denied.


--QDYpO5gEOaeXSXfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2025 at 11:11:23AM -0600, David Lechner wrote:
> On 2/10/25 10:45 AM, Andy Shevchenko wrote:
> > On Fri, Feb 07, 2025 at 02:08:58PM -0600, David Lechner wrote:

> >> +MODULE_IMPORT_NS("SPI_OFFLOAD");

> > This diminishes the point of the namespaces. Anybody who includes a (dangling)
> > header gets namespace imported, which is not good. Same for other globally
> > visible headers.

> In this case, we specifically split up the headers so that the only time you
> would ever include this header is if you need to call functions in this
> namespace (i.e. struct definitions are in linux/spi/offload/types.h which
> doesn't import the namespace). So this doesn't actually seem like a problem
> to me.

Indeed - I can't see any case where a user would need the header without
needing the namespace.

--QDYpO5gEOaeXSXfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeqO88ACgkQJNaLcl1U
h9BHTAf+NsZ6fGYgEqb608Rc2IgVu1nXW39rdEMmwEX0ziE1qwwaxMOuWkergqau
0U3s6JGC4tTbBadpt7+FbUuTZzJmEwMtj3noj+j8dRxoobvyvEZugZl1yN1Ltb09
2ZgYnXy5SS0gQmC4KpXAWZFLtlK+09GYv+IsYbz6+zo+tKVUkadR2KD5a/DCxYwK
53YXiepisQH0E/Eegrr7bIRrQ14Qs1EPniCN92YdS1P9ZKWFv1PU7RgNwSDQh3g9
RBKF4K+y8cj86Dqv7KQGO4H8VgHy1MuagYoeQgDrzPNALW+sSVpVPvBqGsKPMVA7
yVbZk8py4U0OlZs4fIeNwexwhQQHvQ==
=3ETZ
-----END PGP SIGNATURE-----

--QDYpO5gEOaeXSXfw--

