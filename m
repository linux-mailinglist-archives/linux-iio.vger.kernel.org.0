Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A412B3947
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 21:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgKOU5y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 15:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbgKOU5x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2020 15:57:53 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC0AC0613D1
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2020 12:57:53 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id x9so17756558ljc.7
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2020 12:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oSRenFjywTpXu8NL+XTe4zUWms6GZJwpv2y6EHWkomU=;
        b=DAKgK7yso+4JIjoHCBpb+6tgWl2Eo+LvPfpPYbiVbFJMLP4keoa9OJPWdngLX/gZ63
         Tk9vP5Zj3nZMRkJcV2tgzQASh5uf38k3hhQWhfvdK2m8HHWHt2DtBGmqyM5xEdUT43g7
         LaR8UAbYWHp/9mTZbsVUNYX6jbmpExsWaZ2DpbLrfa9GRyl5eaIqTXXxbecfmyLJnzCd
         5BlNE3EF5OjBejkNMdrfIajh6cIzxHJyOxanjlpsOJw71GJ0cWX9ltLUbDIdGqSfHUa0
         SchnmBJplnS1NmZ0qWVyZHwy4P1KIhvEsA8+GEhXBULFCCsFs2WlXtvreJeMXrJGJeQA
         HOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oSRenFjywTpXu8NL+XTe4zUWms6GZJwpv2y6EHWkomU=;
        b=g0cCUfLWgGfcJOxJf119ZcZLHVYIHRPG3WpySDByDIsa6g8eJ/TMfY8tm3yzQRygek
         uTeSJZ9VnYBeOHCR1dXdSCSwplRfHYAaRmyp3vp7XkCVDEyMztJt+5+lx9WUhkswla2o
         Y4FkPVMCwiM61ZbdrKi81JKVTrTnehS+QWyiICdapI7QguXVdi/VXOU90qxiYNOIvy5T
         t13U37onsKjg2v3FOFd6DtMIqsL9AtIy1d0lLWHSs0xwCrzqUYLeOWh6T3q7gr/qFioW
         rGPI1xNcJed/UDmlIXvljgh9YUb1J8VblGcgM2l4gvmaRMZ0T7t7qzPRN6fU9YXYdHan
         UQeA==
X-Gm-Message-State: AOAM530umT4YFoMNnRRoTVkGUrNjuAyvgMtDJX87hvWXYZxbbMq6mDCa
        wPBI5XLq3y7RoO4PNMl6fedW6A==
X-Google-Smtp-Source: ABdhPJyhpzGJJBvkOc/BjhiPAmICTUnvR21ABBN+HkUlT4BnGzH0G42Obz4MiQZ+kdrufD3wAr+Qng==
X-Received: by 2002:a2e:8891:: with SMTP id k17mr4905593lji.326.1605473871823;
        Sun, 15 Nov 2020 12:57:51 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id j4sm2458779lfk.275.2020.11.15.12.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 12:57:51 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3 v3] iio: accel: bmc150-accel: Add rudimentary regulator support
Date:   Sun, 15 Nov 2020 21:57:45 +0100
Message-Id: <20201115205745.618455-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201115205745.618455-1-linus.walleij@linaro.org>
References: <20201115205745.618455-1-linus.walleij@linaro.org>
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
ChangeLog v2->v3:
- Resend with the rest.
ChangeLog v1->v2:
- Use dev_err_probe() to simplify the errorpath.
---
 drivers/iio/accel/bmc150-accel-core.c | 35 +++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 01dbc01e328f..caa984612e88 100644
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
@@ -1591,10 +1593,33 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
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
 
@@ -1611,7 +1636,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 					 &bmc150_accel_buffer_ops);
 	if (ret < 0) {
 		dev_err(dev, "Failed: iio triggered buffer setup\n");
-		return ret;
+		goto err_disable_regulators;
 	}
 
 	if (data->irq > 0) {
@@ -1672,6 +1697,9 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
+err_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
+			       data->regulators);
 
 	return ret;
 }
@@ -1696,6 +1724,9 @@ int bmc150_accel_core_remove(struct device *dev)
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

