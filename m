Return-Path: <linux-iio+bounces-26334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77358C72E9E
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 09:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBBF94E81F8
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519B831196D;
	Thu, 20 Nov 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yZjh0eGI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675731B11D
	for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627189; cv=none; b=EncqA/oZc+t+m2SKeF7ojlzxHYVOuWsKPFJIOYpeYqaN6rroDB9NaUivXbs250Hme7oopVF4hAZ49El+5OaazupMLDffzq6iL+VRPmSTtzkYkbnWSnFxR4wpnkDx2p8F3I/Gyq0xSd7/MnH+WAmK3U+l8mO9lnuJ2vfOPTcK/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627189; c=relaxed/simple;
	bh=Pl7seLKP3VzGqHLHa4t0wj/0Xdcp2dmyAr7jQ8/rApo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q8UbJEqlu98aYvyQbbl58oMOg/M9r1CUizbQBmimA5N6v6rU6Gs6PTvz1301RpcWw77JXLBUj589krutEpWLFVPtPt1kItqQC0FAXrTO29bpGF3kqCnhbt2ikVazKID1DV3A5YDbwUX7pm3tdTeM0BZG8RyqXYPORToqK4eN4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yZjh0eGI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso315853f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 00:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763627185; x=1764231985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NH9HL3lDQ8mwoCbjiBXJSaunGp8CcA2sbb0lLadFpI=;
        b=yZjh0eGILSzm/+sdx+jRO09dzJtrIAogB0G+TeoCVbaSLOTLNotMSoWPKeYi/ZkJKS
         Jmu/xe+W+m8JhTpBB7S/+tD0PTXfDkhhmvVQTlSgjsKH07g2d/47P3AJccqNIU/uJC3W
         NvzQbsTzpCRf8cSRku13JJMpmhg0qPXBFlLeawEjCoAL/+K8vZeWNuJ6rvSqmMsTQ1Ih
         TQve9oJPd11O4M6IptXttO5GxYTRlJI/5KQS1Mzu+ibnaVhXmr+Ply7Gmpg75K29HlnT
         aZvlAhKTruZi4vW3xgdT5LVSL+jXEE9vKcUBsE8gSC+/sOIyrCkdkmzc65o5EgC/2XL3
         zmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763627185; x=1764231985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2NH9HL3lDQ8mwoCbjiBXJSaunGp8CcA2sbb0lLadFpI=;
        b=CyXr1eQdkBR7iU1gRAqjDm9qQSvX+/liQyXxjl2F8BIps2uS0lPS5Hezy416EgjanA
         g6xpe/bHSsPSFZdaJ8vkvTMIGhoxlrEGIJPsWN/ST4xbpWx6vwtKEWFDmb8T+egqPwm9
         kdrdwNquxAZBVR8N9EVFotHppIj+6UxI7Dk87pqz8ab03X/Ge5kUFSGFJU+WxClL3b2P
         bwv6upvENTH3z+0WNDSAqKWGG/Xz17enJ5cIacaxXFfhso6bDQGQynNMVvwQadkC2rpn
         xw/HjCCttuIaPJIYiMbhs7uf4xgcmgYGHo6dSnJRDibb4+6Vpm1fyOlCK4RXvRr5TdYp
         +Ojg==
X-Forwarded-Encrypted: i=1; AJvYcCXMWTqwU+NtxDdaToNHB1fU4hRHKT183BkM+thjvNexYmvzfiaVOlTen4P3MXu+zrnqvYOyBtwBBV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywavwzng+xf63bxPr6sRFXK0fDXMPeWMuR2L04BTqmMvmjMeoMQ
	JIoPqQ1SZwxlPV6N6F87WLIYXBhJgtUWnyylpfuPeOiDHGcPWD6HFad8yBAFhaF5NN0=
X-Gm-Gg: ASbGncuPHYrCdPaCDYI8xdQPa/LwYFws0Qucb9lj2QlBk0dhmYJ1u8cy0TMEo2GHdbm
	hKtIleGBDF3qPyktm7Si3ydDAjj3m5KWaeQ2U1lk47SrJ3rcr0eiqXoMQ+3tc17K8pmV5NBaLuW
	48yTAXnPRb+PkU+GKRds5tzQaoRJBu2TxbUmkepgE06yGmLViIfKC+7WFiVkZu5rHtmS6IxjWVT
	Q0T7wS0p1KAOFS2ZWwk91m3dQ2pXHtDh9X/lxFkUsJJ6cf2G+pb063tFFDvcSnZBcOQl6+95aa1
	h0xeJWVTgZNdh2D8Fn7D9Qc9dN8w7G7kR3ey7Fn8O9/0eliVoXpiD6T5MFGGsexf8zy7aE36c1r
	6imRPJgahvrv8tKPnTJpqGRUv0Xt8SKOoWFm6XsIva3DknTn9d9TtSWU=
X-Google-Smtp-Source: AGHT+IFEUrV71RTzljkgRY/G1TQEE5I1P4a/M9mSlHB0tzKZW2HL6p+RFLaptnK5/KKq1bQArqRnHg==
X-Received: by 2002:a05:6000:1846:b0:42b:4061:241d with SMTP id ffacd0b85a97d-42cb9a67ca6mr1531560f8f.59.1763627184504;
        Thu, 20 Nov 2025 00:26:24 -0800 (PST)
Received: from localhost ([151.35.219.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa41d2sm3961947f8f.22.2025.11.20.00.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 00:26:24 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] iio: imu: st_lsm6dsx: make event management functions generic
Date: Thu, 20 Nov 2025 09:26:12 +0100
Message-Id: <20251120082615.3263892-7-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251120082615.3263892-1-flavra@baylibre.com>
References: <20251120082615.3263892-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11134; i=flavra@baylibre.com; h=from:subject; bh=Pl7seLKP3VzGqHLHa4t0wj/0Xdcp2dmyAr7jQ8/rApo=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpHtB61sRMP968t26t5QkmoT0h6RB0mUWcPl9dZ QPSc0jT59iJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaR7QegAKCRDt8TtzzpQ2 Xy4sC/9HBeRr3bt9wpSbUlhFhWUczJR+3QvUXUP/bnTcJcbs7DsggNKkNnelU6M059c++KxXdPy +2/0hMeDPBrWRCSHSh+OcyU4SwDB7+2Frc1ECp9c5YiZIj3bzum7uoM5Y8sjxwuqeZlO784Otg7 bc0LOgc5/HcOoBhPu0i0zJGgrKVYbDyg6iJua6uHlyUDWjqCiBsS2jcRYQvwhG+uJPKWiauHVOF dxmprFF+vv4r0s2gBZjg37pnyjQ6/+tzpksJjHcpz3iDwxqIwONnlOr6wHoF9AET5qg5LHQDDjj FYHHlC0M34nbja97awhNHBe7RJCfHIVkvS94a/b5QWgnh6VL2CUqeKg6/WsfSHRTFa3k7FHWHgN nghsqp+P7kVdVFW/L2/XhTurTs0rvq2XErKIkgP0OPx1RY4XNTdHvxwr8THz3WliC425mkx1Rku JdFgw/ok+54v3F/HtqFirTSVCQpPqR+DaM/sqdJUi1LWEtL9x2j1GUMqYkedGWDkHo5cQ=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In preparation for adding support for more event types, use an array
indexed by event ID instead of a scalar value to store enabled events, and
refactor the functions to configure and report events so that their
implementation is not specific for wakeup events. Move the logic to update
the global event interrupt enable flag from st_lsm6dsx_event_setup() to its
calling function, so that it can take into account also event sources
different from the source being configured. While changing the signature of
the st_lsm6dsx_event_setup() function, opportunistically add the currently
unused `axis` parameter, which will be used when adding support for
enabling and disabling events on a per axis basis.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 149 ++++++++++++++-----
 2 files changed, 109 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index e727a87413e5..037b3b817e83 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -446,7 +446,7 @@ struct st_lsm6dsx_hw {
 	u8 sip;
 
 	u8 irq_routing;
-	u8 enable_event;
+	u8 enable_event[ST_LSM6DSX_EVENT_MAX];
 
 	u8 *buff;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 117ecb080d8e..18a09ed6907c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1747,11 +1747,16 @@ static int
 st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor)
 {
 	struct st_lsm6dsx_hw *hw = sensor->hw;
+	int event;
 
 	if (sensor->id != ST_LSM6DSX_ID_ACC)
 		return 0;
 
-	return hw->enable_event;
+	for (event = 0; event < ST_LSM6DSX_EVENT_MAX; event++) {
+		if (hw->enable_event[event])
+			return true;
+	}
+	return false;
 }
 
 int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
@@ -1864,9 +1869,10 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 	return err;
 }
 
-static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
+static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw,
+				  enum st_lsm6dsx_event_id event, int axis,
+				  bool state)
 {
-	const struct st_lsm6dsx_reg *reg;
 	const struct st_lsm6dsx_event_src *src;
 	u8 enable_mask;
 	unsigned int data;
@@ -1875,22 +1881,24 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
 	if (!hw->irq_routing)
 		return -ENOTSUPP;
 
-	reg = &hw->settings->event_settings.enable_reg;
-	if (reg->addr) {
-		data = ST_LSM6DSX_SHIFT_VAL(state, reg->mask);
-		err = st_lsm6dsx_update_bits_locked(hw, reg->addr,
-						    reg->mask, data);
-		if (err < 0)
-			return err;
-	}
-
-	/* Enable wakeup interrupt */
-	src = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP];
+	/* Enable/disable event interrupt */
+	src = &hw->settings->event_settings.sources[event];
 	enable_mask = src->enable_mask;
 	data = ST_LSM6DSX_SHIFT_VAL(state, enable_mask);
 	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing, enable_mask, data);
 }
 
+static enum st_lsm6dsx_event_id
+st_lsm6dsx_get_event_id(enum iio_event_type type)
+{
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		return ST_LSM6DSX_EVENT_WAKEUP;
+	default:
+		return ST_LSM6DSX_EVENT_MAX;
+	}
+}
+
 static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 				 const struct iio_chan_spec *chan,
 				 enum iio_event_type type,
@@ -1898,16 +1906,17 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 				 enum iio_event_info info,
 				 int *val, int *val2)
 {
+	enum st_lsm6dsx_event_id event = st_lsm6dsx_get_event_id(type);
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	const struct st_lsm6dsx_reg *reg;
 	u8 data;
 	int err;
 
-	if (type != IIO_EV_TYPE_THRESH)
+	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
-	reg = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].value;
+	reg = &hw->settings->event_settings.sources[event].value;
 	err = st_lsm6dsx_read_locked(hw, reg->addr, &data, sizeof(data));
 	if (err < 0)
 		return err;
@@ -1926,19 +1935,20 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 		       enum iio_event_info info,
 		       int val, int val2)
 {
+	enum st_lsm6dsx_event_id event = st_lsm6dsx_get_event_id(type);
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	const struct st_lsm6dsx_reg *reg;
 	unsigned int data;
 	int err;
 
-	if (type != IIO_EV_TYPE_THRESH)
+	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
 	if (val < 0 || val > 31)
 		return -EINVAL;
 
-	reg = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].value;
+	reg = &hw->settings->event_settings.sources[event].value;
 	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
 	err = st_lsm6dsx_update_bits_locked(hw, reg->addr,
 					    reg->mask, data);
@@ -1954,13 +1964,53 @@ st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
 			     enum iio_event_type type,
 			     enum iio_event_direction dir)
 {
+	enum st_lsm6dsx_event_id event = st_lsm6dsx_get_event_id(type);
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 
-	if (type != IIO_EV_TYPE_THRESH)
+	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
-	return !!(hw->enable_event & BIT(chan->channel2));
+	return !!(hw->enable_event[event] & BIT(chan->channel2));
+}
+
+/**
+ * st_lsm6dsx_check_other_events - Check for enabled sensor events.
+ * @hw: Sensor hardware instance.
+ * @curr: Current event type.
+ *
+ * Return: whether any events other than @curr are enabled.
+ */
+static bool st_lsm6dsx_check_other_events(struct st_lsm6dsx_hw *hw,
+					  enum st_lsm6dsx_event_id curr)
+{
+	enum st_lsm6dsx_event_id other;
+
+	for (other = 0; other < ST_LSM6DSX_EVENT_MAX; other++) {
+		if (other != curr && hw->enable_event[other])
+			return true;
+	}
+	return false;
+}
+
+static int st_lsm6dsx_events_enable(struct st_lsm6dsx_sensor *sensor,
+				    bool state)
+{
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+	const struct st_lsm6dsx_reg *reg;
+
+	reg = &hw->settings->event_settings.enable_reg;
+	if (reg->addr) {
+		int err;
+
+		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+					 ST_LSM6DSX_SHIFT_VAL(state, reg->mask));
+		if (err)
+			return err;
+	}
+	if (state || !(hw->fifo_mask & BIT(sensor->id)))
+		return __st_lsm6dsx_sensor_set_enable(sensor, state);
+	return 0;
 }
 
 static int
@@ -1969,22 +2019,24 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 			      enum iio_event_type type,
 			      enum iio_event_direction dir, bool state)
 {
+	enum st_lsm6dsx_event_id event = st_lsm6dsx_get_event_id(type);
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
+	int axis = chan->channel2;
 	u8 enable_event;
 	int err;
 
-	if (type != IIO_EV_TYPE_THRESH)
+	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
 	if (state) {
-		enable_event = hw->enable_event | BIT(chan->channel2);
+		enable_event = hw->enable_event[event] | BIT(axis);
 
 		/* do not enable events if they are already enabled */
-		if (hw->enable_event)
+		if (hw->enable_event[event])
 			goto out;
 	} else {
-		enable_event = hw->enable_event & ~BIT(chan->channel2);
+		enable_event = hw->enable_event[event] & ~BIT(axis);
 
 		/* only turn off sensor if no events is enabled */
 		if (enable_event)
@@ -1992,22 +2044,24 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	}
 
 	/* stop here if no changes have been made */
-	if (hw->enable_event == enable_event)
+	if (hw->enable_event[event] == enable_event)
 		return 0;
 
-	err = st_lsm6dsx_event_setup(hw, state);
+	err = st_lsm6dsx_event_setup(hw, event, axis, state);
 	if (err < 0)
 		return err;
 
 	mutex_lock(&hw->conf_lock);
-	if (enable_event || !(hw->fifo_mask & BIT(sensor->id)))
-		err = __st_lsm6dsx_sensor_set_enable(sensor, state);
+	if (enable_event)
+		err = st_lsm6dsx_events_enable(sensor, true);
+	else if (!st_lsm6dsx_check_other_events(hw, event))
+		err = st_lsm6dsx_events_enable(sensor, false);
 	mutex_unlock(&hw->conf_lock);
 	if (err < 0)
 		return err;
 
 out:
-	hw->enable_event = enable_event;
+	hw->enable_event[event] = enable_event;
 
 	return 0;
 }
@@ -2418,18 +2472,20 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 }
 
 static bool
-st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
+st_lsm6dsx_report_events(struct st_lsm6dsx_hw *hw, enum st_lsm6dsx_event_id id,
+			 enum iio_event_type type, enum iio_event_direction dir)
 {
+	u8 enable_event = hw->enable_event[id];
 	const struct st_lsm6dsx_event_settings *event_settings;
 	const struct st_lsm6dsx_event_src *src;
 	int err, data;
 	s64 timestamp;
 
-	if (!hw->enable_event)
+	if (!enable_event)
 		return false;
 
 	event_settings = &hw->settings->event_settings;
-	src = &event_settings->sources[ST_LSM6DSX_EVENT_WAKEUP];
+	src = &event_settings->sources[id];
 	err = st_lsm6dsx_read_locked(hw, src->status_reg,
 				     &data, sizeof(data));
 	if (err < 0)
@@ -2437,38 +2493,49 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 
 	timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 	if ((data & src->status_z_mask) &&
-	    (hw->enable_event & BIT(IIO_MOD_Z)))
+	    (enable_event & BIT(IIO_MOD_Z)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
 						  IIO_MOD_Z,
-						  IIO_EV_TYPE_THRESH,
-						  IIO_EV_DIR_EITHER),
+						  type,
+						  dir),
 						  timestamp);
 
 	if ((data & src->status_y_mask) &&
-	    (hw->enable_event & BIT(IIO_MOD_Y)))
+	    (enable_event & BIT(IIO_MOD_Y)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
 						  IIO_MOD_Y,
-						  IIO_EV_TYPE_THRESH,
-						  IIO_EV_DIR_EITHER),
+						  type,
+						  dir),
 						  timestamp);
 
 	if ((data & src->status_x_mask) &&
-	    (hw->enable_event & BIT(IIO_MOD_X)))
+	    (enable_event & BIT(IIO_MOD_X)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
 						  IIO_MOD_X,
-						  IIO_EV_TYPE_THRESH,
-						  IIO_EV_DIR_EITHER),
+						  type,
+						  dir),
 						  timestamp);
 
 	return data & src->status_mask;
 }
 
+static bool st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
+{
+	bool events_found;
+
+	events_found = st_lsm6dsx_report_events(hw, ST_LSM6DSX_EVENT_WAKEUP,
+						IIO_EV_TYPE_THRESH,
+						IIO_EV_DIR_EITHER);
+
+	return events_found;
+}
+
 static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 {
 	struct st_lsm6dsx_hw *hw = private;
-- 
2.39.5


