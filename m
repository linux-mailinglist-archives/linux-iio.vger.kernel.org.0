Return-Path: <linux-iio+bounces-19847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1F1AC2BE2
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 00:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21A8168735
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 22:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9C12236E9;
	Fri, 23 May 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV85DUJy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0AE220F3B;
	Fri, 23 May 2025 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748039768; cv=none; b=nOLM86+Y/ITaRF2cUeR+SwpJ00izPa01ld360v8KPZ/GfJrYRiHGFvdGbyGBcspTKKA/acFytp3eJZ+/A/t0LQ9WV4ZNGkLoM/Q00PIHTIv+w0162Cil6/+RpaLfFEbcYr7ZIgm6HA0uSEvOgBOuWH8SZfniKUR9A2biLLFXfxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748039768; c=relaxed/simple;
	bh=I+PnDm6H8/jBkFcjQxYjEBoWwmJ+zcAiXJu3OIhU8hI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ocjT+7tgDzcq7r+N+cVs7BMknF7bQ25Yo3I1KNk6B7PiPj4x6a5+napcAEtuh8Y96cAQ41/hrGrgMAWv+AY+KXJYezFp1u1b3sIB6mTHeGOPqOSPHUnQ3g2QJizVAuyztRbYy/frcpYit9Zr0w1WQI3H6gXz1fdDV323xHKR8vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV85DUJy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442ea0b3a9fso47725e9.3;
        Fri, 23 May 2025 15:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748039764; x=1748644564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti+cdAqOo/stvgDloRTUlHozi1vVcIkI87kvtC/UaoE=;
        b=PV85DUJyaVfVT61Su3kitWpKa9H4CGeKoODmvKNViQhtppaN0Sc6X6PFaP9QD5J9mB
         CYVI9NZtfWoUUqH9Tr516h8fcYwiJtaWDyxfcnehbnTAfiowedRBO/0tsIstOKF1y4fV
         jbE9bLBolJJrX494apYXIaighZhfo0spYjPhSJihdhomh32P+Er0PjE5I36WYYm+10+C
         muhbRQ3amcwCSUBTHreJEhUMFm+ydb165KeVenCofq1/f48VBCOfymKXn6tRuBl+tcRB
         nMLy3NVqvzymHFfeBLbTbeDdHCX9cGrQNLiO9ww1v/syxv/Y2AIzi1fU7IEXdAxb32+G
         eDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748039764; x=1748644564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ti+cdAqOo/stvgDloRTUlHozi1vVcIkI87kvtC/UaoE=;
        b=qnAdKM+z7ECe70fN2h/kKVtKpzsXWI59yfGqUa5DE9bI7mdSumnFZBg1G+nz/6JuiS
         y9l/MQQOFERxBG0NiyzZNuF7I70/gmK4ycZAQyty/073Z/AjDbF0a/y9s+tjnzKhjadK
         4emTv0X4MWsH6IUbwNeyNGQ7rzpTfHDooDbDzjSmgzeCUZ3eHS0UimtfQw6oLR3+fNDq
         7vOp6gDnk1aklAnwKY5KR8ICoXn38Sc2R3GWCDr0Wmr5GAnsSqSEmVfPezEbLkMWIGd6
         u+pb2EAFdmu/+m+bBs0VG99VdMdwQuswKYqDbzRg4hA5/jysrU2hRHZONC//eGauJHoj
         G05Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzD3PgwbteWf577kZYGBSDFAQA7b6NKDMNse1G0r32g2+bI4WB1CCYTQmUwth9RhQb1J4LEHJcY3bTneaO@vger.kernel.org, AJvYcCVQtiI9JSxpr8nLNCtGxX6n5Fe9L3Xt42X/oQd9pls8ZdnkAJgv7mp5xOC7VLUr7/WxFIC9yBPh092a@vger.kernel.org, AJvYcCWIVpyIvR/JxscSZKPQpuEh4rEctya22mTeTj2e1sVNwSB0J1P/EQqe+uXpQ3P2td7oISkKfSP1uWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIznLUuH7UgajwI5ogZMW3amF9i+kXbg5FxTmIG9fIT5evi+J
	bJ631QDEaELSGygvouQRvlASPKsvdrbLs8flt3Czh9cn6sNa65ocO2Ij
X-Gm-Gg: ASbGncuB5kQLHI1f124efh3KmhekWSpJbhLkqlGtckX1XaMNhbq9gksfcmGAexdSXcn
	7Rmga0xauOXPu8cK8CbB9vgThSB/MMmguLhMqyAMpP3ZsxlhZYpOyG3Dj2t4xGQeZj0M5LagjrH
	T+9s1KbHpy31Ijp1fN/zuM63v3vGNQZb6y6AYph6jaV/G7S87b6PEDI825mUX6Y2cHlQw26fyuN
	Ue9JFrliWd9F5i1dapG2fkwco3fV27tVkJiBjPJ6fu6wRJwAeifO8bmSELyntapLRqX0ilOhvns
	PTMA2On+rz+75BDiEyx5ic7oiaW+fPk+Zv7/sa2rz93RaKXL0ZHFPSnurADB/0SzIwAFFjVSo2I
	gIhEKg4tABR/u7GJphJ4Rxg==
X-Google-Smtp-Source: AGHT+IEERTakfGsFOX5MjIHTSn/ZsxKGIQxbGSCnDll2uuCPr2t83WCklogrumBHfeWehOrSFveslA==
X-Received: by 2002:a05:600c:1d20:b0:442:fff5:5185 with SMTP id 5b1f17b1804b1-44c938caf60mr2256815e9.6.1748039764536;
        Fri, 23 May 2025 15:36:04 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm165202375e9.3.2025.05.23.15.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 15:36:03 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/12] iio: accel: adxl313: implement power-save on inactivity
Date: Fri, 23 May 2025 22:35:22 +0000
Message-Id: <20250523223523.35218-12-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250523223523.35218-1-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 25 +++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 374e4bfe6e05..fae2378fa4ed 100644
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
index f7baca814da7..d65380901f66 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -389,6 +389,7 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	unsigned int axis_ctrl;
 	unsigned int threshold;
 	unsigned int inact_time_s;
+	int act_en, inact_en;
 	bool en;
 	int ret;
 
@@ -415,8 +416,28 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 		en = en && inact_time_s;
 	}
 
-	return regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
-				  adxl313_act_int_reg[type], en);
+	ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
+				 adxl313_act_int_reg[type], en);
+	if (ret)
+		return ret;
+
+	/*
+	 * Advanced power saving: Set sleep and link bit only when ACT and INACT
+	 * are set. Check enable against regmap cached values.
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
+	return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
+				  (ADXL313_POWER_CTL_AUTO_SLEEP | ADXL313_POWER_CTL_LINK),
+				  en);
 }
 
 static int adxl313_read_raw(struct iio_dev *indio_dev,
-- 
2.39.5


