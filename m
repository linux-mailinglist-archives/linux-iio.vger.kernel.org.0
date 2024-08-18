Return-Path: <linux-iio+bounces-8580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2771955FFD
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 00:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE371F21FEE
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 22:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125D9155A3C;
	Sun, 18 Aug 2024 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xyf+f6CJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB869610D;
	Sun, 18 Aug 2024 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724020548; cv=none; b=QWe5eDQ32tdlp7roE8p3OSK40YZZRuwK10GrUUFntkjBk0g+q049EXUyrfhW5q2g9x8Fm1RibL5zN2RMFnBe4K7/b3+dFk/oJMchS8WmF44N7/kFwHP28EnYBxUiq+fXAvB+zpvouVvh+AhbXfoKjIUcTp/VKX36DzxLBufGPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724020548; c=relaxed/simple;
	bh=P3zyhjnGHxYGLn6uj4wiSZbI1XcBPqGdvNYCAJ+SEAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gr7e2h4XEevNLNd/IrA/BVik9g/eVm/zAn7+9UWjOcnSXFSXWdEULrrnBZCRCHM0nlj2z8qWv4gj1+zvCFa2dQgGNE3bN5S95BLWQpGd7SYNFovhKz1mDHh6zEwSns2mr3PqyzyMtFWmXC6RhYD4CwOvFMsM73dmgSGowgSy4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xyf+f6CJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939B7C32786;
	Sun, 18 Aug 2024 22:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724020548;
	bh=P3zyhjnGHxYGLn6uj4wiSZbI1XcBPqGdvNYCAJ+SEAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xyf+f6CJrnnv5sz+cDNM71HRtRfZHnFZ5CEMPP5fSV3n30NKcmg70pIIEipUXCKEx
	 sf9XX18Ectn+VcA/eQeYtmJJorsYblE7o8mn0zNLIw+HdCbg7uv7tLtXXWsdZM008v
	 BUGfNfJWra1Lrybc6ayJJmqIiSWacVy+n+8JxlvYXXPTiAxvCjetqDp4ui8J7AdsJ6
	 8ELiSTtbXwG4NP2jnXkaITUvGAehP8Ehw2QzICAjJw028nNUWg20ufvG/GugjMl0d8
	 Rr4HS/hr73XYEZsA1DLCIZZOd8oUBvOg81PMXad9orQEb+SxACwXJOMmdOqGoYJ3H6
	 ukVBZkgYpWIjw==
Date: Sun, 18 Aug 2024 23:35:43 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Albrieux <jonathan.albrieux@gmail.com>,
	Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux@mainlining.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: iio: magnetometer: Add ak09118
Message-ID: <20240818-audience-surviving-1a7af0441aab@spud>
References: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
 <20240819-ak09918-v4-3-f0734d14cfb9@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1HdgyuG3gzWeJEz3"
Content-Disposition: inline
In-Reply-To: <20240819-ak09918-v4-3-f0734d14cfb9@mainlining.org>


--1HdgyuG3gzWeJEz3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 12:29:41AM +0200, Barnab=E1s Cz=E9m=E1n wrote:
> From: Danila Tikhonov <danila@jiaxyga.com>
>=20
> Document asahi-kasei,ak09918 compatible as a fallback compatible,
> ak09918 is register compatible with ak09912.
>=20
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Signed-off-by: Barnab=E1s Cz=E9m=E1n <barnabas.czeman@mainlining.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--1HdgyuG3gzWeJEz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsJ3PwAKCRB4tDGHoIJi
0lHlAQDE9dsASR3TqPScIngmx4qCcOJFTEXU8uQ4nOIxIwna3AD/WxXsIPFD8DVP
ls9dgc2TDq2c+k95OfxktpOmrHzDlg0=
=bNkD
-----END PGP SIGNATURE-----

--1HdgyuG3gzWeJEz3--

