Return-Path: <linux-iio+bounces-303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4598A7F65E7
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 19:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6CDB2129A
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3EA4B5A1;
	Thu, 23 Nov 2023 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ61VMyv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7354AF76;
	Thu, 23 Nov 2023 18:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCA9C433C8;
	Thu, 23 Nov 2023 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700762585;
	bh=nuppog5gHM5PDdmOf0v6VeS1jwQuAhpresQvggmV4bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJ61VMyvko7QS9/SGSXmW+7k2SIUFTWVAOhWXRnNDB29CULQ3Sl73hQSpDFcm/HU4
	 dLIeOY6KaNugid4myURGXb8kVIoELKiWeY8W/wUAYTZLBK7PBSfo98/bObspjxb/U0
	 UdIbyLVQN0fBW25Ekbn9YfA8t6lSAAl2wabSHpth68uRqfw+nB0cpRO1r/IoRPKKh2
	 MHAhtYfYFFTSGa8PrgdvL1kfpopFX1ZvTEDG5ql2g3+sjl9zpsDs1IeDjmUc8mrwMt
	 rbziIftMB094bNgVretH/dzHYVgAKDxl+gQ/F/rAuctAfrHgDuUGKKSNV5ZYl0Q4Pk
	 1zCMY7vqNE8yQ==
Date: Thu, 23 Nov 2023 18:02:58 +0000
From: Conor Dooley <conor@kernel.org>
To: mitrutzceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
	linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: adc: add AD7173
Message-ID: <20231123-ninth-joylessly-89e8531cf756@spud>
References: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K9w0PSfQdN+TWI+G"
Content-Disposition: inline
In-Reply-To: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>


--K9w0PSfQdN+TWI+G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Yo,

This looks a lot better IMO, thanks.

On Thu, Nov 23, 2023 at 05:23:21PM +0200, mitrutzceclan wrote:
> +patternProperties:
> +  "^channel@[0-9a-f]$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false

> +      bipolar:
> +        type: boolean

This should be defined in adc.yaml, so duping it here is not needed?

> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: adi,ad7173-8
> +    then:
> +      properties:
> +        refin2-supply: false
> +      patternProperties:
> +        "^channel@[0-9a-f]$":
> +          properties:
> +            adi,reference-select:
> +              enum:
> +                - refin
> +                - refout-avss
> +                - avdd

I assume you tested that this restriction works as intended?

Cheers,
Conor.

--K9w0PSfQdN+TWI+G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV+T0gAKCRB4tDGHoIJi
0ps9AP9/++/sCN1dTPtbBoPrxYvOvaRbVFVVoZdi0QouNZ+uQQEAqTtA7VnxEYk0
sIL+bDAZpJIzJU7lUWDbroIR91pOjAU=
=Re9o
-----END PGP SIGNATURE-----

--K9w0PSfQdN+TWI+G--

