Return-Path: <linux-iio+bounces-13683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B26FA9F83B7
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 20:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4C51892ACF
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D84C1A7255;
	Thu, 19 Dec 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap2SJQsQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3644619C54A;
	Thu, 19 Dec 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634798; cv=none; b=h86D0gMYWR1/GJc48nAmJXEXyZ5kFpduKxZwsSavodwNnF+2hzuzsWqxbyu9Dq5195gVmxKv+2SdqC+IVdzLfndxp+9OWYlAlDCQb+4b8lC1eacl2JgIqK5acYhoIyXV5KM8i2QVTe7Nt6xV+9BWMJvoiLMgdFgtgqEOcVNAawA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634798; c=relaxed/simple;
	bh=+TdrP3/6V8zyQ+1lR+s4OOeOSOzX0c0bzyK+3XyjA/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVG6YH+QS/L9LMeRV1bQ9LmWJ/t/3FI9iW4TedTsaG+nmmq1AtYG/2YBF7xa9ogGi0HoMDsabBUnHKVjJvMzfF1nvK2y8s4AyLQ7TbIOAH1LTHxBDxpJi/dxnASUR7oX5wpDJ7FqGc7TjEfvjEzAJAgSY/3HSSyqVnA8IlFH+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap2SJQsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A7BC4CED0;
	Thu, 19 Dec 2024 18:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734634797;
	bh=+TdrP3/6V8zyQ+1lR+s4OOeOSOzX0c0bzyK+3XyjA/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ap2SJQsQPD01KPGCSz/lpbdwcqDNiF7EGo/P0vGfYtuGyepN0vt12y2+z4HyQVI60
	 DT8Mz/7WdWf7GHSoMAP2P8OmLYAgDWpLZG1AzuiFbd/f6CAuuiVkGmo3b8FVvqUhqU
	 Nf4Z+nUdhe+M0PedAj+fPZOwiymrdZUMl5r+jrRasfGERkMpM/SOZVgrLAiMev/zhK
	 eg0iZWcQgxwcfmI9utqNghDaOKHMacx33/pY8F2nFC6zFr0ldHz8cYYyK9jE6WmT5p
	 zNYmDRVP1J5UZMZeOEghaxTpk2+MMGs8v8AdbTtOo9gTosUSrLjnNy4KBsFW75XDXw
	 HrmQGJ3WU8w5Q==
Date: Thu, 19 Dec 2024 18:59:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: Add ROHM BD79703
Message-ID: <20241219-acts-glare-2bc1e723ab20@spud>
References: <cover.1734608215.git.mazziesaccount@gmail.com>
 <51ed31c494ea7385940b59500e8592d12558e291.1734608215.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EETjA5D7Rh+of6WR"
Content-Disposition: inline
In-Reply-To: <51ed31c494ea7385940b59500e8592d12558e291.1734608215.git.mazziesaccount@gmail.com>


--EETjA5D7Rh+of6WR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 01:39:11PM +0200, Matti Vaittinen wrote:
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        dac@0 {

nit: should be a blank line before the child node.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +            compatible =3D "rohm,bd79703";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <30000000>;
> +            vcc-supply =3D <&vcc>;
> +            vfs-supply =3D <&vref>;
> +        };
> +    };
> +...
> --=20
> 2.47.0
>=20



--EETjA5D7Rh+of6WR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2RtKQAKCRB4tDGHoIJi
0swJAQCZDDc3m1K/PMjIv5pf5exwDIuARnLOQ74G+TzxQg8bNAD+OlIqF3c+9R09
xXtsmJ3Te/vCXwJzP8X7ZKt7Wv3UMQ0=
=kchy
-----END PGP SIGNATURE-----

--EETjA5D7Rh+of6WR--

