Return-Path: <linux-iio+bounces-8155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A89463C2
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 21:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970F8283190
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 19:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503EC165F17;
	Fri,  2 Aug 2024 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtlibLJ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98580165EEB;
	Fri,  2 Aug 2024 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626577; cv=none; b=VCjsnlfhyKfoCdKnKPD8d+1rzIy3SowgKD8mqoMXRXfOd24gr58jBPbdg8Fwx1iTnQ6z+LLpKk8x4yPJXF6nHokDHORY+Owf+X1m1YfbFo0ia3AgymFNn7YJ5BLMgLPzg2kSgc/v8VS62IYumxIh2R6P4U+YO0vXs/BGegZWEl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626577; c=relaxed/simple;
	bh=5a+ymo3BBR1upvcXnfIAo+PqatW4K0NQ636IZHuJqs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tz4uk8n4UZYg1/m1TjtokXwsPK5q3IZSqmmYby1nprnu8laSwm6B8rHzOjQivZn6Rh0mV9SA0JInrrDcdoTJbGEIHgJmhvSbgHsa1KWxF5PtEZ7uHGPH8mXu4CY1IGOp+CoMMQhXP4tE/bk/HA8r5eqsV6oiPon3Pn9wmAmnMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtlibLJ+; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db22c02a42so5064142b6e.3;
        Fri, 02 Aug 2024 12:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722626575; x=1723231375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW8pLbjHmp58tJfvrusMBZ0t6nfvqNtc57mmOOIaTIw=;
        b=VtlibLJ+5oaz1yFscCzxp8ExvjV12oRZ3RM1h1fkByGDXBD1IekYo/7XaMaDz6l6mp
         AqNObWwR+TSWCrA2GzFLRnFPGL0gGb/DdPOIqossjr2BmazIJplvxCo+jwmCE6haihv7
         4SRkYpmf3T6raKOUvoaszEcZw+L5Jhcn+2cqtaGRdq5VpP5/MA6nu2Lop2lQsncYKHVL
         KtLELAMEQEqSt+071KYPb15vn9XdHohc/SYUNdO8Th2AGLbmjld8MsWaO4v0qp+o4Rgz
         9IHMAe8ldX2x7kdXrJesdgHknE1XmJkln1TtpD1ixbzv+eGWyRv2DuqHdzZgkofOiNo+
         g69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626575; x=1723231375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW8pLbjHmp58tJfvrusMBZ0t6nfvqNtc57mmOOIaTIw=;
        b=kW+EiVF+MZH2kVTyL83kNWS3tlnxs/jbWZv4CgCUQmjxj+HNj5ZYZm0oe5tCz/z7q5
         KeTJez2ULt0ifj0gfR0TFQG6FCfRxlkkeuacU6H9P3JYp1ghjHdrcwcSzlMdT1R3zzqM
         ff/48nmVgIPVar3I8VjeU8xJMYm00PnlCll9BfD6dciVL9s9RGHfVK9IVET4REVgKF5p
         Ax0l731xDS5/cR9qlSa1EkFSlHNGVTmKlCnP7KSB62S6eNIBM1sK80/z5qXWWSH63Ye/
         8545PjHyBSExhKlzKwYV222BW+dspmWPmR3RZdHzI1VjvxTP8qZ/p2SKSVpNrken7FnK
         ancw==
X-Forwarded-Encrypted: i=1; AJvYcCWW9cAxY8RlppEiBQpt7DRLwBnJDdRZUTkq5wdUWJ/SyCVE+A/Pp9oEmIHGLiLXeWM+iNGoV5cDVK0kJkVRNT1HoeM8+8TFLkFgkXCIhh6aOwdDhalq03CaIYybVkuYhWYTIgw32Q==
X-Gm-Message-State: AOJu0YzytBbFL6EUCQs0Dc5mw/sqVUKpGcrAWqyobY6iNyQP/Pctkxqd
	Xt3XWqGd7OZQJ7hXyBe00m9+ksxvtskBKguvGGVPb9DA6IRrDO9Q
X-Google-Smtp-Source: AGHT+IGLrF7R/GoK7DvLxn2rE5wHYPa4hHdeD3olNUeNmJFauek8wLdUUrmSSS7uheaq9kYw3f4lNA==
X-Received: by 2002:a05:6808:f8a:b0:3d9:dfef:d7c8 with SMTP id 5614622812f47-3db55817bf8mr5537828b6e.27.1722626574804;
        Fri, 02 Aug 2024 12:22:54 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563b7065sm584592b6e.46.2024.08.02.12.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:22:54 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 06/15] power: supply: axp20x_usb_power: add input-current-limit-microamp
Date: Fri,  2 Aug 2024 14:20:17 -0500
Message-Id: <20240802192026.446344-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802192026.446344-1-macroalpha82@gmail.com>
References: <20240802192026.446344-1-macroalpha82@gmail.com>
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


