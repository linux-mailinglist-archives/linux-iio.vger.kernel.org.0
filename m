Return-Path: <linux-iio+bounces-26464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C86F8C87033
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 21:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4724B34FC27
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 20:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CD033BBC4;
	Tue, 25 Nov 2025 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HuztxCei"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FA338591
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102195; cv=none; b=VUyn14F/sq1GJRdLwn52ESCWtlAaV8Ady9UaaDb70saZcDci3vr7ci2Oz+Ch5+jA1DgmCNXQ5Sx8QUatq7A5v2K1rvqUkWmH0MXarIbh/k0GcuTkz/EDZoTleEEFnID3Z/hj8m7eIt4Bdbg7IOonVZ9OEpWB9dLhb8PK5b4xmbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102195; c=relaxed/simple;
	bh=n+tWKmHDIKPoB17m8PDbku2hGkPzuoaQtqpngbiJb08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7t25+UgeT6vqoSDdVw6526dLSMraQr8Jc4+wrxPSOXPiSA+jtZSDPVIXKZAKrAqzUgpXzDIORuG6xGdfvk5z44qZQ50lkZExSuceTMLzGHPZ0lkES2oyvnEMb2zwVMppEac5irPsTQoYMTuEbXpKPlfCj/kkqQBS5NmmRgJCzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HuztxCei; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7277324054so887203466b.0
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 12:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764102191; x=1764706991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOpKIjBtp3jglLtC7+Xd90dUysNa5e26fWUT0wH80JA=;
        b=HuztxCeiVe92DKROSPOp2IvlK5b4QDJL/SzE9O1GIOTlIFFp6BZzxhkFElJAJKVDg3
         qkWPSiuVSmPdSAbsvAZ60ydZp+9M1Pggq/fp+coTjG7t00MIPW0UxibtsLBKAKEpacnp
         gtmKGJA+uKDU1p9b+hl2gegti88datzNW8sDs8DA8Uia2Jd31UedKK+WuVKcNNms5zpe
         fKjUKCcZteYVtOIjO78bWSqSzFpcrlkaMZWzUhKExkNwW1OkpOb9EwBFnP9qK+NsVjzR
         pxMce8RPwTz2+1o/kGB4MJ/wiJz1MnW6/Sw2P3AFYDbTDcOQVpsXQQi+sEQp5rWyqiSi
         FaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102191; x=1764706991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BOpKIjBtp3jglLtC7+Xd90dUysNa5e26fWUT0wH80JA=;
        b=IKrIxunczU3AXh94+2JumrOgb59D+uobafm3hoKpQVcsoHcMrclgUx2GLBfhWvksQi
         t0CPbqsiskO6f3Z1KVj10r5rc3xvfITGwh1BRv9nOjmAAuRrt882vs8XMQJxtgpXaOdQ
         BUMPlKSyVA8IokKPBBM5G51dCZ42eYZUYXKHzuBq8Bb7mDN4LBaPAfOVFWA1kaKiOTAC
         tRBwvn0QYsHZVubQgtuLFnpgwbxCtGpUU/j54SJDa8g2bJ1fuu6ldrRR+cKQFm43BR2w
         rJVLvCfg4D9VEog2CI5u8H8aSZc8zQXpp2zMMt6oJjta1ei4drN5SmYbS2p+MyiP3xoo
         Gv4w==
X-Forwarded-Encrypted: i=1; AJvYcCXdlXVdHUveK1CIasoqM8e/BGKAl78ZhRb250dCqtL8orH4fzfIOmDUDsmMQZAJVppft+TBi83Uf+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSDnH44jrhoLdZXFhidabQdtnx1nBYcDHou+UBBGLFvskqMVK
	3md3feS512W2ufu0FK1XzVARIXfeuOoOtxzkrNScEjkwn6IhnROhH/6uMhZpVB4vK30=
X-Gm-Gg: ASbGnctQF/YfkcpChockP1xpZ5gquiCaamVbQMMNncVHE9Hi6louIokWFT19tCOTd3l
	GbnCj7kVST0zSDwVzZxA0GcNKNvJnTgztuDmHr22aSiSvUJtb35EwRxoVcdivnmXeBrv1fYMRd0
	pWE84EWRGwaCMG3YlSh331BxYTnvLjihTJJpO/19KC8ajpReTtLx78FydoWG7rHhQGDpXe7BEWk
	elj0GVb9NyfQJrQpgrHnRACS00xHyZjsRtTKPnm/OYaEg5LEnwH7AEDM9/oGnkx5+wjXNPcdAKa
	ABIJylNiyLx4zwOt/VxmEk0CM2uLsXIESi1YdDNNWyVqK6UIQJ/L5l/dyhl1JVpAMeO1cy4o+BD
	muH2YeCjokjG6jIf3vtl5YCoHDNnB+/cTQqAxVKosdgDVU+H8NbHruBk8CeE92Ylrj2OM
X-Google-Smtp-Source: AGHT+IFED+wA1aUsDmv+jMUwUksL6v6VocPD4iFOHhGx7FNewLdGFJ4OwYIvMKUrk83F0B/Ohwgvaw==
X-Received: by 2002:a17:907:9610:b0:b73:4d06:bc8 with SMTP id a640c23a62f3a-b76718c224fmr1795378666b.53.1764102191277;
        Tue, 25 Nov 2025 12:23:11 -0800 (PST)
Received: from localhost ([151.35.128.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d7cbebsm1682751666b.29.2025.11.25.12.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:23:11 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 2/9] iio: imu: st_lsm6dsx: make event_settings more generic
Date: Tue, 25 Nov 2025 21:23:00 +0100
Message-Id: <20251125202307.4033346-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251125202307.4033346-1-flavra@baylibre.com>
References: <20251125202307.4033346-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8599; i=flavra@baylibre.com; h=from:subject; bh=n+tWKmHDIKPoB17m8PDbku2hGkPzuoaQtqpngbiJb08=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpJhACqZsTWGnvQ5y4mMPFAjXdt7beAc/oZJiro kTDzMLWF1KJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSYQAgAKCRDt8TtzzpQ2 X2bLC/9pm2QXnG8WLW278XKBGD245lf6bs11d/RI8bOF4kmYtxeth624IcXdXncZ/WG/LqTwf6/ MBgbxnImSh028iKu2K+cGCHnSj3RR2S6dBl2a7ctjFFLbECMsldd3fCc2J9k4sIwiqCbIrph4ZA /QXlRJ3l4orhqXyX9IfJuhprcVvnhO16Nn5vI+XnFoQJ6a1mrg0Gw28eJoivyzRwm1UTMTeZYgG XnUs/+C0VR2kyz6TOqcF+3QPNrm1TazgC47sT+SLh8nigFJpHbodc0aDJ4Z3t1egaj3H+Ecu3+7 T5aPTgPB0f97bgo/dcSvOFTYbJrMDlp3ZSzY66hrL5AynuhCKIU3+KcU7PvrFwOICmlE9Qf2JPR LEr0cmJ4vmvKK2SY34eJqLwl1DQld1wOUsKfjLrvnLhadJQaAo02yzEciKVBRVn9ze+mw+Etoya ionr8juGD1O+a2OolRs13yMRv+OuHrdpbOkergtjcaal3uUmrvNeskatjFDfMEYyF9ZBw=
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


