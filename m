Return-Path: <linux-iio+bounces-15591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35935A375F6
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876F616D9C0
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C211819C54C;
	Sun, 16 Feb 2025 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFY8NyjV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739931EB2A;
	Sun, 16 Feb 2025 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724200; cv=none; b=jEU1SZwk+0EFxcV2tKLi/PQxCpA0BXnw/RQrUQNVIk2eJVuiFOeSxoenKeMZKkoPkl0kHuOlwj59JYjmEejfCVf6nDGjKznse6HHuXiGMg9I6Y4zm3EqC7LavJAxzUJJVZzmfGkVqG5z7h1g9V0mKOox0YNOXkzF3ZiuTLpK58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724200; c=relaxed/simple;
	bh=BT+ZyOmy5mLzUq3dEBSVe9UaUYqjGSKwizeCTgJAeKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPualq0mw6xabDtYkPreDHa3qyinAzcVixjHeMPdis69zkaLxC7XMhNXvOOub6+W8g1ETSTds89+2WveEskHxYfcQMKeGG7DcsJevCcc9woZt1lCK3EGdbFmSmCprkH2Vzq8Gfs+rBWKCwtzYrvTMQPW1ILfnHPFsBziM6TpnnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFY8NyjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E62C4CEDD;
	Sun, 16 Feb 2025 16:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739724199;
	bh=BT+ZyOmy5mLzUq3dEBSVe9UaUYqjGSKwizeCTgJAeKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BFY8NyjVJCbyFc7pXzCVzRBdCfX3PPwdNSFN1MxT/pD6m0PCv6RJtxzMEMX/ch0wm
	 4Fs+DmVA1iJqdzRRN0y4yexmVbCl/Z7toTw1pP1hgG5RjQJDoCcyP8/oPzJ6HKJ5n+
	 vHOK5hKsCF08UPUUIt0XK2Q7qvqGyg6HEGJ1avVhmysV4T5iLm5xznhXx+Gq4FVhqv
	 RhISGZrWC3TFqGgHQAQHQQS87F8e/WDYGKAdx+BH93gy9/WGrxNxQ3geo+NB4F8hfT
	 pzRRzzk15ohNFwR/19IKZ50zOFRLfeZWWKH7M/8x0EgZydm1yQWiGZGDHaCkUu8mgM
	 6aSZ/mBwDZQxQ==
Date: Sun, 16 Feb 2025 16:43:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Ramona
 Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 3/6] iio: imu: adis: Add DIAG_STAT register
Message-ID: <20250216164313.495aabdc@jic23-huawei>
In-Reply-To: <20250211175706.276987-4-robert.budai@analog.com>
References: <20250211175706.276987-1-robert.budai@analog.com>
	<20250211175706.276987-4-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Feb 2025 19:57:00 +0200
Robert Budai <robert.budai@analog.com> wrote:

> Some devices may have more than 16 bits of status. This patch allows the =
user
> to specify the size of the DIAG_STAT register. It defaults to 2 if not
> specified. This is mainly for backward compatibility.
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
>  drivers/iio/imu/adis.c       | 19 ++++++++++++++++---
>  include/linux/iio/imu/adis.h |  3 +++
>  2 files changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 84344f052..b3f074116 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -304,11 +304,21 @@ EXPORT_SYMBOL_NS(__adis_enable_irq, "IIO_ADISLIB");
>   */
>  int __adis_check_status(struct adis *adis)
>  {
> -	u16 status;
> +	unsigned int status;
> +	int diag_stat_bits;
> +	u16 status_16;
>  	int ret;
>  	int i;
> =20
> -	ret =3D __adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
> +	if (adis->data->diag_stat_size)
> +		ret =3D adis->ops->read(adis, adis->data->diag_stat_reg, &status,
> +				      adis->data->diag_stat_size);
> +	else
> +	{

This doesn't match kernel style.=20
	if (adis->data->diag_stat_size) {
		ret =3D adis->ops->read(adis, adis->data->diag_stat_reg, &status,
				      adis->data->diag_stat_size);
	} else {
		ret =3D __adis_read_reg_16(adis, adis->data->diag_stat_reg,
					 &status_16);
		status =3D status_16;
	}

Also the integer instead of pointer issue 0-day found.=20

Jonathan


> +		ret =3D __adis_read_reg_16(adis, adis->data->diag_stat_reg,
> +					 status_16);
> +		status =3D status_16;
> +	}
>  	if (ret)
>  		return ret;
> =20
> @@ -317,7 +327,10 @@ int __adis_check_status(struct adis *adis)
>  	if (status =3D=3D 0)
>  		return 0;
> =20
> -	for (i =3D 0; i < 16; ++i) {
> +	diag_stat_bits =3D BITS_PER_BYTE * (adis->data->diag_stat_size ?
> +					  adis->data->diag_stat_size : 2);
> +
> +	for (i =3D 0; i < diag_stat_bits; ++i) {
>  		if (status & BIT(i)) {
>  			dev_err(&adis->spi->dev, "%s.\n",
>  				adis->data->status_error_msgs[i]);
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 52652f51d..35797fe93 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -44,6 +44,8 @@ struct adis_timeout {
>   * @glob_cmd_reg: Register address of the GLOB_CMD register
>   * @msc_ctrl_reg: Register address of the MSC_CTRL register
>   * @diag_stat_reg: Register address of the DIAG_STAT register
> + * @diag_stat_size: 	Length (in bytes) of the DIAG_STAT register. If 0 t=
he=20
> + * 			default length is 2 bytes long.
>   * @prod_id_reg: Register address of the PROD_ID register
>   * @prod_id: Product ID code that should be expected when reading @prod_=
id_reg
>   * @self_test_mask: Bitmask of supported self-test operations
> @@ -70,6 +72,7 @@ struct adis_data {
>  	unsigned int glob_cmd_reg;
>  	unsigned int msc_ctrl_reg;
>  	unsigned int diag_stat_reg;
> +	unsigned int diag_stat_size;
>  	unsigned int prod_id_reg;
> =20
>  	unsigned int prod_id;


