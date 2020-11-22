Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F25C2BC57F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 12:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgKVL51 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 06:57:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgKVL51 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Nov 2020 06:57:27 -0500
Received: from localhost.localdomain (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B274A20674;
        Sun, 22 Nov 2020 11:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606046246;
        bh=TEmzpGYgUu0dyYkg8uhMxPiVMofs5IBOr60WNilGHcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMC7LxpLMMo3kiN19qWnX52+zVv60JEaWWMhkt1rARV/RBtNK8WAAsmZKa3wkWq7I
         dFiN8Y8UPwkQIbZGU8I/yhCRyNVNfP67P+dwKjGjZkyfuJG6QwdAN3ijczHwd4niXl
         kubKdpR826I9nU2lb6mMrmm44IVKfsC/TQb/ngNM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] iio: humidity: hts221: add vdd voltage regulator
Date:   Sun, 22 Nov 2020 12:56:48 +0100
Message-Id: <6b3347e78f4f920c48eb6a66936d3b69cb9ff53a.1606045688.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606045688.git.lorenzo@kernel.org>
References: <cover.1606045688.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Like all other ST sensors, hts221 devices have VDD power line.
Introduce VDD voltage regulator to control it.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/humidity/hts221.h      |  2 ++
 drivers/iio/humidity/hts221_core.c | 37 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
index 721359e226cb..cf3d8d2dccd6 100644
--- a/drivers/iio/humidity/hts221.h
+++ b/drivers/iio/humidity/hts221.h
@@ -13,6 +13,7 @@
 #define HTS221_DEV_NAME		"hts221"
 
 #include <linux/iio/iio.h>
+#include <linux/regulator/consumer.h>
 
 enum hts221_sensor_type {
 	HTS221_SENSOR_H,
@@ -29,6 +30,7 @@ struct hts221_hw {
 	const char *name;
 	struct device *dev;
 	struct regmap *regmap;
+	struct regulator *vdd;
 
 	struct iio_trigger *trig;
 	int irq;
diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 16657789dc45..6a39615b6961 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -547,6 +547,35 @@ static const struct iio_info hts221_info = {
 
 static const unsigned long hts221_scan_masks[] = {0x3, 0x0};
 
+static int hts221_init_regulators(struct device *dev)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+	struct hts221_hw *hw = iio_priv(iio_dev);
+	int err;
+
+	hw->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(hw->vdd))
+		return dev_err_probe(dev, PTR_ERR(hw->vdd),
+				     "failed to get vdd regulator\n");
+
+	err = regulator_enable(hw->vdd);
+	if (err) {
+		dev_err(dev, "failed to enable vdd regulator: %d\n", err);
+		return err;
+	}
+
+	msleep(50);
+
+	return 0;
+}
+
+static void hts221_chip_uninit(void *data)
+{
+	struct hts221_hw *hw = data;
+
+	regulator_disable(hw->vdd);
+}
+
 int hts221_probe(struct device *dev, int irq, const char *name,
 		 struct regmap *regmap)
 {
@@ -567,6 +596,14 @@ int hts221_probe(struct device *dev, int irq, const char *name,
 	hw->irq = irq;
 	hw->regmap = regmap;
 
+	err = hts221_init_regulators(dev);
+	if (err)
+		return err;
+
+	err = devm_add_action_or_reset(dev, hts221_chip_uninit, hw);
+	if (err)
+		return err;
+
 	err = hts221_check_whoami(hw);
 	if (err < 0)
 		return err;
-- 
2.28.0

