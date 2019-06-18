Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A69249C97
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfFRJHF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 05:07:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59984 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfFRJHF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jun 2019 05:07:05 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7D582283982;
        Tue, 18 Jun 2019 10:07:03 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] iio: common: cros_ec_sensors: move iio_info management to core
Date:   Tue, 18 Jun 2019 11:06:32 +0200
Message-Id: <629386ef37bf96cf5120f0e875ebf1c549126669.1560848479.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1560848479.git.fabien.lahoudere@collabora.com>
References: <cover.1560848479.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In order to avoid code duplication and make future works easier,
we add an iio_info structure to cros_ec_sensors_core_state structure.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c      | 8 ++------
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 2 ++
 drivers/iio/light/cros_ec_light_prox.c                    | 8 ++------
 drivers/iio/pressure/cros_ec_baro.c                       | 8 ++------
 include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
 5 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 17af4e0fd5f8..c59b0ab8fe7d 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -172,11 +172,6 @@ static int cros_ec_sensors_write(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static const struct iio_info ec_sensors_info = {
-	.read_raw = &cros_ec_sensors_read,
-	.write_raw = &cros_ec_sensors_write,
-};
-
 static int cros_ec_sensors_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -199,7 +194,6 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	indio_dev->info = &ec_sensors_info;
 	state = iio_priv(indio_dev);
 	for (channel = state->channels, i = CROS_EC_SENSOR_X;
 	     i < CROS_EC_SENSOR_MAX_AXIS; i++, channel++) {
@@ -235,6 +229,8 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 	}
+	state->core.info.read_raw = &cros_ec_sensors_read;
+	state->core.info.write_raw = &cros_ec_sensors_write;
 
 	/* Timestamp */
 	channel->type = IIO_TIMESTAMP;
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 130362ca421b..a1b324e1a5d8 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -68,6 +68,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		state->loc = state->resp->info.location;
 	}
 
+	indio_dev->info = &state->info;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 308ee6ff2e22..b319d95fb70f 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -161,11 +161,6 @@ static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static const struct iio_info cros_ec_light_prox_info = {
-	.read_raw = &cros_ec_light_prox_read,
-	.write_raw = &cros_ec_light_prox_write,
-};
-
 static int cros_ec_light_prox_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -188,10 +183,11 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	indio_dev->info = &cros_ec_light_prox_info;
 	state = iio_priv(indio_dev);
 	state->core.type = state->core.resp->info.type;
 	state->core.loc = state->core.resp->info.location;
+	state->core.info.read_raw = &cros_ec_light_prox_read;
+	state->core.info.write_raw = &cros_ec_light_prox_write;
 	channel = state->channels;
 
 	/* Common part */
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 034ce98d6e97..85a4864e3a4e 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -107,11 +107,6 @@ static int cros_ec_baro_write(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static const struct iio_info cros_ec_baro_info = {
-	.read_raw = &cros_ec_baro_read,
-	.write_raw = &cros_ec_baro_write,
-};
-
 static int cros_ec_baro_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -134,10 +129,11 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	indio_dev->info = &cros_ec_baro_info;
 	state = iio_priv(indio_dev);
 	state->core.type = state->core.resp->info.type;
 	state->core.loc = state->core.resp->info.location;
+	state->core.info.read_raw = &cros_ec_baro_read;
+	state->core.info.write_raw = &cros_ec_baro_write;
 	channel = state->channels;
 	/* Common part */
 	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 0c636b9fe8d7..a729e667f760 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -70,6 +70,7 @@ struct cros_ec_sensors_core_state {
 				    unsigned long scan_mask, s16 *data);
 
 	int curr_sampl_freq;
+	struct iio_info info;
 };
 
 /**
-- 
2.20.1

