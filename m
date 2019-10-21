Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3507DF17E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 17:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfJUP3Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 11:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbfJUP3P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Oct 2019 11:29:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93AFA206C2;
        Mon, 21 Oct 2019 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571671754;
        bh=okh6J99YfICq6YXZz5SmxsuOA3O6fnBw1o/6a5Ss0aw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hzuC7RdlFXK6fzXhBuLI/ZtfCZMK/rVwb5TbktpCWBE3z+8WR4xf/CDJyU8IGblHi
         yRCFDuHT1v0VWjWAH7QIPQ6LDMWLmaGWEasy0TYSP2zz64nq9WgyKyyTZig2ouRq2f
         3SEymL9nI88zpMqXDkk9fo6p8rt44BPMeIZDGjAY=
Date:   Mon, 21 Oct 2019 16:29:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 00/18] cros_ec: Add sensorhub driver and FIFO
 processing*** SUBJECT HERE
Message-ID: <20191021162908.67255884@archlinux>
In-Reply-To: <20191021055403.67849-1-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Oct 2019 22:53:45 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

Tidy up the title for v3!

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
> The first patch move cros_ec_proto functions documentations into the
> code to prevent rot.
> 
> The inext 3 patches add a primitive cros_ec_sensorhub. MFD just have to

next

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
> That last patch fixes a regression that changes event processing.
> Revert the patches that fixed that regression.
> 
> The next 3 patches add FIFO support. An interface is added to connect
> the IIO sensors with cros_ec_sensorhub, and filters are needed to spread
> the timestamp when the EC send batches of events and deal with variation
> in interrupt delay.
>   platform: chrome: sensorhub: Add FIFO support
>   platform: chrome: sensorhub: Add code to spread timestmap
>   platform: chrome: sensorhub: Add median filter
> 
> The remaining patches update IIO cros_ec drivers:
> The first patch moves cros_ec_sensor_core functions documentation into
> the .c file.
> Then we can use the FIFO function exposed by cros_ec_sensorhub:
>   iio: cros_ec: Use triggered buffer only when EC does not support FIFO
> 
> The power management functions are not necessary anymore, since we
> shutoff the FIFO from cros_ec_sensorhub:
>   iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO
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
> 
> When cros_ec_accel_legacy driver is used, no FIFO is supported and the
> sampling frequency for the accelerometers is hard coded at 10Hz.
> 
> This set is built upon the master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> Enrico Granata (2):
>   platform: chrome: cros_ec: Do not attempt to register a non-positive
>     IRQ number
>   platform: chrome: cros_ec: handle MKBP more events flag
> 
> Gwendal Grignou (16):
>   platform: chrome: Put docs with the code
>   mfd: cros_ec: Add sensor_count and make check_features public
>   platform: cros_ec: Add cros_ec_sensor_hub driver
>   platform/mfd:iio: cros_ec: Register sensor through sensorhub
>   platform: chrome: cros-ec: record event timestamp in the hard irq
>   Revert "Input: cros_ec_keyb - add back missing mask for event_type"
>   Revert "Input: cros_ec_keyb: mask out extra flags in event_type"
>   platform: chrome: sensorhub: Add FIFO support
>   platform: chrome: sensorhub: Add code to spread timestmap
>   platform: chrome: sensorhub: Add median filter
>   iio: cros_ec: Move function description to .c file
>   iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO
>   iio: cros_ec: Remove pm function
>   iio: cros_ec: Expose hwfifo_timeout
>   iio: cros_ec: Report hwfifo_watermark_max
>   iio: cros_ec: Use Hertz as unit for sampling frequency
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c      |  14 +-
>  drivers/iio/common/cros_ec_sensors/Kconfig    |   2 +-
>  .../cros_ec_sensors/cros_ec_lid_angle.c       |   3 +-
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  19 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 359 +++++--
>  drivers/iio/light/cros_ec_light_prox.c        |  21 +-
>  drivers/iio/pressure/cros_ec_baro.c           |  14 +-
>  drivers/input/keyboard/cros_ec_keyb.c         |   6 +-
>  drivers/mfd/cros_ec_dev.c                     | 235 +----
>  drivers/platform/chrome/Kconfig               |  12 +
>  drivers/platform/chrome/Makefile              |   2 +
>  drivers/platform/chrome/cros_ec.c             |  80 +-
>  drivers/platform/chrome/cros_ec_ishtp.c       |  25 +-
>  drivers/platform/chrome/cros_ec_lpc.c         |  17 +-
>  drivers/platform/chrome/cros_ec_proto.c       | 267 ++++-
>  drivers/platform/chrome/cros_ec_rpmsg.c       |  23 +-
>  drivers/platform/chrome/cros_ec_sensorhub.c   | 263 +++++
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 973 ++++++++++++++++++
>  .../linux/iio/common/cros_ec_sensors_core.h   | 106 +-
>  include/linux/platform_data/cros_ec_proto.h   | 138 +--
>  .../linux/platform_data/cros_ec_sensorhub.h   | 171 +++
>  21 files changed, 2118 insertions(+), 632 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_sensorhub.c
>  create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c
>  create mode 100644 include/linux/platform_data/cros_ec_sensorhub.h
> 

