Return-Path: <linux-iio+bounces-26332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8688DC72DC0
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 09:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3D04E2FAC3
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A8A31A056;
	Thu, 20 Nov 2025 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2W4YMWS0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DBB30F532
	for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627186; cv=none; b=DmZuap/PALm7KdmIhB6fwpqCkD/zcmF80H5huZHcYqHjspwZJE1/dtq7f7KdKOMDYMCwWji/sIoLUNZf84rxm9XPOaIbOm9OufJQXHJzZDNqAbVwqbVCf4/jskd8HQ88lPudICx/BICROFOVUrngf9i6Hjnlo/mXPth46ycSrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627186; c=relaxed/simple;
	bh=25QT/Oyvs+VzKW4Otq89F7gvg8t4NUxIgeUi+pJJoj0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwocLk4gU+QFAy6mxL6m5hoenDihgM/95kUAeeDZ1KhDru9m3eQrIj+sBlulofsn9jqLZOyI3SuoLQy5AUObnBMa5tdk9p9B9tvNjYwrxOqfrP9OHNAmDQUplQAhOlHbiUFUEg7mnOXH6o17+/2qGsXtyDv8A1wgqTEgHxUeHzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2W4YMWS0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477aa218f20so3628875e9.0
        for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 00:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763627182; x=1764231982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBH3fRFH4M/FwjnqWt9jTxX8M6Ls1YgPRJmEH7mUtY8=;
        b=2W4YMWS04o1+NpNxTcHuPREZiOnzrPshVC8dsCYgoSQyBrrsWodWERnXQ1/Z3yiPRU
         v9VdHvaMhxajy3z8zUZ2rpNV+vmZ1DRWxv9JJ9TCpmaMUt36AtF6zGlFwH+mWeIdrOGo
         6XWNeFNbG7pCn1wa55h2MX+GEUWN0u+9i3BjRVzKZKB7UTos+3xOBPG1neTJZaa9XGpi
         Qtgvwzfso/IVN5YwYmuAvxPdIaalGw2kVjEgUv4XrBzlcGQ6SpAbVsZNR/8JIIdimGZD
         mvjJNKysUTlg1ImklaRQ7VC6/Qk0tJXX6nUfLFhe4i08qUBQOgRZA0HsYoMOzYDdm3k1
         wc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763627182; x=1764231982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kBH3fRFH4M/FwjnqWt9jTxX8M6Ls1YgPRJmEH7mUtY8=;
        b=A8XTUOGeME+dqGJ9jLF7O8ykwTfECcIws7RM1wg4cc3IPmbULivyTyE50mTEyj2Var
         bE2NjqJ0hiLCUUwu2ookKqgy+xFdeSUUXXNmUKpwBpAMnjyurgWc86O8JD5iSF9NTCFF
         YoVWsLLPhwl8X+QzdHQtQtrI+fXJdtCGH5EhMbQkQNeOJSh9aioEkCsMD6rAj7r2DVI0
         UfejUMN6/VRZ0Bn2qQYHcZ61l8OjGlKVLTMihw2bZosNbalMwSSHBHzLvt/7ySGTv40Z
         Mq6sIveWZTcooLQHexbPZoMvBxamp+80gTrHLFdKOIYEoTarm5SAEV9IArh3piHqqunW
         89/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUtRWxu32hNGixYxYLi8fC8kFAi6koVHXv5bV8OhWVVgVQsJj03LfIcbNsrTowiv5otOL9WeYNG+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrc7ukRL9YGzYH60KZw6vCfWAUm8EX9kNl9rfSYu9F+R0ILvYh
	8ARXK/9jWLmYyMxJohIymHNDs4Sy+M9eF5HqsAqnijnB3DDKfivmh4JCZIk4Sistgjs=
X-Gm-Gg: ASbGncsY3yGzYvBumjp7C7uA/K0p8hxGmQeU/lFZlBlHq8DOstiM+jmXjwKxGj67HS2
	jwBs1Ue7yXkW2vynZPSf1Jdc/O2U7WrVWm3izwJ1DJCy9kVe4zkTEFGdBbatx1hxJm6mSmtUa9/
	rR60rJkit+Z2ACMTJ+svNlblJhi0TuoMCNIWElr7umSjQV2ykgBzm2NXhfY4UdPCKjcFH8pv5em
	e8agiytnhUqc23p+CgH4utQllcbzief9dHkKrcUAr5hDkIayEGL6H7ToLTqdBKFLb6wFBB9uo7O
	2kzy0AMqxCdts0IWlbdzss+42ohTTpq/XUUmWKmI1tFXPvgTIQdxQ80DsVOE76FRuT8uNWZp2UN
	8g0QeaREZKjtTBCRXthuTTp2q1Cw5ZV3oRp1g+G8oPDsFqHbf9jZCHgo=
X-Google-Smtp-Source: AGHT+IHYdRAJ0MjypVv2B6ep3jcVagNqKYXVFmR3fielCDe8rS2OhTTpZ+xq+r9wR2uQVZKEA4G6bQ==
X-Received: by 2002:a05:600c:4e89:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-477b9e2f1b1mr13397055e9.21.1763627182135;
        Thu, 20 Nov 2025 00:26:22 -0800 (PST)
Received: from localhost ([151.35.219.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b0faf295sm96398725e9.0.2025.11.20.00.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 00:26:21 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] iio: imu: st_lsm6dsx: rework code to check for enabled events
Date: Thu, 20 Nov 2025 09:26:10 +0100
Message-Id: <20251120082615.3263892-5-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251120082615.3263892-1-flavra@baylibre.com>
References: <20251120082615.3263892-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; i=flavra@baylibre.com; h=from:subject; bh=25QT/Oyvs+VzKW4Otq89F7gvg8t4NUxIgeUi+pJJoj0=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpHtB6bzyNqh8c0zL5/TICty48+WT6YlFWVAecf KmrNtbnVmCJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaR7QegAKCRDt8TtzzpQ2 XzzdDACtB4vJocur7IXgtO3oVjSKvnFWhNb4owiwQJv0PeL1rpusqIZRLNVnU34P9cU/n/4xdMu vF408whT47G/Q1Sd9keEmkneidKRopmTON3dE5ieUTN5mWndc+jRLnEruGc99iq8QAxk3WBhu+K YYZA506ygNhVyIztjTYUWU4CoEOH6JDg4sevKYmYBxN5B8JqrS+fez8UVhXQGqNuQuVdkptUtIm t1PcI0VVcduU8LQ1P5l0fSVGHx9duEy2dQWuZ7nPI+z2Cv/YRlTvqQP6Nz1kTzpkWasJB01hOZ3 WO+jsseAygAGBUsCcBsSpDAS6Lz6YXkhfuDFzEQz4EUsBABhsFsfGbNB7FrcbW1sAEQIAd/cYst bptzja3TfCSkZK99jmHlhhpf9alWB2aJxnaijLjgXqNaH10HX74z4h58wpUY6gEEryOgcAC8cpF Au4Xw9U+stKd37iGiCWY9ORJkHAEJYGH4UaCsQ70d6HGFmT69fK0PZYEctlJVms0ijl5s=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The enable_event field in struct st_lsm6dsx_hw does not lend itself well to
handling multiple event sources, so it will have to be modified to add
support for more event sources. As a preparatory step, remove references to
this field from code that does not deal with event management; rework the
st_lsm6dsx_check_events() function so that it returns whether any events
are currently enabled on a given sensor.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index ce5f9213d476..287a85d4bd58 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1744,11 +1744,11 @@ __st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
 }
 
 static int
-st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor, bool enable)
+st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor)
 {
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 
-	if (sensor->id == ST_LSM6DSX_ID_GYRO || enable)
+	if (sensor->id != ST_LSM6DSX_ID_ACC)
 		return 0;
 
 	return hw->enable_event;
@@ -1757,7 +1757,7 @@ st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor, bool enable)
 int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
 				 bool enable)
 {
-	if (st_lsm6dsx_check_events(sensor, enable))
+	if (st_lsm6dsx_check_events(sensor))
 		return 0;
 
 	return __st_lsm6dsx_sensor_set_enable(sensor, enable);
@@ -1785,11 +1785,9 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
-	if (!hw->enable_event) {
-		err = st_lsm6dsx_sensor_set_enable(sensor, false);
-		if (err < 0)
-			return err;
-	}
+	err = st_lsm6dsx_sensor_set_enable(sensor, false);
+	if (err < 0)
+		return err;
 
 	*val = (s16)le16_to_cpu(data);
 
@@ -2751,7 +2749,7 @@ static int st_lsm6dsx_suspend(struct device *dev)
 			continue;
 
 		if (device_may_wakeup(dev) &&
-		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event) {
+		    st_lsm6dsx_check_events(sensor)) {
 			/* Enable wake from IRQ */
 			enable_irq_wake(hw->irq);
 			continue;
@@ -2782,7 +2780,7 @@ static int st_lsm6dsx_resume(struct device *dev)
 
 		sensor = iio_priv(hw->iio_devs[i]);
 		if (device_may_wakeup(dev) &&
-		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event)
+		    st_lsm6dsx_check_events(sensor))
 			disable_irq_wake(hw->irq);
 
 		if (!(hw->suspend_mask & BIT(sensor->id)))
-- 
2.39.5


