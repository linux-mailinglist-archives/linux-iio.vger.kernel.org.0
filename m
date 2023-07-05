Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B80747EBD
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jul 2023 09:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjGEH6p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 5 Jul 2023 03:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjGEH6n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jul 2023 03:58:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20134E6B
        for <linux-iio@vger.kernel.org>; Wed,  5 Jul 2023 00:58:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QwsQZ42yqz689w9;
        Wed,  5 Jul 2023 15:55:18 +0800 (CST)
Received: from localhost (10.34.206.101) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 5 Jul
 2023 08:58:38 +0100
Date:   Wed, 5 Jul 2023 15:58:34 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: read the full fifo when
 processing data
Message-ID: <20230705155834.00000989@Huawei.com>
In-Reply-To: <FR3P281MB175727439E7D09F88E44C421CE29A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230623082924.283967-1-inv.git-commit@tdk.com>
        <FR3P281MB175727439E7D09F88E44C421CE29A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.34.206.101]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 Jul 2023 15:19:52 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Jonathan,
> 
> any news about this patch?
> 
> Thanks for your feedback,

LGTM.  I'm traveling however, so I've just been marking stuff that
is ready for queuing up in patchwork. Will send replies when I actually
queue them.

https://patchwork.kernel.org/project/linux-iio/list/

See patches labeled 'queued' which I'm using for this purpose.
Normally I'd just use applied and push the tree out the same
day.

Jonathan

> JB
> 
> 
> From: INV Git Commit <INV.git-commit@tdk.com>
> Sent: Friday, June 23, 2023 10:29
> To: jic23@kernel.org <jic23@kernel.org>
> Cc: lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Subject: [PATCH] iio: imu: inv_mpu6050: read the full fifo when processing data 
>  
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> When processing data read the full fifo data in 1 time. If there
> are several samples in the FIFO, it means we are experiencing
> system delay. In this case, it is better to read all data with 1
> bus access than to add additional latency by doing several ones.
> 
> This requires to use a bigger buffer depending on chip FIFO size
> and do an additional local data copy before sending. But the cost
> is minimal and behavior is still better like this under system
> heavy load.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  3 +++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  4 ++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 19 +++++++++++++------
>  3 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 13086b569b90..29f906c884bd 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1345,6 +1345,9 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>          st->reg = hw_info[st->chip_type].reg;
>          memcpy(&st->chip_config, hw_info[st->chip_type].config,
>                 sizeof(st->chip_config));
> +       st->data = devm_kzalloc(regmap_get_device(st->map), st->hw->fifo_size, GFP_KERNEL);
> +       if (st->data == NULL)
> +               return -ENOMEM;
>  
>          /* check chip self-identification */
>          result = regmap_read(st->map, INV_MPU6050_REG_WHOAMI, &regval);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index a51d103a57ca..ed5a96e78df0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -179,7 +179,7 @@ struct inv_mpu6050_hw {
>   *  @magn_raw_to_gauss:        coefficient to convert mag raw value to Gauss.
>   *  @magn_orient:       magnetometer sensor chip orientation if available.
>   *  @suspended_sensors:        sensors mask of sensors turned off for suspend
> - *  @data:             dma safe buffer used for bulk reads.
> + *  @data:             read buffer used for bulk reads.
>   */
>  struct inv_mpu6050_state {
>          struct mutex lock;
> @@ -203,7 +203,7 @@ struct inv_mpu6050_state {
>          s32 magn_raw_to_gauss[3];
>          struct iio_mount_matrix magn_orient;
>          unsigned int suspended_sensors;
> -       u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] __aligned(IIO_DMA_MINALIGN);
> +       u8 *data;
>  };
>  
>  /*register and associated bit definition*/
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index d83f61a99504..66d4ba088e70 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -52,6 +52,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>          u16 fifo_count;
>          u32 fifo_period;
>          s64 timestamp;
> +       u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
>          int int_status;
>          size_t i, nb;
>  
> @@ -105,24 +106,30 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>                  goto flush_fifo;
>          }
>  
> -       /* compute and process all complete datum */
> +       /* compute and process only all complete datum */
>          nb = fifo_count / bytes_per_datum;
> +       fifo_count = nb * bytes_per_datum;
>          /* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
>          fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
>          inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, pf->timestamp);
>          inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);
> +
> +       /* clear internal data buffer for avoiding kernel data leak */
> +       memset(data, 0, sizeof(data));
> +
> +       /* read all data once and process every samples */
> +       result = regmap_noinc_read(st->map, st->reg->fifo_r_w, st->data, fifo_count);
> +       if (result)
> +               goto flush_fifo;
>          for (i = 0; i < nb; ++i) {
> -               result = regmap_noinc_read(st->map, st->reg->fifo_r_w,
> -                                          st->data, bytes_per_datum);
> -               if (result)
> -                       goto flush_fifo;
>                  /* skip first samples if needed */
>                  if (st->skip_samples) {
>                          st->skip_samples--;
>                          continue;
>                  }
> +               memcpy(data, &st->data[i * bytes_per_datum], bytes_per_datum);
>                  timestamp = inv_sensors_timestamp_pop(&st->timestamp);
> -               iio_push_to_buffers_with_timestamp(indio_dev, st->data, timestamp);
> +               iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
>          }
>  
>  end_session:

