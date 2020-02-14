Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E3215D992
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgBNOdK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgBNOdK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:33:10 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E94BA206B6;
        Fri, 14 Feb 2020 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581690788;
        bh=OUtXjH/bwgJfj15ODqoF2udLtPTr1aUdfe6Yecgxzk0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f6HeMPn0ob6FzHmSsUWdJp6xwHZC3fp5eM+A6Bg7H1t3Jb6nAMQBnOuL0oVR6/DOp
         mHDvt67ZhmjoMYmm01D702XvRQkRRVsvPcbaix1R6lglhSiqWLqp59+RXoBUasLSqw
         pBNGGYwENohSKCDPZjOMSlzh8gab362jO9B0lrtU=
Date:   Fri, 14 Feb 2020 14:33:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nuno.sa@analog.com>
Subject: Re: [PATCH v2 5/9] iio: imu: adis: Add self_test_reg variable
Message-ID: <20200214143305.5c991182@archlinux>
In-Reply-To: <20200210132606.9315-5-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
        <20200210132606.9315-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Feb 2020 15:26:02 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> This patch adds a dedicated self_test_reg variable. This is also a step
> to let new drivers make use of `adis_initial_startup()`. Some devices
> use MSG_CTRL reg to request a self_test command while others use the
> GLOB_CMD register.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

thanks,
> ---
>  drivers/iio/accel/adis16201.c         | 1 +
>  drivers/iio/accel/adis16209.c         | 1 +
>  drivers/iio/gyro/adis16136.c          | 1 +
>  drivers/iio/gyro/adis16260.c          | 1 +
>  drivers/iio/imu/adis.c                | 6 +++---
>  drivers/iio/imu/adis16400.c           | 1 +
>  drivers/iio/imu/adis16460.c           | 2 ++
>  drivers/iio/imu/adis16480.c           | 1 +
>  drivers/staging/iio/accel/adis16203.c | 1 +
>  drivers/staging/iio/accel/adis16240.c | 1 +
>  include/linux/iio/imu/adis.h          | 2 ++
>  11 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index 0f0f27a8184e..4154e7396bbe 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -246,6 +246,7 @@ static const struct adis_data adis16201_data =3D {
>  	.diag_stat_reg =3D ADIS16201_DIAG_STAT_REG,
> =20
>  	.self_test_mask =3D ADIS16201_MSC_CTRL_SELF_TEST_EN,
> +	.self_test_reg =3D ADIS16201_MSC_CTRL_REG,
>  	.self_test_no_autoclear =3D true,
>  	.timeouts =3D &adis16201_timeouts,
> =20
> diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
> index c6dbd2424e10..31d45e7c5485 100644
> --- a/drivers/iio/accel/adis16209.c
> +++ b/drivers/iio/accel/adis16209.c
> @@ -256,6 +256,7 @@ static const struct adis_data adis16209_data =3D {
>  	.diag_stat_reg =3D ADIS16209_STAT_REG,
> =20
>  	.self_test_mask =3D ADIS16209_MSC_CTRL_SELF_TEST_EN,
> +	.self_test_reg =3D ADIS16209_MSC_CTRL_REG,
>  	.self_test_no_autoclear =3D true,
>  	.timeouts =3D &adis16209_timeouts,
> =20
> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> index 1db1131e5c67..a4c967a5fc5c 100644
> --- a/drivers/iio/gyro/adis16136.c
> +++ b/drivers/iio/gyro/adis16136.c
> @@ -471,6 +471,7 @@ static const char * const adis16136_status_error_msgs=
[] =3D {
>  	.diag_stat_reg =3D ADIS16136_REG_DIAG_STAT,			\
>  	.glob_cmd_reg =3D ADIS16136_REG_GLOB_CMD,				\
>  	.msc_ctrl_reg =3D ADIS16136_REG_MSC_CTRL,				\
> +	.self_test_reg =3D ADIS16136_REG_MSC_CTRL,			\
>  	.self_test_mask =3D ADIS16136_MSC_CTRL_SELF_TEST,			\
>  	.read_delay =3D 10,						\
>  	.write_delay =3D 10,						\
> diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
> index be09b3e5910c..9823573e811a 100644
> --- a/drivers/iio/gyro/adis16260.c
> +++ b/drivers/iio/gyro/adis16260.c
> @@ -346,6 +346,7 @@ static const struct adis_data adis16260_data =3D {
>  	.diag_stat_reg =3D ADIS16260_DIAG_STAT,
> =20
>  	.self_test_mask =3D ADIS16260_MSC_CTRL_MEM_TEST,
> +	.self_test_reg =3D ADIS16260_MSC_CTRL,
>  	.timeouts =3D &adis16260_timeouts,
> =20
>  	.status_error_msgs =3D adis1620_status_error_msgs,
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index e4897dad34ab..f7845a90f376 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -346,8 +346,8 @@ static int adis_self_test(struct adis *adis)
>  	int ret;
>  	const struct adis_timeout *timeouts =3D adis->data->timeouts;
> =20
> -	ret =3D __adis_write_reg_16(adis, adis->data->msc_ctrl_reg,
> -			adis->data->self_test_mask);
> +	ret =3D __adis_write_reg_16(adis, adis->data->self_test_reg,
> +				  adis->data->self_test_mask);
>  	if (ret) {
>  		dev_err(&adis->spi->dev, "Failed to initiate self test: %d\n",
>  			ret);
> @@ -359,7 +359,7 @@ static int adis_self_test(struct adis *adis)
>  	ret =3D __adis_check_status(adis);
> =20
>  	if (adis->data->self_test_no_autoclear)
> -		__adis_write_reg_16(adis, adis->data->msc_ctrl_reg, 0x00);
> +		__adis_write_reg_16(adis, adis->data->self_test_reg, 0x00);
> =20
>  	return ret;
>  }
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index 1c0770e03ec9..05e70c1c4835 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -956,6 +956,7 @@ static const char * const adis16400_status_error_msgs=
[] =3D {
>  	.read_delay =3D 50,						\
>  	.write_delay =3D 50,						\
>  	.self_test_mask =3D ADIS16400_MSC_CTRL_MEM_TEST,			\
> +	.self_test_reg =3D ADIS16400_MSC_CTRL,				\
>  	.status_error_msgs =3D adis16400_status_error_msgs,		\
>  	.status_error_mask =3D BIT(ADIS16400_DIAG_STAT_ZACCL_FAIL) |	\
>  		BIT(ADIS16400_DIAG_STAT_YACCL_FAIL) |			\
> diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> index 9539cfe4a259..42fa473c6d81 100644
> --- a/drivers/iio/imu/adis16460.c
> +++ b/drivers/iio/imu/adis16460.c
> @@ -392,6 +392,8 @@ static const struct adis_timeout adis16460_timeouts =
=3D {
>  static const struct adis_data adis16460_data =3D {
>  	.diag_stat_reg =3D ADIS16460_REG_DIAG_STAT,
>  	.glob_cmd_reg =3D ADIS16460_REG_GLOB_CMD,
> +	.self_test_mask =3D BIT(2),
> +	.self_test_reg =3D ADIS16460_REG_GLOB_CMD,
>  	.has_paging =3D false,
>  	.read_delay =3D 5,
>  	.write_delay =3D 5,
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 4c4de1b62769..acbe1701fc2d 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -830,6 +830,7 @@ static int adis16480_enable_irq(struct adis *adis, bo=
ol enable);
>  	.read_delay =3D 5,						\
>  	.write_delay =3D 5,						\
>  	.self_test_mask =3D BIT(1),					\
> +	.self_test_reg =3D ADIS16480_REG_GLOB_CMD,			\
>  	.status_error_msgs =3D adis16480_status_error_msgs,		\
>  	.status_error_mask =3D BIT(ADIS16480_DIAG_STAT_XGYRO_FAIL) |	\
>  		BIT(ADIS16480_DIAG_STAT_YGYRO_FAIL) |			\
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/=
accel/adis16203.c
> index 39dfe3f7f254..fef52d9b5346 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -250,6 +250,7 @@ static const struct adis_data adis16203_data =3D {
>  	.diag_stat_reg =3D ADIS16203_DIAG_STAT,
> =20
>  	.self_test_mask =3D ADIS16203_MSC_CTRL_SELF_TEST_EN,
> +	.self_test_reg =3D ADIS16203_MSC_CTRL,
>  	.self_test_no_autoclear =3D true,
>  	.timeouts =3D &adis16203_timeouts,
> =20
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/=
accel/adis16240.c
> index 39eb8364aa95..8bd35c6c56a1 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -373,6 +373,7 @@ static const struct adis_data adis16240_data =3D {
>  	.diag_stat_reg =3D ADIS16240_DIAG_STAT,
> =20
>  	.self_test_mask =3D ADIS16240_MSC_CTRL_SELF_TEST_EN,
> +	.self_test_reg =3D ADIS16240_MSC_CTRL,
>  	.self_test_no_autoclear =3D true,
>  	.timeouts =3D &adis16240_timeouts,
> =20
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 15e75670f923..b7feca4e5f26 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -41,6 +41,7 @@ struct adis_timeout {
>   * @glob_cmd_reg: Register address of the GLOB_CMD register
>   * @msc_ctrl_reg: Register address of the MSC_CTRL register
>   * @diag_stat_reg: Register address of the DIAG_STAT register
> + * @self_test_reg: Register address to request self test command
>   * @status_error_msgs: Array of error messgaes
>   * @status_error_mask:
>   * @timeouts: Chip specific delays
> @@ -55,6 +56,7 @@ struct adis_data {
>  	unsigned int diag_stat_reg;
> =20
>  	unsigned int self_test_mask;
> +	unsigned int self_test_reg;
>  	bool self_test_no_autoclear;
>  	const struct adis_timeout *timeouts;
> =20

