Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6372B10B1
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 22:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgKLVzK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Nov 2020 16:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgKLVzJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 16:55:09 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D67C0617A6
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2020 13:55:09 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id v144so10703706lfa.13
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2020 13:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwkdEZKAvc8j5iPFuWkoVDjlnDMeZmYFzd85/LfuZ/Y=;
        b=D0CLbcjtMp/JuSGJRxAPMCSGwYEreqEULjgOjcBAL/4BjHzq1bmgIbcPhqpkuxEDrY
         Od4gpvBNlj+c9AvMfIxOPOvKVKQcqJRkKwpyG9jlkcRtXbTKh05zfZCXBUn568NHBUeL
         ONqS9F4oVDlqFzvd2MkFcmXToVoO3f9viX7C3MAe4hb8UL90vTT0PlRtS8Y4Ew3CPmJ5
         w5Kz0LGM5PjezHQ5EQ8GgrEZMpFNkzLj4CVLAdAt1v/5VPA1ri9T/dr89AEfaogU1VEH
         bSxaTnBvW9JYUGpt+09BKnWqzcLDT/m9AsRXfk5Cv8bCf4YORluJIeCQznHHVyAs7JIQ
         jQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwkdEZKAvc8j5iPFuWkoVDjlnDMeZmYFzd85/LfuZ/Y=;
        b=V4eepkXueH9/s19EOSurzkRFdV1irN9OXBiu/AHgSfb5LdkWdr9L52/viOsuO26zU6
         g1VECsSyVxWdb57PCjwHdjTNGHjBM9bBrkPonJkYsVQHf5j5ID/x1X5XQ5TDMWhbsovE
         jj4PioJE/WV6m1nnNe8ljRFSTw8kuKNAeLr8ZaGiR5eg8KUNXkGJLa00vvAsmO20uODH
         pytKeG/Oujlqjg6eTVq8KI6UM+QK6U2RmUDxy6zW93E9y3n1vl4KAPMcs4pIOVPG1jCH
         459/hnTVxsjbrTY8Idt5lhCXswINX2wUDCwMUfgEDGkMKtTPnbURv+sz+WZRLafQlQJX
         v27w==
X-Gm-Message-State: AOAM530/vtzJL8LjDV6XefESWrru/On0Jp8C4W+1NCYespjPxhkgKd2/
        Ap9sEjK9/yn06dNng+2hK6eHcA==
X-Google-Smtp-Source: ABdhPJwEz0Y/AEnYHH3L6uGPbG35kZxxqy75zavlMyltIKE/1G6hO64JMTqe1UEAiQGh1IChPoEfNw==
X-Received: by 2002:ac2:4845:: with SMTP id 5mr641515lfy.402.1605218107568;
        Thu, 12 Nov 2020 13:55:07 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x24sm967731ljj.112.2020.11.12.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:55:07 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3 v2] iio: accel: bmc150-accel: Add rudimentary regulator support
Date:   Thu, 12 Nov 2020 22:54:51 +0100
Message-Id: <20201112215451.2606136-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112215451.2606136-1-linus.walleij@linaro.org>
References: <20201112215451.2606136-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Use dev_err_probe() to simplify the errorpath.
---
 drivers/iio/accel/bmc150-accel-core.c | 35 +++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 0dafe4052856..a9714cfacf4d 100644
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
@@ -1593,10 +1595,33 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
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
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
+
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
 
@@ -1613,7 +1638,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 					 &bmc150_accel_buffer_ops);
 	if (ret < 0) {
 		dev_err(dev, "Failed: iio triggered buffer setup\n");
-		return ret;
+		goto err_disable_regulators;
 	}
 
 	if (data->irq > 0) {
@@ -1674,6 +1699,9 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
+err_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
+			       data->regulators);
 
 	return ret;
 }
@@ -1698,6 +1726,9 @@ int bmc150_accel_core_remove(struct device *dev)
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

