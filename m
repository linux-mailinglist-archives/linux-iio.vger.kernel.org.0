Return-Path: <linux-iio+bounces-828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9ED80D52E
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 19:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1901C21408
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A4051019;
	Mon, 11 Dec 2023 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1Zd+Oo6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875684E1D2;
	Mon, 11 Dec 2023 18:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD3CC433CA;
	Mon, 11 Dec 2023 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702318877;
	bh=yx7x9HZRw2fNrttJxMedeCqy6X82RJq3KdEf+5K1eTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1Zd+Oo6uaDJ/62he6wzYZJ1pWsfJV3i7CeKrJIC0TwLvyk3HX41TUyhrpOeOjoIa
	 7q9KZzHZQCxSkG2FEduM0F0iZA7B3eOKMaodUDUyKOHPvvMIs6mTSggVJKRNfaqLgo
	 /DPTGulIAvJhyzdFLh0WMMSmciI6KQJo72yYXQ+IWy3jStBBr3N3KxLxaNQbtOPzkc
	 8jd666vX+7C6Ulsv/NmzZ4YQK/5kyQ/HmdOFLCpgsQW4dOUEQ7JP+RhyFOZKVldeyV
	 zK1p+NMbo8gjvSke9/3HcEd5Rvz814uLTN20WaagehllWPQY/xMAJJ6HD79Zdsk4kR
	 VI0DHtRWyxmnA==
Date: Mon, 11 Dec 2023 18:21:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Li peiyu <579lpy@gmail.com>
Cc: jic23@kernel.org, javier.carrasco.cruz@gmail.com, lars@metafoo.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] dt-bindings: iio: humidity: Add TI HDC302x support
Message-ID: <20231211-tackiness-imprecise-685882c9c318@spud>
References: <20231211122201.9598-1-579lpy@gmail.com>
 <20231211123101.9868-1-579lpy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XvxZv93uMWHkmLEq"
Content-Disposition: inline
In-Reply-To: <20231211123101.9868-1-579lpy@gmail.com>


--XvxZv93uMWHkmLEq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 08:31:01PM +0800, Li peiyu wrote:
> Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
> temperature sensors.
>=20
> Signed-off-by: Li peiyu <579lpy@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--XvxZv93uMWHkmLEq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXdTGAAKCRB4tDGHoIJi
0mybAP4/anKKpEIWu6vRV5nw3jDFZuvaVLsMfF3wPGeStQQbsQEA7/JiBzEV3Z/N
ZVjWE55zSqdEbI6XQms9Hq4XvLovDwg=
=RvtZ
-----END PGP SIGNATURE-----

--XvxZv93uMWHkmLEq--

