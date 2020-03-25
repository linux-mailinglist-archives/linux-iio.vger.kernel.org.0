Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9817192D9B
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 16:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgCYP7J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 11:59:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43420 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbgCYP7J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 11:59:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id u12so1327559pgb.10;
        Wed, 25 Mar 2020 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YohqWyS95zI3u9ADg0DbKTTWF+VZopIxmoai3opFyUY=;
        b=lxh5Mm2n9Gg4euwPgph8MImlNpPHw7fqQmicCVmu+l+N4bOwQVTqgrcQrwMRPAKYIn
         8fvX43u4lyNRsyUhfULceLgQVax2AeYYyr2oJIohOcIwOiAto6CiFCMeMlaseviC/5E4
         AwD7OKI+DGyF27pNwPsITzkoTJAXGbSQMuwQsuZWL+vYWimMbqR7xZTAVWcvRvK2VjlH
         vBhT5988RMVKucELB2glYYcTdHbOa6dE816JvEf47gLNLaxRfoUJwRy2lrDIzto3Qj9B
         iV8FR9RQ+V8lNffTZJcvq3A4lICJHd7wUq0JywvABv+PokegyHQ4Cr/8gGv/TPPmCsBj
         M7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YohqWyS95zI3u9ADg0DbKTTWF+VZopIxmoai3opFyUY=;
        b=IeuiscT+1P6VY1dtDEKvwae+sc9RvheGIES/fex18tTvta99QUY5gUvbofQAEjgESZ
         KWXbu8PoB+/6cw1qRD+TZw+N0Q4yEDjcXeOP4yKZwlGTlUCbMJAWyEmff3D5dcPpndkm
         sqwnrxKX1EdFCotYz/Te7OOhR0lUVS/oWd1g8Y3Vz45hv4vYbIAnOLw8rIel9gc6RFw9
         1arnwrxu86OS0WNnlKBmQB/p4Tk+2yXuUh7vvUnjJnag/12ocZGBaYWOV8f0wFz0tqNA
         HfL1n7rYMPEA+np4B0BFGl5/jjU4ZSx7DpuWPYc/sZ8/yk+gIwfZvo9Dq9ECQ6wnHm/l
         h/vg==
X-Gm-Message-State: ANhLgQ1mQ5BSsSLLOleFQVpXLmd5zf44cslPo1FCX847bPhuVFOwwzos
        i3gjRGVf3l6nywsloe/FpgVV3RdGPB+B3YpqgT8=
X-Google-Smtp-Source: ADFU+vtqMoCme/CUqCBk/NS4st8CIubR3xs2p/NvbiTghhiFdYIWBwQkwkAGk4E+lb7CaFgnv4dDyd3LBrRrtZ0FSNY=
X-Received: by 2002:a63:1c4d:: with SMTP id c13mr3730420pgm.4.1585151947591;
 Wed, 25 Mar 2020 08:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200324202736.243314-1-gwendal@chromium.org>
In-Reply-To: <20200324202736.243314-1-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Mar 2020 17:59:00 +0200
Message-ID: <CAHp75Vd+46fdKZXuFj0sAhXw9cfN+5SFW3dFZh+YsLFNiiGDWQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Cros EC sensor hub FIFO support
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 24, 2020 at 10:28 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
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
> And extra parameter - flush - (presents on HID and ST sensor hub
> implementation) force the EC to send accumulated events in its queue,
> without waiting for buffer hwfifo_timeout to expire.
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

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com> # for
drivers/platform/chrome bits

> Gwendal Grignou (11):
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
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |  404 +++++--
>  drivers/iio/industrialio-core.c               |    8 +-
>  drivers/iio/light/cros_ec_light_prox.c        |   15 +-
>  drivers/iio/pressure/cros_ec_baro.c           |   14 +-
>  drivers/platform/chrome/Makefile              |    4 +-
>  drivers/platform/chrome/cros_ec_sensorhub.c   |  107 +-
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 1002 +++++++++++++++++
>  .../linux/iio/common/cros_ec_sensors_core.h   |  104 +-
>  include/linux/iio/iio.h                       |    2 +
>  .../linux/platform_data/cros_ec_sensorhub.h   |  166 +++
>  13 files changed, 1612 insertions(+), 238 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c
>
> --
> 2.25.1.696.g5e7596f4ac-goog
>


-- 
With Best Regards,
Andy Shevchenko
