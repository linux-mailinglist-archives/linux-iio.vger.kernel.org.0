Return-Path: <linux-iio+bounces-20106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DF8AC9F94
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FBA1171703
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48A820E338;
	Sun,  1 Jun 2025 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUebaWGV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914C20B7F4;
	Sun,  1 Jun 2025 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798524; cv=none; b=ZEAIXELtZpVzlww3PNJ7LIJGPNu97BFnr+0prVP+DjlmtLXeWEEygFCC/ISXHbRdZWh+qHY8axXxbLIfl1DSqOeAVYzF/6DLrYSykWTKyBg/SDNxPFk7/LBlEX1FACJMPDu4nNDMMoyxiaDk3w7D6ALnl4Yw2JyIhThs/cMoWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798524; c=relaxed/simple;
	bh=Ub1aTeGFAJDvduLbmc5NBo57Tq59dAFTDft49ZVNtRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JP7hmlm62bqEsJfeM0bQ4FeLUbHNpVKy0ljUsLeaC3wo6sVD8VH108XOp0E1zoekF6+HsD32oYUfXEwGOrm9lBfg9vF4+KjunmKtMcahyuJ3rRpEg6zcOWNK7+6phGivpIhZxiMYv1SNY/CosF3r78JtScijPPI1GZCXDQ0vEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUebaWGV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4e575db1aso630826f8f.2;
        Sun, 01 Jun 2025 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748798521; x=1749403321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/p00xxeKrW18DxqZlr6+EJZ+MYsLVPR4xd0nxDfQhA=;
        b=UUebaWGVMlI+6elyJ29HvcSCEr44cA7PFlJoUheBEJgWW87i3bnkzSGHWqSGvCGjf8
         SVeYjs6MjzXVdGhKlrWBMjZfAnDliTAiLozat7Rmum1Q23sOm25D+5RdH//veH5Qxmhh
         PvjFQihzs/pfPkGPABRZKAnxsD1ZHmPA/CgJwnvD9r8lJf/X56oU5xiFwmlSTylJ4niO
         BGdRmb0qIaXpwRTnO3ioDxbxBcUBROxaeKZkA8v3MhyCRzWcSRRtDoSAOx9WUh3sBeZs
         BE8lQbZIoYtBZ2XBOG69th83Ou6JC6+2eGNjQX+oi2Lf4YpbScpUhNTLLKT1KsmcbbV0
         9DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798521; x=1749403321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/p00xxeKrW18DxqZlr6+EJZ+MYsLVPR4xd0nxDfQhA=;
        b=dcpUi+UEke8u74EZjA9f2uUaJKAxucZRW/hLafExUQ6QoEzk8jZr9KicOK/MEAzH/8
         zx3B1hVj48m90nEJ++Sh0FxQurGLWhJcJ7ZnDxe67SSOWtbX+QLTac6wksN8UyO4JlNT
         bhn4Ty27ikVr7DI9VEtUEjtx5OCOmrEDzY47Jwaau7RBZoT6YRu5KctMoP0zJIeq+KS1
         yyEWxWhw4/Q60OfxmVPnAQF6/WytZZhcJsC/lAO5lzjm4L+2f4I0cdt5uKUmmEktGz82
         b8Y3HOCZJSmkfV35K4uUJPPJRuThpcvEfauIP2g5mpa0tLluxQLQxtDd9H5+WA6fcx/R
         n9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCU9/KokxSeXx5u5hhHSG2plJe9dav2onqdJygKGtWbgjnHyvPtW/ZEnRnLOK/HLGqxvSPFBjPGPQTDN@vger.kernel.org, AJvYcCVfYCpRFHPhu397tkIC4VWz0/SxVmCDW5X9HfqGllZfdQgyIXHyMYNSRwhsvFPjySa5YNM0CK3NUg8=@vger.kernel.org, AJvYcCWN7wzKBAUaeEzMokJIBFESLTdIRbULoHBVxigD/LCA0pbptYglu4B2MNIk6JRV+PbOHZteyneKaZYkzox7@vger.kernel.org
X-Gm-Message-State: AOJu0YxIoJdG/fE0s7weVSoRFm0lEjgHG3hwz3HCuSE2jyuXGSD9XYkH
	hqisNcxAPLgKMOtoF82Q6JQ81H/UzHg16p7QHYox6GLhVstgGxpaxpZ9
X-Gm-Gg: ASbGncsgebxG1GfPWIYwHoSzlvLBekj95mnxXEQPt5UMliS//RbxnMHTXeEISjC8/Pr
	fg0avg+iNEaaBbi/Z6vEa7bDs1/WUR0rXrVmnXcsEUmtasupTJQWZ9QkDtVvoe+R8fX3MKGfRED
	80jotNT1lHkjKxi6Z9/BVR0pGaK+/EzbFoiv7N/4JEyo0F05bcXaatvYaIg4qfEuijrHRSEBJyk
	KnP6NbXVs0fGnzWfLvyQ7xSbsCkvwqxJ7VTQ+wJKrV0ZCLsa1w4+mAVngAb2CRTflZrWqHSWjEQ
	LYyjNyOjN48fNcQXl0fLATJ4Op3T3T9pBE+Bb+mOWBxSHySGnTZ71Qe5p9wqmLu25soAEK4GDio
	BU6xKiNS2++CXpN+0S09ePg==
X-Google-Smtp-Source: AGHT+IEirR7LYqR+fFzuvvVAzrXNJIleeo4MysPl+cc8TXzPeVFM2JO7Z8qqbWFRgPCVs7yzi1cjPA==
X-Received: by 2002:a05:6000:230d:b0:3a0:782e:9185 with SMTP id ffacd0b85a97d-3a4f895f857mr2550777f8f.2.1748798521105;
        Sun, 01 Jun 2025 10:22:01 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f9d6sm11890444f8f.84.2025.06.01.10.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:22:00 -0700 (PDT)
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
Subject: [PATCH v4 09/11] iio: accel: adxl313: implement power-save on inactivity
Date: Sun,  1 Jun 2025 17:21:37 +0000
Message-Id: <20250601172139.59156-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601172139.59156-1-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link activity and inactivity to indicate the internal power-saving state.
Add auto-sleep to be linked to inactivity.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  3 +++
 drivers/iio/accel/adxl313_core.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

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
index c5767d56b0cb..1598562a38e2 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -396,6 +396,7 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	unsigned int axis_ctrl;
 	unsigned int threshold;
 	unsigned int inact_time_s;
+	int act_en, inact_en;
 	bool en;
 	int ret;
 
@@ -431,6 +432,25 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	if (ret)
 		return ret;
 
+	/*
+	 * Set sleep and link bit only when ACT and INACT are enabled.
+	 */
+	act_en = adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
+	if (act_en < 0)
+		return act_en;
+
+	inact_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
+	if (inact_en < 0)
+		return inact_en;
+
+	en = en && act_en && inact_en;
+
+	ret = regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
+				 (ADXL313_POWER_CTL_AUTO_SLEEP | ADXL313_POWER_CTL_LINK),
+				 en);
+	if (ret)
+		return ret;
+
 	return adxl313_set_measure_en(data, true);
 }
 
-- 
2.39.5


