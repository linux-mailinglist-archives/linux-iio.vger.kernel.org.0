Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943C42CB8FB
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 10:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbgLBJge (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 04:36:34 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:8905 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgLBJgd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 04:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606901620;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=8AzvBxYHcbQK6J3mGTGm0CjFjQYtv52+YMdToRBbhW8=;
        b=hcJHInpzKmPtu5Io+B355PgyeEZKDsJUJQJmKMWDlXiRNl9DR4h/xNkWFo86FBFxLG
        tPC8Ki/2O10oTp2hBiDkSfjeFnIQkm0jZ3pOU+Va7EofMGrpQstSw0qhMNpm+E5oyIzj
        RDHxrpG8OZGZQBSmcBaP3Ir1CRj/RvI5JrMdxWClK+RI3dFszVZaGshVsuxnc8kXac84
        76v+BJm+hL746m8e9YpMTbNU6s95rQK8vZw1wD7+fvO3WeV/iQ4YF++SPouJbm+yny8K
        aniM3y7VzjrNuw4D3Th27vvvTzeQlmyAyzMrKLlmGMtXS2UhXzqZ/aWwhZuaRoAtiaKH
        sMkQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB626NJkxR"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 47.3.4 SBL|AUTH)
        with ESMTPSA id Z061efwB29XdVue
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 10:33:39 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 4/4] iio: gyro: bmg160: Add rudimentary regulator support
Date:   Wed,  2 Dec 2020 10:33:22 +0100
Message-Id: <20201202093322.77114-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202093322.77114-1-stephan@gerhold.net>
References: <20201202093322.77114-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMG160 needs VDD and VDDIO regulators that might need to be explicitly
enabled. Add some rudimentary support to obtain and enable these
regulators during probe() and disable them during remove()
or on the error path.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/gyro/bmg160_core.c | 38 +++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 2d5015801a75..4baa4169c5a2 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -19,6 +19,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include "bmg160.h"
 
 #define BMG160_IRQ_NAME		"bmg160_event"
@@ -92,6 +93,7 @@
 
 struct bmg160_data {
 	struct regmap *regmap;
+	struct regulator_bulk_data regulators[2];
 	struct iio_trigger *dready_trig;
 	struct iio_trigger *motion_trig;
 	struct iio_mount_matrix orientation;
@@ -1077,14 +1079,28 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	data->irq = irq;
 	data->regmap = regmap;
 
+	data->regulators[0].supply = "vdd";
+	data->regulators[1].supply = "vddio";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regulators),
+				      data->regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulators\n");
+
 	ret = iio_read_mount_matrix(dev, "mount-matrix",
 				&data->orientation);
 	if (ret)
 		return ret;
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
+				    data->regulators);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
 	ret = bmg160_chip_init(data);
 	if (ret < 0)
-		return ret;
+		goto err_regulator_disable;
 
 	mutex_init(&data->mutex);
 
@@ -1107,28 +1123,32 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 						BMG160_IRQ_NAME,
 						indio_dev);
 		if (ret)
-			return ret;
+			goto err_regulator_disable;
 
 		data->dready_trig = devm_iio_trigger_alloc(dev,
 							   "%s-dev%d",
 							   indio_dev->name,
 							   indio_dev->id);
-		if (!data->dready_trig)
-			return -ENOMEM;
+		if (!data->dready_trig) {
+			ret = -ENOMEM;
+			goto err_regulator_disable;
+		}
 
 		data->motion_trig = devm_iio_trigger_alloc(dev,
 							  "%s-any-motion-dev%d",
 							  indio_dev->name,
 							  indio_dev->id);
-		if (!data->motion_trig)
-			return -ENOMEM;
+		if (!data->motion_trig) {
+			ret = -ENOMEM;
+			goto err_regulator_disable;
+		}
 
 		data->dready_trig->dev.parent = dev;
 		data->dready_trig->ops = &bmg160_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		ret = iio_trigger_register(data->dready_trig);
 		if (ret)
-			return ret;
+			goto err_regulator_disable;
 
 		data->motion_trig->dev.parent = dev;
 		data->motion_trig->ops = &bmg160_trigger_ops;
@@ -1174,6 +1194,8 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		iio_trigger_unregister(data->dready_trig);
 	if (data->motion_trig)
 		iio_trigger_unregister(data->motion_trig);
+err_regulator_disable:
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
 
 	return ret;
 }
@@ -1200,6 +1222,8 @@ void bmg160_core_remove(struct device *dev)
 	mutex_lock(&data->mutex);
 	bmg160_set_mode(data, BMG160_MODE_DEEP_SUSPEND);
 	mutex_unlock(&data->mutex);
+
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
 }
 EXPORT_SYMBOL_GPL(bmg160_core_remove);
 
-- 
2.29.2

