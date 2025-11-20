Return-Path: <linux-iio+bounces-26333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BBAC72E6E
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 09:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99F4835BA1A
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75819325734;
	Thu, 20 Nov 2025 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IyJZS54h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0788830FF24
	for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627187; cv=none; b=ZbpZOAtGExhuFvHBToy/0WbinD930cf0VjmixOIP0OY0y+IBsYoNcIxWtnsTQvwh7aSO0jzQvXNl5nN1fq0MXS3xDr+COToIDBRjFMHy58/0QHhQp6BbWKQEQGsvso6DUZUqfcI8TFLHRZLN5Y586ivcdYtKZfEQ8OuOXcH0aLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627187; c=relaxed/simple;
	bh=NvUI5aXQ+dzQGpbFuILdCLUkAgQReaU1kD9uDURqAcA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tC7OGBib8t624HjDkTgpAdPFZ69ThBUp9yJpH3tt5QXXlU6/jss2CuKaGjFeYCeHy9ioMJC3wj/PtlObHrokEW1l7yqFRGVSGXg6v0buEl/fNN2c53ehp2UtygKyU207iNRQFd7wZ0z7+d07NVdOdaMcHxMR5fbBpHms5AzOiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IyJZS54h; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477632b0621so3952275e9.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 00:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763627183; x=1764231983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j20uSIc1dPSouiwWtpqYLhuamnLIKHo+zwTXtyi4/Rk=;
        b=IyJZS54hJnJahV9aaK+VjjNo9F98lq4U+2+ssKGpQfj/9dqiR/fghvQWy7YFPNIh1N
         GV10Wr1JzORJ4IdR3Sb+X/c7KPzl5RSwUBfnTItJDNcxoSBKRXP92ou8993W3rAaTotQ
         /z4gXZ1UydOL2VEf0gZVzXJ/SKxyLvD8EvdsYttxvEu6KDli//C/00gECGo7dhC7LD6W
         8VRLgR4F7HAtOULPzlmOqrREbOwXQDRyTK+I9RsFQpG93+qFl8c7NzzUiD2psN8inX83
         Nh1wC9rgLk7p2+4O/nU7kUxQ5MfqoVZgoLDxnqiz6L6aPUutKRPkFpQe8yBNgO44ORE5
         6m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763627183; x=1764231983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j20uSIc1dPSouiwWtpqYLhuamnLIKHo+zwTXtyi4/Rk=;
        b=N/luC6rOfedAI9mMz0BD2oxfuezwJ+lCCRv+4KYQRNytSuRYtBPTuPpjTeJuww0gzM
         r8ItDGAnhFvPsA0X8V6zpc7e6D0E3ecVzr/mXk8mW9MEqtGEdNYF+kt+R+fRgroNlGYu
         rOdw3LeuI4+qYzY14PJc1jOEdSIcL+TvqUnQ47atE7wNjbXiYsvl2yCBmjj6MC3sAODO
         18i3zIPTbNiSQ1BfAG6g3/0xhtbrerevl7e+MxUC8PRvk9nwPz0ldQarV9XgN7fY7jfO
         e3hM3xCcN7h0RozdeIpNsU/5UB8Ngm5G4YmGwUe64aPSd0/6tqpX5Fubxfj5hhaik0if
         ZdxA==
X-Forwarded-Encrypted: i=1; AJvYcCXF31C0ve8sXm5ZfGW4gAKxp6pn8l28kkWLiDWaIj6emOQal03ehYaAt64YdFkYuAaHU8kJYcIgGB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2q9MBONvSOj0o5Q9Bp/wOMWmpWcG5cE1BgxigZzMovQ/PVQjH
	nEVWTEyeBnaBD289coiUEMQ3D+RlCAPILx6BPgLBir9I4Mu8K1oXl14WCcw80fu7ztE=
X-Gm-Gg: ASbGncvpqBkJtvCqgMjr1yVKMuT0bXVKgVEF5ad6Ajqu8ZCkOulz1gFeE1MZvOf3BvI
	zuO5PZux+TGEWPUdHWuDVbYy+brWriJOos2H8T3YEFZJA97kxKimw1docfEuFaWqLzmSfn82Qyy
	hRFEByvl8Nrr+0wsyEGb1wx4UCODhdZCnQrfVNGQU4u1g2PgtExvqEvzHQVnSvJAlft1wpllsbR
	UVLIRNpcTTqETC0bRYcVGGJDMQM6G2oMyKlNx1ISYJwnUHO12tzbwx6cWaBDdxZ9fMP9nqatLKf
	86BNx7Ctb8Gi9+GQtXwJIb1bBI4qo+9aSxtPp+rD9wIY4cU4rUsZak7pziN+2A71HblULKxxyv0
	v17ukjeRNb/rGP5KdLAXGyTjgJ/qULjXcYPOyMC1SnjyuHy9m9Q6FyRQ=
X-Google-Smtp-Source: AGHT+IH5Mq6z5UQiK7NPi1NRx4HPxcHQdYbblNPbJx5w5sNBeGCJb6k/1tpoCGKvUJVh/4rQ5RkbgQ==
X-Received: by 2002:a05:600c:35c6:b0:477:9976:9e1a with SMTP id 5b1f17b1804b1-477b86716f7mr17640575e9.6.1763627183337;
        Thu, 20 Nov 2025 00:26:23 -0800 (PST)
Received: from localhost ([151.35.219.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm4142194f8f.33.2025.11.20.00.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 00:26:23 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] iio: imu: st_lsm6dsx: remove event_threshold field from hw struct
Date: Thu, 20 Nov 2025 09:26:11 +0100
Message-Id: <20251120082615.3263892-6-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251120082615.3263892-1-flavra@baylibre.com>
References: <20251120082615.3263892-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2848; i=flavra@baylibre.com; h=from:subject; bh=NvUI5aXQ+dzQGpbFuILdCLUkAgQReaU1kD9uDURqAcA=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpHtB66q7Z2wwpif3kDRqjCw/vZVbCw4wQuA5Gn NqSPdDNphWJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaR7QegAKCRDt8TtzzpQ2 X0OsC/9h2sKQte4FveeBl5J6EyJrVGlXIvii/lxSTXaAXj2T2R0fzNHwMhaJNfWmtBrabnc3eJt nNHsCMkm9RQFIb6q1gLDNshWhH7ZoapBvGaUinmD8OCic0MObuy1Ys3QESncZFT0I7DY9W4bdI5 uaizc94Pcnnqicl2fwfnyL9PksPqS6kV978ZU4LRLtCukFofkW0RJPVWgtCdelMUNR0DBp4TAfD ZarMMzMGJMLQ1xM+MwdoJWKJPScPp4m8F1vdAq4ClLBQ8TqXjpDSzVHBFNQ6J2qge6eCPJa6UsC g6II/AVzXALuHDXZ1UyV9Kx6OGpqTfT2QWwtrmq1QYhg2V2D6KZkzRQfwLP2DzRLWRax70nPRRQ IS6M7WKkWs6juu7/NDEXwPHvKP6Qi+eJkvSevuM2j53qk2A5FW73lkiV2zNaDRHqucRlJgYckQn 6N2ZcHmptMG+cJrd6lsYTvZBKZ+SpuXs5WfRN/7OQZEeJ8C/W44ZP6y2hCHvotijfJNnw=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This field is used to store the wakeup event detection threshold value.
When adding support for more event types, some of which may have different
threshold values for different axes, storing all threshold values for all
event sources would be cumbersome. Thus, remove this field altogether, and
read the currently configured value from the sensor when requested by
userspace.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  3 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index bbb967b2754b..e727a87413e5 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -79,6 +79,7 @@ enum st_lsm6dsx_hw_id {
 #define ST_LSM6DSX_MAX_TAGGED_WORD_LEN	((32 / ST_LSM6DSX_TAGGED_SAMPLE_SIZE) \
 					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
 #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
+#define st_lsm6dsx_field_get(mask, reg)	((reg & mask) >> __ffs(mask))
 
 #define ST_LSM6DSX_CHANNEL_ACC(chan_type, addr, mod, scan_idx)		\
 {									\
@@ -422,7 +423,6 @@ struct st_lsm6dsx_sensor {
  * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
  * @buff: Device read buffer.
  * @irq_routing: pointer to interrupt routing configuration.
- * @event_threshold: wakeup event threshold.
  * @enable_event: enabled event bitmask.
  * @iio_devs: Pointers to acc/gyro iio_dev instances.
  * @settings: Pointer to the specific sensor settings in use.
@@ -446,7 +446,6 @@ struct st_lsm6dsx_hw {
 	u8 sip;
 
 	u8 irq_routing;
-	u8 event_threshold;
 	u8 enable_event;
 
 	u8 *buff;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 287a85d4bd58..117ecb080d8e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1900,12 +1900,20 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
+	const struct st_lsm6dsx_reg *reg;
+	u8 data;
+	int err;
 
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
+	reg = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].value;
+	err = st_lsm6dsx_read_locked(hw, reg->addr, &data, sizeof(data));
+	if (err < 0)
+		return err;
+
 	*val2 = 0;
-	*val = hw->event_threshold;
+	*val = st_lsm6dsx_field_get(reg->mask, data);
 
 	return IIO_VAL_INT;
 }
@@ -1937,8 +1945,6 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 	if (err < 0)
 		return -EINVAL;
 
-	hw->event_threshold = val;
-
 	return 0;
 }
 
-- 
2.39.5


