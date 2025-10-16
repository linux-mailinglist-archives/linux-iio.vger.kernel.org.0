Return-Path: <linux-iio+bounces-25155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0C4BE4980
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 18:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34E319C626C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873DD2E2DF4;
	Thu, 16 Oct 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/wkxKkU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E531C84BD;
	Thu, 16 Oct 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632221; cv=none; b=ItLWCuSfTF5rTRjiTrzzt+5v5TY0GgClSiEeV6EJ4284RmcoSmUOluZEVTgsw9EyfSRD1NHW3ohVeYgJQkPCH1w7fcqGgD8bEpyxft8wQ+AX/67WSPXeSHwGtiaH4gDzDuSedcpw6y/a8F05V23gfmn941bhEIjGQ1q5/fQ03Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632221; c=relaxed/simple;
	bh=YKtLs7wArV8n7grH3r+8Jd1kc9FR4e1git/N+2ppZ+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJva0oVN7rkGxsiLaASJhe16ilETwDR54tKQnwOrlY06552ybVRFWGMhAqfXJKhM79eZa4ISwIKylAIM24Q/omfGeO4DbeiWKVplblo05/I63a4ygB+Vp7Yav+BCo3VHHQhF2dEPvC3ZiJounygZxn3MKY//+6Bz+G90x3K0JbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/wkxKkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44C1C4CEF1;
	Thu, 16 Oct 2025 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760632220;
	bh=YKtLs7wArV8n7grH3r+8Jd1kc9FR4e1git/N+2ppZ+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/wkxKkU53aVNN9apdM/GmA1zdPx+XlXhvAs85/0LPXtRYfJjHMyxjxqOhr4+mMD9
	 u3KhGThR1burzcgnZYKyVt1fmy+WvYbD4Js+OeBZ7BYU4n8ZxkVMESFASbC+8Di5zp
	 DjIP4X2kbYaS07an4UUzjfDCI0wOChfpFoFOOEiav2DnOZbC0Z6h1yc5QjRFo00JUZ
	 cly/WCaTQUMxK+Z9s/PkxPel3fSk8GueBYJtt/oZa2Nm0DK8y0JEfis0XDrfvO9ybQ
	 6APXOgc2HqiPJWFC/7wnyHBJtHnf82PfmzSmbHvP5CaQhKAewInpRpNsHviwlzxJ8F
	 u6sstdc02I/eg==
Date: Thu, 16 Oct 2025 17:30:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5 6/7] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <20251016-online-proud-d32e8474a94b@spud>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
 <8ef42b4689c37a71cf320c086cfdc01a8c146282.1760479760.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A4mJbX8u/Y55oKoB"
Content-Disposition: inline
In-Reply-To: <8ef42b4689c37a71cf320c086cfdc01a8c146282.1760479760.git.marcelo.schmitt@analog.com>


--A4mJbX8u/Y55oKoB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 07:22:35PM -0300, Marcelo Schmitt wrote:
> ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have=
 a
> PGA (programmable gain amplifier) that scales the input signal prior to it
> reaching the ADC inputs. The PGA is controlled through a couple of pins (=
A0
> and A1) that set one of four possible signal gain configurations.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v4 -> v5
> - Dropped leftover adi,pga-value.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--A4mJbX8u/Y55oKoB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPEdlwAKCRB4tDGHoIJi
0pD1AQCDtHVsMXDRiIBBZGmvp5HobJYwVI8queBDi0UNWCZxTAD/X1hSDGwynD4c
AhKsHnIHt5KDcGeB1aSGVF0Gs8JZ9Ak=
=l4y6
-----END PGP SIGNATURE-----

--A4mJbX8u/Y55oKoB--

