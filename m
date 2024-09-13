Return-Path: <linux-iio+bounces-9520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D6978741
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 19:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CF41F266CA
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A6385656;
	Fri, 13 Sep 2024 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tonB9dQk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76B79B8E;
	Fri, 13 Sep 2024 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250064; cv=none; b=FfoEBPSUm2YpoDQQWnp1UBXkYJjciWGm7Ut7lGDKqZYDW3iJRh/Al3pWHJG1+NG8EwuVrOK9ZTMPsctjfXs/frjkixcqdDuXYVnM2S3vS7uPWCrFa8HJbO+xNQ1jilaLK18W6KsMy7UgefcPEKrxPjnW6kVSCOawthnmwf4W6QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250064; c=relaxed/simple;
	bh=jWbhiLUcKqWQFU/Im3tjU43mzSy2oUxa2unp1sbQcmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az8kRj8RHqZXlrXT53MKn1G3lpmGeh885Io2vtieN/nvyp/ABGR9SlPxUpjNg7jlc8NMo+O9gn+iDvynICjDWuKnlESnUe5bUdjaUTmeNSUbtC5lJqfHADBURT0yauFUltpDnV0/SwY7RoyjefgaugyaMDVL4iDfKI5egIYu45A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tonB9dQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B5CC4CEC0;
	Fri, 13 Sep 2024 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726250064;
	bh=jWbhiLUcKqWQFU/Im3tjU43mzSy2oUxa2unp1sbQcmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tonB9dQkOKGOFVpWKBM6VU/AgQmpp1sxg0nD0Qqh+HyIhB41icueet53d7U3bqgsL
	 A8Cw9PKUvy/akQHPWDW74KILBUZ7iq5RhrHxDCvRVxpw/lniL4AXrYvSaXBSjpRDZ4
	 vzgp3tag/OuWjrEYjYxY3MOq0xOGE54IdO0xlFAtzaq2MZSMGEhrmzyQpZ/TWT0agS
	 8LRJNjz0scmU+CApaAGyVe/fvvyqcRK+AW6eBcPLWGQHmKGxln8AjIrYqczWptGbb9
	 +iCpsYHJOTLc3oO03yz3J8OfDrLyXeEQAQ4YKDwmhrPknLZcq8bFFtgvniMT9+KWnP
	 ohVaxZK1g/y0A==
Date: Fri, 13 Sep 2024 18:54:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Jianping.Shen@de.bosch.com
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dima.fedrau@gmail.com,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian.Lorenz3@de.bosch.com, Ulrike.Frauendorf@de.bosch.com,
	Kai.Dolde@de.bosch.com
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: imu: smi240: add Bosch smi240
Message-ID: <20240913-curled-cement-0434c7b56e17@spud>
References: <20240913100011.4618-1-Jianping.Shen@de.bosch.com>
 <20240913100011.4618-2-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AXiKi4ZW8chzwwN0"
Content-Disposition: inline
In-Reply-To: <20240913100011.4618-2-Jianping.Shen@de.bosch.com>


--AXiKi4ZW8chzwwN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 12:00:10PM +0200, Jianping.Shen@de.bosch.com wrote:
> From: Shen Jianping <Jianping.Shen@de.bosch.com>
>=20
> add devicetree binding for Bosch imu smi240.
> The smi240 is a combined three axis angular rate and
> three axis acceleration sensor module.
>=20
> * The smi240 requires VDD and VDDIO
> * Provides only spi interface.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

3 reviews? Doing well for yourself!

--AXiKi4ZW8chzwwN0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuR8SwAKCRB4tDGHoIJi
0rYhAP421mgiPxEooyVr0qa0SKv/HJnWIRqtrqEyUp3WPMZyQAEA9J2GdM5juRGy
23tBvqwM6eXl29w7HIln0TsNoeryiwA=
=wPVg
-----END PGP SIGNATURE-----

--AXiKi4ZW8chzwwN0--

