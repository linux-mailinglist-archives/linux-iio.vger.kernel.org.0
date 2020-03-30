Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9EE0197C4E
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgC3M47 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 08:56:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59876 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgC3M47 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 08:56:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 368072981B1
Subject: Re: [PATCH v7 00/12] Cros EC sensor hub FIFO support
To:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200327223443.6006-1-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <bd18a910-4f1b-661a-53a7-c69e7f3e9222@collabora.com>
Date:   Mon, 30 Mar 2020 14:56:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327223443.6006-1-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal,

On 27/3/20 23:34, Gwendal Grignou wrote:
> This patchset adds a sensorhub driver for spreading sensor
> events coming from the Embedded controller sensor FIFO:
> 
>        +---------------+ +--------------+ +----
>        | cros_ec_accel | | cros_ec_gyro | | ...
>        +---------------+ +--------------+ +----
>            id:0       \        id:1 |       / id:..
>                  +------------------------------+
>                  |       cros-ec-sensorhub      |
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
> The patch set allows the host to receive MEMS sensor sample
> asynchronously from ChromeOS Emebedded Controller (EC).
> 
> Given the EC and the host are not synchronized, the timestamp generated
> by the EC drifts and the AP interrupt latency adds variable delay.
> 
> When events arrive, the driver stores the time of the interrupt and use
> that information to convert the timestamp from the EC time domain to the
> AP time domain. To prevent the errors from the interrupt time variation,
> a median filter smooth the timestamp generation and prevents timestamps
> to go in the past.
> 
> When a batch of sensor events arrives, the sensor hub ring code spreads
> the timestamps.
> 
> The buffer interaface is presentid through the IIO ABI.
> And extra parameter - flush - (presents on HID and ST sensor hub implementation)
> force the EC to send accumulated events in its queue, without waiting
> for buffer hwfifo_timeout to expire.
> 
> To access sensor data, we can use iio_readdev like:
>  iio_readdev -T 10000 -s 4 -b 2 iio:device4
> 
> When FIFO is not supported by the EC, a trigger is present in the
> directory. After registering a trigger, setting sampling_frequency,
> the latest data collected by the sensor will be retrieved by the host
> when the trigger expires.
> 
> When cros_ec_accel_legacy driver is used, no FIFO is supported and the
> sampling frequency for the accelerometers is hard coded at 10Hz.
> 
> Gwendal Grignou (12):
>   platform: chrome: sensorhub: Add the number of sensors in sensorhub
>   platform: chrome: sensorhub: Add FIFO support
>   platform: chrome: sensorhub: Add code to spread timestmap
>   platform: chrome: sensorhub: Add median filter
>   iio: cros_ec: Move function description to .c file
>   iio: expose iio_device_set_clock
>   iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO
>   iio: cros_ec: Remove pm function
>   iio: cros_ec: Expose hwfifo_timeout
>   iio: cros_ec: Report hwfifo_watermark_max
>   iio: cros_ec: Use Hertz as unit for sampling frequency
>   iio: cros_ec: flush as hwfifo attribute
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c      |    8 +-
>  .../cros_ec_sensors/cros_ec_lid_angle.c       |    3 +-
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |   13 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |  403 +++++--
>  drivers/iio/industrialio-core.c               |    8 +-
>  drivers/iio/light/cros_ec_light_prox.c        |   15 +-
>  drivers/iio/pressure/cros_ec_baro.c           |   14 +-
>  drivers/platform/chrome/Makefile              |    4 +-
>  drivers/platform/chrome/cros_ec_sensorhub.c   |  111 +-
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 1046 +++++++++++++++++
>  .../linux/iio/common/cros_ec_sensors_core.h   |  104 +-
>  include/linux/iio/iio.h                       |    2 +
>  .../linux/platform_data/cros_ec_sensorhub.h   |  163 +++
>  13 files changed, 1655 insertions(+), 239 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c
> 

Queued patches from 0 to 11 to for-next. Patch 12 needs some rework.

Thanks,
Enric

