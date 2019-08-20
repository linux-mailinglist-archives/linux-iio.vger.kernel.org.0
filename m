Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEF8595686
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2019 07:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfHTFKv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Aug 2019 01:10:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32800 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbfHTFKu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2019 01:10:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so2512428pgn.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Aug 2019 22:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AucSo0iTG1cMBc8FIWdp3OKtOSf3xX/XdVDaCB+1w3E=;
        b=GtlBx2K57kgXonIcp24pVGTKNMUMW2gH4Ka/ZnrNxGwyCABh9lNy6Dm2MpjIZImJ26
         jU5y7MbU+ntQQYcCO02dfYsNsy3lD57BsjZjq5GFbK5hlEVPc4P2NEGqDWk6Sx6PSPdl
         81cIek9c7CeGB0heLGXoLWzXk5ncVehlORCtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AucSo0iTG1cMBc8FIWdp3OKtOSf3xX/XdVDaCB+1w3E=;
        b=q/D7+tB3r/1oo5U8GMAL1njUX/bqD7MBgxhpoD4t+Bo30dqNv68j+aklzMI+p9QOWS
         ot4/UGtY72GErB/tDBg2dbcAJ/zSJrduAezn0LxjnE56w/omxu5jYBaqavHxeS2r5uNL
         e2MKNFGo2d8x3+rQvvcFMcItsaRkfoItALPD2LRng2eoIGgC6WZqkGwMNyLUalzMuXIY
         ULa+QUDfI2A0vkFbYkZuVsrHRjhGvrshHnqS0moxvq21XTJJEIRuaDEwiKRsONexGcqG
         e2eyUsO6cd+Az3uU3TP/zzicq6PDpO0bs3SsbPveU3nM2dTfzU3MotCQdmhq9I3nzt2q
         ANOg==
X-Gm-Message-State: APjAAAXpnlLDWGinp01LMLa+/lDteoUBmxtHPquyVW0G3GfDuehjGgFN
        RE0hClRqgcLUpTOF59F6q3syihncqvI=
X-Google-Smtp-Source: APXvYqy9EyoevmrNpsIqO5DMd+laWuPTmqYg30O6Tg+dLWKU64cDPDNIaFnu2C4J1cZccf0uzNhjOg==
X-Received: by 2002:a65:49cc:: with SMTP id t12mr21549032pgs.83.1566277849606;
        Mon, 19 Aug 2019 22:10:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id p189sm18873562pfb.112.2019.08.19.22.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 22:10:48 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org
Cc:     enric.balletbo@collabora.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: cros_ec: set calibscale for 3d MEMS to unit vector
Date:   Mon, 19 Aug 2019 22:10:29 -0700
Message-Id: <20190820051029.118905-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

By default, set the calibscale vector to unit vector.
It prevents sending 0 as calibscale when not initialized.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---

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
2.23.0.rc1.153.gdeed80330f-goog

