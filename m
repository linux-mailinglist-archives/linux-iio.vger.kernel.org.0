Return-Path: <linux-iio+bounces-8604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B599570C1
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53FFB21283
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D37117B4ED;
	Mon, 19 Aug 2024 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUOD2FsI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E56178377;
	Mon, 19 Aug 2024 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086126; cv=none; b=s8oXtWE5JdLv7+ALhzF2XRIYqe/fDt4yx7mMmIXsvR0rU3OBwOT6Y2IQTGTa6yNZWJHDQGyNTwqFhfPZboFABSTapUqaUlGQY+gTFUb7uE8kbSDMDJ5cdD7dw9l7b55Z5SGHqthJt2fTNPXxx680lMi6yVKpMGcJ2b9iHcvkM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086126; c=relaxed/simple;
	bh=LrihmKdwSa2HCqhUaNRUZZtZeL+1LnhboUcWlT0Xaqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfKmSNJFn3tdY5aEmhGNKtPi9pzum1ZISsD5JUP4uymzySo4gTvWpfNPISTalhvX8gekGmqI3Nn3atgqmsdMZ8dd1Y5yUEMwLcCsUKcriwByDWgpZWAOPYJ8fyg0mQcL2yBEvVKoZXdcx08byvf1kLZb45Qo0G139KiTM/PVGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUOD2FsI; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70949118d26so3724724a34.0;
        Mon, 19 Aug 2024 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086124; x=1724690924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOS6CB7c1t/IxbcoB65fP4OgyGzoOrEBpGmlG4zcGvM=;
        b=CUOD2FsI78uvXTl8qrQzufblSFadiehdZUHJIO0ZGF4nG3cs6kuwumF97uA0ZcszCB
         Pk+c7qpygp0jh+jEXN4sM4C/Ua4jIjCBTIa0JjWcvIsel3nKevKKSvhj+HMYZSzIDay7
         jIgg1S4TnAGaIjdE0EF8JxRf8SfpTF+Q5LZQblmZsnkBT6YGrM601TWQZSFuQBxx6Bka
         +pXFrXJHPHkSkazg8QmuIhYWAjH/iMCsmsfu8RriM5WxTOQo9d0cgoRa22tEsCRVZ+ix
         +SupaqvQ9OFghpT4nV76gT57n4ULWkAxqAg5uU+t4NQeYg1w/vfYGYf4a0xw+FSOU0Cr
         ERUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086124; x=1724690924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOS6CB7c1t/IxbcoB65fP4OgyGzoOrEBpGmlG4zcGvM=;
        b=nGaRsmMsNoW8/WnKg8+4pyWoAixT2zW+C2G2mzV6SIay0bhIK0lqk4PFc/n+fCgbSO
         Lh0cdpLQh+6L/J1JPKA0VtdXdYgfJoHBc5uzJgIO+jffo5a2IfCGXlGTfbby9P6OR8mv
         Wie+i1r06OtAi0ueRADnITUxTWAoqh73w1hDOae0tEwsxqHmblASGdmTxaoWJIh0PFBV
         xdd70+XrQCEdIGkOM3q+Rlj2Mb9RZW101F174v0vraM+spjxlSGkVdrU/L4MXdE3kukE
         VCHa4fmVrSWMmn3NsroX8t4wIW1f7QmpdA1swNdqsaere6V+1nP1o5aLr9knXh6IhEyt
         fUKw==
X-Forwarded-Encrypted: i=1; AJvYcCUZOI1oiLesWCuKt3mWcuzVkCiPwntPnpRHoTMq1z0ZG+fF2dkgw1Cuh0IBtmkyKKqa37Aip4rAiLtWhPuAbBarSlf6sP9LUmMh412Abc6O5JbAWRY8SoxScWktrRb17PGsLuT9uQ==
X-Gm-Message-State: AOJu0YwGd+I/PFWYVaYNah5ZMxNCP/uTVtBFlJIJPsDuOK8IeEDDb7Jf
	OdjZBX0ojDvdR9JHKV7t0WF6jsnocErc2yfZL/qChy9InXx+8Z0O
X-Google-Smtp-Source: AGHT+IGRbx6BxU4vKawFjexC1H9e2LGpEq+T3o1X+Pv/qXuObKZyJbfFheTtea7zTF3p2BUGf2M5zw==
X-Received: by 2002:a05:6830:d1c:b0:709:4936:d8fd with SMTP id 46e09a7af769-70cac8bf963mr15151806a34.29.1724086123933;
        Mon, 19 Aug 2024 09:48:43 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca649c61csm2332428a34.26.2024.08.19.09.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:48:43 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>,
	Chen-Yu Tsai <wens@kernel.org>
Subject: [PATCH V3 02/15] power: supply: axp20x_battery: Remove design from min and max voltage
Date: Mon, 19 Aug 2024 11:46:06 -0500
Message-Id: <20240819164619.556309-3-macroalpha82@gmail.com>
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

The POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN and
POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN values should be immutable
properties of the battery, but for this driver they are writable values
and used as the minimum and maximum values for charging. Remove the
DESIGN designation from these values.

Fixes: 46c202b5f25f ("power: supply: add battery driver for AXP20X and AXP22X PMICs")
Suggested-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_battery.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 6ac5c80cfda2..7520b599eb3d 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -303,11 +303,11 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 		val->intval = reg & AXP209_FG_PERCENT;
 		break;
 
-	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
 		return axp20x_batt->data->get_max_voltage(axp20x_batt,
 							  &val->intval);
 
-	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		ret = regmap_read(axp20x_batt->regmap, AXP20X_V_OFF, &reg);
 		if (ret)
 			return ret;
@@ -455,10 +455,10 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
 	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
 
 	switch (psp) {
-	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		return axp20x_set_voltage_min_design(axp20x_batt, val->intval);
 
-	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
 		return axp20x_batt->data->set_max_voltage(axp20x_batt, val->intval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
@@ -493,8 +493,8 @@ static enum power_supply_property axp20x_battery_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
-	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
 	POWER_SUPPLY_PROP_CAPACITY,
 };
 
@@ -502,8 +502,8 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
 					 enum power_supply_property psp)
 {
 	return psp == POWER_SUPPLY_PROP_STATUS ||
-	       psp == POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
-	       psp == POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
+	       psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
+	       psp == POWER_SUPPLY_PROP_VOLTAGE_MAX ||
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT ||
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
 }
-- 
2.34.1


