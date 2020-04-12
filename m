Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7571A5EB6
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDLNSo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 09:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDLNSo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 09:18:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81D2206E9;
        Sun, 12 Apr 2020 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586697524;
        bh=TI33rzD0n8mmPhb5Pjl/QhsNX9N8yCPVmBC6PfsnmDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O1J8Sg1g3OdL+xchya1LEBmWsw24Ys8kc5KIW//3hxJz9LaYexT7FCuS8UX/07KqJ
         jNDo1QTlbE/hsuDr9ZHOiSUbVfHSAA4zOTv7UJhXUbF7+nTZNmZ3K0WcgV6Yq72dRr
         IZODDDh7PLNKqef9aRNbLFBQLG49wnXB2NDBe5AY=
Date:   Sun, 12 Apr 2020 14:18:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jimmyassarsson@gmail.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH v3] iio: imu: st_lsm6dsx: drop huge include in
 sensor-hub driver
Message-ID: <20200412141840.602ace16@archlinux>
In-Reply-To: <d49d9b76fab1ba0e33034327864d25ff64545bd9.1586199565.git.lorenzo@kernel.org>
References: <d49d9b76fab1ba0e33034327864d25ff64545bd9.1586199565.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  6 Apr 2020 21:00:25 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> st_lsm6dsx is a standalone driver for STM IMU sensors and does not rely
> on st_sensor common framework, so it does not include st_sensor common
> definitions.
> In st_lsm6dsx_shub driver st_sensors.h is used just to introduce the
> default wai address for LIS3MDL sensor.
> Drop this largely unconnected include file and introduce the default wai
> address for LIS3MDL in st_lsm6dsx_ext_dev_settings register map
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes since v2:
> - rewrite commit message
> 
> Changes since v1:
> - improve commit message
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 280925dd8edb..947ca3a7dcaf 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -28,7 +28,6 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/bitfield.h>
>  
> -#include <linux/iio/common/st_sensors.h>
>  #include "st_lsm6dsx.h"
>  
>  #define ST_LSM6DSX_SLV_ADDR(n, base)		((base) + (n) * 3)
> @@ -93,7 +92,7 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
>  	{
>  		.i2c_addr = { 0x1e },
>  		.wai = {
> -			.addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +			.addr = 0x0f,
>  			.val = 0x3d,
>  		},
>  		.id = ST_LSM6DSX_ID_MAGN,

