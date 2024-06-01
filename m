Return-Path: <linux-iio+bounces-5590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE68D71B5
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 21:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDF21F216DB
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 19:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6978E154C08;
	Sat,  1 Jun 2024 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg2AVOeK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD914E2EF;
	Sat,  1 Jun 2024 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717271370; cv=none; b=R/GCUgVbDX8hQcEEkfAlo0dmkmJnv2q7+ZN6MJ3e+fHhihnCVhczuhMyyAsElLPLGes25O2WetiHTmywS9DZmu9aOYuF9ovpbzub8BPsl1HtIK8TJzG8orpziFixPYY62x/s9n5Wgahn706lQZp15qM/Wcpux24jqubj+xz90Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717271370; c=relaxed/simple;
	bh=3u1rfYEcoEn/IHLUVdZkzUBju9xYZmaB7g/1fGKTGjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkSxajwoZUdPkw1LdC7c3q+Wx2HjAu9zR+ZZcoCnotavyPxKAsX90hRoRtvPaerTt1eZJLHWbnLDJNS8r12pBZev8fKR7mX+rkX5HzcqMQ06OulYDKY5Y2E9vedj1qaZHrw0lstGm0qRd3dH9L8Kuw4sR7u6BBC7VJo+97bbGA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg2AVOeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE12C116B1;
	Sat,  1 Jun 2024 19:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717271369;
	bh=3u1rfYEcoEn/IHLUVdZkzUBju9xYZmaB7g/1fGKTGjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kg2AVOeK0RGHJ2jl0k/AK81pd2s1UHFJvEr7nJ/CjHh+zuZTh66eMb/+deRFBHLDp
	 6Sgf/TKTyWOAcfwChNYeuZkDCUEHUiiV4lX3tvoLjuqGIk8D3+OB+yurqjf7JpzG2U
	 lGLs4sZRv+NHpNWiDwFQoOeQW99cIrjJYwYzY8GzTvn4oTjC221uPF1dD3wfwp5frR
	 s9xyMX43OaI2YZuOP1Q/4mQQEPTvuSyfMsWY34MEPZfVOKhMzjq1gVV60m8Lol8XUR
	 qHK45KyY6ZK9lZC5bYp9QiW34/mpm12t63mkHFzLnwINBp5A9qGnnjfuSdAtZtlmj5
	 gQYhkG3sHPX8g==
Date: Sat, 1 Jun 2024 20:49:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, denis.ciocca@st.com,
	devicetree@vger.kernel.org, linus.walleij@linaro.org,
	robh+dt@kernel.org
Subject: Re: [PATCH v3] iio: accel: st_accel: add LIS2DS12
Message-ID: <20240601-spouse-hurler-e7b93ac26f86@spud>
References: <20240601192914.141906-1-kauschluss@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VkJH0smJdlxpRA/x"
Content-Disposition: inline
In-Reply-To: <20240601192914.141906-1-kauschluss@disroot.org>


--VkJH0smJdlxpRA/x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 02, 2024 at 12:56:41AM +0530, Kaustabh Chakraborty wrote:
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index fd3749871121..329a4d6fb2ec 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -102,6 +102,10 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.compatible = "st,lis2de12",
>  		.data = LIS2DE12_ACCEL_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lis2ds12",
> +		.data = LIS2DS12_ACCEL_DEV_NAME,
> +	},
>  	{
>  		.compatible = "st,lis2hh12",
>  		.data = LIS2HH12_ACCEL_DEV_NAME,

> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index f72a24f45322..825adab37105 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -64,6 +64,10 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.compatible = "st,lis2dh12-accel",
>  		.data = LIS2DH12_ACCEL_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lis2ds12",
> +		.data = LIS2DS12_ACCEL_DEV_NAME,
> +	},
>  	{
>  		.compatible = "st,lis3l02dq",
>  		.data = LIS3L02DQ_ACCEL_DEV_NAME,

Any new compatibles need to be documented in st,st-sensors.yaml

Thanks,
Conor.


--VkJH0smJdlxpRA/x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlt7RQAKCRB4tDGHoIJi
0sImAQDlcTYvfFq7lbFfxOa7KThUNrvhCeyCHR+3MzwYRY3JNgEAu2Q+lbwuzLHg
Ct7l41Ox6xi7dS32KcXEQgxfN5WcNws=
=XiVS
-----END PGP SIGNATURE-----

--VkJH0smJdlxpRA/x--

