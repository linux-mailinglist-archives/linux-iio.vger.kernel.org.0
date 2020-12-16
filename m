Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734A52DBA00
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 05:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgLPEU5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Dec 2020 23:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLPEU5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Dec 2020 23:20:57 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E62AC0613D6
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2020 20:20:17 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id c12so16233199pgm.4
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2020 20:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CKQHrCKSXA6lmTxmfSC0zJ1stXi8BtK292xlbkRby0k=;
        b=nruS+J7aI9yRn8PLuxPCc4ztcrEIC6jpqYBD5qaQ/6TDRBmG9Vv+AUwEjFCUG+XRNf
         +j311cU/HQWncoOesLxxk099KqtQTxxra27mtxc4PjytyaaTYOxbNxhL7Hw+yMb0+Btl
         sDphzU1Us2onEvZbRDj44vArgIqtYGl+O+9kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CKQHrCKSXA6lmTxmfSC0zJ1stXi8BtK292xlbkRby0k=;
        b=hcege7vE1nszdcVA1TVYr97iUsJZ5CcB7vPzFdZ1EmcF+SPaPoWEXJ/SAOP/0jNPqb
         odksI04z2r2nG9l5wPe9+kXsR+C5aP46RZ8u6npeSwGck0/sJeJyNmB7FNmCK9pgBlUA
         c4cisENRs/VUV/psn7ptsp7rF5o6iTYcJ9ji6+eRCNdXqfdSNBVhSBMlkvJzrLW+Xn8x
         BCoZJ6SWHzuJ6pmVArnac5gCX4xPEZXam+0K7I1UD6bdvTVpv/rod3AcJnVlUXQzhUx7
         AdciaZDl5MZaz5ShcwSB+glaxOaLZTuh4kHAEz3Q4Gpfvxh32/rhUCZHE6pN8N81U3MV
         pPuQ==
X-Gm-Message-State: AOAM531VafZfvBhJUFswm2PYXdsPCP4MgQNQqVXgspz6tDgkT7zNRhCJ
        RwPFFDyjmMeRPKQPaojKzqKMfA==
X-Google-Smtp-Source: ABdhPJzcS32DUVKjaDsyzWsdGx2u9txorpDWhA5zbbZTUGmM+NgA10R+gTfU/s7ujYA4+ns4VEkqVA==
X-Received: by 2002:a62:2c9:0:b029:19d:d3f7:7dba with SMTP id 192-20020a6202c90000b029019dd3f77dbamr1711594pfc.40.1608092416626;
        Tue, 15 Dec 2020 20:20:16 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id h11sm583362pfn.27.2020.12.15.20.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 20:20:15 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 0/8] iio: Set default trigger device parent
Date:   Tue, 15 Dec 2020 20:20:08 -0800
Message-Id: <20201216042009.15233-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

[Added a new patch to rename iio_trigger_alloc argument from dev to
parent for clarity. Other patches remain the same.]

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
  iio: Rename iio_trigger_alloc dev argument to parent

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
 drivers/iio/adc/ad_sigma_delta.c              |  4 +--
 drivers/iio/adc/at91_adc.c                    |  3 +-
 drivers/iio/adc/max1027.c                     |  1 -
 drivers/iio/adc/xilinx-xadc-core.c            |  4 +--
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
 drivers/iio/industrialio-trigger.c            | 33 +++++++++++--------
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
 drivers/iio/proximity/sx932x.c                |  1 -
 drivers/iio/proximity/sx9500.c                |  1 -
 drivers/iio/trigger/iio-trig-hrtimer.c        |  2 +-
 drivers/iio/trigger/iio-trig-interrupt.c      |  2 +-
 drivers/iio/trigger/iio-trig-loop.c           |  2 +-
 drivers/iio/trigger/iio-trig-sysfs.c          |  3 +-
 include/linux/iio/iio.h                       |  2 +-
 include/linux/iio/trigger.h                   |  3 +-
 50 files changed, 41 insertions(+), 81 deletions(-)

-- 
2.29.2.684.gfbc64c5ab5-goog

