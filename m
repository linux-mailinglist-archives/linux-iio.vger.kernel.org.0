Return-Path: <linux-iio+bounces-6509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E6B90D6C4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 17:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9E1B263EA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F058A1CD20;
	Tue, 18 Jun 2024 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBn+y6qV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B018C22;
	Tue, 18 Jun 2024 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723259; cv=none; b=heEhWFd9p/tFZMPd1AdvqXbG1/BOhYJKkaO3/oLKQFkJWpsp6c4t7u4VUoQ/kw0fE7VJ5YlUATm02AsB0w3AelCyv43Cg/nPOQX7RnXkbGS/4yJ+HjNmZeIFaPp+2ooJzjlIrxGzsGuVeoVsKx03x14Dxmqkhp0/xQZQRoyAMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723259; c=relaxed/simple;
	bh=+IisjZ/vwsQQqOhs55PDsJvjMV1+QCnMyVuLEP0+W3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/0x7wrVB3rFAKz/jzERZ/CK0rQ2Fyyf5On6f95pwh0p7JG17vgEjfFPm5gzKcTdZ/6IwcipLfwM1NEnkTd21NdbsHwoV7l6kRLmtLeFdcZuZHbGVi44WEN1eI850FL5Pl3Ae6I/7o+5aez9Q4bJFdbsEzGE9Ov8PHnyFs2wd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBn+y6qV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D87DC3277B;
	Tue, 18 Jun 2024 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718723259;
	bh=+IisjZ/vwsQQqOhs55PDsJvjMV1+QCnMyVuLEP0+W3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBn+y6qVIcXviQNpCAyo4OzNFOKjQ8ZtnoAmRCN7NYXTl7ai+K/7wx1hUeIhKuhbM
	 R19Ff+RTpp+QPbVD4gOtRGSZ4llSCrm9TtfBfUvJiaBQxTEZ9BytLLMBfTO0NvBX8W
	 nWMAvvSjJ5HlHz4FCv3BzjZ2AAjWkUvhpCQjlLuV7BjD3gyV7/iOybq27KcYAeCB0B
	 2wxaq6BmWLR3mHCXCkQGoY76WfrbBaxk2zD84dPHyCGP5ZNFUU7xrErD2JPLKt2lKz
	 Ywdt4mhsTOQe0/cUHqi7EqOCVrD49gLkeDceOj4B8yYNrUyQ48fe4wLQjXKJqeWftP
	 t7bZYqYauHxkQ==
Date: Tue, 18 Jun 2024 16:07:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/6] dt-bindings: iio: adc: ad7192: Update clock config
Message-ID: <20240618-crushed-courier-87d55930c377@spud>
References: <20240618142138.520192-1-alisa.roman@analog.com>
 <20240618142138.520192-3-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KAga6Hd/EkXMCEbV"
Content-Disposition: inline
In-Reply-To: <20240618142138.520192-3-alisa.roman@analog.com>


--KAga6Hd/EkXMCEbV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 05:21:34PM +0300, Alisa-Dariana Roman wrote:
> There are actually 4 configuration modes of clock source for AD719X
> devices. Either a crystal can be attached externally between MCLK1 and
> MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> pin. The other 2 modes make use of the 4.92MHz internal clock.
>=20
> To configure external clock as either a crystal or a CMOS-compatible
> clock, changing the register settings is necessary. Therefore, add clock
> name xtal alongside mclk. By selecting one or the other, the register is
> configured.
>=20
> The presence of an external clock source is optional, not required. When
> absent, internal clock is used. Modify required property accordingly.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--KAga6Hd/EkXMCEbV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnGitgAKCRB4tDGHoIJi
0k4iAP4+h+s4TpgwEVQfUaCwVH0YiL3KWHazuBDJTtBRyaFsKAEA7yXZKkZ1UDgT
zC+Yor9D5dTaftVPsPNLyCSrtvH79gA=
=VLUD
-----END PGP SIGNATURE-----

--KAga6Hd/EkXMCEbV--

