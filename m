Return-Path: <linux-iio+bounces-53-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA657E9D63
	for <lists+linux-iio@lfdr.de>; Mon, 13 Nov 2023 14:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DCA7B20989
	for <lists+linux-iio@lfdr.de>; Mon, 13 Nov 2023 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3453320325;
	Mon, 13 Nov 2023 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ypq/OJ2N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C611D681;
	Mon, 13 Nov 2023 13:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5484EC433C8;
	Mon, 13 Nov 2023 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699882843;
	bh=Jc38+YeAEJg/asevRi2+sruL/UscKvwPMpD7f7Y2NPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ypq/OJ2NgmtyGNGPhQLsGiJHa2GF8jnANtEewrfvSK/DTNkk4XMK4C2l/hJAlyxHO
	 4wvXgyhm895rsQ0ltmdGiF6FcILsvIVo5hJComrSRSucnIDc/Kot9ghz55JPqMrzj7
	 c1/jHVKiykPbRh3ItIKupqReuDJXLQgL4NibF4cfuuLmnefEIemcNZU2HBmplGFfj0
	 Z9Owpel3Y8BpMpS9ptozFxVX2Ww7hkSUExIkCNR3k+A8oDvVswMv6xu9PQsdO+mLGn
	 i9GXhDNda5wSaxfPDCofBQ0ZBxy7zSicfxJaeMk2K48BHZQ4r14DtENhqj0+XaQkgR
	 FmH9foV80TSHw==
Date: Mon, 13 Nov 2023 13:40:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Ana-Maria Cusco <anamaria.cuscoo@gmail.com>
Cc: Ana-Maria Cusco <ana-maria.cusco@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: hmc425a: add entry for ADRF5740
 Attenuator
Message-ID: <20231113-discourse-sushi-e8fea2450a44@squawk>
References: <20231113102535.51074-1-anamaria.cuscoo@gmail.com>
 <20231113102535.51074-3-anamaria.cuscoo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7/ooBsM+4RJ+q0OO"
Content-Disposition: inline
In-Reply-To: <20231113102535.51074-3-anamaria.cuscoo@gmail.com>


--7/ooBsM+4RJ+q0OO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 12:25:35PM +0200, Ana-Maria Cusco wrote:
> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
>=20
> The ADRF5740 is a silicon, 4-bit digital attenuator with 22 dB
> attenuation control range in 2 dB steps.
>=20
> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--7/ooBsM+4RJ+q0OO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVInVQAKCRB4tDGHoIJi
0nwpAP905npL8Vsvxaa97hvoa2Bw6dbXfLWPhe18s2HXMDZcRQD/WFZEinwMbNON
d/9kuV/v5AgBc19b92HaXWGg2PNxPw8=
=CUl8
-----END PGP SIGNATURE-----

--7/ooBsM+4RJ+q0OO--

