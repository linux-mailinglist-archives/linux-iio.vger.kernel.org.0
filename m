Return-Path: <linux-iio+bounces-19110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBE7AA975E
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313D4189EDC4
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56020266F1D;
	Mon,  5 May 2025 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X98v0qVg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7325DAF3
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458388; cv=none; b=HPnasCiJnA3tnAoCRLVq2EQilbuXkcWuF1m+7cjQtF4GlkT5bSIhMhFEawKbxv2g3CBqQRD8DxIT7Kjb+NUwjPWyZWipLJ6uRzix4G9jT5IeuKq2neUoZut1Er6ND8vGsc/TvzjDxXep7yzcgGzbYHulmOFLlaRuigZCwk3obcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458388; c=relaxed/simple;
	bh=PIJAMIlzuVEx8Oy/GVQ/PFolgX40DZqYqCEV38Xiktc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPdaJc+Q3lOWg7cPeF9cUdbNivMHQrF7a1eTWMDOLVZeBYEvjzWjEVf3/+QZfvexu0NnSKxpxJ8RAT48OeTAiZJei3JjxMp8GKraH9FB7+z1M0V5kPPHOwzcyriX7Fq7yst4/bicJqK2RX2noJcWfeXTI9n/UvKDVIFYV7nLoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X98v0qVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD1FC4CEE4;
	Mon,  5 May 2025 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746458386;
	bh=PIJAMIlzuVEx8Oy/GVQ/PFolgX40DZqYqCEV38Xiktc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X98v0qVgkLm1h+JFgjZFREsZ2qsn5C15tp1i3I0AP14bzdarexkYBA3if5wom4ZA4
	 SzygcJZJ5o5XDklrdzfftGl72PbYATfiKm5J9LxxNwblCLbmdbjJowbv+AHZKUe6ff
	 8FKcOZ+D80HPb/LMFiMu6NoxibW+yktvgZFBTVtq4vTEd5yrHQCeMAxMgpa6UMdmTX
	 Wk11/HPWwiWDuK2durETqyqxCb31Yu+aHnNNZtXZ65LVUkRv7DQk9khZFXZj8DjtVV
	 Se5THeHUMYkD7xbV7KuFVuKz21xt6NftGC/nB1NZheVaaw9FQTDMG72CMLPY22QqeJ
	 cRXnvr1Jb18vg==
Date: Mon, 5 May 2025 16:19:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bianca Costa =?UTF-8?B?R2FsdsOjbw==?= <biancalvao@gmail.com>
Cc: Bianca Costa =?UTF-8?B?R2FsdsOjbw==?= <biancagalvao@usp.br>,
 =?UTF-8?B?SsO6bGlh?= Calixto Rosa <juliacalixtorosa@usp.br>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: mmc35240: refactor volatile and
 writeable reg functions
Message-ID: <20250505161939.0c1b7662@jic23-huawei>
In-Reply-To: <20250426194135.244774-1-biancalvao@gmail.com>
References: <20250426194135.244774-1-biancalvao@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Apr 2025 16:41:32 -0300
Bianca Costa Galv=C3=A3o <biancalvao@gmail.com> wrote:

> From: Bianca Costa Galv=C3=A3o <biancagalvao@usp.br>
>=20
> Refactor 'mmc35240_is_volatile_reg' and 'mmc35240_is_writeable_reg' as th=
ey
> share similar logic, returning the inverse of each other.
>=20
> Introduce a new helper function 'mmc35240_reg_check' to generalize this
> behavior, which is then used by both 'mmc35240_is_volatile_reg' and
> 'mmc35240_is_writeable_reg'.
>=20
> Signed-off-by: Bianca Costa Galv=C3=A3o <biancagalvao@usp.br>
> Co-developed-by: J=C3=BAlia Calixto Rosa <juliacalixtorosa@usp.br>
> Signed-off-by: J=C3=BAlia Calixto Rosa <juliacalixtorosa@usp.br>
Hi Bianca, J=C3=BAlia

The patch is mostly fine but I think the naming as
_reg_check() is not helpful as it doesn't indicate anything specific
is being checked.  I think ti would be cleaner to leave _is_writeable_reg()=
 alone
and them make the implementation of _is_volatile_reg()

	return !mmc35240_is_writeable_reg(dev, reg);

Which will effectively document that all non writeable registers are volati=
le.

Jonathan

> ---
>  drivers/iio/magnetometer/mmc35240.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetomet=
er/mmc35240.c
> index e08a57cd6de2..07f58567e521 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -418,15 +418,14 @@ static const struct iio_info mmc35240_info =3D {
>  	.attrs		=3D &mmc35240_attribute_group,
>  };
> =20
> +static bool mmc35240_reg_check(unsigned int reg)
> +{
> +	return reg =3D=3D MMC35240_REG_CTRL0 || reg =3D=3D MMC35240_REG_CTRL1;
> +}
> +
>  static bool mmc35240_is_writeable_reg(struct device *dev, unsigned int r=
eg)
>  {
> -	switch (reg) {
> -	case MMC35240_REG_CTRL0:
> -	case MMC35240_REG_CTRL1:
> -		return true;
> -	default:
> -		return false;
> -	}
> +	return mmc35240_reg_check(reg);
>  }
> =20
>  static bool mmc35240_is_readable_reg(struct device *dev, unsigned int re=
g)
> @@ -448,13 +447,7 @@ static bool mmc35240_is_readable_reg(struct device *=
dev, unsigned int reg)
> =20
>  static bool mmc35240_is_volatile_reg(struct device *dev, unsigned int re=
g)
>  {
> -	switch (reg) {
> -	case MMC35240_REG_CTRL0:
> -	case MMC35240_REG_CTRL1:
> -		return false;
> -	default:
> -		return true;
> -	}
> +	return !mmc35240_reg_check(reg);
>  }
> =20
>  static const struct reg_default mmc35240_reg_defaults[] =3D {


