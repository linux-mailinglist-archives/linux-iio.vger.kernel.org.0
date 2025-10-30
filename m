Return-Path: <linux-iio+bounces-25640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B4C1EBE2
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE2C74E72B8
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 07:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1A2337109;
	Thu, 30 Oct 2025 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1cwqcG3R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3087336EE0
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809279; cv=none; b=HgtiGOQ753EE9zCW0xwjhL/dbCazyG0E80kCE0FuhE1Qj2R+/pYFqkhIdm5Je39xxsft74DQrkB+MEe8Hy1YegIqDzasyg9TarAuML+9mwpTyHWZKAjUidrWFG1rjz+VLKrGXN2uUjpfRlYJdt9oiG+1NTsUkpFy4z4Lotve4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809279; c=relaxed/simple;
	bh=3i6TmZy38WX7WjId5K7zj8RwsRnHvMYK+XMl1I3L4Vg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JhizEs+jtWAqlJUupgu47Y4owqFEOZMwRo4aMxAH6ccD73sP/Wlw53pmx1t91VR7Zdl6laQeW9S3o+qVzKNtKEsYl6LMG1/RkRfe/wR+3Q/mgTFBSPi6hJVS/Oh9KV5sIFmOa3R391c7H1u5x9WQy2JMl08DgN3K3K6Pi2lEzmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1cwqcG3R; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b5e19810703so101275366b.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 00:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761809276; x=1762414076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSmb/SMvgajuw0XM3CeiqPJTigcBiO6jLs/P2xRmhdg=;
        b=1cwqcG3RUe6aFyATRm95Bvf9ZNHazagYXzYBK0RxW3c/G4Sz6hRMZUnmalY7R220nC
         I32sRMkKcSoYrhuV66kr5FJaFJXE+K46cy38cZZg3zEFGBCGvN8qwvAfxKddDdEViobF
         FUTZnumzOa2Nft0Q6EeygB+uQlpzo0NfjZ8rEKNjJWsl8FPC92zHWMG6jXdoIM9Mixaw
         Z0Ciphef7YBTLvTHSpEG76fpVElGLSBGi3HJM37smk/S4vRez4VdlLitBChjizhZTrIf
         py58BuU0h7kqNf6YKGQzNWZQkOoB+raEDtbSRfKQRtZUpkwk1L7XdsAw9y9vRJAtVhGk
         +c6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809276; x=1762414076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSmb/SMvgajuw0XM3CeiqPJTigcBiO6jLs/P2xRmhdg=;
        b=h0Rd0KUyGAbYOoLFGsAX59EhPHLg9b/Lda8ldH8JMDA9Cgb/FZbsUwe+BsM78I4SHI
         Ys+luVdDHD/RId4yG4879CMC9d0MZP2gFIlE299xNbcAcCgUG81oyhlI40Z5QWm+23Ou
         NCPyj6erZKOa9C3DyiHi0Cg3yneysaBU5UMAxcYRIRluFkd+F6QIcvqtJgYSRVnOkftU
         FcUPXuo5PT42J+I7GWyOAjSiP6s+v0Orz54AkE80sKX79lW+BcCDtWiMjjqZ6WaGISL+
         pBwCxgXAue0UvCPZVRggmBB+yD913qFh0WuwAoRoOL54bWmZ+wr/OpR4oZe/ZaU7cOO1
         Q7yA==
X-Forwarded-Encrypted: i=1; AJvYcCWTDF8rCACP0MYF+JTk6rJImU6NLZMtAhCF3hCyVCInXyr9DpIgFgkpFV7Glyb57yprJRwBJrFt364=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm1sCC3/0DLlIf84qRNsJYBkhKtARdyBuYIc9p3M4GVJGrUDAR
	1qYX8U55AMcBLaVRPCXpuc3l+NAvfXKVGw65769D+Hc4HXWapGqXU/J1JH399U6Kyn4=
X-Gm-Gg: ASbGncsCqgMNEg7n8tkqreJycYYQta/yfliOzq95ZAzU8jMYjepb4EwkymOt6/lqJTU
	85KvZ5NMo9R9MpV0W968etyOs+Rl5n6GttaVR0bk1BmzCddpA5vMjJiJaUZNDb0TAqwpicbz8+c
	ZMLfdSM0ob6zNfluLtpD3O4nDCtwusBNpdbxTX6qJvKB6+mCccGvAH94cFzSjuNHqXyXs3HFP/8
	aN9Wuhf12ECv4EzfIWXGqMwzSbVrwk182GMZ8rJz7JQhCZCwR3G1LCaaq9/7AIaZTzeQ46baMJK
	CGjWBZsp018YFQrr/5yNBHEpefcIEhZB3wIONzb/ds2mzPi6NFYq7UNxQfykxujR2EzPkhUWGd4
	Np550RrNx8pY0Inp8dAfS+zK+9DoizRmZQe3cyIqeb1ZUvs2jS/fazQ78Z1AfGoNupsx8OfSJAP
	v3fP+rGqeIPQC0kk+IqT0i3pvyWw==
X-Google-Smtp-Source: AGHT+IHGOFhWIN+SV4j2Me3OHGGwVE+Gn++jUOxTVSTpnIdG/QQBUMUulH0Be6RC9euvGOaBVOjjbA==
X-Received: by 2002:a17:907:72c4:b0:b45:60ad:daf9 with SMTP id a640c23a62f3a-b7053b0cf7amr200573266b.3.1761809276149;
        Thu, 30 Oct 2025 00:27:56 -0700 (PDT)
Received: from localhost (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853f98adsm1636197366b.49.2025.10.30.00.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:27:55 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] iio: imu: st_lsm6dsx: make event_settings more generic
Date: Thu, 30 Oct 2025 08:27:45 +0100
Message-Id: <20251030072752.349633-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251030072752.349633-1-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8864; i=flavra@baylibre.com; h=from:subject; bh=3i6TmZy38WX7WjId5K7zj8RwsRnHvMYK+XMl1I3L4Vg=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpAxNIlCNm6znDWf19r1q0ljsU0Akp3kpaTA5jk S1Tpv4QB66JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaQMTSAAKCRDt8TtzzpQ2 X+QcDACbVDo/H7DUrCyRumfJV1cFjgV8pyb3qpzMK7JgXPL+a1NW6oPgLXYtFA5jP/xiLZ0D5QF moJGjq92wH8yLpQkLjW9nkUGmcscDCgJmoRHGSTJ5+ydr6NcRyb72fzVvVbKISzfMSOOw3mbeGZ byN+bJA0f/I+5+XnABmBd5758KovWJi4UQlPo3PPAHBS4Y/BmeaVnPWEIP3Nfg9FcrngEX8ybOF RYxHbtPfnxxboAffPsoKS2F2LMAsC87/7D9U6Ee/4SAH3g/bHnt0x9aQEgn+S+PC+Q0TQhi8FmY r8+I1rvKLtS98apzXQhLbdKkPE+E8TDmvMMXB1CrOpgDRwBRb6CvYEdtPHmVSVHMy9ZQK3AavR7 wpbi+V7MqP//Np6li8L2r87YGTqzi1EQVjXAMmihd8nJDoIOSTkWRWB0ktIIaCtVX8UWvUVougT 73E6NlHODNIKQPjYp2MTNrpGSeMn6Fb3gDvq1pgfSqCEBgopJm1s41W58l00e/BzJOaY4=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_event_settings structure contains fields specific
for one event type (wakeup). In preparation for adding support for
more event types, introduce an event id enum and a generic event
source structure, and replace wakeup-specific data in struct
st_lsm6dsx_event_settings with an array of event source structures.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  21 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 136 +++++++++++--------
 2 files changed, 96 insertions(+), 61 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index db863bd1898d..05689887f7ec 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -221,14 +221,23 @@ struct st_lsm6dsx_shub_settings {
 	u8 pause;
 };
 
+enum st_lsm6dsx_event_id {
+	ST_LSM6DSX_EVENT_WAKEUP,
+	ST_LSM6DSX_EVENT_MAX
+};
+
+struct st_lsm6dsx_event_src {
+	struct st_lsm6dsx_reg value;
+	u8 status_reg;
+	u8 status_mask;
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
index 17b46e15cce5..bb4c4c531128 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -350,15 +350,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+					.status_reg = 0x1b,
+					.status_mask = BIT(3),
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
@@ -510,15 +514,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+					.status_reg = 0x1b,
+					.status_mask = BIT(3),
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
@@ -741,15 +749,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+					.status_reg = 0x1b,
+					.status_mask = BIT(3),
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
@@ -972,15 +984,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+					.status_reg = 0x1b,
+					.status_mask = BIT(3),
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
@@ -1147,15 +1163,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+					.status_reg = 0x1b,
+					.status_mask = BIT(3),
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
@@ -1347,15 +1367,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+					.status_reg = 0x45,
+					.status_mask = BIT(3),
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
@@ -1861,7 +1885,7 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 	if (val < 0 || val > 31)
 		return -EINVAL;
 
-	reg = &hw->settings->event_settings.wakeup_reg;
+	reg = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].value;
 	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
 	err = st_lsm6dsx_update_bits_locked(hw, reg->addr,
 					    reg->mask, data);
@@ -2318,7 +2342,7 @@ static int st_lsm6dsx_chan_init(struct iio_chan_spec *channels, struct st_lsm6ds
 	chan->scan_type.endianness = IIO_LE;
 	chan->ext_info = st_lsm6dsx_ext_info;
 	if (id == ST_LSM6DSX_ID_ACC) {
-		if (hw->settings->event_settings.wakeup_reg.addr) {
+		if (hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].value.addr) {
 			chan->event_spec = &st_lsm6dsx_event;
 			chan->num_event_specs = 1;
 		}
@@ -2389,6 +2413,7 @@ static bool
 st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 {
 	const struct st_lsm6dsx_event_settings *event_settings;
+	const struct st_lsm6dsx_event_src *event_src;
 	int err, data;
 	s64 timestamp;
 
@@ -2396,13 +2421,14 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 		return false;
 
 	event_settings = &hw->settings->event_settings;
-	err = st_lsm6dsx_read_locked(hw, event_settings->wakeup_src_reg,
+	event_src = &event_settings->sources[ST_LSM6DSX_EVENT_WAKEUP];
+	err = st_lsm6dsx_read_locked(hw, event_src->status_reg,
 				     &data, sizeof(data));
 	if (err < 0)
 		return false;
 
 	timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
-	if ((data & hw->settings->event_settings.wakeup_src_z_mask) &&
+	if ((data & event_src->status_z_mask) &&
 	    (hw->enable_event & BIT(IIO_MOD_Z)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
@@ -2412,7 +2438,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
 
-	if ((data & hw->settings->event_settings.wakeup_src_y_mask) &&
+	if ((data & event_src->status_y_mask) &&
 	    (hw->enable_event & BIT(IIO_MOD_Y)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
@@ -2422,7 +2448,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
 
-	if ((data & hw->settings->event_settings.wakeup_src_x_mask) &&
+	if ((data & event_src->status_x_mask) &&
 	    (hw->enable_event & BIT(IIO_MOD_X)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
@@ -2432,7 +2458,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
 
-	return data & event_settings->wakeup_src_status_mask;
+	return data & event_src->status_mask;
 }
 
 static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
-- 
2.39.5


