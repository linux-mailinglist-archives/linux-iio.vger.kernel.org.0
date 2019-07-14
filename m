Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3361F67FFC
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfGNP5h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 11:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728125AbfGNP5h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 11:57:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA7342063F;
        Sun, 14 Jul 2019 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563119856;
        bh=utLT91xaeQmRJrKRGtcBbsiE7zMJNA1w8DifIgBNQd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LuLKMrDIKO2GY6QVDuP60rsE/r02YaFGO9VVAKj2dAoV7Yk1/KhV0FwsQiUlQRaug
         KFWv3fxXNQetzPd4arcrB/ktHcVMUvhtetjzbLY5SNl4AnIZdwxSskO4ubO8mcWbHK
         g7PRtziOLrVVrcxOqoNaYLF0qxG0B8ndD3ep8Ey8=
Date:   Sun, 14 Jul 2019 16:57:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 5/5] iio: adc: ad7606: Add debug mode for ad7616
Message-ID: <20190714165721.3f9a3bfb@archlinux>
In-Reply-To: <20190703143648.24402-5-beniamin.bia@analog.com>
References: <20190703143648.24402-1-beniamin.bia@analog.com>
        <20190703143648.24402-5-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 3 Jul 2019 17:36:48 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Support for register access was added for devices which have software
> mode.
>=20
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
This and the first 3 patches all look fine to me.

Will pick them up once patch 4 is ready.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7606.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index be2330c8b277..ed2d08437e5d 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -60,6 +60,29 @@ static int ad7606_reset(struct ad7606_state *st)
>  	return -ENODEV;
>  }
> =20
> +static int ad7606_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	if (readval) {
> +		ret =3D st->bops->reg_read(st, reg);
> +		if (ret < 0)
> +			goto err_unlock;
> +		*readval =3D ret;
> +		ret =3D 0;
> +	} else {
> +		ret =3D st->bops->reg_write(st, reg, writeval);
> +	}
> +err_unlock:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
>  static int ad7606_read_samples(struct ad7606_state *st)
>  {
>  	unsigned int num =3D st->chip_info->num_channels;
> @@ -501,6 +524,14 @@ static const struct iio_info ad7606_info_os_and_rang=
e =3D {
>  	.validate_trigger =3D &ad7606_validate_trigger,
>  };
> =20
> +static const struct iio_info ad7606_info_os_range_and_debug =3D {
> +	.read_raw =3D &ad7606_read_raw,
> +	.write_raw =3D &ad7606_write_raw,
> +	.debugfs_reg_access =3D &ad7606_reg_access,
> +	.attrs =3D &ad7606_attribute_group_os_and_range,
> +	.validate_trigger =3D &ad7606_validate_trigger,
> +};
> +
>  static const struct iio_info ad7606_info_os =3D {
>  	.read_raw =3D &ad7606_read_raw,
>  	.write_raw =3D &ad7606_write_raw,
> @@ -617,7 +648,7 @@ int ad7606_probe(struct device *dev, int irq, void __=
iomem *base_address,
> =20
>  		/* After reset, in software mode, =C2=B110 V is set by default */
>  		memset32(st->range, 2, ARRAY_SIZE(st->range));
> -		indio_dev->info =3D &ad7606_info_os_and_range;
> +		indio_dev->info =3D &ad7606_info_os_range_and_debug;
> =20
>  		ret =3D st->bops->sw_mode_config(indio_dev);
>  		if (ret < 0)

