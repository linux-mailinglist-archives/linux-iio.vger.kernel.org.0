Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A457D3FAC4C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 16:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbhH2Opw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 10:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhH2Opw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 10:45:52 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD9B460F39;
        Sun, 29 Aug 2021 14:44:57 +0000 (UTC)
Date:   Sun, 29 Aug 2021 15:48:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        denis.ciocca@st.com, linus.walleij@linaro.org,
        lee.jones@linaro.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 0/5] iio: st_sensors: convert probe functions to full
 devm
Message-ID: <20210829154812.606e51f5@jic23-huawei>
In-Reply-To: <20210823112204.243255-1-aardelean@deviqon.com>
References: <20210823112204.243255-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Aug 2021 14:21:59 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> Changelog v2 - v3:
> * https://lore.kernel.org/linux-iio/20210816082836.67511-1-aardelean@deviqon.com/
> * Fixed a build warning
>   - When debugging is disabled dev_dbg() ops become a noop and this causes 
>     a warning
>   - Reported-by: kernel test robot <lkp@intel.com>
>   - https://lore.kernel.org/linux-iio/202108180707.05EmDSHt-lkp@intel.com/
> * added tag 'Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>' to
>   series
> * added tag 'Reviewed-by: Linus Walleij <linus.walleij@linaro.org>' to
>   patch 'iio: st_sensors: disable regulators after device unregistration'
> 
> Changelog v1 - v2:
> * https://lore.kernel.org/linux-iio/20210726071404.14529-1-aardelean@deviqon.com/
> * added patch 'iio: st_sensors: disable regulators after device unregistration'
>   - splits the regulator disable fix in a separate patch
> 
As the fix, whilst clearly correct is for an issue that would take a bit of
determination to hit, I'm not going to rush it in.  Hence whole series applied
to the togreg branch of iio.git and pushed out as testing for 0-day to poke at.

Thanks,

Jonathan

> 
> Alexandru Ardelean (5):
>   iio: st_sensors: disable regulators after device unregistration
>   iio: st_sensors: remove st_sensors_deallocate_trigger() function
>   iio: st_sensors: remove st_sensors_power_disable() function
>   iio: st_sensors: remove all driver remove functions
>   iio: st_sensors: remove reference to parent device object on
>     st_sensor_data
> 
>  drivers/iio/accel/st_accel_core.c             | 31 ++---------
>  drivers/iio/accel/st_accel_i2c.c              | 23 +-------
>  drivers/iio/accel/st_accel_spi.c              | 23 +-------
>  .../iio/common/st_sensors/st_sensors_core.c   | 34 ++++++------
>  .../iio/common/st_sensors/st_sensors_i2c.c    |  1 -
>  .../iio/common/st_sensors/st_sensors_spi.c    |  1 -
>  .../common/st_sensors/st_sensors_trigger.c    | 53 +++++++------------
>  drivers/iio/gyro/st_gyro_core.c               | 27 ++--------
>  drivers/iio/gyro/st_gyro_i2c.c                | 23 +-------
>  drivers/iio/gyro/st_gyro_spi.c                | 23 +-------
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h       |  1 -
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  | 17 +-----
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c   |  6 ---
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c   |  6 ---
>  drivers/iio/magnetometer/st_magn_core.c       | 29 ++--------
>  drivers/iio/magnetometer/st_magn_i2c.c        | 23 +-------
>  drivers/iio/magnetometer/st_magn_spi.c        | 23 +-------
>  drivers/iio/pressure/st_pressure_core.c       | 27 ++--------
>  drivers/iio/pressure/st_pressure_i2c.c        | 23 +-------
>  drivers/iio/pressure/st_pressure_spi.c        | 23 +-------
>  include/linux/iio/common/st_sensors.h         | 13 -----
>  21 files changed, 59 insertions(+), 371 deletions(-)
> 

