Return-Path: <linux-iio+bounces-26587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1751C968A2
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 11:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023FC3A2733
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB0305051;
	Mon,  1 Dec 2025 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0z9leyOb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA72304BBA
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583247; cv=none; b=KsCRHOHbiWpG2O4UdXmExIfkrupkD2Yd5WJIZlj+AxMnCdr+NOkR2oUZH9vIawW6YU34v9KOwKlbbdz6lSnGiaxdzohtbduHuOsztwbviIMRllygoVTFuiPCEv9ZEfarR/K3sDRWZxAFjalGe/CmgFZ09xzRMcKOQl/26RJ2QLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583247; c=relaxed/simple;
	bh=I2wP8/v8+iTwp/IbXvF+LNCirEJ4rMBvnG2GqyV2YMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L/4T87tLafD8oH7jaIcQuh0PN0/WczR1XJxwjBBd0wBBu8WG4YQ6WMqM6Dw4lcMy7ABucs1t+1m/7iL8VnmmKGwtIAGK6AvjfIDKJ6VlcN2I8yZOsUu8LHqwk0SUWeN1xD6hnExiN35vcaWxcvvzBE+HJ9uL7dXqYfOW1aOEE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0z9leyOb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so307388a12.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 02:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764583244; x=1765188044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JpMgD46UuIDmNrqgcRKLqCKR6U3UNIGWYWZqhE2Z4U=;
        b=0z9leyOb78LnpCpQD3Box0saKxyqF9bslEd0zZFjrQXYeyk9vYLHVWtmUQ609YZSaz
         MfO+F0qCbLTFQvLaSmQBL0O1uWh63tG0dIYnI/P1sp7r4PtfX2vOeCR+0k8p+ndngc4d
         Yw6QSbCPnnOcaH1CxjShpRSep9Qz+IbctGMYSqUk9t9Ztiyli6LbOFORQp8JpJvI/CyG
         M1N1UfkcNjtWkBRsVO/4JJYv3h9l/48qtNVQ/JV+s5WMSiH2lrfQtrDTmSJJBC9xflx3
         /MEQlEwgQAVbrxnN2PPWc5iYcaC2042yA0i7+Xbe4p0WRi95XRsTu8XNHUQJlGWhmh6s
         CXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583244; x=1765188044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JpMgD46UuIDmNrqgcRKLqCKR6U3UNIGWYWZqhE2Z4U=;
        b=jkjW0/f7nN2SUE3Wisxc8JOpQzNGi54H7IfGf6CBFGwC+ZV2emNdbmsbtu3DfxNnif
         Zl6n499gUm3vN7+tuop8iXjycQH8t4UTlUfbMNzzU+hzavvfiFWR5/XbW9TiZGX0rvD1
         EezMLUPqRrepe7ugLZVttE263TGuXN+RtWjYVVAsxggCY0liikMlS4Cu9TsgnLwGMF2R
         33ZF+BDM32vJR1BAfxb1WSMKgPqE87Ss8iUVJ6Nlsr7L6inHYSzvvSfzmPCnRR2J6tcu
         nFiQgljRfp0OsjOqws1qUhXHDOs/iSyWCmGp7KE+UQeCnUBUPucH1xKrv7PJCy1V+0YV
         CniA==
X-Forwarded-Encrypted: i=1; AJvYcCWeH8HJBMZJV/jXVavnq5roDaiZvL3nBPeETW4UCSHfw9hucgaFVHSxEjr0eb63POq689FDc7/i2Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEjSuDwDajYGLNAp1kAI8IGReXiO5kDHrsbrX44RvFHLX0cdZF
	s/PYo0fEgngnT+LV+s/r3dPShqB1Im+Hy/yrw5JP/wNWV6B6/uovL5YeksfJ3Ljwvmc=
X-Gm-Gg: ASbGncv+ZPOPUb+YIEUBX4nsa5jzGjD1F9m5e2cEuuNRgtCyM/pX2Ai0R3IVbNg1fET
	2/qA1EMt9UaCTBpIuQ7xjE8Isz5zwCVArc46cyqWvsFf2BVTNkrQ5POzfA4bYfcE56jTFkXHlqQ
	ubkdeIaLkjw99td/OuKt+b6jDzqX8BY6rfWOfQSKnllA/aMgsO6vmWwUlkeQjB18a/LNn5AikFz
	ZGbA2LZacEEPc406f9ttmWhqC7cAQ76Q/FfZ+uuvom1/jCVNINkgluqOemLINwMsjbAHjfgc/qx
	2KkuguLi4wW1qweSiEXMUHyt118/Y+zDexo80sWH0G0tvR/tXZa7+vQmU0XXJhyBA1McofmrdJb
	SgZxjGjEOZ+ruwfqZEmanp8H3f9UyVon8IxRq4q38/LsMc4vSYc3rbOKB
X-Google-Smtp-Source: AGHT+IGGa8xdBt3SXYflxkPq8WEDGUrHlW065EwBJ0L3P1ifoX3XoJocf/urbzR9t6D8lAQEs5qFrA==
X-Received: by 2002:a05:6402:5244:b0:645:e6b:4260 with SMTP id 4fb4d7f45d1cf-645eb2a86e4mr23027176a12.20.1764583243703;
        Mon, 01 Dec 2025 02:00:43 -0800 (PST)
Received: from localhost ([151.35.151.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751035b75sm13049937a12.20.2025.12.01.02.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:43 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 6/9] iio: imu: st_lsm6dsx: make event management functions generic
Date: Mon,  1 Dec 2025 11:00:15 +0100
Message-Id: <20251201100018.426749-7-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251201100018.426749-1-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11222; i=flavra@baylibre.com; h=from:subject; bh=I2wP8/v8+iTwp/IbXvF+LNCirEJ4rMBvnG2GqyV2YMI=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpLWb6dbr+4Y1eg2Sf/ylUoDZfk6O/zYPXRoNug tM7uHmzKSKJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaS1m+gAKCRDt8TtzzpQ2 Xw/wC/9rNAn+KlJXCHUpC4iCxPmIdZvOVan1GorqjR2t6cJzjRkF3ECyPJv1RJgHNNtZOjDtpzN dU1OLYaCy9cEXTyIkzkV2YSKRCJanJ79GLOWN23yilu0Otko5Vgi+b8FL5rqB6m+uxlRWOIpoOK f8QcsIkKXghvkPMDbTVJ0GMldd8SP3Cw8YPCvqi1kRuA+jFu0WqrBekRwO8M3wQOs65F+qRMfUG PqPo7WdRdUUD9ox87lou9jHhhnTzR2sOvY4JFAMeidOZ8tqJLB+OoWBzEvNDEO6KvNEFIW/mwZF jWbLb/bs3pcMtGFDb4qoxhKtjuDi+VYaZzjqGL+ZvfC+ewlTtUFTieE6LfPqKSgPSo1IT+Nn/JL GQb9QLQMniPJqguMsirG9USRU+aWoOVEWPtCTUCw5xzP03JcNJufQzQYJC4Vq1L9vj8asvoR25p URdlE1MpmhPTLl2BFI7ow3ZevtfgoPh+00ZcplYHcvayQskyMLkhUr0Vwby9RRG1xBXRk=
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 150 ++++++++++++++-----
 2 files changed, 110 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index b27a833d5107..2aae56b7db0b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -445,7 +445,7 @@ struct st_lsm6dsx_hw {
 	u8 sip;
 
 	u8 irq_routing;
-	u8 enable_event;
+	u8 enable_event[ST_LSM6DSX_EVENT_MAX];
 
 	u8 *buff;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index dbdf9bb9e258..6dc6cda54d05 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1759,11 +1759,16 @@ static int
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
@@ -1876,9 +1881,10 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 	return err;
 }
 
-static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
+static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw,
+				  enum st_lsm6dsx_event_id event, int axis,
+				  bool state)
 {
-	const struct st_lsm6dsx_reg *reg;
 	const struct st_lsm6dsx_event_src *src;
 	unsigned int data;
 	int err;
@@ -1886,22 +1892,24 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
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
 	data = ST_LSM6DSX_SHIFT_VAL(state, src->enable_mask);
 	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing,
 					     src->enable_mask, data);
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
@@ -1909,16 +1917,17 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
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
@@ -1937,19 +1946,20 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
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
@@ -1965,13 +1975,56 @@ st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
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
+
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
+
+	if (state || !(hw->fifo_mask & BIT(sensor->id)))
+		return __st_lsm6dsx_sensor_set_enable(sensor, state);
+
+	return 0;
 }
 
 static int
@@ -1980,22 +2033,23 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 			      enum iio_event_type type,
 			      enum iio_event_direction dir, bool state)
 {
+	enum st_lsm6dsx_event_id event = st_lsm6dsx_get_event_id(type);
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	u8 enable_event;
 	int err;
 
-	if (type != IIO_EV_TYPE_THRESH)
+	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
 	if (state) {
-		enable_event = hw->enable_event | BIT(chan->channel2);
+		enable_event = hw->enable_event[event] | BIT(chan->channel2);
 
 		/* do not enable events if they are already enabled */
-		if (hw->enable_event)
+		if (hw->enable_event[event])
 			goto out;
 	} else {
-		enable_event = hw->enable_event & ~BIT(chan->channel2);
+		enable_event = hw->enable_event[event] & ~BIT(chan->channel2);
 
 		/* only turn off sensor if no events is enabled */
 		if (enable_event)
@@ -2003,22 +2057,24 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	}
 
 	/* stop here if no changes have been made */
-	if (hw->enable_event == enable_event)
+	if (hw->enable_event[event] == enable_event)
 		return 0;
 
-	err = st_lsm6dsx_event_setup(hw, state);
+	err = st_lsm6dsx_event_setup(hw, event, chan->channel2, state);
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
@@ -2429,18 +2485,19 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 }
 
 static bool
-st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
+st_lsm6dsx_report_events(struct st_lsm6dsx_hw *hw, enum st_lsm6dsx_event_id id,
+			 enum iio_event_type type, enum iio_event_direction dir)
 {
 	const struct st_lsm6dsx_event_settings *event_settings;
 	const struct st_lsm6dsx_event_src *src;
 	int err, data;
 	s64 timestamp;
 
-	if (!hw->enable_event)
+	if (!hw->enable_event[id])
 		return false;
 
 	event_settings = &hw->settings->event_settings;
-	src = &event_settings->sources[ST_LSM6DSX_EVENT_WAKEUP];
+	src = &event_settings->sources[id];
 	err = st_lsm6dsx_read_locked(hw, src->status.addr,
 				     &data, sizeof(data));
 	if (err < 0)
@@ -2448,38 +2505,49 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 
 	timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 	if ((data & src->status_z_mask) &&
-	    (hw->enable_event & BIT(IIO_MOD_Z)))
+	    (hw->enable_event[id] & BIT(IIO_MOD_Z)))
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
+	    (hw->enable_event[id] & BIT(IIO_MOD_Y)))
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
+	    (hw->enable_event[id] & BIT(IIO_MOD_X)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
 						  IIO_MOD_X,
-						  IIO_EV_TYPE_THRESH,
-						  IIO_EV_DIR_EITHER),
+						  type,
+						  dir),
 						  timestamp);
 
 	return data & src->status.mask;
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


