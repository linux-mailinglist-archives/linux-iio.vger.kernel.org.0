Return-Path: <linux-iio+bounces-24301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF12AB8AC7E
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 19:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74673565736
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC17321F22;
	Fri, 19 Sep 2025 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnxVdSYu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E326230F547;
	Fri, 19 Sep 2025 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303270; cv=none; b=lu4nUsO00Ul/k7gbp94LIWBJ+A+mXXJRCSGSIlCivjqhEmg6Fen6ZHKqJkMOepR9IR8uh5bwf/jqMgOBvR9iwZZ0W3SOMqOJvTsAYoTDBHEUCjIQYPV6CGNjgHU9IEvnwOQvcUaKV5H1go6OP3TeKacTPU0QmF3GWrcPOKe3g9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303270; c=relaxed/simple;
	bh=fN9queybDi9gsPaFb5uyWlxGyuitcIAS6CLq/g52SC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0bB3v6ig1al9tQ+03XPled87FnBY8+WBSVToB3vx8ylWnJMWsacO+7k40l7Xutou139VuRVWcJXufkcwivtaJUJFdKaPxUIfeTS1/dgRbr0ioec4AHPkcl6L43T2Twez1vghdmCZjpMTWINFRVBnkgYRtkeVDfCnXnJtvfbHmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnxVdSYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49438C4CEF0;
	Fri, 19 Sep 2025 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758303269;
	bh=fN9queybDi9gsPaFb5uyWlxGyuitcIAS6CLq/g52SC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnxVdSYufnVbPg3KbdZrCWemscksMEpCs1HWusGUwtQhhamC1Ma4NSJU04lqnRbmG
	 nn0l5e6wZeLcVmgtCnI4p51e/8lm+QtmzClWwPZs/YMRX5HDUoFz1ozeg3Memb/WyE
	 q+Z7UsxOfrHi+Hdk4386jDNZiNOekH9gyqIphn+UrOCKXY5ciCy1PM6cpQxKkVlgKX
	 nlAMCXwtJmos2Qpegs/U+itW3VT5ylpR4nBR3ABjxEj7cYwJFvLJr9wUEmwtn8cTFQ
	 1+JC35XX8PuRisWPIEAheZk3A6cTj4MDkGeh1IuFQWKZR5j1HtSG+sT2h1wg2JDquX
	 W3j+WVuJEHf/g==
Date: Fri, 19 Sep 2025 18:34:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 4/8] dt-bindings: iio: adc: adi,ad4030: Add PWM
Message-ID: <20250919-divisible-unfrosted-4cd634fe8baa@spud>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <7a1a68a33769c69967bcffbbf7a0bdfec69516ed.1758214628.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s+xqzWcbWXtyN4FX"
Content-Disposition: inline
In-Reply-To: <7a1a68a33769c69967bcffbbf7a0bdfec69516ed.1758214628.git.marcelo.schmitt@analog.com>


--s+xqzWcbWXtyN4FX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--s+xqzWcbWXtyN4FX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaM2UIAAKCRB4tDGHoIJi
0jnmAQDKvLsrYKE36cqvvwXq7+jeFCFtELh7aPMe5WcZ+A73GQD9HA92cZeh5WYh
u2TTgFZwYNSaELmg6o6tERlP65gwxwo=
=E/mD
-----END PGP SIGNATURE-----

--s+xqzWcbWXtyN4FX--

