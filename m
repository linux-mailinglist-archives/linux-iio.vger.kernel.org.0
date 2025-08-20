Return-Path: <linux-iio+bounces-23073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2642B2E5AC
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 21:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8F5727A69
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 19:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E732848BC;
	Wed, 20 Aug 2025 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6wpkuqy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEB636CE0C;
	Wed, 20 Aug 2025 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755718432; cv=none; b=Nl7VfCUpb1U1awtSkponJ+c+u70RyaLXBelTKnGygy1qnLCnGfhpoS7quMG/SAbOkaXEfYcNuwaipbx+knKLhPBMEy3rLyvcDtQ2y20CDyhi4/Bfi60C0sPcmr4P5+N0cIs3yojRNGNUO2VR9NvlaJuZ/sR0Jc1u18Tj8Pc043g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755718432; c=relaxed/simple;
	bh=oaWPMSjxQnZr7qgJMIj4hchkhbV9nr70B3dzzNr6DdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrnWFjwExDzqgHtFbWWQOdQSTjjFO7EvPEbk+VHEo9HRez81C+GDgIb29BzRiA0DAOb6KGJPJ2GmraL3dqx1YBE7/VTKUU5Q1RukHgNF7wWbtqqUu+vUu1E/JAr3nAGtOfPNMgoLUr34OZVOa0FGRiNKTjfDFWQFyiixrsRH/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6wpkuqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A3CC4CEE7;
	Wed, 20 Aug 2025 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755718431;
	bh=oaWPMSjxQnZr7qgJMIj4hchkhbV9nr70B3dzzNr6DdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6wpkuqyOOZ7VeI+eTzcnehvvKa0/gPeodSNx0Qobjdt6z2z+l3wdW23K2brI26Ww
	 kjGW5MHUO4lsA4RFiMlN5UHa08CmFwkprjI126B7IOyslDyQQSRqK9XJ4+mlRSngep
	 L9PUWX1muebFDPmY6RuPVIRMfpalfpdnm7Qdu3PeLmD1f47TEO3VviX4Us1+3UDp1B
	 S9ov0NptNvIjhkl6KYuo5iLTasymXldCGnMoloAz/foo6t11pSnGuIeij1wsztfU84
	 Wcv6DSiMSFkqda53049FSy+zMDckwvZsoanuTT4baVSSjg2jF6UBZZWaKGdhOKqh/J
	 UKkzen5fWSiLw==
Date: Wed, 20 Aug 2025 20:33:47 +0100
From: Conor Dooley <conor@kernel.org>
To: remi.buisson@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/9] dt-bindings: iio: imu: Add inv_icm45600
Message-ID: <20250820-decode-move-3a4497d2df72@spud>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
 <20250820-add_newport_driver-v5-1-2fc9f13dddee@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JOFvzgy1b8g+glJG"
Content-Disposition: inline
In-Reply-To: <20250820-add_newport_driver-v5-1-2fc9f13dddee@tdk.com>


--JOFvzgy1b8g+glJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 02:24:19PM +0000, Remi Buisson via B4 Relay wrote:
> From: Remi Buisson <remi.buisson@tdk.com>
>=20
> Document the ICM-45600 devices devicetree bindings.
>=20
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--JOFvzgy1b8g+glJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKYjGwAKCRB4tDGHoIJi
0uiFAQCRXy/GGeKkcNM7BR8TWYgymdQ6LYkEegpPsL4t9EpoLwD+MeJa+7vmDp9v
7zUFb15dWYjjMD4xdolU09uhNQWDpww=
=L/O/
-----END PGP SIGNATURE-----

--JOFvzgy1b8g+glJG--

