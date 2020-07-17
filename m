Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551C22240F4
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgGQQ42 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgGQQ40 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79108C0619D3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so18247898wmf.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hi8qOFeRWHwGMDY6+jyfXlM1WO1ALepxa0e5DvrODkg=;
        b=nmzt8PjWuuA+nerSb1mT8vWtyIVb8t6x0n1ZjmUMFFq5nUEXV/oEb1bfhDKmv7k0gk
         dtQ1sP5wZzl/3gBZtwoaFXnsSqL5WgnKFggNptn+AV63jQsWjtQsjjXKmjofXcKnyBeK
         +xYZY5QnWpRDeoxkEJ0MMoq9xiPv+IeWZyiFTBI7SbJsWGxadSH9GsLR67Xm+oKbIeX0
         nuo5jzYM6uzv7wSQh4Rt5ZujXneQexwZNsSvFxFcChybReyai11tjhaMjA7Y3vfXHdnh
         B/JcJMpxxDj7ysxOz8ds+DYZBb/Db+Xp5fLrbSvEzRCE4IMRR84Zs0V7JjFubZ8mxKJR
         C5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hi8qOFeRWHwGMDY6+jyfXlM1WO1ALepxa0e5DvrODkg=;
        b=i0ectxRGvch2VDpNfNLhubFOeEh336WVLrsIfpngEDDbdoivvdKtiYOHt31tP4E6wl
         09lraA7pjbqHvzPQp9qy59tsD7RhyVvfoSO1LffzVhe790M9YO8xxaRMucZJcKyNVx4r
         /o5cKQVQAbELFWfFWXD6voL5x6iWsr9lDdplCcs+AYZmO+RMl2x7AECcPGv2J9DGLODB
         WtQa52qrFFYLen+/MQTfjduZuOuanSb9vntbhLdTvveaa6c249wAsIFgLHkaEIXmk06s
         xiSUjgIfL4tJfGtZ1o0l1Zh37dOEj+z4RsEJi/OGWGyszb86ACLLgI9x5jzcUpJRu61T
         T5Tg==
X-Gm-Message-State: AOAM530eNM6Jng2SpkbZqGVavss4uwNIFdM1oy6SpBqJ8nCmVzgxwemy
        V8+9UUuO9pbVXUlAsv18sLtoog==
X-Google-Smtp-Source: ABdhPJzfenz4Z0x8Hd0PIQJbMUlVocb/ARj5dXJtbJSeh57vwPJPM27nkqMYuDx53bhXG4kR8UKxXQ==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr10497071wmc.187.1595004985201;
        Fri, 17 Jul 2020 09:56:25 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 24/30] iio: imu: inv_mpu6050: inv_mpu_core: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Fri, 17 Jul 2020 17:55:32 +0100
Message-Id: <20200717165538.3275050-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:444: warning: Function parameter or member 'st' not described in 'inv_mpu6050_set_lpf_regs'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:444: warning: Function parameter or member 'val' not described in 'inv_mpu6050_set_lpf_regs'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:480: warning: Function parameter or member 'indio_dev' not described in 'inv_mpu6050_init_config'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:862: warning: Function parameter or member 'st' not described in 'inv_mpu6050_set_lpf'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:862: warning: Function parameter or member 'rate' not described in 'inv_mpu6050_set_lpf'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:893: warning: Function parameter or member 'dev' not described in 'inv_mpu6050_fifo_rate_store'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:893: warning: Function parameter or member 'attr' not described in 'inv_mpu6050_fifo_rate_store'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:893: warning: Function parameter or member 'buf' not described in 'inv_mpu6050_fifo_rate_store'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:893: warning: Function parameter or member 'count' not described in 'inv_mpu6050_fifo_rate_store'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:954: warning: Function parameter or member 'dev' not described in 'inv_fifo_rate_show'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:954: warning: Function parameter or member 'attr' not described in 'inv_fifo_rate_show'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:954: warning: Function parameter or member 'buf' not described in 'inv_fifo_rate_show'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:975: warning: Function parameter or member 'dev' not described in 'inv_attr_show'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:975: warning: Function parameter or member 'attr' not described in 'inv_attr_show'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:975: warning: Function parameter or member 'buf' not described in 'inv_attr_show'
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:1282: warning: Function parameter or member 'st' not described in 'inv_check_and_setup_chip'

Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 4d604fe842e5d..f6b2b2e8f1010 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -433,7 +433,7 @@ static int inv_mpu6050_set_gyro_fsr(struct inv_mpu6050_state *st,
 	return regmap_write(st->map, st->reg->gyro_config, data);
 }
 
-/**
+/*
  *  inv_mpu6050_set_lpf_regs() - set low pass filter registers, chip dependent
  *
  *  MPU60xx/MPU9150 use only 1 register for accelerometer + gyroscope
@@ -467,7 +467,7 @@ static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
 	return regmap_write(st->map, st->reg->accel_lpf, val);
 }
 
-/**
+/*
  *  inv_mpu6050_init_config() - Initialize hardware, disable FIFO.
  *
  *  Initial configuration:
@@ -847,7 +847,7 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 	return result;
 }
 
-/**
+/*
  *  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
  *
  *                  Based on the Nyquist principle, the bandwidth of the low
@@ -884,7 +884,7 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
 	return 0;
 }
 
-/**
+/*
  * inv_mpu6050_fifo_rate_store() - Set fifo rate.
  */
 static ssize_t
@@ -945,7 +945,7 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-/**
+/*
  * inv_fifo_rate_show() - Get the current sampling rate.
  */
 static ssize_t
@@ -962,7 +962,7 @@ inv_fifo_rate_show(struct device *dev, struct device_attribute *attr,
 	return scnprintf(buf, PAGE_SIZE, "%u\n", fifo_rate);
 }
 
-/**
+/*
  * inv_attr_show() - calling this function will show current
  *                    parameters.
  *
@@ -1275,7 +1275,7 @@ static const struct iio_info mpu_info = {
 	.debugfs_reg_access = &inv_mpu6050_reg_access,
 };
 
-/**
+/*
  *  inv_check_and_setup_chip() - check and setup chip.
  */
 static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
-- 
2.25.1

