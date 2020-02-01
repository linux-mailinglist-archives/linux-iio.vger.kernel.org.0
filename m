Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B68B14F916
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2020 18:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgBARIp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Feb 2020 12:08:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:53730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbgBARIp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Feb 2020 12:08:45 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8634C206E6;
        Sat,  1 Feb 2020 17:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580576923;
        bh=leQ2oVHxU64TQsgyTBsZlLGuQgNthhdi/27v/ARh1B8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J1MRrVN4o5yEdXPiNRZDwpKjaIe1x2rmyt2rslPikreH3Qel9Bv1qq9keSjD2p56G
         9McYIJeRsDQn12EHPrrw2OCLF/XR60qVLyTSFllsezVHpDasW2kbm+9QzoOl8B0ohV
         VwmsS3c91tPDIIOq5aV429DfBTYCRWXzv7WxnVg4=
Date:   Sat, 1 Feb 2020 17:08:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <dragos.bogdan@analog.com>,
        <nuno.sa@analog.com>
Subject: Re: [PATCH 2/4] iio: imu: adis: Refactor adis_initial_startup
Message-ID: <20200201170839.4ab98d8e@archlinux>
In-Reply-To: <20200120142051.28533-2-alexandru.ardelean@analog.com>
References: <20200120142051.28533-1-alexandru.ardelean@analog.com>
        <20200120142051.28533-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jan 2020 16:20:49 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> All the ADIS devices perform, at the beginning, a self test to make sure
> the device is in a sane state. Furthermore, some drivers also do a call
> to `adis_reset()` before the test which is also a good practice. This
> patch unifies all those operation so that, there's no need for code
> duplication. Furthermore, the rst pin is also checked to make sure the
> device is not in HW reset. On top of this, some drivers also read the
> device product id and compare it with the device being probed to make
> sure the correct device is being handled. This can also be passed to the
> library by introducing a variable holding the PROD_ID register of the
> device.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/imu/Kconfig      |  1 +
>  drivers/iio/imu/adis.c       | 63 ++++++++++++++++++++++++++----------
>  include/linux/iio/imu/adis.h | 15 ++++++++-
>  3 files changed, 61 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index 60bb1029e759..63036cf473c7 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -85,6 +85,7 @@ endmenu
> =20
>  config IIO_ADIS_LIB
>  	tristate
> +	depends on GPIOLIB
>  	help
>  	  A set of IO helper functions for the Analog Devices ADIS* device fami=
ly.
> =20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index d02b1911b0f2..1eca5271380e 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -365,36 +366,64 @@ static int adis_self_test(struct adis *adis)
>  }
> =20
>  /**
> - * adis_inital_startup() - Performs device self-test
> + * __adis_initial_startup() - Device initial setup
>   * @adis: The adis device
>   *
> + * This functions makes sure the device is not in reset, via rst pin.
> + * Furthermore it performs a SW reset (only in the case we are not comin=
g from
> + * reset already) and a self test. It also compares the product id with =
the
> + * device id if the prod_id_reg variable is set.
> + *
>   * Returns 0 if the device is operational, a negative error code otherwi=
se.
>   *
>   * This function should be called early on in the device initialization =
sequence
>   * to ensure that the device is in a sane and known state and that it is=
 usable.
>   */
> -int adis_initial_startup(struct adis *adis)
> +int __adis_initial_startup(struct adis *adis)
>  {
>  	int ret;
> -
> -	mutex_lock(&adis->state_lock);
> +	struct gpio_desc *gpio;
> +	const struct adis_timeout *timeouts =3D adis->data->timeouts;
> +	const char *iio_name =3D spi_get_device_id(adis->spi)->name;
> +	u16 prod_id, dev_id;
> +
> +	/* check if the device has rst pin low */
> +	gpio =3D devm_gpiod_get_optional(&adis->spi->dev, "reset", GPIOD_ASIS);
> +	if (IS_ERR(gpio)) {
> +		return PTR_ERR(gpio);

Given you are returning here, no need for else to follow

if (gpio...

> +	} else if (gpio && gpiod_get_value_cansleep(gpio)) {
> +		/* bring device out of reset */
> +		gpiod_set_value_cansleep(gpio, 0);

Hmm. So is a software reset the best option if we have a hardware reset
line but it's not currently in the reset mode?

> +		msleep(timeouts->reset_ms);
> +	} else {
> +		ret =3D __adis_reset(adis);
> +		if (ret)
> +			return ret;
> +	}
> =20
>  	ret =3D adis_self_test(adis);
> -	if (ret) {
> -		dev_err(&adis->spi->dev, "Self-test failed, trying reset.\n");
> -		__adis_reset(adis);
> -		ret =3D adis_self_test(adis);
> -		if (ret) {
> -			dev_err(&adis->spi->dev, "Second self-test failed, giving up.\n");
> -			goto out_unlock;
> -		}
> -	}
> +	if (ret)
> +		return ret;
> =20
> -out_unlock:
> -	mutex_unlock(&adis->state_lock);
> -	return ret;
> +	if (!adis->data->prod_id_reg)
> +		return 0;
> +
> +	ret =3D adis_read_reg_16(adis, adis->data->prod_id_reg, &prod_id);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D sscanf(iio_name, "adis%hu\n", &dev_id);

Hmm. I have a general dislike of pulling part name strings apart to get
IDs.  It tends to break when someone comes along and adds a part with new
branding.  Perhaps just put it in the relevant device part specific structu=
res
directly?

> +	if (ret !=3D 1)
> +		return -EINVAL;
> +
> +	if (prod_id !=3D dev_id)
> +		dev_warn(&adis->spi->dev,
> +			 "Device ID(%u) and product ID(%u) do not match.",
> +			 dev_id, prod_id);
> +
> +	return 0;
>  }
> -EXPORT_SYMBOL_GPL(adis_initial_startup);
> +EXPORT_SYMBOL_GPL(__adis_initial_startup);
> =20
>  /**
>   * adis_single_conversion() - Performs a single sample conversion
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index d21a013d1122..c43e7922ab32 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -41,6 +41,7 @@ struct adis_timeout {
>   * @glob_cmd_reg: Register address of the GLOB_CMD register
>   * @msc_ctrl_reg: Register address of the MSC_CTRL register
>   * @diag_stat_reg: Register address of the DIAG_STAT register
> + * @prod_id_reg: Register address of the PROD_ID register
>   * @self_test_reg: Register address to request self test command
>   * @status_error_msgs: Array of error messgaes
>   * @status_error_mask:
> @@ -54,6 +55,7 @@ struct adis_data {
>  	unsigned int glob_cmd_reg;
>  	unsigned int msc_ctrl_reg;
>  	unsigned int diag_stat_reg;
> +	unsigned int prod_id_reg;
> =20
>  	unsigned int self_test_mask;
>  	unsigned int self_test_reg;
> @@ -299,6 +301,7 @@ static inline int adis_read_reg_32(struct adis *adis,=
 unsigned int reg,
> =20
>  int adis_enable_irq(struct adis *adis, bool enable);
>  int __adis_check_status(struct adis *adis);
> +int __adis_initial_startup(struct adis *adis);
> =20
>  static inline int adis_check_status(struct adis *adis)
>  {
> @@ -311,7 +314,17 @@ static inline int adis_check_status(struct adis *adi=
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

