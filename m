Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB2C3DC73A
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 19:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhGaRhx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 13:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhGaRhx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 13:37:53 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF4C860EE6;
        Sat, 31 Jul 2021 17:37:45 +0000 (UTC)
Date:   Sat, 31 Jul 2021 18:40:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        denis.ciocca@st.com
Subject: Re: [PATCH 0/4] iio: st_sensors: convert probe functions to full
 devm
Message-ID: <20210731184024.454ad962@jic23-huawei>
In-Reply-To: <20210726071404.14529-1-aardelean@deviqon.com>
References: <20210726071404.14529-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Jul 2021 10:14:00 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> Continuing from series:
>   https://lore.kernel.org/linux-iio/20210720074642.223293-1-aardelean@deviqon.com/
> 
> This goes a little further and converts all ST drivers using the st_common
> bits to devm functions.
> As mentioned by Jonathan, the devm unwind is often attached to
> iio_dev->dev.parent, and something it's attached to some other pointer
> which references the same device object.
> 
> In the last patch, that point is removed, to eliminate doubt about this
> mix-n-match.
> An alternative would be an assert/check somewhere to ensure that
> 'iio_dev->dev.parent == adata->dev'. But I [personally] don't like it that
> much.
> 
> As mentioned previously, I was also thinking of sending this set with the
> previous one. But I am usually reserved to send large sets; also, because I
> don't really like to review large sets [when I'm reviewing other people's
> code].

I'm fine with this, though I would like the reorder pulled out as as
separate patch and moved to the front of the series. It's a good change
in it's own right and will also make the rest of the series more 'obviously'
correct as you'll always be stripping off the last thing done in remove.

Otherwise, needs some time for others to take a look.

thanks,

Jonathan

> 
> Alexandru Ardelean (4):
>   iio: st_sensors: remove st_sensors_deallocate_trigger() function
>   iio: st_sensors: remove st_sensors_power_disable() function
>   iio: st_sensors: remove all driver remove functions
>   iio: st_sensors: remove reference to parent device object on
>     st_sensor_data
> 
>  drivers/iio/accel/st_accel_core.c             | 32 +++--------
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
>  21 files changed, 60 insertions(+), 371 deletions(-)
> 

