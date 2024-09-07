Return-Path: <linux-iio+bounces-9304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C91970353
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 19:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 475D7B220D7
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5B5165EE1;
	Sat,  7 Sep 2024 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM6OgsaI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051F15ECD7;
	Sat,  7 Sep 2024 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725729544; cv=none; b=cO663FTowQGa+xHzoi60oxIB/+JsRFTK7RLLgTcHlY5NdEmwqE19lJOxLxNztHOO6b2Avd4d42Ne/lIa1VgQvej8+MfIvr5W6E8FyWOBuhbIurQ+Eb+A3GRDZdJKA9bScCPiP9ztcHTwcdKwTlQ0HGd+upUm9kG9h0O1olwxOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725729544; c=relaxed/simple;
	bh=bvFB2XXvjdM+ZXXqgnzKkdPk8ExVd44b9X43rt827Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZELPfI37h1Mcq28X1lp/zTyHblUfcbA12f8kB4u8TLl9mJlX9v6BSSgvoJjqiYZVhUbNfzTAjzGbhnbqYm9vTkgOf8MSM0LyfElF0ISE9SToUP92mhi1NdSIxgaBYijKHLMz78a1lKWSDaNm+vHRoa+xTCwQqnEHY+f2Ez3Vsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM6OgsaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEFCC4CEC2;
	Sat,  7 Sep 2024 17:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725729543;
	bh=bvFB2XXvjdM+ZXXqgnzKkdPk8ExVd44b9X43rt827Iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UM6OgsaIFHTvvRjUTzslkDN4QdJ1NDpRD02DSXg8+6OF6YAJMO/vq96i/D3i4sVlF
	 6wRE+3hHc9b1cHvJZgpgzG+E9UoYTbd3umd/zX52E3o+CoXwDXdtEwEDAiPjlerAB9
	 G4yoVBA7n5t8IGpVyjZ+bpHgii9I9o3Nq9J2X13SmDn7tAenr5uDwbX9ztg9jQtANm
	 CvD0F6C+uhQoqkEqS2ttfMLN7AWyXEJz3rq5qY3tW2s9uFRcTunuWKbWC2udQaCeLp
	 CExbY/es/HjPpC1/91a8opoY2BiNTYOTOqz1NnpPRpNurLEapf9jjPYsRsQlQNcfcT
	 XHlo84hs79jHg==
Date: Sat, 7 Sep 2024 18:18:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: imu: inv_mpu6050: Use
 upper_16_bits()/lower_16_bits() helpers
Message-ID: <20240907181853.78367ac4@jic23-huawei>
In-Reply-To: <FR3P281MB1757F1ABDB6FC9F2F02C21B4CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240904184543.1219866-1-andy.shevchenko@gmail.com>
	<FR3P281MB1757F1ABDB6FC9F2F02C21B4CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Sep 2024 09:16:22 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello,
>=20
> looks good for me, nice reading improvement indeed.
>=20
> Acked-by:=C2=A0Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied.

>=20
> Thanks for the patch,
> JB
>=20
> ________________________________________
> From:=C2=A0Andy Shevchenko <andy.shevchenko@gmail.com>
> Sent:=C2=A0Wednesday, September 4, 2024 20:45
> To:=C2=A0Andy Shevchenko <andy.shevchenko@gmail.com>; linux-iio@vger.kern=
el.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-ker=
nel@vger.kernel.org>
> Cc:=C2=A0Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@me=
tafoo.de>
> Subject:=C2=A0[PATCH v1 1/1] iio: imu: inv_mpu6050: Use upper_16_bits()/l=
ower_16_bits() helpers
> =C2=A0
> This Message Is From an External Sender
> This message came from outside your organization.
> =C2=A0
> Use upper_16_bits()/lower_16_bits() helpers instead of open-coding them.
> This is easier to scan quickly compared to bitwise manipulation, and
> it is pleasingly symmetric.
>=20
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_acpi.c
> index f7bce428d9eb..b15d8c94cc11 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> @@ -10,6 +10,8 @@
>  #include <linux/i2c.h>
>  #include <linux/dmi.h>
>  #include <linux/acpi.h>
> +#include <linux/wordpart.h>
> +
>  #include "inv_mpu_iio.h"
> =20
>  enum inv_mpu_product_name {
> @@ -118,8 +120,8 @@ static int inv_mpu_process_acpi_config(struct i2c_cli=
ent *client,
>  		return ret;
> =20
>  	acpi_dev_free_resource_list(&resources);
> -	*primary_addr =3D i2c_addr & 0x0000ffff;
> -	*secondary_addr =3D (i2c_addr & 0xffff0000) >> 16;
> +	*primary_addr =3D lower_16_bits(i2c_addr);
> +	*secondary_addr =3D upper_16_bits(i2c_addr);
> =20
>  	return 0;
>  }


