Return-Path: <linux-iio+bounces-24571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2ABBAA32F
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 19:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9087A317C
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF06A21D590;
	Mon, 29 Sep 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKBlXwRH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8B19F13F;
	Mon, 29 Sep 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167606; cv=none; b=ZSaDCU4lAX1nBtrgQ6EbartAra1C48eWCo8o8KZf19/E56RODIvfUw4ST+z1evl951BzK3TwCU72xpWDcYVfn7YVjN/EbqRFFr/l7Ub8pa3EqKNXKUyx4jsRSLXnguB/TgBnI0AgdLSa+tj6q7ecqG901IjeGZk3aJB9Dr19m4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167606; c=relaxed/simple;
	bh=DussbqhLKrswcxrIlWjLtHAqSuuJZjymit0SUpL4FjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3jpZsnRr00ANmQf9LNzfTjkZ9wWxPuC0la2P6KykkyHxhRW9p2pmMhOXJ2ztX0f4tjXL4acOVSiRWeS2hJRdN1PDCjFY2tZ+0XytgTF0LzKTmu8XtCE6yaqcue3pvickh7n4GU/s+kjB3PbQ/TlQkISm42tammwZ1R88HZBuHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKBlXwRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C351FC4CEF4;
	Mon, 29 Sep 2025 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759167606;
	bh=DussbqhLKrswcxrIlWjLtHAqSuuJZjymit0SUpL4FjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKBlXwRHxX9p5/+ULGrEMOM8CkrEdINMCx6xgdOn2UhBXwXAeN5Re/9YVqOMNuqTY
	 Rq28+iqdC0QRwx3Z7u4jGOfb45OfKjWACZNU9OPK3IKG+PwQhAvckObF9u8T6r3Yda
	 rNeqoPkJu7gikJaErM1ZhNXImj2yHNYivsCQRgGa+wMyIAUA8YjhKmgd8+c8vbwqQW
	 g1a2taJr9eOjIm8Pgrmh647vpGa3mElah2NgcwmsJQNe/e4EMHJRg3azCaViWc+ni7
	 +Rds/lobxzob/YtaIha36y+8mc8zsP8UdnJgP8YJSMj992lFs1LeWHnt/bALwpiJgs
	 WehbT7xkINHmQ==
Date: Mon, 29 Sep 2025 18:40:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v12 1/3] dt-bindings: iio: adc: add max14001
Message-ID: <20250929-hatchery-borrower-82dbd352103f@spud>
References: <961e5351afa408e69541b60ec75852fbbd1ddd24.1759121938.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Wy073bv8O9ZEW09"
Content-Disposition: inline
In-Reply-To: <961e5351afa408e69541b60ec75852fbbd1ddd24.1759121938.git.marilene.agarcia@gmail.com>


--1Wy073bv8O9ZEW09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 29, 2025 at 02:58:38AM -0300, Marilene Andrade Garcia wrote:

>  .../bindings/iio/adc/adi,max14001.yaml        | 89 +++++++++++++++++++
>  MAINTAINERS                                   |  8 ++
>  2 files changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml

FWIW, odd to call the file 14001 when 14002 is the compatible that is
permitted standalone.

> +      max14001: adc@0 {

Drop the label, it's not used.
With those,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--1Wy073bv8O9ZEW09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNrEcAAKCRB4tDGHoIJi
0sAAAP9emijiH0IpSfrw1oFnZmP08veEuPOMeVlJHqKY/B5OgAEAlTg23hE5zmue
Ai74VhXlN/rGflo4BjDIsmNK1qASfAY=
=9M5D
-----END PGP SIGNATURE-----

--1Wy073bv8O9ZEW09--

