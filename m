Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18D3279AA8
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 18:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgIZQUR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 12:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZQUQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Sep 2020 12:20:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C6AA21527;
        Sat, 26 Sep 2020 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137215;
        bh=v9AfXAJUwsfZ/T5JfCEyjMB7aaEyYc0YW8JqOpmUQDY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nCLO1Uku48pQDgHvb+wNfWeuQNvTn+GLsCg5v5qdJPvHnBpC+gNhx94NF8rxS9Pss
         kB+xC9J9x//JMS5bLgX8KZbEUbvUfC+nfAKudn4ruY6Tyu4k2IpLvTew9xosXJu8Xt
         KGC7rIKUSO0lPr7/0eeCDRd20h8Ii4/T+vKvw6lU=
Date:   Sat, 26 Sep 2020 17:20:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 0/5] iio: remove iio_buffer_set_attrs() and assign
 buffer attrs during alloc
Message-ID: <20200926172011.7356eb2d@archlinux>
In-Reply-To: <20200925083743.46469-1-alexandru.ardelean@analog.com>
References: <20200925083743.46469-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Sep 2020 11:37:38 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> I've been mulling this over for a while, and I am still not 100% convinced
> that this is the best approach, but this feels closer to something
> correct.

I'd not worry too much.  It might not be perfect but it's also not hideous
- though that won't stop me suggesting an alternative :)

> 
> A few things about this patchset:
> 1. it hasn't been tested; it just compiles
> 2. there are some patches that have went out [from my side] in the last
>    few days that deal with trying to organize iio_buffer_set_attrs()
>    in order to get to this point [as-in: this patch-set]
> 2a. the only reason patch [1] is in this set, is so that [5] applies
> 2b. the main reason patch [2] is in this set, is so that [5] compiles
> 3. This patch is only meant as RFC, as I'd like that some cleanup
>    patches go in before this set; this RFC is meant to provide an idea
>    of where I want to get at.
> 
> This tries to address the issue with iio_buffer_set_attrs(), where a
> driver needs to provide a reference to a buffer to assign extra sysfs
> attributes.
> Something like 'iio_buffer_set_attrs(indio_dev->buffer, <buffer_attrs>)'
> 
> This works well for the 1 IIO buffer == 1 IIO device case.
> The driver access the 'buffer' reference attached to the IIO device.
> 
> But for a multiple IIO buffers per 1 IIO device, this is cumbersome, as
> a driver would need to:
> 1. allocate a set of buffers
> 2. dig out of IIO the buffers to which it wants to assign extra sysfs
>    attributes
> 
> The main change here is to move the attributes [usually HW FIFO
> attributes] to become arguments of the devm_}iio_triggered_buffer_setup()
> functions.
> Other buffer allocation functions would need to do the same, but right
> now, it's only these functions that assign extra buffer attributes.

Probably worth stating here that we have a confusing mess of where
these attributes are and will probably look long term to move them
or at least think about doing so.

The buffer directory in modern IIO isn't strictly matched to a hwfifo
any more (it used to be - see sca3000 for the history - the model
was not a nice solution, but it took a few years to figure that out).
buffer/* represent a software buffer fed by the hardware fifo. There
are potentially other software buffers being fed in the form of
other consumers.

The hardware fifo is a separate entity.  However as Alex adds
support for multiple streams of data (that may come from mulitple hardware
fifos) we are going to still need a mapping of hardware buffer X
to software buffer X.  So separate entities, but with a one to one
(technically many of the consumer side, but only one in the IIO
userspace interface) mapping.

Anyhow, Alex and others know this from previous discussions but perhaps others
reading this don't hence I thought I'd mention it :)

> 
> Some alternative ideas to doing this change [as-is]:
> * move the attributes to 'struct iio_buffer_setup_ops' ; this has a
>   minimal patch/change-impact, but it doesn't feel correct
> * introduce a new type called 'struct iio_trigerred_buffer_args' that
>   wrap all the triggered-buffer arguments into a single object; this is
>   still a big patch [like this], but future-wise, we would just be
>   extending that object [if more args are needed]; the main point
>   here is that right now 'devm_iio_triggered_buffer_setup()' has 6
>   arguments, which feels a bit much

So here is another one:
* Let us assume that we actually don't want to use this interface in new
  drivers because we decide to deprecate putting the hardware fifo stuff
  where it currently is. (big assumption - dependent on what userspace
  code is using this and it will take a while).
* With that assumption, we could add a new function that takes the attrs
  e.g. iio_setup_triggered_buffer_ext() 
  and only replace the instances where we need to provide the attrs.

To be honest, as I said above, I'm not that bothered which route is
taken.

Jonathan

> 
> 
> Alexandru Ardelean (5):
>   [1] iio: cros_ec: unify hw fifo attributes into the core file
>   [2] iio: buffer: dmaengine: unwrap the use of iio_buffer_set_attrs()
>   [3] iio: triggered-buffer: add sysfs buffer attributes as args for setup
>   [4] iio: buffer: extend arg list for {devm_}iio_triggered_buffer_setup()
>   [5] iio: remove iio_buffer_set_attrs() and assign buffer attrs during
>     alloc
> 
>  drivers/iio/accel/adxl372.c                   |  5 ++--
>  drivers/iio/accel/bma180.c                    |  2 +-
>  drivers/iio/accel/bma220_spi.c                |  2 +-
>  drivers/iio/accel/bmc150-accel-core.c         | 19 ++++++++------
>  drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
>  drivers/iio/accel/kxcjk-1013.c                |  2 +-
>  drivers/iio/accel/kxsd9.c                     |  2 +-
>  drivers/iio/accel/mma7455_core.c              |  2 +-
>  drivers/iio/accel/mma8452.c                   |  2 +-
>  drivers/iio/accel/mxc4005.c                   |  2 +-
>  drivers/iio/accel/st_accel_buffer.c           |  2 +-
>  drivers/iio/accel/stk8312.c                   |  2 +-
>  drivers/iio/accel/stk8ba50.c                  |  2 +-
>  drivers/iio/adc/ad7266.c                      |  3 ++-
>  drivers/iio/adc/ad7298.c                      |  2 +-
>  drivers/iio/adc/ad7476.c                      |  2 +-
>  drivers/iio/adc/ad7606.c                      |  2 +-
>  drivers/iio/adc/ad7766.c                      |  2 +-
>  drivers/iio/adc/ad7768-1.c                    |  2 +-
>  drivers/iio/adc/ad7887.c                      |  2 +-
>  drivers/iio/adc/ad7923.c                      |  2 +-
>  drivers/iio/adc/ad799x.c                      |  2 +-
>  drivers/iio/adc/ad_sigma_delta.c              |  2 +-
>  drivers/iio/adc/at91-sama5d2_adc.c            | 25 +++++++++++--------
>  drivers/iio/adc/at91_adc.c                    |  2 +-
>  drivers/iio/adc/cc10001_adc.c                 |  2 +-
>  drivers/iio/adc/dln2-adc.c                    |  3 ++-
>  drivers/iio/adc/hx711.c                       |  3 ++-
>  drivers/iio/adc/max1027.c                     |  2 +-
>  drivers/iio/adc/max1118.c                     |  2 +-
>  drivers/iio/adc/max1363.c                     |  2 +-
>  drivers/iio/adc/mxs-lradc-adc.c               |  2 +-
>  drivers/iio/adc/rockchip_saradc.c             |  2 +-
>  drivers/iio/adc/stm32-adc.c                   |  2 +-
>  drivers/iio/adc/stm32-dfsdm-adc.c             |  2 +-
>  drivers/iio/adc/ti-adc081c.c                  |  3 ++-
>  drivers/iio/adc/ti-adc0832.c                  |  2 +-
>  drivers/iio/adc/ti-adc084s021.c               |  3 ++-
>  drivers/iio/adc/ti-adc108s102.c               |  3 ++-
>  drivers/iio/adc/ti-adc12138.c                 |  2 +-
>  drivers/iio/adc/ti-adc161s626.c               |  2 +-
>  drivers/iio/adc/ti-ads1015.c                  |  2 +-
>  drivers/iio/adc/ti-ads124s08.c                |  3 ++-
>  drivers/iio/adc/ti-ads7950.c                  |  3 ++-
>  drivers/iio/adc/ti-ads8688.c                  |  3 ++-
>  drivers/iio/adc/ti-tlc4541.c                  |  2 +-
>  drivers/iio/adc/vf610_adc.c                   |  3 ++-
>  drivers/iio/adc/xilinx-xadc-core.c            |  2 +-
>  .../buffer/industrialio-buffer-dmaengine.c    |  3 +--
>  .../buffer/industrialio-triggered-buffer.c    | 13 +++++++---
>  drivers/iio/chemical/atlas-sensor.c           |  2 +-
>  drivers/iio/chemical/ccs811.c                 |  2 +-
>  drivers/iio/chemical/pms7003.c                |  3 ++-
>  drivers/iio/chemical/scd30_core.c             |  3 ++-
>  drivers/iio/chemical/sps30.c                  |  3 ++-
>  .../cros_ec_sensors/cros_ec_lid_angle.c       |  5 ++--
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  5 ++--
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 16 +++++++++---
>  .../common/hid-sensors/hid-sensor-trigger.c   | 19 ++++++--------
>  drivers/iio/gyro/adxrs290.c                   |  3 ++-
>  drivers/iio/gyro/bmg160_core.c                |  2 +-
>  drivers/iio/gyro/fxas21002c_core.c            |  3 ++-
>  drivers/iio/gyro/itg3200_buffer.c             |  2 +-
>  drivers/iio/gyro/mpu3050-core.c               |  2 +-
>  drivers/iio/gyro/st_gyro_buffer.c             |  2 +-
>  drivers/iio/health/afe4403.c                  |  2 +-
>  drivers/iio/health/afe4404.c                  |  2 +-
>  drivers/iio/humidity/am2315.c                 |  2 +-
>  drivers/iio/humidity/hdc100x.c                |  2 +-
>  drivers/iio/humidity/hts221_buffer.c          |  2 +-
>  drivers/iio/imu/adis_buffer.c                 |  2 +-
>  drivers/iio/imu/bmi160/bmi160_core.c          |  3 ++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  2 +-
>  drivers/iio/imu/kmx61.c                       |  4 +--
>  drivers/iio/industrialio-buffer.c             | 12 ---------
>  drivers/iio/light/adjd_s311.c                 |  2 +-
>  drivers/iio/light/as73211.c                   |  3 ++-
>  drivers/iio/light/cros_ec_light_prox.c        |  5 ++--
>  drivers/iio/light/gp2ap020a00f.c              |  3 ++-
>  drivers/iio/light/isl29125.c                  |  2 +-
>  drivers/iio/light/ltr501.c                    |  2 +-
>  drivers/iio/light/max44000.c                  |  3 ++-
>  drivers/iio/light/rpr0521.c                   |  2 +-
>  drivers/iio/light/si1145.c                    |  2 +-
>  drivers/iio/light/st_uvis25_core.c            |  2 +-
>  drivers/iio/light/tcs3414.c                   |  2 +-
>  drivers/iio/light/tcs3472.c                   |  2 +-
>  drivers/iio/light/vcnl4000.c                  |  3 ++-
>  drivers/iio/light/vcnl4035.c                  |  2 +-
>  drivers/iio/magnetometer/ak8974.c             |  2 +-
>  drivers/iio/magnetometer/ak8975.c             |  2 +-
>  drivers/iio/magnetometer/bmc150_magn.c        |  2 +-
>  drivers/iio/magnetometer/hmc5843_core.c       |  2 +-
>  drivers/iio/magnetometer/mag3110.c            |  2 +-
>  drivers/iio/magnetometer/rm3100-core.c        |  2 +-
>  drivers/iio/magnetometer/st_magn_buffer.c     |  2 +-
>  drivers/iio/potentiostat/lmp91000.c           |  2 +-
>  drivers/iio/pressure/cros_ec_baro.c           |  5 ++--
>  drivers/iio/pressure/dlhl60d.c                |  2 +-
>  drivers/iio/pressure/mpl3115.c                |  2 +-
>  drivers/iio/pressure/ms5611_core.c            |  2 +-
>  drivers/iio/pressure/st_pressure_buffer.c     |  2 +-
>  drivers/iio/pressure/zpa2326.c                |  2 +-
>  drivers/iio/proximity/as3935.c                |  3 ++-
>  drivers/iio/proximity/isl29501.c              |  2 +-
>  drivers/iio/proximity/mb1232.c                |  3 ++-
>  .../iio/proximity/pulsedlight-lidar-lite-v2.c |  2 +-
>  drivers/iio/proximity/srf08.c                 |  3 ++-
>  drivers/iio/proximity/sx9310.c                |  2 +-
>  drivers/iio/proximity/sx9500.c                |  2 +-
>  drivers/iio/temperature/maxim_thermocouple.c  |  3 ++-
>  include/linux/iio/buffer.h                    |  3 ---
>  .../linux/iio/common/cros_ec_sensors_core.h   |  4 +--
>  include/linux/iio/triggered_buffer.h          |  7 ++++--
>  114 files changed, 198 insertions(+), 172 deletions(-)
> 

