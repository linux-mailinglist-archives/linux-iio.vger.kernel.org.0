Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075FC70E62C
	for <lists+linux-iio@lfdr.de>; Tue, 23 May 2023 22:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjEWUBs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 May 2023 16:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjEWUBs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 May 2023 16:01:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2327BE5
        for <linux-iio@vger.kernel.org>; Tue, 23 May 2023 13:01:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1YBg-0006FG-HA; Tue, 23 May 2023 22:00:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1YBW-002K6d-Pw; Tue, 23 May 2023 22:00:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1YBW-007Kj6-1E; Tue, 23 May 2023 22:00:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wolfram Sang <wsa@kernel.org>, Jean Delvare <jdelvare@suse.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Kalle Valo <kvalo@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Crt Mori <cmo@melexis.com>, Haowen Bai <baihaowen@meizu.com>,
        Tom Rix <trix@redhat.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        kernel@pengutronix.de, linux-media@vger.kernel.org
Subject: [PATCH] staging: Switch i2c drivers back to use .probe()
Date:   Tue, 23 May 2023 22:00:36 +0200
Message-Id: <20230523200036.465180-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8102; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=g91xHbFgS5Gs6f9qzlJt585+luryBlKUwO11FC+whhQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkbRtcrzS6BeMuzhATOvigmDwMi8vXk4wYR5BEc c7E7mVq8QqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG0bXAAKCRCPgPtYfRL+ TiUDCACd68Wl0qdgEDME6YfVpaouxtaSI7e/trhSe8UwIMtxLzSqqBabdFOcGYNTS0Lt/AUxkWx Zwxobwdz2TaXO6zc6ddxSE0b62u9cW82JL/eStDsfWsVdQEjhf5I5lWEHfqAah4qxzSAYUJ7peh t8ipojCcuQs6SsLgFi8jx/p/8Opyl8Ou+eBaLP2BE79meylFDoM/tBRODVYD/2diu+dv4THuC39 As8MNKiNuw7BumzGsRJn+pPkF0ZWoV+6Yi9hbroUSBRCCyANH8fBhhVV5WEC3Fjz+ZfeWKvHaj7 Q1LMrjmJdCLkCs+LhgaHryVIqYtUpWDVjwwx3uQMClbKutRa
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
call-back type"), all drivers being converted to .probe_new() and then
03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
back to (the new) .probe() to be able to eventually drop .probe_new() from
struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this patch was generated using coccinelle.

I chose to convert all drivers below drivers/staging in a single
patch, but if you prefer I can split by driver.

If conflicts arise until this is applied, feel free to just drop the
files with conflicts from this patch. I'll care about the fallout later
then.

Also note there is no coordination necessary with the i2c tree. Dropping
.probe_new() will happen only when all (or most) drivers are converted,
which will happen after v6.5-rc1 for sure.

Best regards
Uwe
 drivers/staging/iio/addac/adt7316-i2c.c                   | 2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c           | 2 +-
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c        | 2 +-
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c        | 2 +-
 drivers/staging/media/atomisp/i2c/atomisp-lm3554.c        | 2 +-
 drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c       | 2 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c        | 2 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2722.c        | 2 +-
 drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c | 2 +-
 drivers/staging/media/max96712/max96712.c                 | 2 +-
 drivers/staging/most/i2c/i2c.c                            | 2 +-
 drivers/staging/olpc_dcon/olpc_dcon.c                     | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 7e3d1a6f30ba..6c1f91c859ca 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -138,7 +138,7 @@ static struct i2c_driver adt7316_driver = {
 		.of_match_table = adt7316_of_match,
 		.pm = ADT7316_PM_OPS,
 	},
-	.probe_new = adt7316_i2c_probe,
+	.probe = adt7316_i2c_probe,
 	.id_table = adt7316_i2c_id,
 };
 module_i2c_driver(adt7316_driver);
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index b3152f7153fb..46db6d91542a 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -781,7 +781,7 @@ static struct i2c_driver ad5933_driver = {
 		.name = "ad5933",
 		.of_match_table = ad5933_of_match,
 	},
-	.probe_new = ad5933_probe,
+	.probe = ad5933_probe,
 	.id_table = ad5933_id,
 };
 module_i2c_driver(ad5933_driver);
diff --git a/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c b/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
index 273155308fe3..21eb4234a081 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
@@ -483,7 +483,7 @@ static struct i2c_driver gc0310_driver = {
 		.pm = pm_sleep_ptr(&gc0310_pm_ops),
 		.acpi_match_table = gc0310_acpi_match,
 	},
-	.probe_new = gc0310_probe,
+	.probe = gc0310_probe,
 	.remove = gc0310_remove,
 };
 module_i2c_driver(gc0310_driver);
diff --git a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c b/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
index cb4c79b483ca..9fa390fbc5f3 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
@@ -864,7 +864,7 @@ static struct i2c_driver gc2235_driver = {
 		.name = "gc2235",
 		.acpi_match_table = gc2235_acpi_match,
 	},
-	.probe_new = gc2235_probe,
+	.probe = gc2235_probe,
 	.remove = gc2235_remove,
 };
 module_i2c_driver(gc2235_driver);
diff --git a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
index c4ce4cd445d7..cf5d9317b11a 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
@@ -945,7 +945,7 @@ static struct i2c_driver lm3554_driver = {
 		.pm   = &lm3554_pm_ops,
 		.acpi_match_table = lm3554_acpi_match,
 	},
-	.probe_new = lm3554_probe,
+	.probe = lm3554_probe,
 	.remove = lm3554_remove,
 };
 module_i2c_driver(lm3554_driver);
diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
index 0e5a981dd331..1c6643c442ef 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
@@ -1600,7 +1600,7 @@ static struct i2c_driver mt9m114_driver = {
 		.name = "mt9m114",
 		.acpi_match_table = mt9m114_acpi_match,
 	},
-	.probe_new = mt9m114_probe,
+	.probe = mt9m114_probe,
 	.remove = mt9m114_remove,
 };
 module_i2c_driver(mt9m114_driver);
diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
index 63de214916f5..b5d93a96d588 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
@@ -719,7 +719,7 @@ static struct i2c_driver ov2680_driver = {
 		.pm = pm_sleep_ptr(&ov2680_pm_ops),
 		.acpi_match_table = ov2680_acpi_match,
 	},
-	.probe_new = ov2680_probe,
+	.probe = ov2680_probe,
 	.remove = ov2680_remove,
 };
 module_i2c_driver(ov2680_driver);
diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
index 5d2e6e2e72f0..6a72691ed5b7 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
@@ -1019,7 +1019,7 @@ static struct i2c_driver ov2722_driver = {
 		.name = "ov2722",
 		.acpi_match_table = ov2722_acpi_match,
 	},
-	.probe_new = ov2722_probe,
+	.probe = ov2722_probe,
 	.remove = ov2722_remove,
 };
 module_i2c_driver(ov2722_driver);
diff --git a/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c b/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
index da8c3b1d3bcd..c94fe8e861a5 100644
--- a/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
+++ b/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
@@ -1794,7 +1794,7 @@ static struct i2c_driver ov5693_driver = {
 		.name = "ov5693",
 		.acpi_match_table = ov5693_acpi_match,
 	},
-	.probe_new = ov5693_probe,
+	.probe = ov5693_probe,
 	.remove = ov5693_remove,
 };
 module_i2c_driver(ov5693_driver);
diff --git a/drivers/staging/media/max96712/max96712.c b/drivers/staging/media/max96712/max96712.c
index 99b333b68198..77943bdf3fb9 100644
--- a/drivers/staging/media/max96712/max96712.c
+++ b/drivers/staging/media/max96712/max96712.c
@@ -427,7 +427,7 @@ static struct i2c_driver max96712_i2c_driver = {
 		.name = "max96712",
 		.of_match_table	= of_match_ptr(max96712_of_table),
 	},
-	.probe_new = max96712_probe,
+	.probe = max96712_probe,
 	.remove = max96712_remove,
 };
 
diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2c.c
index 4e85e681922f..ce869280a056 100644
--- a/drivers/staging/most/i2c/i2c.c
+++ b/drivers/staging/most/i2c/i2c.c
@@ -362,7 +362,7 @@ static struct i2c_driver i2c_driver = {
 	.driver = {
 		.name = "hdm_i2c",
 	},
-	.probe_new = i2c_probe,
+	.probe = i2c_probe,
 	.remove = i2c_remove,
 	.id_table = i2c_id,
 };
diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index 2fba52e0bd7b..d5271eac14f6 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -779,7 +779,7 @@ static struct i2c_driver dcon_driver = {
 	},
 	.class = I2C_CLASS_DDC | I2C_CLASS_HWMON,
 	.id_table = dcon_idtable,
-	.probe_new = dcon_probe,
+	.probe = dcon_probe,
 	.remove = dcon_remove,
 	.detect = dcon_detect,
 	.address_list = normal_i2c,

base-commit: 1f3413dc8eb0de023c5ec5994aef8225262d0f19
-- 
2.39.2

