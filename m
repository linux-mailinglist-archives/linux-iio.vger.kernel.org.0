Return-Path: <linux-iio+bounces-5352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758008D089D
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FF91F23F97
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 16:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0265A7346A;
	Mon, 27 May 2024 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsah57Hz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911173451;
	Mon, 27 May 2024 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827450; cv=none; b=fiPmSgsrB8f70B5gDfMwKdvw8/93sh8LZeel5T2TyZKKYcGykhIQ0MIT4u63GXPzqdmri59OI/SVmL0bO9hIsQvLQtfplfEpGSYr0ajIiiQz6xGPptCYLjipsCD3H2u852ZSqsFlx4dPk8s3E9qV4PRs5YMmU9wnM5N+3nLXgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827450; c=relaxed/simple;
	bh=b7bgwRLi1QVwtqQdf6LMJT1yHV4WWN3TjLr0JQuI8D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFLqWg1tiWU98GIrAASvLv6l8Y4Ht8MTRTrZ7YKfVZR60hrHRCrM5ASX/tXql8Wg1ZxDLmgh31VuVzN5B87c5SaZMNV+TdXm2Al1xzNejiKUmwNLVAXiAJYu3PqGtRXfvA0mLvbckkDU2NO0oNBXYIdoxeeTAkVsElV0BqA7MzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsah57Hz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6253DC32789;
	Mon, 27 May 2024 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716827450;
	bh=b7bgwRLi1QVwtqQdf6LMJT1yHV4WWN3TjLr0JQuI8D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsah57HzN2qYj+/na64i4iC3vUpjaM41VXU8sc/M0mbP0oAFMooXrV+WgGVpsRGYj
	 0vCjreZlhE0gWOX3PhPgR/iBpZ9he7OM3vDiaOcvjsyBbSl3NF/poHCZyOVYps5HOj
	 Glm8EOWt2xC2dlB4den79sJcQ9CRXAku5dSu85Re+KpcxRJIujO3Bu7o+URc+qtEyi
	 CtKMC9hSingpfKquPSfHqM0byf+Ipos8+yUmeQCn4cHXbMsRZtD09lFPPkFacw1EYs
	 FAi5MGHw/E5fxfMB97YeVtfHvoA3kT898px8TnsxMGhiiebyCOkqfePOVdJQ6jL6ik
	 eZZxJXhd2OdGQ==
Date: Mon, 27 May 2024 17:30:46 +0100
From: Conor Dooley <conor@kernel.org>
To: arthur.becker@sentec.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: light: add VEML6040 RGBW-LS
 bindings
Message-ID: <20240527-effort-hungry-c7bbb0b0e36b@spud>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
 <20240527-veml6040-v3-2-6f3bbfd42960@sentec.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1Iu929YBt0ECJpdr"
Content-Disposition: inline
In-Reply-To: <20240527-veml6040-v3-2-6f3bbfd42960@sentec.com>


--1Iu929YBt0ECJpdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 05:12:09PM +0200, Arthur Becker via B4 Relay wrote:
> From: Arthur Becker <arthur.becker@sentec.com>
>=20
> Device tree bindings for the vishay VEML6040 RGBW light sensor iio
> driver
>=20
> Signed-off-by: Arthur Becker <arthur.becker@sentec.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--1Iu929YBt0ECJpdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlS1NgAKCRB4tDGHoIJi
0gb8APwJWEHJYeTg86kAgqTRwFhNoJZO6TLLYpvDKkohxiOn7gEAsJTbrGISCElz
x0wNOXCDMjotKoDKzFrLEay2Y4tZEQ4=
=GyS3
-----END PGP SIGNATURE-----

--1Iu929YBt0ECJpdr--

