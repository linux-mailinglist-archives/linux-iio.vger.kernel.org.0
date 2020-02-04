Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346BD1517F1
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 10:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgBDJfJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 04:35:09 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:49368 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgBDJfJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Feb 2020 04:35:09 -0500
Received: from localhost.localdomain (126.212-243-81.adsl-dyn.isp.belgacom.be [81.243.212.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 8489725206;
        Tue,  4 Feb 2020 10:35:06 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     Dmitry Osipenko <digetx@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org
Subject: [PATCH v4 7/7] iio: light: al3320a allow module autoload and polish
Date:   Tue,  4 Feb 2020 10:30:40 +0100
Message-Id: <20200204093031.616409-8-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204093031.616409-1-david@ixit.cz>
References: <20200204093031.616409-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- allow autoloading when build as module and defined inside DT

Signed-off-by: David Heidelberg <david@ixit.cz>

v4
 - dropping of init.h header moved to previous patches

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 49e73e24fff6..e7c4899a4313 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -15,6 +15,7 @@
 #include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -241,9 +242,16 @@ static const struct i2c_device_id al3320a_id[] = {
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

