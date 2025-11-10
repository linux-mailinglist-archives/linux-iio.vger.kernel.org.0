Return-Path: <linux-iio+bounces-26152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CDDC48EB7
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 20:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71DF34F2C9A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 19:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FC132A3DA;
	Mon, 10 Nov 2025 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8BofuqZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C323ABA1;
	Mon, 10 Nov 2025 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762801650; cv=none; b=FbgZy14Kg/YHka6c00NKdbNrP/5DiV9zxtEYre1oVjoONzVtZPjhlZYKaLGAGLH7kqkcoD528GEEzDVtl7fiMHOtg3kxi26legN3aAC3l3XQkpWONrVqGXc2MumDWJJJ8sLLXTizWHPRzmaS8UqwdVozNp4g0L80M6F2A4vX5js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762801650; c=relaxed/simple;
	bh=gdMPSWFUx6fQxjEeg88AQCpfbokaGBVOZ3O5cWM3Xts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O97/1+VOtg0iqj8tFRGgJutaz5I5Ce3D+ZLZZLjyynMJu/k8asnXC+vtu1pcJom9En09Fw9aHKi4yQo7TfSxVMDJq+aDCpR+hmF64/yAHO391lYZBsUbQpjaLIAhHXFKUAxoMD3w6QiQhZoWl1McxO8eOTtQDVJ6llo41Lmv5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8BofuqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C83CC4CEF5;
	Mon, 10 Nov 2025 19:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762801650;
	bh=gdMPSWFUx6fQxjEeg88AQCpfbokaGBVOZ3O5cWM3Xts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8BofuqZKxDxoVpIR4gMTKkobJ7QaF6zjZmN6oY9SWF1wnk3/nUCO1tVsXHeGeRu3
	 F8X5wlX4tqmRBbxbMVAvXkz5zzDMbvTIo9BI5sLSbYTSv2tuNsLGo8Ky43OPPtdkqx
	 bzrxwtuJFOFNKz6DcFe74hc4sRkm2fwFcgSRHFBjA0SKyca0TRKg/6O6yIzfpGSmsp
	 7Xfec9U7HeRxJNJw/SLCR/YNxLf9+lcEPB4j8mZ7jpGKc5PIshX66ozUMceiWF/K8p
	 0cpkNLprCSxaElJekdx2syr7EMObMmswk3KPNzEVvUwVnVVTJXAz+xUEg5xQC9ngbc
	 hPzOHcsqMvJog==
Date: Mon, 10 Nov 2025 19:07:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	cosmin.tanislav@analog.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: Add AD4134
Message-ID: <20251110-unsightly-blah-410539e95a18@spud>
References: <cover.1762777931.git.marcelo.schmitt@analog.com>
 <608ab00821af9f766c75d88f59940fed87cb6df7.1762777931.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rJNX4uVi5xG0GC+z"
Content-Disposition: inline
In-Reply-To: <608ab00821af9f766c75d88f59940fed87cb6df7.1762777931.git.marcelo.schmitt@analog.com>


--rJNX4uVi5xG0GC+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2025 at 09:45:18AM -0300, Marcelo Schmitt wrote:

> +  adi,control-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Describes whether the device is wired to an SPI interface or not. The

Can you explain how you don't automagically know this from what bus
you're on?

> +      PIN/SPI pin on the device must be set accordingly, i.e., PIN/SPI must be
> +      set to logic high for SPI Control Mode, low for Pin Control Mode. When
> +      absent, implies the SPI interface configuration.
> +    enum: [ spi-control-mode, pin-control-mode ]
> +    default: spi-control-mode
> +
> +  adi,asrc-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Asynchronous Sample Rate Converter (ASRC) operation mode control input.
> +      Describes whether the MODE pin is set to a high level (for master mode
> +      operation) or to a low level (for slave mode operation).

I don't really get this one. If this is an input to the device that
controls behaviour (master v slave) why is an option needed too? Clearly
this is not a gpio but it seems like it could be one, in which case you'd
need some sort of asrc-gpios property. Is it not possible to read the
value of this setting out of the device's registers (maybe it's not when
there's no spi interface connected?)?
It's not used in your driver, so I can't look there easily to see what's
going on.

> +    enum: [ high, low ]
> +    default: low

--rJNX4uVi5xG0GC+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRI37AAKCRB4tDGHoIJi
0jIVAP9dkrrgzG/cSA6tOhSgQaiGaYLQh5ZGJauZzUJXnSJVPwD8Dugs/GOYERvs
j5eJjvifsUN8QWWVuP2JQLxEV+Jnug8=
=nHVh
-----END PGP SIGNATURE-----

--rJNX4uVi5xG0GC+z--

