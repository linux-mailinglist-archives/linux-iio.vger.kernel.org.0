Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0796138127
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 12:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgAKLfs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 06:35:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbgAKLfs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 06:35:48 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFDBB20673;
        Sat, 11 Jan 2020 11:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578742547;
        bh=U2YJi8SazhqshG6jcTn2DiVpE+zrlZAMRGuXimhCAfk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UjjEAy771+w5OOhwyWpPDKp8cGkgYEB3qMYfX4plFZR0WTRMPwOrT6lItnrXZdJho
         qIjFTviB/78/9tKCxoZkZJ7v5JJIhjoFSoplwtJgE3AQHb4xmrgCbVvUPQ6VxOLV+L
         E+UYJ4eMn8O0p5Mr+CIv5GMdJJ4I3CgcguL3Gn2s=
Date:   Sat, 11 Jan 2020 11:35:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 2/2] iio: adis: Remove startup_delay
Message-ID: <20200111113544.1a5e0cce@archlinux>
In-Reply-To: <20200107111705.24138-2-alexandru.ardelean@analog.com>
References: <20200107111705.24138-1-alexandru.ardelean@analog.com>
        <20200107111705.24138-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 Jan 2020 13:17:05 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> All timeouts are now handled by a dedicated timeout struct. This
> variable is no longer needed.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adis16201.c         | 1 -
>  drivers/iio/accel/adis16209.c         | 1 -
>  drivers/iio/gyro/adis16136.c          | 1 -
>  drivers/iio/gyro/adis16260.c          | 1 -
>  drivers/iio/imu/adis16400.c           | 1 -
>  drivers/staging/iio/accel/adis16203.c | 1 -
>  drivers/staging/iio/accel/adis16240.c | 1 -
>  include/linux/iio/imu/adis.h          | 1 -
>  8 files changed, 8 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index c92d22387b01..0f0f27a8184e 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -247,7 +247,6 @@ static const struct adis_data adis16201_data =3D {
> =20
>  	.self_test_mask =3D ADIS16201_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear =3D true,
> -	.startup_delay =3D ADIS16201_STARTUP_DELAY_MS,
>  	.timeouts =3D &adis16201_timeouts,
> =20
>  	.status_error_msgs =3D adis16201_status_error_msgs,
> diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
> index f5a78fc11919..c6dbd2424e10 100644
> --- a/drivers/iio/accel/adis16209.c
> +++ b/drivers/iio/accel/adis16209.c
> @@ -257,7 +257,6 @@ static const struct adis_data adis16209_data =3D {
> =20
>  	.self_test_mask =3D ADIS16209_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear =3D true,
> -	.startup_delay =3D ADIS16209_STARTUP_DELAY_MS,
>  	.timeouts =3D &adis16209_timeouts,
> =20
>  	.status_error_msgs =3D adis16209_status_error_msgs,
> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> index dc91d8df7697..d5e03a406d4a 100644
> --- a/drivers/iio/gyro/adis16136.c
> +++ b/drivers/iio/gyro/adis16136.c
> @@ -472,7 +472,6 @@ static const struct adis_data adis16136_data =3D {
>  	.msc_ctrl_reg =3D ADIS16136_REG_MSC_CTRL,
> =20
>  	.self_test_mask =3D ADIS16136_MSC_CTRL_SELF_TEST,
> -	.startup_delay =3D 80,
> =20
>  	.read_delay =3D 10,
>  	.write_delay =3D 10,
> diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
> index 0e3a66a7726d..be09b3e5910c 100644
> --- a/drivers/iio/gyro/adis16260.c
> +++ b/drivers/iio/gyro/adis16260.c
> @@ -346,7 +346,6 @@ static const struct adis_data adis16260_data =3D {
>  	.diag_stat_reg =3D ADIS16260_DIAG_STAT,
> =20
>  	.self_test_mask =3D ADIS16260_MSC_CTRL_MEM_TEST,
> -	.startup_delay =3D ADIS16260_STARTUP_DELAY,
>  	.timeouts =3D &adis16260_timeouts,
> =20
>  	.status_error_msgs =3D adis1620_status_error_msgs,
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index 51b1ec23b8ef..cfb1c19eb930 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -1126,7 +1126,6 @@ static const struct adis_data adis16400_data =3D {
>  	.write_delay =3D 50,
> =20
>  	.self_test_mask =3D ADIS16400_MSC_CTRL_MEM_TEST,
> -	.startup_delay =3D ADIS16400_STARTUP_DELAY,
> =20
>  	.status_error_msgs =3D adis16400_status_error_msgs,
>  	.status_error_mask =3D BIT(ADIS16400_DIAG_STAT_ZACCL_FAIL) |
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/=
accel/adis16203.c
> index 3d706ee02df0..39dfe3f7f254 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -251,7 +251,6 @@ static const struct adis_data adis16203_data =3D {
> =20
>  	.self_test_mask =3D ADIS16203_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear =3D true,
> -	.startup_delay =3D ADIS16203_STARTUP_DELAY,
>  	.timeouts =3D &adis16203_timeouts,
> =20
>  	.status_error_msgs =3D adis16203_status_error_msgs,
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/=
accel/adis16240.c
> index d4848ef78c75..39eb8364aa95 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -374,7 +374,6 @@ static const struct adis_data adis16240_data =3D {
> =20
>  	.self_test_mask =3D ADIS16240_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear =3D true,
> -	.startup_delay =3D ADIS16240_STARTUP_DELAY,
>  	.timeouts =3D &adis16240_timeouts,
> =20
>  	.status_error_msgs =3D adis16240_status_error_msgs,
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 853dc8c8365c..d2fcf45b4cef 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -56,7 +56,6 @@ struct adis_data {
> =20
>  	unsigned int self_test_mask;
>  	bool self_test_no_autoclear;
> -	unsigned int startup_delay;
>  	const struct adis_timeout *timeouts;
> =20
>  	const char * const *status_error_msgs;

