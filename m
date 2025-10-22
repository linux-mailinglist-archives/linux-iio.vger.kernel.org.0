Return-Path: <linux-iio+bounces-25359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF666BFDBD6
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 19:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2534189DA9F
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FE92D0C60;
	Wed, 22 Oct 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU34Oeue"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D082C236D;
	Wed, 22 Oct 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155865; cv=none; b=LG7w9YJV/qkuU49EU78nrnDAzl2UuSUNDxtpH6vMffTC4bpnHKmUmmes/hkntF531QVew96lvoRdNF6vDaASKqSllVYrWolgHElMlmkmr+20ydkGNbK5ErdWvZM1DDi2YuorOJnTdOfgFa8VvEn9AJb+XmlLBFOL6DwYz9y0FUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155865; c=relaxed/simple;
	bh=F5VveIwlzMg64g1uO8p0shQBvCA74sGldZVW3WldWOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1vWMbCzCpB0W+Bu4Da/VXuSjuPP6lgI7hjG8V+2rcYJe1HC2Flhp9mU3eGMFX0gibkuycz8npUCktg+yOasJGEAEltgWsIkOwr0Pq7Z9yfckluQ29QGsOMyyFXGBMkgFD8yTDq1YpX8rJ7luQDvIBpGZVzM7pr3cd/BLeGyzNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU34Oeue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4B7C4CEE7;
	Wed, 22 Oct 2025 17:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761155865;
	bh=F5VveIwlzMg64g1uO8p0shQBvCA74sGldZVW3WldWOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AU34OeuegcF7JRDM1HVti6EdJx6RvHtDJUWXpbJfrbW8FbyS3TnABPYKfYjd8wKD5
	 25oZY7mdnYmupTB82ID0/lkxeEi9q35fsxT7lDi9A//gJH208Z0AxQNa2dCjK3vBhE
	 0t7Hi7QOL9hw0c2gRrkKffHPTuX8qzPeKU4hYveqFSDu8jWCQ4I3FMpjNKpYn73CCJ
	 eBwoj3EKXmzcV2DG6d0kmIO0Hp2cdtTSymbT/07mgroBKFEY/MrWb1p6Mv7E5wKhm1
	 VTXT9P4rFQPINnC1YVxlWCoI+JtERSRwJofC8wRDlbMfRC85qFwVAHLYG7cDlpji7Y
	 ev4H5EJEeokXg==
Date: Wed, 22 Oct 2025 18:57:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: Add rockchip,rk3506-saradc variant
Message-ID: <20251022-grandma-maybe-2a1cef529cf8@spud>
References: <20251021223107.193453-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BvzJ9qHNkAmrHkqA"
Content-Disposition: inline
In-Reply-To: <20251021223107.193453-1-heiko@sntech.de>


--BvzJ9qHNkAmrHkqA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:31:07AM +0200, Heiko Stuebner wrote:
> The SARADC of the RK3506 is similar to the one found in the RK3528
> in terms of number of channels and the other implementation details.
>=20
> So add a variant compatible for it, that reflects this fact.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--BvzJ9qHNkAmrHkqA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkbFAAKCRB4tDGHoIJi
0kekAP46hDQAdkFN8x5rulWTl5bTH/twS3iTeXKtAKTtGqZMJAEAu0z8J53LF80z
LKPxNtL+/g+fxHm+dSHoTi/1UtGPqgI=
=ofxG
-----END PGP SIGNATURE-----

--BvzJ9qHNkAmrHkqA--

