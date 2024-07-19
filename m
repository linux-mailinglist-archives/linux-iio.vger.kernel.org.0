Return-Path: <linux-iio+bounces-7711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AD89379A4
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 17:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A21B20C91
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC51459F8;
	Fri, 19 Jul 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFhE+Oxl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45F313D63B;
	Fri, 19 Jul 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401852; cv=none; b=Cj727+reLIvWMek1LTqPNpwYtz7KHB9Iu7JReQst7KzLJg/BtI7TbOWxZGNjK5e5JvHDt0IELYwtZtfy0IuwzJ9sc3skcyQvDN2CQi1O1BYlLg1pah1mHW3T4AHM6m/azv8Wdn8FEIprbg4Ccx5sh3GuaHUdAM/9n4I5Cpb8DnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401852; c=relaxed/simple;
	bh=mQRDIAq5XGoSCwO48BwclCvMdi/s9aohyNnVkYCka8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2vSOBVsfdpB9daeWRroxPMRF2rAXWaDOpXEfRSnKgMtP5Sx3dnkPnTul1+QWCp79vaf6FY6AH6zifnsRXSPwd2EHRZBqV8he8wihZsQFlk6ZvdPTOx818cqcbhbHZCTTCLqDshxzArty/fRiGi23J9h0p6Aoa98xtTAs4cNKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFhE+Oxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAE2C32782;
	Fri, 19 Jul 2024 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721401852;
	bh=mQRDIAq5XGoSCwO48BwclCvMdi/s9aohyNnVkYCka8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFhE+OxlmgmQ3lPr+DTOfYvoyb9LzuRYka560UgqHi3/n2dcXtE4kBLt6BAbtcghn
	 HiOfKk8DE9AdS0lcj+0Ll2bFoRVwZMj5hD3ZXPzeC2SO6w+TLVdY4Ch+NP9BFB9Pd7
	 h7tExb+2G8PDdL05Aw+CjOWrtyX5jvxTAg2+Um0tyd4T0GO2BpyqTmdTyPqwWcjQxE
	 1RN/zLq2VXaUCmF9SkbiZe+RfcoTY7Lapf6Ykx4MTvFlyJgwZiC+9dpRzFjZBcDtVX
	 pxIYwZB9s03xZO1yNc2u3g0aL87LVdd9DodhU1NRNO3xHr0R6mAFVH8NQcuL7INONO
	 vcWvPo1syU9Ew==
Date: Fri, 19 Jul 2024 16:10:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: humidity: add ENS210 sensor
 family
Message-ID: <20240719-romp-slouching-b28c35965760@spud>
References: <20240719-ens21x-v4-0-6044e48a376a@thegoodpenguin.co.uk>
 <20240719-ens21x-v4-1-6044e48a376a@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ShUNuFC495O2T4Gw"
Content-Disposition: inline
In-Reply-To: <20240719-ens21x-v4-1-6044e48a376a@thegoodpenguin.co.uk>


--ShUNuFC495O2T4Gw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 01:50:53PM +0100, Joshua Felmeden wrote:
> Add device tree documentation for ENS210 family of temperature and
> humidity sensors
>=20
> Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--ShUNuFC495O2T4Gw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpqB+AAKCRB4tDGHoIJi
0mY2AP4lelSzPFN/Jh6n68WOiaDevJ3/DWqRwYkulbWRlIsNygD/RI5FMdDD5FES
xzIsYyMO3YYjNSQBOwl+URDrOme0pg8=
=Vkuj
-----END PGP SIGNATURE-----

--ShUNuFC495O2T4Gw--

