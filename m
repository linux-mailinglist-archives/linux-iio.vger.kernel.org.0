Return-Path: <linux-iio+bounces-6600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56C590F594
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 19:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6074B1F227B3
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 17:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B8715665E;
	Wed, 19 Jun 2024 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5jradRK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F081855884;
	Wed, 19 Jun 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819885; cv=none; b=n6y+sxuXQaUae1Bm6b72sUegMMhzmRgrhEU79EWtQTBXMteCKZxqexQvpfD+8cN2SgviQ3hv57eLx1IBGoSbgYn5+hGRf07eMB29kRXS6s/ijeBU79uqrIgkPF92vi6i1I2uxVC62kO7Ikhut2fK/Izkm1tlzRL1ZN6fElEWVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819885; c=relaxed/simple;
	bh=dulOfWapq1riowFzarPIjt0FGEvDfAqz4NvXyqMk3Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gt1gX+ISJsoNVO2sNXbwFojJBO1ZG/1xp5rm32KAeRqb5KpLLuxFdvfRpSsMnsNetRIR+0Ki8R3T/oclxdIAjkmxsg34A2jQ3jelIegJ3838ApAvEp1dIeAeTjNzku/D/W/EqiYCIX+CgVgZhjjgnsD96VQJc2/FqQ2csHbCK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5jradRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF24C2BBFC;
	Wed, 19 Jun 2024 17:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718819884;
	bh=dulOfWapq1riowFzarPIjt0FGEvDfAqz4NvXyqMk3Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5jradRKDOYlJ4oZTE2K1yTJ0Rdb7pnd578crjSaPs2mJnivr2VUHx9pcfhZsonF4
	 pWdZDIA+7zWq9kBxRUfa0VrbfORmXynK19G0Hf/rO2h3jFCRj8zxmDbum24diV0FNM
	 vKt8BG+IWQOUAtoyQVEx7XZT0MbPG2hohh4FPN5SkmxIwnZVyamJwe5Bksau9G/yvS
	 FmFDw8VC2XzRRrHbKtilfwkZGDAqXxCRfZ3oMt7IYUvHvYjVcW1rhJOVz72CLSjh2D
	 jVlOWsklDxEK4ShTgmJk73t+4wWuWRcPPFQJslWVToDneMw/imTBUcGoPXz7qae3s2
	 zne6RXXH4tQmw==
Date: Wed, 19 Jun 2024 18:57:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Message-ID: <20240619-vanity-crowd-24d93dda47b8@spud>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
 <20240619064904.73832-5-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VZs3U0EDq8+3ekdN"
Content-Disposition: inline
In-Reply-To: <20240619064904.73832-5-kimseer.paller@analog.com>


--VZs3U0EDq8+3ekdN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 02:49:03PM +0800, Kim Seer Paller wrote:
> +patternProperties:
> +  "^channel@[0-4]$":
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel number representing the DAC output channel.
> +        maximum: 4
> +
> +      adi,toggle-mode:
> +        description:
> +          Set the channel as a toggle enabled channel. Toggle operation enables
> +          fast switching of a DAC output between two different DAC codes without
> +          any SPI transaction.
> +        type: boolean
> +
> +      adi,output-range-microamp:
> +        description: Specify the channel output full scale range.
> +        enum: [3125000, 6250000, 12500000, 25000000, 50000000, 100000000,
> +               200000000, 300000000]

IIO folks, is this sort of thing common/likely to exist on other DACs?

--VZs3U0EDq8+3ekdN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnMcJwAKCRB4tDGHoIJi
0qTHAQCIBJ6P9QySiAd2lvBBP8TytzaivOaDJCPxiSOpB2GEeAD/amMaLYjHrHTI
cN0HQsmvkMOJOJv0w/QSOQjlkK4yQQ8=
=RET4
-----END PGP SIGNATURE-----

--VZs3U0EDq8+3ekdN--

