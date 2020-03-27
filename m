Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14CD196132
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 23:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgC0Wet (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 18:34:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36401 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgC0Wes (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 18:34:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id j29so5270519pgl.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 15:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4W7il/SUE8zUP0mcJ/uA7eBv3zkE6qgGXJ8Gi2G1bGc=;
        b=fFJMe+uv7dx/GIdNbdWPiOEuHJbIMI2boKej//D6yPWsBog+iuRnO1i8EK8XtHwwQl
         tewoenQ+8uI/9F/fXK9tN2P9tMmV4WRFzFKGAJhcrT1WN695Hl1f91Q98A+E+H5QZ5Mf
         vs1iyY1rxXshI2BuE7UqTH1kWbEtPaqdLS1yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4W7il/SUE8zUP0mcJ/uA7eBv3zkE6qgGXJ8Gi2G1bGc=;
        b=N1kJL98kVAterd9uP4M6Fn4YKFuqyU5iprHW/cIIzNOawrqppr09Od1KE4LYaU7oX8
         6MCwWIon+js6AWQPpqJzETZN+LI54D0anL+P5ktyVXNdHrCMJLVCV1jTdBLYbauajtR7
         yd6cNsVn5+s3VdNuNatRigGzsFb/tm4tKBF3MM/XR37zfuttXSWcmhbQKNkLxXUUkGVW
         yrFtWZlRmwIWPK3c8KO10bzQxvM6+NYBCk8p3jhsVWSwOdmgaWr32dtimRPugW1vsgKI
         GllP9CLvpQURrgVMxWIvttiTq5MghgnOwk3/ud6pBASFsTAom+7XQjwdbqTS5617QcME
         2IeA==
X-Gm-Message-State: ANhLgQ1OD/sJoGINJuYcjKrCOUSJEKo//HVrzIMMpKUP8VVXS/TYACSs
        sMdVOSQ1wNP3YmhdGe2dLEHNqUms1ls=
X-Google-Smtp-Source: ADFU+vsEQm58Y6bck8dGuJISGBC8slSFs3004K27R3DUjblqN6/o1Gnrj1QUOPMHhugguLyolhfBsQ==
X-Received: by 2002:a63:5004:: with SMTP id e4mr1496115pgb.19.1585348487774;
        Fri, 27 Mar 2020 15:34:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id a2sm4441959pjq.20.2020.03.27.15.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:34:47 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 01/12] platform: chrome: sensorhub: Add the number of sensors in sensorhub
Date:   Fri, 27 Mar 2020 15:34:32 -0700
Message-Id: <20200327223443.6006-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200327223443.6006-1-gwendal@chromium.org>
References: <20200327223443.6006-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To better manage resources, store the number of sensors reported by
the EC.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
New in v7

 drivers/platform/chrome/cros_ec_sensorhub.c     | 4 +++-
 include/linux/platform_data/cros_ec_sensorhub.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index 79fefd3bb0fa6..134ee5e460472 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -65,6 +65,7 @@ static int cros_ec_sensorhub_register(struct device *dev,
 		return sensor_num;
 	}
 
+	sensorhub->sensor_num = sensor_num;
 	if (sensor_num == 0) {
 		dev_err(dev, "Zero sensors reported.\n");
 		return -EINVAL;
@@ -172,7 +173,8 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
 		 * If the device has sensors but does not claim to
 		 * be a sensor hub, we are in legacy mode.
 		 */
-		for (i = 0; i < 2; i++) {
+		data->sensor_num = 2;
+		for (i = 0; i < data->sensor_num; i++) {
 			ret = cros_ec_sensorhub_allocate_sensor(dev,
 						"cros-ec-accel-legacy", i);
 			if (ret)
diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
index bef7ffc7fce10..7e46a47fd642b 100644
--- a/include/linux/platform_data/cros_ec_sensorhub.h
+++ b/include/linux/platform_data/cros_ec_sensorhub.h
@@ -22,9 +22,11 @@ struct cros_ec_sensor_platform {
  * struct cros_ec_sensorhub - Sensor Hub device data.
  *
  * @ec: Embedded Controller where the hub is located.
+ * @sensor_num: Number of MEMS sensors present in the EC.
  */
 struct cros_ec_sensorhub {
 	struct cros_ec_dev *ec;
+	int sensor_num;
 };
 
 #endif   /* __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H */
-- 
2.26.0.rc2.310.g2932bb562d-goog

