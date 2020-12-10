Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0050B2D68FD
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 21:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390014AbgLJUnA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 15:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgLJUnA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 15:43:00 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0541C0613CF
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:19 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id s21so5225769pfu.13
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4F5yEw5LoxB7mVRv1S/HeWBXT12WjEAw6rtt2leYV4U=;
        b=e+TFkg1TvkwfqbXf6kp8Oi2fBtbiShdApexDkOrnCYux+lExpaUI5Pj+fpoQ39nma0
         rVo1iCDdOdpblu3knAer15yZ+QmSU9MIXGZOmLQBnvrrlO52rLealSd8hCKUMY/A6YI4
         kU41Z7sWgWYxzXJi1ymdl+c9T+vxYuBXdPhV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4F5yEw5LoxB7mVRv1S/HeWBXT12WjEAw6rtt2leYV4U=;
        b=UMQjNfBloeF6VY2z9YPplLmu9SIYiv2Z0bqnKxxtPbGgtEMB1ZzcP5cb2DvqlI7P2h
         UJR+ZC9Jn5TYe7DkaKCJVgH7TiGxf1KGCft+0GtVUGK31hMpf9FA2nfbd4KDkpwfcvt8
         iG1NpneUQSfmNkURD/moZMZuKtpZTpry8pw2XFl+dnp/xSd/N4TFzyg+rZXBPLicwzNm
         4Skg4Zk8S59itX8VNA+OES3LmtYYrQ6VJPQhIJJk7nfSgV1T3YlY8Y0DtyLeBFxdt00q
         CEpJqxmmaHIKiHHbpEIGTqkZhmzZWjBkm9LsVpHlpCCv3NDMd1OzOcQ9zbMGdShZrdr1
         BUqg==
X-Gm-Message-State: AOAM530+X8QyCuku2JD7fFqLxfsMhJttLjR16MAXMaSG8ddE8yL4y5OT
        yl0L1lPqKwO5orb11RMUZ+LHKw==
X-Google-Smtp-Source: ABdhPJwcMGL3Phj4Q6hd/5PpIM6zrRBIDuL5wMUamB2DVGm7ukA/2DGjowIpFam4Sh8ZUmooKZ5Aeg==
X-Received: by 2002:a63:f910:: with SMTP id h16mr1569189pgi.77.1607632939420;
        Thu, 10 Dec 2020 12:42:19 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id gw21sm7413113pjb.28.2020.12.10.12.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:42:18 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 0/7] iio: Set default trigger device parent
Date:   Thu, 10 Dec 2020 12:42:04 -0800
Message-Id: <20201210204211.967018-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
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

Gwendal Grignou (7):
  iio: set default trig->dev.parent
  iio: fix devm_iio_trigger_alloc with parent.cocci
  iio: adis_trigger: Remove code to set trigger parent
  iio: gp2ap020a00f: Remove code to set trigger parent
  iio: lmp91000: Remove code to set trigger parent
  iio: chemical: atlas: Remove code to set trigger parent
  iio: as3935: Remove code to set trigger parent

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
 drivers/iio/industrialio-trigger.c            | 31 ++++++++++++-------
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
 include/linux/iio/trigger.h                   |  3 +-
 49 files changed, 39 insertions(+), 79 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

