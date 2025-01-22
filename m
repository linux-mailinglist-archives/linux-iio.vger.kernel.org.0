Return-Path: <linux-iio+bounces-14533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6205A19878
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 19:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3572F16A8A0
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 18:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38221578E;
	Wed, 22 Jan 2025 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK+7ow7r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F4215777;
	Wed, 22 Jan 2025 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737570759; cv=none; b=XfK2QmooaJ8616Wt7S/1i3PXpRQVSF77STdOg7p8uo0tJc0IFTS+IbxllsDhpAjDXxLAFSZQeogeiF8fNkLu2KNnGa9ZL0+/BNVCoze2mmXT+2RCS7Zosa0rzEnNPwIO1efqo44w2VWhHXZwXMeBXrnR7KePvFVbpLt4T/2Hhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737570759; c=relaxed/simple;
	bh=Iis+QU1tjZAJEHmlk0WnMQoa/BLWtdN140rjfcxdt14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4oHJ/lkc12CUpL2xUgAgtYnGDieViwl+O0cB2fwxLk4aUDqJuy5xG0EtTuHXTIkWDUuQ8ijE7782cx9f9CbHlM3MpUbwt9X4VCEOAGZF+jGmiKItxz5oX61PeqW9ibgDtJ83d6HeXBCODwlAnh7yjfoTJ1ixScW2s4T5gmarsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK+7ow7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CC6C4CED2;
	Wed, 22 Jan 2025 18:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737570758;
	bh=Iis+QU1tjZAJEHmlk0WnMQoa/BLWtdN140rjfcxdt14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gK+7ow7ruuizrO8T11TJcO7Ay3+QJe5i+3QPNghJVS2wooa2QnTAh5XvpwCuGBFh+
	 LZ2cdeq+XuJXxBLDqwKVGnWGQew6Y8Sglm97+m/Y5GD6hklG1L3hmx+hwXPtJZQmBA
	 WbQi6VrrPGcSuQk6ZBfTXzZLSZLyK9RSTfncpSxF2moZ8B6t9C0d3Zfx7FxMFxMURL
	 dvYfVfk2DLVBaUy4EBVDIpJ4N0z6qID/i0xQg6trDVXW1WcS0CTEEnAUbnLndm244+
	 4noqvIz1jNSqw4q2d54UXBd4W42NNNMyEIJiwjs243EVlzv6xWiFvct0YVvn1AOhCC
	 a7u916y10GK7g==
Date: Wed, 22 Jan 2025 18:32:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add AD7191
Message-ID: <20250122-gravel-angelfish-495977611060@spud>
References: <20250122132821.126600-1-alisa.roman@analog.com>
 <20250122132821.126600-2-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tTB+zRNEZ6Rhy9nc"
Content-Disposition: inline
In-Reply-To: <20250122132821.126600-2-alisa.roman@analog.com>


--tTB+zRNEZ6Rhy9nc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 22, 2025 at 03:20:39PM +0200, Alisa-Dariana Roman wrote:

> +  adi,odr-state:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Should be present if ODR pins are pin-strapped. Value corresponds to:
> +      0: 120 Hz (ODR1=0, ODR2=0)
> +      1: 60 Hz (ODR1=0, ODR2=1)
> +      2: 50 Hz (ODR1=1, ODR2=0)
> +      3: 10 Hz (ODR1=1, ODR2=1)
> +      If defined, odr-gpios must be absent.
> +    enum: [0, 1, 2, 3]

This should be a property in hertz

> +  pga-gpios:
> +    description: |
> +      PGA1 and PGA2 pins for gain selection. Should be defined if adi,pga-state
> +      is absent.
> +    maxItems: 2
> +
> +  adi,pga-state:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Should be present if PGA pins are pin-strapped. Value corresponds to:
> +      0: Gain 1 (PGA1=0, PGA2=0)
> +      1: Gain 8 (PGA1=0, PGA2=1)
> +      2: Gain 64 (PGA1=1, PGA2=0)
> +      3: Gain 128 (PGA1=1, PGA2=1)
> +      If defined, pga-gpios must be absent.
> +    enum: [0, 1, 2, 3]

And I think this one should be in units of "gain".


> +  adi,clksel-state:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Should be present if CLKSEL is pin-strapped. 0 selects an external clock,
> +      1 selects the internal clock. If defined, clksel-gpios must be absent.
> +    enum: [0, 1]

IMO this one should be a string, options of "external" and "internal". 0
& 1 means nothing to a dts reader/author and needs to be cross checked
with the binding to obtain the meanings.

--tTB+zRNEZ6Rhy9nc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ5E5wQAKCRB4tDGHoIJi
0iBWAP9cunN3VZiL/VMCctFYc0GGl32jDAmBgTtgCfqjwBieqQD+OruD3WW4BaQm
IMdxGlmH2ViKldDq+l4neEa7erwlJQ0=
=JpYZ
-----END PGP SIGNATURE-----

--tTB+zRNEZ6Rhy9nc--

