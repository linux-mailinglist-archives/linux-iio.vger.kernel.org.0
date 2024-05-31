Return-Path: <linux-iio+bounces-5536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DA18D621E
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 14:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797D21C24AB3
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0C715884D;
	Fri, 31 May 2024 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCP49Rj0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17CB158845;
	Fri, 31 May 2024 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159672; cv=none; b=LDPEj52QYYNjvzkM32m7yTELYTitH6W92jshFmAW/LeFUXrv0RwXu40vzGQ5GAS2yiAa+ydKaG6e69bgSG+3sQyAFxJ6cRIYDbonlczL6ccIRoXWXmNVJRoY7ZOnxmmP7tvFwld+z9xt/cWwlrusrhATKMTQW8Y6jxiUeS3CZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159672; c=relaxed/simple;
	bh=smSrXrIOTm6C2xaV0U6WGYhPw32W+7RUuflt9biyoW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAyJb8FObFH2zWCS891+yXG6rCR7PGnVU0lYrpCGUOPkh/5abwRde8wZwJSK4UXjDhPE0Av1bZKIsrNV+OigH1R5vrA9o6P/OSqwvPkIlyRVPhJqMGb16BTfGTdluScE0RW7pZdkIu7Bqtp5Mm4JAnjpjSCuKdhQ3xoTuo0/XMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCP49Rj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1049FC116B1;
	Fri, 31 May 2024 12:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717159671;
	bh=smSrXrIOTm6C2xaV0U6WGYhPw32W+7RUuflt9biyoW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCP49Rj0r+TuWcuwoHGGzkDSNzXDVNc/dJV8Sx5k4Bm5GZpaLTQY5MMwNZvGhj1z+
	 IyYsnkVCQEhdjFii5os6pzgxLHTGxHtovHpTi0DcQxAFONPrifEEzHE11/D5g0gcMY
	 a2tRXfrCiANlRVbN8bplYNwvSial+L8ElTpVqRDnq6QxeU8CvJLTmoGtXEngyYUjKx
	 qOAbqaNBfKrndprPlFuP6idtDenJieFqu9EnbGwvTfd7Y+qU6Q542IISqHlvfdkKCz
	 g9cBE4GgIOqQOVeTUy8TSFiyero6CbN8APOUYCbwC3UdSl0/lptUdYiRK/tPAwPpgH
	 hiZGtvggKBxZQ==
Date: Fri, 31 May 2024 13:47:45 +0100
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Conor Dooley <conor@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
Message-ID: <f67fadb2-03de-4f82-ae32-5e1c64fac027@sirena.org.uk>
References: <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
 <20240526-peculiar-panama-badda4f02336@spud>
 <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>
 <20240530-petunia-genre-2731493dbd0f@spud>
 <8ba46ea7-ad57-4ade-9a77-fc605710c14f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J1Zz5On/pzKE0RsE"
Content-Disposition: inline
In-Reply-To: <8ba46ea7-ad57-4ade-9a77-fc605710c14f@baylibre.com>
X-Cookie: Serving suggestion.


--J1Zz5On/pzKE0RsE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 04:28:38PM -0500, David Lechner wrote:

> I think one of my colleagues was working on one in the last year that we
> might still have lying around. But I don't know what we could use as the
> SPI controller that would have offload support.=20

David was using a Raspberry Pi, their DMA controller can happily write
to the SPI controller registers so functions as an offload engine - I'd
not be surprised if other SPI controllers and DMA controllers could
interact in a similar fashion for the CAN or interrupt controller style
use cases.

--J1Zz5On/pzKE0RsE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZZxvAACgkQJNaLcl1U
h9CAKgf9H9TgXJuGOIkZbFW3xhxadrFbeV8HASnWFZFRY12SLKHWJhu+HqypwaLl
Ym6TSGQtsS3BpjB8IA9cs+SPl2HT4n0Z+h/aI4SX6oDa0CJ9Fk8BvC6SO+TSffel
gb5N1FUPWdxMxUr+sFfa9OwPFFnHl7OobLYyw2BVC4A6oBFqxan5JbgALLXblnyT
O+ojrcgqXgkAGMNxgFeym4FetZiI1IsSsmUbl4CcSP3dXQxb+jKp6V3v0dXHUWUx
rNLpTYOwnpLrnB7csT3H0hr7ycqsuGIzrSdmy+Ag608uosK94/kXP+KOaQMG3/IY
JlwEC0Fp+n84ef5Qm+kwNwbOUda62w==
=YIXU
-----END PGP SIGNATURE-----

--J1Zz5On/pzKE0RsE--

