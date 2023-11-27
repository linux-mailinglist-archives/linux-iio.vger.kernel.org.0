Return-Path: <linux-iio+bounces-443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA9F7FA85F
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 18:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7266A1C20B61
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60B63BB27;
	Mon, 27 Nov 2023 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZZVBa3K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61164746B;
	Mon, 27 Nov 2023 17:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4F8C433C8;
	Mon, 27 Nov 2023 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701107605;
	bh=26PQ6jwX8FLz7MO9L5/L1UazsxLIswdEKnXCxM6fe80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZZVBa3KmUF2kSm/KXK2TZY4BUdbTl6S2ncN6qpvtnIJUJLTnzGyazp1L1tTbPHDA
	 A49ResrHvhD0BiDD5E4ULWcOWzO6VvMolRZly6IVlfSnYVUTuP0I2HTcXL8yqGuIsv
	 kg3VvzIvUbs6/YJQoYyqaTWUSS71nD0+mVi5mujYvlLdmSU0Nk4YD1Qjm9sZqR2+/0
	 UFTg0nYyTxeQfOGgPd93/BGfpXXiPK+r5qLH+SDYe6zgJsZ8KpRquqjxQCzmtaIcjR
	 cTswsWpjTusPC1Ua8dTMn3l+EVLDk0B/YqtxaDXwz1Jfk2IEN1+qGZCa/WqzxoOZR0
	 u1UGCDj4F/T2A==
Date: Mon, 27 Nov 2023 17:53:21 +0000
From: Conor Dooley <conor@kernel.org>
To: 579lpy@gmail.com
Cc: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: humidity: Add TI HDC302x support
Message-ID: <20231127-jab-retying-f89d4790034a@spud>
References: <20231125102221.2795-1-579lpy@gmail.com>
 <20231125102749.2876-1-579lpy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O599d3nNZVKMXShY"
Content-Disposition: inline
In-Reply-To: <20231125102749.2876-1-579lpy@gmail.com>


--O599d3nNZVKMXShY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 06:27:49PM +0800, 579lpy@gmail.com wrote:
> From: Li peiyu <579lpy@gmail.com>
>=20
> Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
> temperature sensors.
>=20
> Signed-off-by: Li peiyu <579lpy@gmail.com>

With Jonathans comments applied:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--O599d3nNZVKMXShY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWTXkQAKCRB4tDGHoIJi
0iDrAP4z9bAGYCtegBn2EG1sz1c4yMq3QvltCyPaq4ivhgWmAgEAqsM5Ks8AzcH+
kIQl/jwM8oihxnW/Jc5jW074404KagI=
=yzqp
-----END PGP SIGNATURE-----

--O599d3nNZVKMXShY--

