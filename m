Return-Path: <linux-iio+bounces-10644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E0D99F2ED
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 18:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D311F240BF
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C031F76AF;
	Tue, 15 Oct 2024 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV+Qs+46"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015191F6671;
	Tue, 15 Oct 2024 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010604; cv=none; b=hLK8RDjWUim0Q0WXxDbtPI1SxDcRTGKKGShVhbWBY9TkmiBx+py0Idzm5TAariLrvq76MEvq4OqlnyyhS4IrUHG+8xCcYwu8VQwgSnAs2zFT0SUba6toC40aDjbJv77RrP8+ojBIWokc3AN2FSWHJ8rDQ9OMHuf1ihCDlPUAnuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010604; c=relaxed/simple;
	bh=Zp5x28awwso2vq4W5at6yDp0Z0E2vZCjRjcmFsBaAIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvER378eObX/ZBRX5B+TFbflCuOznBi333Ilrjkw9/LPCLqkJVtd6njQpCCle3Le3sRhfS/53gqD2qHSw4lmcKxSZieMN3wE+nucoynVxy/ul5JhasZx9FaTqE4azmwEbdmdVukqJOZGODDA5PXAUV3WQ3YhhXBu+6pen20e14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV+Qs+46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAA8C4CEC6;
	Tue, 15 Oct 2024 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729010603;
	bh=Zp5x28awwso2vq4W5at6yDp0Z0E2vZCjRjcmFsBaAIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VV+Qs+46ppTUZUXsf69B7hzmxiymCC0zQSOLcO4KNGzvpeGXGA9lK2U3R3C0CDU6k
	 NGsl4KceqsPv12A62QirAGkNOTRYo8+NPjeUr9yOH9+Ew+07htvFgB6iYE0zK89JkQ
	 vjUdqLJNTO5IfDxw1RV6n3B0lCrRDzHTjdq93WAL+mD6NmbeC/UgirUNObl91m4oru
	 XgTwJootzavUxQTPxCY0ZJ/Z9251Jl5gTtX9NaPsGQKDvJAe3E2a/NvphbBgzdqtPb
	 82dBz83EkEhvDuyrIiAivEm5aaMi7Np3wI/Muju+3JDf1fuRXou4qfRxacCI7Kt0t5
	 AyleRtFbmvRhg==
Date: Tue, 15 Oct 2024 17:43:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] ad7380: add adaq4370-4 and adaq4380-4 support
Message-ID: <20241015-scoreless-carwash-9ac6047092fe@spud>
References: <20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FquwYMWZuCPTNX1G"
Content-Disposition: inline
In-Reply-To: <20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com>


--FquwYMWZuCPTNX1G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 11:09:05AM +0200, Julien Stephan wrote:
> Hello,
>=20
> This series add support for adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS)
> which are quad-channel precision data acquisition signal chain =CE=BCModu=
le
> solutions compatible with the ad738x family, with the following differenc=
es:
>=20
> - configurable gain in front of each 4 adc
> - internal reference is 3V derived from refin-supply (5V)
> - additional supplies
>=20
> This series depends on [1] which fix several supplies issues
>=20
> [1]: https://lore.kernel.org/all/20241007-ad7380-fix-supplies-v1-0-badcf8=
13c9b9@baylibre.com/

What exactly makes this series RFC rather than v1?

--FquwYMWZuCPTNX1G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZw6bpgAKCRB4tDGHoIJi
0gW1AP48+cVNlb0SPPyBWZb3bp4yRzZlQBfrWiCLsO0pH/QZSQEAsbgWsUskqrtD
yvKLDMW6F6ddCH4YHgLRdER2iz36DAM=
=HG2C
-----END PGP SIGNATURE-----

--FquwYMWZuCPTNX1G--

