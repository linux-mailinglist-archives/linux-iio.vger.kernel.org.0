Return-Path: <linux-iio+bounces-22900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D5B299FF
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01E61888312
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 06:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4E42701D2;
	Mon, 18 Aug 2025 06:46:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A944D19D8A8
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499573; cv=none; b=VmrPOhWsr8QG13mMNRgSi8uZIY3Aqyr1jFF1H5nLIndeIgGHvEppSc4xmT+GX6avjvAa6HiUONz3DhSM7uybBiKRV70gOVBs5ktP1r2xUzhSE5HnPVZ1AkLDgGwSrjHazV0Xfs/NQZnxoPxFhrzIVlZNCoXDkSfivtCQRp/EdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499573; c=relaxed/simple;
	bh=h/6c7Gz4xEzFlrmMg0LHnC6xxRCSwZVPe0AbEFhJ2y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wtjho+JQQhaX/rIq0CHZ0VNAacSXtJiNrO5K85LMR+qHwWi0I0F8jhMRj3Q1ZpygEAw7Nh3vn8IJ3oJK5ysLFqqIv4xgj+/zuTw5ylIevFSyOXpmZsp4QdDD0eeOT0E4Css0c/F9EP0YZ4Y9kSzKpQhHr/CZO6OkBqR4ouPtU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Aug 2025 02:46:05 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Hepp <andrew.hepp@ahepp.dev>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: iio: mcp9600: Add microchip,mcp9601
 and add constraints
Message-ID: <2025081802-busy-chital-df0ef6@boujee-and-buff>
Mail-Followup-To: "Rob Herring (Arm)" <robh@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
References: <20250818035953.35216-1-bcollins@kernel.org>
 <20250818035953.35216-2-bcollins@kernel.org>
 <175549878302.4073296.5081888197780869494.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p6cczt6sxnnsh3tz"
Content-Disposition: inline
In-Reply-To: <175549878302.4073296.5081888197780869494.robh@kernel.org>
X-Migadu-Flow: FLOW_OUT


--p6cczt6sxnnsh3tz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/5] dt-bindings: iio: mcp9600: Add microchip,mcp9601
 and add constraints
MIME-Version: 1.0

On Mon, Aug 18, 2025 at 01:33:03AM -0500, Rob Herring (Arm) wrote:
>=20
> On Sun, 17 Aug 2025 23:59:49 -0400, Ben Collins wrote:
> > From: Ben Collins <bcollins@watter.com>
> >=20
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/iio/temperature/microchip,mcp960=
0.example.dts:34.34-35 syntax error
> FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/binding=
s/iio/temperature/microchip,mcp9600.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1527: dt_bin=
ding_check] Error 2
> make: *** [Makefile:248: __sub-make] Error 2

Thanks. Found this already and fix will be in v6.

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--p6cczt6sxnnsh3tz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmiizC0ACgkQXVpXxyQr
Is+HFA//a1oHbWeGRhfcz5KGFd+Fp3ZqKHDbt1UFszFghFAn+3/df/UD38dhskF2
SeWrvIbNNWSz/hmOyjOZPsx+nmQGi3o3rgeLf/S/p9aVkCBYFKdxibAUdL+P93wZ
2Xcyf/ro/cI5AiCBZqDYrJciSzsJv8Nj1WbHiYud1Q7MJMNVtfcAtt6BSE+9pLVM
mYMw/M1/1VGa+XZ04YNOyvC4G4ydbSA5Hkwjeb0u9k9FOE8wI1Rz6+S/OpCL0Ibl
b1cQYwfGbkvtYZOj1TB2IE7qchi72hZ/DQLDH21ZdQ7uDjRzYJRYe6pNI0oOlQbP
vXK1y9G84oAeCLVxWzFG3wsmXVxM7SrvbiNVHSwqcOM7Cv09QT2qokzJlSLrEUcO
pR7NNHDux0xwco+3Ahvp63jjNAgbQhTa3py95nnXU2Xr3H1E3dKmfz7ClGReHIkq
tyTT/GE7T3EoFW2fAy1qoNqUWlmGn/nJ3XIxmc4nDfcQG/bqUDA4TjgASbOHYPRa
otZtrqhbqOXkMkksGLEcjGU1vTpMxpXmCc/z1jxhMjAA6NAVy1XF1jRIj/LIKwXU
uQqnWy+6edVunI64RIQVuRVosZlhVDo7dyFg/cxZmu8Kx4p8AnmIDO19s+G9T04d
MoOtVxC/mqAJIHMuvJeWVeHgCdq7OQOq7ypsMst+X2qA8nowXbk=
=YbUe
-----END PGP SIGNATURE-----

--p6cczt6sxnnsh3tz--

