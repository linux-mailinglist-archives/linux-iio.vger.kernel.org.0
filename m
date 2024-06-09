Return-Path: <linux-iio+bounces-6114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38EE901813
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 22:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D53281599
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 20:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1E54D8BD;
	Sun,  9 Jun 2024 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fyyzpM1q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9075947F60
	for <linux-iio@vger.kernel.org>; Sun,  9 Jun 2024 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717963587; cv=none; b=kaNGTW6/KE3xEg6JTj7qg4J41VRZiGM3Q5YI/apjM58ql12182jRruH8a0H5iju0vEUI7w+bGHE1mEYtuGuTvOYzpxpSazS08pNhMYxShe8pQWfhzkR904tgsbJZ1z8hcH/mrQSwT22kfcXYjPlRCh5BssnaQ3UbvqEHSHdCrZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717963587; c=relaxed/simple;
	bh=OQ8LIfPXu3hLpWk0qkAUgzkjoCV+/oOpWmGnaf7E7Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIFixqTocXGUl/aFyGE8t+YvP30BpelFlfZIjvM1XgTPBVd3InF0TIjmzQe6Rg4crTfj4CoZgnAf8ZEBS6Ov5WwiWTFXRueHgALc6SqtlkIo3w2ELZoHereqVvhJyEASAxWWsNO5kGqlgwdmnEewQp3nD3frZ4EEF4g80o7mNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fyyzpM1q; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b2e93fddafso1727746eaf.0
        for <linux-iio@vger.kernel.org>; Sun, 09 Jun 2024 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717963584; x=1718568384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYKfigbf7VqwLqv7HhequLfARQ4HkFaCIDWgcDYu/E0=;
        b=fyyzpM1qJH8vd7WMvjO02DuGSo7qU/VBMKL6bzPRk99FYDozEfzp3CSWQK4Jv5TJEj
         ArH8GdfmERhvuuEDEs8PFJfkRoJJEuXT/JPEZanbK7Z4IKjiCbciLuxmIoj4orhpHFIu
         JZWYSrLXCrcMdXBQ4hrtVGgcqyb5mqeUdFoBQHOdNEXT8xuf2WA2CKBIMaRs6DZG/t/x
         gVI8oO4j6uN8BY7kIY54VADF/tDA4G57ka2wWdePXekLpqek0FfDFHX9249gvjIFZrZx
         K+wjvshXzbKpmahSjSCBmax8VZc6EJHg6QM2FwO/QPasX+bHJf30KwNYpnHG3NHpiggO
         87sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717963584; x=1718568384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYKfigbf7VqwLqv7HhequLfARQ4HkFaCIDWgcDYu/E0=;
        b=fPTaLs5ZkB1VZS/1fSs1DkgLeorBW3wX0bd9KAe6914DyBv6a5CRwh/Os8b1PfXOA+
         yagBmaEWyVtMEYv8ipbGVoZ8evK6UEb4jfiAACT2mQ1PmEqGy1AepsaEmpfPahZHIvzZ
         +if5N+5jH5VXNlRNxTNUXPomI9Bgjdlqkre4Ok1F5VUombxMUTEQp4Q8P2l9CWNoH0PT
         yq/EwwCWNVHr7J0WFLoifynKWsE2NIzX1bW5S5PAQv7mAGouQw0vrEpkHSfDnW3ox/88
         Zo3dPi2Z/zV3sZWjRiPD046lG3mNXtNAXfduDYRh7kYhFUyfV2xYtkzZKwal5k863uf9
         ggMA==
X-Forwarded-Encrypted: i=1; AJvYcCXxtiAwp3unaf+XHwRGJNR1vbbnt2lQ0r2FJUo+0m9b5NBq9E/Pf2OS5sbcn9avnKr69uHgMQokMY4hYs6sUsrzXo7huGAlcAgE
X-Gm-Message-State: AOJu0YzfU/yGAA0Uj4LZA+NT43VK54WZh0L1eAoyt9EtkL7Gl7GJJ5qA
	IdDi95KskkXBRmkdHsbRMsPIDyMIKYKZq5Z4jmLLbT9QSFVVWJylSkTmDnGKuOE=
X-Google-Smtp-Source: AGHT+IE+Q6PIYzDdNSoHQfMEgTJPKdEnjFwglsLO0gEt7q/0j56YXA/CnyEa9tPCeZtPIufEStcA2A==
X-Received: by 2002:a4a:bc01:0:b0:5ba:8ac1:3a29 with SMTP id 006d021491bc7-5ba9151ae64mr4996042eaf.1.1717963584573;
        Sun, 09 Jun 2024 13:06:24 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba977e121bsm1413278eaf.28.2024.06.09.13.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:06:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] counter: ti-eqep: remove counter_priv() wrapper
Date: Sun,  9 Jun 2024 15:06:16 -0500
Message-ID: <20240609-ti-eqep-cleanup-v1-2-9d67939c763a@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240609-ti-eqep-cleanup-v1-0-9d67939c763a@baylibre.com>
References: <20240609-ti-eqep-cleanup-v1-0-9d67939c763a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The ti_eqep_count_from_counter() function is just a wrapper around
counter_priv(). counter_priv() can be used directly, so we don't need
the wrapper function. Remove it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/counter/ti-eqep.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 30c35b6c6050..924e379303dd 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -86,15 +86,10 @@ struct ti_eqep_cnt {
 	struct regmap *regmap16;
 };
 
-static struct ti_eqep_cnt *ti_eqep_count_from_counter(struct counter_device *counter)
-{
-	return counter_priv(counter);
-}
-
 static int ti_eqep_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 cnt;
 
 	regmap_read(priv->regmap32, QPOSCNT, &cnt);
@@ -106,7 +101,7 @@ static int ti_eqep_count_read(struct counter_device *counter,
 static int ti_eqep_count_write(struct counter_device *counter,
 			       struct counter_count *count, u64 val)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 max;
 
 	regmap_read(priv->regmap32, QPOSMAX, &max);
@@ -120,7 +115,7 @@ static int ti_eqep_function_read(struct counter_device *counter,
 				 struct counter_count *count,
 				 enum counter_function *function)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 qdecctl;
 
 	regmap_read(priv->regmap16, QDECCTL, &qdecctl);
@@ -147,7 +142,7 @@ static int ti_eqep_function_write(struct counter_device *counter,
 				  struct counter_count *count,
 				  enum counter_function function)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	enum ti_eqep_count_func qsrc;
 
 	switch (function) {
@@ -177,7 +172,7 @@ static int ti_eqep_action_read(struct counter_device *counter,
 			       struct counter_synapse *synapse,
 			       enum counter_synapse_action *action)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	enum counter_function function;
 	u32 qdecctl;
 	int err;
@@ -249,7 +244,7 @@ static int ti_eqep_position_ceiling_read(struct counter_device *counter,
 					 struct counter_count *count,
 					 u64 *ceiling)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 qposmax;
 
 	regmap_read(priv->regmap32, QPOSMAX, &qposmax);
@@ -263,7 +258,7 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
 					  struct counter_count *count,
 					  u64 ceiling)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 
 	if (ceiling != (u32)ceiling)
 		return -ERANGE;
@@ -276,7 +271,7 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
 static int ti_eqep_position_enable_read(struct counter_device *counter,
 					struct counter_count *count, u8 *enable)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 qepctl;
 
 	regmap_read(priv->regmap16, QEPCTL, &qepctl);
@@ -289,7 +284,7 @@ static int ti_eqep_position_enable_read(struct counter_device *counter,
 static int ti_eqep_position_enable_write(struct counter_device *counter,
 					 struct counter_count *count, u8 enable)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 
 	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, enable ? -1 : 0);
 

-- 
2.45.2


