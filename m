Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D601169E9E
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 00:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbfGOWCK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 18:02:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34452 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732779AbfGOWCK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jul 2019 18:02:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so2137454pgc.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2019 15:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhXoLG8P0nMA+YOIeWelO3ErTVoSm0/02oSgqurPZHs=;
        b=KbgDkDnR+UJA+By/unJMfuL5s63ke4W31lnTbZx/BpqPl/aQkxSZ2szfV/TSlaidoj
         fFRUemtdfb7lE7Etj0oSeYYvT8nzH3cPRq2g8cyG6NO+qV9ubheQ7breod4HKbC2XyaB
         oI0TiOJkcinMADDOqbZYep1qIlriY4XUig3Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhXoLG8P0nMA+YOIeWelO3ErTVoSm0/02oSgqurPZHs=;
        b=Ztj72RwtmewGVN33makLZuIzZu9sZ5Fbh3ekE2YQWN6zRhw66mXNSJ3iLampYTCOO8
         wtftuFt9sWy0fW7zMrlBa/lS3reG7IZPREB9gWz1eK6dLKpGRgjkaC9FWg3IThm9gf6i
         gLT+BXb3wa+2vxqkPsiZct0jLth86ysVRJ8Vp3NlMZkUfc+X2UTt7MbGI2M1v5zWmN7M
         PbnNd3beWntWuGSKq8ibjj7jIoykuVobuKGQpu/Wb8vKlOmccrij9l435bSSNO86C7H4
         xsuhexlWddtUnO5oS7SVPBjBoIs/AevJrTMVaoNDETKdfFTv3Ukf2zb8QdkmsjIO8Nun
         BL+g==
X-Gm-Message-State: APjAAAV0zH6W5zN1AOtJqFRbWYwgrbgYzwaf+uuGAFfDRUpgLIJcpXcE
        8Q5KWHXzNa/vArd7Gz41N+/qtQ==
X-Google-Smtp-Source: APXvYqxHll1LUwEk5NuyEh0r6rfo009kT0BeZDSvmFW1e2vqzq8tumyxyaIJ92hEqXNlHz1fctGZrg==
X-Received: by 2002:a65:50c5:: with SMTP id s5mr29153751pgp.368.1563228129249;
        Mon, 15 Jul 2019 15:02:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id h26sm19168079pfq.64.2019.07.15.15.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 15:02:08 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 1/4] iio: cros_ec: Add sign vector in core for backward compatibility
Date:   Mon, 15 Jul 2019 15:01:49 -0700
Message-Id: <20190715220152.119531-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715220152.119531-1-gwendal@chromium.org>
References: <20190715220152.119531-1-gwendal@chromium.org>
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

