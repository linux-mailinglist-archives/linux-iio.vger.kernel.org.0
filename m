Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A621417AA
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 14:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgARNcU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 08:32:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbgARNcT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 08:32:19 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA93724699;
        Sat, 18 Jan 2020 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579354338;
        bh=+cFn0PMGaLPuNGL5qQ0ZQI56qAlfqxs08j8ybTZesCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O4W7g82w8iM6xU1Jh9uOHIwvw+8Hgn6Ap0Z/x4CJVVkz9kxJBXtbFP//MWbqc53+/
         E4SZ3a2KaQKFTDDGkVDlIfOcAOS/f/dhONwb9HrGyvx2k4mcPwwlKy1Pw9wnNxoevJ
         SX1O5ngOk1p1K0NwxF5jWRaELGAETPSVVud0wy8c=
Date:   Sat, 18 Jan 2020 13:32:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: imu/mpu6050: support dual-edge IRQ
Message-ID: <20200118133214.58142508@archlinux>
In-Reply-To: <8934b8d01f823f71b0fd66b16c832dbb47317cca.1578755864.git.mirq-linux@rere.qmqm.pl>
References: <8934b8d01f823f71b0fd66b16c832dbb47317cca.1578755864.git.mirq-linux@rere.qmqm.pl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 11 Jan 2020 16:19:11 +0100
Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl> wrote:

> Make mpu6050 usable on platforms which provide only any-edge interrupts.
> One example of this kind of platform is AT91SAM9G45
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if they can break anything.

Thanks,

Jonathan

>=20
> ---
> v3: reword commit message
> v2: just remove the dev_warn() message
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 2261c6c4ac65..4cfdd19ee4fc 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1118,7 +1118,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int i=
rq, const char *name,
>  	irq_type =3D irqd_get_trigger_type(desc);
>  	if (!irq_type)
>  		irq_type =3D IRQF_TRIGGER_RISING;
> -	if (irq_type =3D=3D IRQF_TRIGGER_RISING)
> +	if (irq_type & IRQF_TRIGGER_RISING)	// rising or both-edge
>  		st->irq_mask =3D INV_MPU6050_ACTIVE_HIGH;
>  	else if (irq_type =3D=3D IRQF_TRIGGER_FALLING)
>  		st->irq_mask =3D INV_MPU6050_ACTIVE_LOW;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_ring.c
> index 72d8c5790076..a8a833f8b99b 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -180,11 +180,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  			"failed to ack interrupt\n");
>  		goto flush_fifo;
>  	}
> -	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT)) {
> -		dev_warn(regmap_get_device(st->map),
> -			"spurious interrupt with status 0x%x\n", int_status);
> +	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))
>  		goto end_session;
> -	}
> =20
>  	if (!(st->chip_config.accl_fifo_enable |
>  		st->chip_config.gyro_fifo_enable))

