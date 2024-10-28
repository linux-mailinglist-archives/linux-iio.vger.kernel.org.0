Return-Path: <linux-iio+bounces-11500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CDD9B3736
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD185285300
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB4D1DF253;
	Mon, 28 Oct 2024 16:59:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6241DEFC7;
	Mon, 28 Oct 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134759; cv=none; b=Z1GDtxYRe9WVeW+XGqeBKUYF+HXJHJjHe26CXKrKE1w9P/PQGS/jVE8uEnKuPSkYh08wKvVfRB9PPzLLt331j9VUqo/n9xgqMj+VAJZwaDOo/5M0mSmgxaGpr/LaXGR/92zt0y7yq9lQ+srmi8nVZ+capmxTbsLydXWYqyukMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134759; c=relaxed/simple;
	bh=CKF5zHRpYuIZkvXaHwRxD2JxwDQKSXwuR6dR7dKaDEo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOW5ry87P+NcaPSiB5SQxaBjdPvH+GUsXfSLgKZU8Jd86/d7GC74SwK9riB6L7ILLYCosFPKoP5t/RkbYjaZnogdJtA3YjdWVYLXVrDzfD3jUeTxfLLwJkXjDK+y8EBxW2TBNSHcnkdN6Ec3XWKvNoa2w2RXCZEnZhT+5aGLeq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xcfcc5V23z6LDYc;
	Tue, 29 Oct 2024 00:54:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 34113140B3C;
	Tue, 29 Oct 2024 00:59:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Oct
 2024 17:59:12 +0100
Date: Mon, 28 Oct 2024 16:59:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Budai <robert.budai@analog.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>, Antoniu Miclaus
	<antoniu.miclaus@analog.com>, Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jagath Jog J
	<jagathjog1996@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <robi_budai@yahoo.com>
Subject: Re: [PATCH 1/5] iio: imu: adis: Add custom ops struct
Message-ID: <20241028165910.0000171c@Huawei.com>
In-Reply-To: <20241028122543.8078-2-robert.budai@analog.com>
References: <20241028122543.8078-1-robert.budai@analog.com>
	<20241028122543.8078-2-robert.budai@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Oct 2024 14:25:33 +0200
Robert Budai <robert.budai@analog.com> wrote:

> From: Nuno S=E1 <nuno.sa@analog.com>
>=20
> This patch introduces a custom ops struct letting users define
> custom read and write functions. Some adis devices might define
> a completely different spi protocol from the one used in the
> default implementation.

Also needs to mention the reset as that is nothing to do with
bus access.

>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>

Minor comments inline

Jonathan

> =20
> @@ -339,8 +339,11 @@ int __adis_reset(struct adis *adis)
>  	int ret;
>  	const struct adis_timeout *timeouts =3D adis->data->timeouts;
> =20
> -	ret =3D __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
> -				 ADIS_GLOB_CMD_SW_RESET);
> +	if (adis->ops->reset)

This one looks to be unrelated to the read / write path and
isn't mentioned in the patch description. Perhaps better to add
it in a separate patch where you can talk about why is it is needed.=20

> +		ret =3D adis->ops->reset(adis);
> +	else
> +		ret =3D __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
> +					 ADIS_GLOB_CMD_SW_RESET);
>  	if (ret) {
>  		dev_err(&adis->spi->dev, "Failed to reset device: %d\n", ret);
>  		return ret;

>  /**
>   * adis_init() - Initialize adis device structure
>   * @adis:	The adis device
> @@ -517,6 +525,9 @@ int adis_init(struct adis *adis, struct iio_dev *indi=
o_dev,
> =20
>  	adis->spi =3D spi;
>  	adis->data =3D data;
> +	if (!adis->ops->write || !adis->ops->read)
> +		adis->ops =3D &adis_default_ops;

If only write or read is specified, error out, don't replace with
the default ops as that clearly indicates a bug.


> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index e6a75356567a..7b589cc83380 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -94,6 +94,21 @@ struct adis_data {
>  	unsigned int burst_max_speed_hz;
>  };
> =20
> +/**
> + * struct adis_ops: Custom ops for adis devices.
> + * @write: Custom spi write implementation.
> + * @read: Custom spi read implementation.
> + * @reset: Custom sw reset implementation. The custom implementation doe=
s not
> + *	   need to sleep after the reset. It's done by the library already.
> + */
> +struct adis_ops {
> +	int (*write)(struct adis *adis, unsigned int reg, unsigned int value,
> +		     unsigned int size);
> +	int (*read)(struct adis *adis, unsigned int reg, unsigned int *value,
> +		    unsigned int size);
> +	int (*reset)(struct adis *adis);
> +};
> +
>  /**
>   * struct adis - ADIS device instance data
>   * @spi: Reference to SPI device which owns this ADIS IIO device
> @@ -117,6 +132,7 @@ struct adis {
> =20
>  	const struct adis_data	*data;
>  	unsigned int		burst_extra_len;
> +	const struct adis_ops	*ops;

Docs?  This structure has kernel-doc that needs updating to cover this new =
element.
Also, whilst you are here, please can you fix that doc in general (as=20
precursor patch preferably).

At least one element in the docs doesn't seem to exist in the structure.

>  	/**
>  	 * The state_lock is meant to be used during operations that require
>  	 * a sequence of SPI R/W in order to protect the SPI transfer


