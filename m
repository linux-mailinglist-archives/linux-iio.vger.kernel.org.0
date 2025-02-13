Return-Path: <linux-iio+bounces-15507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD20A34F54
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 21:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06AA3ACE65
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 20:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB3D266186;
	Thu, 13 Feb 2025 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPHF68oA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BC72222DE;
	Thu, 13 Feb 2025 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478341; cv=none; b=jxVuQu4LpnfKShNao6+j3XgFmibE9A4c58QV9TrrSZVHSZdntFFMSBnvxH8Vy0evHkj+HPR57eh0aDKv+rWC0LC5XOrcfemVcMapHH6GWS34DoBGM6VPFmRrhFzRBCWCjVVs9hZigkm/JJ1OPrA9Wfx4J2ZSpuGiH9KVpTI3YOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478341; c=relaxed/simple;
	bh=0fl/5EuCkMkPaSWLh19FXELzC67YtrjrdyCIkM/pgjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o65Gj+gennuJ9pNm12OPgCSfX8h6GCqzeHQ/IYXBZ54w9wHCaVN3+euW4/fRUzCKJuOdOj4P/Gdce+IXYggDZjLRoedknrF7+YztkYyGhJPu+6GNqSBzqz1drNE881vkFKojm2z9tFulq+zhBmuOixTuEd67mTxV9GcJhSqkpaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPHF68oA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE70C4CED1;
	Thu, 13 Feb 2025 20:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739478341;
	bh=0fl/5EuCkMkPaSWLh19FXELzC67YtrjrdyCIkM/pgjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPHF68oAO3m/rDkPTiM0e9+oXWkxpB52q1Wc1lrrH06PWcIBeduFndRcc/dgaog2C
	 mPcJSnpk27IIVkgAROVZpqkpMFSwiSmsMQRjlOkuGVGvzdj5YR+rT0Me9Ev12+5tdd
	 8rPlWWTrlfnOFqsxmbZNTHloqKedjcg8eIEJdc/7PZNJ/zjgtC4G3twDjxz8zdbGWh
	 fuRAJFCCVtaa4Fn/CH5NeG1MKoU494/0zPinYkc6XbLi7j3LS0SxY0aO3zkBzTXtO9
	 9wgG40w12o4mQuQ0DzvYky811ioEupWZqqMxvqQnYZfZPWCyFx5xk++OOvsRaDYHVT
	 xQSJLV7SyHBDA==
Date: Thu, 13 Feb 2025 20:25:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jonath4nns@gmail.com,
	marcelo.schmitt1@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH RESEND v3 05/17] dt-bindings: iio: adc: ad7768-1:
 document regulator provider property
Message-ID: <20250213-anybody-affecting-f951f66242aa@spud>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <78c7d5d139d6c158423804f0e6c81cbfe9717b1b.1739368121.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CpEWeTb+A6AzQ08v"
Content-Disposition: inline
In-Reply-To: <78c7d5d139d6c158423804f0e6c81cbfe9717b1b.1739368121.git.Jonathan.Santos@analog.com>


--CpEWeTb+A6AzQ08v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 03:16:35PM -0300, Jonathan Santos wrote:
> The AD7768-1 provides a buffered common-mode voltage output
> on the VCM pin that can be used to bias analog input signals.
>=20
> Add regulators property to enable the use of the VCM output,
> referenced here as vcm_output, by any other device.
>=20
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--CpEWeTb+A6AzQ08v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ65VPwAKCRB4tDGHoIJi
0rdfAP94PIe6E1lyDQNdt1pZc5Cf2DiCd8ADkNuBJ1Nanjc2aAD+MWbFZ5b923Ed
31oVf7grz0LFxU0mB/DOXKPr8AeGhQ0=
=kiXf
-----END PGP SIGNATURE-----

--CpEWeTb+A6AzQ08v--

