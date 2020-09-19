Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C616270FA5
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 18:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgISQv1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 12:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgISQv1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 12:51:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A44B320771;
        Sat, 19 Sep 2020 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600534285;
        bh=407cmM9XzM5T4W4zn5RfyBGfOUj8ejJ6letwig8rbkc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wQnBk8iYtX+CF7dj5G+k+CQfIvNVW5zwqgk1abPfyHLLFAEL5jXJgkOl2Yu+urmTo
         e2eiA4QZlumy0A4aiY8QUv0oqkJpkye7FQZ29kCng8yAQJKAVCpP6ZaUZ6H494eIBc
         e2/+GYusYtAHtu/exb9vpzO7Ka/nR5or23acyjN0=
Date:   Sat, 19 Sep 2020 17:51:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 17/27] iio:imu:inv_mpu6050 Fix dma and ts alignment
 and data leak issues.
Message-ID: <20200919175120.63570277@archlinux>
In-Reply-To: <MN2PR12MB4390D02D8798C05C3376991DC4770@MN2PR12MB4390.namprd12.prod.outlook.com>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-18-jic23@kernel.org>
        <MN2PR12MB4390D02D8798C05C3376991DC4770@MN2PR12MB4390.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Jul 2020 08:27:13 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
>=20
> looks perfect for me.
>=20
> Thanks for the fix,

No problem.

Applied with a slightly expanded comment on the length to explain
that less may be needed if not all channels are enabled as long
as the timestamp alignment is maintained.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke it.

thanks,

Jonathan

> JB
>=20
> Reviewed-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>=20
>=20
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> o=
n behalf of Jonathan Cameron <jic23@kernel.org>
> Sent: Wednesday, July 22, 2020 17:50
> To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; Lars-Peter Clausen <lars=
@metafoo.de>; Peter Meerwald <pmeerw@pmeerw.net>; Jonathan Cameron <Jonatha=
n.Cameron@huawei.com>; Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> Subject: [PATCH v3 17/27] iio:imu:inv_mpu6050 Fix dma and ts alignment an=
d data leak issues.=20
> =C2=A0
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This case is a bit different to the rest of the series.=C2=A0 The driver
> was doing a regmap_bulk_read into a buffer that wasn't dma safe
> as it was on the stack with no guarantee of it being in a cacheline
> on it's own.=C2=A0=C2=A0 Fixing that also dealt with the data leak and
> alignment issues that Lars-Peter pointed out.
>=20
> Also removed some unaligned handling as we are now aligned.
>=20
> Fixes tag is for the dma safe buffer issue. Potentially we would
> need to backport timestamp alignment futher but that is a totally
> different patch.
>=20
> Fixes: fd64df16f40e ("iio: imu: inv_mpu6050: Add SPI support for MPU6000")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> =C2=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=C2=A0 |=C2=A0 8 +++++---
> =C2=A0drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 12 +++++-------
> =C2=A02 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_iio.h
> index cd38b3fccc7b..e4df2d51b689 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -122,6 +122,9 @@ struct inv_mpu6050_chip_config {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 user_ctrl;
> =C2=A0};
> =C2=A0
> +/* 6 + 6 + 2 + 7 (for MPU9x50) =3D 21 round up to 24 and plus 8 */
> +#define INV_MPU6050_OUTPUT_DATA_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 32
> +
> =C2=A0/**
> =C2=A0 *=C2=A0 struct inv_mpu6050_hw - Other important hardware informati=
on.
> =C2=A0 *=C2=A0 @whoami:=C2=A0=C2=A0 Self identification byte from WHO_AM_=
I register
> @@ -165,6 +168,7 @@ struct inv_mpu6050_hw {
> =C2=A0 *=C2=A0 @magn_raw_to_gauss:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 coefficient to convert mag raw value to Gauss.
> =C2=A0 *=C2=A0 @magn_orient:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 magnetom=
eter sensor chip orientation if available.
> =C2=A0 *=C2=A0 @suspended_sensors:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sensors mask of sensors turned off for suspend
> + *=C2=A0 @data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dma safe buffer used for bulk reads.
> =C2=A0 */
> =C2=A0struct inv_mpu6050_state {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex lock;
> @@ -190,6 +194,7 @@ struct inv_mpu6050_state {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s32 magn_raw_to_gauss[3];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_mount_matrix =
magn_orient;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int suspended_s=
ensors;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 data[INV_MPU6050_OUTPUT_DATA_SIZ=
E] ____cacheline_aligned;
> =C2=A0};
> =C2=A0
> =C2=A0/*register and associated bit definition*/
> @@ -334,9 +339,6 @@ struct inv_mpu6050_state {
> =C2=A0#define INV_ICM20608_TEMP_OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8170
> =C2=A0#define INV_ICM20608_TEMP_SCALE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3059976
> =C2=A0
> -/* 6 + 6 + 2 + 7 (for MPU9x50) =3D 21 round up to 24 and plus 8 */
> -#define INV_MPU6050_OUTPUT_DATA_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 32
> -
> =C2=A0#define INV_MPU6050_REG_INT_PIN_CFG=C2=A0=C2=A0=C2=A0=C2=A0 0x37
> =C2=A0#define INV_MPU6050_ACTIVE_HIGH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x00
> =C2=A0#define INV_MPU6050_ACTIVE_LOW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x80
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_ring.c
> index b533fa2dad0a..d8e6b88ddffc 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -13,7 +13,6 @@
> =C2=A0#include <linux/interrupt.h>
> =C2=A0#include <linux/poll.h>
> =C2=A0#include <linux/math64.h>
> -#include <asm/unaligned.h>
> =C2=A0#include "inv_mpu_iio.h"
> =C2=A0
> =C2=A0/**
> @@ -121,7 +120,6 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_mpu6050_state=
 *st =3D iio_priv(indio_dev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t bytes_per_datum;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int result;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 data[INV_MPU6050_OUTPUT_DATA_SIZ=
E];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 fifo_count;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s64 timestamp;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int int_status;
> @@ -160,11 +158,11 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * read fifo_count =
register to know how many bytes are inside the FIFO
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * right now
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D regmap_bulk_read(st->map=
, st->reg->fifo_count_h, data,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_FIFO_COUNT_BYTE);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D regmap_bulk_read(st->map=
, st->reg->fifo_count_h,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->data, INV_MPU6050_FIFO_CO=
UNT_BYTE);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (result)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto end_session;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fifo_count =3D get_unaligned_be16(&=
data[0]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fifo_count =3D be16_to_cpup((__be16=
 *)&st->data[0]);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Handle fifo over=
flow by resetting fifo.
> @@ -182,7 +180,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_mpu6050_update_perio=
d(st, pf->timestamp, nb);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nb; ++=
i) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 result =3D regmap_bulk_read(st->map, st->reg->fifo=
_r_w,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 data, bytes_per_datum);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 st->data, bytes_per_datum);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (result)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to flush_fifo;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* skip first samples if needed */
> @@ -191,7 +189,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
ntinue;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 timestamp =3D inv_mpu6050_get_timestamp(st);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 iio_push_to_buffers_with_timestamp(indio_dev, st->data, timest=
amp);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0end_session:

