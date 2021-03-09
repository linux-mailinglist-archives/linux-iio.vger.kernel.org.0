Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446F2333204
	for <lists+linux-iio@lfdr.de>; Wed, 10 Mar 2021 00:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhCIXnu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 18:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhCIXnU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 18:43:20 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738FDC06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 15:43:20 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b23so2124855pfo.8
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 15:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qAAN5oUm/wH3seqrHMB2Z9YQ2gWc8131n9wO8pNAkf4=;
        b=jMgCczgNeYOnp4wXuIEU3Ij+CuIxL4LffelTeWLS0JRMeFIfpGQlRSv7DBsR03yr92
         3vcNBo82mlfnlQgd3t52bUk0Bh0LdJMPZ39xMUEyHaV/fn3PE5zXROUWUJr4GCJkyEMt
         aHF38rqBoLsPlxiSwHbbOw1ytSMqiSfhcklMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qAAN5oUm/wH3seqrHMB2Z9YQ2gWc8131n9wO8pNAkf4=;
        b=EAqho0x1INC3Iyf08Q9F3nllagH3Ftm3LJrC7Z5F4gLD0qTtOmqdzapTO5lQoLfx3Y
         q9r5jlUTflXK8QtkBXR7ChcsDvh4gVHq5h79mDze1U3k7qP5JAQ40bNdJUc66vjqEq3k
         15CsFSZ4HfQVUGpKtkGVws6RQ63hLcI8ObxHze6Dlq3h4yVIB6MO/GeandRePHCbVQkr
         grc/mfF5Uwoz92NulLMdJUiFAtPktSOs9MI3zpXh4G2zlNEt9oUl32cri3MRRTTvh2cP
         8EVeGpkhNAQbwZYl+4kTTTIdcahZJMOgcpEdgYypY5tPbg/h7oHVdZ3fgHFdT6dC3GHv
         N8RA==
X-Gm-Message-State: AOAM530cFUyHoUrmOD2h/41uyJRmj7eucQU5u7TLdbFTBqzvPgteU+b6
        JOC7g5XAPR8sj2gLRU0w2cObSUdhq8lF2Q==
X-Google-Smtp-Source: ABdhPJzLpLhYPPoyvJwFhIZfepO7bkRUAS54cYrkrvvvJ8KjFUcUS0t5Ir5zAvA+K0M4+bM5OcHxHA==
X-Received: by 2002:aa7:99c6:0:b029:1f5:c49d:dce7 with SMTP id v6-20020aa799c60000b02901f5c49ddce7mr392599pfi.78.1615333399886;
        Tue, 09 Mar 2021 15:43:19 -0800 (PST)
Received: from localhost ([2620:15c:202:201:98f9:3cff:c504:d44b])
        by smtp.gmail.com with UTF8SMTPSA id e1sm3839622pjm.12.2021.03.09.15.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 15:43:19 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: Remove kernel-doc keyword in file header comment
Date:   Tue,  9 Mar 2021 15:43:14 -0800
Message-Id: <20210309234314.2208256-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove kernel-doc keyword from function header comment.
It fixes issues spotted by scripts/kernel-doc like:
drivers/iio/<driver>.c:3: info: Scanning doc for function <component name>
drivers/iio/<driver>.c:X: warning: expecting prototype for <component name>.
  Prototype was for <function>() instead

To reproduce the errors:
scripts/kernel-doc -v -none $(find drivers/iio/ -name \*.c \
-exec head -2 {} \+ | grep -B2 -e '\*\*' | grep '==' | cut -d ' ' -f 2)

After, confirm these errors are gone with:
scripts/kernel-doc -v -none $(git show --name-only  | grep -e "^driver")

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/bma220_spi.c         | 2 +-
 drivers/iio/accel/da280.c              | 2 +-
 drivers/iio/accel/da311.c              | 2 +-
 drivers/iio/accel/dmard10.c            | 2 +-
 drivers/iio/accel/mc3230.c             | 2 +-
 drivers/iio/accel/mma7660.c            | 2 +-
 drivers/iio/accel/stk8312.c            | 2 +-
 drivers/iio/accel/stk8ba50.c           | 2 +-
 drivers/iio/adc/ti-adc084s021.c        | 2 +-
 drivers/iio/humidity/am2315.c          | 2 +-
 drivers/iio/light/opt3001.c            | 2 +-
 drivers/iio/light/stk3310.c            | 2 +-
 drivers/iio/trigger/iio-trig-hrtimer.c | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 3c9b0c6954e60..36fc9876dbcaf 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * BMA220 Digital triaxial acceleration sensor driver
  *
  * Copyright (c) 2016,2020 Intel Corporation.
diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 4472dde6899ec..5edff9ba72da7 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * IIO driver for the MiraMEMS DA280 3-axis accelerometer and
  * IIO driver for the MiraMEMS DA226 2-axis accelerometer
  *
diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index 3b3df620ba272..92593a1cd1aa6 100644
--- a/drivers/iio/accel/da311.c
+++ b/drivers/iio/accel/da311.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * IIO driver for the MiraMEMS DA311 3-axis accelerometer
  *
  * Copyright (c) 2016 Hans de Goede <hdegoede@redhat.com>
diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index 90206f015857d..e84bf8db1e895 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * IIO driver for the 3-axis accelerometer Domintech ARD10.
  *
  * Copyright (c) 2016 Hans de Goede <hdegoede@redhat.com>
diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 46e4283fc0375..735002b716f32 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * mCube MC3230 3-Axis Accelerometer
  *
  * Copyright (c) 2016 Hans de Goede <hdegoede@redhat.com>
diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index b3c9136d51ec7..47f5cd66e996e 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Freescale MMA7660FC 3-Axis Accelerometer
  *
  * Copyright (c) 2016, Intel Corporation.
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 3b59887a8581b..1a8a1a0c3ffb4 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Sensortek STK8312 3-Axis Accelerometer
  *
  * Copyright (c) 2015, Intel Corporation.
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 3ead378b02c9b..7a06904455eb2 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Sensortek STK8BA50 3-Axis Accelerometer
  *
  * Copyright (c) 2015, Intel Corporation.
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index fb14b92fa6e71..d6e1bf3de755c 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) 2017 Axis Communications AB
  *
  * Driver for Texas Instruments' ADC084S021 ADC chip.
diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 02ad1767c845e..23bc9c784ef4b 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Aosong AM2315 relative humidity and temperature
  *
  * Copyright (c) 2016, Intel Corporation.
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 2d48d61909a4d..52963da401a78 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * opt3001.c - Texas Instruments OPT3001 Light Sensor
  *
  * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index a2827d03ab0fb..07e91846307c7 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Sensortek STK3310/STK3311 Ambient Light and Proximity Sensor
  *
  * Copyright (c) 2015, Intel Corporation.
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index 410de837d0417..9fbf878ad2d18 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * The industrial I/O periodic hrtimer trigger driver
  *
  * Copyright (C) Intuitive Aerial AB
-- 
2.30.1.766.gb4fecdf3b7-goog

