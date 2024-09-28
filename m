Return-Path: <linux-iio+bounces-9824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA87989007
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A4DB215D2
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565DA224F2;
	Sat, 28 Sep 2024 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlt+Dfq+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C51EF01;
	Sat, 28 Sep 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536599; cv=none; b=eI2epzn6/vH5vtyM/Tj6F4HzRtDeP8AI1HtoIMqMosloYEBhHp+Cz7JdKGy+uWuHas9IjMWOG1YI8DVDsjhUwVqXt+7vtqs1hVIsre7l7pqDVCHaJBPl0LetzD8JxRyndBYqoJX2j3auMZOLZdobhezDJU3VLdSmfIe9bDOQrRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536599; c=relaxed/simple;
	bh=e/vC5P+z4/0yuRExJtUMzvP53rS1ndwzqtVfgobpZWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtBsw866L9vRpPR/55TrKM293JxwKnIb0xzcqOZLiAQfj/z7eNSWl6aacaXbco74U3jSBJRDEJiaeSLEHuv/YwSg9ULGHZEOvs1AHmLCxMfNouMcjuDvM0kvMtiGiuKoInMfN2xnh87rKIbfEjv5ewW/H8IhU6hOF5Ku2oIKsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlt+Dfq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5451FC4CEC3;
	Sat, 28 Sep 2024 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727536598;
	bh=e/vC5P+z4/0yuRExJtUMzvP53rS1ndwzqtVfgobpZWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jlt+Dfq+eq1/l1afN2CT8R7AHG24PzJ9RzuM2Sq0+i/pUvpiyOjFzARBqCBFf3dG5
	 mNcWjXmGSe9srn3gYKYtrgBje3kW7E7x0JKOnl54WkUyExp2xMjRPNHT/38/ANEBjJ
	 WHDodhPCr9GweldZx9jgHbVdCXuoRTFLqcmrhNtQJ8tgIAeBkHmIr8BQTfOt1HQ4id
	 RPK+RfalPjTIePXhgUmXLezKfjur8pyINHIsNvtue7jguW+g1O/A9U1mi8eew6mGAU
	 zY1MLOBDVPT1oNm+VeBr6VkcSWkCQbyJOFmqhv0mRI6JaiZ+OrOa0G1B3eYiYYKNMs
	 5lAM2InB3WW/A==
Date: Sat, 28 Sep 2024 16:16:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: puranjay@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 puranjay12@gmail.com, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH 2/3] iio: accel: adxl355: Correct the typo
 'accelaration'
Message-ID: <20240928161631.0182ad73@jic23-huawei>
In-Reply-To: <739D781F53669A17+ee9db6cf-dca4-4e53-9444-ecdf0b72dfbd@uniontech.com>
References: <7BF34BF48048052E+20240922111832.441807-1-wangyuli@uniontech.com>
	<739D781F53669A17+ee9db6cf-dca4-4e53-9444-ecdf0b72dfbd@uniontech.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Sep 2024 19:26:08 +0800
WangYuli <wangyuli@uniontech.com> wrote:

>  From 562a6ce3ebbeae03eabdd8fa5c265299ca59560b Mon Sep 17 00:00:00 2001
> From: WangYuli <wangyuli@uniontech.com>
> Date: Sun, 22 Sep 2024 18:45:50 +0800
> Subject: [PATCH 2/3] iio: accel: adxl355: Correct the typo 'accelaration'
>=20
> There is a spelling mistake of 'accelaration' which should be
> 'acceleration'.
>=20
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
Patch is fine, but the way it has been sent is not.
We shouldn't be seeing the email header within the body of the patch.

Jonathan

> ---
>  =C2=A0drivers/iio/accel/adxl355_core.c | 2 +-
>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/adxl355_core.c=20
> b/drivers/iio/accel/adxl355_core.c
> index 0c9225d18fb2..5e682bf079d8 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -643,7 +643,7 @@ static irqreturn_t adxl355_trigger_handler(int irq,=20
> void *p)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The acceleration data=
 is 24 bits and big endian. It has to=20
> be saved
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * in 32 bits, hence, it=
 is saved in the 2nd byte of the 4 byte=20
> buffer.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The buf array is 14 b=
ytes as it includes 3x4=3D12 bytes for
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * accelaration data of x, y, =
and z axis. It also includes 2=20
> bytes for
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * acceleration data of x, y, =
and z axis. It also includes 2=20
> bytes for
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * temperature data.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_bulk_read(data=
->regmap, ADXL355_XDATA3_REG,


