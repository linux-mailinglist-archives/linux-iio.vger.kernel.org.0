Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0B74D5106
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfJLQaU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 12:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbfJLQaT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 12:30:19 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46B5A2087E;
        Sat, 12 Oct 2019 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570897819;
        bh=0QeoKIx358nOUEGn7TdMlYAFeC4/vu3FEHmOuAT6hRY=;
        h=From:To:Cc:Subject:Date:From;
        b=NEhV4sKOFv/UiECSwkzq11wfl/ybvoA3iCW0Kn+bAmSrCSTXstv9g3bASoiltjPem
         r2R/0dwIsnEetI2FXZv+JWwo0KIUAFCFQ3n/jBh4BLlL0jwla+GQlT6pqLEZrFo3/u
         brlSfZe7Crdy8r+Qy6aiEofGyI1TldOwYpDx2zgM=
From:   jic23@kernel.org
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC] iio: adis: Fix build warnings due to disagreement on whether ret can be > 0
Date:   Sat, 12 Oct 2019 17:28:08 +0100
Message-Id: <20191012162808.1196470-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I added a check to the inline functions in the header that provide
the specific sized versions of __adis_read_reg_* to check if
they were returning 0 before setting the value.   This was
needed to solve a 0-day report which I was unable to replicate.

Unfortunately it caused some build warnings because the drivers
check for ret is not negative before using the value, leaving the
positive range where flow continues, but the value is unset.

This is one of several possible fixes, hence the RFC.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/gyro/adis16136.c | 4 ++--
 drivers/iio/imu/adis.c       | 2 +-
 drivers/iio/imu/adis16480.c  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 2d2c48f0b996..223c42ef6f86 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -191,7 +191,7 @@ static int __adis16136_get_freq(struct adis16136 *adis16136, unsigned int *freq)
 	int ret;
 
 	ret = __adis_read_reg_16(&adis16136->adis, ADIS16136_REG_SMPL_PRD, &t);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*freq = 32768 / (t + 1);
@@ -288,7 +288,7 @@ static int adis16136_get_filter(struct iio_dev *indio_dev, int *val)
 
 	ret = __adis_read_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT,
 				 &val16);
-	if (ret < 0)
+	if (ret)
 		goto err_unlock;
 
 	ret = __adis16136_get_freq(adis16136, &freq);
diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 5e28464ea05b..6ee54996609a 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -289,7 +289,7 @@ int __adis_check_status(struct adis *adis)
 	int i;
 
 	ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	status &= adis->data->status_error_mask;
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 01dae50e985b..ed3e52651003 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -564,7 +564,7 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 	mutex_lock(slock);
 
 	ret = __adis_read_reg_16(&st->adis, reg, &val);
-	if (ret < 0)
+	if (ret)
 		goto out_unlock;
 
 	if (freq == 0) {
@@ -944,7 +944,7 @@ static int adis16480_enable_irq(struct adis *adis, bool enable)
 	int ret;
 
 	ret = __adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	val &= ~ADIS16480_DRDY_EN_MSK;
-- 
2.23.0

