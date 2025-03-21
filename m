Return-Path: <linux-iio+bounces-17179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39082A6BF99
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 17:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7545176070
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24A41E835D;
	Fri, 21 Mar 2025 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="h3zSnoO3"
X-Original-To: linux-iio@vger.kernel.org
Received: from p00-icloudmta-asmtp-us-central-1k-100-percent-8.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (p-east1-cluster5-host6-snip4-2.eps.apple.com [57.103.89.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F8C19938D
	for <linux-iio@vger.kernel.org>; Fri, 21 Mar 2025 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573891; cv=none; b=pRXH6C17l/B0jBGgeetm6btIDTcTe2XA4qsKIKtX+zOQ0mGrws8FrvA/ttGdv4GF2K9K/iOvqxKcSGHoDbPXdqMxiBr5fdi3K4Ahnes0fx64ZvYyljmvuKnByVIckEfvcUnVsQE6AuYSVBPpWHRYieoIvUKP1Vrz5mrBQ1I0tCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573891; c=relaxed/simple;
	bh=H6o9I3+v4AZcYviKhQH6WKRTfrGF8tG7acbR4GpB+ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKYsk+TurXVFzaQsvpxE+OrFGNMDSxm9s4clltyoGOgFlQNitwmAF8nY90vSPOyK7sl/fRegbOo/DPpFCjZQehMDcGoTfxVfy8SfAIjjbzsbhBRlv3Yo3tzsaBgT6SDi7T+uG6LUvR3UhKQ97akkRad1RDhVOxS0TD4+AtdN+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=h3zSnoO3; arc=none smtp.client-ip=57.103.89.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=oLL6xqfVSwrgkY0J2aQo0YZdH5erYvY/+9P5IAuUfq4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=h3zSnoO3Nx0O28k5Jr45zo28oAFo3+6T0L3eu7YW4D7GJfz7WfMdjm//HfeYOdEAP
	 o2lAKDBZr3fhTzzBIAwYEZRr9wwD9PJGfliHN7rtLrqJESjATP4oJI7oyzBv98G/0V
	 x+hVNreddiRbHFlC5s/Xn4tZczFJ+zsrb+5bq7vtjHlMRClV4rI8orsExumk+fKFDf
	 f7u2Lu2A2gBbhOew51GqAMfFyDYzgRlzklnBLxIXoC3cVXU2l4f60P4IIj46L6Rch8
	 z1xmi/tKpMLP4neGfn0YBHhMaMhrukUoACXIQYdDKaoPCO//6ZEQBYxzpcxZo2QsIt
	 +ei0dI3tRIwWA==
Received: from localhost.localdomain (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-8.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (Postfix) with ESMTPSA id 985DB18009A1;
	Fri, 21 Mar 2025 16:18:04 +0000 (UTC)
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
Subject: [PATCH v5 2/2] iio: light: bh1750: Add hardware reset support via GPIO
Date: Fri, 21 Mar 2025 17:16:09 +0100
Message-ID: <20250321161609.3662-2-sergio@pereznus.es>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321161609.3662-1-sergio@pereznus.es>
References: <20250321161609.3662-1-sergio@pereznus.es>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ke2n7Kj045EMxJlpwH9li30QTXsRpBMC
X-Proofpoint-ORIG-GUID: ke2n7Kj045EMxJlpwH9li30QTXsRpBMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503210120

Some BH1750 sensors require a hardware reset before they can be
detected on the I2C bus. This implementation adds support for an
optional reset GPIO that can be specified in the device tree.

The reset sequence pulls the GPIO low and then high before initializing
the sensor, which enables proper detection with tools like i2cdetect.
This is particularly important for sensors that power on in an
undefined state.

Signed-off-by: Sergio Perez <sergio@pereznus.es>
---
Revision history:
v4 => v5:
 - Logic change to be coherent with dt-binding as mentioned by Krzysztof Kozlowski
 - Adjust indentation as commented by Krzysztof Kozlowski
v3 => v4:
 - No changes
v2 => v3:
 - Split in two patches: dtbinding and code
 - Ensure list on mantainers following instructions by Krzysztof Kozlowski
 - Fix check tests as explainned by Krzysztof Kozlowski
v1 => v2:
 - Fixes some whitespaces and end lines
 - Remove unnecessary include
 - Use of fsleep rather than usleep_range as suggested by Jonathan Cameron
 - Use of dev_dbg to reduce innecessary output as suggested by Jonathan Cameron
 - Delete an extra function implementing the functionality inline as suggested by Jonathan Cameron
---
 drivers/iio/light/bh1750.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 4b869fa9e5b1..764f88826fcb 100644
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
@@ -248,6 +253,25 @@ static int bh1750_probe(struct i2c_client *client)
 	data->client = client;
 	data->chip_info = &bh1750_chip_info_tbl[id->driver_data];
 
+	/* Get reset GPIO from device tree */
+	data->reset_gpio = devm_gpiod_get_optional(&client->dev,
+						   "reset", GPIOD_OUT_HIGH);
+
+	if (IS_ERR(data->reset_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
+				     "Failed to get reset GPIO\n");
+
+	/* Perform hardware reset if GPIO is provided */
+	if (data->reset_gpio) {
+		/* Perform reset sequence: low-high */
+		gpiod_set_value_cansleep(data->reset_gpio, 1);
+		fsleep(BH1750_RESET_DELAY_US);
+		gpiod_set_value_cansleep(data->reset_gpio, 0);
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


