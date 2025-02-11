Return-Path: <linux-iio+bounces-15341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8000A30C5D
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 14:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994F73A73EC
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 13:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAE721D00B;
	Tue, 11 Feb 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnoD0KpM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB41204859;
	Tue, 11 Feb 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739278816; cv=none; b=UO/L+DsLvvv8eoh0QIZg00malixlPLV9ZZm8ZIxb8RdbzCjpjogaFfcS5PDaI5CRUozKRl0RtvMhq2f0cuhwTj6YqDO3QNh/h2vPdZERcghbAjEFAm9DdXIWFtBH5aDlxCq3YWwUsowzT5oHG8fEHRrwnDLihJjeOHjCo/agnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739278816; c=relaxed/simple;
	bh=A3BZpJLJafLrsTduj49Udb7kidzg/yb+lZ0uRxIf3cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1OZT6COqq4uKlzNU950GT44/9B0e80Nn/65HNmNGJ8ERlqPhk5McYRY2EofRjzwuS80cscBH4opW+tz90eP3/xi5EaB8R2Bnul+9f2imQ2PNBTMqqd8ZMICYZcuvsP1PMeVVguxme9rTavIqQn3TwopkmGNPF+0wjaXGfLsY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnoD0KpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCD3C4CEDD;
	Tue, 11 Feb 2025 13:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739278816;
	bh=A3BZpJLJafLrsTduj49Udb7kidzg/yb+lZ0uRxIf3cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UnoD0KpMGl1O7VkYH6bKVdhRA7raY63f/1GA+HvAPFCaExeG6n5hzOXcu/iJXIdjU
	 IbPOiqfQx7Tst1Xaw526vZ7pipFmQlQVTChifj0nI6NUoSQp/QnKCTSqxW1dJDLyBt
	 FOgJEf9eYw0u6RSLP7Q7wHBMdqXOWhqvayGipWMgwrjI3oq+C8kpKAPbhwmdo32j3e
	 gzEdXO0wC0RLPZfQazADSMkCaYDTh6IFSn2r5Ed6VjGHo6sjuqr/ajlNQn2LT0ZIEi
	 w2aI1RmnC7OTqDFXFGIZDk4FdEwFktTnyot3ljBOf/qK4S3rfGJoTOHw39jPO4iUiD
	 3G7jhQwNKXFOQ==
Date: Tue, 11 Feb 2025 13:00:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
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
Message-ID: <b000d3fd-754a-43e8-ab10-82677eeee1d2@sirena.org.uk>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
 <20250207-dlech-mainline-spi-engine-offload-2-v8-1-e48a489be48c@baylibre.com>
 <Z6otFlsmEikIbI__@black.fi.intel.com>
 <27d2a88c-b44a-4712-b066-b999e41774f0@baylibre.com>
 <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
 <Z6pim_nLct33LzfN@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J/EFsBuP+b+AoL5b"
Content-Disposition: inline
In-Reply-To: <Z6pim_nLct33LzfN@smile.fi.intel.com>
X-Cookie: Printed on recycled paper.


--J/EFsBuP+b+AoL5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2025 at 10:33:31PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 10, 2025 at 05:48:00PM +0000, Mark Brown wrote:
> > On Mon, Feb 10, 2025 at 11:11:23AM -0600, David Lechner wrote:

> > > In this case, we specifically split up the headers so that the only time you
> > > would ever include this header is if you need to call functions in this
> > > namespace (i.e. struct definitions are in linux/spi/offload/types.h which
> > > doesn't import the namespace). So this doesn't actually seem like a problem
> > > to me.

> > Indeed - I can't see any case where a user would need the header without
> > needing the namespace.

> You are looking from the other end. What I'm telling is that anyone who adds
> a header, automatically gets a namespace. What's the point to have namespace
> if it won't easily prevent from (ab)using it in the code. I consider putting
> MODULE_IMPORT_NS() in the headers a bit weird.

Sure, but there's no case where anyone should ever be adding the header
without adding the namespace which does rather sound like the sort of
thing where you should just move the namespace addition to the header.

--J/EFsBuP+b+AoL5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmerSdcACgkQJNaLcl1U
h9DBYwf/d4mDef4Pkrie8SuKHHBQWTYej9llUslvUazOm/nwONmglSBhyo34uT0/
zD/M+rieJKO0icoS7JXCXacLfDkKN2uZW+7YTPOv7oZoRSL/wcT/0nh2naj2s7X7
5v8cxp0Jyg241ZE4yDnrlD3jSbwckgmpgiTzxW9VpRdvWLxdHpmiRblNnEkv3ZWL
dHxctlWq0LLcXGFgxi9ll7DR5Buv2CVMgZ3201YU0Z0GKUf5qgiTkESh3kbGPsi5
ViNPz4Y/pw44IYZkUGLbXZC4OkeoTIXto9AOjfksA//FqGeaRKhaCrB0dfZbsI17
TNV6zWgxLhSvR3UpTWYVanq8UX4e+Q==
=ZJSN
-----END PGP SIGNATURE-----

--J/EFsBuP+b+AoL5b--

