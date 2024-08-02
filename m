Return-Path: <linux-iio+bounces-8151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D95C9463B4
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 21:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2377F282B53
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C525F15C14A;
	Fri,  2 Aug 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU//QauX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163EF1547D1;
	Fri,  2 Aug 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626573; cv=none; b=FlQeYRY5lvCJmuC94g0IkhWpCvR6/aCz2CBD8cutPadoeLk/X7I3FFH7jh0UJBIHlK45tsE9q6IxfoQdxeXcrdqYP103b5opJMuDojzZpRmLBY/hIztIjmy7N75bAeBD3wNKxZa40cN71NswGAccwNm/ERC1Uj0aabqycNmgihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626573; c=relaxed/simple;
	bh=LrihmKdwSa2HCqhUaNRUZZtZeL+1LnhboUcWlT0Xaqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h7NVDn5BrGk9d+WuDDrknq9bnX5PapCB9Pj80pyZmBP9wDLcuB4FfkZXfHE4hoxOIevvN36MbnPevDmr4rvdEp6GM2p7P6GhKOIAJCiBJC/uMy+Btcx1QjbVvqlwKjI8fdQpVjkd9q1H5nCR6Y39pdzb0pthsooW2DH7JmZFcIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU//QauX; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db23a608eeso5595753b6e.1;
        Fri, 02 Aug 2024 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722626571; x=1723231371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOS6CB7c1t/IxbcoB65fP4OgyGzoOrEBpGmlG4zcGvM=;
        b=aU//QauXqtaAWaG4iOyJQzXYs86r8rCRlI/e9N3LEW/7z+iWTE59VSB39JMledY/p7
         ZImim3qRgpKDOrkm6Jxn1tn33ULW/2Im26qu3L8kMBSgYSxCJcZZkVmb/bjHWyy4bPwf
         KqZBAKLbHj7D8z83JLk2n6FwjvKxDlDb8KR18P5CvGoSg/TFyjVgZ/XWvc4RCk8eBzgi
         RpfKzzMEG8oJa6zvlJMb53I8KUc2RxAt7YycVPGCCja4Tezdmt+ljQgOT34cNd03WLUg
         7eQqWgs50HJ+fxYj5E42KAZdtk6aEDuDlPPDRgmAgcII7Q7ybi2W2u7etajeHguk/BZI
         x/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626571; x=1723231371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOS6CB7c1t/IxbcoB65fP4OgyGzoOrEBpGmlG4zcGvM=;
        b=j/NKsVXr7vvlyb0QNERojK5iAyqry27EVIvGO9DIR9LCZuPWDkkpppnc6S+mMzwIyU
         ss0/LK9XiVWXeNIxeiFF70fx8ogS4NTtiUBE40h+zZhH3Mp1EsFVnpQeV5bdHBNQEZMf
         5AAeK4Dn4fZL0KHWeF15vDzillM0oF+402D52fk7CaomAet4i0ad3qoZip2DpcjdL/2w
         eGIz6+9WYc7AK+kPjPq/HNQ60hr8dBJZWwziM8MzqZGbifmOphz+hki0S70M6bjnUes8
         ZYFYnCOwPaWFUWw8K7gAdk5MdXXiizaWU1AqRsIGmjxWZLTQpj5kyBIFpFi+6hAhya67
         6INg==
X-Forwarded-Encrypted: i=1; AJvYcCV9bk0U2ObOaL2TMSS05ofSNjTc78Y4+HEaxOajxeqhHwgjUHOFFj0dAoEp3mBK1NEFNCUt003Hm1pxP31gXNIBeLr/N+ce3e+TAZ0ceRV6E2gRevSe6HVLb26Dfj9U3+ow3QAAfg==
X-Gm-Message-State: AOJu0YyZ7mQrpnuUjYmDo7RzKjiJ1dtD8DU86TFn1bjNasOCJs76k6Fn
	Ya5P3Q6l3WoCSfD2fpnw9HjXpuVsitDtA4bhf98x+m9TMOXTyB3j
X-Google-Smtp-Source: AGHT+IFJcAjiqo+BzQ7QTY8ocYPFJ2ywrHoQ1xB5Idyd/7diq5ZppHkiZrLU53qgCT0FJHZgYfZPjg==
X-Received: by 2002:a05:6808:1919:b0:3db:27e6:8be5 with SMTP id 5614622812f47-3db55847b72mr5731454b6e.42.1722626571189;
        Fri, 02 Aug 2024 12:22:51 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563b7065sm584592b6e.46.2024.08.02.12.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:22:50 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>,
	Chen-Yu Tsai <wens@kernel.org>
Subject: [PATCH V2 02/15] power: supply: axp20x_battery: Remove design from min and max voltage
Date: Fri,  2 Aug 2024 14:20:13 -0500
Message-Id: <20240802192026.446344-3-macroalpha82@gmail.com>
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


