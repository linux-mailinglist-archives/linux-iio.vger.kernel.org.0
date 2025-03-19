Return-Path: <linux-iio+bounces-17107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990F7A6948B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 17:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97EB885D1B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACF21DEFD6;
	Wed, 19 Mar 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="LhRRQyDr"
X-Original-To: linux-iio@vger.kernel.org
Received: from p00-icloudmta-asmtp-us-central-1k-60-percent-6.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (p-east1-cluster7-host11-snip4-10.eps.apple.com [57.103.88.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D51DEFD7
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.88.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400888; cv=none; b=QCw207kSHzDwuyWvpVmwv1zjNFtOpgz8nzEkn1BoMgqvZUqYe78lb/QaBhmZ/o0XqLrv6+EeNy6WMZ7hiLDbYbiu1kWq/I+5dEbVGWXn9K9Xx80R4JJqVyntN/CJ3ci/kcXzRZcAfJWLxMvVnOQefr/+3aUvV14mNJeKo0YtnAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400888; c=relaxed/simple;
	bh=3z981oMbZZh1KSvC1SA/RqKrhFPX0Y9yVhpd/Uj2H3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plvb+m7S/3phKZDny4coC8Z9xSQTqCzEhtJpe08dFIQFS1dggcGf6Dnvvq/kux18qcKXg/qQeC1ZJRbTogcsJKbnlaKxRSJxowUs2ZUtiZ2mGe/w805V/TVoC+g1AdcJXYXECD4Skjfb0TPAn4jwlDUjIO92qjcEW4WbfdRjAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=LhRRQyDr; arc=none smtp.client-ip=57.103.88.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=hfZZp3kpPm7fvDpAPnOLgcg1yvSUVxC5CPDbowrM7u8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=LhRRQyDrJ6O78Xa79hc7/wmup0kwG5kW1eW8XMvFOy/1Dli9q/dZRZzXpNwWDbUFZ
	 OAVEkh0OmsPzRFpx88BgxXpZ+RgdbOxgIv7FQUUYmMBfWCmcuZfUyTBqhfDQeDKdtM
	 GO9IS2Cp/YgzuaafqFoWlq5ppc9W+h8Vfx9R6pwVEHFczsU38nBqzxB+Uv3nYewrrI
	 MZRBy+xFCN8QyBG1xIrTPPZ+qTp7wFsmUp9GtrSzypZICrmBzRbrrIWLkZkswfS7PM
	 9cki9tqVMbtua6noXQGVBomNU84UpCvB5M4lg8S1xEbfhytD8nHFo/1GLJ200rsw1H
	 /PpHbJ68TTjmw==
Received: from localhost.localdomain (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-6.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (Postfix) with ESMTPSA id DBC76180037B;
	Wed, 19 Mar 2025 16:14:42 +0000 (UTC)
From: Sergio Perez <sergio@pereznus.es>
To: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sergio Perez <sergio@pereznus.es>
Subject: [PATCH v3 2/2] iio: light: bh1750: Add hardware reset support via GPIO
Date: Wed, 19 Mar 2025 17:11:17 +0100
Message-ID: <20250319161117.1780-2-sergio@pereznus.es>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319161117.1780-1-sergio@pereznus.es>
References: <20250319161117.1780-1-sergio@pereznus.es>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: smKrVxtdY2gMS52-bg09oRHyCWla_g4x
X-Proofpoint-GUID: smKrVxtdY2gMS52-bg09oRHyCWla_g4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1030 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2503190110

Some BH1750 sensors require a hardware reset before they can be
detected on the I2C bus. This implementation adds support for an
optional reset GPIO that can be specified in the device tree.

The reset sequence pulls the GPIO low and then high before initializing
the sensor, which enables proper detection with tools like i2cdetect.
This is particularly important for sensors that power on in an
undefined state.

Signed-off-by: Sergio Perez <sergio@pereznus.es>
---
 drivers/iio/light/bh1750.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 4b869fa9e5b1..1852467e96cf 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -22,12 +22,16 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 
 #define BH1750_POWER_DOWN		0x00
 #define BH1750_ONE_TIME_H_RES_MODE	0x20 /* auto-mode for BH1721 */
 #define BH1750_CHANGE_INT_TIME_H_BIT	0x40
 #define BH1750_CHANGE_INT_TIME_L_BIT	0x60
 
+/* Define the reset delay time in microseconds */
+#define BH1750_RESET_DELAY_US 10000 /* 10ms */
+
 enum {
 	BH1710,
 	BH1721,
@@ -40,6 +44,7 @@ struct bh1750_data {
 	struct mutex lock;
 	const struct bh1750_chip_info *chip_info;
 	u16 mtreg;
+	struct gpio_desc *reset_gpio;
 };
 
 struct bh1750_chip_info {
@@ -248,6 +253,24 @@ static int bh1750_probe(struct i2c_client *client)
 	data->client = client;
 	data->chip_info = &bh1750_chip_info_tbl[id->driver_data];
 
+	/* Get reset GPIO from device tree */
+	data->reset_gpio = devm_gpiod_get_optional(&client->dev,
+									"reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
+							"Failed to get reset GPIO\n");
+
+	/* Perform hardware reset if GPIO is provided */
+	if (data->reset_gpio) {
+		/* Perform reset sequence: low-high */
+		gpiod_set_value_cansleep(data->reset_gpio, 0);
+		fsleep(BH1750_RESET_DELAY_US);
+		gpiod_set_value_cansleep(data->reset_gpio, 1);
+		fsleep(BH1750_RESET_DELAY_US);
+
+		dev_dbg(&client->dev, "BH1750 reset completed via GPIO\n");
+	}
+
 	usec = data->chip_info->mtreg_to_usec * data->chip_info->mtreg_default;
 	ret = bh1750_change_int_time(data, usec);
 	if (ret < 0)
-- 
2.43.0


