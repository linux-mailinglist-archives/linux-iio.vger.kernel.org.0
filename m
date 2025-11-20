Return-Path: <linux-iio+bounces-26331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DCAC72E65
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 09:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFA3A3593CD
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E33930FF31;
	Thu, 20 Nov 2025 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KHKZD4ME"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFFC30E0FB
	for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627184; cv=none; b=QJXKK86ErnE3if4VSr0YYivjJlhPrj2da7RAWiDA9rPTrmbGBRvVdjOR4qoQUQOWYrIIVUbxEpvq3DB0jlhO7LkF/GXdg0pnxOKZ0n3YGKunIVWgyclPALH7iPegfi8lAwXzXWpThR5MbMJm5vrwbLZPHxj1m7HgQb+xEvXwo7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627184; c=relaxed/simple;
	bh=W7dRYFBp5zbk0lTntGV+cJ+DU2JAhLbFX8VsL4eBjeo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YijLlCZgGlbrsMSY11WQkAr5jjq/IJ9ic8jvUi6OSSoAwa648FRKPySEMvqKuX0H2jVuHgrVSptrGE5JCoWru0+3BUIKX7f7BtKBZK27YBd8GH7t/AkdP8yo7CzDI6HuzBHa9lFUIrkkJXjAI72WxsFgIJeiz98UsKX0zfHTnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KHKZD4ME; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477563e28a3so3826765e9.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 00:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763627181; x=1764231981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PnQ4g/3MCD+/CeDtkg6cQ8hBr+h2xXlLFe41ou95fQ=;
        b=KHKZD4ME0utNLFid9hCZvDQtFKdqHox2TzKuROM6s5NQt8Ov+OBIPW3CqfWxkiF3yu
         RQaY5eyE/7RymOwDdGEa5CJPpj3l3/e6M83PZLetgrTtsRWtUVKpxMJaeUKp8cMwCSdG
         zQhcEg9wZfOeeNA/E4NKokDWbgZwo1AGE21EtY7bH3RFxO520eDx9XCCMyP+8wt1d7aR
         CWBcCO28NSolRcWNPrGyxNMgj+Ab8+SKQ8anTrwLy+XVH6vp0PCw13hpclKsP3DJFoQT
         FBCALIw7o67fHxPORkQhj0nNw1vykdCdzYkHRDdCJWqnJx87zjIVN0tn4gtOEW2SWOia
         53aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763627181; x=1764231981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7PnQ4g/3MCD+/CeDtkg6cQ8hBr+h2xXlLFe41ou95fQ=;
        b=VJLOXb2imkl4/RZYOFuMBM66Nm9zGtNiPInQwlabN5cTG9cmV6LAUGsKCs+wDtdqQh
         N/MgwgdkZYhvW+ZkkpaiKMNa78rHoCFMFZbWKwhcOczyGVdZ4ZxIfweQ4HWocraf16TT
         AFAN41BMSNBLsKPXXHEUTyE4QkZfBTTfYPrHfsmbrMjyXV0TI7rdwycd+th4gC/bdrWZ
         zBQyEVd+68aCOp3arcOHezthJucVS3p+IestgaAls5YZwF+JB9GydFRja3WBm15dCcva
         TvdP8TDxcZbbTEA+dPVt+iXGUBJclD9UkkmxU/yP4SCyeEB3KUWwII4YQrvSycF4NYpr
         tBFw==
X-Forwarded-Encrypted: i=1; AJvYcCWIaa+0dIniYuGbEdHSJCayXjQ2lRa3Arj7harA797rn6hvNaXYaAi4v13vfc2IuBnlSouPAsJAIoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBY9qWFWrwOFadsDy74f3+x+5Ezg52T1WoP4K6BjGa7hKuKs3q
	vdVp6Noc3ndHSZtlJzrQeHs5zOWtNnwdA149gcXcIyiqIutEK+gWfxU4YLYW+PyZfy4=
X-Gm-Gg: ASbGncu7nxgACw6H5MDmfsTP/KFw8Gw2oVBQcs8jgLRXfbto+1DRzlfLXCMjADi6rZ+
	0eO7ZfDetQ0GZjmXQUSNXcXmvPKiMRLwLiPjTOi2/H95LGIlKrnlsVhR+x1q0Bl8zbS6+6J5Kqw
	DJ/x7KNQ9oeRU/IL7d/oNfPvqKChtsJdzQFpaNJKlzBnXxfjFJaWZ/7TGjwzd6aIDjaXIWOLvNx
	XfksdxdT929a8+MDCPiADdQXHhLFQMWkKilku6Df83ELacJUVfVeqMq+Pmp0oYCTOiGeikHw9It
	IBeSN4felZis88xiKTpszbqK5CyU3hIqLFuWF/c7qPSNMJbvQlwNK0+NM3qAviCRunVDvLAk4kM
	64chME871In8KD+e58GEphDECyM7UBvL4JE5la8PtvK3lJVEj3z7WAwbuaUr+aRjqOw==
X-Google-Smtp-Source: AGHT+IErXVHOiL3+XMt6VKRG0OihyK1Ccu27CSbMzfghO9tn3MZRV/0yEewjwJ9mgYVHs5nlQmU41A==
X-Received: by 2002:a05:600c:4184:b0:477:a2f7:74de with SMTP id 5b1f17b1804b1-477b9ea3508mr8601435e9.3.1763627180835;
        Thu, 20 Nov 2025 00:26:20 -0800 (PST)
Received: from localhost ([151.35.219.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1076865sm93400045e9.13.2025.11.20.00.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 00:26:20 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] iio: imu: st_lsm6dsx: move wakeup event enable mask to event_src
Date: Thu, 20 Nov 2025 09:26:09 +0100
Message-Id: <20251120082615.3263892-4-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251120082615.3263892-1-flavra@baylibre.com>
References: <20251120082615.3263892-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7525; i=flavra@baylibre.com; h=from:subject; bh=W7dRYFBp5zbk0lTntGV+cJ+DU2JAhLbFX8VsL4eBjeo=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpHtB5qOw5JEdmXERyjwBdrBVvmU1TaXh0S5YdX RcIpIuUQXGJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaR7QeQAKCRDt8TtzzpQ2 XyhZDACdPs2v2eVq6BOYprhQVzlCtevYM7Gs9XfUjl2+ZblLi8C1x6kvPqAjeFXQq8qChBHuAD7 1K2+yClFHflK/kbjDLPRMvACqy5HoV1rawX8wBTSHL4dEpcEv8mJamoE2t9V3Hv1/27KG/SQp7p lNmlDLeNOe/jXkVRPIzPlAU8wVL6Qlx3PibwwpGk8A7EJxhHd4tqz6n4NAPMh46iGYqg76X7yaO lB5GUtdrSIcPcUKu5G1fT/eIuEJgPd+Tf/HhQSA1BPLOK8hqyK7QB6YFeqYHXDehHb2ZIfXTGy5 oB7SMAQaUpRpx7rm1BD3WZx7eklSlPfJYo+js5fQqp1rLxrPp56M71W7MZdX7nby/u/uI22XHaS nzz3rLUyREFDlUPQc9KodKdej0gDgzKIKJL/cERJtcZ8Lh10/k+owcuo47zhwqdIGejCqfjsCOl NJnHiKUi2aaJBGIL5/HmsdaBobCFJK1jFwdvpzuB5HgkUnu3+tmIjgvrD8kZdb3T6nB2U=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The mask value being assigned to the irq1_func and irq2_func fields of the
irq_config struct is specific to a single event source (i.e. the wakeup
event), and as such it should be separate from the definition of the
interrupt function registers, which cover multiple event sources.
In preparation for adding support for more event types, change the
irq1_func and irq2_func type from an {address, mask} pair to an address,
and move the mask value to a new field of struct st_lsm6dsx_event_src. No
functional changes.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 81 +++++++-------------
 2 files changed, 31 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 4c3ff1cc0097..bbb967b2754b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -249,6 +249,7 @@ enum st_lsm6dsx_event_id {
 
 struct st_lsm6dsx_event_src {
 	struct st_lsm6dsx_reg value;
+	u8 enable_mask;
 	u8 status_reg;
 	u8 status_mask;
 	u8 status_x_mask;
@@ -344,8 +345,8 @@ struct st_lsm6dsx_settings {
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
@@ -444,7 +445,7 @@ struct st_lsm6dsx_hw {
 	u8 ts_sip;
 	u8 sip;
 
-	const struct st_lsm6dsx_reg *irq_routing;
+	u8 irq_routing;
 	u8 event_threshold;
 	u8 enable_event;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index a71174e75f44..ce5f9213d476 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -328,14 +328,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -394,6 +388,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status_reg = 0x1b,
 					.status_mask = BIT(3),
 					.status_z_mask = BIT(0),
@@ -498,14 +493,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -564,6 +553,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status_reg = 0x1b,
 					.status_mask = BIT(3),
 					.status_z_mask = BIT(0),
@@ -698,14 +688,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -805,6 +789,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status_reg = 0x1b,
 					.status_mask = BIT(3),
 					.status_z_mask = BIT(0),
@@ -951,14 +936,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -1046,6 +1025,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status_reg = 0x1b,
 					.status_mask = BIT(3),
 					.status_z_mask = BIT(0),
@@ -1168,14 +1148,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -1231,6 +1205,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status_reg = 0x1b,
 					.status_mask = BIT(3),
 					.status_z_mask = BIT(0),
@@ -1347,14 +1322,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -1441,6 +1410,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status_reg = 0x45,
 					.status_mask = BIT(3),
 					.status_z_mask = BIT(0),
@@ -1899,10 +1869,12 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
 {
 	const struct st_lsm6dsx_reg *reg;
+	const struct st_lsm6dsx_event_src *src;
+	u8 enable_mask;
 	unsigned int data;
 	int err;
 
-	if (!hw->settings->irq_config.irq1_func.addr)
+	if (!hw->irq_routing)
 		return -ENOTSUPP;
 
 	reg = &hw->settings->event_settings.enable_reg;
@@ -1915,9 +1887,10 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
 	}
 
 	/* Enable wakeup interrupt */
-	data = ST_LSM6DSX_SHIFT_VAL(state, hw->irq_routing->mask);
-	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing->addr,
-					     hw->irq_routing->mask, data);
+	src = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP];
+	enable_mask = src->enable_mask;
+	data = ST_LSM6DSX_SHIFT_VAL(state, enable_mask);
+	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing, enable_mask, data);
 }
 
 static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
@@ -2171,11 +2144,11 @@ st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
 
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


