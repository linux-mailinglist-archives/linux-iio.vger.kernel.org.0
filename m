Return-Path: <linux-iio+bounces-7255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC7E9263EC
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 16:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8259D1C21FA5
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876FD17DA2E;
	Wed,  3 Jul 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUN6WLpH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D817DA1A;
	Wed,  3 Jul 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018505; cv=none; b=ame5Z36vBI7ewAcys8dhHpGBbEtvlvF3TbnAyLxPE1i9r3tX96/d/pqvpKKxSAaxEpu1VdLqi6t2CBBwy/tTdeBMZAT76ZOWX9XB1bqYEygJhk8/NCMg2DTr5+YqTaXmpH9YX5YsLsjD5yySvQzlBjxxdgFMGszBC5nDyqbT5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018505; c=relaxed/simple;
	bh=lw6ZRckzdBzfG4AbAAVALv4Knp+zmoL9nUwuQvkR7gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXlxm61r03jmhogHwMHUw3X8SDE2OYnV1QPLUNS8DVq2cMcZN3YHhsSIWYOnwoWkqwohB3+DtewgfyhgJPbRS0Eb61/wITbaVd4VRBcR+GXGUkHRec/mkCm0Z2MqsO5Lj8iajnwpttnk+3gNKjJS1vLZXlyRdGa3DuXc2tUpNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUN6WLpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9DDC3277B;
	Wed,  3 Jul 2024 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720018504;
	bh=lw6ZRckzdBzfG4AbAAVALv4Knp+zmoL9nUwuQvkR7gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUN6WLpHTpEq5lcVSXIt9XDdB1ESww2bIH+/t/XGqyBKtdyUQXsjt/DgIEao4EUrQ
	 at33AvqXIMjoAsUFlTtxBFxGr6qvGg5yN06Ff5d12BXyK3e2pRxXh2YNMCwlOuPPre
	 4i9ASAA+XiSMmDGofphA/IUcbsdz0j7OhXYK9SCrZ12q3N7bm5y5KnKqj8foU4F9zr
	 mmKTDOIGL7otHbNWOA/FV12Fk6na7meb8RltSt7g4ijknDrskwM+I8B8BUgyp/y/Kn
	 LZE4zPCml8KPujJTNsSbzUtvK8BLgJqUDzg++iZpw/7TofPrNuZeSoVz1LXQi8Qxn3
	 9RZExRSFpMKIw==
Date: Wed, 3 Jul 2024 15:55:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	marius.cristea@microchip.com
Subject: Re: [PATCH 0/2] iio: adc: add support for pac1921
Message-ID: <20240703-zebra-choosy-7f34a02b0c7d@spud>
References: <20240703-iio-pac1921-v1-0-54c47d9180b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LsEp9HjQoNvjCCAz"
Content-Disposition: inline
In-Reply-To: <20240703-iio-pac1921-v1-0-54c47d9180b6@gmail.com>


--LsEp9HjQoNvjCCAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 03:34:34PM +0200, Matteo Martelli wrote:
> Add iio driver and DT binding for the Microchip PAC1921 Current/Power
> monitor.
>=20
> Implemented most of the features with few limitations listed in the
> driver commit message.
>=20
> Tested with a Pine64 host board connected to a PAC1921 click board [1]
> via I2C. The PAC1921 click board embeds the Microchip PAC1921 device
> and a 10 mOhms shunt resistor. The PAC1921 datasheet is at [2].
>=20
> [1]: https://www.mikroe.com/pac1921-click
> [2]: https://ww1.microchip.com/downloads/en/DeviceDoc/PAC1921-Data-Sheet-=
DS20005293E.pdf
>=20
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>

Marius, could you take a look at this driver/binding?

> ---
> Matteo Martelli (2):
>       dt-bindings: iio: adc: add binding for pac1921
>       iio: adc: add support for pac1921
>=20
>  .../ABI/testing/sysfs-bus-iio-adc-pac1921          |   45 +
>  .../bindings/iio/adc/microchip,pac1921.yaml        |   79 ++
>  MAINTAINERS                                        |    7 +
>  drivers/iio/adc/Kconfig                            |   10 +
>  drivers/iio/adc/Makefile                           |    1 +
>  drivers/iio/adc/pac1921.c                          | 1033 ++++++++++++++=
++++++
>  6 files changed, 1175 insertions(+)
> ---
> base-commit: 529d2e1900642eba6df28307e26e19793e227546
> change-id: 20240606-iio-pac1921-77fa0fa3ac11
>=20
> Best regards,
> --=20
> Matteo Martelli <matteomartelli3@gmail.com>
>=20

--LsEp9HjQoNvjCCAz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoVmRAAKCRB4tDGHoIJi
0oLTAP9MlOAZ+cX8P1cLqF8Xrw27ZjgJiqQKNNkgA4QimI09BgEAvvxfi99aSdog
XMtwu3ST9LmUZuRxQzysSh7D/HLEAwk=
=zbyz
-----END PGP SIGNATURE-----

--LsEp9HjQoNvjCCAz--

