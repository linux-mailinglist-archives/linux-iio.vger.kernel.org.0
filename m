Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C921D332F17
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 20:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhCITgg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 14:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhCITgZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 14:36:25 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3168C06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 11:36:24 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x7so6683799pfi.7
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 11:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ia5hEmYZpNqKUSM42FkbbfulzySANsZPziY0I2xJK7E=;
        b=gfmbWBLnGddRVsV5xVEU6/v9Y5co2/i20HplGK57TNOUZbZ2jIz7T8TZiSXK4IDiHX
         xA8/zjdXzm7cULU2Zopq+vniSPO++3JrOIURn6GkB1nT1JHwUkgJS61BE6cJ5xdHdwfN
         Iaeo9T950WM7EFPFNWjuYIngjGIhTXNq7L8XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ia5hEmYZpNqKUSM42FkbbfulzySANsZPziY0I2xJK7E=;
        b=dSPiZ22S794JJByCWEl05CyiLY4y1TxXY4ghrsUDTmLSRKYauzWAbhn2b2QecAwfEr
         mc8vgWHFp1ZiUn9Y1DFsh9Slc9mfCSsHgDCOtDd4nXtHSezSCEKpZ5VL0rJImKyINJrs
         dIc7D4eBVN20js7Xx9m2qSvRZSxqoeUZhX3IgUUJMzKwAZ2yKmEHvo8HElNvpdbRNTvm
         Qf7mWLjzapgEy0ARjy0ExUnOPkhJVe2lRGqf82khEciiQ4P+h4sm+2Pis0Pgh3ncWkkq
         dKn6gRwxeekjBTVOXmP+hC0peMwEDqq9FGYJt6fDmIzhWX7qyjLxkanjU0v5jtHOL+C8
         iJYA==
X-Gm-Message-State: AOAM531AP/mSlSKIuBq1AjtqwXnmM+93KbOgOf5X9OvWkZwiIzPXMQl0
        OeF3lPoHVSPNMimrOUj2SEKSFA==
X-Google-Smtp-Source: ABdhPJy/0j1w7E7M+bAX2kpT2PTf0Zz05N7uY6vnoYVo6SCqmiH6dpHNfHiQK6oFaWdtiyBp1KMeoQ==
X-Received: by 2002:a05:6a00:1582:b029:1bc:fb40:4bd7 with SMTP id u2-20020a056a001582b02901bcfb404bd7mr27868028pfk.41.1615318584195;
        Tue, 09 Mar 2021 11:36:24 -0800 (PST)
Received: from localhost ([2620:15c:202:201:98f9:3cff:c504:d44b])
        by smtp.gmail.com with UTF8SMTPSA id p3sm13812734pgl.88.2021.03.09.11.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:36:23 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 0/8] iio: Set default trigger device parent
Date:   Tue,  9 Mar 2021 11:36:12 -0800
Message-Id: <20210309193620.2176163-1-gwendal@chromium.org>
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


Changes in v4:
- Allow lines to be greater than 80 characters.
- Document patches that manually remove trigger parent assignments
  better.

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
 drivers/iio/industrialio-trigger.c            | 34 +++++++++++--------
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
 49 files changed, 40 insertions(+), 81 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

