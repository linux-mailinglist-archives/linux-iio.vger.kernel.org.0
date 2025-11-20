Return-Path: <linux-iio+bounces-26335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 335D3C72E71
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 09:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0283035AD10
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB96327BFE;
	Thu, 20 Nov 2025 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q2weYyzk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5919D32571C
	for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627189; cv=none; b=MN8OzhTqt/CQ22ECeqqcBFtejjAPe6+jzkofjqB1TEabCHBjhn+iuGeIrVaGD4UXPNslfSgCKG+y1H+GxgRwE+faDGbNOA9h8DHUhxkd8RKSoUWfXTRJP31BWFKCFoRcV/fxgcyp7idmXPfRbRjRNp7ZcONrYk5Op8egiTJJZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627189; c=relaxed/simple;
	bh=M2xi7kmYS8FYoUjEZg0XBnuh1zE891+q0kJi1ZGVBrQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sPyQqX0v08HndjpsNqJog1gdz8UrnbMPIBYBXrGZOxTwixBGd+LsFv59gBpOxTaEJkIBqNzEniKfHRA15JhMwK0UIG7nN3a81xGHbj5hnf1wFq9EGBaJswWX///5YSTPgCrHvA+qZDgoaoQfRGbDWPUZ1d26C3qi1K+giMYje9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q2weYyzk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3b29153fso312342f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 00:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763627186; x=1764231986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/6WYSWNnQnuNFEM1VMeHztnE0M2zVKGUMsSbsYzHHU=;
        b=Q2weYyzkehxTkNNx0IWfmaUfC7aZPkTYxdH2nvYqKwfULAvs+jRo7fUx5Eoy7TVXLZ
         MCYk4QbNCvNT609ozMc2ehZjwDCKbXhptS6RHuf9+0hVY6wW/qQRxKo3oQlugqcPcyqq
         4A+6c9YMXRhqdBkhGh2F8OBJHZGXYca6PnxGx5cRi4I1vtBkGq7phjT4uGlEW9LbHvvI
         EdP4eRoLPsiP10NFuKIIhUEItqRt2wBNzxGKc40+0p6Tm40JxXu5n0WUpbxADUxpfATR
         9XMH6dKrf1m4Pwu5cJD190qZD2yY793BmPfmKPQPnIXWRrBLI6BOjcMNfoL3FHEZmw/Q
         oAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763627186; x=1764231986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b/6WYSWNnQnuNFEM1VMeHztnE0M2zVKGUMsSbsYzHHU=;
        b=VEwAwUOzB3SVT9j3wN9s3giPuIciakkivBeZ6GNjUIJ4Ic+KwVdcMTr0zqZ7JCxnuP
         poJbuc2CbMzyGLno3lP+bQKJE3HP/mt2bDkSvpCGD+Iimebu0jkIOi5xTmUYRmVWa/aS
         R8w0Vs5BuJR4TW1SvXGp5+bR3HaJ4CPmws50wDwiuZkOB4DtbHF5kts8Zmqxefxy3Ln1
         3l0l1J5sEg3kJVwfEItt7MZmfbQyrcJXq087ZlkgGXej21OfSzMvWsNi2OKwGs2wpUyZ
         e0DAajo4RabhnAMSlEY8ohEY/sqPQpRMo2aTp9CcZVIlgIkS6Ze9rYs0pruIZHgXVIPk
         hiJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqrRSbmesRY4RFa1Kf0uFskLS8QVppkjYqbQ6SJBVzjNGxPLIIuyl+pCqKt8vafsP3R+iddh5v5uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFAzIRb2oM0nJVgKBdd+zvKiyPNS4e2wJLqbnb3Q7vFvjwvt0q
	KvJUh0yPtXHoR1YQkgD8+4vv/uEmYNjebHIxMUtxpMu1baAyC4xFycF4UcCzZ9F2uL4=
X-Gm-Gg: ASbGncui5D+ZeD47eHe4Zzf3suF4RGef8jgijJJzC91sJxkoTIdYvO52yohsz7sGAso
	aMtqN4YetSdSn9NGAHMx5Yr8fywXchz+Oj0r+r6rfTFkFLMMBR/Hdk4Apsc0tqNEvJ51CXfA620
	gAXALqcZBZnV6+jOg9njXfK9cch+3wM5GBsYJOsdcFoGpcSsW40CsK58DgV4sEe7coRXgpZKEXM
	6q9dh/Mikm+HX9WbS44Dc2I2L0tkguIDogsqCYCieuOybYnu87JZNcZGhOzkwMK25ZgzyKOLhOA
	vAqPwnAS2L5dh7woBzV4erz/BSjNWa9Cr6KEtUDMYb91pOdyrkjh6bBUIkkD11W5xJkvQTLsxPk
	DBmW3DBA6PXuS8CzGvNGWecI4KkOVMi4XJAEgfpV7F7KC88xBEk5cOHk=
X-Google-Smtp-Source: AGHT+IG1R/Xrbs/polljSQlJxwd47c4tbTlgz8tUqGVrTueBAkGCPO0V8tDFfeEC1TKUoHay87Gtpw==
X-Received: by 2002:a05:6000:184a:b0:42b:3dbe:3a55 with SMTP id ffacd0b85a97d-42cbb2783b8mr1199692f8f.14.1763627185638;
        Thu, 20 Nov 2025 00:26:25 -0800 (PST)
Received: from localhost ([151.35.219.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e598sm4062507f8f.4.2025.11.20.00.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 00:26:25 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] iio: imu: st_lsm6dsx: add event configurability on a per axis basis
Date: Thu, 20 Nov 2025 09:26:13 +0100
Message-Id: <20251120082615.3263892-8-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251120082615.3263892-1-flavra@baylibre.com>
References: <20251120082615.3263892-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5556; i=flavra@baylibre.com; h=from:subject; bh=M2xi7kmYS8FYoUjEZg0XBnuh1zE891+q0kJi1ZGVBrQ=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpHtB7JmIOK5wxn5U6F6GBQIAq8rARghItco41w jT2Mew0noeJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaR7QewAKCRDt8TtzzpQ2 X4B+C/wLgy/c03T3WHkbmVMNtLN4rsjGLmqbOkI++eEE6fzNbYP6UmcFbskWrsjK2UeqeEf7fR8 +lMwqqR2zjFywx3iqOR1ldl9c6Tt41pCfzu0lQIl2Z3pgZh9NJxPeaoNbIoHoB4pAtL6AR/d0Zk zFSpJHoH/CuP/IL0Zkjedz4ewpoVYidA5ka1rEyPOwOxlAf1uVTdbbJruPbgq9AfRaiz7aH54/o IMQeLc8G8YcNilL1TKHbg+ewZ8uUno2ReeejVbp2TNxGKcW3U558LhVBdJTOj7pA32rXaLLFQdf +x+RTpLQWXgrAmGq66GPtThBG87x7xsb6zmnCfzBWUJr5njK+De8uDpOdNnOnGM0ES9qJ0SKGIN hCMu/eTieEVi7+SgU4P6tctt5VQv8PKXr5TA2C/4fFsivMoc4JKd94pe8p+/sfsMATYa8w7sQfh 8xhmF/dh/Us/qJ4lAMSovG7uxTMNzZ7buuSl2bRLSEio7FxgG2vmf4+yeye7XUkTt0UOw=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In order to be able to configure event detection on a per axis
basis (for either setting an event threshold/sensitivity value, or
enabling/disabling event detection), add new axis-specific fields
to struct st_lsm6dsx_event_src, and modify the logic that handles
event configuration to properly handle axis-specific settings when
supported by a given event source.
A future commit will add actual event sources with per-axis
configurability.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  7 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 93 +++++++++++++++++---
 2 files changed, 86 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 037b3b817e83..6f68508e5769 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -250,7 +250,14 @@ enum st_lsm6dsx_event_id {
 
 struct st_lsm6dsx_event_src {
 	struct st_lsm6dsx_reg value;
+	struct st_lsm6dsx_reg x_value;
+	struct st_lsm6dsx_reg y_value;
+	struct st_lsm6dsx_reg z_value;
 	u8 enable_mask;
+	u8 enable_axis_reg;
+	u8 enable_x_mask;
+	u8 enable_y_mask;
+	u8 enable_z_mask;
 	u8 status_reg;
 	u8 status_mask;
 	u8 status_x_mask;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 18a09ed6907c..da914a58a875 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1877,12 +1877,48 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw,
 	u8 enable_mask;
 	unsigned int data;
 	int err;
+	u8 old_enable, new_enable;
 
 	if (!hw->irq_routing)
 		return -ENOTSUPP;
 
 	/* Enable/disable event interrupt */
 	src = &hw->settings->event_settings.sources[event];
+	if (src->enable_axis_reg) {
+		switch (axis) {
+		case IIO_MOD_X:
+			enable_mask = src->enable_x_mask;
+			break;
+		case IIO_MOD_Y:
+			enable_mask = src->enable_y_mask;
+			break;
+		case IIO_MOD_Z:
+			enable_mask = src->enable_z_mask;
+			break;
+		default:
+			enable_mask = 0;
+		}
+		if (enable_mask) {
+			data = ST_LSM6DSX_SHIFT_VAL(state, enable_mask);
+			err = st_lsm6dsx_update_bits_locked(hw,
+							    src->enable_axis_reg,
+							    enable_mask, data);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	/*
+	 * If the set of axes for which the event source is enabled does not
+	 * change from empty to non-empty or vice versa, there is nothing else
+	 * to do.
+	 */
+	old_enable = hw->enable_event[event];
+	new_enable = state ? (old_enable | BIT(axis)) :
+			     (old_enable & ~BIT(axis));
+	if (!!old_enable == !!new_enable)
+		return 0;
+
 	enable_mask = src->enable_mask;
 	data = ST_LSM6DSX_SHIFT_VAL(state, enable_mask);
 	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing, enable_mask, data);
@@ -1899,6 +1935,39 @@ st_lsm6dsx_get_event_id(enum iio_event_type type)
 	}
 }
 
+static const struct st_lsm6dsx_reg *
+st_lsm6dsx_get_event_reg(struct st_lsm6dsx_hw *hw,
+			 enum st_lsm6dsx_event_id event,
+			 const struct iio_chan_spec *chan)
+{
+	const struct st_lsm6dsx_event_src *src;
+	const struct st_lsm6dsx_reg *reg;
+
+	src = &hw->settings->event_settings.sources[event];
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = &src->x_value;
+		break;
+	case IIO_MOD_Y:
+		reg = &src->y_value;
+		break;
+	case IIO_MOD_Z:
+		reg = &src->z_value;
+		break;
+	default:
+		return NULL;
+	}
+	if (reg->addr)
+		return reg;
+
+	/*
+	 * The sensor does not support configuring this event source on a per
+	 * axis basis: return the register to configure the event source for all
+	 * axes.
+	 */
+	return &src->value;
+}
+
 static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 				 const struct iio_chan_spec *chan,
 				 enum iio_event_type type,
@@ -1916,7 +1985,10 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
-	reg = &hw->settings->event_settings.sources[event].value;
+	reg = st_lsm6dsx_get_event_reg(hw, event, chan);
+	if (!reg)
+		return -EINVAL;
+
 	err = st_lsm6dsx_read_locked(hw, reg->addr, &data, sizeof(data));
 	if (err < 0)
 		return err;
@@ -1948,7 +2020,10 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 	if (val < 0 || val > 31)
 		return -EINVAL;
 
-	reg = &hw->settings->event_settings.sources[event].value;
+	reg = st_lsm6dsx_get_event_reg(hw, event, chan);
+	if (!reg)
+		return -EINVAL;
+
 	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
 	err = st_lsm6dsx_update_bits_locked(hw, reg->addr,
 					    reg->mask, data);
@@ -2029,20 +2104,11 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
-	if (state) {
+	if (state)
 		enable_event = hw->enable_event[event] | BIT(axis);
-
-		/* do not enable events if they are already enabled */
-		if (hw->enable_event[event])
-			goto out;
-	} else {
+	else
 		enable_event = hw->enable_event[event] & ~BIT(axis);
 
-		/* only turn off sensor if no events is enabled */
-		if (enable_event)
-			goto out;
-	}
-
 	/* stop here if no changes have been made */
 	if (hw->enable_event[event] == enable_event)
 		return 0;
@@ -2060,7 +2126,6 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (err < 0)
 		return err;
 
-out:
 	hw->enable_event[event] = enable_event;
 
 	return 0;
-- 
2.39.5


