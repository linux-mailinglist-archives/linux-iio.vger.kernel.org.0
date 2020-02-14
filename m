Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA81E15D9AE
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbgBNOpU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387435AbgBNOpT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:45:19 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F6D2187F;
        Fri, 14 Feb 2020 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581691519;
        bh=YjV/0M1BF3XZrKj6Jps/vOoHoV3Dd7RWf7IDUsjJ6JU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zBwWu3Y19f5sLYVk0k2RRpCzmIIMLa4G+hl6C1S2HKmrGXLf+6azjYQ/3FAMSi54N
         T9gXZkhaRjyD5T61yxqkHKCLiYbb6OLFfeddfq/0cd6SCJpabfzf85FtucdDZ7rYCC
         +oR9AmCZ36WMApcNayC3MVcHcY8W5IGJTmuPhllM=
Date:   Fri, 14 Feb 2020 14:45:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nuno.sa@analog.com>
Subject: Re: [PATCH v2 9/9] iio: adis16460: Make use of
 __adis_initial_startup
Message-ID: <20200214144515.64ed70be@archlinux>
In-Reply-To: <20200210132606.9315-9-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
        <20200210132606.9315-9-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Feb 2020 15:26:06 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> All of the actions done in `adis16460_initial_setup()` are now done in
> `__adis_initial_startup()` so, there's no need for code duplication.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16460.c | 38 +++----------------------------------
>  1 file changed, 3 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> index 42fa473c6d81..0027683d0256 100644
> --- a/drivers/iio/imu/adis16460.c
> +++ b/drivers/iio/imu/adis16460.c
> @@ -333,40 +333,6 @@ static int adis16460_enable_irq(struct adis *adis, b=
ool enable)
>  	return 0;
>  }
> =20
> -static int adis16460_initial_setup(struct iio_dev *indio_dev)
> -{
> -	struct adis16460 *st =3D iio_priv(indio_dev);
> -	uint16_t prod_id;
> -	unsigned int device_id;
> -	int ret;
> -
> -	adis_reset(&st->adis);
> -	msleep(222);
> -
> -	ret =3D adis_write_reg_16(&st->adis, ADIS16460_REG_GLOB_CMD, BIT(1));
> -	if (ret)
> -		return ret;
> -	msleep(75);
> -
> -	ret =3D adis_check_status(&st->adis);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D adis_read_reg_16(&st->adis, ADIS16460_REG_PROD_ID, &prod_id);
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
>  #define ADIS16460_DIAG_STAT_IN_CLK_OOS	7
>  #define ADIS16460_DIAG_STAT_FLASH_MEM	6
>  #define ADIS16460_DIAG_STAT_SELF_TEST	5
> @@ -392,6 +358,8 @@ static const struct adis_timeout adis16460_timeouts =
=3D {
>  static const struct adis_data adis16460_data =3D {
>  	.diag_stat_reg =3D ADIS16460_REG_DIAG_STAT,
>  	.glob_cmd_reg =3D ADIS16460_REG_GLOB_CMD,
> +	.prod_id_reg =3D ADIS16460_REG_PROD_ID,
> +	.prod_id =3D 16460,
>  	.self_test_mask =3D BIT(2),
>  	.self_test_reg =3D ADIS16460_REG_GLOB_CMD,
>  	.has_paging =3D false,
> @@ -441,7 +409,7 @@ static int adis16460_probe(struct spi_device *spi)
> =20
>  	adis16460_enable_irq(&st->adis, 0);
> =20
> -	ret =3D adis16460_initial_setup(indio_dev);
> +	ret =3D __adis_initial_startup(&st->adis);
>  	if (ret)
>  		goto error_cleanup_buffer;
> =20

