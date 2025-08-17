Return-Path: <linux-iio+bounces-22869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4724B29430
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 18:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F347B192E
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D605D1DED42;
	Sun, 17 Aug 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pfroa3MM"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344CB233D7C
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755448691; cv=none; b=nUURFBmRJoM4gJGk331aEVu+5tcQMDaeW0IQBOCFmM/akTwxvUbrg3C4uiKYpcxNj8DLdvg4qZCVLQ9dsRHvQqay38/DSIU9zwfBaPtU1nJBHJbEQpEbm9YOY9fCIHnNeJzSTxbdUDhMhzJCnUmtaNUcbwJaf7v+7T54eJGR6jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755448691; c=relaxed/simple;
	bh=FrbkZCkhbDKLPC5fLGBBDhpcBP2eiMOMetgbOqzNldk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnZ/iR+YMimySFwCYKqwk+815x8O0YWfpYPbVXpmm3V8K/m8T0m7afTtK7P4NQMIk104LCX8YSOE+M3iZbGCkTpoMNuV9G+E9AT0k3oPlYOUPSGi0REvOZJx9bflfE/UUkHLXCMo+DmRCavYmgOIFlVm/OefgSzH8lZ77PVVovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pfroa3MM; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 17 Aug 2025 12:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755448684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sVf8PnkVxlpSRHQTs3i6dbnOHEqyandzVN3vVorjITw=;
	b=Pfroa3MMT9UHUiYM5f0gHsyMXwI1t7JDactxMUab1DTYgC2ZpU2HN5gYbkKG8iOoYKIxq1
	COx3J4ezDJGZBr21b9WfKit5NlkdIe+KJFDGUHcCSxGv2VEe9ffV4PNPpQSU+trhGhkyF8
	YT6H/r/vqSu+rax+7N/ZBRij97sYdS0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <ben.collins@linux.dev>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Ben Collins <bcollins@watter.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
Message-ID: <2025081711-coral-aardwark-9f061b@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Ben Collins <bcollins@watter.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-2-bcollins@watter.com>
 <20250816105825.35e69652@jic23-huawei>
 <66063382-78c6-4d93-be25-46e972e390f4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ohr2spbq24hdbnd"
Content-Disposition: inline
In-Reply-To: <66063382-78c6-4d93-be25-46e972e390f4@baylibre.com>
X-Migadu-Flow: FLOW_OUT


--7ohr2spbq24hdbnd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
MIME-Version: 1.0

On Sat, Aug 16, 2025 at 01:55:31PM -0500, David Lechner wrote:
> On 8/16/25 4:58 AM, Jonathan Cameron wrote:
> > On Fri, 15 Aug 2025 16:46:03 +0000
> > Ben Collins <bcollins@watter.com> wrote:
> >=20
> >> The mcp9600 driver supports the mcp9601 chip, but complains about not
> >> recognizing the device id on probe. A separate patch...
> >>
> >> 	iio: mcp9600: Recognize chip id for mcp9601
> >>
> >> ...addresses this. This patch updates the dt-bindings for this chip to
> >> reflect the change to allow explicitly setting microchip,mcp9601 as
> >> the expected chip type.
> >>
> >> The mcp9601 also supports features not found on the mcp9600, so this
> >> will also allow the driver to differentiate the support of these
> >> features.
> >=20
> > If it's additional features only then you can still use a fallback
> > compatible.  Intent being that a new DT vs old kernel still 'works'.
> >=20
> > Then for the driver on new kernels we match on the new compatible and
> > support those new features.  Old kernel users get to keep the ID
> > mismatch warning - they can upgrade if they want that to go away ;)
> >=20
> > Krzysztof raised the same point on v2 but I'm not seeing it addressed
> > in that discussion.
>=20
> One could make the argument that these are not entirely fallback
> compatible since bit 4 of the STATUS register has a different
> meaning depending on if the chip is MCP9601/L01/RL01 or not.

There are some nuances to this register between the two, but it can be
used generically as "not in range" for both.

My understanding from the docs is if VSENSE is connected on mcp9601,
then it is explicitly open-circuit detection vs. short-circuit, which
is bit 5.

> Interestingly, the existing bindings include interrupts for
> open circuit and short circuit alert pins. But these pins
> also only exist on MCP9601/L01/RL01. If we decide these aren't
> fallback compatible, then those properties should have the
> proper constraints added as well.

In my v4 patch, I'm going to remove the short/open circuit interrupts
since they are not implemented, yet.

I have VSENSE wired on my board so I can work on those interrupts and
register support in a later patch series.

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--7ohr2spbq24hdbnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmiiBWUACgkQXVpXxyQr
Is8GXBAAlXCMZq+YW/y/fosvogvGw32Bkwv7mSXfX86VV3HAQl7LK/cLC+yOcGtj
TFOk7i25gGulWpGpzeXP4HCxwfa4nR2PH2ND26RgzsnoCa7AzXmtQuvSshHyOOty
UtiCeMVQZYblWXxzSqtev+Aj0MVs4nh953ruI3NY6EQEUFDLf0aodr8LlP5Yr4dE
t9yGoH751gg2Eb0Q7v+EnIcT1ZEOdNV5RM0sBdk+pHNyYWsbEC3AXm2L9I+5+pD4
S+JwamLaGzA9nek7p3Jth7tj8/A8IcxmcaVHwENWEVD/5PGBa8WKyuwJEDsdVfk5
Y7J2+UyMSSCgh6HB+ILhSdWBwfdssUNyv1wQh0FehJKlOaEYQ3stiAJClFXn4tgD
uLvuw24SUi+/igaMsWOVj91pzq4bOQWA/nQ+lm3EeQkqYgw6gpOis1C0Mrp6vDiy
u0SAtmTx0HLK2uzOZI80m3+/cwSBv6kk+MFAbO2NLr1WWPDtfqkth/umbLDxz+VE
I8LbnkS59hzBP1AmPIXXhnxPibJRHBbNJd38zaDOyi2YIYk5mM2tMzeAZJV/uEmu
tNVrZR7HkRKB20mpd/OQu3aDadpeWWFSJMSFiq2e6wkbqJ/EOa7mj4xaNFhWtULV
+bY6U0Sw2Xso8fCaZzvc3X+cZ/lnMVYXn7RIrRP1totiRssVwL0=
=wwCy
-----END PGP SIGNATURE-----

--7ohr2spbq24hdbnd--

