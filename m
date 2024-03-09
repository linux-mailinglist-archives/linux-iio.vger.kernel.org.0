Return-Path: <linux-iio+bounces-3405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A7877276
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 18:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A7DB2114C
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227E722325;
	Sat,  9 Mar 2024 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blBm6L/5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B2BA4D
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710005736; cv=none; b=V6KLLNDqmU1LtNyWAxXcklgUN/ndGKwq/2LmuY652ohGJNVIJbH14XEu3mEeL1fYGQ7x5UE8w1XByVMoN9pQtuO0c741hOKHoucA4OB9aeAH1Mn7EFjG4zxQQsCMyoev65ZY/gvjgbW3dxUTEkLERZ6+qKlRwJI2N6fk5ZAGLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710005736; c=relaxed/simple;
	bh=0hhRquT+WX0n2D64EKr//KPdBLTmBnsTJZbqT5gpn1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuTlHcNXZfhOo4D8G6XLiuqhbDe34Ot90o364HhvYU6BJhR2OOV5Ri8+EFkLo+DkxOZHjBYG6dMCmUHgdOV1CBEgaNAZ7lAOQh4r89FCC0stihGo7yUTW42uru6j5WOohoK+quw9UUh1V2RAxj1o76hO9UiMGvHvTeO0isjVxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blBm6L/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5767CC433C7;
	Sat,  9 Mar 2024 17:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710005736;
	bh=0hhRquT+WX0n2D64EKr//KPdBLTmBnsTJZbqT5gpn1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=blBm6L/5zjQcNeITjldL2uSfdhthNRG/UD4hdwanHc7M90W42bG0D9RvW5iu1yIUC
	 c8Czaen9j9DwqpZwUsKjKuBEyG6Pbc0oighVOSVOx5zz6ZTqSVTNtYPOwyuhch7zVq
	 09CQKaBRSSNW8UXU1IjJxW9BfJAKWyMsg4aPzc855CAldLl4bezEIreazlQE/BjZFV
	 8Uqs1sVwlLIaiLc8rtDuX8fqkDPGIZNQWW4adv2Sn6JomouNtpnntBeUdhJNUwFhd2
	 2nPnOBoc3GXsH+DM5+tIgqPi7cebIx8cU1P0XpJqe3dBuWViModQqJTHlVJ+YKlLTe
	 FL2grJ0iEfRFg==
Date: Sat, 9 Mar 2024 17:35:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH] iio: proximity: isl29501: fix unused of_device_id table
Message-ID: <20240309173525.1015c30e@jic23-huawei>
In-Reply-To: <20240308180718.1913090-1-ben.dooks@codethink.co.uk>
References: <20240308180718.1913090-1-ben.dooks@codethink.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  8 Mar 2024 18:07:18 +0000
Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> Under certain build conditions, the following warning is being generated
> from the isl29501 driver due to OF being configured but the driver being
> built in.
>=20
> drivers/iio/proximity/isl29501.c:999:34: warning: =E2=80=98isl29501_i2c_m=
atches=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>   999 | static const struct of_device_id isl29501_i2c_matches[] =3D {
>=20
> The isl29501_i2c_matches[] is only passed to MODULE_DEVICE_TABLE() and th=
us is
> not referenced if the driver is built into the kernel. Fix by adding a ch=
eck
> for MODULE around the #if block.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Hi Ben,

Already applied a different fix for this which is to allow matching via the
table.

Thanks

Jonathan
> ---
>  drivers/iio/proximity/isl29501.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl=
29501.c
> index bcebacaf3dab..d509227f47b7 100644
> --- a/drivers/iio/proximity/isl29501.c
> +++ b/drivers/iio/proximity/isl29501.c
> @@ -995,7 +995,7 @@ static const struct i2c_device_id isl29501_id[] =3D {
> =20
>  MODULE_DEVICE_TABLE(i2c, isl29501_id);
> =20
> -#if defined(CONFIG_OF)
> +#if defined(CONFIG_OF) && defined(MODULE)
>  static const struct of_device_id isl29501_i2c_matches[] =3D {
>  	{ .compatible =3D "renesas,isl29501" },
>  	{ }


