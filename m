Return-Path: <linux-iio+bounces-6002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A822C9005A7
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 15:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F1CB27741
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8321953AA;
	Fri,  7 Jun 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8ixaMzu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0570A1946A9;
	Fri,  7 Jun 2024 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768373; cv=none; b=lrBmAC15Y2H3Vsk170PNn61xIuI4qwzZGYYWHYFkrQE3l7eMpW6lATGNjflTBrXPttHZj06nYc9hflJdc/7LkMHhnondfnzVgc0qEFEXFwDqFSvH2XNLR71sTwvFCYqFmurkAjqUld8Pe/IWPsfWMm+XQyBjlLVdWYNtFwBkGlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768373; c=relaxed/simple;
	bh=XGVX7AZuoXtC4aHwOBmnRoGcJiF2HZ1EWEecnKPuTHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFNQdQlMXQBqg5RQEySf9qeQvTxxkFuRyVNiwkJRNwaXjWiFNMZe29LDMh8wrdr8aXk9+w9gdPXzKc5C/ZU7AD7dGOZ7EzGpEhpBjZwF2nKqj4LCogHFsPSBAkKXgpXvSAyUHY4k829qI7h3XC9GhOLqTQDozUxq0oCUDZdx3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8ixaMzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFB0C2BBFC;
	Fri,  7 Jun 2024 13:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717768372;
	bh=XGVX7AZuoXtC4aHwOBmnRoGcJiF2HZ1EWEecnKPuTHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8ixaMzufss7LKTZZeC7c9zLvHE5YFqtgNWtJ/a3u2PmaUGqb8r9/jgCnVW7mNdT6
	 8+3gyYTYGz3pIMkG2RN9IyDO4Q29wG4f2kys/jXSAJF6B3wRjimZCqSDA0ecCDudCe
	 DI1GF+JzP+TrejWY+2iCuaHXyGiGdH7STvEzdKSo2bjj2e/IJBUe95Q/NXr3gm44y+
	 P4EG1DQjqD+ZN4Td6NAkK4TwWXF3H1oZjERh3z0KOz1oYxgCKI8QNXW9XmSVE8IGKV
	 8sxLryzrveWMoo6yAImOU7N3lKgwi8kKZmDHUuC+LHb3LD06C0NQ1znllOJZdCUkob
	 XOksEcf1JuQ4Q==
Date: Fri, 7 Jun 2024 14:52:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] spi: Add SPI mode bit for MOSI idle state
 configuration
Message-ID: <ZmMQseQUm05ctRWM@finisterre.sirena.org.uk>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
 <21d3314355b43ecd6acc42f9dfedec501418332d.camel@gmail.com>
 <67f94cfb-6a33-4390-8032-a942f5f7b944@sirena.org.uk>
 <ZmIXnBSk7nlviIZ3@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zsC/K195XhebRJpD"
Content-Disposition: inline
In-Reply-To: <ZmIXnBSk7nlviIZ3@debian-BULLSEYE-live-builder-AMD64>
X-Cookie: Your love life will be... interesting.


--zsC/K195XhebRJpD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2024 at 05:10:04PM -0300, Marcelo Schmitt wrote:
> On 06/05, Mark Brown wrote:

> > > Should we assume such a thing? IOW, should this be treated as a warning or a
> > > real error? I would assume this should be a configuration error and return -
> > > EINVAL but...

> > Right, and the error message isn't very clear.

> Yeah, the message is not all that clear. I'll think of something better.
> I'm biased towards having this as a warning because I don't see this as a
> feature of usual SPI protocol but not really sure about either ...

The less usual it is the more likely it is that it won't be supported
and we should actually check that to try to avoid data corruption.

--zsC/K195XhebRJpD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZjELAACgkQJNaLcl1U
h9BmlQf+JUslqI9U0mKHytkvvRL0JDpLxIk4U4QG9t0LRiQCyBhlDYh0HWJPuYpr
ArpMHl9BEFliiK59gU9RiIQ+FOE4MrGBq/oRmYIYmRqFB/h0RseDcx6kr/2LB0CY
jvWxpmAKSyLIR3+xJ6JAlZiL6TXxew2t/Orj3AR/RRkmkQ2ZqM8MckIirrCUZHng
wq1NYg9EVNzn+9EuMwh4z+n7401QdpkvqUrsRcd6NLaMdvSruhxna2bLHwtnxdid
++fT/i6NKtGGtq0mnGW6TAtBqua2Ao9armQrstBqrpYwPu1vCuFzlRDhSgvHIzKK
FxMBVjRAWeecDUBC0+VITFnCoIPLpg==
=TXlA
-----END PGP SIGNATURE-----

--zsC/K195XhebRJpD--

