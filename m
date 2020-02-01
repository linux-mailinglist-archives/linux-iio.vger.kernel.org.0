Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D33AF14F94D
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2020 19:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgBASBh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Feb 2020 13:01:37 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:54056 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgBASBh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Feb 2020 13:01:37 -0500
Received: from localhost.localdomain (silversquare.silversquare.eu [185.174.184.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id CA0BF2520C;
        Sat,  1 Feb 2020 19:01:34 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     linux-iio@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v3 7/7] iio: light: al3320a allow module autoload and polish
Date:   Sat,  1 Feb 2020 19:00:24 +0100
Message-Id: <20200201180024.328700-8-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200201180024.328700-1-david@ixit.cz>
References: <20200201180024.328700-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- allow autoloading when build as module and defined inside DT
- drop init.h and alphabetically sort includes

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

