Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0922A4EEECF
	for <lists+linux-iio@lfdr.de>; Fri,  1 Apr 2022 16:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344816AbiDAOIO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Apr 2022 10:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346784AbiDAOIK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2022 10:08:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99ED214FBF;
        Fri,  1 Apr 2022 07:06:20 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KVMNl29cgz681Zh;
        Fri,  1 Apr 2022 22:04:23 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Apr 2022 16:06:18 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Apr 2022 15:06:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-iio@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v2 1/3] iio: chemical: scd30: Export dev_pm_ops instead of suspend() and resume()
Date:   Fri, 1 Apr 2022 15:06:03 +0100
Message-ID: <20220401140605.31871-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220401140605.31871-1-Jonathan.Cameron@huawei.com>
References: <20220401140605.31871-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Whilst here move to the new infrastructure using pm_sleep_ptr()
and EXPORT_DEV_PM_OPS() so as to let the compiler remove the unused
code if CONFIG_SLEEP is not defined.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 drivers/iio/chemical/scd30.h        | 5 +----
 drivers/iio/chemical/scd30_core.c   | 8 ++++----
 drivers/iio/chemical/scd30_i2c.c    | 2 +-
 drivers/iio/chemical/scd30_serial.c | 2 +-
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/chemical/scd30.h b/drivers/iio/chemical/scd30.h
index f60127bfe0f4..1ac9f3f79271 100644
--- a/drivers/iio/chemical/scd30.h
+++ b/drivers/iio/chemical/scd30.h
@@ -68,10 +68,7 @@ struct scd30_state {
 	scd30_command_t command;
 };
 
-int scd30_suspend(struct device *dev);
-int scd30_resume(struct device *dev);
-
-static __maybe_unused SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend, scd30_resume);
+extern const struct dev_pm_ops scd30_pm_ops;
 
 int scd30_probe(struct device *dev, int irq, const char *name, void *priv, scd30_command_t command);
 
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 9fe6bbe9ee04..6c6c11c2772a 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -517,7 +517,7 @@ static const struct iio_chan_spec scd30_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
-int __maybe_unused scd30_suspend(struct device *dev)
+static int scd30_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct scd30_state *state  = iio_priv(indio_dev);
@@ -529,9 +529,8 @@ int __maybe_unused scd30_suspend(struct device *dev)
 
 	return regulator_disable(state->vdd);
 }
-EXPORT_SYMBOL(scd30_suspend);
 
-int __maybe_unused scd30_resume(struct device *dev)
+static int scd30_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct scd30_state *state = iio_priv(indio_dev);
@@ -543,7 +542,8 @@ int __maybe_unused scd30_resume(struct device *dev)
 
 	return scd30_command_write(state, CMD_START_MEAS, state->pressure_comp);
 }
-EXPORT_SYMBOL(scd30_resume);
+
+EXPORT_SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend, scd30_resume);
 
 static void scd30_stop_meas(void *data)
 {
diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
index 875892a070ee..7c332e4e8e46 100644
--- a/drivers/iio/chemical/scd30_i2c.c
+++ b/drivers/iio/chemical/scd30_i2c.c
@@ -128,7 +128,7 @@ static struct i2c_driver scd30_i2c_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = scd30_i2c_of_match,
-		.pm = &scd30_pm_ops,
+		.pm = pm_sleep_ptr(&scd30_pm_ops),
 	},
 	.probe_new = scd30_i2c_probe,
 };
diff --git a/drivers/iio/chemical/scd30_serial.c b/drivers/iio/chemical/scd30_serial.c
index 568b34486c44..8664f3ce6b33 100644
--- a/drivers/iio/chemical/scd30_serial.c
+++ b/drivers/iio/chemical/scd30_serial.c
@@ -252,7 +252,7 @@ static struct serdev_device_driver scd30_serdev_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = scd30_serdev_of_match,
-		.pm = &scd30_pm_ops,
+		.pm = pm_sleep_ptr(&scd30_pm_ops),
 	},
 	.probe = scd30_serdev_probe,
 };
-- 
2.32.0

