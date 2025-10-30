Return-Path: <linux-iio+bounces-25641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37670C1EBE8
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 882A24E752C
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 07:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B89833769C;
	Thu, 30 Oct 2025 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jvT92i5h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC9A336EF4
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809280; cv=none; b=nPrzuygp4ID/INjO4f/hhXHWYRSvv9ZNxJzEfd1Lo7n6xKttBgnpORGg/ikdc0reOo2OT6kvtaUyMBqw0JdRetGwzoYHW57agocI7WUpuSnrBHEgtZAjyaS2o1ynNQfdig6GN+YHWTLuTFzA/9htm1WlzKLGHk5QtSCZBUI5BPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809280; c=relaxed/simple;
	bh=5udrDdlPMpudCr1yZSepm0qaGnwL+JdHE+fbHDma8IU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ShjVmyRpXCiI7zWoGyH9zGVPSI4ySy3yIwxopaHcpfx6wp/M3vgzzrs8aBfmvvON9buTnLHnp4LkhV4dJG2nMbRrqn2slJbOfgwsg8XA/jFaHEAWGbWibUnjpJWQbN3GJGwg/B+aizquUD2ffY2jbT8cLNENCiYXXE6oQnQIA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jvT92i5h; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7042e50899so180224166b.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 00:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761809277; x=1762414077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehIJ73lPnu+6O4xgnu4sQPXRj/ZPgaqQ3z7fCTL7zhE=;
        b=jvT92i5hOIrKpmdg1Ur3ABKHHYr+LhqnfdYQthcg7iC3t6XGRh6DmNJ9n93US2Ff+0
         GOoVpQwosskQLScZ/8p+2VNGlctKDEheEuvH9aguzdlZmB5o9tP/pAtuOXOdAndfYeJH
         VNyTJiGN0wjX++MfdlXvwUXNU8yJTBQYlRHd8MFekdVr8+W1lq4Im3z+TPlL41biz+aP
         yoiynGW5rqOrqwMfTF2+UC9sCLdta3od9FReX1lIgXbOP8LsD19DPHTJlgxLOS1WVmYm
         ws37t9PhXv95Yn2nznx9gzoKaG2tJJu2GDFIs0ufN89lnCFkFzotIPjzwsescr2JgnAd
         b/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809277; x=1762414077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehIJ73lPnu+6O4xgnu4sQPXRj/ZPgaqQ3z7fCTL7zhE=;
        b=Qk2I2U9dVvkg3nUjaTOf+Y96QW4LhdokIIGHAbK7wTgvhCL2oglbt1ESMRzupaGJCL
         g8Y0HqV8DdbZlFNtUNocwuM5MflIZ34VLcP+XP54ofQW2BCFWzPOOvyzgxZ55ipV3KXH
         2+mIgGKXagoueKoaC+weB9MwrUq5rfeTfF8HOnAx+ypcPsTfFKRkJvTHxQBQjsQ/yk9/
         yO9scqyqfHrWSzBTaW2CMaHBKf0O8RLLyxNWL7a8A5v3QAjFL2ohHHcEZL3+V9q7zYrf
         bAhdClqASD/aaSgugeUATbaSbrxlldqiN4qz1cI7IUucglh82Z6/sF7mk/wCP30rHHNG
         MyoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUkq/iw0bKexpoMGb67jVgbQtbavLxEh4bgRdKqCBc4GeCWtPTdyEOXHBt1NHUsT0LTe+mS3SSGlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8jih2dj4Woqt94udj8QHtggb1HpH6bglLX01GsGgV6tgWIoQ8
	RpDxO2Xjj80Ztp2FgE7f4hR0C7X2BvrGrrvTLtnqB/dI+Qk26rwY8b06BvPY+7aBXRI=
X-Gm-Gg: ASbGnctH6EqRru3F7graCRzoH1GZCo91uhCLbAInwCkoaPjsDj/8V0wHtFYKhn7UTvO
	vkGsx+DLsvqu9HVLuG+6YAfYgDxssgl+L0+oZ5l+wfz69tsSPkRuhbdosIMOluGmzTGFRAPq0Vg
	ivwAxTGJPqQU0T5jk1v6Gngqt3zTyO7Zw2IUTDsuF6WYZrEL6l/7lY3E4K7ZJ6zyBv5dpfdgPYJ
	Dt+/MR6x0Y8p5p97mQP5rg4Vlqjf/1YaU0BoZA3husT/ejOOU2Ys5Qv5msUL48IzzkIVxZvs0G1
	l/eU4OyHImxJZiEKzTuVEmNcByPvw5Q/Es90oGWq+oVhN9tbxzh6Vcju4j08CFiA5WlHLeicWJ2
	WmSyjz3hcpTwi2/ezsMRTDcjuAqyAC9IOK6DDFeWBfNuqGuHhFiat9dKSvHVim84N+/g4PqDqkh
	NngOYC03Zu/zPhv7DKrOMFS1MriQ==
X-Google-Smtp-Source: AGHT+IEbm+Ph/BHY3X6rf2/ObAk9FRxDe/dtnkcM68DCMfwtCwzw/eavt2N/8WTvTK0XroSzL0OvUQ==
X-Received: by 2002:a17:907:3fa1:b0:b6d:6ae2:b66 with SMTP id a640c23a62f3a-b703d2f62d4mr544570666b.20.1761809277192;
        Thu, 30 Oct 2025 00:27:57 -0700 (PDT)
Received: from localhost (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85398439sm1682670866b.36.2025.10.30.00.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:27:57 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] iio: imu: st_lsm6dsx: move wakeup event enable mask to event_src
Date: Thu, 30 Oct 2025 08:27:46 +0100
Message-Id: <20251030072752.349633-4-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251030072752.349633-1-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7477; i=flavra@baylibre.com; h=from:subject; bh=5udrDdlPMpudCr1yZSepm0qaGnwL+JdHE+fbHDma8IU=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpAxNJUqwdeZd2hE7bzBsdS7ZsaGVJIXj6S1gwW zjdQ38hhwaJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaQMTSQAKCRDt8TtzzpQ2 X4seC/0YTo0aLdkslaQoGRrOIQuzRI+uwzb2ayKLfNeD6SWwEZtlcTvAVmMwFsk4TYnU6DrKrcF yrPe/XiYDq+NYjgM43qBOxdUoIrdyd6lRmc7kpw3YuVdbi0MlFYtn1nb+eF8q4c8EKIxaywxi+d kE/349O5UhcRji18ZQvhdChVDR2DoqXKhHMek2ro7JxGxu5azF9Pk+Fnq6Gqtw/IGB+4R9lNj3F /PI88/j9Gl80stNv8Z2fKavy5ISg36zevNUAgEQU+j8+0EfscDUnNHKtx5PKfuSmbavb9lGfize 8kOTPAH92QSLdI2yLUJri+VdQ2Hd8TRUJfpuSqGZotZWrBLWPLoVUMnwbURcjaXtC7hS8VC9vyS zVyWSvl84WgtAIhFbgt+/zVezCWEN3LWLZDoBULPWqpMMfelgmkeSg+dEdCDYXXKSpLy65OjF9r qG10M91YleUlgyNRJzL2M2qVBtO8syciMVNF5v2CgRYBOG2eQqMucAGdWjLFTqZPKxha4=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The mask value being assigned to the irq1_func and irq2_func fields
of the irq_config struct is specific to a single event source (i.e.
the wakeup event), and as such it should be separate from the
definition of the interrupt function registers, which cover
multiple event sources.
In preparation for adding support for more event types, change the
irq1_func and irq2_func type from an {address, mask} pair to an
address, and move the mask value to a new field of struct
st_lsm6dsx_event_src. No functional changes.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 80 +++++++-------------
 2 files changed, 30 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 05689887f7ec..5c73156b714a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -228,6 +228,7 @@ enum st_lsm6dsx_event_id {
 
 struct st_lsm6dsx_event_src {
 	struct st_lsm6dsx_reg value;
+	u8 enable_mask;
 	u8 status_reg;
 	u8 status_mask;
 	u8 status_x_mask;
@@ -320,8 +321,8 @@ struct st_lsm6dsx_settings {
 	struct {
 		struct st_lsm6dsx_reg irq1;
 		struct st_lsm6dsx_reg irq2;
-		struct st_lsm6dsx_reg irq1_func;
-		struct st_lsm6dsx_reg irq2_func;
+		u8 irq1_func;
+		u8 irq2_func;
 		struct st_lsm6dsx_reg lir;
 		struct st_lsm6dsx_reg clear_on_read;
 		struct st_lsm6dsx_reg hla;
@@ -420,7 +421,7 @@ struct st_lsm6dsx_hw {
 	u8 ts_sip;
 	u8 sip;
 
-	const struct st_lsm6dsx_reg *irq_routing;
+	u8 irq_routing;
 	u8 event_threshold;
 	u8 enable_event;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index bb4c4c531128..4bae5da8910e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -290,14 +290,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(0),
 			},
-			.irq1_func = {
-				.addr = 0x5e,
-				.mask = BIT(5),
-			},
-			.irq2_func = {
-				.addr = 0x5f,
-				.mask = BIT(5),
-			},
+			.irq1_func = 0x5e,
+			.irq2_func = 0x5f,
 			.hla = {
 				.addr = 0x12,
 				.mask = BIT(5),
@@ -356,6 +350,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status_reg = 0x1b,
 					.status_mask = BIT(3),
 					.status_z_mask = BIT(0),
@@ -454,14 +449,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(0),
 			},
-			.irq1_func = {
-				.addr = 0x5e,
-				.mask = BIT(5),
-			},
-			.irq2_func = {
-				.addr = 0x5f,
-				.mask = BIT(5),
-			},
+			.irq1_func = 0x5e,
+			.irq2_func = 0x5f,
 			.hla = {
 				.addr = 0x12,
 				.mask = BIT(5),
@@ -520,6 +509,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status_reg = 0x1b,
 					.status_mask = BIT(3),
 					.status_z_mask = BIT(0),
@@ -648,14 +638,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(0),
 			},
-			.irq1_func = {
-				.addr = 0x5e,
-				.mask = BIT(5),
-			},
-			.irq2_func = {
-				.addr = 0x5f,
-				.mask = BIT(5),
-			},
+			.irq1_func = 0x5e,
+			.irq2_func = 0x5f,
 			.hla = {
 				.addr = 0x12,
 				.mask = BIT(5),
@@ -755,6 +739,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status_reg = 0x1b,
 					.status_mask = BIT(3),
 					.status_z_mask = BIT(0),
@@ -895,14 +880,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x56,
 				.mask = BIT(6),
 			},
-			.irq1_func = {
-				.addr = 0x5e,
-				.mask = BIT(5),
-			},
-			.irq2_func = {
-				.addr = 0x5f,
-				.mask = BIT(5),
-			},
+			.irq1_func = 0x5e,
+			.irq2_func = 0x5f,
 			.hla = {
 				.addr = 0x12,
 				.mask = BIT(5),
@@ -990,6 +969,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status_reg = 0x1b,
 					.status_mask = BIT(3),
 					.status_z_mask = BIT(0),
@@ -1106,14 +1086,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x56,
 				.mask = BIT(6),
 			},
-			.irq1_func = {
-				.addr = 0x5e,
-				.mask = BIT(5),
-			},
-			.irq2_func = {
-				.addr = 0x5f,
-				.mask = BIT(5),
-			},
+			.irq1_func = 0x5e,
+			.irq2_func = 0x5f,
 			.hla = {
 				.addr = 0x12,
 				.mask = BIT(5),
@@ -1169,6 +1143,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status_reg = 0x1b,
 					.status_mask = BIT(3),
 					.status_z_mask = BIT(0),
@@ -1279,14 +1254,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x56,
 				.mask = BIT(0),
 			},
-			.irq1_func = {
-				.addr = 0x5e,
-				.mask = BIT(5),
-			},
-			.irq2_func = {
-				.addr = 0x5f,
-				.mask = BIT(5),
-			},
+			.irq1_func = 0x5e,
+			.irq2_func = 0x5f,
 			.hla = {
 				.addr = 0x03,
 				.mask = BIT(4),
@@ -1373,6 +1342,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status_reg = 0x45,
 					.status_mask = BIT(3),
 					.status_z_mask = BIT(0),
@@ -1825,10 +1795,11 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
 {
 	const struct st_lsm6dsx_reg *reg;
+	u8 enable_mask;
 	unsigned int data;
 	int err;
 
-	if (!hw->settings->irq_config.irq1_func.addr)
+	if (!hw->irq_routing)
 		return -ENOTSUPP;
 
 	reg = &hw->settings->event_settings.enable_reg;
@@ -1841,9 +1812,10 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
 	}
 
 	/* Enable wakeup interrupt */
-	data = ST_LSM6DSX_SHIFT_VAL(state, hw->irq_routing->mask);
-	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing->addr,
-					     hw->irq_routing->mask, data);
+	enable_mask = hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].enable_mask;
+	data = ST_LSM6DSX_SHIFT_VAL(state, enable_mask);
+	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing,
+					     enable_mask, data);
 }
 
 static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
@@ -2097,11 +2069,11 @@ st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
 
 	switch (drdy_pin) {
 	case 1:
-		hw->irq_routing = &hw->settings->irq_config.irq1_func;
+		hw->irq_routing = hw->settings->irq_config.irq1_func;
 		*drdy_reg = &hw->settings->irq_config.irq1;
 		break;
 	case 2:
-		hw->irq_routing = &hw->settings->irq_config.irq2_func;
+		hw->irq_routing = hw->settings->irq_config.irq2_func;
 		*drdy_reg = &hw->settings->irq_config.irq2;
 		break;
 	default:
-- 
2.39.5


