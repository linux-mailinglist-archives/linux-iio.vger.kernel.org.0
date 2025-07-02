Return-Path: <linux-iio+bounces-21276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49009AF6604
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453C5188DE97
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533972F7CEC;
	Wed,  2 Jul 2025 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcCOo5Hz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC052F6F8F;
	Wed,  2 Jul 2025 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497714; cv=none; b=lEW2Lfo+O/4l9uwOoooLxJlFIe/lUFAPpg0BR6J2h/hBODhjAGz5Yr/JVuwnWbzwr/3u+ku7wqGOMh/VcZAVbVqsS+0h+ZBMBv6cgta897EWnBTZyJMYtzbWE3H5nwxfNipxEXTSo64qyZxtd3c+rBPsmPjwYwt3n7jYCArUz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497714; c=relaxed/simple;
	bh=wKtvDQZu6l90x2OlmiXHmRu8/yrPWXsTFGnokuDXXGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TbqHmenVIu5yhrV4xLx7EM+YgNSLJSP7Ct86q6OEYJmJ2b92bYUBXr/fKT+6VJ19yjpkKB97xoGOwgwSAvYJv0NYPshtkngMI1dv/vPOTvgvGq4AqzVXeia4ZmvoHPhPZ9P+JaP1GTXtqizpa6hMogW3HQ+XwxzDZKAqpUgKJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcCOo5Hz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0cee8c1d2so101259466b.0;
        Wed, 02 Jul 2025 16:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497711; x=1752102511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6aGXjZeOxHiO0bsZaqRt7xOA1xwQMEIOJ9yT+ooLKs=;
        b=GcCOo5HzYIzNbZ8IIv4pkig62mMODMWdmUSxCqEAk2/Rrzd2V54uDKdTJoh1/CHSMP
         1Fp26qXBJ6836+bZt5vICQPQ+oISDz3NeegtjZs95Skk98EexnJcMda7DAnrIlZMWUpa
         uUTxalVE3e2wm+5aSZtXMVpECowkonMGHKo8NgNefgYVjwRtUr112UMa9cc/C9IwylDo
         w9MpDSbyzSCkgXdYb2W60U5mKGthO59cCuoZJ3zuVvPtm1VydoBSOU/ysC/EP06UMpak
         8elSGo915FRXz0oxAXW2qxslcPGb1eWN5tAzRqObGR9VsWw+N85Lgf+GVWPt+7OQBgKN
         4XHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497711; x=1752102511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6aGXjZeOxHiO0bsZaqRt7xOA1xwQMEIOJ9yT+ooLKs=;
        b=DaylUJGqj94hMNfUoDlD7C+gXwFtlUwe/rBwK9Hw2shEIH4Allx20jnp/kVHjrJfwE
         O3wYKX6ZseNkMrWztXrKHDJILyFLZlDVCyXTsIsTabdFA2zoi9l2UjjST8HZJ0yhOhas
         wbWg7dRGYKGbEQODC7j6UdFHiFkGZ6pOGWvyM6v08TdWbx3HZ0Bcu6M83BvFT2tKusKk
         eZ5UY6x8qxR+1XcCGHfwzkP/PlWbSPStC8qxOlU4+WNfvG21UNIZ0ZKm0LnzxMHpR1I9
         DW2LI2wov8k3XbagI7QhA9S+qgPvKBt6CmrXRbrZPFkyDbCiq1Q3D5B+YChcBK5iitXh
         rm+A==
X-Forwarded-Encrypted: i=1; AJvYcCUsZaojFy3pwVLkpvbxKlVq89rIbivg2EsqbwEs0YlFUBisA9saofCo+uLfLLeiyYKpLx5GfTwdVPQ=@vger.kernel.org, AJvYcCWZa8qavyVglQXVdevj58y7JERCG/AH1fpDbhC8PWv64C8IuhebtDcsGXhotV5WVXstSZKYzqGCz+3K@vger.kernel.org, AJvYcCXdNL8/+01DA1iGBCOM3nCTOeh7G2vqoIkDyO4Ofr7D89Vkda2SQ0FIWrN7B3YmAnbSWS81c85NHXHr5k4l@vger.kernel.org
X-Gm-Message-State: AOJu0YwplDRW587t28kZZUY67brIwBIquVwh+ZktCDnmzakoFk7FyBBu
	zJNmHSpLVn+hzjkisM9s4YSFs0re+FJmGKVt22+dvBN1vqDxio3emB2d
X-Gm-Gg: ASbGncu7ag8wzBvDjStQTnWl0hE/iBilVU9+a4CQ2qYLzjGLndc3QRc4dZ6WV1ahy41
	OaBR+PKNt1v89X5ie5PlLg2t4nQAZa49q3Vqfq+Sc6jd9ARaiwDVZW2VH8tjtjqiTUbBLzuvliG
	C12RPt3tYI0IGFmrzHUZD2KNxkkCT5STw3Uj6aofDoYfQw/NFN7MbtZdYKHAbmrd2/fhwSi8qvW
	/vtM49oEpsP4Y3pgFIY64CaUbLf51ZDoR8OQ67iLNtzNlmes2g5czCW366hzaeqhxSph/RyR+EU
	goYbMUGrmJyXeD6RBW7/C+Ec7FgPCz7F/HBgeWlR+R6QbcU+v5FuVo2tOu9EOQgVutcovHLslJP
	tbOHHK1WWef8hvyLsR7TA21SNU4yalsRH
X-Google-Smtp-Source: AGHT+IGK02e4+cfORuOqUVEs88u/QXgtzUIE7b+MGx4nG0xOy+GpaM/2uaZo88uzA5B39T+ZbiKELg==
X-Received: by 2002:a17:907:3d8b:b0:ad8:aa3a:772b with SMTP id a640c23a62f3a-ae3e288cd07mr5314166b.15.1751497710543;
        Wed, 02 Jul 2025 16:08:30 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca18bbsm1158355566b.151.2025.07.02.16.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:08:30 -0700 (PDT)
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
Subject: [PATCH v7 6/8] iio: accel: adxl313: implement power-save on inactivity
Date: Wed,  2 Jul 2025 23:08:17 +0000
Message-Id: <20250702230819.19353-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702230819.19353-1-l.rubusch@gmail.com>
References: <20250702230819.19353-1-l.rubusch@gmail.com>
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
index e904dee4dc2b..df10dc430e1c 100644
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


