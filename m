Return-Path: <linux-iio+bounces-6001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC5090059F
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 15:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2391C21128
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C5E194C97;
	Fri,  7 Jun 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTAAz2ba"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D5194A53;
	Fri,  7 Jun 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768306; cv=none; b=niqYNvwZBXqqYtRP/zBhtTNONNQAKjiARjBoinkfp8OX2FdPbxZWbERiUL2ZjQOCFuhK2kq6leusUs/A785akj9tDOxUiRlp9UjSoSe8NP/MeWbZRv652KvAlxWuzOZJyk+rt+KQ0LMUCl18zDKZsEWLP3vCP7rEQg2viHbPexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768306; c=relaxed/simple;
	bh=pe3Qusx9B2GcfWcWsmCMScgmL8tPmZ/E8aQtJn5OhZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCq8ABQBIPFJnYri+Hp4lhNHyuzMPeXByx5F2k0wLBUxBES/yxMBN6qzLHD4OudKQAJeLcPJGy1jWrqWOYdy/uN+NUKVHo/Om5qIF5ge+vK9GxncQ57o1HPNeXYTybEGn60mIMg/kkFfNpr2DOAVq6GKumXvSUS/dO9HE3kGkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTAAz2ba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0B3C2BBFC;
	Fri,  7 Jun 2024 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717768306;
	bh=pe3Qusx9B2GcfWcWsmCMScgmL8tPmZ/E8aQtJn5OhZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTAAz2baCWDlKJz9mv/8cPBIDGPdeK0jVnvxbs7mcCJ03gEvo6Ny/ndspI6A611GF
	 tnNnjjl/HpqRTCPbd9Okk0VZPyzzMa0y5EyIqvY38hEloxMaMRSgKWDKK83Hu4x7d3
	 mJq4VX/pegr8flDXnsVZRTOxM2XVrEgUgqkvmYsn/hNKOFISjNcWVAKRCCSx9A2wA5
	 0a2CBNv/7gAqbP94RQ/m+Uq5gJaQsyS2IzSBQQTVqR1wgd18QrRxpcGSVXQXh5Xpur
	 +588IwvoTlI9vfgk3qn9xOyRG1vwnUQIJimdEtAtCGRH3ZIWhnDt3tTO5TewuEpift
	 KgQhQYLt9ODOg==
Date: Fri, 7 Jun 2024 14:51:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] spi: Add SPI mode bit for MOSI idle state
 configuration
Message-ID: <ZmMQbkuRyG2PXYZL@finisterre.sirena.org.uk>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
 <0a716b10-0ae0-425f-919a-ea5d8b7975b6@sirena.org.uk>
 <5dcd9701-2725-4aff-9e73-d8f2e038be75@baylibre.com>
 <d09485bf-bbb5-4a3f-84b8-54478c6d78cf@sirena.org.uk>
 <ZmIzXun2-DWl7cT-@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DiJ4Cbmw/Jy9g/RR"
Content-Disposition: inline
In-Reply-To: <ZmIzXun2-DWl7cT-@debian-BULLSEYE-live-builder-AMD64>
X-Cookie: Your love life will be... interesting.


--DiJ4Cbmw/Jy9g/RR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2024 at 07:08:30PM -0300, Marcelo Schmitt wrote:

> So, if I understand correctly, it would be desirable to also have flags and
> descriptions for the MOSI idle configuration capabilities in include/linux/spi/spi.h.

> Does the following definitions look good?
> #define SPI_CONTROLLER_MOSI_IDLE_LOW		BIT(8)
> #define SPI_CONTROLLER_MOSI_IDLE_HIGH		BIT(9)

Yes.

> Maybe also document the MOSI idle configuration feature in spi-summary.rst?

Yes.

--DiJ4Cbmw/Jy9g/RR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZjEG0ACgkQJNaLcl1U
h9A+DQf9H+ow1yixeeJVv2HWjYdjTXXvogM7+ytxuolBO+8b+GMRpwIBasFkjdrv
vhU9CYK83gDKBAzK4Xg4/YmXS9O2QSRwguQ0USsGPYOBDbF2Rsv838BWVDM0p2YZ
kcc3YWXumlQ0OZVI7vlYE8sZ3ITAG/R+wMyiYhKtqKRZI8o7B2KsHeffje70KtvL
wVMT5b6VH74pekp2TTDoU2KQQBSYJ8noV2HWqYvBMdPO+vv+Jo7uPH1tvz3QBfFi
ALaDw8qdpyL3RNtqz5qN6EhESF8XR/a6yyoULa1z7tUOBIf2TG12L3iivo0+Zk01
qgpLoJiamDooRZ5LsbemooN3Sr/PNw==
=00CC
-----END PGP SIGNATURE-----

--DiJ4Cbmw/Jy9g/RR--

