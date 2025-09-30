Return-Path: <linux-iio+bounces-24600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A43BAE5CE
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 20:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE638326505
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 18:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F56261B67;
	Tue, 30 Sep 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IM2dFsas"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165D11CF5C6;
	Tue, 30 Sep 2025 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258402; cv=none; b=IK/69gGELRjJWXwKJf9u729RC2ggBxKLDe1Q4GF49xZEwawDto6w7KSbKC7pP/pPPjoVjCotzsG8mYqKmSksxHYkTZrXNbAX96xCwlRsfivDahP8SZxxPZHC1UEnRM3bsTAWInM66DwUa7Z6NpvOyyO5UtmD3mHct8/SoQYMp/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258402; c=relaxed/simple;
	bh=5IPeu5NAjLS5d1iW+Pw0qmaV7aUal6E2N1oVnFoqGU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba95Y/F28qv9v2lh1KEU1C+evmx44njA7R51wbEylQNp03hh9ffK25F6moUH7na+xGFBzCctpjq7zvbsM7gvLJweEEsNYuJaknMPz8dlL5ExPBfCgqiOdlhmupOYYvzGTZFWHWtQ0DzBDAk4cXP112LM37lZbflM82NgFAHETJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM2dFsas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E7BC4CEF0;
	Tue, 30 Sep 2025 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759258401;
	bh=5IPeu5NAjLS5d1iW+Pw0qmaV7aUal6E2N1oVnFoqGU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IM2dFsasM5JHuzuDChjzqCos4pWi+hvdWVfBuCk9CZJXpp3yKmGbedq65nIHOda+j
	 /OqEUbrZgJqMPoBctNQ9rkQ+dY+klePMM6+3kYISZHdz+oRDLah6rX1fATCGqrEeOC
	 nh2NLB1FmsxXqx+qJQNx7vRFhAGT/4QjIL7Z5pBW+m5190ewvSURks7JhuhM7dos60
	 yyTCNE0pyXm9YVZMLRi5hgQKERO+Ja5/Vt3CuRDlldAaN+TLsslpgRKXs5agsFiv2j
	 E9UwEtXOQz99uCkp9v0FVBhFpjqBCVUt3IBwqG//3j9MndyeJ/+0sg7oq5FiKK/LKG
	 wqslRiPk/FAvA==
Date: Tue, 30 Sep 2025 19:53:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/6] dt-bindings: iio: adc: adi,ad4080: add support
 for AD4081
Message-ID: <20250930-treble-depict-4e1d0be89575@spud>
References: <20250930103229.28696-1-antoniu.miclaus@analog.com>
 <20250930103229.28696-5-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eud+2P2pyEfv5Z8l"
Content-Disposition: inline
In-Reply-To: <20250930103229.28696-5-antoniu.miclaus@analog.com>


--eud+2P2pyEfv5Z8l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--eud+2P2pyEfv5Z8l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNwnHQAKCRB4tDGHoIJi
0nWdAP4pEAySAM+LAqXT8t5sZ+BAHEU3SBe6IgIn7Ha/shupcgD+P0aiyeEC12+G
5D+6eWZLvPALvb20tfSYcet7guyOVQo=
=8RSX
-----END PGP SIGNATURE-----

--eud+2P2pyEfv5Z8l--

