Return-Path: <linux-iio+bounces-12786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A29DBBB6
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 18:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 210DAB21925
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2961C07EA;
	Thu, 28 Nov 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2lOi+MZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400F211C;
	Thu, 28 Nov 2024 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732814326; cv=none; b=OmoVWvRXfVd6zsp6g+Za4MtBTkEuzERzpAw/FyYuYOBDgjRSW3ystaj64L8PzaUFQY/YYfgXDlgUxw8tW/R0uFE6HdGs7RU/rlCkkCudQbsqDpeVUrVALPQwxKawHUf3ilO5uQFUzI8Ln3lpBaQu3pZnii9DMT9fd2lz7vlQFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732814326; c=relaxed/simple;
	bh=UIrIEmLYdSOlcksLODxWYu2pnF1u08S8scD0J5Vk7CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8WFL98tER4A0LZ+N78WFXSeNxLp+Fm8AODpZoZi9HelceD7htB/ZOJ0a4Te1Mxx84HR6OED2ZKu42OhuDWslChtFUf1uF/d7HR0hpPdVv0fJPdMjPwFdqCgG0+lwYmo11yK+j7FBZ6fFoud7wTKw3ZSl/umZMH+1NMXF7kW7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2lOi+MZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48565C4CECE;
	Thu, 28 Nov 2024 17:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732814325;
	bh=UIrIEmLYdSOlcksLODxWYu2pnF1u08S8scD0J5Vk7CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2lOi+MZC6MW5os0C+NcDkV1f7dJ3TwAf3aJC7C0P0T9soX5dtYlUKH8YHeeqBkxN
	 7ODCyulTVPhLdqMG18VCdQULiEScfhT7Q14Y+/cKqKo3ebbK/HRTz09wATexwJ56IH
	 cfDdJpmRUCp5UWqSpyPxYAFcsyMtflo/PFzHDJnzNNrL5sPi8Zflqz2UKIMYP6iPW3
	 ICu8fDgGeIf9Q2ps2YNeFZ75J+n0lPN3B8LmK50neisvjTEo3nECASwZzOKVDU9H6s
	 9IDiY89lQN5C0WP1wsscQPVZIIhK2IOJOzM1F6Gz5lptbiNPdV2VFQKJrga7UHvxav
	 ak0xKEmJCvwng==
Date: Thu, 28 Nov 2024 17:18:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: iio: adc: ad7192: Add sync gpio
Message-ID: <20241128-abnormal-alienate-593f6b1af7ed@spud>
References: <20241128125811.11913-1-alisa.roman@analog.com>
 <20241128125811.11913-3-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2oJer5AVFXRxoPIe"
Content-Disposition: inline
In-Reply-To: <20241128125811.11913-3-alisa.roman@analog.com>


--2oJer5AVFXRxoPIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 02:55:02PM +0200, Alisa-Dariana Roman wrote:
> Add support for the SYNC pin GPIO specification in the devicetree
> bindings. This pin allows synchronization of digital filters and analog
> modulators when using multiple devices. Update the examples to
> demonstrate the usage of the new property.
>=20
> Also update the interrupt type in the examples to use the proper
> IRQ_TYPE_EDGE_FALLING macro instead of the raw value.
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--2oJer5AVFXRxoPIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0il8AAKCRB4tDGHoIJi
0l7yAQCH67TYxHnL5eswbdjT7pbzI+kLwX3cakf7lGZJ8cO8zgD/ebqo34zPpwQZ
NumRmQouXh7PafP/Tg76KaY4yobM6gk=
=bI0m
-----END PGP SIGNATURE-----

--2oJer5AVFXRxoPIe--

