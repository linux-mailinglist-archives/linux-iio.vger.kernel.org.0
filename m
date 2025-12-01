Return-Path: <linux-iio+bounces-26585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D689C96896
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 11:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B09D24E236B
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 10:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2438D30498E;
	Mon,  1 Dec 2025 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ohmCkulh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308CB303C81
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583243; cv=none; b=Pl//Gp9oNWukYsmGkHod2iEwn2xdYXKG2WY96/VyHkDDRBcBE/gFv3ccxBUQIzyICUbUH3our70cmZXhBCD+HWuPAjrKxsDBCsQrWurOZqr96hm7C77F25BY5NPYk2/cHdfOIPb3JlfueebFzyu9aW/XdiBcsM0OG0JjLaZvOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583243; c=relaxed/simple;
	bh=DqJyjrJckqTFCFbsp+ufeGsL49os8RH1HQOvg32AKQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c5uBx7bFzPDPrbZ3M1zPL7oL8FvviA6olLJg4oS3oPQQW/9xkrOdT0++dEHdK4q4cPmq7oXKzA1MD6MWdAGv7hNpwhib/Cy0R3uIl3Y5PRVaaFVHWX3RVly0ad5W+MGPRbcbgZtZGVSjpBDXiDK+5GHHWsYZBV6f7lO+vVJEWe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ohmCkulh; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ed66b5abf7so53888921cf.1
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 02:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764583241; x=1765188041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/17Tgx9epkg1KaWaLaodjBbzP+GCzteuD35HmwuiLE=;
        b=ohmCkulh3dF6owAaxwyJ2yNOpptDftQdL7cylnoTwxhvdBtYHgn2H7mBNKqBbgZs8P
         CJ+/FbdsKT3NNbFi3W5xd/nOM0sPN5cjPV2plVsYhqxbE+76T6qRVYUbTZpU/DXFB4am
         ICtV/IuvIdv9VnWECnkP9YgM2mWV+8KWaJ3f326KaRNttm6wWwnKeS8rrAKc0Qle4Vp/
         wivun6JasHK9POraU+Tem92JaqVgI/TukyY11YeFPD7ByHaXSBwQBh/1g72FA6SLe8eM
         OP7t02GKX/UruNzFJ087I7lOCQxp1aTVETEDJ08Zkhl1DntjZvAUhd9RL4ztdjf561J7
         gq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583241; x=1765188041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/17Tgx9epkg1KaWaLaodjBbzP+GCzteuD35HmwuiLE=;
        b=pU7BfmpgV1R8v1ndavElWgQ+Zr+HfPeX8P8xkRcnqEl49sBleuYmdfqSRP0d+u4PCa
         fWnv67+oseCY0ls9OeBbQ8llvlNtsZAOsd9zAsfEagX6Y9Af0ALtd2OKsxf96oqyTIwt
         FaXvzLNgHWn6v0+FqjO/Am0aNsgmB4yH7E6r2ND74votGbny/Hp7cnqaK/9uRag8v9Ak
         s9i/YO1/4cfaJvBuSIlsPJLzyXLZf4TldILNU4FQgr/v0sYQAGqdJjkVU2cgUUgKH980
         agHWToQEgn7EVYB6a6f/fy1EhcqOSqQUnd/IWeJi8VpluOcmPSDzbfQettpkuEU95JU5
         U3xg==
X-Forwarded-Encrypted: i=1; AJvYcCUuOWufeOwao+YE6VsplsQBLTxJhpkqY9FI1kGU+IfpU0MBYjJ+1036UD4SV0tSfGXBpO6v3JY6Av8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeZaRq3Fro3ZgEU8sAWkLwaGKKmxFDHLA/mPrPNF7U9xQVjpj8
	zordxO2WwWtdj2paEHUhzFXZEDhWMqiMKUlaFS1dDFeMw/cNZXrpSFc+s0xU5iUHUK4=
X-Gm-Gg: ASbGnctY8Xtk/oslD3S4wfy1n+zUL4j9yKzzgSH9c9vQIXYCVaVMeAHAY8BLQ8ht9e5
	o+CDQIlIN8+hHyKmMsmOcl1I2QQvQ99UnHkyLUxG+6SKRifNiRVsE9iUENGMPlceaQ5h1twW9Ye
	cYg/J7MrbGWUv4IpSAMYKk9f9tbTLjEy1JFMibJOnaS5Ig88SfLesqVDhjv57DFFHQzhbJMPBNS
	F8WHiaW8xeJMCL3ObxECo/puZ7KLk70RGPv6UQ+PaGjy0ZIQKjSnirzWDtFRYSySbcclyDbmq9g
	dD7uhNOCRxAnjpWKEGPg8L0LZweycK1IBGevumxK2ucqNyCqB6QPGbg0yQX5DVrW5cUBBGtRozt
	KNv1/u7UTFsxquzMVyqu9qlAtLOZvRu45QK68VFSsIqUFIp+yYN6o+gzs4Hm2/IEiScY=
X-Google-Smtp-Source: AGHT+IF0TOZFmwIWOLrHLyZQYtM2iUe56kUUp8TGyGHg3pPd5q5rSIt0wA202Kpwhe7oz7ic1nTIEg==
X-Received: by 2002:ac8:5805:0:b0:4ee:24d0:4539 with SMTP id d75a77b69052e-4ee4b4184damr564427851cf.6.1764583240445;
        Mon, 01 Dec 2025 02:00:40 -0800 (PST)
Received: from localhost ([151.35.151.28])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd3443375sm70552381cf.29.2025.12.01.02.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:39 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 4/9] iio: imu: st_lsm6dsx: rework code to check for enabled events
Date: Mon,  1 Dec 2025 11:00:13 +0100
Message-Id: <20251201100018.426749-5-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251201100018.426749-1-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2722; i=flavra@baylibre.com; h=from:subject; bh=DqJyjrJckqTFCFbsp+ufeGsL49os8RH1HQOvg32AKQk=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpLWb5MQVpJcwRohUAGn+A7Rc5GiIcg+Cr4E5+E EzqWf8+OkWJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaS1m+QAKCRDt8TtzzpQ2 XxbvDACnfrJ5wnpg/i8QGcJDLYPdI1bk0vJzhu4uQA7AZNuQPscX5gp66ogwx6x9fJwrRhnm6PI kNzXXzWjAejtTnX/JICvn5yn7oZKqCQPMqOCWW5kNggyOmAdNGAjuzEsVH18ccW4kDKJ6u6EEYa cKkr6WEzWZY0PCbN6snSbHJmPeWt3nisMW7U7bmU6bJ9U3+hpxHw4HImsn0x2L+M6jW+pB43o2Y gG4AWoA4VBSgowws/A+/jaQmL5gxRQCY8OChJbb8KScjjWQx8ge99kpHxZfHmR4s5Jt/NVRJSuX 281gQWiX7yk9a3eE6RESk33zY+23s89VTfgBANpNHzUrsmv11w5g8JkRge9JxHM97hW7u+bQRCQ y23UN8jjEVjdIj/UmJSXFb2aS1Z/355nR9vnmOGRbwmzk1ca6I3lKAUg0346h1bfA97lVGfxr/7 qjMH55y3I1PiRR9xi0O7KXGZJ3rb+iAC0ISVtK/zT5c2RBM/1HvxhBUtdPfAyZ3Ac0gzA=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The enable_event field in struct st_lsm6dsx_hw does not lend itself well to
handling multiple event sources, so it will have to be modified to add
support for more event sources. As a preparatory step, remove references to
this field from code that does not deal with event management; rework the
st_lsm6dsx_check_events() function so that it returns whether any events
are currently enabled on a given sensor.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index ba163dd2ab82..828e495c870c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1756,11 +1756,11 @@ __st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
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
@@ -1769,7 +1769,7 @@ st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor, bool enable)
 int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
 				 bool enable)
 {
-	if (st_lsm6dsx_check_events(sensor, enable))
+	if (st_lsm6dsx_check_events(sensor))
 		return 0;
 
 	return __st_lsm6dsx_sensor_set_enable(sensor, enable);
@@ -1797,11 +1797,9 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
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
 
@@ -2762,7 +2760,7 @@ static int st_lsm6dsx_suspend(struct device *dev)
 			continue;
 
 		if (device_may_wakeup(dev) &&
-		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event) {
+		    st_lsm6dsx_check_events(sensor)) {
 			/* Enable wake from IRQ */
 			enable_irq_wake(hw->irq);
 			continue;
@@ -2793,7 +2791,7 @@ static int st_lsm6dsx_resume(struct device *dev)
 
 		sensor = iio_priv(hw->iio_devs[i]);
 		if (device_may_wakeup(dev) &&
-		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event)
+		    st_lsm6dsx_check_events(sensor))
 			disable_irq_wake(hw->irq);
 
 		if (!(hw->suspend_mask & BIT(sensor->id)))
-- 
2.39.5


