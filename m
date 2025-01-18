Return-Path: <linux-iio+bounces-14447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEAEA15CAD
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 13:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B6D1888E41
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA6618C337;
	Sat, 18 Jan 2025 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAMZowvc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9C13BADF;
	Sat, 18 Jan 2025 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737203103; cv=none; b=Ad3aH30iviQ0a29GEqFUE2yT0xDvjNdxkAsLDeDb+dDAMp4R/tbRtIpZ3L9mC6no4B7Q32fg2u/K4+0QaPIQnhXvlP05XGqNJGQgWvgO3XL65wRPQ/JblfmFtI3s6px7/XkxmBAiBCZweosUHn5u9QBhL5gT6WMmaOuZJLUBhsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737203103; c=relaxed/simple;
	bh=8bocchLEvBYJ1Ltc/vlXsJuW8LNfAxE97FasDuykO5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyefS+7gZmN3SvwIpVGb/jbiNg8z3Grlc7bWlwT1plg27jcmhicWJ1EkOudrAGzJy4d/1p+wVR5bhsRYhYmD1oc/mGfS3qQQSenpDXeD8fQ4MHSMUtBAV/O2yONlcEn74T0rynwT5y7bZ7wnJuQL4wKw45OIqyobe3UPmbo3isc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAMZowvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39640C4CED1;
	Sat, 18 Jan 2025 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737203102;
	bh=8bocchLEvBYJ1Ltc/vlXsJuW8LNfAxE97FasDuykO5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EAMZowvcHG/0QnVtB8HAXhdukl+/zrGQd67dqCZtF3J6wiQI12OBoWX5Eb/ursKDo
	 uG88Y4vLdZ9u2W8LT0hksXgWBn+P4DX1X5VhCFDV/0LYCfSnmpD99Ep8+jjo707Fnu
	 x8Bad3CZqZ6BxpMApKLgJ8fS8YjlWSi+8HNfpiqjj8LhnDahl5BliFz12tQGBOdD0N
	 NhQ96C4/1CW6SIaGMbeA2bsFBdVvyYMxCdcy7rtcegCnCAG5Ly+NMBiuTc0l3iHTMp
	 6LgrS750aNyDGWtVKxcqNSwAbWkWCSFNyIgoqwFe5S3MTyVJS2H9Y/B10GdDwfLoZX
	 Vnu2QSMvJ/BfA==
Date: Sat, 18 Jan 2025 12:24:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: apds9306: fix max_scale_nano values
Message-ID: <20250118122455.54c1e96e@jic23-huawei>
In-Reply-To: <20250112-apds9306_nano_vals-v1-1-82fb145d0b16@gmail.com>
References: <20250112-apds9306_nano_vals-v1-1-82fb145d0b16@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 12 Jan 2025 01:08:11 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The two provided max_scale_nano values must be multiplied by 100 and 10
> respectively to achieve nano units. According to the comments:
>=20
> Max scale for apds0306 is 16.326432 =E2=86=92 the fractional part is 0.32=
6432,
> which is 326432000 in NANO. The current value is 3264320.
>=20
> Max scale for apds0306-065 is 14.09721 =E2=86=92 the fractional part is 0=
.09712,
> which is 97120000 in NANO. The current value is 9712000.
>=20
> Update max_scale_nano initialization to use the right NANO fractional
> parts.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

This just missed last pull request for this cycle.
I've locally advanced my fixes branch to include all the material that will
merge in next couple of weeks, but for now can't push it out without making
a mess of linux-next (it will be in wrong place in the sequence)

So applied, but you can't see it yet!

Jonathan

> ---
>  drivers/iio/light/apds9306.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 69a0d609cffc91cc3daba160f309f511270be385..5ed7e17f49e76206609aba83c=
85e8144c536d17d 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -108,11 +108,11 @@ static const struct part_id_gts_multiplier apds9306=
_gts_mul[] =3D {
>  	{
>  		.part_id =3D 0xB1,
>  		.max_scale_int =3D 16,
> -		.max_scale_nano =3D 3264320,
> +		.max_scale_nano =3D 326432000,
>  	}, {
>  		.part_id =3D 0xB3,
>  		.max_scale_int =3D 14,
> -		.max_scale_nano =3D 9712000,
> +		.max_scale_nano =3D 97120000,
>  	},
>  };
> =20
>=20
> ---
> base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
> change-id: 20241218-apds9306_nano_vals-d880219a82f2
>=20
> Best regards,


