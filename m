Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C62515D9AB
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgBNOoe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:44:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgBNOoe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:44:34 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02CF92187F;
        Fri, 14 Feb 2020 14:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581691472;
        bh=Jd/SClKOykHFkTkevADdjXuqB9tJdoSeZkeSlwAdi/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pwExVZIi+L9vZ+yGxYqhGpJ6JrAmTNoOG7D31JJKUwMpuhs1Ke+fli2wuNp+44ED1
         5IIWcfR4hHvEI40hwLAG3SY6RmEfUp6CtPxkhlRg+XCBjBfbRTBMTO+DfLVhfa8O1g
         2Z8wgpIrORoYQHbKJ7MwGxk+0Dgu16UOFZKeOoHo=
Date:   Fri, 14 Feb 2020 14:44:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nuno.sa@analog.com>
Subject: Re: [PATCH v2 8/9] iio: adis16480: Make use of
 __adis_initial_startup
Message-ID: <20200214144425.737cf4f5@archlinux>
In-Reply-To: <20200210132606.9315-8-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
        <20200210132606.9315-8-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Feb 2020 15:26:05 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> All actions done in `adis16480_initial_setup()` are now done in
> `__adis_initial_startup()` so, there's no need for code duplication.
> Furthermore, the call to `adis16480_initial_setup()` is done before any
> device configuration since the device will be reset if not already (via
> rst pin). This is actually fixing a potential bug since `adis_reset()` was
> being called after configuring the device which is obviously a problem.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 80 +++++++++++--------------------------
>  1 file changed, 24 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index acbe1701fc2d..cfae0e4476e7 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -822,10 +822,12 @@ static const char * const adis16480_status_error_ms=
gs[] =3D {
> =20
>  static int adis16480_enable_irq(struct adis *adis, bool enable);
> =20
> -#define ADIS16480_DATA(_timeouts)					\
> +#define ADIS16480_DATA(_prod_id, _timeouts)				\
>  {									\
>  	.diag_stat_reg =3D ADIS16480_REG_DIAG_STS,			\
>  	.glob_cmd_reg =3D ADIS16480_REG_GLOB_CMD,				\
> +	.prod_id_reg =3D ADIS16480_REG_PROD_ID,				\
> +	.prod_id =3D (_prod_id),						\
>  	.has_paging =3D true,						\
>  	.read_delay =3D 5,						\
>  	.write_delay =3D 5,						\
> @@ -888,7 +890,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.int_clk =3D 2460000,
>  		.max_dec_rate =3D 2048,
>  		.filter_freqs =3D adis16480_def_filter_freqs,
> -		.adis_data =3D ADIS16480_DATA(&adis16485_timeouts),
> +		.adis_data =3D ADIS16480_DATA(16375, &adis16485_timeouts),
>  	},
>  	[ADIS16480] =3D {
>  		.channels =3D adis16480_channels,
> @@ -901,7 +903,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.int_clk =3D 2460000,
>  		.max_dec_rate =3D 2048,
>  		.filter_freqs =3D adis16480_def_filter_freqs,
> -		.adis_data =3D ADIS16480_DATA(&adis16480_timeouts),
> +		.adis_data =3D ADIS16480_DATA(16480, &adis16480_timeouts),
>  	},
>  	[ADIS16485] =3D {
>  		.channels =3D adis16485_channels,
> @@ -914,7 +916,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.int_clk =3D 2460000,
>  		.max_dec_rate =3D 2048,
>  		.filter_freqs =3D adis16480_def_filter_freqs,
> -		.adis_data =3D ADIS16480_DATA(&adis16485_timeouts),
> +		.adis_data =3D ADIS16480_DATA(16485, &adis16485_timeouts),
>  	},
>  	[ADIS16488] =3D {
>  		.channels =3D adis16480_channels,
> @@ -927,7 +929,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.int_clk =3D 2460000,
>  		.max_dec_rate =3D 2048,
>  		.filter_freqs =3D adis16480_def_filter_freqs,
> -		.adis_data =3D ADIS16480_DATA(&adis16485_timeouts),
> +		.adis_data =3D ADIS16480_DATA(16488, &adis16485_timeouts),
>  	},
>  	[ADIS16490] =3D {
>  		.channels =3D adis16485_channels,
> @@ -941,7 +943,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.max_dec_rate =3D 4250,
>  		.filter_freqs =3D adis16495_def_filter_freqs,
>  		.has_pps_clk_mode =3D true,
> -		.adis_data =3D ADIS16480_DATA(&adis16495_timeouts),
> +		.adis_data =3D ADIS16480_DATA(16490, &adis16495_timeouts),
>  	},
>  	[ADIS16495_1] =3D {
>  		.channels =3D adis16485_channels,
> @@ -955,7 +957,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.max_dec_rate =3D 4250,
>  		.filter_freqs =3D adis16495_def_filter_freqs,
>  		.has_pps_clk_mode =3D true,
> -		.adis_data =3D ADIS16480_DATA(&adis16495_1_timeouts),
> +		.adis_data =3D ADIS16480_DATA(16495, &adis16495_1_timeouts),
>  	},
>  	[ADIS16495_2] =3D {
>  		.channels =3D adis16485_channels,
> @@ -969,7 +971,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.max_dec_rate =3D 4250,
>  		.filter_freqs =3D adis16495_def_filter_freqs,
>  		.has_pps_clk_mode =3D true,
> -		.adis_data =3D ADIS16480_DATA(&adis16495_1_timeouts),
> +		.adis_data =3D ADIS16480_DATA(16495, &adis16495_1_timeouts),
>  	},
>  	[ADIS16495_3] =3D {
>  		.channels =3D adis16485_channels,
> @@ -983,7 +985,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.max_dec_rate =3D 4250,
>  		.filter_freqs =3D adis16495_def_filter_freqs,
>  		.has_pps_clk_mode =3D true,
> -		.adis_data =3D ADIS16480_DATA(&adis16495_1_timeouts),
> +		.adis_data =3D ADIS16480_DATA(16495, &adis16495_1_timeouts),
>  	},
>  	[ADIS16497_1] =3D {
>  		.channels =3D adis16485_channels,
> @@ -997,7 +999,7 @@ static const struct adis16480_chip_info adis16480_chi=
p_info[] =3D {
>  		.max_dec_rate =3D 4250,
>  		.filter_freqs =3D adis16495_def_filter_freqs,
>  		.has_pps_clk_mode =3D true,
> -		.adis_data =3D ADIS16480_DATA(&adis16495_1_timeouts),
> +		.adis_data =3D ADIS16480_DATA(16497, &adis16495_1_timeouts),
>  	},
>  	[ADIS16497_2] =3D {
>  		.channels =3D adis16485_channels,
> @@ -1011,7 +1013,7 @@ static const struct adis16480_chip_info adis16480_c=
hip_info[] =3D {
>  		.max_dec_rate =3D 4250,
>  		.filter_freqs =3D adis16495_def_filter_freqs,
>  		.has_pps_clk_mode =3D true,
> -		.adis_data =3D ADIS16480_DATA(&adis16495_1_timeouts),
> +		.adis_data =3D ADIS16480_DATA(16497, &adis16495_1_timeouts),
>  	},
>  	[ADIS16497_3] =3D {
>  		.channels =3D adis16485_channels,
> @@ -1025,7 +1027,7 @@ static const struct adis16480_chip_info adis16480_c=
hip_info[] =3D {
>  		.max_dec_rate =3D 4250,
>  		.filter_freqs =3D adis16495_def_filter_freqs,
>  		.has_pps_clk_mode =3D true,
> -		.adis_data =3D ADIS16480_DATA(&adis16495_1_timeouts),
> +		.adis_data =3D ADIS16480_DATA(16497, &adis16495_1_timeouts),
>  	},
>  };
> =20
> @@ -1064,40 +1066,6 @@ static int adis16480_enable_irq(struct adis *adis,=
 bool enable)
>  	return __adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
>  }
> =20
> -static int adis16480_initial_setup(struct iio_dev *indio_dev)
> -{
> -	struct adis16480 *st =3D iio_priv(indio_dev);
> -	uint16_t prod_id;
> -	unsigned int device_id;
> -	int ret;
> -
> -	adis_reset(&st->adis);
> -	msleep(70);
> -
> -	ret =3D adis_write_reg_16(&st->adis, ADIS16480_REG_GLOB_CMD, BIT(1));
> -	if (ret)
> -		return ret;
> -	msleep(30);
> -
> -	ret =3D adis_check_status(&st->adis);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D adis_read_reg_16(&st->adis, ADIS16480_REG_PROD_ID, &prod_id);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D sscanf(indio_dev->name, "adis%u\n", &device_id);
> -	if (ret !=3D 1)
> -		return -EINVAL;
> -
> -	if (prod_id !=3D device_id)
> -		dev_warn(&indio_dev->dev, "Device ID(%u) and product ID(%u) do not mat=
ch.",
> -				device_id, prod_id);
> -
> -	return 0;
> -}
> -
>  static int adis16480_config_irq_pin(struct device_node *of_node,
>  				    struct adis16480 *st)
>  {
> @@ -1278,18 +1246,22 @@ static int adis16480_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D adis16480_config_irq_pin(spi->dev.of_node, st);
> +	ret =3D __adis_initial_startup(&st->adis);
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D adis16480_config_irq_pin(spi->dev.of_node, st);
> +	if (ret)
> +		goto error_stop_device;
> +
>  	ret =3D adis16480_get_ext_clocks(st);
>  	if (ret)
> -		return ret;
> +		goto error_stop_device;
> =20
>  	if (!IS_ERR_OR_NULL(st->ext_clk)) {
>  		ret =3D adis16480_ext_clk_config(st, spi->dev.of_node, true);
>  		if (ret)
> -			return ret;
> +			goto error_stop_device;
> =20
>  		st->clk_freq =3D clk_get_rate(st->ext_clk);
>  		st->clk_freq *=3D 1000; /* micro */
> @@ -1301,24 +1273,20 @@ static int adis16480_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_clk_disable_unprepare;
> =20
> -	ret =3D adis16480_initial_setup(indio_dev);
> -	if (ret)
> -		goto error_cleanup_buffer;
> -
>  	ret =3D iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_stop_device;
> +		goto error_cleanup_buffer;
> =20
>  	adis16480_debugfs_init(indio_dev);
> =20
>  	return 0;
> =20
> -error_stop_device:
> -	adis16480_stop_device(indio_dev);
>  error_cleanup_buffer:
>  	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
>  error_clk_disable_unprepare:
>  	clk_disable_unprepare(st->ext_clk);
> +error_stop_device:
> +	adis16480_stop_device(indio_dev);
>  	return ret;
>  }
> =20

