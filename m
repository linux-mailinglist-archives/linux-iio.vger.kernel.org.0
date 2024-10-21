Return-Path: <linux-iio+bounces-10882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F49A7021
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 18:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343761F21BCD
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F51E570F;
	Mon, 21 Oct 2024 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/dzPpI0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508E19939E;
	Mon, 21 Oct 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529564; cv=none; b=E9/nZni/jP4pfTAhHOn0xXcFHWOFQ29EMNlb0l0J30c+sgnOS/d0040x9VFv4q5ITuupO1JOOdihFc9gTMWjDw6hmcdF6pXpT2G+DypIZQsvTfnec3yZUu8+nB/gipa01FvMKkLY/3Pn6hogRBeuRpM943hTUoiX5HC03hMdZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529564; c=relaxed/simple;
	bh=pqXNyNGeM/0Hm4mgO7hEHXwOgAA/DyXeGAQoAQxRx0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpDhaVgrzX453LYrmodnZgsq3qLbgJ7MK9qNuMvtoTbErTmebE/Sviic2pQCXNRP6wrWFgwmqkAkQHpE5UGth0PsYZd00rTV0xjkTAkrnCBUQ2/miXHR5Bqg6XFBvkF33s97fi6/ijKxad5AoJ1A2An6h791vsOCuNAaE/m3+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/dzPpI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C4EC4CEC3;
	Mon, 21 Oct 2024 16:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729529563;
	bh=pqXNyNGeM/0Hm4mgO7hEHXwOgAA/DyXeGAQoAQxRx0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/dzPpI0bDdRiH/hHJdv0VBLV9hgOy0lv8c29r75uz3JY5zua2i7r9D1nRZGVEwNX
	 DVkrMTMkQQ+WTfSyagJkP5PDOoaiudSrXcB6bYr94FFWpDf/BX7nVmxF+8IBTXDSdx
	 CCkVJUHqZ/lYdOHpQqRRJzHlGrjpAUNaBpfRa3bWZWM8XA/8Ss9xXIT+/+Pg6uQJkw
	 HUb1jGWPCapG6gYidgplUV3ODongYBVLe+SQOBLt9GYsbOb2IyPo775FWSUgtrUwDR
	 BkfCAsbYwEYpPsXvfCDh3J9mOIjG9YtRyZteWrY1M96RVNTxIe5YO4w4i0pbFJM3/e
	 EQ40sNTsxazeg==
Date: Mon, 21 Oct 2024 17:52:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com,
	gstols@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: adi,ad7606: document
 AD760{7,8,9} parts
Message-ID: <20241021-shading-overeager-dd0a6c15c672@spud>
References: <20241021130221.1469099-1-aardelean@baylibre.com>
 <20241021130221.1469099-6-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V0fED2AYWKWHQzGl"
Content-Disposition: inline
In-Reply-To: <20241021130221.1469099-6-aardelean@baylibre.com>


--V0fED2AYWKWHQzGl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 04:02:20PM +0300, Alexandru Ardelean wrote:
> This change adds the AD7607, AD7608 & AD7609 parts to the binding doc of
> the ad7606 driver.
>=20
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--V0fED2AYWKWHQzGl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxaG1wAKCRB4tDGHoIJi
0mxcAQDqZH7gXVcWJZX4GK91lOWZWF7EDMqAYTianX0lSrIdgQEAxw3RagPqqx3c
GxwiEdmEXeMP+hMyI1wXSupZoeof9wU=
=e3L9
-----END PGP SIGNATURE-----

--V0fED2AYWKWHQzGl--

