Return-Path: <linux-iio+bounces-113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2517EE249
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 15:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289931C20CA9
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 14:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3094315A4;
	Thu, 16 Nov 2023 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCJKnCmV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1128E09;
	Thu, 16 Nov 2023 14:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA684C433C8;
	Thu, 16 Nov 2023 14:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700143409;
	bh=d6xPUlhaYELCUC56AkK/eGiDZyhysNoVJ5PsEWB3OyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCJKnCmV70p7/Zs+2XSS+PXNOlA6+oDISYhh0L9KvfYNiIT1msdmujTTsy/Asdpvd
	 0gAkms93us8ptNyaws9N0qfyX2Z2LjpVCliNQZ7SN1EyYJ8JZfuU7krj7Sv/hEX+SW
	 b9hlPSF2vwBvYbItVQZyT3pzMzmGJ+i7bddYpZLiOVj+HaTrVL4O+7SplxWH4wao0i
	 qfuM+NiIV9f2wNrki9hJmKo44zAfkCkzG9G6H5Xcp8lWob8stpmoyBlj2FFE2qNhUK
	 xP6oCgGMr2FBPU9lLfxakXC+kiMCJDS3gfH9R6xBZJAHvwDkovTidcptMBmza2DKEh
	 Sp5hSQnvHJI0w==
Date: Thu, 16 Nov 2023 14:03:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andre Werner <andre.werner@systec-electronic.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Rob Herring <robh+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	Vincent Tremblay <vincent@vtremblay.dev>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: isl76682: Document ISL76682
Message-ID: <20231116-diameter-showbiz-59067f7c6334@squawk>
References: <20231116131329.6801-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4b1214TFXiQZKbns"
Content-Disposition: inline
In-Reply-To: <20231116131329.6801-1-marex@denx.de>


--4b1214TFXiQZKbns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 02:13:15PM +0100, Marek Vasut wrote:
> The ISL76682 is very basic ALS which only supports ALS or IR mode
> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> other fancy functionality. Document it as trivial device.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Andre Werner <andre.werner@systec-electronic.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> Cc: Naresh Solanki <naresh.solanki@9elements.com>
> Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
> Cc: Vincent Tremblay <vincent@vtremblay.dev>
> Cc: devicetree@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index c3190f2a168a2..27164e9219276 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -179,6 +179,8 @@ properties:
>            - isil,isl29030
>              # Intersil ISL68137 Digital Output Configurable PWM Controll=
er
>            - isil,isl68137
> +            # Intersil ISL76682 Ambient Light Sensor
> +          - isil,isl76682
>              # Linear Technology LTC2488
>            - lineartechnology,ltc2488
>              # 5 Bit Programmable, Pulse-Width Modulator
> --=20
> 2.42.0
>=20
>=20

--4b1214TFXiQZKbns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVYhKQAKCRB4tDGHoIJi
0pNbAQCpSK5BsngtT7hZXgeFenbylOiiuvXV97ZU0cXhVt8oPQEAgkBRmj4NbUdm
I4YU+UgU/J22n2dnXuaphI/5mw4ZCAE=
=2wgf
-----END PGP SIGNATURE-----

--4b1214TFXiQZKbns--

