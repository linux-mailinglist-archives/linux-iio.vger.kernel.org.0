Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCA7331C36
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 02:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhCIBSs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 20:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhCIBSZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 20:18:25 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBBFC06174A
        for <linux-iio@vger.kernel.org>; Mon,  8 Mar 2021 17:18:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d23so2531497plq.2
        for <linux-iio@vger.kernel.org>; Mon, 08 Mar 2021 17:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VuEWd1WO7dOk3Ol8ApqGq4VvO7rRq0drhF9XnE4gNwY=;
        b=m9vqc8YQcLJNbmuyihiAmy3cExgdHY4anAXBYdXYHlETcKqV/PligR+9pq8aSyW41u
         tPBy9/sv9MyiefmoINq0oBZDzW7HgzW2jGbPsYBwTiDKdMoXPSjPlg9qNW+x/RtKsSPo
         S8oDJDdgWQyGslP4HzL6jfXn7VgNzvL8yqBWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VuEWd1WO7dOk3Ol8ApqGq4VvO7rRq0drhF9XnE4gNwY=;
        b=Ct/z6wCVoQjsfftaewdnKdJz2kYDT5adqNDbhTzoaFFyD3XIm55ryyROdRkpYFF59O
         uxMLAPyyq4xCy1DMLTEkEh3ROsSPwL5Dyrkeo+/UmSprLvzQTk8KqtQArcX41kXlh+37
         YBY7N/Vno+nQ8BHudzNC+5pVhV22q04jw9ehW+FF10ddxMEI64GNSZbg8N0YR3iShZb0
         qadKxrsyNUBf0VypGdNfwO3ge3yDzH9rs7hsYrSMnTwZvZkAnREOp5SDB23dQyFUt+Lf
         M2lEH6rMHwRWK/M9sRZ5Z0VXV9TGwYuddVTmD3d7L7TvJO0BJfU29ey1C8hBpiJhaWFU
         ETrQ==
X-Gm-Message-State: AOAM532VSnoD0/1W8dL2HWkfcib8YqBdEHHMXhSX2fQwT34YNeccXnaK
        b1dhqbAQ6lW/lcdnA+sdHWxD5w==
X-Google-Smtp-Source: ABdhPJwPL/IUOt7cKatQORR5x9yFa6za/Xc7kcyn9gNDDDryh1e+9icsCd8Ovben7SQSGRLC9DH5MQ==
X-Received: by 2002:a17:90a:a789:: with SMTP id f9mr1914994pjq.192.1615252704682;
        Mon, 08 Mar 2021 17:18:24 -0800 (PST)
Received: from localhost ([2620:15c:202:201:3cb0:414a:7f1c:ca43])
        by smtp.gmail.com with UTF8SMTPSA id g22sm533559pju.30.2021.03.08.17.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 17:18:23 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 0/8] iio: Set default trigger device parent
Date:   Mon,  8 Mar 2021 17:18:08 -0800
Message-Id: <20210309011816.2024099-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Each drivers are setting trig->dev.parent to a common value - usually.
Move that in boiler plate code.

The first patch set the parent pointer, the next is an automatic change
with spatch.
The remaining ones are straightforward manual changes.

Few drivers remain:
drivers/iio/adc/at91-sama5d2_adc.c
drivers/iio/adc/mxs-lradc-adc.c
trigger parent set to iio device instead of its parent.

drivers/iio/adc/dln2-adc.c
trigger parent not set.

drivers/iio/gyro/mpu3050-core.c
trigger allocated for iio device but parent set to iio device parent.

drivers/iio/imu/bmi160/bmi160_core.c
drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
trigger allocated for iio device but parent set to mapped register device holder. Looks like iio device parent.

drivers/iio/trigger/stm32-lptimer-trigger.c
drivers/iio/trigger/stm32-timer-trigger.c
trigger allocated for device, but parent set to device parent.

Gwendal Grignou (8):
  iio: set default trig->dev.parent
  iio: fix devm_iio_trigger_alloc with parent.cocci
  iio: adis_trigger: Remove code to set trigger parent
  iio: gp2ap020a00f: Remove code to set trigger parent
  iio: lmp91000: Remove code to set trigger parent
  iio: chemical: atlas: Remove code to set trigger parent
  iio: as3935: Remove code to set trigger parent
  iio: xilinx-xadc: Remove code to set trigger parent

 drivers/iio/accel/adxl372.c                   |  2 --
 drivers/iio/accel/bma180.c                    |  3 +-
 drivers/iio/accel/bmc150-accel-core.c         |  1 -
 drivers/iio/accel/kxcjk-1013.c                |  2 --
 drivers/iio/accel/mma8452.c                   |  1 -
 drivers/iio/accel/mxc4005.c                   |  1 -
 drivers/iio/accel/stk8312.c                   |  1 -
 drivers/iio/accel/stk8ba50.c                  |  1 -
 drivers/iio/adc/ad7606.c                      |  1 -
 drivers/iio/adc/ad7766.c                      |  1 -
 drivers/iio/adc/ad7768-1.c                    |  1 -
 drivers/iio/adc/ad_sigma_delta.c              |  6 ++--
 drivers/iio/adc/at91_adc.c                    |  3 +-
 drivers/iio/adc/max1027.c                     |  1 -
 drivers/iio/adc/xilinx-xadc-core.c            |  1 -
 drivers/iio/chemical/atlas-sensor.c           |  1 -
 drivers/iio/chemical/ccs811.c                 |  1 -
 drivers/iio/chemical/scd30_core.c             |  1 -
 .../common/hid-sensors/hid-sensor-trigger.c   |  4 +--
 .../common/st_sensors/st_sensors_trigger.c    |  4 +--
 drivers/iio/gyro/adxrs290.c                   |  1 -
 drivers/iio/gyro/bmg160_core.c                |  2 --
 drivers/iio/gyro/fxas21002c_core.c            |  1 -
 drivers/iio/gyro/itg3200_buffer.c             |  3 +-
 drivers/iio/health/afe4403.c                  |  1 -
 drivers/iio/health/afe4404.c                  |  1 -
 drivers/iio/humidity/hts221_buffer.c          |  1 -
 drivers/iio/imu/adis_trigger.c                | 10 ++----
 drivers/iio/imu/kmx61.c                       |  1 -
 drivers/iio/industrialio-trigger.c            | 36 +++++++++++--------
 drivers/iio/light/gp2ap020a00f.c              |  1 -
 drivers/iio/light/rpr0521.c                   |  1 -
 drivers/iio/light/si1145.c                    |  1 -
 drivers/iio/light/st_uvis25_core.c            |  1 -
 drivers/iio/light/vcnl4000.c                  |  1 -
 drivers/iio/light/vcnl4035.c                  |  1 -
 drivers/iio/magnetometer/bmc150_magn.c        |  1 -
 drivers/iio/magnetometer/rm3100-core.c        |  1 -
 drivers/iio/potentiostat/lmp91000.c           |  3 +-
 drivers/iio/pressure/zpa2326.c                |  1 -
 drivers/iio/proximity/as3935.c                |  1 -
 drivers/iio/proximity/sx9310.c                |  1 -
 drivers/iio/proximity/sx9500.c                |  1 -
 drivers/iio/trigger/iio-trig-hrtimer.c        |  2 +-
 drivers/iio/trigger/iio-trig-interrupt.c      |  2 +-
 drivers/iio/trigger/iio-trig-loop.c           |  2 +-
 drivers/iio/trigger/iio-trig-sysfs.c          |  3 +-
 include/linux/iio/iio.h                       |  2 +-
 include/linux/iio/trigger.h                   |  3 +-
 49 files changed, 42 insertions(+), 81 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

