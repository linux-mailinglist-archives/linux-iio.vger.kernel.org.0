Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD17F1490C4
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2020 23:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgAXWOB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jan 2020 17:14:01 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:33216 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbgAXWOA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 Jan 2020 17:14:00 -0500
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 85484251ED;
        Fri, 24 Jan 2020 23:04:17 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     linux-iio@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>
Subject: [PATCH 7/7] iio: light: al3320a allow module autoload when defined in dts
Date:   Fri, 24 Jan 2020 23:03:46 +0100
Message-Id: <20200124220346.2655336-7-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124220346.2655336-1-david@ixit.cz>
References: <20200124220346.2655336-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- also drop init.h and alphabetically sort

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index d99f9d139b5f..d66c85b27907 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -12,9 +12,9 @@
  * potential races with the interrupt handling.
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -238,9 +238,16 @@ static const struct i2c_device_id al3320a_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, al3320a_id);
 
+static const struct of_device_id al3320a_of_match[] = {
+	{ .compatible = "dynaimage,al3320a", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, al3320a_of_match);
+
 static struct i2c_driver al3320a_driver = {
 	.driver = {
 		.name = AL3320A_DRV_NAME,
+		.of_match_table = al3320a_of_match,
 		.pm = &al3320a_pm_ops,
 	},
 	.probe		= al3320a_probe,
-- 
2.25.0

