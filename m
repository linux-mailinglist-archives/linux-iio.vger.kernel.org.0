Return-Path: <linux-iio+bounces-17042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E169EA67D4F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 20:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE8C7AB1B1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 19:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D2120D4E3;
	Tue, 18 Mar 2025 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="PrLDBle+"
X-Original-To: linux-iio@vger.kernel.org
Received: from p00-icloudmta-asmtp-us-central-1k-60-percent-4.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (p-east1-cluster1-host4-snip4-1.eps.apple.com [57.103.91.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA1F1E1DF8
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327300; cv=none; b=jvA3xBpW6ShgsAGCkYnFjGkvkcaXkF+gzwm4cY/dJbbksoH0WuabgCeqG+AZwGtVQNPSXtZCIVYppkyqHMomdJDRwE7gEqc1G5zQTLVjhCKbRs9hZhiA/0kuMEIMVWGfVIHqjGuSmeVslwjpqRYQzJ68qCDlemw/uvGP0G1cSgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327300; c=relaxed/simple;
	bh=3z981oMbZZh1KSvC1SA/RqKrhFPX0Y9yVhpd/Uj2H3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4JAw7uxx4wLyz/+Hbnsa1MQjnXUkj3uty5yhrqTIWnF/0/G19yJV6NkpdwZRl/KKzwX172SFPFvLAfnTySrA5EIcIHfkWs4w/Si3te7DpuQNYLbRdMI207QSNuKdBKrtYdN9hN7CzHfqLIKR6e3OIzt701sXI/CCIqtsvTUjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=PrLDBle+; arc=none smtp.client-ip=57.103.91.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=hfZZp3kpPm7fvDpAPnOLgcg1yvSUVxC5CPDbowrM7u8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=PrLDBle+bjbJNu4E+ZwoTXKpNTqiKiXZCzHSRBlKyAYzuLvBhHG/pQPWdHexD/ppC
	 5OWa72LTJIkF1lIdqUiEz29PzNaQ8EzitQutO8ZLVm+L9hbgghgI1JlUi5VadazhXF
	 2rnS0v3EhEF38AwNGuKmyxvdK6Pv4ntXWQIxyMr7OU5C0U1aHeshICoLWts4eWV8Kx
	 asBB77ztEOj1gE8Qwx7d0oZekWpykyuWH2TijUdk/lPiXkRnDZFUB8pBKngkJTCpdv
	 V3afUQG2g6AqesHCQVkI++SlX289NSPwhrxK7EKPf3A9rm+GFDA3mrsgXk6UalcF8A
	 kmrJr0+nJqjIA==
Received: from localhost.localdomain (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-4.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (Postfix) with ESMTPSA id 4988318000B8;
	Tue, 18 Mar 2025 19:48:16 +0000 (UTC)
From: Sergio Perez <sergio@pereznus.es>
To: linux-iio@vger.kernel.org
Cc: Sergio Perez <sergio@pereznus.es>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/2] iio: light: bh1750: Add hardware reset support via GPIO
Date: Tue, 18 Mar 2025 20:47:21 +0100
Message-ID: <20250318194751.7669-1-sergio@pereznus.es>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Pa-7hPnG3EBeq8sbkiByyRl7t7uVU-Uw
X-Proofpoint-GUID: Pa-7hPnG3EBeq8sbkiByyRl7t7uVU-Uw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1030 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503180143

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


