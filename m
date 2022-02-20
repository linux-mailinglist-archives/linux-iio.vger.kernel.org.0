Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AFA4BD089
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244478AbiBTSJK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 13:09:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbiBTSJK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 13:09:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63D9527E3
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 10:08:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 722AA60EA9
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 18:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC73C340F3;
        Sun, 20 Feb 2022 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645380527;
        bh=ZjcP+fAD4lesyu6D6XafiSMG8G9UoSOm58Q9T7rTJ/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWq2SeTE2QB+dqOrVyIay+MylZe2yPjo+JyB4gvp7vnIS30t7MdCJnFD5tdgK30Yp
         JxlMSrRQrRL8s5aZFPQqvOesdVX1WiEDoSPfvodTJklLyOg/MdZTB/T3c3S+IDXWDB
         QCFx0/ldOsDrIsd+GVlqKDd50Ieu2J5jzlwlgpp/puUbMRW5uLoQ6gCQJ7s3B4VeIZ
         kivsQ2F1xyuy7AH872zBCT4GqN3T0+2GlyW+hn3fNoy0GSBvLiBdQBW0mNcYUjqBAR
         gJfIQ1LDmrCgN6/Sal6/VU43AEcWm0HH/XKPaxRn1KuylxfLuKaJwR8QCTmxcPatlR
         aglJVKj4WZTIw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/8] iio: chemical: scd30: Export dev_pm_ops instead of suspend() and resume()
Date:   Sun, 20 Feb 2022 18:15:15 +0000
Message-Id: <20220220181522.541718-2-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220181522.541718-1-jic23@kernel.org>
References: <20220220181522.541718-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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
2.35.1

