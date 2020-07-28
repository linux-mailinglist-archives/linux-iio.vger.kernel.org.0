Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2011231131
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgG1SBW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgG1SBV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:01:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CE8C061794
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 11:01:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f9so260839pju.4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1SdceZNh9L+Lp9C1ZJql+X/rBOasJLEpgdQx1XWxDqI=;
        b=doN4N0ImFCyBAd3czlSOEpI4vVobZL0z32UJf6KO79Onp/6T58CR3kyoBxAkNmOaD1
         p6LPGZXTwj3Lxi3NGIu8TAnEzRdjobLQUBqnKS648ZtcqnXcoxkGL8tXLn0qkwIeZrb5
         szWEOW4tdk2ymZtlDkf/cgjye3KDTES9INRp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1SdceZNh9L+Lp9C1ZJql+X/rBOasJLEpgdQx1XWxDqI=;
        b=aDKtLhu+CCZzmDxDBEWnVVu6yoavHAa4Y9nnKmGneCU+1bJneKkeEExIdgpAe/B9HP
         Rbd6C9tcQ5jx8v2ynFkl0hNKdS8kONrF53cLB1Sq9PigEFX5NDzPYVqqEPQnjo2yHOAJ
         YmeuQbOD5D+DYGfE9ct/lEaOcuuM6qXNW5sU8oZmdmfpckDuXu04ZWuQWcuZ6UgATud5
         tXl6Z0XsWYwpiYlne2Bf0ilJ+4KC7omJPvZg6tVia42fizHn5CqjbsSQFI9WzhRhQuri
         c4l89ATjjOacs138KK/achrjk9kXdSxuquopmcuvdY8/eMGOV36NkWZz9CRLF5Uvyh6l
         aEmw==
X-Gm-Message-State: AOAM531cCpnlM8NxDvK+3Kms/akodGade7yzHd1eNGZjiuQn1/GXBdLw
        IAGvGk18Zb9v58JBIcHrOZuIDQ==
X-Google-Smtp-Source: ABdhPJy3f+pjgVwoyVAI4yP+KAPrWg9O7qhjKVuDxt6Kn/MgTXewiszYugvTWU9wmuVaZRX6EVFLpw==
X-Received: by 2002:a17:902:a9c1:: with SMTP id b1mr24705827plr.234.1595959281090;
        Tue, 28 Jul 2020 11:01:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id q5sm19439221pfc.130.2020.07.28.11.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 11:01:20 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org, enric.balletbo@collabora.com
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: cros_ec: Set Gyroscope default freuqency to 25Hz
Date:   Tue, 28 Jul 2020 11:01:11 -0700
Message-Id: <20200728180111.3263162-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMI160 Minimium gyroscope frequency in normal mode is 25Hz.
When older EC firmware do not report their sensors frequencies,
use 25Hz as the minimum for gyroscope to be sure it works on BMI160.

Fixes: ae7b02ad2f32d ("iio: common: cros_ec_sensors: Expose cros_ec_sensors
frequency range via iio sysfs")

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 156848d27c473..213837c2ecee2 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -85,10 +85,13 @@ static void get_default_min_max_freq(enum motionsensor_type type,
 
 	switch (type) {
 	case MOTIONSENSE_TYPE_ACCEL:
-	case MOTIONSENSE_TYPE_GYRO:
 		*min_freq = 12500;
 		*max_freq = 100000;
 		break;
+	case MOTIONSENSE_TYPE_GYRO:
+		*min_freq = 25000;
+		*max_freq = 100000;
+		break;
 	case MOTIONSENSE_TYPE_MAG:
 		*min_freq = 5000;
 		*max_freq = 25000;
-- 
2.28.0.rc0.142.g3c755180ce-goog

