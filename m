Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5461E27D2
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgEZRAS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 26 May 2020 13:00:18 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728450AbgEZRAS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 May 2020 13:00:18 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 782FFA90C836B413EE16;
        Tue, 26 May 2020 18:00:16 +0100 (IST)
Received: from localhost (10.47.89.183) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 26 May
 2020 18:00:16 +0100
Date:   Tue, 26 May 2020 17:59:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 13/25] iio:imu:inv_mpu6050 Fix dma and ts alignment and
 data leak issues.
Message-ID: <20200526175945.00002dbe@Huawei.com>
In-Reply-To: <MN2PR12MB44223FFD85B9FBEADEA8368BC4B30@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200525170628.503283-1-jic23@kernel.org>
        <20200525170628.503283-14-jic23@kernel.org>
        <MN2PR12MB44223FFD85B9FBEADEA8368BC4B30@MN2PR12MB4422.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.89.183]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 May 2020 18:44:41 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
> 
> the driver is also doing other regmap_bulk_read and regmap_bulk_write for getting sensor data from registers and for setting hardware offsets.
> But there are numerous IIO drivers supporting SPI that are doing the same (IMU ST driver for example).
> 
> Are you sure this is really required? It seems to just call standard SPI transfers behind (I don't know if DMA can be implicitly call there)
> This is very inconvenient to deal with if there is no easy way to read/write multiple registers on the stack.

It's rare for this to be a problem on modern spi controllers, but there
are still some out there that will occasionally have trouble with
this. 

Personally I only ran into the problem in the wild once and it is really
really evil to track down.

We should clear the other cases out but it's not something I'd consider
urgent given no one is screaming about it.

> 
> Another thing I have in mind, the read for the FIFO should be replaced by a regmap_noinc_read, since this is a virtual register reading the FIFO, not the register map.

Good point.

Jonathan

> 
> Thanks,
> JB
> 
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, May 25, 2020 19:06
> To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Lars-Peter Clausen <lars@metafoo.de>; Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> Subject: [PATCH 13/25] iio:imu:inv_mpu6050 Fix dma and ts alignment and data leak issues. 
>  
>  CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This case is a bit different to the rest of the series.  The driver
> was doing a regmap_bulk_read into a buffer that wasn't dma safe
> as it was on the stack with no guarantee of it being in a cacheline
> on it's own.   Fixing that also dealt with the data leak and
> alignment issues that Lars-Peter pointed out.
> 
> Also removed some unaligned handling as we are now aligned.
> 
> Fixes tag is for the dma safe buffer issue. Potentially we would
> need to backport timestamp alignment futher but that is a totally
> different patch.
> 
> Fixes: fd64df16f40e ("iio: imu: inv_mpu6050: Add SPI support for MPU6000")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  8 +++++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 12 ++++++------
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index cd38b3fccc7b..e4df2d51b689 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -122,6 +122,9 @@ struct inv_mpu6050_chip_config {
>          u8 user_ctrl;
>  };
>  
> +/* 6 + 6 + 2 + 7 (for MPU9x50) = 21 round up to 24 and plus 8 */
> +#define INV_MPU6050_OUTPUT_DATA_SIZE         32
> +
>  /**
>   *  struct inv_mpu6050_hw - Other important hardware information.
>   *  @whoami:   Self identification byte from WHO_AM_I register
> @@ -165,6 +168,7 @@ struct inv_mpu6050_hw {
>   *  @magn_raw_to_gauss:        coefficient to convert mag raw value to Gauss.
>   *  @magn_orient:       magnetometer sensor chip orientation if available.
>   *  @suspended_sensors:        sensors mask of sensors turned off for suspend
> + *  @data:             dma safe buffer used for bulk reads.
>   */
>  struct inv_mpu6050_state {
>          struct mutex lock;
> @@ -190,6 +194,7 @@ struct inv_mpu6050_state {
>          s32 magn_raw_to_gauss[3];
>          struct iio_mount_matrix magn_orient;
>          unsigned int suspended_sensors;
> +       u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] ____cacheline_aligned;
>  };
>  
>  /*register and associated bit definition*/
> @@ -334,9 +339,6 @@ struct inv_mpu6050_state {
>  #define INV_ICM20608_TEMP_OFFSET             8170
>  #define INV_ICM20608_TEMP_SCALE              3059976
>  
> -/* 6 + 6 + 2 + 7 (for MPU9x50) = 21 round up to 24 and plus 8 */
> -#define INV_MPU6050_OUTPUT_DATA_SIZE         32
> -
>  #define INV_MPU6050_REG_INT_PIN_CFG     0x37
>  #define INV_MPU6050_ACTIVE_HIGH         0x00
>  #define INV_MPU6050_ACTIVE_LOW          0x80
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 9511e4715e2c..554c16592d47 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -13,7 +13,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/poll.h>
>  #include <linux/math64.h>
> -#include <asm/unaligned.h>
>  #include "inv_mpu_iio.h"
>  
>  /**
> @@ -121,7 +120,6 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>          struct inv_mpu6050_state *st = iio_priv(indio_dev);
>          size_t bytes_per_datum;
>          int result;
> -       u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
>          u16 fifo_count;
>          s64 timestamp;
>          int int_status;
> @@ -160,11 +158,12 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>           * read fifo_count register to know how many bytes are inside the FIFO
>           * right now
>           */
> -       result = regmap_bulk_read(st->map, st->reg->fifo_count_h, data,
> +       result = regmap_bulk_read(st->map, st->reg->fifo_count_h,
> +                                 st->data,
>                                    INV_MPU6050_FIFO_COUNT_BYTE);
>          if (result)
>                  goto end_session;
> -       fifo_count = get_unaligned_be16(&data[0]);
> +       fifo_count = be16_to_cpup((__be16 *)&st->data[0]);
>  
>          /*
>           * Handle fifo overflow by resetting fifo.
> @@ -182,7 +181,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>          inv_mpu6050_update_period(st, pf->timestamp, nb);
>          for (i = 0; i < nb; ++i) {
>                  result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
> -                                         data, bytes_per_datum);
> +                                         st->data, bytes_per_datum);
>                  if (result)
>                          goto flush_fifo;
>                  /* skip first samples if needed */
> @@ -191,7 +190,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>                          continue;
>                  }
>                  timestamp = inv_mpu6050_get_timestamp(st);
> -               iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
> +               iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> +                                                  timestamp);
>          }
>  
>  end_session:


