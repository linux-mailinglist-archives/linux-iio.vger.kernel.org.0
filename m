Return-Path: <linux-iio+bounces-12785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30259DBBB2
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 18:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5721028168D
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBFF1C07DF;
	Thu, 28 Nov 2024 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faertAD/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5B211C;
	Thu, 28 Nov 2024 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732814301; cv=none; b=Xy96Tb3GSM2oPV9Pwu0VdgJHel7xXiMaVv046+0fhjI3YDDWMD78ilF5vbWgXzJjrwfqjDCP3K3KbaT+WSX2Bue18raRenBeX9RJpdU4hNU3bSo1AQaDpR9Cs1y8qQnuPxK6jkB+0hDH64XEfftsJG+24h0Io3uhsmjoIwovhZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732814301; c=relaxed/simple;
	bh=qA90LVanfI9jDZsIFcUFMXN7NM3/WoSq4iNlLPPXGkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln4y26ny4zJs+litacINc3LJEjtms/0eXRDdEO1kmCfx6OJXRjEjEFVLbEF0Bvk/mBaOcYOLJ22etpwY1ZiIXXqPD9J7TWOY7pjgCi17yHpqxLkOkMqM2UnYJnKUiejeJQAcRkSRAFRG7WCjbGDeid66rNasIlczbPmjbLAMTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faertAD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0CFC4CECE;
	Thu, 28 Nov 2024 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732814301;
	bh=qA90LVanfI9jDZsIFcUFMXN7NM3/WoSq4iNlLPPXGkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faertAD/RcXTQfBjyEZV19YesmMcV+IXEwqHY8NgGvVXeKxwkl4rdRk1lbXSf7UT0
	 nX9mpzjd48bQimGLJNf7mVZB3SPTvgUfKAnpdhkdlE/vkUoP4l9SP+eHEELdpSND4f
	 fsD11BPpELB6e9Gkl5kxMakbA58vYA82hr6TYV6vZbVQmAvsqdXUb+0kvExUYLb+pN
	 6ZrE15u8NGMoRPQgwnRjRdJMVdJtvW5aS51FiAvW3Gzn9ozFxGiA8R9TmxfHoq8rQY
	 DmtEliViW14urDhJkUtdVLRUDwLHZW63V5RKswzz1JOfA92564ETVPc/Lhsc+dbSLr
	 Cp8hF/DT7PhLw==
Date: Thu, 28 Nov 2024 17:18:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: ad7192: Add maintainer
Message-ID: <20241128-sappy-harddisk-5e65ffc3be5f@spud>
References: <20241128125811.11913-1-alisa.roman@analog.com>
 <20241128125811.11913-2-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kfb9eJeXP+/tgEsR"
Content-Disposition: inline
In-Reply-To: <20241128125811.11913-2-alisa.roman@analog.com>


--Kfb9eJeXP+/tgEsR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 02:55:01PM +0200, Alisa-Dariana Roman wrote:
> Add myself as a maintainer for AD7192 devicetree bindings.
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Kfb9eJeXP+/tgEsR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0il2AAKCRB4tDGHoIJi
0rmHAPwOfa5STeC0585dFIMMQfmu9WrsDxN4bTqLpdJc8sbjCgEAlYyU+5nweAIO
vHALCqu8O64HJIso8MahE8hs52MeSwo=
=f4Dz
-----END PGP SIGNATURE-----

--Kfb9eJeXP+/tgEsR--

