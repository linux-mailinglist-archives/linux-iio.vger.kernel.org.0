Return-Path: <linux-iio+bounces-26588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B0BC968A5
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 11:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7729C4E262A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 10:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5886030214A;
	Mon,  1 Dec 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z7Z7STF4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F96305044
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583249; cv=none; b=SHQk/9zMb6WBY+TynKDRl+5nDkdEh9crB35oC75qJxcsJk6tof+eW4hQNS3z2wHYC2GKfHHN38DqSdJoFhLBr6+GCMhp4+VYTgbkl6so2L2ESdXp60CoPJpzG9BJSSozrzCqKZs1qjKz6XE+BanF70aPjOAhsf6m9Xbqe2Fu/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583249; c=relaxed/simple;
	bh=UZ+NdiZ3XXGhqfYf7NBT7wSKeBqxcjm3BrjMaP7yIMQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NILy+nodaYBYqzdRXTWdFgdjo2gcLlF2Qi1l2k1c9vSja4CiANOdTyf1e0VTGGscuhiG/XrZeIe+JgbNsGI1NtU+UMEJXFMGFq+IM5Geo//MwRpyvKj/nlJurGP40m+TIXSnPJcTPKQ1OeokmOL4aFHsoDoUhGpZUBPLv6sUNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z7Z7STF4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-645a13e2b17so264612a12.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 02:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764583245; x=1765188045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwJPcF87ublVHeKGOaqXUL8BklErYLQR4Y/XoYD4Qmk=;
        b=Z7Z7STF4pO+GQq8EKLY1INeuk5ioibhnRLi6HKQudTI6GChIMp6OtqUO4xfUeOH+lF
         U2+dZuEJBV4FdnIKvfKt28ci0KYyFn+mW2efJb3iRhNV286oVVUQvX+ODJulrQQ7Vw+X
         iGGz7/9L67t0PDD+PxvTi5nj5MWNLXyRcZK0JRgmoTRIyaYq4gGsYOzffonB/g5POv2L
         /yPmE/JEXdK9onpS21JGNpobJCKTBJflyVF5bGFfdATKz9679EYao7cWz/8FRUvL7wPM
         m6y2hWwaPqHqunJx0v5QX5frVz0IULWs5uOdclqB7NjPlt/gwxFP5lTsyp9s4lTKRAAk
         FC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583245; x=1765188045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wwJPcF87ublVHeKGOaqXUL8BklErYLQR4Y/XoYD4Qmk=;
        b=JcxvBXSzANu8XkwDgYjVBy++bvx18Ef7As89RWG8dOjIOSm5CLvW6KWLhdrNLQXeVj
         1098b9TA+HaoAY7Gu2fzw2wHvtuJgsgfeo8mXmDo/TyNj+ZMizhR1NZnPRfjGfYveDAo
         S5Tt5rcNg+wTRIjdUb68oR95igGNrRPCkoSHFrNbiGPZRH4X9CccbIpI9OuX21ueLsMF
         vOpuhEks+Is8/DKlDkvcd0ziDEv7akoheNB8f8sNFkBE12MTZopFJa0XQF5Tp/Gd49ER
         wy53s+k8YSGNGAhj28swBeKhKFLH/6Fl4EOYjGcVFPf/m0B3IjzK6BqN6q2iBKtHC6Y9
         Nt7w==
X-Forwarded-Encrypted: i=1; AJvYcCWmDhpAROCHSbkNOqHT1RHskDGop2nmzd5+UE8QBdXJfUXPhBsAjibaNI67HOE2xKULFpBrhelO4Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVhGkrRUiBeOWuMbtXUc+CgNKb6S7c7gHHa9mbbgVFNyVACwLu
	MzatGzrlLXufGngbLFQyJVHxYosl7k59NBqKOiE1z/JBr/3Ues7Vj4yPESdyvXWpmBo=
X-Gm-Gg: ASbGncu+hjgCeMWNpcoXCXWx2cjFgDHHn6PZ6ED7Ujml9TSrFjVj/uuCPHCfDFMzH6V
	mJn3lEDckE3q20RltbZQBoawTh4oYlRMXx+N8g9CWN+L19IDWuuigdgBXidYLzU5nDRBzYgPaVB
	LE5S2bIYQWb3DQR5JpGrs1mBu05aSSSS8GB4aodPeG29C9cGkJO2G5OZJ9LCpcAt5Jvzw8oGjdj
	27NKxhVjEM/SuTkrzUxtm5VSclwSa0By48hLkoZkmMPUfNTzqNsIHLWnF1Qh0Jd6JyK3BWpElSR
	4yyQH30PDkB0YLvjrcEq0xPcUaoH8/QRkrOtTxYNeVH6pkW6c+drH2dH2HUkIqnXErlXuY9SLXY
	k3WD3EjeC5TwZJeQduhx+47QKtapVbOonVxg8ttse47kpcJ8uuCPL5nrB
X-Google-Smtp-Source: AGHT+IFChMHak8SankQL+6tB2ksAC/qOZGucx8K1PhOJa9cotCvj2CZq//xGxU+Qk/xs17mlKJdgBw==
X-Received: by 2002:a05:6402:3492:b0:647:5fbd:f065 with SMTP id 4fb4d7f45d1cf-6475fbdf099mr9858594a12.32.1764583245072;
        Mon, 01 Dec 2025 02:00:45 -0800 (PST)
Received: from localhost ([151.35.151.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510508d4sm11914829a12.26.2025.12.01.02.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:44 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] iio: imu: st_lsm6dsx: add event configurability on a per axis basis
Date: Mon,  1 Dec 2025 11:00:16 +0100
Message-Id: <20251201100018.426749-8-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251201100018.426749-1-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5625; i=flavra@baylibre.com; h=from:subject; bh=UZ+NdiZ3XXGhqfYf7NBT7wSKeBqxcjm3BrjMaP7yIMQ=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpLWb6F0mHQJw27OmiaIrbqPHW4CGVF1suZcbLy wRVqZkS/xqJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaS1m+gAKCRDt8TtzzpQ2 Xz+9C/0SYYLng6hhAgMto0esFfCfwjMkoq72PceTWmy/RVSrvuPhejFWkSRYMdrwk+ETyqEKM8d HOSwxpvZt9sUckAAthayAyxjMdr+8qOWJ9KYMAHstfC/VtcDjph+4eiaykDEO6c6FmhG+uXheUl 4T5q5ojJfdeST1WOYGBdAnYwx+Dq7BYzTg7YZ3vQY4y6QYKTOeIbJ6hB1V5iS4ykISI7HaLXn9C 2UgklnN3gwWW+YTWwTi9oWH99eCsd8nQCVRj4nJ4hYMHGP60oFgzOsVuHRBu9E+qak7vLtLWzRE j0W42HPdT/8yu5QG6/Ev6PAVQP75VsiRnF2I2OVdhPMSCzUAEzJC+5jVvCWM9JS6/bBklUku0yK UMcM+Esvn9Na0BIXVqd+QjK4gQEdu9JhnrUgq6joFMSx4x7+YKOq+LRUt2xKH72GcJovmJTsPeh Pt6EapBFLEFz62ZMyhHNE7VquSUoxP9gyTpXKF7NMB0x/r71eHBZbIrwCBiGNWAtpjkcg=
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
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 95 +++++++++++++++++---
 2 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 2aae56b7db0b..515aadbee3a4 100644
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
 	struct st_lsm6dsx_reg status;
 	u8 status_x_mask;
 	u8 status_y_mask;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 6dc6cda54d05..e6c769049981 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1888,12 +1888,50 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw,
 	const struct st_lsm6dsx_event_src *src;
 	unsigned int data;
 	int err;
+	u8 old_enable, new_enable;
 
 	if (!hw->irq_routing)
 		return -ENOTSUPP;
 
 	/* Enable/disable event interrupt */
 	src = &hw->settings->event_settings.sources[event];
+	if (src->enable_axis_reg) {
+		u8 enable_mask;
+
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
+	if (!old_enable == !new_enable)
+		return 0;
+
 	data = ST_LSM6DSX_SHIFT_VAL(state, src->enable_mask);
 	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing,
 					     src->enable_mask, data);
@@ -1910,6 +1948,39 @@ st_lsm6dsx_get_event_id(enum iio_event_type type)
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
@@ -1927,7 +1998,10 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
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
@@ -1959,7 +2033,10 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
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
@@ -2042,20 +2119,11 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
-	if (state) {
+	if (state)
 		enable_event = hw->enable_event[event] | BIT(chan->channel2);
-
-		/* do not enable events if they are already enabled */
-		if (hw->enable_event[event])
-			goto out;
-	} else {
+	else
 		enable_event = hw->enable_event[event] & ~BIT(chan->channel2);
 
-		/* only turn off sensor if no events is enabled */
-		if (enable_event)
-			goto out;
-	}
-
 	/* stop here if no changes have been made */
 	if (hw->enable_event[event] == enable_event)
 		return 0;
@@ -2073,7 +2141,6 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (err < 0)
 		return err;
 
-out:
 	hw->enable_event[event] = enable_event;
 
 	return 0;
-- 
2.39.5


