Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA0945CC7
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 14:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfFNM0W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 08:26:22 -0400
Received: from first.geanix.com ([116.203.34.67]:45596 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbfFNM0W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Jun 2019 08:26:22 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 386DA15E9;
        Fri, 14 Jun 2019 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560515025; bh=ZbXkWGCLh91XHA0BMF8N+gtza/hzhzwamuIrdpJUYyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dcS/s5978gvV5uQ9xtVnzmNZtAUXNA7zA95RLnVic5g/DOWcl26eHLiRGrw8ryriE
         ioAdNe6H/+0mqcVP5MELzeZpUJMMQjRs9UNwkDzT4uOctPJrv+R3ciezdefEJ5OkIz
         FEQ/4mduqT5TCmnZh9K+yTJQZctEEJgQts5Y6YxxBfvdywd0IURnYsfyC74sHkLO3/
         rcTkr7XvksM2kOI8Gfq2ncH40kFmEezzTamURJ3484CTUuovDbCBGO0nYnggpHv9Wd
         F8p906o2TJlxMaA0uSy3k/kG5IkxE8gUxVvHcYuJFFDTb9jCWLvF1mEDt6hjYsVnHR
         hmmKKProsKS/g==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, martin@geanix.com
Subject: [RFC PATCH 3/3] iio: imu: st_lsm6dsx: add wake on accelerometer threshold hook in sysfs
Date:   Fri, 14 Jun 2019 14:26:04 +0200
Message-Id: <20190614122604.52935-4-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190614122604.52935-1-sean@geanix.com>
References: <20190614122604.52935-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 796779db2bec
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds a wakeup threshold hook in sysfs, it enables us to
change the threshold value on the run.
For now this is the raw register value...

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 2c8ad7d65d2f..cbcd7920f05d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -657,12 +657,45 @@ static ssize_t st_lsm6dsx_sysfs_set_wakeup_enabled(struct device *dev,
 	return len;
 }
 
+static ssize_t st_lsm6dsx_sysfs_get_wakeup_threshold(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+
+	return sprintf(buf, "%d\n", hw->wake_threshold);
+}
+
+static ssize_t st_lsm6dsx_sysfs_set_wakeup_threshold(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+	int threshold;
+
+	if (kstrtoint(buf, 0, &threshold))
+		return -EINVAL;
+
+	if ((threshold < 0) || (threshold > 31))
+		return -EINVAL;
+
+	if (!st_lsm6dsx_set_wake_threshold(hw, threshold))
+		return len;
+
+	return -EINVAL;
+}
+
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sysfs_sampling_frequency_avail);
 static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
 		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
 static IIO_DEVICE_ATTR(wakeup_enabled, 0644,
 		       st_lsm6dsx_sysfs_get_wakeup_enabled,
 		       st_lsm6dsx_sysfs_set_wakeup_enabled, 0);
+static IIO_DEVICE_ATTR(wakeup_threshold, 0644,
+		       st_lsm6dsx_sysfs_get_wakeup_threshold,
+		       st_lsm6dsx_sysfs_set_wakeup_threshold, 0);
 static IIO_DEVICE_ATTR(in_anglvel_scale_available, 0444,
 		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
 
@@ -670,6 +703,7 @@ static struct attribute *st_lsm6dsx_acc_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
 	&iio_dev_attr_wakeup_enabled.dev_attr.attr,
+	&iio_dev_attr_wakeup_threshold.dev_attr.attr,
 	NULL,
 };
 
-- 
2.22.0

