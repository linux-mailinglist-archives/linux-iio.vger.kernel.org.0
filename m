Return-Path: <linux-iio+bounces-20853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EA2AE2FE3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337B117116D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8181F1306;
	Sun, 22 Jun 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQjm/o/D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494EC1EB5E5;
	Sun, 22 Jun 2025 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750595391; cv=none; b=IPMyZVmxas4ThnjMP432PVdEfFG65pyry9IK8mjSygvYIZSGDLLUckwa6ckAHcCJK9db3HDDGGz59SX6tnsD079DY8cW6CkVe9iQ+wHu3XDECx6YnN5D6SQx4hi0ylm6GSTBTtq3e+OSVK4An1N3z1Fz+OW108//93aWhXJ3w7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750595391; c=relaxed/simple;
	bh=1Kw3ofbQtj/HNhdUQ4xAZrkSZ4j/+mkxZBTQo58MRnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3M4+zyAkIReuO7l/ku0+ieIhBKqBfHmNzs+prJ66IOpN06M/pVYZoET7obO2MT/tTJbgAP7OWfLAMwnJOkYudkc54Ho8q8xDgn15yDebuxrGVpV4vXjFAQmbO0qPe1QW3W9ENAqwag6mMgLohkH9PPQExRjduNCNCuNZZbFq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQjm/o/D; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6006cf5000aso619160a12.0;
        Sun, 22 Jun 2025 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750595388; x=1751200188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hy/JMiUHyBX0T2DXaBCq2snU5kx4BbgY+BhORUobO1I=;
        b=aQjm/o/Dx5TaHKlpwpGAaaDEPSnph+v+dO8QEn/S9zA0t9rhWz6TV7Ev005JQYMsMN
         ECeg9iTky9NisWln2fWvYZqrsRm79rW14p8X//Wey6GCHiMg+AZmepb/bNu2MfK4P/Z+
         zrr9MEqcHW9VV2Vv1GpjyxXlZ7m77mfYB7JwMsTbuxxejmXdvq+Phdp34UMK6Tc/gQqN
         iETpDwvpY20aFGKnbA+UY1aaoc/9fIW0HuDc8hLGNY4CBkYDutpojDiUxWQXNuiT+ZdX
         GtrMMrePoTQNG6O+fqasCob0FaULtGWcvy7Y0/kjmX9jdrxfNBlBYtU2382DAJGS8nDg
         HkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750595388; x=1751200188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy/JMiUHyBX0T2DXaBCq2snU5kx4BbgY+BhORUobO1I=;
        b=R/oLoN3zN3WDp02u5jJUNyw25IWfQKjAMJnGOxFP4WWX4/nFG+zvpTk6lcpVoXyx3O
         DMlo9MAD/1WkRrTNzjVL7QNpEPIB7DxXtEpDn+JOXrtV/bWn+V9RVNluivaB13rkwIgz
         DSCODpEHk82QWk2+/oIA2L7tZSR9PYXH4rm59mR50YonA5z5ffWywfk7f10uPuCSS0Wz
         lC502X+EnfdiOIys6uLKsa1Do8qxq0URPZ6CyXSyW/bH7ufdvwBG1V5xV3WA0cZ4Za0H
         RZEYhip1p1vliduMMdpZhgLNoaz5v1Z7uj2gK1sFNsc0oddaTnksLRu0cmELRW1DyStq
         sDmA==
X-Forwarded-Encrypted: i=1; AJvYcCVhTcpNoCJJ938QibCDJOwaoBB2HCi2iwW0w+Nin0VcpzSESb7HhaXmx6CXbecapvutwySURlKQXnNjkEEQ@vger.kernel.org, AJvYcCVrNqSXAND3GmBa0VAnj+/MKuVsTsWB7ugM7MLXv9JO2YgAFuo4NzzJ2bCjfiEiDlTdp7vQHkf5S1vv@vger.kernel.org, AJvYcCWxpBmbOb+L1va4IRDUdIcoeUM6AhI9HddTQWhaeI8b/WLUhiJICInbnsIyrDvI4mhrPCUi/iMsEmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5iMnqslmFZTldm1eXMNbsFotNUWrZ+2KpbuJAlhmCD1MAA7c
	2eZ9GbsOoCvyYkEfCQQ1kQLf08Pl9g88qnCtx9/Qm+YBnyAScgWaa680
X-Gm-Gg: ASbGncuPy0s/ArRMc2q2rQ04MFwcviz7JR9Z0N4ZLRnDcM0/i1N1L68zTOnkBRMqdmJ
	c5ZZqegLhjISHuhq+s1WlEVcmslgP7daSPUbj/zJVmWOjkvtC9t2NvQArv249IU6LNx+9WW4cuU
	Uj5ljhKaGqCo1l0vYGvZeH4/CAkVEZy7uija0JuA0qKmjynWU93DVpmpY/qht93gAo+F6Okd0Nr
	o6+IsIMIbYuH5X9smX49ITbLpLBBuPdNn3ff6V9xceDOdOq8HgtWGZB7NzwXM7pJYZ74BHHTC2w
	YucQvXxLicx28Q8xDuryBcMT+CgUhcihrqnwmreKCCJV6jN4/6Umcox6FQ0GiU1lot76Vp+1pU+
	8jvAW8e+WGXlBmORvywMDKmTbdoHQe4EN
X-Google-Smtp-Source: AGHT+IHgEDsO6A8uHrMHxJfoQvLn6dy+g6+7vAN64erFMY4b1AdR9a7gGjkPDvIH7zXh32tSNq2Puw==
X-Received: by 2002:a17:907:934a:b0:ad8:8f5a:9d2b with SMTP id a640c23a62f3a-ae057b4f13fmr236526166b.16.1750595387562;
        Sun, 22 Jun 2025 05:29:47 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053edc0e9sm533917566b.54.2025.06.22.05.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 05:29:47 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/8] iio: accel: adxl313: implement power-save on inactivity
Date: Sun, 22 Jun 2025 12:29:35 +0000
Message-Id: <20250622122937.156930-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622122937.156930-1-l.rubusch@gmail.com>
References: <20250622122937.156930-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Configure the link bit to associate activity and inactivity sensing,
allowing the sensor to reflect its internal power-saving state.
Additionally, enable the auto-sleep bit to transition the sensor into
auto-sleep mode during periods of inactivity, as outlined in the
datasheet.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  3 +++
 drivers/iio/accel/adxl313_core.c | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index d7e8cb44855b..75ef54b60f75 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -41,6 +41,9 @@
 #define ADXL313_RATE_BASE		6
 
 #define ADXL313_POWER_CTL_MSK		BIT(3)
+#define ADXL313_POWER_CTL_INACT_MSK	GENMASK(5, 4)
+#define ADXL313_POWER_CTL_LINK		BIT(5)
+#define ADXL313_POWER_CTL_AUTO_SLEEP	BIT(4)
 
 #define ADXL313_RANGE_MSK		GENMASK(1, 0)
 #define ADXL313_RANGE_MAX		3
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 36cfd23d2e3c..40c75e90e4bf 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -396,6 +396,23 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
 	return adxl313_act_int_reg[type] & regval;
 }
 
+static int adxl313_set_act_inact_linkbit(struct adxl313_data *data, bool en)
+{
+	int act_en, inact_en;
+
+	act_en = adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
+	if (act_en < 0)
+		return act_en;
+
+	inact_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
+	if (inact_en < 0)
+		return inact_en;
+
+	return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
+				  ADXL313_POWER_CTL_AUTO_SLEEP | ADXL313_POWER_CTL_LINK,
+				  en && act_en && inact_en);
+}
+
 static int adxl313_set_act_inact_en(struct adxl313_data *data,
 				    enum adxl313_activity_type type,
 				    bool cmd_en)
@@ -455,6 +472,11 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	if (ret)
 		return ret;
 
+	/* Set link-bit and auto-sleep only when ACT and INACT are enabled */
+	ret = adxl313_set_act_inact_linkbit(data, cmd_en);
+	if (ret)
+		return ret;
+
 	return adxl313_set_measure_en(data, true);
 }
 
-- 
2.39.5


