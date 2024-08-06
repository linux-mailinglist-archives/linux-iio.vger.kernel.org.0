Return-Path: <linux-iio+bounces-8282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B726694951E
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84BE1C20BA5
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A783B770E8;
	Tue,  6 Aug 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWMb8Din"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF3039855;
	Tue,  6 Aug 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960049; cv=none; b=Xask1lQm2JUno7Ku/dxJIxu3b8njdY0u8oLswESqf7oZbicIGnnKQhII/sKyBckLJNQSzO0DrTpZl6wYnKQU3yTs3PBVNRfyIrrOrmdTLq8Vllyzd5Ka2ZjEVH2+Jy67qflaPC0i543FY9n10CM9xU0uW/ElZbDzPRdYph3ASM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960049; c=relaxed/simple;
	bh=dgWnsxsAvivSg1NsaUmrzHE9OVk8NSPXI08WSrXTbFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHfxIKErfk+dsYO2X/JVt0tcIKFWUarfsNHV/EcNBQYbAkTBBPXNsUoHAMvHSbjkdlw1e3+wZegy0BJZnx+o355up9ZTff5fkZUDUR30W+cj5V3K95ztILlV3+Uwb71opXjUiTjRCWaW7RbFC0ENZpFqoddqXQ9RNjTO4p+NzGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWMb8Din; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8947BC32786;
	Tue,  6 Aug 2024 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960049;
	bh=dgWnsxsAvivSg1NsaUmrzHE9OVk8NSPXI08WSrXTbFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWMb8DinnsQDbExSXI48mqLZXdQfdEcahKloBdwJNTneK5rXsJPuherek4DNYhnQc
	 nMuc+iI6iLE7WXm+KdHNQhklUwK/t36LzCVZrQC4RXPbxB+1gazxyAJCNV3titjVFI
	 hKJ2JMkWMcrxKqK6gBrldhaI/z2x21prMAyYNFxF3+bqmPklGCbZv18l0MvIdM7jT9
	 ho1bEKE2Td2MpRJ+ef2RIwybb1Syg+enLl97MB6eZFsFHxPRKbwHorGNg6YNrvWg8C
	 OBqud50XwNj7nyU4q5hhOqi5rldeUvkjt/O42SJ/M/Td7Fhag0dMnc0d0QC724QenI
	 TO6A9cfCgqyIw==
Date: Tue, 6 Aug 2024 17:00:44 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Albrieux <jonathan.albrieux@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@mainlining.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: imu: magnetometer: Add ak09118
Message-ID: <20240806-paycheck-visibly-4e114692ae98@spud>
References: <20240806-ak09918-v2-0-c300da66c198@mainlining.org>
 <20240806-ak09918-v2-2-c300da66c198@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3TllyQc2YYniCF7R"
Content-Disposition: inline
In-Reply-To: <20240806-ak09918-v2-2-c300da66c198@mainlining.org>


--3TllyQc2YYniCF7R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 08:10:19AM +0200, Barnab=E1s Cz=E9m=E1n wrote:
> From: Danila Tikhonov <danila@jiaxyga.com>
>=20
> Document asahi-kasei,ak09918 compatible.

Please explain what makes this device incompatible with those already in
the binding and why a fallback is not suitable.

Thanks,
Conor.

>=20
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Signed-off-by: Barnab=E1s Cz=E9m=E1n <barnabas.czeman@mainlining.org>
> ---
>  .../devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml        =
 | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kas=
ei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-k=
asei,ak8975.yaml
> index 9790f75fc669..583cdd2fad7e 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak89=
75.yaml
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak89=
75.yaml
> @@ -18,6 +18,7 @@ properties:
>            - asahi-kasei,ak09911
>            - asahi-kasei,ak09912
>            - asahi-kasei,ak09916
> +          - asahi-kasei,ak09918
>        - enum:
>            - ak8975
>            - ak8963
>=20
> --=20
> 2.46.0
>=20

--3TllyQc2YYniCF7R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrJIrAAKCRB4tDGHoIJi
0uydAQDG0c2y7H6w4zozEzZ9VYi7IQyZI7ZDFm2zmKjet3UbjwEAkDB2RHT1yKvq
QktGCWzF0cmqhwU+BMbBEe9J7IzyGAE=
=BSEH
-----END PGP SIGNATURE-----

--3TllyQc2YYniCF7R--

