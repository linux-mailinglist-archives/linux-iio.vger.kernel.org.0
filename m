Return-Path: <linux-iio+bounces-27936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE50D3A09B
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 08:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A00363005FC4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92B528934F;
	Mon, 19 Jan 2026 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GwDS9cBQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E5500964
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808976; cv=none; b=b7uKozu6Zr98su0KWZ3p41FfnyY3ie7WGomnQKNvidFSBCtypfP8G5M3Mf9sLAXi/uZSPDlWdgghL+162+xOneNbKZRgzoT/aWOle9iWQ380Mk8FWjhNE46QERUErKJ7bM2ICVXDFu20Ai/iytMGywcOkzoF2RvIf6+gyd+Nat0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808976; c=relaxed/simple;
	bh=sfUIvDLYfrWyoY2KRiOHLG8zY764oxtnql1Kdo+H5X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2T5X2LOdqumQwMPWX0455PXbu7Z55eHRHL2jg5dd53jvQ8lfaSoDQoGqhqI2Rx6pt3qyERBjdQUiLbQL8roYOpvCcsiTVLdS/FQIuH7/zWCOIfcm+hvuTlTW/NpTVwDvw9fTxp16+IuH68TVwKHpYyh4clcyU1In6cj0w9ACsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GwDS9cBQ; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b4520f6b32so5299996eec.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 23:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768808974; x=1769413774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ftIt2GWChhb5BZO+6AL7R4Bl7HI2FHwGVT8UseNi550=;
        b=GwDS9cBQByQbwY5xlcIciR08z5jdCiyC55eRZi2ZkFgskch123uUPyBqWyFTCpbYr3
         cAg02Gjm+JmCPU6ei8/RAUUKQgCUdjBM/0ML7SoFHHLL2AeOPUvdd66o7i8RomWp/K3s
         f8rWMVtUIoJyTKoQMEvtm7p9ikMs7AF0yebSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768808974; x=1769413774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftIt2GWChhb5BZO+6AL7R4Bl7HI2FHwGVT8UseNi550=;
        b=nrrhhGYRdqPdZk+SpN1GwqSRsOU4dWZCOt4M1oSeI5E7CiDwwQRMVfAPVb4EwZnJ26
         e9pJcPCfcvYYpPSnGoqH9zhoBA0lNFVshjvSnVBgR41Yq1ElEtxfyAmtydG+KN1733Jj
         vzATyEjajX6AxRCR9QoYo0pHcH04GBrrsSnPQh+33PDZd8GG86QejAGDN3CXNta2TMeI
         cjjVxA8iKuXkq2x3Qk/SxOB6J1X09mou82WCGD1hs0ZCsycxzk21lHMFxgr3D+O1HIxG
         uhzlA+F5OMngTIl9FJMWquhcq93yNG3MMv0whrIBHEsWVcN3JA3rq/2g7gMJ3CN3eiV5
         u7WA==
X-Forwarded-Encrypted: i=1; AJvYcCXLRLDuZzqLqF1XdTG7XVgI94nO/6sewACC4ZoS1g9+AG29Qf7VhmxVKofmoj1ckttQdlspln5FceE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOd4ekrgoz7B0TSjzoNZ5/lYw4k73dR0nNqKZTK4OPKMWbvwv6
	4IeGqNZ2rIsXhCfItTw37+v79wNwmRuyH6X1PAkrq3Z1or+iNWK5YdQ6S5k7DLIUDQ==
X-Gm-Gg: AY/fxX7cSZ0Xd9oS1F9BLuK9K3XGB4obdktJgP/CeFZJN1n7pUZWyEDQ7tbWLGdtvom
	4WS1t0w3nSMUYVmPiNJ/a/dhOvi2pGtWDjAhux6OluywQrvpTUBHldCdJL89q1adBXCeHDzO7ev
	Ohn69WmkuF1tmqsSBarmCzk8JKPdfwjjGKnf7vuag6DiNi7Vxdi6ikhQrS+ofAwfvG0eiG6VKnY
	AMmrbZtZU0SbslruKKkeWY/W/yL0Q4Po5T3NyfeVA7K3FqAEEXoA73TCHKzU3JMEyJ6mtORfT0S
	hO5RAuVByvikoztopESdkZXHGxflkKYuu3/+MWt+RB6yHrD/So81FiJ3KGPa8Dhsv3xK4iHPn4x
	Y2tzOv4uoujCFJ313l9XGuzfOddWIQibPolTlKQUgfqMHoPHv6B+MU7V2AbGzlHEvBi6dmkU+/n
	bNdPWPdfs6aAOup3O22y4vnpKRvg3HgtigP8I8weP0VoPO
X-Received: by 2002:a05:7301:5f85:b0:2b1:7910:b0f9 with SMTP id 5a478bee46e88-2b6b4108213mr7706470eec.42.1768808974105;
        Sun, 18 Jan 2026 23:49:34 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:d473:4c4d:1b02:3ebe])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b6b34c0e22sm11611757eec.6.2026.01.18.23.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 23:49:33 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: jic23@kernel.org
Cc: nvaccaro@google.com,
	tzungbi@kernel.org,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: cros_ec: Allow enabling/disabling calibration mode
Date: Sun, 18 Jan 2026 23:49:28 -0800
Message-ID: <20260119074928.1334489-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

calibration was a one-shot event sent to the sensor to calibrate itself.
It is used on Bosch sensors (BMI160, BMA254).
For light sensor, we need to stay in calibration mode to run tests.
Accept boolean true and false (not just true) to enter/exit calibration.

Check "echo 0 > calibrate" is supported.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Nick Vaccaro <nvaccaro@google.com>
---
 .../common/cros_ec_sensors/cros_ec_sensors_core.c    |  6 +++---
 include/linux/platform_data/cros_ec_commands.h       | 12 +++++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 9ac80e4b7d756..f1cdee2a61cbd 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -444,14 +444,14 @@ static ssize_t cros_ec_sensors_calibrate(struct iio_dev *indio_dev,
 	ret = kstrtobool(buf, &calibrate);
 	if (ret < 0)
 		return ret;
-	if (!calibrate)
-		return -EINVAL;
 
 	mutex_lock(&st->cmd_lock);
 	st->param.cmd = MOTIONSENSE_CMD_PERFORM_CALIB;
+	st->param.perform_calib.enable = calibrate;
 	ret = cros_ec_motion_send_host_cmd(st, 0);
 	if (ret != 0) {
-		dev_warn(&indio_dev->dev, "Unable to calibrate sensor\n");
+		dev_warn(&indio_dev->dev, "Unable to calibrate sensor: %d\n",
+			 ret);
 	} else {
 		/* Save values */
 		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 69294f79cc88a..d363d60bb8a36 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -2598,13 +2598,19 @@ struct ec_params_motion_sense {
 
 		/*
 		 * Used for MOTIONSENSE_CMD_INFO, MOTIONSENSE_CMD_DATA
-		 * and MOTIONSENSE_CMD_PERFORM_CALIB.
 		 */
 		struct __ec_todo_unpacked {
 			uint8_t sensor_num;
-		} info, info_3, data, fifo_flush, perform_calib,
-				list_activities;
+		} info, info_3, data, fifo_flush, list_activities;
 
+		/*
+		 * Used for MOTIONSENSE_CMD_PERFORM_CALIB:
+		 * Allow entering/exiting the calibration mode.
+		 */
+		struct __ec_todo_unpacked {
+			uint8_t sensor_num;
+			uint8_t enable;
+		} perform_calib;
 		/*
 		 * Used for MOTIONSENSE_CMD_EC_RATE, MOTIONSENSE_CMD_SENSOR_ODR
 		 * and MOTIONSENSE_CMD_SENSOR_RANGE.
-- 
2.52.0.457.g6b5491de43-goog


