Return-Path: <linux-iio+bounces-25988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF9EC3CD2C
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 18:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA86B4E4204
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3CF156F20;
	Thu,  6 Nov 2025 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sL+XJhei"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815F42C0F96;
	Thu,  6 Nov 2025 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449788; cv=none; b=RxP5g2z5C5yC1VoGEtnteif/Bp9sD333FxlqSvad407fkZglRpyIFeDVw96Db75JY94R2xcf7OVS3ab7vxk94Ane8b8H+8MnHfr5zd4YMG43h805ZgOTQ/RltsXhwHvBRaxicSaZllzPWfAtSL8wiRIoVja2v8bEhjKgSYl+zeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449788; c=relaxed/simple;
	bh=Rxan2Yeh68Lm/SyLo3Z42fx4sETys8Q/LCfL4kyAoDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX1RVekdAp18XW5lwyipXm2qFn0p87050lEAFwH4N7vW9s+O57gqxmCIxrbqI/ddDoyBwBsrI5+AhAEzY2z9W6UWy2jIYZJNM1EIKo3ah4SUQunwy9+mYCVD1i2/3jfXf5Q57Q7duz6HOlCIcX2lV86PBGTIwg3WjgdfboOzJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sL+XJhei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCC2C116B1;
	Thu,  6 Nov 2025 17:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762449786;
	bh=Rxan2Yeh68Lm/SyLo3Z42fx4sETys8Q/LCfL4kyAoDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sL+XJhei4/cEYp0T+g6kl6wIGRpeDOhnGwZ4lwCRh9JqjjgFZ36VZrYL68flck+gB
	 AR/cvhoPj8N9HHf7PFMkRJbYURgPt2ToaYPPRtZyi979IlJfpnds9fWPhG/XKmPQf/
	 Pbeej9ar4hVRygbpjwWkZ2uBMwnUmL4xhoMOu/NU/siDyVt79VDFyISRX+kJIMAxH4
	 laeD9qi6T75yyHIbiiYS1Kc4TNrW/IlAVdtSe5yhRKg6rdAeZiOjrL0RigWTens0Ou
	 cxeFmc5oIqVGEflUpZvdWrQHJWX4cQ3ZggYfMLLoQnrL2AiDAWdyTbNn5NjHfe/G1f
	 hP32xjDOdtx0w==
Date: Thu, 6 Nov 2025 17:23:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/5] regulator: dt-bindings: Add Linear Technology
 LTM8054 regulator
Message-ID: <20251106-puritan-snort-89c23ab2a485@spud>
References: <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
 <20251106-ltm8054-driver-v3-1-fd1feae0f65a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cc4TgVtS10azUgXi"
Content-Disposition: inline
In-Reply-To: <20251106-ltm8054-driver-v3-1-fd1feae0f65a@bootlin.com>


--Cc4TgVtS10azUgXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 03:11:46PM +0100, Romain Gantois wrote:
> The Linear Technology LTM8054 is a Buck-Boost voltage regulator with an
> input range of 5V to 36V and an output range of 1.2V to 36V.
>=20
> The LTM8054's output voltage level is typically set using a voltage divid=
er
> between the Vout and FB pins, the FB pin being constantly regulated to
> 1.2V.
>=20
> The output current limit of the LTM8054 may be statically set by placing a
> sense resistor on a dedicated pin. This limit can then be lowered by
> controlling the voltage level on the CTL pin.
>=20
> Describe the LTM8054 voltage regulator.
>=20
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Cc4TgVtS10azUgXi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQzZdAAKCRB4tDGHoIJi
0sMTAQC6qbxNWzh6RXnu2ZGMpDTzYga/Umnc6DJFEkVDvbisIgD8CtttMVFowVda
U9LLrAvjq8fW70b5VfzFOyon4h9FrQI=
=uCKL
-----END PGP SIGNATURE-----

--Cc4TgVtS10azUgXi--

