Return-Path: <linux-iio+bounces-18753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8388A9E896
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 08:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B9F77A6833
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 06:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313E71D5CFB;
	Mon, 28 Apr 2025 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvXS+pjT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B01A072A;
	Mon, 28 Apr 2025 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823282; cv=none; b=FS8KoSdeKP+elPEIccmJohcbWvB000dq4nas/MltnEhnN2BxLVfCfl9GwHkXtptTDaXDkwRgcmzanspmfUvEFxVLHcFYQe611jPgq7GNLkJVYGdHdlwRv/nhOrSkcW9BuIE9lldD3P9MQbkOeX761XY0tUGhYIe96W5jWyP0qBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823282; c=relaxed/simple;
	bh=DHhoS4rQcVy/Z7btxiMLFULAi3/lghSJihGrVJBvccY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hntTW1PWvyxf80203L2QGwI4OURjtEMHFnjkqusRpkf34ymrNiJeueXcpaMxLzxlx8YC7z/eA2bKp57BV2dVFFWGLZHXzXbGJKpMfWQweNT7t08UfwQFVzy/5iLpIC3ggwe+4RWkUZv6vxxZ2DDmrzlNpwabY6NjOCZDiCTFa/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvXS+pjT; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30eef9ce7feso46223201fa.0;
        Sun, 27 Apr 2025 23:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745823278; x=1746428078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIgv3LP87OoHzk5Dyiq6/wSMsFHxvx99TVeE0pWiL0k=;
        b=VvXS+pjT8UIrGUk6J58Ji87ZXwbwPMRvU9x+JPYRM7k61DEDMOz/cLxtap+8tfH53q
         TBZvXN3tohGMbsCESxPTO1AAMNTi5dlBoPN8IHiqzZr+VZd+PTTzedcCXqbi+G6kYL73
         hlZBd3sV0ytxHi5Z24SDFQSj5UPBoFL+7OtZoN6Fn7pj9o11rapNqPcIoN1cA/WzOV4q
         lRtlecUus0UpwpfSunNIEYMKBdhWVww/mdMDvHAY0+hGNvecyRRwxgr5O5LLYCxzT88o
         h/71LCRlbmkaBgWcDrqll97F6YvXn8cSWnGLIl8YJqyuTGRO1lYrHzhKO1zJg+82nn5H
         QToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745823278; x=1746428078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIgv3LP87OoHzk5Dyiq6/wSMsFHxvx99TVeE0pWiL0k=;
        b=UXLGBE4t1rONClhbGRCGWEFyaqFWo7B2CZWNMV/drGUr0WQAuB3W5QOZz2KjSYGP4G
         mKwmoxvjJ7PmQy8OS/za5Ffpvjs+6n5A/0VtpUe5A09cpJnNUHriHglTml8bqQDIYdoQ
         1c4YcNYtHkHmch73TZFfC8LyrZasl69o9l3cnUA63krZ6qY9TkyFxw68KH6Jf/jjF3Et
         N71ZAxBR7G4x8u7WETwJgUueRqO0Be9E9B06HHB66igYX50koS20cpLaIH8ZyE+CzurP
         MT6KCJmzP86kEStfuzdBxAPwVoGSXs0gXvSRKN7jkJGfAwASWOuei+Lmnn8ofJDoRawF
         Fqgg==
X-Forwarded-Encrypted: i=1; AJvYcCUkOMqDyqFnyXrJQ89jgPO7Gj4Yvnx6tO4Bnyjfl4HOn+DKNPa9pAR38HDLWc9cxjEyBSdzdaaXEI3q@vger.kernel.org, AJvYcCUqWfUv1fgcMOHk8B1+rdiA0U0nbXjJEAPD90S/7muPiQmAPH5W5wuRWZS51ff1eLHrGZdiE3sP7F+esjBH@vger.kernel.org, AJvYcCX77ONdNn6Iz8kkPBnJygFVTSpA/2AYv3gk/bTNc5ZTTJfSmVVK0c7iBgLAJWRyR9J15GjQDrHG58J8@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKj2Pc10/0bDZ9RDahktBsEnzD8VIlv5W30u5xV+hcG2tR0HS
	G0reD1fy2YdkwO+jf3vb8l4CN1qWAa2T/tUDWXYRbZx7QojuJlQo
X-Gm-Gg: ASbGncv+zHo6CWbbYroUaxerQIBSi/vrE1/T/s0UL3w17eELWmNqv0JXWgI/0QLS7Fm
	ELGc7CJPyf0DpUsUWqoPwn7bKzItwqCkxAf6lCSngKuJJYioN7IJZab4AAxZW/ix7S6VdDnWDfg
	r5Qh8BBz5mw2tliW3vES2KzJ9dW+7FNmRimv9M0HeO8FKVbJswrftuPbyYhVIRiZ4bPWxx7NyHs
	gtxYHwWtY+8pxZpDDnPx4DuSnIRcZ7Bw5PrX1RByOeLkwttX/wvxlFf5+KSU0kYxqMkGUJu1Daq
	92AfoRYQIFdrkEvhKeaL0mGVu7PGC/Q1EW6knfCxl2xjqe4RR2w8X05KXoskWWSQWv75VJTv2wg
	dzfs2T4Fu
X-Google-Smtp-Source: AGHT+IEfMfPPhSPz9W6Oc4iaQTp8MCWjKujv1n5NrZUuHBGTjMwJZmgyo1SV2U05xahQdtwOpdGN3g==
X-Received: by 2002:a05:651c:2222:b0:30d:626e:d004 with SMTP id 38308e7fff4ca-319dc41c1a8mr20802381fa.20.1745823277928;
        Sun, 27 Apr 2025 23:54:37 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317cf659c4fsm20017871fa.21.2025.04.27.23.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 23:54:37 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 28 Apr 2025 08:54:11 +0200
Subject: [PATCH v2 1/3] iio: adc: mcp3911: fix device dependent mappings
 for conversion result registers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-mcp3911-fixes-v2-1-406e39330c3d@gmail.com>
References: <20250428-mcp3911-fixes-v2-0-406e39330c3d@gmail.com>
In-Reply-To: <20250428-mcp3911-fixes-v2-0-406e39330c3d@gmail.com>
To: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kent Gustavsson <nedo80@gmail.com>, devicetree@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Lukas Rauber <lukas.rauber@janitza.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5432;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=DHhoS4rQcVy/Z7btxiMLFULAi3/lghSJihGrVJBvccY=;
 b=kA0DAAgBiIBOb1ldUjIByyZiAGgPJhygaIBqyVMFzlR1EMB2ZGh0EA1YDhnrBvEvC3yrCaDF/
 okCMwQAAQgAHRYhBAVRoui2bLVNZMEsZYiATm9ZXVIyBQJoDyYcAAoJEIiATm9ZXVIyVREQALvx
 /GhgUbD6S7J6aD4ENqcH49E6kB7JPIuEL3q1RfHX/esNtJdvH2uFwQo0S4eKVP7DorP7CFgsfoC
 FyJcq2lCZlBFjvbjb3h/XhIbdcsAsZDhHUk4l84tLZQedltzHS2ESFZz3vBVabOxTCa4cx0HX09
 cwzqocgOKYbxg/IFt8GWHUKjaajp8cMq7BB0oyGpKIRhaXmYV7tYPvQSEs57N4+IvypIjsLZoKF
 3Mp6ut4HK5ab43iFf4TzenTt7ECoH5Ehw8l1ThUwUeK8sAhruny4MKruxgP32NMS3jZArzqLy1D
 bJvO9t0FrKDW3xEhqXBEyw8+c4QN6HQKGJjNPILXIgIbp9n/ZYuLOksQI3+2zo4OhU5Y9gnbniJ
 xLkmKND9HrPtVNcnD21BEhF8EaCr3bB4U7IBQolfnuRk5NoHtuOSxncLmBWygiauJcDpFMdVuIG
 75cGt0t52nyXjSvdC5K9Y52N0+SMqbDCCza1+Vu2yrfjtefOZI90ewlqGCZep2zaCOW1kZYjSGP
 tAQDOaRfv8jj4MjF38yBlbByhHcyCVwC/IWSQJphBYofyzOLyLyXoEk3AR2Wwv1z7lwwOy+Hu9m
 K+dHP6KvpXrgC4oTlhoObglm3O6zGwvifG4+0pH4jeE+bvQhfw1T+qceI60JRrYi2ohNCMhnM7E
 sxGE8
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

The conversion result registers differs between devices. Make sure the
mapping is correct by using a device dependent .get_raw() callback function.

Fixes: 732ad34260d3 ("iio: adc: mcp3911: add support for the whole MCP39xx family")
Co-developed-by: Lukas Rauber <lukas.rauber@janitza.de>
Signed-off-by: Lukas Rauber <lukas.rauber@janitza.de>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 6748b44d568db68120172a950bbfffb6adc7cfa3..60a19c35807ab783505e817898a2405bd8beae34 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
  */
 #include <linux/bitfield.h>
-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -79,6 +79,8 @@
 #define MCP3910_CONFIG1_CLKEXT		BIT(6)
 #define MCP3910_CONFIG1_VREFEXT		BIT(7)
 
+#define MCP3910_CHANNEL(ch)		(MCP3911_REG_CHANNEL0 + (ch))
+
 #define MCP3910_REG_OFFCAL_CH0		0x0f
 #define MCP3910_OFFCAL(ch)		(MCP3910_REG_OFFCAL_CH0 + (ch) * 6)
 
@@ -110,6 +112,7 @@ struct mcp3911_chip_info {
 	int (*get_offset)(struct mcp3911 *adc, int channel, int *val);
 	int (*set_offset)(struct mcp3911 *adc, int channel, int val);
 	int (*set_scale)(struct mcp3911 *adc, int channel, u32 val);
+	int (*get_raw)(struct mcp3911 *adc, int channel, int *val);
 };
 
 struct mcp3911 {
@@ -170,6 +173,18 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask, u32 val, u8 len
 	return mcp3911_write(adc, reg, val, len);
 }
 
+static int mcp3911_read_s24(struct mcp3911 *const adc, u8 const reg, s32 *const val)
+{
+	u32 uval;
+	int const ret = mcp3911_read(adc, reg, &uval, 3);
+
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(uval, 23);
+	return ret;
+}
+
 static int mcp3910_enable_offset(struct mcp3911 *adc, bool enable)
 {
 	unsigned int mask = MCP3910_CONFIG0_EN_OFFCAL;
@@ -194,6 +209,11 @@ static int mcp3910_set_offset(struct mcp3911 *adc, int channel, int val)
 	return adc->chip->enable_offset(adc, 1);
 }
 
+static int mcp3910_get_raw(struct mcp3911 *adc, int channel, s32 *val)
+{
+	return mcp3911_read_s24(adc, MCP3910_CHANNEL(channel), val);
+}
+
 static int mcp3911_enable_offset(struct mcp3911 *adc, bool enable)
 {
 	unsigned int mask = MCP3911_STATUSCOM_EN_OFFCAL;
@@ -218,6 +238,11 @@ static int mcp3911_set_offset(struct mcp3911 *adc, int channel, int val)
 	return adc->chip->enable_offset(adc, 1);
 }
 
+static int mcp3911_get_raw(struct mcp3911 *adc, int channel, s32 *val)
+{
+	return mcp3911_read_s24(adc, MCP3911_CHANNEL(channel), val);
+}
+
 static int mcp3910_get_osr(struct mcp3911 *adc, u32 *val)
 {
 	int ret;
@@ -321,12 +346,9 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 	guard(mutex)(&adc->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = mcp3911_read(adc,
-				   MCP3911_CHANNEL(channel->channel), val, 3);
+		ret = adc->chip->get_raw(adc, channel->channel, val);
 		if (ret)
 			return ret;
-
-		*val = sign_extend32(*val, 23);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		ret = adc->chip->get_offset(adc, channel->channel, val);
@@ -799,6 +821,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3911] = {
 		.channels = mcp3911_channels,
@@ -810,6 +833,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3911_get_offset,
 		.set_offset = mcp3911_set_offset,
 		.set_scale = mcp3911_set_scale,
+		.get_raw = mcp3911_get_raw,
 	},
 	[MCP3912] = {
 		.channels = mcp3912_channels,
@@ -821,6 +845,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3913] = {
 		.channels = mcp3913_channels,
@@ -832,6 +857,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3914] = {
 		.channels = mcp3914_channels,
@@ -843,6 +869,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3918] = {
 		.channels = mcp3918_channels,
@@ -854,6 +881,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3919] = {
 		.channels = mcp3919_channels,
@@ -865,6 +893,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 };
 static const struct of_device_id mcp3911_dt_ids[] = {

-- 
2.49.0


