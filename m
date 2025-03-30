Return-Path: <linux-iio+bounces-17382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4F1A75BB2
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 20:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F71166EAC
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2443C1DC991;
	Sun, 30 Mar 2025 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvrJ+sci"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C508F5B;
	Sun, 30 Mar 2025 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743358116; cv=none; b=qc15KS5KO0QYnWulI1DxEwNlSOxYH5PtvG80+I3xke3EB2dfTj/fX+T5uqfs6wSe7hop92+01FYeMFKjcPRa2aPynHsZHfJ+WUg+8ofBgFaSfYTAyLfKGpd0QfwgycM6fqLqaiFrZgnw4QAbtRl9Be0dCI4ysrf25arn8QnuQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743358116; c=relaxed/simple;
	bh=CN2OkThA27NdQWpbEPcjNloXlUl9MhYskmBkPRGKCVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gw4Yp6/AmnrkVVJfmAI/aYXFPqzwAFMCePWydN2jSsZWJOEyiWXnyLJAIKMjIX7QRMFb571XVgXlPPIIaMUClLAaCSe59ZW0DQtUYRXBJ7ec+V4TVGUq5xlyWL+qmsnWFKqM/cPr/gBxO48B/dFos9MGMjV/+lja7C4wlPW9q7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvrJ+sci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBA0C4CEDD;
	Sun, 30 Mar 2025 18:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743358116;
	bh=CN2OkThA27NdQWpbEPcjNloXlUl9MhYskmBkPRGKCVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cvrJ+scib8pnbZFObnCGzNTSDBiN0jLF0AKE5SXxAQ877MCqVDA3fC6JT+APqltQu
	 XuI6RsFl45smHmZJzqpuQoolPHP6nke/2CL5cNm3I1Izr4BG0xyDkHBMmKcMul0eRN
	 U30PfURcIBLuhD4g00Jcx9BzegZpw0JoEjTW7JzL+kINd0rgBwDMk50aIQ77S/CZhT
	 yLMKigQzLoTN8Vgx5SIIsZsHZF3SP7xz4W89Up+m6+rf8dyz7L5M+pSKUxMhQJARJj
	 xCBfTpEsmRyb/PfNc/RKb4M/Cq1pvJmDozR3vKdpy1BLkJQeqcY1j57Okzg+OqtF8D
	 JsvfdtKBC5W3A==
Date: Sun, 30 Mar 2025 19:08:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Alexandru Ardelean <aardelean@baylibre.com>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 10/10] iio: adc: ad7606_par: add ad7606c chips
Message-ID: <20250330190827.654b4f3d@jic23-huawei>
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-10-4b605427774c@baylibre.com>
References: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
	<20250318-iio-adc-ad7606-improvements-v2-10-4b605427774c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Mar 2025 17:52:18 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add lookup table entries for ad7606c-16 and ad7606c-18 chips.
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the togreg branch of iio.git which due to timing I'll only
push out as testing until rc1 is available for me to rebase on top of.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7606_par.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> index e33b07ab5eace4b78e7cf39ee7e8d9379c9f73e7..634852c4bbd2c531d6c0e02d2=
f1e62db9008cad9 100644
> --- a/drivers/iio/adc/ad7606_par.c
> +++ b/drivers/iio/adc/ad7606_par.c
> @@ -222,6 +222,8 @@ static const struct platform_device_id ad7606_driver_=
ids[] =3D {
>  	{ .name	=3D "ad7606-6", .driver_data =3D (kernel_ulong_t)&ad7606_6_info=
, },
>  	{ .name	=3D "ad7606-8", .driver_data =3D (kernel_ulong_t)&ad7606_8_info=
, },
>  	{ .name	=3D "ad7606b", .driver_data =3D (kernel_ulong_t)&ad7606b_info, =
},
> +	{ .name =3D "ad7606c-16", .driver_data =3D (kernel_ulong_t)&ad7606c_16_=
info },
> +	{ .name =3D "ad7606c-18", .driver_data =3D (kernel_ulong_t)&ad7606c_18_=
info },
>  	{ .name	=3D "ad7607", .driver_data =3D (kernel_ulong_t)&ad7607_info, },
>  	{ .name	=3D "ad7608", .driver_data =3D (kernel_ulong_t)&ad7608_info, },
>  	{ .name	=3D "ad7609", .driver_data =3D (kernel_ulong_t)&ad7609_info, },
> @@ -235,6 +237,8 @@ static const struct of_device_id ad7606_of_match[] =
=3D {
>  	{ .compatible =3D "adi,ad7606-6", .data =3D &ad7606_6_info },
>  	{ .compatible =3D "adi,ad7606-8", .data =3D &ad7606_8_info },
>  	{ .compatible =3D "adi,ad7606b", .data =3D &ad7606b_info },
> +	{ .compatible =3D "adi,ad7606c-16", .data =3D &ad7606c_16_info },
> +	{ .compatible =3D "adi,ad7606c-18", .data =3D &ad7606c_18_info },
>  	{ .compatible =3D "adi,ad7607", .data =3D &ad7607_info },
>  	{ .compatible =3D "adi,ad7608", .data =3D &ad7608_info },
>  	{ .compatible =3D "adi,ad7609", .data =3D &ad7609_info },
>=20


