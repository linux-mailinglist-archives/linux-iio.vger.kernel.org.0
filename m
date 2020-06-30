Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AFF20F009
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 09:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgF3H7j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 03:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgF3H7i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 03:59:38 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04DBC061755
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:59:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w2so8771234pgg.10
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jeC8GVIzcrPU4psaaDsOk851rDSBtTAuq0O80hwsrZI=;
        b=mUGdGeke1nFNywrlZbYB1cCw7KwleKe+qukxWVHhKm5IOAYBEd96A3+2rdOjgW84RK
         oxGqAu+75XvDlSAaw8su59OoglikQEFVGJN13cXfiDdw44L8+j7eNAsq39DHlRqD0sIq
         zvvwmMLm1G5lUz9FNoBgx4qp/JJ0rsZ4s03Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jeC8GVIzcrPU4psaaDsOk851rDSBtTAuq0O80hwsrZI=;
        b=oZ6wzYxqz48Abo7oh4HBCZVPoWUaV1ry56H5Y9PTJZu7RK/himoSfuuwEE5hxKmDEg
         /20DMzQg5u9qqnFoYPN6ngeI+6D3zgaRJ820JBxxOOs3w7DkL8ciNZXUKwDBbpHsIFSI
         qBusQ3+TgsJuqiQmBzQ1WvgTbQzkxHDosRIOosbZ7Yc6FmAEIfLZ+DpiVkJC+W72Dt2t
         n0mF5/JlwVXUc4UfNFJNQyFUXR5CCn1uwvCMx7YD1n+c1VhqVDsf/DAlkoKsixFniGJU
         JMd0cRuBx0bD3lG3y8mCAotp/Rz5XnH994zg8pONojhTlN//z42lVrazk6BeTe+GGqVE
         ZxYw==
X-Gm-Message-State: AOAM53209DQcHsHEggUSmCXUrFNPGpgTfITJuRoFB2GxmRavrrS8gqzj
        guvjsc8hi1U8gb8yOzrA0Jx78w==
X-Google-Smtp-Source: ABdhPJwjMp68Izsxm8JpwCNsF1Yd89eR3wzN6eGZ6myZN5nL4uDLRDH6dT0fFKkdif0s3m1OC/lzfw==
X-Received: by 2002:a62:ce48:: with SMTP id y69mr17022688pfg.208.1593503978220;
        Tue, 30 Jun 2020 00:59:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id f20sm1794234pfn.51.2020.06.30.00.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 00:59:37 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org, enric.balletbo@collabora.com
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: cros_ec: Use default frequencies when EC returns invalid information
Date:   Tue, 30 Jun 2020 00:59:33 -0700
Message-Id: <20200630075933.3056990-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Minimal and maximal frequencies supported by a sensor is queried.
On some older machines, these frequencies are not returned properly and
the EC returns 0 instead.
When returned maximal frequency is 0, ignore the information and use
default frequencies instead.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 .../common/cros_ec_sensors/cros_ec_sensors_core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 36e3f20891f05..8437ff659260b 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -289,7 +289,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
 	struct cros_ec_dev *ec = sensor_hub->ec;
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
-	u32 ver_mask;
+	u32 ver_mask, temp;
 	int frequencies[ARRAY_SIZE(state->frequencies) / 2] = { 0 };
 	int ret, i;
 
@@ -345,8 +345,17 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 						 &frequencies[2],
 						 &state->fifo_max_event_count);
 		} else {
-			frequencies[1] = state->resp->info_3.min_frequency;
-			frequencies[2] = state->resp->info_3.max_frequency;
+			if (state->resp->info_3.max_frequency == 0) {
+				get_default_min_max_freq(state->resp->info.type,
+							 &frequencies[1],
+							 &frequencies[2],
+							 &temp);
+			} else {
+				frequencies[1] =
+					state->resp->info_3.min_frequency;
+				frequencies[2] =
+					state->resp->info_3.max_frequency;
+			}
 			state->fifo_max_event_count =
 			    state->resp->info_3.fifo_max_event_count;
 		}
-- 
2.27.0.212.ge8ba1cc988-goog

