Return-Path: <linux-iio+bounces-19042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D098AA874D
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850FB176923
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4BA1CDFAC;
	Sun,  4 May 2025 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRUS8nEO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A393A32;
	Sun,  4 May 2025 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746372528; cv=none; b=L9IFj91BG+n8mZhMbpD4Y/3prjV1ZAv1IhLGMQ0qUi4zvJ/9j8lNGv5be2pZ2khL4vCyfR035wZieg9Vsvp/fp+PljQJ9rk9RoguuxrvDFb3/psOdKUCmXJ7AfnZRq+xcQM1u7EBwvEoQ1+PD06RLA4CDwcBENHKSWhvOozTUPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746372528; c=relaxed/simple;
	bh=UbJVHEaWD77LSZDnCEqT67cMDLT3M9vSbOHoVsnCzG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPog4ByEzrNgswQgEh/nZaW4+jy/HRCpS+U7uE+v+LJ59SWraDEz2uWFyacGMcb4ko3aBcrgGFb5YImLpGd9VHLadzHbdXJsS47Vz9zxVCoMdavmWx94y3kC71THeedQXHpNGFBG2VPO8u8UdHOwaZMRJHyMabge4mG1bk1/9rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRUS8nEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4215C4CEEF;
	Sun,  4 May 2025 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746372528;
	bh=UbJVHEaWD77LSZDnCEqT67cMDLT3M9vSbOHoVsnCzG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SRUS8nEO/KsyEgxDk2M534jyW+nY0O9s+BxsBSe7d944VZFN9Da5FV8CIVR/jhBvR
	 z/RTzxzG8jFY1ejD4406CeD/EQzRMaTjTeO7OYoKSRJ5L30OvikiyLCJ5t9dctu72L
	 VVyoQtAQfwFtSx97z9zVBUrsEjy8lQBCX1Imef7zpHwAmIqd1XR3iagBQS+1hPHjTS
	 o++vXCPACDubAyt1nwSZqmy1sjAKxjdMWM5PFgR9hd0uWjNmdLmOOTjAy0zz426vOT
	 JVdCa1Lz4lxK4oT/CcKmTHlDdGEPacjDXdL+GtnPESym5lz0bRv0jYW5xaW6yegEgR
	 V/F6RdSG2HQSg==
Date: Sun, 4 May 2025 16:28:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jean-Baptiste Maneyrol
 <jmaneyrol@invensense.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: Fix temperature calculation
Message-ID: <20250504162841.3a3cfe8a@jic23-huawei>
In-Reply-To: <20250502-imu-v1-1-129b8391a4e3@geanix.com>
References: <20250502-imu-v1-1-129b8391a4e3@geanix.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 02 May 2025 11:37:26 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> From the documentation:
> "offset to be added to <type>[Y]_raw prior toscaling by <type>[Y]_scale"
> Offset should be applied before multiplying scale, so divide offset by
> scale to make this correct.
>=20
> Fixes: bc3eb0207fb5 ("iio: imu: inv_icm42600: add temperature sensor supp=
ort")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Looks correct to me.  Given this is going to have impacts on userspace
I'd definitely like to know Jean-Baptiste has seen it though before I apply.
So, Jean-Baptiste please take a look!

Thanks,

Jonathan


> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_temp.c
> index 213cce1c31110e669e7191c8b42c9524c0d3e5db..91f0f381082bda3dbb95dfe1a=
38adcdc4eaf5419 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> @@ -67,16 +67,18 @@ int inv_icm42600_temp_read_raw(struct iio_dev *indio_=
dev,
>  		return IIO_VAL_INT;
>  	/*
>  	 * T=C2=B0C =3D (temp / 132.48) + 25
> -	 * Tm=C2=B0C =3D 1000 * ((temp * 100 / 13248) + 25)
> +	 * Tm=C2=B0C =3D 1000 * ((temp / 132.48) + 25)
> +	 * Tm=C2=B0C =3D 7.548309 * temp + 25000
> +	 * Tm=C2=B0C =3D (temp + 3312) * 7.548309
>  	 * scale: 100000 / 13248 ~=3D 7.548309
> -	 * offset: 25000
> +	 * offset: 3312
>  	 */
>  	case IIO_CHAN_INFO_SCALE:
>  		*val =3D 7;
>  		*val2 =3D 548309;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val =3D 25000;
> +		*val =3D 3312;
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>=20
> ---
> base-commit: 609bc31eca06c7408e6860d8b46311ebe45c1fef
> change-id: 20250502-imu-edc0faa6dae9
>=20
> Best regards,


