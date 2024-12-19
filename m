Return-Path: <linux-iio+bounces-13671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1829F8196
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADDDA7A2D45
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060A1A0BFB;
	Thu, 19 Dec 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOq1ozet"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F61A0B15;
	Thu, 19 Dec 2024 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628825; cv=none; b=dM1Dzam7/S22C0T8ZMeVup0M1YzYI34F+3diYdrbcT83XIcgso/IsShqYYnPrkx6k2MdqXJLEt1mA3d62lCZbZKhRUYQlZanrVY2URkcoizpe4y+Mw/ro6555WDNPgqpIClXQe5jv3j52PABDFYP0LUXA4BIAAagqeRMFXaHyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628825; c=relaxed/simple;
	bh=py3NaCKG6sROKnF55lQMOdYhi4YSL6lU85XEN+z3HGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zj//Ko8+5wk5smHGCvxBFaAphd7bxxVH7WPzgn3H0vDhWmauRX+g+1jMhqgBZQO/904xwEl4ScjjiMpi3AwahKg0Gdqirh1vHFINXjE0aS7reKWVtMJRTTrRiUWiISLpS0nQS+qIQNZWeJ92r5b7A0P/zEqyYCdxsQK2vCT1xvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOq1ozet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9198C4CECE;
	Thu, 19 Dec 2024 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734628824;
	bh=py3NaCKG6sROKnF55lQMOdYhi4YSL6lU85XEN+z3HGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MOq1ozetsa2smkp9A+ZEPhgnEcGrWgdAzzHfBgc26ce0xpKmljKZFYFaZ+P9tU16O
	 mNjlEoeia3pbQ6knxhcx9ra/p4zUCUKrWMzY5MWUW/GxNF2Qf5DCKLLT0X0R0I7Z/8
	 +QVTntTbKEm9+wz486mYtAR1gFTmJzQQieFhRk9+0aEFA/WfHVXNlAR/8HGl/YGhxJ
	 xDpEBkCW2ltTux6tdWY922ZejYQMxje4HfL+Mv08vH3wRbSoCbqFZ0my0gRNs2QgKr
	 80onS78a4agYKfemly8bUKSgvq3738dXhq/1vPKAmT6GQH0gcO3wc0XFHuaQPvcY+Q
	 CDewPdBFz9AYg==
Date: Thu, 19 Dec 2024 17:20:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alex Lanzano
 <lanzano.alex@gmail.com>, Shen Jianping <Jianping.Shen@de.bosch.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <robi_budai@yahoo.com>
Subject: Re: [PATCH v3 3/7] iio: imu: adis: Add reset to custom ops
Message-ID: <20241219172013.73e6eebc@jic23-huawei>
In-Reply-To: <20241216144818.25344-4-robert.budai@analog.com>
References: <20241216144818.25344-1-robert.budai@analog.com>
	<20241216144818.25344-4-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Dec 2024 16:48:09 +0200
Robert Budai <robert.budai@analog.com> wrote:

> This patch allows the custom definition of reset funcitonality

functionality

> for adis object. It is useful in cases where the reset does not
> need to sleep after the reset since it is handled by the library.
reset does not need to sleep?  Driver I assume?
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
>=20
> v3:
> - added reset to default ops and used the allowed custom ops definition i=
n case all read/write and reset are defined
>=20
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


