Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F882D7E43
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 19:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbgLKSmS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 13:42:18 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:32073 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732504AbgLKSmD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 13:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607711951;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:
        Subject:Sender;
        bh=R9fci6EiMxdHKTGC3N1/vvheHR3a4vfxhujqbG75lBQ=;
        b=XpNnvlBI8lH7VY9OYgNGLzECpyLRoWm2Emyddd/lwuTDIvllIMYcH6EcTYQRIszCF5
        pfps2waYv/ZbV8BAYSrcYmUmR8aCfigGF2htDRRsMrn6bz0iiDdskiGJY9fck2QYWjF6
        o/480jsgmTe9pQSkE5m2TOWQZfAeXWEZgiRRiGiygZQljGfAQdzGMDhO+/pzViLtc4W6
        lRWd6Nu4dmj3PolVwU8Mjm0oyE9zPSIjG+wukVNIam/jZEbR4B4HXY0um8FqU60+YJEN
        4qLd4fTFZxxa5ZUqjeTphIPDQs49XCRyPe+uUKVoL8kWlvfFhKc0qU6RYLqg0O6tOsH7
        W41w==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB626OARkI"
X-RZG-CLASS-ID: mo00
Received: from droid..
        by smtp.strato.de (RZmta 47.7.1 DYNA|AUTH)
        with ESMTPSA id 409b08wBBId34ed
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 11 Dec 2020 19:39:03 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 2/2] iio: gyro: bmg160: Add rudimentary regulator support
Date:   Fri, 11 Dec 2020 19:38:15 +0100
Message-Id: <20201211183815.51269-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211183815.51269-1-stephan@gerhold.net>
References: <20201211183815.51269-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMG160 needs VDD and VDDIO regulators that might need to be explicitly
enabled. Add some rudimentary support to obtain and enable these
regulators during probe() and disable them using a devm action.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2:
  - Do regulator_bulk_enable() immediately after devm_regulator_bulk_get()
  - Simplify error handling using devm_add_action_or_reset()
---
 drivers/iio/gyro/bmg160_core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 2d5015801a75..029ef4c34604 100644
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
@@ -1061,6 +1063,13 @@ static const char *bmg160_match_acpi_device(struct device *dev)
 	return dev_name(dev);
 }
 
+static void bmg160_disable_regulators(void *d)
+{
+	struct bmg160_data *data = d;
+
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
+}
+
 int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		      const char *name)
 {
@@ -1077,6 +1086,22 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	data->irq = irq;
 	data->regmap = regmap;
 
+	data->regulators[0].supply = "vdd";
+	data->regulators[1].supply = "vddio";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regulators),
+				      data->regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulators\n");
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
+				    data->regulators);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, bmg160_disable_regulators, data);
+	if (ret)
+		return ret;
+
 	ret = iio_read_mount_matrix(dev, "mount-matrix",
 				&data->orientation);
 	if (ret)
-- 
2.29.2

