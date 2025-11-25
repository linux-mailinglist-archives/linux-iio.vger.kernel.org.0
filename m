Return-Path: <linux-iio+bounces-26469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F8EC8704B
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 21:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C84EB9CC
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 20:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A9233E375;
	Tue, 25 Nov 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gXqzApp3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C27F33D6F5
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102201; cv=none; b=R5QZeHP6aUwNj/kCBIyixJj4W5+wKOZ95YwDGr0IKIsbKn/s5p0RBX4GFMonXlioF2cIIn7MUb2hZnGS76Zjsw4xvs+eLG/BQqqwenPz7prtPZWRnQ/IH+akDlLeERCzSJPJ1lirS2hFQpUTQHx02aSnu/6y7uoKEkUPKpYDi2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102201; c=relaxed/simple;
	bh=gHSJ2ACpil3oUoOrN4nqa6atJKyrIL8QdwCNvpfI3Qk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dc42v3qoe5/UjnjiVZ22/5y+iNX1RYSLolsai6wZcHy+QsxNlqrwreu2YUwpgSugteq+6MBX4zS2xYLvifjYAkyWHXBWHEEUjR9c79hUw5jbMlPnYHY3sQZ+4DR1XddtmR4RPOzojwSt2DHC1TeYN7A/8YyyhRy81RdFWvRv1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gXqzApp3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b735ce67d1dso930785666b.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 12:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764102198; x=1764706998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZ3KjII7xZFDbQeKyBo731P+isw4m0FcuZQDXssMMvU=;
        b=gXqzApp3jhpRnUzLKBd+c+xg81L3u+GHUPfVZRwpibLT2CfJPzHo6RlWEifdL9Zg4y
         RcDIqIGRCp+G26Nk4nT87yQDBsaRLF0bt2LfwnVLCusyjnSyP8vqv8UWmLIcDSLTlIUo
         bZVZmHvMSoXDb66ffWPXieRPdcoYknTh/YyMDyMRqB7TXTFOQ+9N3StYxeKBqTjeF3T8
         zAnUgqUYm0+WjznUn+gnqfTOVYzpR0NlCkmvYxvvcM9KqkwlBp7BeX1qdXEFH4nkAlU8
         OM15Yxxxmijp8RumPniKQe4cYOeiF4/JBTjJtE4s+Jx6CV9leling45Rm9t68FCnIIFW
         yndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102198; x=1764706998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vZ3KjII7xZFDbQeKyBo731P+isw4m0FcuZQDXssMMvU=;
        b=DKBrd60FvocZ8j6qrguL90fMrR3AqIRmOqzLYKalqmc5JOyvt3b3RSNVlWfY7epfWu
         b5dtoROiOVXOeRer3UDFZbwdGoWKUjZtAcjPW6BD+LTDmLV7TMR6Fel3G3fPJazYkhTJ
         vtNXT4+BIKtG3Q3YjiKqPYPuBcy854F+J3/aZWWIuoxBKA0S1dz93WgMBbOo1a0PxnUt
         X8t78lSMKTLxyuuZaDTkUhDH2QB2yKB7ttgsun+giHE/rZwwmQKVea/nOM6swIdrxcR7
         YG8xIozMrMO3E9SBf3FrmhV30sqFFXb5DjPWAuOGEtY4fqn2+I358Mn3itEHaMaAfH4X
         yMqg==
X-Forwarded-Encrypted: i=1; AJvYcCW8bOJzPIxUCqkY35BiPA4R7+x6SdHDoDdDUC613y3QzR9zYVMF4kezYzspxBe/2VGiYJhIRaZEGFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzdoupv+/nuVbBiOziUl8QSSbak9vgmBptJVEDnThq22EGmfgJ
	Dcnz4sTHBPhhW48WevdhxH8EykaqZBwyeu/VfM1b9Qg9Qwj49RhB2w8nFN2m54sNJ3Q=
X-Gm-Gg: ASbGncsuJiISXsGOhnzhUQG++3KgKRjGQm179bsP/VXluU8wSFBCLhYGtiRMYHDXN6I
	ZKJ3B7ON5JXd4qwr6GUDY9JWBLafXxrpUd6lIwDVJ1d4pRGIaZt7fg1P9X1RJAfJABm1efdIfwp
	EZ1tgwFQ/cuOXDhS1iB7bzjdl4VzzZlyeM++rtudaTZRy3wsn75gLwP0uAiDQG7oETnaiw47dwC
	pS6ZMAFail8U/wiYlC2fbpYG9kyACMO2vIcbH9bU/iZsOcidlB3jMBo6fMolK3UokgJsCVCi8Br
	yq6ydjhpXL5s6+SGWBCO/uo1+aGiCGjw79V+1EwsVXkyL4oEUbLxBknIG2F+0bF/7b6ed0Y5Yhq
	zgmgY39aEvbL+q4tSMn08KEe93GhGicg/AOOqgaFWCP+iMZwMihtfwIydzA==
X-Google-Smtp-Source: AGHT+IFlmccSpoREOSIViih01/Pl1YGQquFBeoydLee+4dk/jLLZRnkDI96o5RM1J6u6zey3yzyV/g==
X-Received: by 2002:a17:907:7ba1:b0:b73:870f:fa37 with SMTP id a640c23a62f3a-b76c53c0113mr482544466b.17.1764102197785;
        Tue, 25 Nov 2025 12:23:17 -0800 (PST)
Received: from localhost ([151.35.128.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd43a6sm1637193266b.32.2025.11.25.12.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:23:17 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/9] iio: imu: st_lsm6dsx: add event configurability on a per axis basis
Date: Tue, 25 Nov 2025 21:23:05 +0100
Message-Id: <20251125202307.4033346-8-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251125202307.4033346-1-flavra@baylibre.com>
References: <20251125202307.4033346-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5627; i=flavra@baylibre.com; h=from:subject; bh=gHSJ2ACpil3oUoOrN4nqa6atJKyrIL8QdwCNvpfI3Qk=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpJhAEB75tQqC/WkBF5miDejQQrZ2AjaoCKO7aX bDty5S4JpmJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSYQBAAKCRDt8TtzzpQ2 X1B4C/4spJl2I7rRU/UjeSAH7mntFxJiXC3jnYIopFbUoyKqnszNdeygqXsHN2hO98hjlXZGIeA jv1L7bhwhu1KFCC9sUKe2wjjYdxdwIniC+Lg+WxDxQgbmm/YAsdL/PCVRkY5jzh+jC28XyTwZtR itT05l8EFZgK2zHH9cCDCeSWzCZxe4psvFnURrwqcRj+TpweIhlljUYcNEdtmjw3aBFxfceEnIX 5+Kmpr155YddDOSBFjwnqHXytO07O2OpGP/25mgZvFt3CeVaChV0iTqMRZCEGNn0gTyLlDQbJb1 N7aVlmJKW5e0sMa/X3xtGZp2S92ccNeJ8H/HD9vGFxNWgKxcgfJ6PuwkA5e8OX5QVztoaDwpF3m yeJqsYEROgi9oqQGB+eK6uoY3004dYSCNA+NrgQZpgj3zX8roeHlyq1+t8Iv9K6mXbT36EvnqWS UtQqqMqs9iosMPZTVJXvHMsA+M/pjUVSrAatQGk0A/nGBKDmNBqSKh52036Kzmmqg+AeA=
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
index 6dc6cda54d05..50c00dd38c63 100644
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
+	if (!!old_enable == !!new_enable)
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


