Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EFC2B26B0
	for <lists+linux-iio@lfdr.de>; Fri, 13 Nov 2020 22:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgKMV1x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Nov 2020 16:27:53 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:58319 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgKMV1I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Nov 2020 16:27:08 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id BEB6B240002;
        Fri, 13 Nov 2020 21:27:01 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/9] iio: adc: at91_adc: rework trigger definition
Date:   Fri, 13 Nov 2020 22:26:45 +0100
Message-Id: <20201113212650.507680-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move the available trigger definition back in the driver to stop cluttering
the device tree. There is no functional change except that it actually
fixes the available triggers for at91sam9rl as it inherited the list from
at91sam9260 but actually has the triggers from at91sam9x5.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../bindings/iio/adc/atmel,sama9260-adc.yaml  | 46 -----------
 drivers/iio/adc/at91_adc.c                    | 80 +++++++++----------
 2 files changed, 36 insertions(+), 90 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
index 9b0ff59e75de..e6a1f915b542 100644
--- a/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
@@ -97,29 +97,6 @@ required:
   - atmel,adc-startup-time
   - atmel,adc-vref
 
-patternProperties:
-  "^(trigger)[0-9]$":
-    type: object
-    description: Child node to describe a trigger exposed to the user.
-    properties:
-      trigger-name:
-        $ref: /schemas/types.yaml#/definitions/string
-        description: Identifying name.
-
-      trigger-value:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description:
-          Value to put in the Trigger register to activate this trigger
-
-      trigger-external:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description: This trigger is provided from an external pin.
-
-    additionalProperties: false
-    required:
-      - trigger-name
-      - trigger-value
-
 examples:
   - |
     #include <dt-bindings/dma/at91.h>
@@ -139,29 +116,6 @@ examples:
             atmel,adc-use-external-triggers;
             atmel,adc-vref = <3300>;
             atmel,adc-use-res = "lowres";
-
-            trigger0 {
-                trigger-name = "external-rising";
-                trigger-value = <0x1>;
-                trigger-external;
-            };
-
-            trigger1 {
-                trigger-name = "external-falling";
-                trigger-value = <0x2>;
-                trigger-external;
-            };
-
-            trigger2 {
-                trigger-name = "external-any";
-                trigger-value = <0x3>;
-                trigger-external;
-            };
-
-            trigger3 {
-                trigger-name = "continuous";
-                trigger-value = <0x6>;
-            };
         };
     };
 ...
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 0d67c812ef3d..83539422b704 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -207,6 +207,8 @@ struct at91_adc_caps {
 
 	u8	low_res_bits;
 	u8	high_res_bits;
+	u32	trigger_number;
+	const struct at91_adc_trigger *triggers;
 	struct at91_adc_reg_desc registers;
 };
 
@@ -227,8 +229,6 @@ struct at91_adc_state {
 	u8			sample_hold_time;
 	bool			sleep_mode;
 	struct iio_trigger	**trig;
-	struct at91_adc_trigger	*trigger_list;
-	u32			trigger_number;
 	bool			use_external;
 	u32			vref_mv;
 	u32			res;		/* resolution used for convertions */
@@ -537,13 +537,13 @@ static int at91_adc_channel_init(struct iio_dev *idev)
 }
 
 static int at91_adc_get_trigger_value_by_name(struct iio_dev *idev,
-					     struct at91_adc_trigger *triggers,
+					     const struct at91_adc_trigger *triggers,
 					     const char *trigger_name)
 {
 	struct at91_adc_state *st = iio_priv(idev);
 	int i;
 
-	for (i = 0; i < st->trigger_number; i++) {
+	for (i = 0; i < st->caps->trigger_number; i++) {
 		char *name = kasprintf(GFP_KERNEL,
 				"%s-dev%d-%s",
 				idev->name,
@@ -575,7 +575,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 	u8 bit;
 
 	value = at91_adc_get_trigger_value_by_name(idev,
-						   st->trigger_list,
+						   st->caps->triggers,
 						   idev->trig->name);
 	if (value < 0)
 		return value;
@@ -620,7 +620,7 @@ static const struct iio_trigger_ops at91_adc_trigger_ops = {
 };
 
 static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
-						     struct at91_adc_trigger *trigger)
+						     const struct at91_adc_trigger *trigger)
 {
 	struct iio_trigger *trig;
 	int ret;
@@ -647,7 +647,7 @@ static int at91_adc_trigger_init(struct iio_dev *idev)
 	int i, ret;
 
 	st->trig = devm_kcalloc(&idev->dev,
-				st->trigger_number, sizeof(*st->trig),
+				st->caps->trigger_number, sizeof(*st->trig),
 				GFP_KERNEL);
 
 	if (st->trig == NULL) {
@@ -655,12 +655,12 @@ static int at91_adc_trigger_init(struct iio_dev *idev)
 		goto error_ret;
 	}
 
-	for (i = 0; i < st->trigger_number; i++) {
-		if (st->trigger_list[i].is_external && !(st->use_external))
+	for (i = 0; i < st->caps->trigger_number; i++) {
+		if (st->caps->triggers[i].is_external && !(st->use_external))
 			continue;
 
 		st->trig[i] = at91_adc_allocate_trigger(idev,
-							st->trigger_list + i);
+							st->caps->triggers + i);
 		if (st->trig[i] == NULL) {
 			dev_err(&idev->dev,
 				"Could not allocate trigger %d\n", i);
@@ -685,7 +685,7 @@ static void at91_adc_trigger_remove(struct iio_dev *idev)
 	struct at91_adc_state *st = iio_priv(idev);
 	int i;
 
-	for (i = 0; i < st->trigger_number; i++) {
+	for (i = 0; i < st->caps->trigger_number; i++) {
 		iio_trigger_unregister(st->trig[i]);
 		iio_trigger_free(st->trig[i]);
 	}
@@ -838,8 +838,7 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
 {
 	struct at91_adc_state *st = iio_priv(idev);
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *trig_node;
-	int i = 0, ret;
+	int ret;
 	u32 prop;
 	char *s;
 
@@ -885,37 +884,6 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
 
 	st->registers = &st->caps->registers;
 	st->num_channels = st->caps->num_channels;
-	st->trigger_number = of_get_child_count(node);
-	st->trigger_list = devm_kcalloc(&idev->dev,
-					st->trigger_number,
-					sizeof(struct at91_adc_trigger),
-					GFP_KERNEL);
-	if (!st->trigger_list) {
-		dev_err(&idev->dev, "Could not allocate trigger list memory.\n");
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	for_each_child_of_node(node, trig_node) {
-		struct at91_adc_trigger *trig = st->trigger_list + i;
-		const char *name;
-
-		if (of_property_read_string(trig_node, "trigger-name", &name)) {
-			dev_err(&idev->dev, "Missing trigger-name property in the DT.\n");
-			ret = -EINVAL;
-			goto error_ret;
-		}
-		trig->name = name;
-
-		if (of_property_read_u32(trig_node, "trigger-value", &prop)) {
-			dev_err(&idev->dev, "Missing trigger-value property in the DT.\n");
-			ret = -EINVAL;
-			goto error_ret;
-		}
-		trig->value = prop;
-		trig->is_external = of_property_read_bool(trig_node, "trigger-external");
-		i++;
-	}
 
 	/* Check if touchscreen is supported. */
 	if (st->caps->has_ts)
@@ -1315,6 +1283,13 @@ static int at91_adc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
 
+static const struct at91_adc_trigger at91sam9260_triggers[] = {
+	{ .name = "timer-counter-0", .value = 0x1 },
+	{ .name = "timer-counter-1", .value = 0x3 },
+	{ .name = "timer-counter-2", .value = 0x5 },
+	{ .name = "external", .value = 0xd, .is_external = true },
+};
+
 static struct at91_adc_caps at91sam9260_caps = {
 	.calc_startup_ticks = calc_startup_ticks_9260,
 	.num_channels = 4,
@@ -1328,6 +1303,15 @@ static struct at91_adc_caps at91sam9260_caps = {
 		.mr_prescal_mask = AT91_ADC_PRESCAL_9260,
 		.mr_startup_mask = AT91_ADC_STARTUP_9260,
 	},
+	.triggers = at91sam9260_triggers,
+	.trigger_number = ARRAY_SIZE(at91sam9260_triggers),
+};
+
+static const struct at91_adc_trigger at91sam9x5_triggers[] = {
+	{ .name = "external-rising", .value = 0x1, .is_external = true },
+	{ .name = "external-falling", .value = 0x2, .is_external = true },
+	{ .name = "external-any", .value = 0x3, .is_external = true },
+	{ .name = "continuous", .value = 0x6 },
 };
 
 static struct at91_adc_caps at91sam9rl_caps = {
@@ -1344,6 +1328,8 @@ static struct at91_adc_caps at91sam9rl_caps = {
 		.mr_prescal_mask = AT91_ADC_PRESCAL_9260,
 		.mr_startup_mask = AT91_ADC_STARTUP_9G45,
 	},
+	.triggers = at91sam9x5_triggers,
+	.trigger_number = ARRAY_SIZE(at91sam9x5_triggers),
 };
 
 static struct at91_adc_caps at91sam9g45_caps = {
@@ -1360,6 +1346,8 @@ static struct at91_adc_caps at91sam9g45_caps = {
 		.mr_prescal_mask = AT91_ADC_PRESCAL_9G45,
 		.mr_startup_mask = AT91_ADC_STARTUP_9G45,
 	},
+	.triggers = at91sam9x5_triggers,
+	.trigger_number = ARRAY_SIZE(at91sam9x5_triggers),
 };
 
 static struct at91_adc_caps at91sam9x5_caps = {
@@ -1380,6 +1368,8 @@ static struct at91_adc_caps at91sam9x5_caps = {
 		.mr_prescal_mask = AT91_ADC_PRESCAL_9G45,
 		.mr_startup_mask = AT91_ADC_STARTUP_9X5,
 	},
+	.triggers = at91sam9x5_triggers,
+	.trigger_number = ARRAY_SIZE(at91sam9x5_triggers),
 };
 
 static struct at91_adc_caps sama5d3_caps = {
@@ -1399,6 +1389,8 @@ static struct at91_adc_caps sama5d3_caps = {
 		.mr_prescal_mask = AT91_ADC_PRESCAL_9G45,
 		.mr_startup_mask = AT91_ADC_STARTUP_9X5,
 	},
+	.triggers = at91sam9x5_triggers,
+	.trigger_number = ARRAY_SIZE(at91sam9x5_triggers),
 };
 
 static const struct of_device_id at91_adc_dt_ids[] = {
-- 
2.28.0

