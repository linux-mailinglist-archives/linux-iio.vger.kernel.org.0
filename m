Return-Path: <linux-iio+bounces-20433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6746FAD588B
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62B73A72D9
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F67D2BEC31;
	Wed, 11 Jun 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNoq9Mte"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB662BEC29;
	Wed, 11 Jun 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651672; cv=none; b=AvJPvntDRQCY+jLEUSvocFXPHQiNcxaAFz6OH3Qu7PAEf0j7RAHZDF+a4KUAXn/EUTvfRrEd0nOVHdcEvEDCxzzDbMc3Ll9Ld+ZUSmh2XzYtTpEn0jT2CSmOwtqBugzQvDCyIMInS30aTusNWcCsYpm/aRAIglJaelsRxvUmuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651672; c=relaxed/simple;
	bh=4EpeE6l8Nn2dB+jf+yHetdQyuWdaDecEEjQqM9rQqY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo9MZL9p/W9n0NDWW6w64qVGKjBJZoLn9INRvOa0SPcecD/pTxMfm2fjn+Wbp9FAg57kt6A5pjJwiWf6LTyg4vHjfdICiu9K3kDwhSk+eY/Sl+KOiM9fpm8u1Odnf4zUYEloB+2k0B4BMc6xKkqdvWodhebFCCDm+XSkEvnIZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNoq9Mte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3BDC4CEE3;
	Wed, 11 Jun 2025 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749651671;
	bh=4EpeE6l8Nn2dB+jf+yHetdQyuWdaDecEEjQqM9rQqY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNoq9Mtei6sRXl7pUE1LEvQ/9JNy25VcwC6QqsbTg9ooFzl7FTKkIa2cboykRIzgx
	 1hogX4t9s5DcU8i8Bgh7EYnC67u+wZSPKBZQk01sfmgKkE7j9HTHkGEn7kdIKqdvZH
	 GGSl4cdoFGUmTJj9nfa9SAjY9IXWj0wjRlorN2ArZiemWSIQOBBboFc10lhhyzRLMU
	 1/FPLv0Yz5I/tYdo0m7Ug06vB5fbGhQ8T/npdzBSgiGDW03xmABCkse8Dndk1Iq39v
	 P/r7JvDrkpVgjLV9Bn9Cerhc1tPG9dm2N4MCkJLGsM0zshT8qmqXVWz466bPGNFI2e
	 TgiIlVKfuKHcQ==
Date: Wed, 11 Jun 2025 15:21:04 +0100
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Da Xue <da@libre.computer>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Subject: Re: [RFC] spi: expand bits_per_word_mask to 64 bits
Message-ID: <c8b8a963-6cef-4c9b-bfef-dab2b7bd0b0f@sirena.org.uk>
References: <20250611000516.1383268-1-da@libre.computer>
 <71b66cbb-ab2f-44e3-926f-9ae4bcb3aadc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C8NDDtQ7fYtQCDq5"
Content-Disposition: inline
In-Reply-To: <71b66cbb-ab2f-44e3-926f-9ae4bcb3aadc@baylibre.com>
X-Cookie: No skis take rocks like rental skis!


--C8NDDtQ7fYtQCDq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2025 at 09:16:06AM -0500, David Lechner wrote:
> On 6/10/25 7:05 PM, Da Xue wrote:

> >  static int ad7949_spi_probe(struct spi_device *spi)
> >  {
> > -	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
> > +	u64 spi_ctrl_mask = spi->controller->bits_per_word_mask;

> I think this driver is incorrectly accessing bits_per_word_mask
> directly and should be using spi_is_bpw_supported() instead.

Yes, that'd be an improvemnet.

--C8NDDtQ7fYtQCDq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhJkM8ACgkQJNaLcl1U
h9AoGQf7BpiMDy7//XU9lEZQ/VEn8tyF8R5nc5t4Hw6vF3NvKT0GbyOZqlS/KDnf
uV2QHAMFNdfODkpxv0E9VRkgKLUm5zNVP/1KT0kCF5Qv2nE9Y+vFBfKycvUB8OCm
oPlCDVvMNBueFTAp64IFpB5VKPCVcgWew9IZ2mtxMQCqB+Xg4jjNm5Ju57Vwwrwh
ABk3xaK7nmalCeSit7Gx5qpdjyPkzMrNKv870WNliuZZX1peuYZdHmusnV3cXPs8
2d26GAahFM3d7JAJ5sklNVlPDVEIvvYk5uh/oGGTG8qKvXljyCuihnCS7ZLslgmK
LCyQQygFokLIwkKSNPoKG+CP97fyCQ==
=T5ML
-----END PGP SIGNATURE-----

--C8NDDtQ7fYtQCDq5--

