Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA3677E83
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 09:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfG1H7F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 03:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfG1H7E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jul 2019 03:59:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC9422085A;
        Sun, 28 Jul 2019 07:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564300743;
        bh=fycF8RP0WU9/NMk4CEpQiYWpTGtseQg109lSyQuWX+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DP5jcM6ghA252s4jw5KpnPb7oHKBYP0OL00XmPG5j/WzsNRN2XYSubEj+vZ9djxzG
         DtG7KWxF5jZABowMVA3ffQOuBueEE1E461hFttQf28jYegyo7ldVz2JX4jNwRoW/wW
         vmGAA1EW6afLWLOXvTO86SiJkRXjI0iI93VI3kqY=
Date:   Sun, 28 Jul 2019 08:58:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <biabeniamin@outlook.com>
Subject: Re: [PATCH 5/5] iio: adc: ad7606: Add debug mode for ad7616
Message-ID: <20190728085859.2c5c2932@archlinux>
In-Reply-To: <20190718062734.17306-5-beniamin.bia@analog.com>
References: <20190718062734.17306-1-beniamin.bia@analog.com>
        <20190718062734.17306-5-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 09:27:34 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Support for register access was added for devices which have software
> mode.
>=20
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> -nothing changed
>=20
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

