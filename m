Return-Path: <linux-iio+bounces-20064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 495DDAC9B6A
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0412F17C3AA
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 15:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042F7238142;
	Sat, 31 May 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htyzh90e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F5E213E78
	for <linux-iio@vger.kernel.org>; Sat, 31 May 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748703970; cv=none; b=SgkrRY67Bf/ScJ8A4y7jN+6j59FnyAo4reyRpvhZ6XG9r6+CGuflsF8TvgxWhVuHMhD3XSghiXngAQFafk8xNFVZ1uefTLORpt/ON1LvKKqFMnGw1xLbYC259Nm0LQVlva5sTpgJZGigH6596IRCzlW22SRPI2iZ8EXgz0Jr8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748703970; c=relaxed/simple;
	bh=dBCium7s7Enp2jcjtvEvAYZ6JxBNUv9vNzPHEymw7Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rc7fYeJ4NLo1Nzd+K59NLAsIHfAaqciX8q6iQIGrbb45G00t6e3J9VRNtYCPvXg3ZXSs6y8VoZIgVpGQf8++5QmOWta6pKVD/H0Rtj97n+JfHM5U93qYHj0TGVeID6Z3TttB8FVPgI/fMOFtLCOSH46IYvFmaNdW4ubR2Wq+xrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htyzh90e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8030BC4CEE3;
	Sat, 31 May 2025 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748703970;
	bh=dBCium7s7Enp2jcjtvEvAYZ6JxBNUv9vNzPHEymw7Q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=htyzh90eXcS40vfiCiFR+PNJCXokPXsdkSDAIIkEMCR08FgnSRvq8pORoVm29aFc5
	 P8q2P5r/tYKlu1JI6FBfnB/KSb0B4jfbfviViXc3aoYVhyc891w2BsfNy23CuXFsNM
	 fk+fJxU9SU23oj/6O8Gq+/MVHXBuEGYn9Sl6nu/HAMZa4ydGXRIWLgEMrdGbKhVk+3
	 lx+jwf6ogpSP6rS5orRsos2pWitu10zhawEtLzgM6AfnUtBTkIQJIb2bGCF1Mdazzr
	 k8TDoeQ63W0GD9Ozld2pygUdf/a9EboC0rRxS08JhGyQsHgRiesXecqbqPv5dLjxcP
	 p63p1n4bqTU1g==
Date: Sat, 31 May 2025 16:06:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bianca <biancalvao@gmail.com>
Cc: juliacalixtorosa@usp.br, Bianca Costa =?UTF-8?B?R2FsdsOjbw==?=
 <biancagalvao@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: mmc35240: unify reg-access
 predicates
Message-ID: <20250531160604.1bd97711@jic23-huawei>
In-Reply-To: <20250526120340.16880-1-biancalvao@gmail.com>
References: <20250526120340.16880-1-biancalvao@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 May 2025 09:03:30 -0300
Bianca <biancalvao@gmail.com> wrote:

> From: Bianca Costa Galv=C3=A3o <biancalvao@gmail.com>
>=20
> Refactor the two complementary helper functions
> `mmc35240_is_volatile_reg()` and
> `mmc35240_is_writeable_reg()` by implementing the volatile predicate
> as the logical negation of the writeable predicate. This removes the
> duplicate bit-mask checks and makes the intent clearer.
>=20
> Changes since v1:
> - Removed the obsolete mmc35240_reg_check() helper.
> - Wrapped commit message and body to 75 columns.
> - Fixed indentation in mmc35240_is_writeable_reg() to use tabs.
>=20
> Signed-off-by: Bianca Costa Galv=C3=A3o <biancagalvao@usp.br>
> Co-developed-by: J=C3=BAlia Calixto Rosa <juliacalixtorosa@usp.br>
> Signed-off-by: J=C3=BAlia Calixto Rosa <juliacalixtorosa@usp.br>
> ---
>  drivers/iio/magnetometer/mmc35240.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetomet=
er/mmc35240.c
> index 07f58567e521..6cfb89295802 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -418,14 +418,16 @@ static const struct iio_info mmc35240_info =3D {
>  	.attrs		=3D &mmc35240_attribute_group,
>  };
> =20
> -static bool mmc35240_reg_check(unsigned int reg)
> -{
> -	return reg =3D=3D MMC35240_REG_CTRL0 || reg =3D=3D MMC35240_REG_CTRL1;
> -}
> =20
>  static bool mmc35240_is_writeable_reg(struct device *dev, unsigned int r=
eg)
>  {
> -	return mmc35240_reg_check(reg);
> +	switch (reg) {
> +	case MMC35240_REG_CTRL0:
> +	case MMC35240_REG_CTRL1:
> +		return true;
> +	default:
> +    	return false;

Indent is incorrect.  This should be two tabs in but it is in spaces.
Please run scripts/checkpatch.pl over your patches before sending.


> +	}
>  }
> =20
>  static bool mmc35240_is_readable_reg(struct device *dev, unsigned int re=
g)
> @@ -447,7 +449,7 @@ static bool mmc35240_is_readable_reg(struct device *d=
ev, unsigned int reg)
> =20
>  static bool mmc35240_is_volatile_reg(struct device *dev, unsigned int re=
g)
>  {
> -	return !mmc35240_reg_check(reg);
> +	return !mmc35240_is_writeable_reg(dev, reg);
>  }
> =20
>  static const struct reg_default mmc35240_reg_defaults[] =3D {


