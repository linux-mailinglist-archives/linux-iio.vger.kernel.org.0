Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B07915D984
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgBNObo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:31:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgBNObo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:31:44 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6C7E206B6;
        Fri, 14 Feb 2020 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581690703;
        bh=+8T/dPPlxh7EgMeFLHxDhIho7wHw3zbcndMewJB3C5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sd3B9EKMO0mDZx13eyRi0lrg6IFzSGwoGW1cJEjewzc711JypHJAHG0wzLihtYMHt
         9GnVyyeI3+lxfOrcOM4UktzrRKqAv0Y2e1Q7ZFAh991wwU7oYkn8yIoXfOqY4UGb+/
         kfISL9euEiBMDqiRxldue0RROqb4yVbtjjz1Efi0=
Date:   Fri, 14 Feb 2020 14:31:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nuno.sa@analog.com>
Subject: Re: [PATCH v2 4/9] iio: imu: adis: add unlocked
 __adis_initial_startup()
Message-ID: <20200214143137.72e995b3@archlinux>
In-Reply-To: <20200210132606.9315-4-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
        <20200210132606.9315-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Feb 2020 15:26:01 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change splits the __adis_initial_startup() away from
> adis_initial_startup(). The unlocked version can be used in certain calls
> during probe, where races won't happen since the ADIS driver may not be
> registered yet with IIO.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.  Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c       | 14 ++++----------
>  include/linux/iio/imu/adis.h | 13 ++++++++++++-
>  2 files changed, 16 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 022bb54fb748..e4897dad34ab 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -365,7 +365,7 @@ static int adis_self_test(struct adis *adis)
>  }
> =20
>  /**
> - * adis_inital_startup() - Performs device self-test
> + * __adis_initial_startup() - Device initial setup
>   * @adis: The adis device
>   *
>   * Returns 0 if the device is operational, a negative error code otherwi=
se.
> @@ -373,28 +373,22 @@ static int adis_self_test(struct adis *adis)
>   * This function should be called early on in the device initialization =
sequence
>   * to ensure that the device is in a sane and known state and that it is=
 usable.
>   */
> -int adis_initial_startup(struct adis *adis)
> +int __adis_initial_startup(struct adis *adis)
>  {
>  	int ret;
> =20
> -	mutex_lock(&adis->state_lock);
> -
>  	ret =3D adis_self_test(adis);
>  	if (ret) {
>  		dev_err(&adis->spi->dev, "Self-test failed, trying reset.\n");
>  		__adis_reset(adis);
>  		ret =3D adis_self_test(adis);
> -		if (ret) {
> +		if (ret)
>  			dev_err(&adis->spi->dev, "Second self-test failed, giving up.\n");
> -			goto out_unlock;
> -		}
>  	}
> =20
> -out_unlock:
> -	mutex_unlock(&adis->state_lock);
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(adis_initial_startup);
> +EXPORT_SYMBOL_GPL(__adis_initial_startup);
> =20
>  /**
>   * adis_single_conversion() - Performs a single sample conversion
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index d2fcf45b4cef..15e75670f923 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -297,6 +297,7 @@ static inline int adis_read_reg_32(struct adis *adis,=
 unsigned int reg,
> =20
>  int adis_enable_irq(struct adis *adis, bool enable);
>  int __adis_check_status(struct adis *adis);
> +int __adis_initial_startup(struct adis *adis);
> =20
>  static inline int adis_check_status(struct adis *adis)
>  {
> @@ -309,7 +310,17 @@ static inline int adis_check_status(struct adis *adi=
s)
>  	return ret;
>  }
> =20
> -int adis_initial_startup(struct adis *adis);
> +/* locked version of __adis_initial_startup() */
> +static inline int adis_initial_startup(struct adis *adis)
> +{
> +	int ret;
> +
> +	mutex_lock(&adis->state_lock);
> +	ret =3D __adis_initial_startup(adis);
> +	mutex_unlock(&adis->state_lock);
> +
> +	return ret;
> +}
> =20
>  int adis_single_conversion(struct iio_dev *indio_dev,
>  	const struct iio_chan_spec *chan, unsigned int error_mask,

