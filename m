Return-Path: <linux-iio+bounces-26471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A9C8705D
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 21:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D33164EBE57
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 20:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9758C33F37A;
	Tue, 25 Nov 2025 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="klVG/I8J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA4A33EAF8
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102204; cv=none; b=uBJRlZ/N8l6U6tGYG74apTUe+uy8Br4ws8gxDqsx007F6AdakGPGU2CBPsd3IzsOaEOtjk969nOuUSmNTRD47miiem05p583TG6Lbv6eBt+x7p5wdUeIg4zSFf8l2/A17BBhLp796UZVrhRoXId6Jw7ZnKimxoh+2LEicXgMhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102204; c=relaxed/simple;
	bh=fPKQq9VW/0IRfnIwOJhKfq8568r/UARLM1IVoAPX3D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qk6hlRy/NQGg8mGh6MGk80M/Xe0cOBR2LZws4BTFLM5j+QPc70OJaJQQ8Z7WjVU30w4cLRgmDADDxvecdd2tEsTk8eC78ISBhiNF43ZMN0I6F8z6BuzGgSDCgyIgVHlPEqYYvIyVE0zP5kwSlgx/GG0+gVHRJnApra+FUkvR91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=klVG/I8J; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so8913854a12.0
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 12:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764102201; x=1764707001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu3VlZP+h+37IpIE5wmYW7UTzGfSy7LB4iu6rGw2cJQ=;
        b=klVG/I8J48rmDVma7mgOYkNsiq85wqSx9V1Uf0GPpvl/fkbpA0jvll0y5V52lT/E5A
         Q8PQS9CjVM14viE+sgJiIklKmNkiVOMkKrJachUWP5fHNumEP90P9vOQk5nlWf/FUArE
         /V2WAIDykOhUWmTrFqrNZJyod22f9NNHU7gthpdLnWb1jVzgEsWBCnjDdEx1UlS9NRq6
         xXh7xo1zYFNQFs7tKC28tYFWixoaa0GjHepSfvZ2lqewJ3BODkEeL6RzOJeuTgNJ8m3J
         WRyL3YzlT6lSUBJs9/8YthLb0j+IEc/n2ApDH62mVE2hkvPYSpI9m5+8vY+z6AbnhYZ5
         agTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102201; x=1764707001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lu3VlZP+h+37IpIE5wmYW7UTzGfSy7LB4iu6rGw2cJQ=;
        b=iAb5b8bdAuThp6p/6JR5CSWxx07teYTqEgup+QX+A2CeoynRuyvwu8D3oj321S2Y9U
         P0C+16nm4IuyiY1nC/+cT5KkAMxYD00oW0Z7JXWgzmF2/IjfX8/yXEW5Zow/K559/51q
         gi30hmQMZQHYasu/MPNxSnVMyIeptpQJ+IYaMF7dpAA3Ae4dbM6ek1q493qPjuQRRLmo
         SJGhZBJquB0luPOruFumzkNIdnFRBXVv1QRbJTSsS+yI2tp8C/b85CwK/Ks2sdyjJ8zN
         96Q/4yvGP6PFVeMzB6YTQ/96sFP3R1Ecl+k8e9+BeObyHHFKVZLJrjeLDr5whdJaAwGI
         uq1g==
X-Forwarded-Encrypted: i=1; AJvYcCWI8Bdw+06oNhntTDHW8OA89OSJyrp434SoxMz7AgpLQR4P+/++kWxEm90ErDXswYe57KGxRMBAZDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcK/bMqxAoE5uVf1rbyhCbtHlfoNSMiJ/xC85bbMPB3UmAyBo+
	j7YpmnStbHctKp6FhXeUuxasWIpDzcsi18aT3DjYGZ9BqG4Y/1vIE8KmNTtpiDDwAlo=
X-Gm-Gg: ASbGncu2x5qphLq9yl9nEvve4pXDR6DKxQCDbpok6eiyomjbnnw8PP/OmzLS3WwJ2kg
	lSJewELTMH0vF5sLJ2PaXFk6JtEmenk0P3Tdu/jsN/vzUSjZIMiOc65tZyoP0Z6vdQVmhyhU4DY
	RV34L0YYJrI/EcXLqbPtJfFoEqxxlI2M81fgYVnZ0Wx5vIDdt7P6apCKzfwttN2qGHdzKHd/BbF
	r7nQ3u3wtHz07/u/dECez8cufrGpzBazcso+COOzIAAh7oziTGexWiV5XeWEmj7eu0lbeDwzdSl
	CZk2YTHIWNmHjVGwkZeh5dY51nLKUlN9Y+VBXqCJWkylBvg7GD1l4INgwRX2cjAnb7Y3CA2UsON
	+u6q/kPo1lz0ZJvH4VN7PHn+vXdmcjXycmp/tLmQr6zCagfTfI0C/CFa23ytkR1aDVjJ269utdC
	ofOQ==
X-Google-Smtp-Source: AGHT+IFFxu6lRPjOwtB3ddihvruy9A2yx5MCC3G4mEdVQ/CR9Ep4cTGk5NZUtjWETohOzfRwr+REtg==
X-Received: by 2002:a05:6402:1ed2:b0:643:83f3:1b9f with SMTP id 4fb4d7f45d1cf-64554691819mr14495817a12.31.1764102200752;
        Tue, 25 Nov 2025 12:23:20 -0800 (PST)
Received: from localhost ([151.35.128.119])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453645f2easm15731147a12.33.2025.11.25.12.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:23:20 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 9/9] iio: imu: st_lsm6dsx: add tap event detection
Date: Tue, 25 Nov 2025 21:23:07 +0100
Message-Id: <20251125202307.4033346-10-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251125202307.4033346-1-flavra@baylibre.com>
References: <20251125202307.4033346-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4582; i=flavra@baylibre.com; h=from:subject; bh=fPKQq9VW/0IRfnIwOJhKfq8568r/UARLM1IVoAPX3D0=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpJhAFZUzSspl8rRCYGkd5xsAkHOgNqFIknAJX5 kQzb/3nSQKJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSYQBQAKCRDt8TtzzpQ2 X8t/C/4+/yYGE6L2EJTqkqd4ZyypsfHo7VvWgFUuRkdZza9w4bvvl3uILk/YLonmqEFjOzeZiLg 2SJuhH0a4qnupHzwbb+kRDb6s/ANpZsnIryv0hlDIg4gXDY/NwG/VOcVsTVHRNDO+DasHBsEes4 KE6G1SjeV4GWedbvHvR1Nx3rrrnYZJgtyw0WPHwNsSzt9ACzAKatxjn7JA0Jzdgrb7jIT13jJW4 UNsTI6QuX8V4LMohiJq5ic3Z0XetjWZbq+AgYqm4qRbHZg6wGkDQm1MdlkdbaZ9qvpai9w6Z0vN LavEZLH0s8Mg+Q0AAswiVOt4s37J5UzzlDhTPFj3gSPp+uZqGhC6mFoAlo/ppy1AvMuSxJaJjrR Hzf2JgW/8kinPTNMFpo+I8hLU4pyZha1cajGqlbi7jsxSRTfL0MMlDiBkoFl5qNRgwBomyWReof aY42YJXGyaLkSl+r0ChKm2IhLUp8QXdqURB9tYslmuAIscaro3ShrOAM09m1LfGxKMzpg=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In order to allow sensors to advertise tap event capability and report tap
events, define a new struct iio_event_spec array that includes a tap event
spec, and a new struct iio_chan_spec array that references the new
iio_event_spec array; for the LSM6DSV chip family, use the new
iio_chan_spec array and define an event source for tap events.
Tested on LSMDSV16X.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 57 +++++++++++++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 3edff8456a8f..957dae73e13d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -245,6 +245,7 @@ struct st_lsm6dsx_shub_settings {
 
 enum st_lsm6dsx_event_id {
 	ST_LSM6DSX_EVENT_WAKEUP,
+	ST_LSM6DSX_EVENT_TAP,
 	ST_LSM6DSX_EVENT_MAX
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index e1eb64a5b10d..1c70d8d80541 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -105,6 +105,21 @@ static const struct iio_event_spec st_lsm6dsx_ev_motion[] = {
 	},
 };
 
+static const struct iio_event_spec st_lsm6dsx_ev_motion_tap[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_SINGLETAP,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
 	ST_LSM6DSX_CHANNEL_ACC(0x28, IIO_MOD_X, 0, st_lsm6dsx_ev_motion),
 	ST_LSM6DSX_CHANNEL_ACC(0x2a, IIO_MOD_Y, 1, st_lsm6dsx_ev_motion),
@@ -119,6 +134,13 @@ static const struct iio_chan_spec st_lsm6ds0_acc_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec st_lsm6dsx_acc_tap_channels[] = {
+	ST_LSM6DSX_CHANNEL_ACC(0x28, IIO_MOD_X, 0, st_lsm6dsx_ev_motion_tap),
+	ST_LSM6DSX_CHANNEL_ACC(0x2a, IIO_MOD_Y, 1, st_lsm6dsx_ev_motion_tap),
+	ST_LSM6DSX_CHANNEL_ACC(0x2c, IIO_MOD_Z, 2, st_lsm6dsx_ev_motion_tap),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
 static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
 	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x22, IIO_MOD_X, 0),
 	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x24, IIO_MOD_Y, 1),
@@ -1260,8 +1282,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 		},
 		.channels = {
 			[ST_LSM6DSX_ID_ACC] = {
-				.chan = st_lsm6dsx_acc_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
+				.chan = st_lsm6dsx_acc_tap_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_acc_tap_channels),
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.chan = st_lsm6dsx_gyro_channels,
@@ -1438,6 +1460,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.status_y_mask = BIT(1),
 					.status_x_mask = BIT(2),
 				},
+				[ST_LSM6DSX_EVENT_TAP] = {
+					.x_value = {
+						.addr = 0x57,
+						.mask = GENMASK(4, 0),
+					},
+					.y_value = {
+						.addr = 0x58,
+						.mask = GENMASK(4, 0),
+					},
+					.z_value = {
+						.addr = 0x59,
+						.mask = GENMASK(4, 0),
+					},
+					.enable_mask = BIT(6),
+					.enable_axis_reg = 0x56,
+					.enable_x_mask = BIT(3),
+					.enable_y_mask = BIT(2),
+					.enable_z_mask = BIT(1),
+					.status = {
+						.addr = 0x46,
+						.mask = BIT(5),
+					},
+					.status_x_mask = BIT(2),
+					.status_y_mask = BIT(1),
+					.status_z_mask = BIT(0),
+				},
 			},
 		},
 	},
@@ -1952,6 +2000,8 @@ st_lsm6dsx_get_event_id(enum iio_event_type type)
 	switch (type) {
 	case IIO_EV_TYPE_THRESH:
 		return ST_LSM6DSX_EVENT_WAKEUP;
+	case IIO_EV_TYPE_GESTURE:
+		return ST_LSM6DSX_EVENT_TAP;
 	default:
 		return ST_LSM6DSX_EVENT_MAX;
 	}
@@ -2620,6 +2670,9 @@ static bool st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 	events_found = st_lsm6dsx_report_events(hw, ST_LSM6DSX_EVENT_WAKEUP,
 						IIO_EV_TYPE_THRESH,
 						IIO_EV_DIR_EITHER);
+	events_found |= st_lsm6dsx_report_events(hw, ST_LSM6DSX_EVENT_TAP,
+						 IIO_EV_TYPE_GESTURE,
+						 IIO_EV_DIR_SINGLETAP);
 
 	return events_found;
 }
-- 
2.39.5


