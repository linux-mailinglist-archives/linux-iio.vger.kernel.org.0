Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4794D86C5
	for <lists+linux-iio@lfdr.de>; Mon, 14 Mar 2022 15:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbiCNOT2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Mar 2022 10:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242279AbiCNOTZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Mar 2022 10:19:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E45B193D6
        for <linux-iio@vger.kernel.org>; Mon, 14 Mar 2022 07:18:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nTlVQ-0004zL-Eh; Mon, 14 Mar 2022 15:17:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nTlVI-000f2l-Q9; Mon, 14 Mar 2022 15:16:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nTlVG-0097af-Ma; Mon, 14 Mar 2022 15:16:54 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-clk@vger.kernel.org, kernel@pengutronix.de,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?q?Andr=C3=A9_Gustavo_Nakagomi_Lopez?= <andregnl@usp.br>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH v8 03/16] hwmon: Make use of devm_clk_get_enabled()
Date:   Mon, 14 Mar 2022 15:16:30 +0100
Message-Id: <20220314141643.22184-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314141643.22184-1-u.kleine-koenig@pengutronix.de>
References: <20220314141643.22184-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5520; i=uwe@kleine-koenig.org; h=from:subject; bh=yoWCqkNop/4c6OeHmiSUVdq/1kzaWm1CMWom+WTtANQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiL03yCpTW66mjenPvolXbHi93VsM0yzx1/1i/xg38 JATIi6SJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYi9N8gAKCRDB/BR4rcrsCQkqB/ 9PjEPh2PyWfNPLXABv6MwOZQFQlkQEqb7Uekuh33gB2X0gHncSoOfkEhvSA3yU5f1JKsoWGktEOVRg n+3bvFwDe1hNoOS5coZgZV7FTfW8NcDdt1L55ROM501f7GHgh9/VyyqTbW9Jfg108IB6GXoVFmyiA3 zdrIOdlQb2gSicQGiLiTWR0+HZModM3RWjv+KN8b3Mz5fHJdX2rt20lVLbG6aC4fgbxgl/k2GNIq7F utAI4QGzo9+Vc41UCForfyIXi/JNyyOSfFvugrXq8ze/4V3IkxdO+/DOtDfkPum8ClhrVLXZeDmngJ RvozUy0kpU8RDShp4aDvanTK0USO9z
X-Developer-Key: i=uwe@kleine-koenig.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Several drivers manually register a devm handler to disable their clk.
Convert them to devm_clk_get_enabled().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/hwmon/axi-fan-control.c | 15 +--------------
 drivers/hwmon/ltc2947-core.c    | 17 +----------------
 drivers/hwmon/mr75203.c         | 26 +-------------------------
 drivers/hwmon/sparx5-temp.c     | 19 +------------------
 4 files changed, 4 insertions(+), 73 deletions(-)

diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
index d2092c17d993..ce404ed9c53e 100644
--- a/drivers/hwmon/axi-fan-control.c
+++ b/drivers/hwmon/axi-fan-control.c
@@ -393,11 +393,6 @@ static int axi_fan_control_init(struct axi_fan_control_data *ctl,
 	return ret;
 }
 
-static void axi_fan_control_clk_disable(void *clk)
-{
-	clk_disable_unprepare(clk);
-}
-
 static const struct hwmon_channel_info *axi_fan_control_info[] = {
 	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT),
 	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_LABEL),
@@ -477,20 +472,12 @@ static int axi_fan_control_probe(struct platform_device *pdev)
 	if (IS_ERR(ctl->base))
 		return PTR_ERR(ctl->base);
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "clk_get failed with %ld\n", PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&pdev->dev, axi_fan_control_clk_disable, clk);
-	if (ret)
-		return ret;
-
 	ctl->clk_rate = clk_get_rate(clk);
 	if (!ctl->clk_rate)
 		return -EINVAL;
diff --git a/drivers/hwmon/ltc2947-core.c b/drivers/hwmon/ltc2947-core.c
index 5423466de697..626f5bf2c9c7 100644
--- a/drivers/hwmon/ltc2947-core.c
+++ b/drivers/hwmon/ltc2947-core.c
@@ -956,13 +956,6 @@ static struct attribute *ltc2947_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ltc2947);
 
-static void ltc2947_clk_disable(void *data)
-{
-	struct clk *extclk = data;
-
-	clk_disable_unprepare(extclk);
-}
-
 static int ltc2947_setup(struct ltc2947_data *st)
 {
 	int ret;
@@ -989,7 +982,7 @@ static int ltc2947_setup(struct ltc2947_data *st)
 		return ret;
 
 	/* check external clock presence */
-	extclk = devm_clk_get_optional(st->dev, NULL);
+	extclk = devm_clk_get_optional_enabled(st->dev, NULL);
 	if (IS_ERR(extclk))
 		return dev_err_probe(st->dev, PTR_ERR(extclk),
 				     "Failed to get external clock\n");
@@ -1007,14 +1000,6 @@ static int ltc2947_setup(struct ltc2947_data *st)
 			return -EINVAL;
 		}
 
-		ret = clk_prepare_enable(extclk);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(st->dev, ltc2947_clk_disable,
-					       extclk);
-		if (ret)
-			return ret;
 		/* as in table 1 of the datasheet */
 		if (rate_hz >= LTC2947_CLK_MIN && rate_hz <= 1000000)
 			pre = 0;
diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 1ba1e3145969..0c691f291a64 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -461,24 +461,6 @@ static int pvt_get_regmap(struct platform_device *pdev, char *reg_name,
 	return 0;
 }
 
-static void pvt_clk_disable(void *data)
-{
-	struct pvt_device *pvt = data;
-
-	clk_disable_unprepare(pvt->clk);
-}
-
-static int pvt_clk_enable(struct device *dev, struct pvt_device *pvt)
-{
-	int ret;
-
-	ret = clk_prepare_enable(pvt->clk);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, pvt_clk_disable, pvt);
-}
-
 static void pvt_reset_control_assert(void *data)
 {
 	struct pvt_device *pvt = data;
@@ -515,16 +497,10 @@ static int mr75203_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	pvt->clk = devm_clk_get(dev, NULL);
+	pvt->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(pvt->clk))
 		return dev_err_probe(dev, PTR_ERR(pvt->clk), "failed to get clock\n");
 
-	ret = pvt_clk_enable(dev, pvt);
-	if (ret) {
-		dev_err(dev, "failed to enable clock\n");
-		return ret;
-	}
-
 	pvt->rst = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(pvt->rst))
 		return dev_err_probe(dev, PTR_ERR(pvt->rst),
diff --git a/drivers/hwmon/sparx5-temp.c b/drivers/hwmon/sparx5-temp.c
index 98be48e3a22a..04fd8505e5d6 100644
--- a/drivers/hwmon/sparx5-temp.c
+++ b/drivers/hwmon/sparx5-temp.c
@@ -26,13 +26,6 @@ struct s5_hwmon {
 	struct clk *clk;
 };
 
-static void s5_temp_clk_disable(void *data)
-{
-	struct clk *clk = data;
-
-	clk_disable_unprepare(clk);
-}
-
 static void s5_temp_enable(struct s5_hwmon *hwmon)
 {
 	u32 val = readl(hwmon->base + TEMP_CFG);
@@ -113,7 +106,6 @@ static int s5_temp_probe(struct platform_device *pdev)
 {
 	struct device *hwmon_dev;
 	struct s5_hwmon *hwmon;
-	int ret;
 
 	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
 	if (!hwmon)
@@ -123,19 +115,10 @@ static int s5_temp_probe(struct platform_device *pdev)
 	if (IS_ERR(hwmon->base))
 		return PTR_ERR(hwmon->base);
 
-	hwmon->clk = devm_clk_get(&pdev->dev, NULL);
+	hwmon->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(hwmon->clk))
 		return PTR_ERR(hwmon->clk);
 
-	ret = clk_prepare_enable(hwmon->clk);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&pdev->dev, s5_temp_clk_disable,
-				       hwmon->clk);
-	if (ret)
-		return ret;
-
 	s5_temp_enable(hwmon);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
-- 
2.35.1

