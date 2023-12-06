Return-Path: <linux-iio+bounces-665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BFF807314
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 15:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23782281FEC
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 14:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAD53EA73;
	Wed,  6 Dec 2023 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m87zyRsO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46F37144;
	Wed,  6 Dec 2023 14:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02380C433C7;
	Wed,  6 Dec 2023 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701874414;
	bh=BfmDvJ8RDuCVQ+mXdoNuZyTFuN44YPuJHi24jXGbAHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m87zyRsOCTOxBF+aKu/NHagCRxmyDv+Asnc8Pkf2E+AAD7YXbZYTb2GGZMvLfzeWX
	 VZ5pkGgYk3j0VYIYveNb3P31U1FAy8X5FqnWZq6yfWW9DlHik457j/oyJf7KHYvh8s
	 ELfU7SepC17kVpuBOPHGjq5K9C3XqOj161s2rCi8dv106SlsrOPR+zELd1+0pCGXJF
	 VpVYP9hqoBCjvmv50D11jVZDv9XuPt2gfBQaYpO4OBASeSaSHXhtwvQOyMuyUtjfSi
	 dJCG6dePOCByyQogNNPzTyfwW5PCWgb9TqfiFFsCroboK7yan46DXg/4R5ojFmsc09
	 LZOgRB4roLxqA==
Date: Wed, 6 Dec 2023 14:53:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Li peiyu <579lpy@gmail.com>
Cc: jic23@kernel.org, javier.carrasco.cruz@gmail.com, lars@metafoo.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: humidity: Add TI HDC302x support
Message-ID: <20231206-quarrel-dill-27b94d881ec0@spud>
References: <20231206134655.559474-1-579lpy@gmail.com>
 <20231206135148.559564-1-579lpy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QXd7A5Rf7VK5v4Il"
Content-Disposition: inline
In-Reply-To: <20231206135148.559564-1-579lpy@gmail.com>


--QXd7A5Rf7VK5v4Il
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 09:51:48PM +0800, Li peiyu wrote:
> Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
> temperature sensors.
>=20
> Signed-off-by: Li peiyu <579lpy@gmail.com>

If there is a resubmission, please prepend "dt-bindings: " to your
commit $subject. Otherwise, I am only with this.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--QXd7A5Rf7VK5v4Il
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXCK6QAKCRB4tDGHoIJi
0qgdAQC2K/aw8tdHJ+rVh82hTYCgzPkrJT1gzpW/7/zq0F+giAD/U2P64GnkIVeo
Opn8r6Hjo4FpMoZKTGwUaQQMKQJ/0g4=
=+UPl
-----END PGP SIGNATURE-----

--QXd7A5Rf7VK5v4Il--

