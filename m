Return-Path: <linux-iio+bounces-14483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7BFA16360
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 18:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46427164D75
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9969A1DFDB7;
	Sun, 19 Jan 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV/xDScC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46EB1DF747;
	Sun, 19 Jan 2025 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737307928; cv=none; b=Uwcpfhu/Fsy7IX+dBWvBwu8OcgF8DRlAcUCP+DznEUytrjZ8RLnFqWB3pYequbLrNZBLgkwjqnK5W2pSuAmSPUwC+FfPDTzIDARnc8Hlay9zwdJbvI7Luhhr6C+lYIilTJj+OcI0Z/VDQ+DOh/aj+xgqCwZQFtYK6rCbmkf9Wbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737307928; c=relaxed/simple;
	bh=bWPm28t2DlwzlWZMqKi/LpXy84GMNqzF/p/UNU+O2CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFqCj0bOnu4l/R78GM4hoAT7KB6+dRD54EPoNaF9urlVNXKw/ZqnzBhL/QeKgwbbMHWFkgsTlJpEm9dM14otBGSBNdnHbJxTdmnpy0CQcHR2TGyg8hRJgsKw3EFfxHEZx6yqGlbJ2jXlVHp/5qpHDRJlu63Hr68xZEUB87mz6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV/xDScC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-438a39e659cso5638085e9.2;
        Sun, 19 Jan 2025 09:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737307925; x=1737912725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXm1wLqxZkE4tLGPAZYZyFKZAArgrpe/zDW01KawXnk=;
        b=IV/xDScC+4ghnQn81EzxswJRUcdGmf8g0TaIe7QlqLgnSWJ+V+gSqOlRL4KoLfz9Ub
         iVwmsxFP8UqYT/gmmR5Gz0zTvMrod1ZliUZmS7SIhjXAXdu9/DXL4+vItIedYLgGMO21
         u2PpvnPybf4W1ckamDuUx8sBRx7cHaFCjSlx8oOhw35XekGATi6VNfFewOUVk06zozUn
         fpqQsnLCec/V5IKg3Y54F1p7a/Xq1A1oSVVseGWVVf298X/SUCUNxi1pXqYNhb2t0ngM
         vQW63m4XrhuUEbbrSe2ACd/dRdLDMyNQlHaulFasdNbgQGLazN4/NBeyRwhpamnuk0Fv
         IVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737307925; x=1737912725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXm1wLqxZkE4tLGPAZYZyFKZAArgrpe/zDW01KawXnk=;
        b=eJ5WVjUxUmUHqPbIA0sEIc+rOUniJNoKnKgexd087Lb04pR8N6qQv1y+AtQK+wllyD
         /MmsB3BnL23GpLvRueAFsdAeQXUAwSq5KyoFOWH9I234qYFhB32EjEcbFD3sFB1vWkqe
         FGND/D1mpru+U1kREtuoBcOe1keZj/inA5ZNPm2R239lCVvXgDs8c8w3wRlkfH1t0v1e
         SVd9+uNe4m0ElyNQISm7cc7+Q6//QTCu0/ZGlZBt61rzof7Rt0SM+umJYyuhtr6c4d25
         haPDEUrDJnNz2DlTb5GgUjVp24fzqZBwxlBpzaEhzUH1pAQ+OCeY88iUa1dk2kWE5buJ
         GkZw==
X-Forwarded-Encrypted: i=1; AJvYcCWObTX02RK1i67PwtznqLoAevvp4Uk+HoWePO+q1+Ev7UvpfjieZMf97myMVfIyJ5spHR9DKk5Wasf3FsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGsDU0pYqESf3ScOxRpanqACY+kYy5Q2SV65hSgUgF6sL8B3m
	6fj7UGKwv2HfwGq3yOxzPg+lx9kUmPP/M/ifT3pFt7yrtLeVPLH1
X-Gm-Gg: ASbGnctTKzc4aTSb/U2UlwOH5rRaQOWzQLrkDk3ff3AQmu5tuHA7Mih2k54NwFrfTCQ
	bGt01cU+yA64ik3DmAmQROIZpjubyziqeQUuwgWbm26iU8jJWIGXyeyvs3JXTrJ01HO1pc7l7Rb
	NidNjVZoSuc7STCifJk+q4rGMAfnAz34g5x4F6MFdl4YM99cL2xCJStXiF+3PDWqJg4SfgArvdo
	aCV+ZwQO0JFAeHUgzU9mBOBH8y5q/1Pw6YiSCuMohrIuK+90YUdb6wOsPd0H3XWRcI9KgQU3Pkd
	5zh8K8oGJTrYpA7+U/Y9o84twihR4tfpuWzWpvIVKF1g2yysbx02yUO4uO3Kjy/BGElU8qBVfDX
	lykABGehlxcAdhcIY
X-Google-Smtp-Source: AGHT+IGAJ3KDPAIhylgxeMwZjYARwsFQZpWgg0+2SJY+v1AIlA7wbcu2LEbJIpthAa4knP/y7RWJHA==
X-Received: by 2002:a05:600c:4511:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-438914387ddmr79282045e9.25.1737307924657;
        Sun, 19 Jan 2025 09:32:04 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-ec17-b16a-8f4c-782f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:ec17:b16a:8f4c:782f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32221e2sm8299423f8f.36.2025.01.19.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 09:32:03 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 19 Jan 2025 18:31:59 +0100
Subject: [PATCH v2 2/4] iio: light: veml6030: extend regmap to support
 caching
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250119-veml6030-scale-v2-2-6bfc4062a371@gmail.com>
References: <20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com>
In-Reply-To: <20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737307920; l=2224;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=bWPm28t2DlwzlWZMqKi/LpXy84GMNqzF/p/UNU+O2CE=;
 b=dGZnrFw9PVNID3Ut0NS0zSiWFgrq2G+XKoBHVioferc8gK5GN6AeM8cdqhV0Avt3V2wtwi8xP
 qkQYkPgoRRWAWyiJv1VlAhzr9ZhnM5xknft8GZxN8SAWbVEPMWbRAb/
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The configuration registers are not volatile and are not affected
by read operations (i.e. not precious), making them suitable to be
cached in order to reduce the number of accesses to the device.

Add support for caching (RBTREE type).

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 8e4eb8b0c19276635567d4eed74f4d402c3205fa..3afd4bb1ad53157f7ec63a35f51e5a96f7b019fd 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -333,12 +333,43 @@ static const struct iio_chan_spec veml7700_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(VEML6030_SCAN_TIMESTAMP),
 };
 
+static const struct regmap_range veml6030_readable_ranges[] = {
+	regmap_reg_range(VEML6030_REG_ALS_CONF, VEML6030_REG_ALS_INT),
+};
+
+static const struct regmap_access_table veml6030_readable_table = {
+	.yes_ranges = veml6030_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6030_readable_ranges),
+};
+
+static const struct regmap_range veml6030_writable_ranges[] = {
+	regmap_reg_range(VEML6030_REG_ALS_CONF, VEML6030_REG_ALS_PSM),
+};
+
+static const struct regmap_access_table veml6030_writable_table = {
+	.yes_ranges = veml6030_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6030_writable_ranges),
+};
+
+static const struct regmap_range veml6030_volatile_ranges[] = {
+	regmap_reg_range(VEML6030_REG_ALS_DATA, VEML6030_REG_WH_DATA),
+};
+
+static const struct regmap_access_table veml6030_volatile_table = {
+	.yes_ranges = veml6030_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6030_volatile_ranges),
+};
+
 static const struct regmap_config veml6030_regmap_config = {
 	.name = "veml6030_regmap",
 	.reg_bits = 8,
 	.val_bits = 16,
 	.max_register = VEML6030_REG_ALS_INT,
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.rd_table = &veml6030_readable_table,
+	.wr_table = &veml6030_writable_table,
+	.volatile_table = &veml6030_volatile_table,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int veml6030_get_intgrn_tm(struct iio_dev *indio_dev,

-- 
2.43.0


