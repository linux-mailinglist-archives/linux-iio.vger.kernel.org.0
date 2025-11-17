Return-Path: <linux-iio+bounces-26271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D244DC65F44
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 20:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E17F4EA748
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8BE2F549A;
	Mon, 17 Nov 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaR42cll"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD832C317;
	Mon, 17 Nov 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407341; cv=none; b=kgJFHYoUJCNd6i5WitDqJYwUxcICEolpVXnDquxZHiwn9M+bE1iM8Xvc4HVhS6F0cHQmVdTFPIE1PUb7wQqzWQGckm+LfqFVhVbvwBQGqyXsQRXYYJo0b6+qJKNhnZjizBGjkeJ/PCFYjmXti1leo+/+bVN1vfwe11LsRDj4iNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407341; c=relaxed/simple;
	bh=9HqFXiRP3LG9cL6kLxNt57dTXOY3ssXBzOj05wrby6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BScNUvjnJWAesqgPixIpcxjFc2yTsG3HadT5gMHi4uYDDAv2MxXeGtPKQ+FGzvxli3SzFaH1b4SuX9j4skGfuVpsOdkEMb2geaB/6PgahQJpV+B+6BsaAYclSWrwZOiIv7uyJCRCRHwJg2zW0eg+6Jz3QFPPmiiLDxmI+TiPZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaR42cll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCD9C2BCB2;
	Mon, 17 Nov 2025 19:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763407340;
	bh=9HqFXiRP3LG9cL6kLxNt57dTXOY3ssXBzOj05wrby6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MaR42cll4DR4CNYVRUjpPCCqaoH1e1SmEESrpHhBW4cppupCCeSBMriAgDQHXasih
	 haMt8PuBTWJQnPjvF7GypRV71LRgCw/bktqEbdeGkOEJIJYBv+/hqZmQ5uJaEvuKXh
	 RWUPXuyUDuiL8n0c9r/WvVsRm5BvAR0ZP37ND33bE04iyFDO4+MZIdtyoyKKYaTrTY
	 UALwq4bza01SpY6GEbruAjACcdFqFHzgcUEDAqKpwObUGfzlzhsP6QrZe8XP0sPfI2
	 v4FV86842uC9TUDJ6++4gIH9XQvu4kumNEFtkVgCUopSM0Lz795L4SVvtyw7pw9PKD
	 GZBRiVSdeceYQ==
Date: Mon, 17 Nov 2025 19:22:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: amplifiers: add adl8113
Message-ID: <20251117-upstart-sushi-c9d69186abc7@spud>
References: <20251114115725.5660-1-antoniu.miclaus@analog.com>
 <20251114115725.5660-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a2GufTgF+z+yJtM/"
Content-Disposition: inline
In-Reply-To: <20251114115725.5660-2-antoniu.miclaus@analog.com>


--a2GufTgF+z+yJtM/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:57:23AM +0000, Antoniu Miclaus wrote:
> Add devicetree bindings for adl8113.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>=20
> Changes in v3:
> - Remove extra blank line from YAML file for cleaner formatting

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--a2GufTgF+z+yJtM/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRt15wAKCRB4tDGHoIJi
0lm7AQDsX7KvaA2LnS2dsNr8gBaudl0eOfBrz9+M73GYf2hCHwEAtBb+OT8AWXC6
zlCqQ9nt1P8LXHNNkt8AgbUnChahmA4=
=+9uD
-----END PGP SIGNATURE-----

--a2GufTgF+z+yJtM/--

