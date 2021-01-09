Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77E22F045A
	for <lists+linux-iio@lfdr.de>; Sun, 10 Jan 2021 00:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbhAIXNk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 18:13:40 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41887 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbhAIXNj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jan 2021 18:13:39 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 104D960002;
        Sat,  9 Jan 2021 23:12:52 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 6/6] iio:pressure:ms5637: add ms5803 support
Date:   Sun, 10 Jan 2021 00:11:48 +0100
Message-Id: <20210109231148.1168104-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109231148.1168104-1-alexandre.belloni@bootlin.com>
References: <20210109231148.1168104-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ms5803 is very similar to the ms5805 but has less resolution options
and has the 128bit PROM layout.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 drivers/iio/pressure/ms5637.c                          | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index e9b64be4b91e..a327130d1faa 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -153,6 +153,8 @@ properties:
             # Measurement Specialities I2C pressure and temperature sensor
           - meas,ms5637
             # Measurement Specialities I2C pressure and temperature sensor
+          - meas,ms5803
+            # Measurement Specialities I2C pressure and temperature sensor
           - meas,ms5805
             # Measurement Specialities I2C pressure and temperature sensor
           - meas,ms5837
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 0a6034342714..81f683321b23 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -200,8 +200,15 @@ static const struct ms_tp_hw_data ms5637_hw_data  = {
 	.max_res_index = 5
 };
 
+static const struct ms_tp_hw_data ms5803_hw_data  = {
+	.prom_len = 8,
+	.max_res_index = 4
+};
+
 static const struct ms_tp_data ms5637_data = { .name = "ms5637", .hw = &ms5637_hw_data };
 
+static const struct ms_tp_data ms5803_data = { .name = "ms5803", .hw = &ms5803_hw_data };
+
 static const struct ms_tp_data ms5805_data = { .name = "ms5805", .hw = &ms5637_hw_data };
 
 static const struct ms_tp_data ms5837_data = { .name = "ms5837", .hw = &ms5637_hw_data };
@@ -222,6 +229,7 @@ MODULE_DEVICE_TABLE(i2c, ms5637_id);
 
 static const struct of_device_id ms5637_of_match[] = {
 	{ .compatible = "meas,ms5637", .data = &ms5637_data },
+	{ .compatible = "meas,ms5803", .data = &ms5803_data },
 	{ .compatible = "meas,ms5805", .data = &ms5805_data },
 	{ .compatible = "meas,ms5837", .data = &ms5837_data },
 	{ .compatible = "meas,ms8607-temppressure", .data = &ms8607_data },
-- 
2.29.2

