Return-Path: <linux-iio+bounces-14816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85923A24995
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936D07A3207
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 14:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F291BD014;
	Sat,  1 Feb 2025 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSECrB8x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09352557A;
	Sat,  1 Feb 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738421129; cv=none; b=VDPOjFjMZrGQGLbG1xL+Drz/T5n5kjqsDBhIxjON6TYSnNkvh3TNXEWue972GglIuaBJkAmzfgQELuMS8Ee4dcXjd3huewCPQlNEQeobelGpzCYDgqwS4oS91uiEtdytUjd2p2/B86HCL7XeMglzlGEymAcM8S6BeMBbBXJklzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738421129; c=relaxed/simple;
	bh=h3fZCiwYRqE+HzDA39f3dJWcnPSExT0LTqlrCDBkB58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQR5IsvM9RXY0AOR7pitUYJaXY1Cy/29OmKUkJIx7rvvAGh/CxBC1MWVWhcpzjdZ3N44S2Eaop612u8OidrmGFE0V+98h6q5x1HiGD416+3WiN/4v9DCGa/SNqTBr8CyiZD0k6Ps1U9nwWAcsx0klj6xO16MdnY/qZLsfuWWpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSECrB8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F00BC4CED3;
	Sat,  1 Feb 2025 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738421128;
	bh=h3fZCiwYRqE+HzDA39f3dJWcnPSExT0LTqlrCDBkB58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HSECrB8xldQtWVeQBa8kxeKXdsP5+rf3GUGm1FuQKumPFn9mgJkiiVi48gNMehOIO
	 dtXx8RJn4Ug8DwRTS66WSQUiIhauUlXklMTHKT5amuUjVlCc42XJT0x9hI/JAm5ZJj
	 2V9zjebOfslfNb8dyEBaSDTl8yMlMVtXTCK+cRGWhPZHOQCV5xVotg4GQSvJZ9RTeU
	 chIkMOuIZTIe9bX4PJgU4gKO5tENSqhOan51xOaA6TxfqKtfH8XKCN2lS3JxqFBlaa
	 Z2r4YPJKqb7ZJ3Plv8KpUrW3N0GFghAkLi9Cwjqojk5wpxedxYl2SzKEPG76aTvkGo
	 Mt4feo6HkR8Gw==
Date: Sat, 1 Feb 2025 14:45:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <ramona.gradinariu@analog.com>, <antoniu.miclaus@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <lanzano.alex@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 1/6] iio: imu: adis: Add custom ops struct
Message-ID: <20250201144517.56b0e636@jic23-huawei>
In-Reply-To: <20250129082053.19077-2-robert.budai@analog.com>
References: <20250129082053.19077-1-robert.budai@analog.com>
	<20250129082053.19077-2-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jan 2025 10:20:41 +0200
Robert Budai <robert.budai@analog.com> wrote:

> This patch introduces a custom ops struct letting users define
> custom read and write functions. Some adis devices might define
> a completely different spi protocol from the one used in the
> default implementation.
Wrap at 75 chars, not around 62

Otherwise this looks fine to me.  Could have been merged
with patch 2 as that just adds another op, but that's not important.

>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
>  drivers/iio/imu/adis.c       | 16 +++++++++++++---
>  include/linux/iio/imu/adis.h | 28 +++++++++++++++++++++-------
>  2 files changed, 34 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 494171844812..54915c7a3e76 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -223,13 +223,13 @@ int __adis_update_bits_base(struct adis *adis, unsi=
gned int reg, const u32 mask,
>  	int ret;
>  	u32 __val;
> =20
> -	ret =3D __adis_read_reg(adis, reg, &__val, size);
> +	ret =3D adis->ops->read(adis, reg, &__val, size);
>  	if (ret)
>  		return ret;
> =20
>  	__val =3D (__val & ~mask) | (val & mask);
> =20
> -	return __adis_write_reg(adis, reg, __val, size);
> +	return adis->ops->write(adis, reg, __val, size);
>  }
>  EXPORT_SYMBOL_NS_GPL(__adis_update_bits_base, "IIO_ADISLIB");
> =20
> @@ -468,7 +468,7 @@ int adis_single_conversion(struct iio_dev *indio_dev,
> =20
>  	guard(mutex)(&adis->state_lock);
> =20
> -	ret =3D __adis_read_reg(adis, chan->address, &uval,
> +	ret =3D adis->ops->read(adis, chan->address, &uval,
>  			      chan->scan_type.storagebits / 8);
>  	if (ret)
>  		return ret;
> @@ -488,6 +488,11 @@ int adis_single_conversion(struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_NS_GPL(adis_single_conversion, "IIO_ADISLIB");
> =20
> +static const struct adis_ops adis_default_ops =3D {
> +	.read =3D __adis_read_reg,
> +	.write =3D __adis_write_reg,
> +};
> +
>  /**
>   * adis_init() - Initialize adis device structure
>   * @adis:	The adis device
> @@ -517,6 +522,11 @@ int adis_init(struct adis *adis, struct iio_dev *ind=
io_dev,
> =20
>  	adis->spi =3D spi;
>  	adis->data =3D data;
> +	if (!adis->ops->write && !adis->ops->read)
> +		adis->ops =3D &adis_default_ops;
> +	else if (!adis->ops->write || !adis->ops->read)
> +		return -EINVAL;
> +
>  	iio_device_set_drvdata(indio_dev, adis);
> =20
>  	if (data->has_paging) {
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index e6a75356567a..04140b36712a 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -94,6 +94,18 @@ struct adis_data {
>  	unsigned int burst_max_speed_hz;
>  };
> =20
> +/**
> + * struct adis_ops: Custom ops for adis devices.
> + * @write: Custom spi write implementation.
> + * @read: Custom spi read implementation.
> + */
> +struct adis_ops {
> +	int (*write)(struct adis *adis, unsigned int reg, unsigned int value,
> +		     unsigned int size);
> +	int (*read)(struct adis *adis, unsigned int reg, unsigned int *value,
> +		    unsigned int size);
> +};
> +
>  /**
>   * struct adis - ADIS device instance data
>   * @spi: Reference to SPI device which owns this ADIS IIO device
> @@ -102,6 +114,7 @@ struct adis_data {
>   * @burst: ADIS burst transfer information
>   * @burst_extra_len: Burst extra length. Should only be used by devices =
that can
>   *		     dynamically change their burst mode length.
> + * @ops: ops struct for custom read and write functions
>   * @state_lock: Lock used by the device to protect state
>   * @msg: SPI message object
>   * @xfer: SPI transfer objects to be used for a @msg
> @@ -117,6 +130,7 @@ struct adis {
> =20
>  	const struct adis_data	*data;
>  	unsigned int		burst_extra_len;
> +	const struct adis_ops	*ops;
>  	/**
>  	 * The state_lock is meant to be used during operations that require
>  	 * a sequence of SPI R/W in order to protect the SPI transfer
> @@ -169,7 +183,7 @@ int __adis_read_reg(struct adis *adis, unsigned int r=
eg,
>  static inline int __adis_write_reg_8(struct adis *adis, unsigned int reg,
>  				     u8 val)
>  {
> -	return __adis_write_reg(adis, reg, val, 1);
> +	return adis->ops->write(adis, reg, val, 1);
>  }
> =20
>  /**
> @@ -181,7 +195,7 @@ static inline int __adis_write_reg_8(struct adis *adi=
s, unsigned int reg,
>  static inline int __adis_write_reg_16(struct adis *adis, unsigned int re=
g,
>  				      u16 val)
>  {
> -	return __adis_write_reg(adis, reg, val, 2);
> +	return adis->ops->write(adis, reg, val, 2);
>  }
> =20
>  /**
> @@ -193,7 +207,7 @@ static inline int __adis_write_reg_16(struct adis *ad=
is, unsigned int reg,
>  static inline int __adis_write_reg_32(struct adis *adis, unsigned int re=
g,
>  				      u32 val)
>  {
> -	return __adis_write_reg(adis, reg, val, 4);
> +	return adis->ops->write(adis, reg, val, 4);
>  }
> =20
>  /**
> @@ -208,7 +222,7 @@ static inline int __adis_read_reg_16(struct adis *adi=
s, unsigned int reg,
>  	unsigned int tmp;
>  	int ret;
> =20
> -	ret =3D __adis_read_reg(adis, reg, &tmp, 2);
> +	ret =3D adis->ops->read(adis, reg, &tmp, 2);
>  	if (ret =3D=3D 0)
>  		*val =3D tmp;
> =20
> @@ -227,7 +241,7 @@ static inline int __adis_read_reg_32(struct adis *adi=
s, unsigned int reg,
>  	unsigned int tmp;
>  	int ret;
> =20
> -	ret =3D __adis_read_reg(adis, reg, &tmp, 4);
> +	ret =3D adis->ops->read(adis, reg, &tmp, 4);
>  	if (ret =3D=3D 0)
>  		*val =3D tmp;
> =20
> @@ -245,7 +259,7 @@ static inline int adis_write_reg(struct adis *adis, u=
nsigned int reg,
>  				 unsigned int val, unsigned int size)
>  {
>  	guard(mutex)(&adis->state_lock);
> -	return __adis_write_reg(adis, reg, val, size);
> +	return adis->ops->write(adis, reg, val, size);
>  }
> =20
>  /**
> @@ -259,7 +273,7 @@ static int adis_read_reg(struct adis *adis, unsigned =
int reg,
>  			 unsigned int *val, unsigned int size)
>  {
>  	guard(mutex)(&adis->state_lock);
> -	return __adis_read_reg(adis, reg, val, size);
> +	return adis->ops->read(adis, reg, val, size);
>  }
> =20
>  /**


