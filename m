Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F010311F8D3
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 17:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfLOQSx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 11:18:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfLOQSx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Dec 2019 11:18:53 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CE1A206D7;
        Sun, 15 Dec 2019 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576426731;
        bh=3gWrFECQ4JB7+4udxE5anmcclq9pSjQUlEM5geJjlQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AYfbrtGFK7MIaOhIBC04U7fy1WDOjWhQpr2zNYle7kYM+HzKBWPemGjd9Qul6SjeS
         vNhxhzaaXOpkOaSDwuH6+/9wGsWyGJsaYDOAY6yRc+lfeuFMpl2yQRoKqzjulnM943
         KTI6P2Vmj/onOUjoIk9GCGmk4QN8XYKqXlIeY49g=
Date:   Sun, 15 Dec 2019 16:18:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH 1/5] iio: gyro: adi16136: construct adis data on probe
 vs static on driver
Message-ID: <20191215161847.21c67f00@archlinux>
In-Reply-To: <20191213160312.1834-1-alexandru.ardelean@analog.com>
References: <20191213160312.1834-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Dec 2019 18:03:08 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change is done in preparation of adding an `struct adis_timeout` typ=
e.
> Some ADIS drivers support multiple drivers, with various combinations of
> timeouts. Creating static tables for each driver is possible, but that al=
so
> creates quite a lot of duplication.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

There are considerable advantages to using constant structures,
(security - not that relevant here probably, XiP, general readability)

So to take a series like this I want to see evidence that it makes
a significant difference.  So far you just have cases where we end up
with a worse result.  More code, harder to read...

Hence it will take a lot to persuade me to take this series without
the follow up patches where I assume significant advantages are seen.

Jonathan


> ---
>  drivers/iio/gyro/adis16136.c | 49 ++++++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> index f10c4f173898..129de2bd5845 100644
> --- a/drivers/iio/gyro/adis16136.c
> +++ b/drivers/iio/gyro/adis16136.c
> @@ -465,24 +465,6 @@ static const char * const adis16136_status_error_msg=
s[] =3D {
>  	[ADIS16136_DIAG_STAT_FLASH_CHKSUM_FAIL] =3D "Flash checksum error",
>  };
> =20
> -static const struct adis_data adis16136_data =3D {
> -	.diag_stat_reg =3D ADIS16136_REG_DIAG_STAT,
> -	.glob_cmd_reg =3D ADIS16136_REG_GLOB_CMD,
> -	.msc_ctrl_reg =3D ADIS16136_REG_MSC_CTRL,
> -
> -	.self_test_mask =3D ADIS16136_MSC_CTRL_SELF_TEST,
> -	.startup_delay =3D 80,
> -
> -	.read_delay =3D 10,
> -	.write_delay =3D 10,
> -
> -	.status_error_msgs =3D adis16136_status_error_msgs,
> -	.status_error_mask =3D BIT(ADIS16136_DIAG_STAT_FLASH_UPDATE_FAIL) |
> -		BIT(ADIS16136_DIAG_STAT_SPI_FAIL) |
> -		BIT(ADIS16136_DIAG_STAT_SELF_TEST_FAIL) |
> -		BIT(ADIS16136_DIAG_STAT_FLASH_CHKSUM_FAIL),
> -};
> -
>  enum adis16136_id {
>  	ID_ADIS16133,
>  	ID_ADIS16135,
> @@ -509,11 +491,36 @@ static const struct adis16136_chip_info adis16136_c=
hip_info[] =3D {
>  	},
>  };
> =20
> +static struct adis_data *adis16136_adis_data_alloc(struct adis16136 *st,
> +						   struct device *dev)
> +{
> +	struct adis_data *data;
> +
> +	data =3D devm_kzalloc(dev, sizeof(struct adis_data), GFP_KERNEL);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	data->msc_ctrl_reg =3D ADIS16136_REG_MSC_CTRL;
> +	data->glob_cmd_reg =3D ADIS16136_REG_GLOB_CMD;
> +	data->diag_stat_reg =3D ADIS16136_REG_DIAG_STAT;
> +	data->self_test_mask =3D ADIS16136_MSC_CTRL_SELF_TEST;
> +	data->read_delay =3D 10;
> +	data->write_delay =3D 10;
> +	data->status_error_msgs =3D adis16136_status_error_msgs;
> +	data->status_error_mask =3D BIT(ADIS16136_DIAG_STAT_FLASH_UPDATE_FAIL) |
> +				BIT(ADIS16136_DIAG_STAT_SPI_FAIL) |
> +				BIT(ADIS16136_DIAG_STAT_SELF_TEST_FAIL) |
> +				BIT(ADIS16136_DIAG_STAT_FLASH_CHKSUM_FAIL);
> +
> +	return data;
> +}
> +
>  static int adis16136_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id =3D spi_get_device_id(spi);
>  	struct adis16136 *adis16136;
>  	struct iio_dev *indio_dev;
> +	const struct adis_data *adis16136_data;
>  	int ret;
> =20
>  	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*adis16136));
> @@ -532,7 +539,11 @@ static int adis16136_probe(struct spi_device *spi)
>  	indio_dev->info =3D &adis16136_info;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =20
> -	ret =3D adis_init(&adis16136->adis, indio_dev, spi, &adis16136_data);
> +	adis16136_data =3D adis16136_adis_data_alloc(adis16136, &spi->dev);
> +	if (IS_ERR(adis16136_data))
> +		return PTR_ERR(adis16136_data);
> +
> +	ret =3D adis_init(&adis16136->adis, indio_dev, spi, adis16136_data);
>  	if (ret)
>  		return ret;
> =20

