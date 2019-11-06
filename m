Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45208F1CE1
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2019 18:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfKFRzo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Nov 2019 12:55:44 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40745 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfKFRzo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2019 12:55:44 -0500
Received: by mail-qv1-f66.google.com with SMTP id r8so1784662qvq.7
        for <linux-iio@vger.kernel.org>; Wed, 06 Nov 2019 09:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FJUHLMbm/tSIBVChotuCj0exRQqONQj2GQ4evg4p8S4=;
        b=RGC8VoaYZgvMAG9dHAi3ksfCgLsDHuzPId0Etq13p+14RiaQeRCZAiAYGR+gQtFmIj
         Jq+VbG6R0zbeVnCln39x86W5DNDaQ4IGvbYJoJVU/X67IrxX0MLsPmFysQ/GwVmWqE19
         vfgZLlZt2+LeX0sB+N+LxV1uBxygSx4anhhd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FJUHLMbm/tSIBVChotuCj0exRQqONQj2GQ4evg4p8S4=;
        b=CpLvxuATUKS/H/PHdLBqIjSJ+jTW0uPk2pRjqD+a5eYYzCGzrmwhvmEZON4D139bI9
         lRTJdrjRlSbNrTAaszxcWtQPziqMlipyOfTdMkRRU0TC+Gx4X+/x2RoElPguWeRNIz77
         DG+8lEYmuGxsJGRfljrRUiUkhA+L4XpLvVh65d1UgE37+xZhWGluNrT1nuXZ+cua08Zm
         4roYjr5SRchLp1ouMOPdpTSwgi6pvfRFhJoHxhXYFqNziwOjtOX4yfDyqMY0yIH11QTI
         oEYvOgzfcoLNeAQV1XVAQi/LR579c591oQjd7MKLi4ox2+hwr9aE35YDd6tHG2DUOOFn
         r7iQ==
X-Gm-Message-State: APjAAAV9meuyQpzmLxdm8nkawklhrNzkHVBnAxu5e7/vn7BypZx3PjaQ
        qQpJki6sYt6tcnAyUZfWV/H+RQ4WSdsjsw==
X-Google-Smtp-Source: APXvYqzujX2c2birywXm7OIXBUo15MaC1VRQP0EYr/lN7hw9f7//js/ruVmerChKJmZphx1nnhYu1Q==
X-Received: by 2002:a63:e148:: with SMTP id h8mr4191713pgk.297.1573062942282;
        Wed, 06 Nov 2019 09:55:42 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id l62sm14511880pgl.24.2019.11.06.09.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 09:55:41 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     fabien.lahoudere@collabora.com, enric.balletbo@collabora.com,
        jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio: cros_ec_baro: set info_mask_shared_by_all_available field
Date:   Wed,  6 Nov 2019 09:55:33 -0800
Message-Id: <20191106175533.199257-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Field was already set for light/proximity and
accelerometer/gyroscope/magnetometer sensors.

Fixes: ae7b02ad2f32 ("iio: common: cros_ec_sensors: Expose
cros_ec_sensors frequency range via iio sysfs")

Change-Id: Iffa4c47979994eaaf1abb609c75c080923ecf600
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v2:
 Forgot to add read_avail entry point.

 drivers/iio/pressure/cros_ec_baro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 2354302375de..52f53f3123b1 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -114,6 +114,7 @@ static int cros_ec_baro_write(struct iio_dev *indio_dev,
 static const struct iio_info cros_ec_baro_info = {
 	.read_raw = &cros_ec_baro_read,
 	.write_raw = &cros_ec_baro_write,
+	.read_avail = &cros_ec_sensors_core_read_avail,
 };
 
 static int cros_ec_baro_probe(struct platform_device *pdev)
@@ -149,6 +150,8 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 		BIT(IIO_CHAN_INFO_SCALE) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_FREQUENCY);
+	channel->info_mask_shared_by_all_available =
+		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
 	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
 	channel->scan_type.shift = 0;
-- 
2.24.0.432.g9d3f5f5b63-goog

