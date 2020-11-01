Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95D52A1DDD
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 13:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgKAM2p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 07:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgKAM2o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2020 07:28:44 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A492BC061A48
        for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2020 04:28:42 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id b1so13741960lfp.11
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2020 04:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D//csSkef/q1fmS2JF6nZIsqRiFshRpn9N22nb8nS5E=;
        b=kGIyGZKeEweHWzwL+H0LdhP4e14J8KJbxwtqgSIJIUOjduETuvRplH52h5hiVVZZ1q
         7pprDNN9o2dzShN7Q+TWr95DB5630naYzfL4JXWNf5jNBo7+hfCxiHGJViTUNdHPyqss
         +OU0FvSflg/RTZY0khH+ckx2gIh99keG4GYgipQB9wmEgOd/VOBOmyFWh28plZT5i0w8
         bI3jrd1YVPjqYExRPvjhvcDYH8tK2UogQd5id5J16E7wjEafGkU+JOPMk4OmkKv4XXC+
         wtJdjrWcOI+FLPy8uJ1feTc+9Ps92cvmC9XCMeQ2wpGfwC4wYN2NK3/FdFKAwh4HHTk/
         WxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D//csSkef/q1fmS2JF6nZIsqRiFshRpn9N22nb8nS5E=;
        b=Ob9lJoxoxIbMfVSRk6Mj70EdRjMoXsyaBOzWt0sQ8cdKPKumTTjxjc9c1LUKpYaFtX
         5xWlhuWO+fvIR9NryTUS+WGq6QOOItmubhFo8wpHkZIQBmFdjFOLuBVWi/0FA5NAV8/m
         +crPVIdQ4YRgAWlqZFPy9n62Nrf18os/qt5vOQ9vblq26glwCVxR1hDLj5+OHoiMQYN5
         DnoD8jkew3DrXytPAMxAm0oIkQEYaKeV7ceyjRCq2Y2R03wvbNxDuZOTE90krjLnfL4R
         Ov1p1Q/nya97hARYDOzkR6bB0rCzvVD1ufLp/kPNIdSaX+MkFTPoiNlFSB4ljNWmTgnJ
         dBIw==
X-Gm-Message-State: AOAM531y5WdT5nszNlNAPXjDBNspYLtt8GqBLh7jWZZnP1rHkbZaDX4N
        oFFpxrkbetmS9dzBndel0K190g==
X-Google-Smtp-Source: ABdhPJwhuNTY0jV6fjulkvIZnQ1RW5Oq8uFHGKx1pb6i8VdF0X7g3OKU7Xo4KnxH2y4uEhCAQ8uEkw==
X-Received: by 2002:ac2:5c4c:: with SMTP id s12mr3756651lfp.174.1604233721157;
        Sun, 01 Nov 2020 04:28:41 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id 190sm1480655lfk.238.2020.11.01.04.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 04:28:40 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] iio: accel: bmc150-accel: Add rudimentary regulator support
Date:   Sun,  1 Nov 2020 13:28:33 +0100
Message-Id: <20201101122833.1111424-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201101122833.1111424-1-linus.walleij@linaro.org>
References: <20201101122833.1111424-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These Bosch accelerometers have two supplies, VDD and VDDIO.
Add some rudimentary support to obtain and enable these
regulators during probe() and disable them during remove()
or on the errorpath.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/bmc150-accel-core.c | 37 +++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 0dafe4052856..a69a4f54d69a 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -28,6 +28,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include "bmc150-accel.h"
 
@@ -184,6 +185,7 @@ enum bmc150_accel_trigger_id {
 
 struct bmc150_accel_data {
 	struct regmap *regmap;
+	struct regulator_bulk_data regulators[2];
 	int irq;
 	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
@@ -1593,10 +1595,35 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 				     &data->orientation);
 	if (ret)
 		return ret;
+	/*
+	 * VDD   is the analog and digital domain voltage supply
+	 * VDDIO is the digital I/O voltage supply
+	 */
+	data->regulators[0].supply = "vdd";
+	data->regulators[1].supply = "vddio";
+	ret = devm_regulator_bulk_get(dev,
+				      ARRAY_SIZE(data->regulators),
+				      data->regulators);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get regulators %d\n", ret);
+		return ret;
+	}
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
+				    data->regulators);
+	if (ret) {
+		dev_err(dev, "failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+	/*
+	 * 2ms or 3ms power-on time according to datasheets, let's better
+	 * be safe than sorry and set this delay to 5ms.
+	 */
+	msleep(5);
 
 	ret = bmc150_accel_chip_init(data);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulators;
 
 	mutex_init(&data->mutex);
 
@@ -1613,7 +1640,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 					 &bmc150_accel_buffer_ops);
 	if (ret < 0) {
 		dev_err(dev, "Failed: iio triggered buffer setup\n");
-		return ret;
+		goto err_disable_regulators;
 	}
 
 	if (data->irq > 0) {
@@ -1674,6 +1701,9 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
+err_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
+			       data->regulators);
 
 	return ret;
 }
@@ -1698,6 +1728,9 @@ int bmc150_accel_core_remove(struct device *dev)
 	bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_DEEP_SUSPEND, 0);
 	mutex_unlock(&data->mutex);
 
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
+			       data->regulators);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(bmc150_accel_core_remove);
-- 
2.26.2

