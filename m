Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 930CD9D9BE
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 01:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfHZXDI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Aug 2019 19:03:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42285 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfHZXDH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Aug 2019 19:03:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id p3so11461677pgb.9
        for <linux-iio@vger.kernel.org>; Mon, 26 Aug 2019 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bVRIjgzMwAqxXns5N+dHw5KIDXsRHaWlI4IhPrgP/ww=;
        b=A3/pKOzD0Np24RKGi9Qn/ncAueuHM8pXQLnXWy9z0isNL1x4sDbTSgz6CkBCKOc4Ja
         RnA2HndYqYa5y9l3awHSCbQI0qoSvVz3dHIxtBpbQ1oH7sueTZY7fx2utPPow/4ni5T0
         DxQFq05fVhs+VeL0c8gPWJ7CFPGfneY7UYNMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bVRIjgzMwAqxXns5N+dHw5KIDXsRHaWlI4IhPrgP/ww=;
        b=bOCe0sCKCcbd77fCOsrYsOHpaxsjuySmG2+BgCMNhR3ZRsfoIACL/sKrqm4rIEns6d
         lqrItcp8lI3MEIlNCCHwlN5YnoQLaOtJZi//pigMDUNKK56Xwzf3/d6OxPsr/rjAhDaU
         qiMpUNwi40oPQjCBTntlOqd7FmjOYijeJ1bp5YpfL8guedS7GLnRjYXnHDrTvqIWzbTv
         i+rXdtvtc5/nI7AAaPpB7wyWLPD2O44IMYXMD5iWuHrDgSghhvaIxBFOMkVZfz/XqiHa
         bIb/DmTwffrq2c8Qhu65NVj547/b+seRiPH7iiJQGRRB2SeEqHDy3Cg2Vyi94JojwF/l
         KBcg==
X-Gm-Message-State: APjAAAU4O/0EsAC1//jL6vou0KmcTzDOYD7jI905akRcsyhW1QgGzSv7
        60IzzdCVk2ODyM2uHcIJh9zg/Q==
X-Google-Smtp-Source: APXvYqysY75VXURBl0E23DHyZYz/VYDdXkvwmZDWBIaDTyDU2tpIPODWt0f1nmHLQdN0O3PR5G4hfA==
X-Received: by 2002:aa7:9a52:: with SMTP id x18mr23384036pfj.8.1566860587004;
        Mon, 26 Aug 2019 16:03:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 15sm5094062pfh.188.2019.08.26.16.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 16:03:06 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org
Cc:     enric.balletbo@collabora.com, linux-iio@vger.kernel.org,
        nvaccaro@chromium.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio: cros_ec: set calibscale for 3d MEMS to unit vector
Date:   Mon, 26 Aug 2019 16:02:58 -0700
Message-Id: <20190826230258.203235-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

By default, set the calibscale vector to unit vector.
When calibrating one axis, the other axis calibrations  are sent as well.
If left to 0, sensor data from uncalibrated axis are zero'ed out until
all axis are calibrated.

Fixes: ed1f2e85da79 ("iio: cros_ec: Add calibscale for 3d MEMS ")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v2:
- Add fixes tag.
- Improve description.

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index fd833295bb173..d44ae126f4578 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -90,7 +90,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
 	u32 ver_mask;
-	int ret;
+	int ret, i;
 
 	platform_set_drvdata(pdev, indio_dev);
 
@@ -136,6 +136,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		/* Set sign vector, only used for backward compatibility. */
 		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
 
+		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
+			state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
+
 		/* 0 is a correct value used to stop the device */
 		state->frequencies[0] = 0;
 		if (state->msg->version < 3) {
-- 
2.23.0.187.g17f5b7556c-goog

