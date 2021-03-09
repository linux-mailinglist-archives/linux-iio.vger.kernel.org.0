Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991D033228A
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 11:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCIKFH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 05:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCIKEh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 05:04:37 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC321C06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 02:04:37 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 16so7630986pfn.5
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 02:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SV1ThKQY1vu/XR58+gHjClWodHRGlMRbyEdEaQ2CrNg=;
        b=as+zegjwai+5yMnj04YuWa8FYvrCCN+px/Xqmg8rBXWSrkE7UxB0W/Q2w53gq6vW8K
         xAdX0060/eQDhbinODk9NT/hdw5QgbEokosceYNhhOmQyyAWPeIt16TwkaPjoC8al6gN
         q3eM7D/BJ6d+tCXtvSmP0kl7gBsi5bM+9uCcIor7cx9mIGBhOaSrVQSRk7SkBDFhyKHM
         zM3XrotSAoFwPmkt0Xsb0AnBQxRiyAteWr5YdLjnwQAU2Smfy3NrXnQwvAGx7V4NpPGE
         qdX3DO0vyfScBpZbYWxDvPfbCLZ66R2++CGCcFdHMhqfUnso/zMGcFfosBOWK2q7SyZa
         SDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SV1ThKQY1vu/XR58+gHjClWodHRGlMRbyEdEaQ2CrNg=;
        b=qjKJIXGW5IxRdATiIWQdc5N2dBhzll+M5kn0dOznd9vuTmfu5aIr3oYBSw4yXp+/6U
         vTqpS6FRh39yA1i60MqrpBjaDx7hZf062gPoAqtO951kxNQZGSZhuQJVueqFXBplWv3t
         bXjMHfOtEt/06mDyWzHu+WUvB2f84ZY5aXy4/RNnhL3e9ZGsnmqdi5Re6IIRTTDzS/KR
         lWWZyA+j0Btlzin7rMDDuWyl+pEWZhepnwKxW8Mda7C+kZJ2xTmW29WajtFk4yHhgqbo
         wT/HmkSGAxzoGGJzAPsSHVRwvmgQObwmdZjaDx5DIBNVRLSR1e5+8rjdo4dg74w6cJrY
         plQA==
X-Gm-Message-State: AOAM531GQYPL7r3sMxc9nX0wtBIwS626Yb0y98pjAcySlnKfhVD5ffsf
        eopD7O2xdbgQfLXHp8Ynl6lzMC8dUFro12Fbcbk=
X-Google-Smtp-Source: ABdhPJwG+55RApUnALtXJwNqHknDbSlzDsUHAJbgfDoLtluXQT2q3mjpN0hmmv3VvBSOvYYNpYRzVj9ZkQWJpLTS1CE=
X-Received: by 2002:a65:4bc5:: with SMTP id p5mr3438675pgr.74.1615284277372;
 Tue, 09 Mar 2021 02:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20210309011816.2024099-1-gwendal@chromium.org>
In-Reply-To: <20210309011816.2024099-1-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Mar 2021 12:04:21 +0200
Message-ID: <CAHp75VeLqcocDCTPe+oQQdUqYnCU9Nw1Ch4KVUhRYTAHObuT9A@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] iio: Set default trigger device parent
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 9, 2021 at 3:18 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Each drivers are setting trig->dev.parent to a common value - usually.

"Each driver is"

> Move that in boiler plate code.
>
> The first patch set the parent pointer, the next is an automatic change
> with spatch.
> The remaining ones are straightforward manual changes.

Few nit-picks here and there, overall LGTM
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Few drivers remain:
> drivers/iio/adc/at91-sama5d2_adc.c
> drivers/iio/adc/mxs-lradc-adc.c
> trigger parent set to iio device instead of its parent.
>
> drivers/iio/adc/dln2-adc.c
> trigger parent not set.
>
> drivers/iio/gyro/mpu3050-core.c
> trigger allocated for iio device but parent set to iio device parent.
>
> drivers/iio/imu/bmi160/bmi160_core.c
> drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> trigger allocated for iio device but parent set to mapped register device holder. Looks like iio device parent.
>
> drivers/iio/trigger/stm32-lptimer-trigger.c
> drivers/iio/trigger/stm32-timer-trigger.c
> trigger allocated for device, but parent set to device parent.
>
> Gwendal Grignou (8):
>   iio: set default trig->dev.parent
>   iio: fix devm_iio_trigger_alloc with parent.cocci
>   iio: adis_trigger: Remove code to set trigger parent
>   iio: gp2ap020a00f: Remove code to set trigger parent
>   iio: lmp91000: Remove code to set trigger parent
>   iio: chemical: atlas: Remove code to set trigger parent
>   iio: as3935: Remove code to set trigger parent
>   iio: xilinx-xadc: Remove code to set trigger parent
>
>  drivers/iio/accel/adxl372.c                   |  2 --
>  drivers/iio/accel/bma180.c                    |  3 +-
>  drivers/iio/accel/bmc150-accel-core.c         |  1 -
>  drivers/iio/accel/kxcjk-1013.c                |  2 --
>  drivers/iio/accel/mma8452.c                   |  1 -
>  drivers/iio/accel/mxc4005.c                   |  1 -
>  drivers/iio/accel/stk8312.c                   |  1 -
>  drivers/iio/accel/stk8ba50.c                  |  1 -
>  drivers/iio/adc/ad7606.c                      |  1 -
>  drivers/iio/adc/ad7766.c                      |  1 -
>  drivers/iio/adc/ad7768-1.c                    |  1 -
>  drivers/iio/adc/ad_sigma_delta.c              |  6 ++--
>  drivers/iio/adc/at91_adc.c                    |  3 +-
>  drivers/iio/adc/max1027.c                     |  1 -
>  drivers/iio/adc/xilinx-xadc-core.c            |  1 -
>  drivers/iio/chemical/atlas-sensor.c           |  1 -
>  drivers/iio/chemical/ccs811.c                 |  1 -
>  drivers/iio/chemical/scd30_core.c             |  1 -
>  .../common/hid-sensors/hid-sensor-trigger.c   |  4 +--
>  .../common/st_sensors/st_sensors_trigger.c    |  4 +--
>  drivers/iio/gyro/adxrs290.c                   |  1 -
>  drivers/iio/gyro/bmg160_core.c                |  2 --
>  drivers/iio/gyro/fxas21002c_core.c            |  1 -
>  drivers/iio/gyro/itg3200_buffer.c             |  3 +-
>  drivers/iio/health/afe4403.c                  |  1 -
>  drivers/iio/health/afe4404.c                  |  1 -
>  drivers/iio/humidity/hts221_buffer.c          |  1 -
>  drivers/iio/imu/adis_trigger.c                | 10 ++----
>  drivers/iio/imu/kmx61.c                       |  1 -
>  drivers/iio/industrialio-trigger.c            | 36 +++++++++++--------
>  drivers/iio/light/gp2ap020a00f.c              |  1 -
>  drivers/iio/light/rpr0521.c                   |  1 -
>  drivers/iio/light/si1145.c                    |  1 -
>  drivers/iio/light/st_uvis25_core.c            |  1 -
>  drivers/iio/light/vcnl4000.c                  |  1 -
>  drivers/iio/light/vcnl4035.c                  |  1 -
>  drivers/iio/magnetometer/bmc150_magn.c        |  1 -
>  drivers/iio/magnetometer/rm3100-core.c        |  1 -
>  drivers/iio/potentiostat/lmp91000.c           |  3 +-
>  drivers/iio/pressure/zpa2326.c                |  1 -
>  drivers/iio/proximity/as3935.c                |  1 -
>  drivers/iio/proximity/sx9310.c                |  1 -
>  drivers/iio/proximity/sx9500.c                |  1 -
>  drivers/iio/trigger/iio-trig-hrtimer.c        |  2 +-
>  drivers/iio/trigger/iio-trig-interrupt.c      |  2 +-
>  drivers/iio/trigger/iio-trig-loop.c           |  2 +-
>  drivers/iio/trigger/iio-trig-sysfs.c          |  3 +-
>  include/linux/iio/iio.h                       |  2 +-
>  include/linux/iio/trigger.h                   |  3 +-
>  49 files changed, 42 insertions(+), 81 deletions(-)
>
> --
> 2.30.1.766.gb4fecdf3b7-goog
>


-- 
With Best Regards,
Andy Shevchenko
