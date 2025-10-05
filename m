Return-Path: <linux-iio+bounces-24753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9323CBB96F7
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149FA3BB922
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8F9287518;
	Sun,  5 Oct 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="LVI2kd9w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB128AAF9;
	Sun,  5 Oct 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669997; cv=none; b=OFFZRuYPC2wAQOOAgz5emKGTfbvoz1iPo+8WrDBtFDhGDn1tehHhi65snmzG46Kv88PNpy8oeo16ULj+Xh6rHXvlFHevSXgiH21vynW7OenS1zgoiLtvXUHS1Jbbxvd6AHnP+90ZfNbTR8fq15KnRBunvoeuyIAxc6ZzRgC+D7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669997; c=relaxed/simple;
	bh=1PNswrNq1+RwvS/M7dRpzM5A+EzBOkH3teLiLfbT8C8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SoZ92lmmokIEvrKBqAL3dB+MHvB8Fth4MyRUq3SjDWr+ITB3mY2VXayANBCl+xP7NON9y80ewtGtDkS2WpzjXszWJsbzrOQSriE5NWDJvPPaNf0W7yIno8eGjNKxzgvtqL+4j3y7EkDInv7KGnxghqktizpKHc1q081A8Brdp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=LVI2kd9w; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id C0121173BF7;
	Sun, 05 Oct 2025 16:13:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDEOtfTru/Ogw9pyS3SwcWFlvIzmPM6wcAxTmLyFrWM=;
	b=LVI2kd9wWQOq5UwQsQ27LdUd59lBSQr6ph1dZVYwfzRTQSyO0ADfWetQCJJxowG1J53Cj8
	PpKJU4qHBMTTtJUF3xgiumJH772hXQy7wHaSdWrLX49Xi24+opxTWIEFNevGlQcrl8ftSA
	Tvxbw2e1N4j9aGBgfilIZKfaQGeAzgBHykd96DHEc1m4LkVtba/0pSg2+tVT5/tUhVIMOm
	a1v8H0VAgRBf9nK+bMpo+cHeSJETDZ2QA4tHKkHdjp6mH/klM4OppmT9n8lHbUrYOKEYoS
	4U1bShK5zx0wrS4AJicmwWO0/FC6ZIh/O3mrDZ9C0QetvYDExRIkmvoiYyHpRQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:24 +0300
Subject: [PATCH v4 15/19] iio: accel: bma220: add i2c watchdog feature
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-15-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
In-Reply-To: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=1PNswrNq1+RwvS/M7dRpzM5A+EzBOkH3teLiLfbT8C8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnRLODF5dkQ1L1NBSGdna3lRd240SGNJCk9jUUNVdDE1Q1RzdWNQQkUr
 OWZPS1lrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtN1N
 BQW9KRUhRcko2ZGpPa2xqVCtnUC8xV1NwTlpkbTdxVExMTDgzMS9HL1VZSlhpZThqL3ZGVDV0Zg
 pJNERsOE04cFFmSXpRWjlWc0ZGcmh5dU9LaTRvMktvb0tJQlZiYi9tZGhBd2piUkpKdkhEWkprc
 XdmaTFmSGZRClRESWZmdGRLWm1lZi95Z1R2NzFiRjZSaHVWeHlaUFdnazBJZmozZG1UUHNhMndH
 Z0tLcHNjY0FHRkJWM212WlYKRDRIajE2SldWZDQwL0EvbDQ4MmRrY1ZLcjJJdEtta0hsNFNzN0x
 tQm5CSlB2WFNzUVBER3dUZ2FJOHlxemtONgpWckhPbkZJRVBuNFNROXd2NWZNWXZJRityVjVLK1
 RzWWZmWDNOSFJlVnM2Z0E5YXBFbkhQYTVKUEdKNUw2RUNqClZoQWN4Wk1JQ2p1Q0hzRWZMeHJYM
 nZpTzF5U3FMTGI1UjJqeGFkZGJScGMzOHhjYnpXcFEwZ3hpdk8za3h0ZmMKQitmSDNrN0gxY1FD
 QWtxUXc5N1A5Vy9GNFprVkpRTzk1UjNkV3hRR2dOSDRqVW1oL2xJVHVMMU1sbC9BOTJkVgpmWWU
 xMEI2eTlxSTRMajBraVBOZmVSRCtIN3VjcVVuRERxaDd6anVCMnFPRkhiTmpqcXJ5N3VRSG1BUl
 JoUEhmCjI2NGlYcWV6bGNXaE0xTzlEVzNnWGpRRkpWZ3c4U05iY25hTnZrWUF4UElCS3hPT0VoQ
 XZjUE5DbERGcU5Hc2IKUG5ka0s3d0RmZ091dmRTMGhrRnRDdmNodEJja2JFSy8rSEtWQUFPTWNm
 UGEvVDdUR1k3MmtRUTFjb0l2Qm95bQpPWVE1UUw2SHArOVl5bWlWMWdBRjZYMDNLZUQySCtPcEV
 YcTdET1JDQ2o1RVBRbzR5aFRXWWVJY3pBU1NOWnpKCjVZY2N1aVFVY3VFZlFRPT0KPTdvS1UKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Sometimes the sensor gets stuck and enters a condition in which it pulls
SDA low, thus making the entire i2c bus unusable.
This problem is mitigated by activating a 1ms watchdog implemented in
the sensor.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2
- hardcode 1ms timer watchdog to any i2c-based sensor instead of
  configuring a dt-based property
- rename bma220_wdt() to bma220_set_wdt()
v2->v4 no change
---
 drivers/iio/accel/bma220_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index a3faf1f5ec6d79f2c6105697b404d6eb1f4501db..a957751be40c63c25963283be813db97f73bf004 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -10,6 +10,7 @@
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -355,6 +356,12 @@ static int bma220_power(struct bma220_data *data, bool up)
 	return -EBUSY;
 }
 
+static int bma220_set_wdt(struct bma220_data *data, const u8 val)
+{
+	return regmap_update_bits(data->regmap, BMA220_REG_WDT, BMA220_WDT_MASK,
+				  FIELD_PREP(BMA220_WDT_MASK, val));
+}
+
 static int bma220_init(struct device *dev, struct bma220_data *data)
 {
 	int ret;
@@ -383,6 +390,13 @@ static int bma220_init(struct device *dev, struct bma220_data *data)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to soft reset chip\n");
 
+	if (i2c_verify_client(dev)) {
+		ret = bma220_set_wdt(data, BMA220_WDT_1MS);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to set i2c watchdog\n");
+	}
+
 	return 0;
 }
 

-- 
2.49.1


