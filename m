Return-Path: <linux-iio+bounces-17545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D437A78FC3
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 15:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE906188C0E1
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF3723A990;
	Wed,  2 Apr 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLBsfe3A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877023908C;
	Wed,  2 Apr 2025 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600456; cv=none; b=C2GSdl0DlQK67UNyrCNWI/2g2r10SFKjMWy9SovlziiaLow5tp47TdOhpLZ835EF/9LGisMtUVlHXkIgIN1Ve4VgjUM6gxvVOOp6oxTggbCGr96gdZPHRpVsV4ju4KbSiZ/iSljZYufrwNHob9owZv6fMHBMOarwqJxLaecBm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600456; c=relaxed/simple;
	bh=eyprlbruttFArk649ZaHs0r8kWpNrV0UoRpFY8gTMtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTxlWPKk+xTchOLG8DDS/BCXrZiY4+JvNK2TYbTlUwKCndB0XTLUpFLQ9fszDiPJ0vyhC7qQ1GWkleH2UcCp3WGVa+96l1ex1HjvnSyPRDlXi4efmeArKHsMsR5RXqqRf8cCSSpHhE+ecGi2IEWqLKVr0qLTwgjWIX8IT3EYMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLBsfe3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90C9C4CEDD;
	Wed,  2 Apr 2025 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743600455;
	bh=eyprlbruttFArk649ZaHs0r8kWpNrV0UoRpFY8gTMtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLBsfe3AnWLUfmJuHSfLJ3hFtnbJsOb5O6rstvyh3TYl/N2+3Oyl/bKPGiSaNYVSg
	 WLqAx4DX1LWz/s/+Htg4VbhxsdufkOZK5eV2T+Da7R9jmkt2fdO/5AOR6ZCYyBuOXh
	 2aSzzGfe6YbWv520Us/FHPdL5CGCr65Sy7+Aj92BTo9FYvVphJs5RqFhkkTAsdi5AZ
	 1F2qba3fYr5GhtSHXsq0Y/SISp4nPhLlGplQlAIwjHRCZH9IYUadXelA0kk93FgWQF
	 Dm/zIpyDx8rvD58GNbVKbOlyNw898rSH1jEq7M3A4mwWAGxe4s9k+j+NCUYxfhnETC
	 oi8a6TDWplSmA==
Date: Wed, 2 Apr 2025 14:27:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: Add ROHM BD7970x variants
Message-ID: <20250402-directory-turbine-bfe77d6bc543@spud>
References: <cover.1743576022.git.mazziesaccount@gmail.com>
 <0a114565e4de52bf8f98c4f9d17943e5148b0112.1743576022.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="inqJrLpCfua9LcWy"
Content-Disposition: inline
In-Reply-To: <0a114565e4de52bf8f98c4f9d17943e5148b0112.1743576022.git.mazziesaccount@gmail.com>


--inqJrLpCfua9LcWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 09:44:36AM +0300, Matti Vaittinen wrote:
> The ROHM BD79700, BD79701 and BD79702 are subsets of the BD79703 DAC.
> The main difference is the number of the channels. BD79703 has 6
> channels.
>=20
> The BD79702 has 4, BD79701 3 and BD79700 2 channels. Additionally, the
> BD79700 and BD79701 do not have separate Vfs pin but use the Vcc also
> for the full-scale voltage.
>=20
> Add properties for the BD79700, BD79701 and BD79702.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--inqJrLpCfua9LcWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+07QwAKCRB4tDGHoIJi
0jBhAQC50GOZN9lPXluk3fI491lymkX1Ztx3nC26mydUrC/VKgD/Xt/6ZMpdqyIq
dGnDLqGxnz3yY99z2Kz8Q4zs+M5LRgU=
=HDg9
-----END PGP SIGNATURE-----

--inqJrLpCfua9LcWy--

