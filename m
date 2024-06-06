Return-Path: <linux-iio+bounces-5933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9598FF357
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 19:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06EE1C2543A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB241990B2;
	Thu,  6 Jun 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp7pk3MU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84146197A65;
	Thu,  6 Jun 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693667; cv=none; b=hY4sewrq8hDQARiWEvvGowvu5511NHvUy6FxH3fspeEfPQYvh1mT/5ccYkRwx4mm0F+gYmRjfSqBFdDcNPrY04ywaQKAvYVitxBglQfrs8/YTqIH6xaTWfISB6uSrvov637nLvizw7SvUYW37/PAGs92fNvYO8hrZOxIqs8yjt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693667; c=relaxed/simple;
	bh=83n/I+Eo4TLS4nRX1lMoo9h2rB6lMc8Pv/wLW87Nshc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXfeNf45tCNiC2cwHsmkFFdWLJGRiaHeQYYVG5+nrCsTs7V6b1qB3fOoRywMohbIu34rVjnuNg+IF6IW4CjJjpo/JderXkkKZsvcPMFv3dbMP1QhE1xq/tadyEOppMyHVJAoQnj1aPRTlJYTdJ9TQuzAp5dHjXs0yTNgCTspR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp7pk3MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39E3C2BD10;
	Thu,  6 Jun 2024 17:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717693667;
	bh=83n/I+Eo4TLS4nRX1lMoo9h2rB6lMc8Pv/wLW87Nshc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zp7pk3MUh+E2K0vp5ptItAd8LTTqBxprf//wmBnqu75SaXYdtgTJlOakiR6/0igyy
	 yloOv3Tb8Ay8SU6PMEqH0SLd3Zurg70oUfcTuyyFZsCjvo3IxCPqj3DNlkv7VoUbfy
	 xjSlVDwY2LJPY3tZZxxCaMXmV07BytxbxXh+6h+8Hp4pZUaBaB0rdbQKBKqTT2AKQQ
	 ZPDx9wfNz14+rRg+t02ETbtGTvrjm4VetczCjdCpXbLBsqRvkZZls/OxxDzggbaLeC
	 f7pIpWcuZwTkV5fYB6L/srIYJyfJr6wrkewfWoxd+NsofaW5f8wWiy7LbbQC6dtVh/
	 3GJHL30JnmT7w==
Date: Thu, 6 Jun 2024 18:07:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add ti,ads1119
Message-ID: <20240606-popular-cornflake-9995abdc7763@spud>
References: <20240606163529.87528-1-francesco@dolcini.it>
 <20240606163529.87528-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MlNTfdf3jY1WyMxn"
Content-Disposition: inline
In-Reply-To: <20240606163529.87528-2-francesco@dolcini.it>


--MlNTfdf3jY1WyMxn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 06:35:28PM +0200, Francesco Dolcini wrote:
> From: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
>=20
> Add devicetree bindings for Texas Instruments ADS1119 16-bit ADC
> with I2C interface.
>=20
> Datasheet: https://www.ti.com/lit/gpn/ads1119
> Signed-off-by: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2:
>  - add diff-channels and single-channel
>  - add XOR check to make diff/single channel property required=20
>  - add interrupts, reset-gpios and vref-supply to the example=20
>  - fix missing additionalProperties/unevaluatedProperties warning in chan=
nels
>  - remove ti,gain and ti,datarate as they aren't fixed hw properties
>  - remove unnecessary |=20

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--MlNTfdf3jY1WyMxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmHs3gAKCRB4tDGHoIJi
0ge+AQDSD9FzXJl3Ozm3C5LKszHGqGVdbLyh8RrnWpHB3DFZWwD+Kyrt9dfKVg1r
LzUBrCsz5O8x0LHgxTyA3tjFJZe4MwU=
=iHiO
-----END PGP SIGNATURE-----

--MlNTfdf3jY1WyMxn--

