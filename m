Return-Path: <linux-iio+bounces-26583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B7FC96875
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 11:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AABD3A1C47
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B94302745;
	Mon,  1 Dec 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xMjTgRff"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D19302156
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583234; cv=none; b=qsa/Ru8Sod9IkbrfH64E3ANm0ETxYpe88JrMPtIvgoJR5/YT3hH3xEw2mrLKBgI5OBpqtBYPpa3DJHgdUHdKgtK+HyEOdAtyokbSE+aJurB9vpqdJxR5SgNlxNyBuOgzs0vK8ouqxvO97xy1mBQNYL4p4pl6qgGWEfaSIM6C3DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583234; c=relaxed/simple;
	bh=n+tWKmHDIKPoB17m8PDbku2hGkPzuoaQtqpngbiJb08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HI0ZyiYiz/2m6o9d+fE2qboNeLCFw7ee55UAGXe2r+hrvfFcZmirOPQb9GxCatip0uWf/NNZJcK7as8AaqLfVMQPPEWGFdDvktr4460eo529wm5FgI4tNmn/EGtX154ltbI6LZYYgtuSgtUzNiZKJwQ++K36NeNXZqmncoQ/f7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xMjTgRff; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8826b83e405so55225196d6.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 02:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764583231; x=1765188031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOpKIjBtp3jglLtC7+Xd90dUysNa5e26fWUT0wH80JA=;
        b=xMjTgRfffyTgpfBUiiQw1EuE1NXu6vpNhJdlmedw4yUy12EL0IMCDSN6JQFas6ueQ0
         m/8O8dwibhNOWtydmR1AOd5wYHCkF00diA8GEUSh+H72d5oAYvCebZyajuVrkLmgIRhZ
         OFQSESpIG6D1/f2JjHLGeaGKG3V1wT+aCR+p2ixydsAeF+2PsZjoM+MzXbbqx+trAN+g
         7/w9cAdJVX8APhAKRpjRXav1fO9ru/KzOYd5adM8/IpXx5YWAadfcr0j8p7s134jOBoW
         2ntntuopHpPv+Rato8WGjeggiOUR5UmjxuzhcKoLfH1JIvRw/SXHOfh7jLvJUkc+aQnH
         eYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583231; x=1765188031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BOpKIjBtp3jglLtC7+Xd90dUysNa5e26fWUT0wH80JA=;
        b=JpbGnDj/JMkEbFCENOeyj3g8lbH7IY2Fy5qIk6qLSD9gf+MrOIiMDYWbxvbhUrr+6P
         PbIr350+Rrs9lfjSqethHXo+RpYBRS3qew/m3vwOJzG0H86vrKFuRfT36nIwu21VhD8h
         i1f9KSZvEGxyrhdYDs81mHs3jRCkEftMpeXGof06K6/Z4udGcgtjbZ4zFTh63KpuA3Cv
         QXys8+8Jq9WlR1aVHhhEKrvKDvtVHiXfmOA8AnPkNCttEjPbTvz9wAFLPww1GhrRzxes
         VkpAJAa9m0dC3tQoTzMz+DBIrXZwpwiuQ8Uj2C1iNWWQqeWEGNRQw6llXYAxS8qaYZjq
         gFrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8qutPxiAnSajfPKsnHCECaea0rsz+xupEKP7xQSgeuBW2cE/WR3fACCGEYZaG1LoFHGFADkrUpgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHOJcLiBLgZ4jeApvVAUjhC3GP0p/MPg7uoZZPODI8F1e6bDWU
	to3QnIpQ2IFqCDREQmplg8+muZCaNsGHQ5efM7Yo7CgIOPYcD7YqbpkvGHu8aK+KhC8=
X-Gm-Gg: ASbGncs+gKFCVwIMyywLV2O8ay2sykpaDp7tWTY3/bhDCWXwIWJeEAHGp3JV54KbDHv
	EJfOORGRqG2/wQ+QTq65iU4rv2BsMVzxJiGvLgZxcMyafpN6wJN1nJFTCVSRv2yxG3ihjGc7vXN
	Li16kAUSDOK0Q48sTizzmcl/waZpYps6xMBgukQXVWl01xddk5ke3qixzUIjZ+HTHjIsiWErIOL
	GXVDyr+1gVevaR/6pd4E6U8eYRSktmViI22/xi71Il2RyaJ+h35HNqGmGmpRKljt+3F+7ashyFa
	WbDu1yTgfpXrk/y7Bf+r3PnErJSfT1MNUuV1WGG1ViCz9qszR4HgjAdfHrWKOhQ2nDqYZil0X32
	5wcXXshOMW7HSRjJ8VObmdymL+bxQwHYm4oMZ+qoInUPtFNaG/Oc8E9ZP
X-Google-Smtp-Source: AGHT+IGSO5IwGs6hZGHFBf6IPOzV6kaFdfaImnLXAS0LDmC8e/1YF9ZtBCdiJdYjdxb3iZycnGP9bQ==
X-Received: by 2002:ad4:5de3:0:b0:882:3492:b405 with SMTP id 6a1803df08f44-8847c535bd3mr580065226d6.54.1764583229987;
        Mon, 01 Dec 2025 02:00:29 -0800 (PST)
Received: from localhost ([151.35.151.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b494ebsm79665276d6.34.2025.12.01.02.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:29 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 2/9] iio: imu: st_lsm6dsx: make event_settings more generic
Date: Mon,  1 Dec 2025 11:00:11 +0100
Message-Id: <20251201100018.426749-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251201100018.426749-1-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8599; i=flavra@baylibre.com; h=from:subject; bh=n+tWKmHDIKPoB17m8PDbku2hGkPzuoaQtqpngbiJb08=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpLWb4qZsTWGnvQ5y4mMPFAjXdt7beAc/oZJiro kTDzMLWF1KJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaS1m+AAKCRDt8TtzzpQ2 X20jC/9t7ppVndnMBWP+U587sGMD5i/XWATa+g0Nlsc6QqXFDIy15yFk5EVIfdYknynDhk7iIm4 A6BSijW7JIuY43e94n6y+9bmCthvnVep5UFKe61pm+kgt0c+UgSKaD7cK+mx4RnBakKj2gVIfX3 KZMpMGfIDB7TwYKbUQGxi6hhF6lGXG9NK8BKWn1zagQN43Cx/bzdMLzx8TSLebpyFOZe4YoSFga wErEwaQlHrO7G/GDZFQqhAZjr1T7AxX9Jj/4HWzfM4zGiBtJ7RT+oNZkQuoerOTfjt1iwEQS4bJ cpMndp0HI2vkOrcy73zpJ8l67KtFG+IyohWLwkPlBaIzrtDl0sxJjp7Y70HfQTlpWHkhIDhSpOU ioPbbnXpBl/HvoSGCihXRCAjwU9Rk7nE7Wgw1QgOUqd2tjb47Vj7ww5Es3wWlELX52J3865nEwm mS6F/VVZ8kdZxSf/6BhkGKMcPRCM3qRvTCtueq9JyBZGJ0Gc7JCTyBdPj8S25butU7ong=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_event_settings structure contains fields specific for one
event type (wakeup). In preparation for adding support for more event
types, introduce an event id enum and a generic event source structure, and
replace wakeup-specific data in struct st_lsm6dsx_event_settings with an
array of event source structures.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  20 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 146 ++++++++++++-------
 2 files changed, 106 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index a4f558899767..80bc5686454b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -242,14 +242,22 @@ struct st_lsm6dsx_shub_settings {
 	u8 pause;
 };
 
+enum st_lsm6dsx_event_id {
+	ST_LSM6DSX_EVENT_WAKEUP,
+	ST_LSM6DSX_EVENT_MAX
+};
+
+struct st_lsm6dsx_event_src {
+	struct st_lsm6dsx_reg value;
+	struct st_lsm6dsx_reg status;
+	u8 status_x_mask;
+	u8 status_y_mask;
+	u8 status_z_mask;
+};
+
 struct st_lsm6dsx_event_settings {
 	struct st_lsm6dsx_reg enable_reg;
-	struct st_lsm6dsx_reg wakeup_reg;
-	u8 wakeup_src_reg;
-	u8 wakeup_src_status_mask;
-	u8 wakeup_src_z_mask;
-	u8 wakeup_src_y_mask;
-	u8 wakeup_src_x_mask;
+	struct st_lsm6dsx_event_src sources[ST_LSM6DSX_EVENT_MAX];
 };
 
 enum st_lsm6dsx_ext_sensor_id {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index a09df9d772dd..e8f0a2ff91be 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -388,15 +388,21 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			},
 		},
 		.event_settings = {
-			.wakeup_reg = {
-				.addr = 0x5B,
-				.mask = GENMASK(5, 0),
+			.sources = {
+				[ST_LSM6DSX_EVENT_WAKEUP] = {
+					.value = {
+						.addr = 0x5b,
+						.mask = GENMASK(5, 0),
+					},
+					.status = {
+						.addr = 0x1b,
+						.mask = BIT(3),
+					},
+					.status_z_mask = BIT(0),
+					.status_y_mask = BIT(1),
+					.status_x_mask = BIT(2),
+				},
 			},
-			.wakeup_src_reg = 0x1b,
-			.wakeup_src_status_mask = BIT(3),
-			.wakeup_src_z_mask = BIT(0),
-			.wakeup_src_y_mask = BIT(1),
-			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -554,15 +560,21 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			},
 		},
 		.event_settings = {
-			.wakeup_reg = {
-				.addr = 0x5B,
-				.mask = GENMASK(5, 0),
+			.sources = {
+				[ST_LSM6DSX_EVENT_WAKEUP] = {
+					.value = {
+						.addr = 0x5b,
+						.mask = GENMASK(5, 0),
+					},
+					.status = {
+						.addr = 0x1b,
+						.mask = BIT(3),
+					},
+					.status_z_mask = BIT(0),
+					.status_y_mask = BIT(1),
+					.status_x_mask = BIT(2),
+				},
 			},
-			.wakeup_src_reg = 0x1b,
-			.wakeup_src_status_mask = BIT(3),
-			.wakeup_src_z_mask = BIT(0),
-			.wakeup_src_y_mask = BIT(1),
-			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -791,15 +803,21 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(7),
 			},
-			.wakeup_reg = {
-				.addr = 0x5B,
-				.mask = GENMASK(5, 0),
+			.sources = {
+				[ST_LSM6DSX_EVENT_WAKEUP] = {
+					.value = {
+						.addr = 0x5b,
+						.mask = GENMASK(5, 0),
+					},
+					.status = {
+						.addr = 0x1b,
+						.mask = BIT(3),
+					},
+					.status_z_mask = BIT(0),
+					.status_y_mask = BIT(1),
+					.status_x_mask = BIT(2),
+				},
 			},
-			.wakeup_src_reg = 0x1b,
-			.wakeup_src_status_mask = BIT(3),
-			.wakeup_src_z_mask = BIT(0),
-			.wakeup_src_y_mask = BIT(1),
-			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -1028,15 +1046,21 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(7),
 			},
-			.wakeup_reg = {
-				.addr = 0x5b,
-				.mask = GENMASK(5, 0),
+			.sources = {
+				[ST_LSM6DSX_EVENT_WAKEUP] = {
+					.value = {
+						.addr = 0x5b,
+						.mask = GENMASK(5, 0),
+					},
+					.status = {
+						.addr = 0x1b,
+						.mask = BIT(3),
+					},
+					.status_z_mask = BIT(0),
+					.status_y_mask = BIT(1),
+					.status_x_mask = BIT(2),
+				},
 			},
-			.wakeup_src_reg = 0x1b,
-			.wakeup_src_status_mask = BIT(3),
-			.wakeup_src_z_mask = BIT(0),
-			.wakeup_src_y_mask = BIT(1),
-			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -1209,15 +1233,21 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(7),
 			},
-			.wakeup_reg = {
-				.addr = 0x5B,
-				.mask = GENMASK(5, 0),
+			.sources = {
+				[ST_LSM6DSX_EVENT_WAKEUP] = {
+					.value = {
+						.addr = 0x5b,
+						.mask = GENMASK(5, 0),
+					},
+					.status = {
+						.addr = 0x1b,
+						.mask = BIT(3),
+					},
+					.status_z_mask = BIT(0),
+					.status_y_mask = BIT(1),
+					.status_x_mask = BIT(2),
+				},
 			},
-			.wakeup_src_reg = 0x1b,
-			.wakeup_src_status_mask = BIT(3),
-			.wakeup_src_z_mask = BIT(0),
-			.wakeup_src_y_mask = BIT(1),
-			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -1415,15 +1445,21 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x50,
 				.mask = BIT(7),
 			},
-			.wakeup_reg = {
-				.addr = 0x5b,
-				.mask = GENMASK(5, 0),
+			.sources = {
+				[ST_LSM6DSX_EVENT_WAKEUP] = {
+					.value = {
+						.addr = 0x5b,
+						.mask = GENMASK(5, 0),
+					},
+					.status = {
+						.addr = 0x45,
+						.mask = BIT(3),
+					},
+					.status_z_mask = BIT(0),
+					.status_y_mask = BIT(1),
+					.status_x_mask = BIT(2),
+				},
 			},
-			.wakeup_src_reg = 0x45,
-			.wakeup_src_status_mask = BIT(3),
-			.wakeup_src_z_mask = BIT(0),
-			.wakeup_src_y_mask = BIT(1),
-			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -1935,7 +1971,7 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 	if (val < 0 || val > 31)
 		return -EINVAL;
 
-	reg = &hw->settings->event_settings.wakeup_reg;
+	reg = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].value;
 	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
 	err = st_lsm6dsx_update_bits_locked(hw, reg->addr,
 					    reg->mask, data);
@@ -2420,6 +2456,7 @@ static bool
 st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 {
 	const struct st_lsm6dsx_event_settings *event_settings;
+	const struct st_lsm6dsx_event_src *src;
 	int err, data;
 	s64 timestamp;
 
@@ -2427,13 +2464,14 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 		return false;
 
 	event_settings = &hw->settings->event_settings;
-	err = st_lsm6dsx_read_locked(hw, event_settings->wakeup_src_reg,
+	src = &event_settings->sources[ST_LSM6DSX_EVENT_WAKEUP];
+	err = st_lsm6dsx_read_locked(hw, src->status.addr,
 				     &data, sizeof(data));
 	if (err < 0)
 		return false;
 
 	timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
-	if ((data & hw->settings->event_settings.wakeup_src_z_mask) &&
+	if ((data & src->status_z_mask) &&
 	    (hw->enable_event & BIT(IIO_MOD_Z)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
@@ -2443,7 +2481,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
 
-	if ((data & hw->settings->event_settings.wakeup_src_y_mask) &&
+	if ((data & src->status_y_mask) &&
 	    (hw->enable_event & BIT(IIO_MOD_Y)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
@@ -2453,7 +2491,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
 
-	if ((data & hw->settings->event_settings.wakeup_src_x_mask) &&
+	if ((data & src->status_x_mask) &&
 	    (hw->enable_event & BIT(IIO_MOD_X)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
@@ -2463,7 +2501,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
 
-	return data & event_settings->wakeup_src_status_mask;
+	return data & src->status.mask;
 }
 
 static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
-- 
2.39.5


