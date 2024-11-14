Return-Path: <linux-iio+bounces-12266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB0E9C92F2
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 21:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A99B253D8
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 20:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8E01AAE28;
	Thu, 14 Nov 2024 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puN6Y1ZW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD61A9B3A;
	Thu, 14 Nov 2024 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614970; cv=none; b=CwsacVukMuOThUiRi4/QssK4NF3nWyEbxKL5J1CGMeG4u/yf7LcB6hpI4eHQAQwV6zbfXWLSvHZgQSyOLrA3qufnpn/67lK7idOn9MJbgDmTU4+ev0sUadpdo1FhoTWJhwB4QV+GFnKcHiReEAqjB8gGkklPUYGYayUJFsvE6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614970; c=relaxed/simple;
	bh=vL97R4gQ83JgU7ayQ6bFXPB0T2AuF7pgvSGStTn43Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9yDtX6fXJY0eQe7bmkVUXGmV6NjG5nGy8ShZGNwkMLwO8OUIUjLvcZBVViK45d2Grd0JeAcNWsyyuhrRSbBUO4N8YiBjtAniiRnRqKlY5uMQsXR68CGbqr7qvqegfP5iovzJk93RaXnMBfmunU5yIct5l21rQafaS6Nfbb/q/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puN6Y1ZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638FFC4CECD;
	Thu, 14 Nov 2024 20:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731614970;
	bh=vL97R4gQ83JgU7ayQ6bFXPB0T2AuF7pgvSGStTn43Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=puN6Y1ZWxAgdsaad0SHULrE1k4NjVrnJ5fHQTSSeC/F6q2fujhl3mjaZlIX5s+P2y
	 50QxoPDwT5M/aL9fMMKO5cy6r1dFLFsxS5rLXUHPdZKmWh7/PGvLJI3zyu7y/inMVl
	 8Ta50Pxq3yaEaaNBD30txTl5sKdAXtcz/R+ZT8aG83F8wT6AjA0bYu5RJkHWVyOi8N
	 o0M9fu57daf98sKDBvBBBMDfB/5kbBqGWBsjQkvY7W/OGRVbkt3GyyG1/vFxwd3YHx
	 e4jUAJnEIFckQ2F1S/jh1zmZ1qCz8zir7T4jwGDik1o338qHnQ6bRa2dydXrLTz070
	 iqItyU7QHf0hw==
Date: Thu, 14 Nov 2024 20:09:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Add
 invensense,iam20380 compatible string
Message-ID: <20241114-penalty-define-6dc0df195885@spud>
References: <20241113-iam20380-v1-0-cae690c4674d@nxp.com>
 <20241113-iam20380-v1-1-cae690c4674d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ENEN3ELixFLWJQZA"
Content-Disposition: inline
In-Reply-To: <20241113-iam20380-v1-1-cae690c4674d@nxp.com>


--ENEN3ELixFLWJQZA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 11:05:56AM -0500, Frank Li wrote:
> From: Han Xu <han.xu@nxp.com>
>=20
> Add compatible string "invensense,iam20380" for the Invensense IAM20380
> sensor. The IAM20380 is similar to the IAM20680, but only supports gyro.
>=20
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ENEN3ELixFLWJQZA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZY9gAKCRB4tDGHoIJi
0v++APwOLUD/m9Uja9J+s4WwsU4Z4hkRdfZOpvn7YtXysmxEpgD/foqCUSi5/NHC
2xs59s0e8uqWqmP4HmY28R6xuA5LPgE=
=ys9Z
-----END PGP SIGNATURE-----

--ENEN3ELixFLWJQZA--

