Return-Path: <linux-iio+bounces-26113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED25C44674
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 20:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3183018894FD
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 19:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9F224A049;
	Sun,  9 Nov 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4S99DiA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40E23AB98;
	Sun,  9 Nov 2025 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762717906; cv=none; b=aYNOfuV6N03a+CglZ5CgH2JM3ezvGLg6tTO0AkdwVpVOZA85HTOMmvei38Y8zEazfPwYWG0OFv8QeHoNWM5nR14IMOoK0ZUP3xsx/UcR3GpG/AUjF8oAbxg7gE6U4XwX+mmDeNQGdp5R/axDv1AXILy6j82mpJjIwJnrb57arB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762717906; c=relaxed/simple;
	bh=cpUCNfYH2ejYnsqjtHgdamX5IDnGs6bZ9FL6/y9aG30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dA2REj3P/fpbae8I9S0V761/NiNexgoYSk+BBn1mOs/9Vpy1ctgBon9qIw8VnyI5y44grWe27luS+H2Lj6WGS7bpswR/GdLj0u1ncDnn8Pvq3LqwsWjdGuR50qFcwQP4vQeGnZtKDpz6bSjEQ9lMuAOgpWEYUMb0avCPPxChaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4S99DiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D856C116B1;
	Sun,  9 Nov 2025 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762717906;
	bh=cpUCNfYH2ejYnsqjtHgdamX5IDnGs6bZ9FL6/y9aG30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4S99DiAKaOGJDoik1DlfliNsHNzBZouFg9TinauYhE7FygGD5TU8IA0oiHqw40eF
	 i5Burlyy3eonAcPCt9ng0cjWw/yBwVxp1mNCXcHpqpDKR1Ffk6pcXwqOVpUQFLTRB2
	 g1QhtkCcMz01sXTs+XFXnaje705mRcMiu3dwhlgbyoaKn4HeNrO+pYACcb4SdBXgMB
	 Xb5HUqAzyDiFm2nnP/IqvT+4PbCYH7bHdjE9h6ddlSpVyyEGMy6rnvqT8omk1hs9v9
	 dD+XLwywv5N9unWu2YRro3cGc2oDyZY94AuNLdV0XX/Plx/8BYfoQud7rEkYvDLNqA
	 17NMQhHU4lMaw==
Date: Sun, 9 Nov 2025 19:51:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v5 6/7] dt-bindings: clock: rockchip: Add RK3506 clock
 and reset unit
Message-ID: <20251109-udder-powdering-d3cdd425105c@spud>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
 <20251104-dev-add-ad5542-v4-1-6fe35458bf8c@analog.com>
 <20251104-mutt-spleen-31e1569f1674@spud>
 <20251109155757.087db448@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DSLUTbOwO1FjvFPQ"
Content-Disposition: inline
In-Reply-To: <20251109155757.087db448@jic23-huawei>


--DSLUTbOwO1FjvFPQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 09, 2025 at 03:57:57PM +0000, Jonathan Cameron wrote:
> On Tue, 4 Nov 2025 17:51:25 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > pw-bot: not-applicable
>=20
> Hi Conor,
>=20
> Strange email subject given you replied to:
>=20
> 20251104-dev-add-ad5542-v4-1-6fe35458bf8c@analog.com
>=20
> I'll assume intent was to Ack that.

Bug in mutt I believe, not the first time it has happened recently.
The rockchip patch did not get an ack from me, so this is where it was
meant to go.

--DSLUTbOwO1FjvFPQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRDwzQAKCRB4tDGHoIJi
0n4XAQDkQmiq+DmPmtwE9OARvgyyK1Oyv+mBupmkvhp8+S1N3gEAhGld1J6Qhqj4
AlS39Wf30DYlr3PHgDs6XoqJGnOnlQk=
=X0wo
-----END PGP SIGNATURE-----

--DSLUTbOwO1FjvFPQ--

