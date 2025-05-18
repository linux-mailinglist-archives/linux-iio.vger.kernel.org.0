Return-Path: <linux-iio+bounces-19626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFEFABAFD6
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 13:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E3B172311
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 11:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB6221D3DF;
	Sun, 18 May 2025 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdJRS3HW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009A21D3E6;
	Sun, 18 May 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747566830; cv=none; b=CWlvBDrE16urbrj6VmCRSwhHWUc/HmHlsbKb+tdvN/UCVfniD+dlW/4Q2/To5bOw9g6VKFsXKnLOku5beNpTlZhSS6xXLl5go4tOah6/Ar0OstVGwI6HARbopviwRBelpwpmnIhrXw/PZBxELzNbAzbhNJNp8oUtI08LnEal6WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747566830; c=relaxed/simple;
	bh=AQgWRZ+bNmb6VNtMYMD1eQK2L/bmoVe/hTRUpXwNIBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rlBOyOIeadnXy39rEJJVI1RMIZ2Kt7PNYFOr9WFY5RykR8Z46sATu91JYukgpH4sX+DZbeIVb8qeYebdT6YC5tatM1fA7muea0CAL9Ag4IshpBc2l5ywsp8f6b3Z+cf4tAPyD1dTyVED8Z0CwN1o4j0b95IQdTJbQM/Km3ttTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdJRS3HW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a36977f261so113128f8f.1;
        Sun, 18 May 2025 04:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747566827; x=1748171627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1drZhJrDbb5wAe1X2U8L5IB9vNXA2H8lOJZnEvsQ7A=;
        b=RdJRS3HWQiJEWmaZ4FHCnJ2Hp6koDBaY+hbzgj/AWVwwDydur10o6EfNkAn6dNX/Nt
         ZqegqyOhh7zbFimTPsTkvNmCm0lsYsGe/XoeDXbugh08EwVb+4NOTq8skUEt/VwgGlS3
         V3RwEjHA5NgLR5N8li2Z2mCwDa8c+zZSVbdMN9VCqgsVCN325KIhj3fXmJ3UZP1Xa6jt
         sYE3QCbPDytNsbHAWjsqkNHu52bImqyoEyDyLiWJeCteh4rvxMGRYLgOe6A5ESUaxnT+
         XC0mvGNBwuxGqSn9C5WEPqg7vixtCBg6+dtrEHgKRXevm+73NPNQ6k3Vsj2wXysLcbr8
         rUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747566827; x=1748171627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1drZhJrDbb5wAe1X2U8L5IB9vNXA2H8lOJZnEvsQ7A=;
        b=CaH9F5Sn9avI0ybNBdkCseBHsriz19rfhlj1lwvAa3vxcwO/LnyIZIOxEnFv+d92G0
         I/UGWefLdUVVjqvgdZ1Ir4RCtN7nj47ihzSaNMPsAE6I8qxRyGcoQ2JYB678i9jUNMrq
         ig1XK/ye8XgfLupBVguopKkWOwTo3Vb2Zfw4ATnBIbK17kziR4osiyvQPqs1m2XnIXTj
         TFZ3Q/l9T8IseuaojR0DdKP17SeyyCtc7jBHAePCAMqpyPV0nJ0v8ulFMRPWMXmFvz6k
         UtXZbNJexIxhX1kaAAr8N+YG7qtstqL8tT1DpImX6nwBvsYD7C3Kk/Rkw+hyFM9et8qk
         NBJw==
X-Forwarded-Encrypted: i=1; AJvYcCUD0crVKnYWfTgr0jnSRCCWslBLBBM4ZxovLmCL691nbYrxAofnxRCG2JGHc1iSSwhGkw/vts0ulO4=@vger.kernel.org, AJvYcCW3zw7nmmKp01rhshlbrsacb4XwKE655VoSMKeEDNBTmcznFUI0cmXVvyo6GEKptoYBxsUziGZleXY2F5Lf@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9ytEWe/6q1aSXXnDb1onIxgmr+H1kVFZ/Ncgftfw6A2QhFSS
	SPEDDmmU0EmwH1mQUbTOXiSrQWKLtiEcuWhh4OJmc5KP4wkm3RzwdIRW
X-Gm-Gg: ASbGncuCknrUcLDEXPsUbf5KUt3GubvTyJw1Plm8JnA8B3ET649LT1fnRzwMDOOalCO
	taM2m5SKlDluRfRuvQUgs8CG5hJBSLOjkkQLJbEIgmtTio8kq/p80EAjBip1BN3ck5hKHZWqUH9
	mxEdrrm9UAuwUhEjE9v5w/nLAoCRJ9rADRJnA2pC+G1RfwtSp2/cxaiwfQCf2rb0Y6aYhnjD81T
	6/KLzu4J+QHHIxQP9Y562ViUN6egi6JHiTpk0ocQXagUl0N9Ly/lfAsReE3ccvhu8pdwfVOmV+d
	JlJ+qgGAkl7i3UblYi+mK0OA5yuBP/GrDQfDiEMN/L2mpuB55gHGzdzn8hM9BAUMg39+9h6eXtK
	5h2QlmXiG4YkBKZmgtt4IRA==
X-Google-Smtp-Source: AGHT+IEliM0EwzXhTiOaakSADoBSFwrmUOdk/p4CPfoz42kMheZRwHMXkLfeJtvTHvd6xAy26ov+GA==
X-Received: by 2002:adf:f10e:0:b0:3a3:5c8e:2d8d with SMTP id ffacd0b85a97d-3a35c8e2da0mr2877447f8f.0.1747566826697;
        Sun, 18 May 2025 04:13:46 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm9287446f8f.18.2025.05.18.04.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 04:13:46 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v1 11/12] iio: accel: adxl313: implement power-save on inactivity
Date: Sun, 18 May 2025 11:13:20 +0000
Message-Id: <20250518111321.75226-12-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250518111321.75226-1-l.rubusch@gmail.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 1398ac54d19b..eafdf8f57816 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -41,6 +41,9 @@
 #define ADXL313_RATE_BASE		6
 
 #define ADXL313_POWER_CTL_MSK		BIT(3)
+#define ADXL313_POWER_CTL_INACT_MSK	GENMASK(5, 4)
+#define ADXL313_POWER_CTL_LINK		BIT(5)
+#define ADXL313_POWER_CTL_AUTO_SLEEP	BIT(4)
 #define ADXL313_MEASUREMENT_MODE	BIT(3)
 #define ADXL313_MEASUREMENT_STANDBY	0x00
 
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 46ca30abc7fd..aabb4a1b9b9b 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -392,6 +392,7 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	unsigned int axis_ctrl;
 	unsigned int threshold;
 	unsigned int inact_time_s;
+	bool act_en, inact_en;
 	bool en;
 	int ret;
 
@@ -423,9 +424,31 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 		en = cmd_en && threshold && inact_time_s;
 	}
 
-	return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
-				  adxl313_act_int_reg[type],
-				  en ? adxl313_act_int_reg[type] : 0);
+	ret = regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
+				 adxl313_act_int_reg[type],
+				 en ? adxl313_act_int_reg[type] : 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Advanced power saving: Set sleep and link bit only when ACT and INACT
+	 * are set. Check enable against regmap cached values.
+	 */
+	ret = adxl313_is_act_inact_en(data, ADXL313_ACTIVITY, &act_en);
+	if (ret)
+		return ret;
+
+	ret = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY, &inact_en);
+	if (ret)
+		return ret;
+
+	en = en && act_en && inact_en;
+
+	return regmap_update_bits(data->regmap,
+				  ADXL313_REG_POWER_CTL,
+				  ADXL313_POWER_CTL_INACT_MSK,
+				  en ? (ADXL313_POWER_CTL_AUTO_SLEEP | ADXL313_POWER_CTL_LINK)
+					  : 0);
 }
 
 static int adxl313_read_raw(struct iio_dev *indio_dev,
-- 
2.39.5


