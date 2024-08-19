Return-Path: <linux-iio+bounces-8608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 792C49570CC
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA961C21662
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124DD18757F;
	Mon, 19 Aug 2024 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtCs8aGy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3B178CE8;
	Mon, 19 Aug 2024 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086129; cv=none; b=VEdZlZpNLSPWC7Vuw6pgEmaq+rq1LlzFy5jxLwWX6niYcnejrm5cyPnTleo6CtXmcBn5uyS/qbgRNNMIIhW/zE894S41ATxYpGzwir23qwYnEjUyrY5xYqdQbUkOipJOFeydGyDanVFJsspcXZizGSID3vnf0lpExMS8LPX2TRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086129; c=relaxed/simple;
	bh=5a+ymo3BBR1upvcXnfIAo+PqatW4K0NQ636IZHuJqs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3Ibb0VkujxMBrih92KS1ud9v0himF1tGXnM/WnmF2Ky66saZ4vMKvl0jsxVKKgjMB7HOuen8lEmT+/l+UW1ygswn3cz0Jgi418hcRdtTh+Ehi7eerzbJV9PS7pQQ8gpMSKRvoDw/dmgAkb5LDIYKYd6SF5sh7MXdiqKe9iXubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtCs8aGy; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70936061d0dso2761745a34.2;
        Mon, 19 Aug 2024 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086127; x=1724690927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW8pLbjHmp58tJfvrusMBZ0t6nfvqNtc57mmOOIaTIw=;
        b=BtCs8aGyx7SH0Xzr6HruFsSTOEm7U4a2HsqzK+o2Hu0BzcjL8ddEyWABfaXWoV+V4b
         YfwVi9w/0eLMhpf33WujflRdBgn9dh8N2l8WuheNlHyOK030QmvSsbH2KtQq3mPm4BnE
         Q3wSuWb6ARlqMFg4Qu2VZzWVQJOjGZTNAMP7gZz358C18e4REzzZ/ckfgMVy/hlSJOlM
         wDFHioei7f6qlddld4hOoff/SrGandQQcrAApiDJy1hY7uHyiN6qlPNrZyUWXUTSuVw5
         7KsHg0unQJSg4Pv2MikxaLUwCbgPqE8IOYFTE3UM2s/ZGwXWp1CSWwMZqayHyxKvWaHA
         trYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086127; x=1724690927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW8pLbjHmp58tJfvrusMBZ0t6nfvqNtc57mmOOIaTIw=;
        b=JmZFGG0hZJr9yzqrZtnGmb4xFgaD3372RnHgXL8NjojOjf0ZaopxMizTimiQ5ibW/X
         rQwMBiajDqifNiF5qPgHGD4hd5XTIdHIjadLGBa7sh/QV1+1z9w/rBUnV1xleUlLjTd8
         WB09jjurPa73c8KCs7gPuZDw1/4PTBGVIC/bx3ZDFAAmw1ho6216KAt0C/qio1JrNNN8
         0FG4/0h1pU6gAshyb+FSFDjfFXqnu6kEd6oUuH4onNoHK6zeVRuBmihaOpt9kLWw9yuK
         UZONhX4Oh3nXEC3ZvujeqcX8bLUN5gjWajnryddG8fu/E4AMEr6rV/8HECCQgIHD80Ob
         hdCg==
X-Forwarded-Encrypted: i=1; AJvYcCX7ApA0er99kXEd0w+v5krcLGgZSaRi5bCkI1T2DgRBkKH9L5NnmZsDt6IuXSBs0P9gsLwHf8k7v5cubtjPgF/4QQna+6ZghhjCjvHMHkhdxoxYEDq/9tXqHMvEqmDV2uoLTfAfqQ==
X-Gm-Message-State: AOJu0Yy8P65l4yoiS8oAHxG7tnu+7G3LxZaoUw2qhEJnaLoqqa9QL6s8
	SmO+7BcI9vvwSKU2UeSpRR4wK43gBGSgrG/QszZFKhP0F9SJ9wnn
X-Google-Smtp-Source: AGHT+IGLpyFYSUV+cBCNRptV8yxiewNZEx5HrXXFCUBc5RJlJY+ALXntzTpuvudFQsRUtsorOOSeSQ==
X-Received: by 2002:a05:6830:380d:b0:709:33ee:f578 with SMTP id 46e09a7af769-70cac84f622mr12959822a34.14.1724086127315;
        Mon, 19 Aug 2024 09:48:47 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca649c61csm2332428a34.26.2024.08.19.09.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:48:47 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com,
	mripard@kernel.org,
	tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 06/15] power: supply: axp20x_usb_power: add input-current-limit-microamp
Date: Mon, 19 Aug 2024 11:46:10 -0500
Message-Id: <20240819164619.556309-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819164619.556309-1-macroalpha82@gmail.com>
References: <20240819164619.556309-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Allow users to specify a maximum input current for the device. Some
devices allow up to 3.25A of input current (such as the AXP717), which
may be too much for some implementations.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index cd9e92f2ce71..69fbb5861934 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -80,6 +80,7 @@ struct axp20x_usb_power {
 	struct iio_channel *vbus_v;
 	struct iio_channel *vbus_i;
 	struct delayed_work vbus_detect;
+	int max_input_cur;
 	unsigned int old_status;
 	unsigned int online;
 	unsigned int num_irqs;
@@ -323,6 +324,13 @@ static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *pow
 	if (intval == -1)
 		return -EINVAL;
 
+	if (power->max_input_cur && (intval > power->max_input_cur)) {
+		dev_warn(power->dev,
+			 "reqested current %d clamped to max current %d\n",
+			 intval, power->max_input_cur);
+		intval = power->max_input_cur;
+	}
+
 	/*
 	 * BC1.2 detection can cause a race condition if we try to set a current
 	 * limit while it's in progress. When it finishes it will overwrite the
@@ -661,6 +669,18 @@ static int axp20x_regmap_field_alloc_optional(struct device *dev,
 	return 0;
 }
 
+/* Optionally allow users to specify a maximum charging current. */
+static void axp20x_usb_power_parse_dt(struct device *dev,
+				      struct axp20x_usb_power *power)
+{
+	int ret;
+
+	ret = device_property_read_u32(dev, "input-current-limit-microamp",
+				       &power->max_input_cur);
+	if (ret)
+		dev_dbg(dev, "%s() no input-current-limit specified\n", __func__);
+}
+
 static int axp20x_usb_power_probe(struct platform_device *pdev)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -697,6 +717,8 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (IS_ERR(power->curr_lim_fld))
 		return PTR_ERR(power->curr_lim_fld);
 
+	axp20x_usb_power_parse_dt(&pdev->dev, power);
+
 	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
 						 axp_data->vbus_valid_bit,
 						 &power->vbus_valid_bit);
-- 
2.34.1


