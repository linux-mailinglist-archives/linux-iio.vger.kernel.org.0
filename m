Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38EED1517EC
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 10:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgBDJex (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 04:34:53 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:49350 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgBDJex (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Feb 2020 04:34:53 -0500
Received: from localhost.localdomain (126.212-243-81.adsl-dyn.isp.belgacom.be [81.243.212.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 3145725204;
        Tue,  4 Feb 2020 10:34:51 +0100 (CET)
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
Subject: [PATCH v4 6/7] iio: light: al3320a implement devm_add_action_or_reset
Date:   Tue,  4 Feb 2020 10:30:38 +0100
Message-Id: <20200204093031.616409-7-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204093031.616409-1-david@ixit.cz>
References: <20200204093031.616409-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use devm_add_action_or_reset to automatically disable the device
and allow you to get rid of the remove function entirely.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index affa4c6c199a..49e73e24fff6 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -87,6 +87,13 @@ static int al3320a_set_pwr(struct i2c_client *client, bool pwr)
 	return i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG, val);
 }
 
+static void al3320a_set_pwr_off(void *_data)
+{
+	struct al3320a_data *data = _data;
+
+	al3320a_set_pwr(data->client, false);
+}
+
 static int al3320a_init(struct al3320a_data *data)
 {
 	int ret;
@@ -206,12 +213,14 @@ static int al3320a_probe(struct i2c_client *client,
 		dev_err(&client->dev, "al3320a chip init failed\n");
 		return ret;
 	}
-	return devm_iio_device_register(&client->dev, indio_dev);
-}
 
-static int al3320a_remove(struct i2c_client *client)
-{
-	return al3320a_set_pwr(client, false);
+	ret = devm_add_action_or_reset(&client->dev,
+					al3320a_set_pwr_off,
+					data);
+	if (ret < 0)
+		return ret;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static int __maybe_unused al3320a_suspend(struct device *dev)
@@ -238,7 +247,6 @@ static struct i2c_driver al3320a_driver = {
 		.pm = &al3320a_pm_ops,
 	},
 	.probe		= al3320a_probe,
-	.remove		= al3320a_remove,
 	.id_table	= al3320a_id,
 };
 
-- 
2.25.0

