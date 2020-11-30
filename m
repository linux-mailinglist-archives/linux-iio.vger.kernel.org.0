Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EA82C8494
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 14:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgK3NAC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 08:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgK3NAB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2020 08:00:01 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000C1C0613D4
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2020 04:59:20 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u18so21411442lfd.9
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2020 04:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vzUKpDdGw3DeKYZJvtAHtIzx8LG3ZUWuYSvug1TKDA=;
        b=g3YzTo4yvJ3DZWSgyEBJJlJ+eH2u1CVKPSIupC/KGG28Uw6/foiMIuWq/xhwkpQcdB
         QDbTcAB8HQ/Kn0SGB1Uwv6KYoYOP7IcchVHVYzWGZJdAR5y0XOeAL0M4qr/CLjJuhnjj
         ZcRXEUcIOjpWmbsoVUgDqcc8THjRuR97LMEqiCdNHrO6qnQXlIt47DZCgmP3T/DKquJz
         H1ZqZU72EPF6mk4j/HTqoxmgNAFPbVPgN945SGfPFSuFM96g83f6AtBQz2AD4QfQGVIf
         ft3n4AtN1gPrOA9I5yNIY5teXowmwjT3ZkXd/RXzFZ7G1EHyUvUOz26iJbBJuMqWTolY
         DAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vzUKpDdGw3DeKYZJvtAHtIzx8LG3ZUWuYSvug1TKDA=;
        b=lQ5c9E/6gLe+zEBNSLLLLSDTW4yLMwz+iItLrD5TJJIMdLfJJ7YMePwHodJ+rOpRsd
         040j2WbjSfITzm2ou/WC4YhDUA4/VbneNgBl/T26KGvIMUZEJLwLD+sg4rR4YeXaqgjd
         fhxkUHg9A/9tZiYEKm3LKNdp9JF170picVNkaXiI3ud77oJGCxQvZRxlyLlCV+oNi0TP
         Y/qVOzAvVrLlTHbE26Pht+LtWyjKVKFHxeVadS8/nJhkfC29Dhg26dwHaSUXAApspUNX
         5T97UER2Rqf3G8ad0JzMgyzJWJX7hpjXBiN1IJx+DK+iu4iKYz1E3+VBybcjb/k+Mvrd
         grJA==
X-Gm-Message-State: AOAM531RTs/HTkxI/jAdoAhjxMGKV+7mEy1H+Mcjk2NV6RQZcjIomB3/
        hxHq8UD5tZgBCQZssSsRJVO9S8wfWy+0cnQ+
X-Google-Smtp-Source: ABdhPJwT6xnky/mHaJNxckiNgkibDGvw90qwzfJSlcDCNn3jbsIMJ962xH6Kd5qNGNkzNXRe1WckpQ==
X-Received: by 2002:ac2:5e34:: with SMTP id o20mr8630983lfg.337.1606741159493;
        Mon, 30 Nov 2020 04:59:19 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id y28sm2949671ljn.18.2020.11.30.04.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 04:59:18 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] iio: gyro: mpu3050: Use devm_ to set up buffer
Date:   Mon, 30 Nov 2020 13:59:14 +0100
Message-Id: <20201130125915.1315667-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This makes use of devm_iio_triggered_buffer_setup() to
save some minor overhead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/gyro/mpu3050-core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 00e58060968c..0d0850945d3a 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1203,9 +1203,10 @@ int mpu3050_common_probe(struct device *dev,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
 
-	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
-					 mpu3050_trigger_handler,
-					 &mpu3050_buffer_setup_ops);
+	ret = devm_iio_triggered_buffer_setup(dev,
+					indio_dev, iio_pollfunc_store_time,
+					mpu3050_trigger_handler,
+					&mpu3050_buffer_setup_ops);
 	if (ret) {
 		dev_err(dev, "triggered buffer setup failed\n");
 		goto err_power_down;
@@ -1214,7 +1215,7 @@ int mpu3050_common_probe(struct device *dev,
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "device register failed\n");
-		goto err_cleanup_buffer;
+		goto err_power_down;
 	}
 
 	dev_set_drvdata(dev, indio_dev);
@@ -1241,8 +1242,6 @@ int mpu3050_common_probe(struct device *dev,
 
 	return 0;
 
-err_cleanup_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
 err_power_down:
 	mpu3050_power_down(mpu3050);
 
@@ -1258,7 +1257,6 @@ int mpu3050_common_remove(struct device *dev)
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-	iio_triggered_buffer_cleanup(indio_dev);
 	if (mpu3050->irq)
 		free_irq(mpu3050->irq, mpu3050);
 	iio_device_unregister(indio_dev);
-- 
2.26.2

