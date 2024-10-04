Return-Path: <linux-iio+bounces-10139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD18799086F
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 18:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730D2286FF9
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0311C304E;
	Fri,  4 Oct 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asK9Ilbn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CEE1E3766;
	Fri,  4 Oct 2024 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057857; cv=none; b=Y03nihe8FoTe6exeREPgdeYGasN/YvvZsFl6Z2WWL+gVsIUQvu0Vco80JmpPImRKlhFpmyMZOYXpoHtH196fspIGj7N5aLPl4hbFVUBbimBOH7nGx0XNmY6E/rBcxxukflDaQlDANaV01/R7Snf6rM4KLsehUY6m9jXpNda85R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057857; c=relaxed/simple;
	bh=7nWePiMTOkb09psm6kqrNfokwIWfLXuYfsSBj2qWW7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYfErz6fptCpdaLD8K1oyiUPIUWKcorm+wUBPSlyixiHXo984/94eclhXVUEgQXYU+hwc6wmH5p+zb2Y/1FGsbQnxSVqycSqU0cuNre5YwHY9gTls/e70K5cELAg6zpgpTk2LrRcTwNhoK/6X7AYHMzJQ/ERxOlSF83l1tOUxjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asK9Ilbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842EAC4CEC7;
	Fri,  4 Oct 2024 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728057857;
	bh=7nWePiMTOkb09psm6kqrNfokwIWfLXuYfsSBj2qWW7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asK9IlbnUAMWgWoLJj2P57oA1qFJkT8xklaHuygRbnRYFqJR1VmEJv40w6McY8kck
	 umpAhlCu79EhewlrlNvwDUFgvOVQgveFYsX+XOrnm4s2JWeAtCtGbRtHYd11ma+MRx
	 /zN2VKgGmHYy1IUFKti5fxCN5lZOhNKYUoaSWAKwqfLUJ4nSAQvwiQPT6NR4S8lJlt
	 MUclapIS16/fSF+oL/VAq4sFHhYSNw5s+ylM8unxrZrOcJmiV9eGEa4gQx6IfAjYAg
	 6Ji6GkRKPWXXLsYfjYbFi1LW1ri+2rraafAofUcZCjglQ3nK/CiiwfkadTt1OkcfHm
	 RZEpgVEf1SuYQ==
Date: Fri, 4 Oct 2024 17:04:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org, dlechner@baylibre.com,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 05/11] dt-bindings: iio: dac: ad3552r: add iio backend
 support
Message-ID: <20241004-unawake-pushchair-58d4b2347897@spud>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
 <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-5-ceb157487329@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JCq2Q4DdpKt1JHME"
Content-Disposition: inline
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-5-ceb157487329@baylibre.com>


--JCq2Q4DdpKt1JHME
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 07:29:02PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> There is a version of AXI DAC IP block (for FPGAs) that provides
> a physical QSPI bus for AD3552R and similar chips, so supporting
> spi-controller functionalities.
>=20
> For this case, the binding is modified to include some additional
> properties.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--JCq2Q4DdpKt1JHME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwAR/AAKCRB4tDGHoIJi
0vGPAQC41tO/ln6tykdXvY1rih8XUVOH9JGl7QWP+4EKx7NOLgEA0KVS/ihoXc4O
RAqEXUTGmB9rQsNoCWw/eo01YL3P3gM=
=S6rC
-----END PGP SIGNATURE-----

--JCq2Q4DdpKt1JHME--

