Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C346DCC97E
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfJEK6j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 06:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfJEK6j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 06:58:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3FB62133F;
        Sat,  5 Oct 2019 10:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570273118;
        bh=PfhQYW44fomWZ1X+Hjjh5lPj7FvAsRMXmIN5hMzZNN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bYHnorhw4Y1/nFZ4sLbbtarCAEoZL5KsNeD3c+kTr10biAecS8UJwJlDgmSiknAJr
         5u0D1z1f9Z6PurQgV1DNdCtp4+DDi+HtCAjjvDhEZc2OAGRw8wU6e4W/dda83lWn0j
         BMqc7VJw5JLZJm+Kr+GjMmVU8sucu4MG8+JID/yA=
Date:   Sat, 5 Oct 2019 11:58:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] iio: imu: inv_mpu6050: add defines for
 supporting 9-axis chips
Message-ID: <20191005115834.0629d46a@archlinux>
In-Reply-To: <20190916094128.30122-4-jmaneyrol@invensense.com>
References: <20190916094128.30122-1-jmaneyrol@invensense.com>
        <20190916094128.30122-4-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 09:42:02 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Add registers defines required for driving chip i2c master ip.
> Add MPU9xxx magnetometer scan elements and update data bytes size.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 56 ++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 7cfd3a05c144..04215bc6e8ab 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -164,9 +164,41 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_REG_ACCEL_CONFIG        0x1C
>  
>  #define INV_MPU6050_REG_FIFO_EN             0x23
> +#define INV_MPU6050_BIT_SLAVE_0             0x01
> +#define INV_MPU6050_BIT_SLAVE_1             0x02
> +#define INV_MPU6050_BIT_SLAVE_2             0x04
>  #define INV_MPU6050_BIT_ACCEL_OUT           0x08
>  #define INV_MPU6050_BITS_GYRO_OUT           0x70
>  
> +#define INV_MPU6050_REG_I2C_MST_CTRL        0x24
> +#define INV_MPU6050_BITS_I2C_MST_CLK_400KHZ 0x0D
> +#define INV_MPU6050_BIT_I2C_MST_P_NSR       0x10
> +#define INV_MPU6050_BIT_SLV3_FIFO_EN        0x20
> +#define INV_MPU6050_BIT_WAIT_FOR_ES         0x40
> +#define INV_MPU6050_BIT_MULT_MST_EN         0x80
> +
> +/* control I2C slaves from 0 to 3 */
> +#define INV_MPU6050_REG_I2C_SLV_ADDR(_x)    (0x25 + 3 * (_x))
> +#define INV_MPU6050_BIT_I2C_SLV_RNW         0x80
> +
> +#define INV_MPU6050_REG_I2C_SLV_REG(_x)     (0x26 + 3 * (_x))
> +
> +#define INV_MPU6050_REG_I2C_SLV_CTRL(_x)    (0x27 + 3 * (_x))
> +#define INV_MPU6050_BIT_SLV_GRP             0x10
> +#define INV_MPU6050_BIT_SLV_REG_DIS         0x20
> +#define INV_MPU6050_BIT_SLV_BYTE_SW         0x40
> +#define INV_MPU6050_BIT_SLV_EN              0x80
> +
> +/* I2C master delay register */
> +#define INV_MPU6050_REG_I2C_SLV4_CTRL       0x34
> +#define INV_MPU6050_BITS_I2C_MST_DLY(_x)    ((_x) & 0x1F)
> +
> +#define INV_MPU6050_REG_I2C_MST_STATUS      0x36
> +#define INV_MPU6050_BIT_I2C_SLV0_NACK       0x01
> +#define INV_MPU6050_BIT_I2C_SLV1_NACK       0x02
> +#define INV_MPU6050_BIT_I2C_SLV2_NACK       0x04
> +#define INV_MPU6050_BIT_I2C_SLV3_NACK       0x08
> +
>  #define INV_MPU6050_REG_INT_ENABLE          0x38
>  #define INV_MPU6050_BIT_DATA_RDY_EN         0x01
>  #define INV_MPU6050_BIT_DMP_INT_EN          0x02
> @@ -179,6 +211,18 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_BIT_FIFO_OVERFLOW_INT   0x10
>  #define INV_MPU6050_BIT_RAW_DATA_RDY_INT    0x01
>  
> +#define INV_MPU6050_REG_EXT_SENS_DATA       0x49
> +
> +/* I2C slaves data output from 0 to 3 */
> +#define INV_MPU6050_REG_I2C_SLV_DO(_x)      (0x63 + (_x))
> +
> +#define INV_MPU6050_REG_I2C_MST_DELAY_CTRL  0x67
> +#define INV_MPU6050_BIT_I2C_SLV0_DLY_EN     0x01
> +#define INV_MPU6050_BIT_I2C_SLV1_DLY_EN     0x02
> +#define INV_MPU6050_BIT_I2C_SLV2_DLY_EN     0x04
> +#define INV_MPU6050_BIT_I2C_SLV3_DLY_EN     0x08
> +#define INV_MPU6050_BIT_DELAY_ES_SHADOW     0x80
> +
>  #define INV_MPU6050_REG_USER_CTRL           0x6A
>  #define INV_MPU6050_BIT_FIFO_RST            0x04
>  #define INV_MPU6050_BIT_DMP_RST             0x08
> @@ -206,6 +250,9 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_BYTES_PER_3AXIS_SENSOR   6
>  #define INV_MPU6050_FIFO_COUNT_BYTE          2
>  
> +/* MPU9X50 9-axis magnetometer */
> +#define INV_MPU9X50_BYTES_MAGN               7
> +
>  /* ICM20602 FIFO samples include temperature readings */
>  #define INV_ICM20602_BYTES_PER_TEMP_SENSOR   2
>  
> @@ -233,8 +280,8 @@ struct inv_mpu6050_state {
>  #define INV_ICM20602_TEMP_OFFSET	     8170
>  #define INV_ICM20602_TEMP_SCALE		     3060
>  
> -/* 6 + 6 round up and plus 8 */
> -#define INV_MPU6050_OUTPUT_DATA_SIZE         24
> +/* 6 + 6 + 7 (for MPU9x50) = 19 round up to 24 and plus 8 */
> +#define INV_MPU6050_OUTPUT_DATA_SIZE         32
>  
>  #define INV_MPU6050_REG_INT_PIN_CFG	0x37
>  #define INV_MPU6050_ACTIVE_HIGH		0x00
> @@ -283,6 +330,11 @@ enum inv_mpu6050_scan {
>  	INV_MPU6050_SCAN_GYRO_Y,
>  	INV_MPU6050_SCAN_GYRO_Z,
>  	INV_MPU6050_SCAN_TIMESTAMP,
> +
> +	INV_MPU9X50_SCAN_MAGN_X = INV_MPU6050_SCAN_GYRO_Z + 1,
> +	INV_MPU9X50_SCAN_MAGN_Y,
> +	INV_MPU9X50_SCAN_MAGN_Z,
> +	INV_MPU9X50_SCAN_TIMESTAMP,
>  };
>  
>  /* scan element definition for ICM20602, which includes temperature */

