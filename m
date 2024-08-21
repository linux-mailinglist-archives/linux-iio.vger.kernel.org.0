Return-Path: <linux-iio+bounces-8670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56A395A748
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92441C22AD4
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B1917C7CB;
	Wed, 21 Aug 2024 21:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKlq8RbB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E87A17C21E;
	Wed, 21 Aug 2024 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277456; cv=none; b=TIUV9Sf28XzpHKApuRpdyV5ymBmMgO7PvpvN6prl/Pm5PaSTtO+VVRr7QaR5l2xKri5TCzSTFtMo2lVBjLFz/XftoiwL9wfO6jDwQh0Xn7hDs4TVKwEAUBPw3eOCyeUDRWkn51MBj2l2QIvRuGonZ3wnR0Mvsrv5eVZ4WjWiBjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277456; c=relaxed/simple;
	bh=5a+ymo3BBR1upvcXnfIAo+PqatW4K0NQ636IZHuJqs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eT0YJKsGXwQsoOBciEuqjOIglyaxq1qAxFKY8bkEDjBslGSA1UYNJ5KGiZpO3YtAUxWfT2l04b6MZMscFI+9TQ483xNFwB2cSoDUYaH7ucil0tuFqSDxnyl2OQ7TcxLUb17Gb2x3X80M2MsggKezCEYiV30fwv7qbC74SActnSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKlq8RbB; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db23a60850so87459b6e.0;
        Wed, 21 Aug 2024 14:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277453; x=1724882253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW8pLbjHmp58tJfvrusMBZ0t6nfvqNtc57mmOOIaTIw=;
        b=SKlq8RbBrD7yzLVgU3c8DbWlGa7oU5lL885ol+sQIHzIXsnwEppHhDPiymr0umT4Y1
         S+u5HiZtvaGxsn+I/V50klf5ZXNygqPUHTYfZL53o/dx/rzxEgZqC4ihMHNFS3rKnKsV
         7T1J2nHkKKsrcdwyQowUScV8EoQkW2y1JTSRL31mJTVPIf2GjiQP1A+lJYtct/pyAFQB
         zOICAB7SqtpU2G2HEifNZRDRZlJ3ulc5hOjGmMlW/LzkBVyf1uA5IkuCz5zpxZoCpXRG
         9wdIq/fuKYqeyJCEGCNpM7oz8AvKae+QpDHtcFEB0ydxPP3Iq8MSLUVe9JW0by4zH0LM
         3Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277453; x=1724882253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW8pLbjHmp58tJfvrusMBZ0t6nfvqNtc57mmOOIaTIw=;
        b=I83ixxybafM4OE+/4qJcfuWuzi+GwPiBNg0KoZFNIzGd1KKJhIPWyaPHSEfjyFofdE
         DRLCUVkuj/tyof8DsMloVKaIM5M8kGc6A4Ft+ZMR4gRQYp7N5jFQd2e+jNcnQrWCsWb3
         ZNeWvx9gkOECSAgTvx/KdYMhRDBVRX1DyPWt51b6Lg3f614WsN2+gzjfT3JFo9Ekmxnv
         FnraHAPTuDsFV77qjjPiWvK7NNfNb6EqDZ6sCDcl+MoaKQNe1KnzRNZ3s+yEpbdf4mGg
         B6jsE8GwNIHK5ResP8w237CiIREvheC+fYmkUhRAZQI/3J6cL1KEPMSXzofpklxzMVWs
         DF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsuGlU43sILryzGe02QnSWeYLxnq5tXVXeFmtBUWfO5GFevOFDGnszbDb0DC4XLMFSvWsQKKPIjmLs@vger.kernel.org, AJvYcCVFWRA8o8M1ySuTUQlP72CGejrHCHiHxuw5LnE8458ZNBRwj0KJ1txj95NxninFCB/dmna00Vxn16/Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8qNSAX3Jjih7LyBZ6NxcTKt1o7s5Ek8eVDLJ0tjMR6JjYEB/X
	4RIrdxNv6RQ8+W/DhTbuOckVcHlQ9d3RTIxlW9Br/PQL7e8smaLh
X-Google-Smtp-Source: AGHT+IHGclXhRe7MiZ2gdXv83D4GWjeaFVDAh8ffxoiueuIZjAXOFvrAwN7o6rMnhdMLZv0E2Dx/ug==
X-Received: by 2002:a05:6808:2f07:b0:3db:198d:97cc with SMTP id 5614622812f47-3de19d20c0emr4500013b6e.33.1724277453646;
        Wed, 21 Aug 2024 14:57:33 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:81a9:2325:e0f7:7376])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225555b6sm47070b6e.17.2024.08.21.14.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:57:33 -0700 (PDT)
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
Subject: [PATCH V4 06/15] power: supply: axp20x_usb_power: add input-current-limit-microamp
Date: Wed, 21 Aug 2024 16:54:47 -0500
Message-Id: <20240821215456.962564-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821215456.962564-1-macroalpha82@gmail.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
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


