Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D1769F61
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 01:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbfGOXPB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 19:15:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37757 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfGOXPB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jul 2019 19:15:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so8127392pfa.4
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2019 16:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhXoLG8P0nMA+YOIeWelO3ErTVoSm0/02oSgqurPZHs=;
        b=Yv4m51z76Fdk+O/Fk3kj38Q/sos+0DEI26wiWRrPtkGvTq2KD8sNaju8wSqGvzKK7P
         WmpFaI9zfsofoSgH02kFODp3mdbAIoOT8SKX5ShhKVpYwvyXa0NGq9u8oks/d3MLk81H
         As7UlyKesiVQv5oSa4CyuIuXbgo6JwekBDxkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhXoLG8P0nMA+YOIeWelO3ErTVoSm0/02oSgqurPZHs=;
        b=Bx7MJYUZ81C7977hqx+3rE6Qx9KIleZ4Z3y4v3pcPqnOmKlRo9a1pI9JH8+QjYu/mZ
         Ulg5e34VZpw1X6FLSAXY8PCwiBzYBVeFfs9lzNbb6eVTgi/66o1Yc1RI7KEsD5Vaaw5Z
         pWI7t0djvpOiNuGSBjmoABTNYM2ujLvic5IMxYazsNisI5UaDhZciim8fEOSWp8Iuo3s
         R9VIUdgpuThfj5exGVelkBVXZx1RXYp+1lifFB+tzHGA1Y0eLWphZB4CqdsT86rNCaU/
         iSBofitEFCBiSjpt/1rMspDeoA7bTYuIoKK94vvXxGsek6PS8bktVtL+gV2j81Spntfa
         vYag==
X-Gm-Message-State: APjAAAWZERFwCI85J3Q0P08/EvdqAUW7TyFlb2uviefCZ9gDhVhsXn2z
        mUR+ruFxqA8aatyy46Nvt5CHjg==
X-Google-Smtp-Source: APXvYqz+zxkihdIA92v31sq+9bU9V0KVb6yAYzOQ26k1vKro62lT+3LcHadA1bvzfFfyavwIf+81Eg==
X-Received: by 2002:a17:90a:360c:: with SMTP id s12mr32514637pjb.30.1563232500337;
        Mon, 15 Jul 2019 16:15:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id b24sm17113690pfd.98.2019.07.15.16.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 16:14:59 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 1/4] iio: cros_ec: Add sign vector in core for backward compatibility
Date:   Mon, 15 Jul 2019 16:14:51 -0700
Message-Id: <20190715231454.189459-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715231454.189459-1-gwendal@chromium.org>
References: <20190715231454.189459-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To allow cros_ec iio core library to be used with legacy device, add a
vector to rotate sensor data if necessary: legacy devices are not
reporting data in HTML5/Android sensor referential.

Check the data is not rotated on recent chromebooks that use the HTML5
standard to present sensor data.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 4 ++++
 include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 719a0df5aeeb..e8a4d78659c8 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -66,6 +66,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		}
 		state->type = state->resp->info.type;
 		state->loc = state->resp->info.location;
+
+		/* Set sign vector, only used for backward compatibility. */
+		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
 	}
 
 	return 0;
@@ -254,6 +257,7 @@ static int cros_ec_sensors_read_data_unsafe(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
+		*data *= st->sign[i];
 		data++;
 	}
 
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index ce16445411ac..a1c85ad4df91 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -71,6 +71,7 @@ struct cros_ec_sensors_core_state {
 	enum motionsensor_location loc;
 
 	s16 calib[CROS_EC_SENSOR_MAX_AXIS];
+	s8 sign[CROS_EC_SENSOR_MAX_AXIS];
 
 	u8 samples[CROS_EC_SAMPLE_SIZE];
 
-- 
2.22.0.510.g264f2c817a-goog

