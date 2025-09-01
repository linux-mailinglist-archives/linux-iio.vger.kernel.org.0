Return-Path: <linux-iio+bounces-23614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF2EB3EED4
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544A3485E8A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F64A32ED2F;
	Mon,  1 Sep 2025 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="40jOoNYa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C321019C;
	Mon,  1 Sep 2025 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756086; cv=none; b=ZDvxBRQKH3VeedQMxVvQI8Irnb6JA8TkSvOoL6Dp0ed6KRjU3KHPhJD11vZbR7gOZ2KOahb/BJnrNtE1eCXB9Wh3REWu/+KVECnj5AE4V9GCg1Q3THweq1ZeLz+ZD4EMpqLGtpucIAa6uy8Mi5gkL2bjF3y8NV99v5KCEeiIK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756086; c=relaxed/simple;
	bh=Tepe2HnmOQQtLKDtH3w0ZwrujUeBKRNKyeiSGGFLgT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knV/pWP06zV6Vtx65LFh/+Ycn6MpTr+dzVXxNxhF9Vwfz9Rgv8G+MtDnHAD6EUiX+17NTGEWtuGo/1ZyDL6LQ21OkCIZlzvqEBbeeIADb4ca7HOwcVfBH662+nrlMxjg/SoJqG2HHLjMN7lSHw9LX6LN0uITfRappwcU/3LlaUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=40jOoNYa; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 5615D173BED;
	Mon, 01 Sep 2025 22:47:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1756756076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8037ziBQdvZlRDgfvedaXrcP/LtyZMhTXyYaCxnZVyc=;
	b=40jOoNYazEhJm79D9WXOe5HjI8YjXZl2uw1rA4Jz1ipRCFnxXfV2i4TwdHCQtqV4FTXMpx
	ZGhh1hsJiN5bghqli5SgtJs+H2Aa6n9Ku3n93pzi6N1bCmXphVpHHreUUtw9yJwm8TO5Yw
	Shaags3UD7mF+7CzC9jQGhXoabvn3xhJ/4gMrs7KuqoYdGttWWmh0Zg5OIfN77d89VgHpF
	6aHhjSsggI4kDQws7zXikLvrpKhb32c9umerfbd49SKP74ez1Y3OZ9073PmvOg7+TYTI1g
	l8z0WZtHlkNZMGYjy1RlSgY/Iyc5nUA/BThVWvMQgdM7YUI/+nzJ9ikjnWmG3g==
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 05/10] iio: accel: BMA220 make use of the watchdog functionality
Date: Mon,  1 Sep 2025 22:47:31 +0300
Message-ID: <20250901194742.11599-6-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250901194742.11599-1-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes the sensor gets stuck and enters a condition in which it pulls
SDA low, thus making the entire i2c bus unusable.
The optional bosch,watchdog property mitigates this problem by clearing
the condition after a period of 1 or 10ms.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/accel/bma220_core.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index fae84823d52b..86347cf8ab1e 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -158,6 +158,12 @@ enum bma220_axis {
 	AXIS_Z,
 };

+enum bma220_prop_wdt {
+	BMA220_PROP_WDT_OFF,
+	BMA220_PROP_WDT_1MS,
+	BMA220_PROP_WDT_10MS,
+};
+
 static const int bma220_scale_table[][2] = {
 	{0, 623000}, {1, 248000}, {2, 491000}, {4, 983000},
 };
@@ -428,10 +434,17 @@ static int bma220_power(struct bma220_data *data, bool up)
 	return -EBUSY;
 }

+static int bma220_wdt(struct bma220_data *data, const u8 val)
+{
+	return regmap_update_bits(data->regmap, BMA220_REG_WDT, BMA220_WDT_MASK,
+				  FIELD_PREP(BMA220_WDT_MASK, val));
+}
+
 static int bma220_init(struct bma220_data *data)
 {
 	int ret;
 	unsigned int val;
+	u32 watchdog;
 	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };

 	ret = devm_regulator_bulk_get_enable(data->dev,
@@ -462,6 +475,25 @@ static int bma220_init(struct bma220_data *data)
 		return ret;
 	}

+	ret = device_property_read_u32(data->dev, "bosch,watchdog", &watchdog);
+	if (!ret) {
+		switch (watchdog) {
+		case BMA220_PROP_WDT_1MS:
+			ret = bma220_wdt(data, BMA220_WDT_1MS);
+			break;
+		case BMA220_PROP_WDT_10MS:
+			ret = bma220_wdt(data, BMA220_WDT_10MS);
+			break;
+		default:
+			ret = bma220_wdt(data, BMA220_WDT_OFF);
+			break;
+		}
+		if (ret) {
+			dev_err(data->dev, "Failed to set watchdog\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }

--
2.49.1


