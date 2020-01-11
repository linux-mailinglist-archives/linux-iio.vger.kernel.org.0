Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 338F513814E
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 13:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgAKMKw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 07:10:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgAKMKw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 07:10:52 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8228520678;
        Sat, 11 Jan 2020 12:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578744651;
        bh=6Gv+nt5Z9CLF/Y0YWRCq4mKnmsj8Xz+0ADRolnCe4D0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W90fwS/7eymyrDtXV+FlTF9c0Iti4GHjkNKW8Z/NoKJO7RMeK11dmhdfQ3YSsl7ra
         RfCR9ukJiov+tgBOS6GtobfQig/nO0wwNhri3uM/LuoyrGubXJPYruKS+8JdGR03m8
         tfT5GVgepgI9r+rPLYTbGkE/WoXzLpsS6X9YrCyQ=
Date:   Sat, 11 Jan 2020 12:10:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu/mpu6050: support dual-edge IRQ
Message-ID: <20200111121047.79e16365@archlinux>
In-Reply-To: <e5b39c16dc6dcb25324f6e8389cc0d0f895c1cbd.1578309319.git.mirq-linux@rere.qmqm.pl>
References: <MN2PR12MB33737F067F25B2F7477C4FE5C43C0@MN2PR12MB3373.namprd12.prod.outlook.com>
        <e5b39c16dc6dcb25324f6e8389cc0d0f895c1cbd.1578309319.git.mirq-linux@rere.qmqm.pl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 06 Jan 2020 12:17:54 +0100
Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl> wrote:

> Make mpu6050 usable on platforms which provide only any-edge interrupts.
> This also covers shared interrupt case.

So this had me confused for a bit because I assumed we were trying to make
a level interrupt providing device work with edge interrupts.  Seems
device supports a pulsed  mode and the driver supports this.

Why do we want to detect on both edges?  Do you have a crazy board
with this shared and some devices using the rising edge and some the fallin=
g one?

For shared case it should return that it did not handle the interrupt
to allow spurious interrupt detection to work...

Jonathan

>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

>=20
> ---
> v2:
>    just remove the dev_warn() message
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 0686e41bb8a1..b3d138091f89 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1241,7 +1241,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int i=
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
> index 10d16ec5104b..a4dc2c4a3ca5 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -183,11 +183,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
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
>  		st->chip_config.gyro_fifo_enable |

