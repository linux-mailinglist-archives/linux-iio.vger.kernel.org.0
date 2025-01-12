Return-Path: <linux-iio+bounces-14227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B0EA0AA8B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E903416331E
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC721BC9F0;
	Sun, 12 Jan 2025 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQywA/Vb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAEC1B4135;
	Sun, 12 Jan 2025 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736696148; cv=none; b=jiTvs1OLn6mH7q6tGlMt2lKPW7GZzElukP3NJbqPOk4KRIzqO9yrmrI4rUSEZzQQkQ/GN6G0pk2HOvPVDjmR9ielHUgbREDl2jVJZB7f97V96ghqIK/mIClRGMKycfO3V1L9V7YH42UdVAsXyYp/t+TqjSwMk5p7iN3eWAC0UwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736696148; c=relaxed/simple;
	bh=ikFZPYcGQUJcP6MsH0gEx/v2U803DLIXaUl4KdyGCmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YECllkruDUCNNKNfBTcwme1xAgL2VEwJvuy71IrsEnnKJAcIr7YEDAD+KeCo2pPAVRDttGiugC2WfQZciumaR6ySqiV3fzqs44rFHbEhlZZo6w4PqPTS9EfgjkNvGYBr49E23OIEqokfL52Nz5R2r1VQA9CajBD6uqCob5TX9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQywA/Vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A72C4CEDF;
	Sun, 12 Jan 2025 15:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736696148;
	bh=ikFZPYcGQUJcP6MsH0gEx/v2U803DLIXaUl4KdyGCmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RQywA/VbjtVbhKRUVQLI2RK5dLaQQRLttZIhibDE2WttBWk87JO22TPJCmXggDo4P
	 M5pP+tnaXclPrBWni6vn1KYrpKM9bm/uvODNCxqeB+xQcnmiO0K2dJphyKYUgTyPc0
	 N0bkt1SOZV/AyKWLjjGFIZFzrAUOiZ72LiOpF3pyqCw5pqPJY+dr7MclERWdGggSDz
	 uuMLrZVrMxzAnUJEB+RQUTQybZUJc2y2KVj6BvId/FFLojYST4BzsyA7l+4M5EzR4D
	 BryoaKhommvyu0kMaWTzYAhMyye+sv3CTpcDbM9WKT0rKJdwo7it3HECD1dG9IUPJX
	 D/QqDdjZ65hMA==
Date: Sun, 12 Jan 2025 15:35:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alex Lanzano
 <lanzano.alex@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] iio: imu: adis: Add reset to custom ops
Message-ID: <20250112153536.0d6034a9@jic23-huawei>
In-Reply-To: <20250110074254.38966-3-robert.budai@analog.com>
References: <20250110074254.38966-1-robert.budai@analog.com>
	<20250110074254.38966-3-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jan 2025 09:42:50 +0200
Robert Budai <robert.budai@analog.com> wrote:

> This patch allows the custom definition of reset functionality
> for adis object. It is useful in cases where the driver does not
> need to sleep after the reset since it is handled by the library.
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
>  drivers/iio/imu/adis.c       | 7 ++++---
>  include/linux/iio/imu/adis.h | 3 +++
>  2 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 54915c7a3e76..9e4113473dc4 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -340,7 +340,7 @@ int __adis_reset(struct adis *adis)
>  	const struct adis_timeout *timeouts =3D adis->data->timeouts;
> =20
>  	ret =3D __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
> -				 ADIS_GLOB_CMD_SW_RESET);
> +					 ADIS_GLOB_CMD_SW_RESET);

Accidental change I guess, but bad anyway. Original looks better aligned.

>  	if (ret) {
>  		dev_err(&adis->spi->dev, "Failed to reset device: %d\n", ret);
>  		return ret;
> @@ -491,6 +491,7 @@ EXPORT_SYMBOL_NS_GPL(adis_single_conversion, "IIO_ADI=
SLIB");
>  static const struct adis_ops adis_default_ops =3D {
>  	.read =3D __adis_read_reg,
>  	.write =3D __adis_write_reg,
> +	.reset =3D __adis_reset,
>  };
> =20
>  /**
> @@ -522,9 +523,9 @@ int adis_init(struct adis *adis, struct iio_dev *indi=
o_dev,
> =20
>  	adis->spi =3D spi;
>  	adis->data =3D data;
> -	if (!adis->ops->write && !adis->ops->read)
> +	if (!adis->ops->write && !adis->ops->read && !adis->ops->reset)
>  		adis->ops =3D &adis_default_ops;
> -	else if (!adis->ops->write || !adis->ops->read)
> +	else if (!adis->ops->write || !adis->ops->read || !adis->ops->reset)
>  		return -EINVAL;
> =20
>  	iio_device_set_drvdata(indio_dev, adis);
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 89cfa75ae9ea..52652f51db2e 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -98,12 +98,15 @@ struct adis_data {
>   * struct adis_ops: Custom ops for adis devices.
>   * @write: Custom spi write implementation.
>   * @read: Custom spi read implementation.
> + * @reset: Custom sw reset implementation. The custom implementation doe=
s not
> + *	   need to sleep after the reset. It's done by the library already.
>   */
>  struct adis_ops {
>  	int (*write)(struct adis *adis, unsigned int reg, unsigned int value,
>  		     unsigned int size);
>  	int (*read)(struct adis *adis, unsigned int reg, unsigned int *value,
>  		    unsigned int size);
> +	int (*reset)(struct adis *adis);
>  };
> =20
>  /**


