Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C018CCADC
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 17:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJEPkE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 11:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfJEPkE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 11:40:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E751020862;
        Sat,  5 Oct 2019 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570290003;
        bh=qzZ8scKc7hDWoTIj8h7sqmHcifGcZt/4GAY0vT1rRok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NThlPTVx+PN3UYqVgfdC3FArOoBLWJD3p3WRUeyVi6cmFmup/a5Mdykv0M+0/Q92K
         M5qSL/TpV9zTGYy6cI6LFnib7rNO6mN1RzcAC8ND3erjKGacXppyOEeN9HhNN8CFJV
         XTo/JA1Jx7235U6jj1WaL+wr0SGx2BW6L715FEfI=
Date:   Sat, 5 Oct 2019 16:39:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/13] cros_ec: Add sensorhub driver and FIFO processing
Message-ID: <20191005163957.64afa7da@archlinux>
In-Reply-To: <20190922175021.53449-1-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Sep 2019 10:50:08 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> This patchset adds a sensorhub driver for spreading sensor
> events coming from the Embedded controller sensor FIFO:
> 
>        +---------------+ +--------------+ +----
>        | cros_ec_accel | | cros_ec_gyro | | ...
>        +---------------+ +--------------+ +----
>            id:0       \        id:1 |       / id:..
>                  +------------------------------+
>                  |       cros_ec_sensorhub      |
>                  +------------------------------+
>                  |           cros_ec_dev        |
>                  +------------------------------+
>                  | cros_ec_i2c, cros_ec_lpc, .. |
>                  +------------------------------+
>                                  |
>                                  EC
> 
> When new sensors events are present, the EC raises and interrupt,
> sensorhub reads the FIFO and uses the 'id' field to spread the event to
> the proper IIO sensors. This stack is similar to the HID sensor input
> stack.
> 
> The first 3 patches add a primitive cros_ec_sensorhub. MFD just have to
> register this driver if at least one sensor is presented by the EC.
> cros_ec_sensorhub retrieves more information from the EC to find out
> which sensors are actually present:
>   mfd: cros_ec: Add sensor_count and make check_features public
>   platform: cros_ec: Add cros_ec_sensor_hub driver
>   platform/mfd:iio: cros_ec: Register sensor through sensorhub
> 
> The next 3 patches prepare for FIFO support:
>   platform: chrome: cros-ec: record event timestamp in the hard irq
>   platform: chrome: cros_ec: Do not attempt to register a non-positive
>   platform: chrome: cros_ec: handle MKBP more events flag
> 
> The next 4 patches add FIFO support. An interface is added to connect
> the IIO sensors with cros_ec_sensorhub, and filters are needed to spread
> the timestamp when the EC send batches of events and deal with variation
> in interrupt delay.
>   platform: chrome: sensorhub: Add FIFO support
>   platform: chrome: sensorhub: Add code to spread timestmap
>   platform: chrome: sensorhub: Add median filter
>   iio: cros_ec: Use triggered buffer only when EC does not support FIFO
> 
> Finally, the last 3 patches present sensor information following the IIO
> ABI:
> -  Configurable EC timeout to allow batch mode in buffer/hwfifo_timeout,
>   in seconds.
> -  Hard coded EC FIFO size in buffer/hwfifo_watermark_max
> -  Sensor sampling frequency in hertz at sampling_frequency:
>   iio: cros_ec: Expose hwfifo_timeout
>   iio: cros_ec: Report hwfifo_watermark_max
>   iio: cros_ec: Use Hertz as unit for sampling frequency
> 
> For testing, libiio test tools can be used:
> A iio device link looks like:
> iio:device1 ->
> ...09:00/GOOG0004:00/cros-ec-dev.6.auto/cros-ec-sensorhub.7.auto/
>                      cros-ec-accel.15.auto/iio:device1
> 
> When FIFO is available, no trigger are presented. Once
> sampling_freqeuncy and hwfifo_timeout are set, sensor events flow
> when listening to /dev/iio:device1:
> echo 12 > sampling_frequency   # Set ODR to at least 12Hz
> echo .100 > buffer/hwfifo_timeout  # do not wait more than 100ms to
>                                    # to send samples
> iio_readdev -b 2 -T 1000 -s 2 iio:device1 2>/dev/null| od -x
> 0000000 ffd0 2e20 d990 0000 8630 b56c 07ea 0000
> 0000020 ffc0 2e10 d970 0000 877e b56c 07ea 0000
> 0000040`
> 
> When FIFO is not supported by the EC, a trigger is present in the
> directory. After registering a trigger, setting sampling_frequency,
> the latest data collected by the sensor will be retrieved by the host
> when the trigger expires.

This is the only bit that makes me wonder... For other devices we have
supported allowing triggers even when there is a fifo present.  I assume
we can disable the fifo if necessary?  In that case we use the hwfifo
path if no trigger is provided, but if there is one switch back to
the handling for when the hardware doesn't support such a fifo.

Could that model be useful here?

Thanks,

Jonathan

> 
> When cros_ec_accel_legacy driver is used, no FIFO is supported and the
> sampling frequency for the accelerometers is hard coded at 10Hz.
> 
> This set is built upon the master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> 
> Enrico Granata (2):
>   platform: chrome: cros_ec: Do not attempt to register a non-positive
>     IRQ number
>   platform: chrome: cros_ec: handle MKBP more events flag
> 
> Gwendal Grignou (11):
>   mfd: cros_ec: Add sensor_count and make check_features public
>   platform: cros_ec: Add cros_ec_sensor_hub driver
>   platform/mfd:iio: cros_ec: Register sensor through sensorhub
>   platform: chrome: cros-ec: record event timestamp in the hard irq
>   platform: chrome: sensorhub: Add FIFO support
>   platform: chrome: sensorhub: Add code to spread timestmap
>   platform: chrome: sensorhub: Add median filter
>   iio: cros_ec: Use triggered buffer only when EC does not support FIFO
>   iio: cros_ec: Expose hwfifo_timeout
>   iio: cros_ec: Report hwfifo_watermark_max
>   iio: cros_ec: Use Hertz as unit for sampling frequency
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c      |  13 +-
>  drivers/iio/common/cros_ec_sensors/Kconfig    |   2 +-
>  .../cros_ec_sensors/cros_ec_lid_angle.c       |   2 +-
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  14 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 251 ++++-
>  drivers/iio/light/cros_ec_light_prox.c        |  18 +-
>  drivers/iio/pressure/cros_ec_baro.c           |  12 +-
>  drivers/mfd/cros_ec_dev.c                     | 208 +---
>  drivers/platform/chrome/Kconfig               |  18 +-
>  drivers/platform/chrome/Makefile              |   2 +
>  drivers/platform/chrome/cros_ec.c             |  51 +-
>  drivers/platform/chrome/cros_ec_lpc.c         |   2 +
>  drivers/platform/chrome/cros_ec_proto.c       |  51 +-
>  drivers/platform/chrome/cros_ec_sensorhub.c   | 269 +++++
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 918 ++++++++++++++++++
>  .../linux/iio/common/cros_ec_sensors_core.h   |  29 +-
>  include/linux/mfd/cros_ec.h                   |  17 +
>  include/linux/platform_data/cros_ec_proto.h   |  30 +-
>  .../linux/platform_data/cros_ec_sensorhub.h   | 173 ++++
>  19 files changed, 1780 insertions(+), 300 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_sensorhub.c
>  create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c
>  create mode 100644 include/linux/platform_data/cros_ec_sensorhub.h
> 

