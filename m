Return-Path: <linux-iio+bounces-26466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA94C8703C
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 21:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC66E4E2939
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 20:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1698833D6C1;
	Tue, 25 Nov 2025 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n95Kmad8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019133C190
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102197; cv=none; b=qy7Lcd+fIm+7zLIV4FDoKrlZPbq6mA/icPPXeMTyD+3FayiFG13Q7jR4ViIMLKbMWAXBWfD6f227O8TY7EfKqacA2/QfDNqMMkdJY4yap3/ENVKhcYdm/rNWEwQaDy358Z+K0jqIc9aNRHXZUVf20q2Mz24nv9VjtWT6vm+NwxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102197; c=relaxed/simple;
	bh=DqJyjrJckqTFCFbsp+ufeGsL49os8RH1HQOvg32AKQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EdzcOK4h8CWx5iq1GVjbIvSEuclPLGxMK4ungXQPN+J2W40VR9k6yBIdGYo0i/2Y+09qrWLoF2xO2dQtHlLJGvoCx80qOBuTo0EPzKRBQHjH/sNeLdqY/mihNL7VMZ30WESnRYd3K9EqyuAUqPqJJuT9Jy4hfCswOgKzKeJp+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n95Kmad8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b725ead5800so762502366b.1
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 12:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764102194; x=1764706994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/17Tgx9epkg1KaWaLaodjBbzP+GCzteuD35HmwuiLE=;
        b=n95Kmad8cOie22eHyiMhmiBGYDkAtsdMWXBOJqz721WW3WTNt24bBn4gHy3lNwiQH1
         Pya+ByHGQkteqZ4X7MNB3UVCx6g3NQtqaRHLE3Y9Jhl/6ImoeR/ujFdm7bF70InkzNMg
         5NFJ0m5MxBpj/X9ufSeVI5SZGM3Re4r6cFMDZWwRXs6+D1La2/kg4TVZMJTruMS3PEkE
         EyMmc3CUSn4IJ8DN3ej5Ei8xsvwlhtuHjfZ+ERk9Aa2bUZbbAZ2eRVeWL0YFtcqxCG3m
         5H+pSMxCbudy4TC3DIfE6ujFbGWKl3Z6ULHVYQlLE2HqCpD9CAnW/ZGtd77iOqqqiAC5
         aY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102194; x=1764706994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/17Tgx9epkg1KaWaLaodjBbzP+GCzteuD35HmwuiLE=;
        b=NWGxkcWhurBsWuc2deYJR/b9xFBTxoSyd19ESgDdaurcrsw1ikmof5n/n1qQV0UEnS
         WGE60A14mVS8gyoMpofRBGx6fp967JnkGAwxsHlu9dtW+2BWGoh8mZU26buDe6S9EB6r
         7h/NghB7Xk7+Qa0tocylP8wGy6d3IyMLKa21W0pPaBIZyYTan/WNEAIix5kof5ABlZBU
         fLkLffj1+4mNEZqI8+iTHkXPyEYZY27IuWjxjxFJapqhhWVfp6G3yLCgx/adtU6ZE/Yx
         FsfRZgvMEtsRnnfuXrS1IEfIxUMVs1LIZgL9Vva7L/uRb5mytAFKGhbxa8m6zvutctWX
         Pb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrF/rhsTlJc367O2wpyQdf3aIDJIYZ7YwYB4A3RRbuzz4c7h3m66+uqE9dHy98AMJEkvhQZ5t65ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7jumHVJC1378zqkAFgjF1z6zEwq6Qh68fQsx1ZBxyNy07b5Ln
	1ie65gvt6cHkB1F8FOpHFjbvUavBE2TBETrrFu0zuS1Ev9jPlGeb68z2hmURnBUmesk=
X-Gm-Gg: ASbGnctptxVoelyKcw7GiNjF8C0cXWzZOVS26/8nkGUlHm93b68VzGAym+Y76arF/Dx
	CpRgMjve1Pd7jwVYlZDsMBaKBT4wnJ6TwylQkiQCpTPZgzOThxOFRq2LQnlbqgwy2RV+SaMdrMu
	oxTRNG3nbJhkiVMQPZyysSVnorY0YTDJhZDl+ShDo2RF3HU/PI1kXStwEZV1oM/S45j2smRYmtx
	Fa5R2FE9I7VT4m6JM+RMWORZhCz9XqEVj+bqyyPzTqzIEjYYpLDo0J/CTsRfG31I1FVdDK2BBKA
	sdlvYhXdKKY+1bzthv+vga3pgwt/A5/mSV3TaROvT4c7KIMG+un0ouVJpUc9HmQNTIJYRGXH3UQ
	qJbOXyfJHJ4PzoQWoL7+a5fOMLND3142uyNXl6ojxYXeppg6xfWZQPDFxl9TzC8zaO5Ck
X-Google-Smtp-Source: AGHT+IF1jEzi0tnblxW4NUau8G4FOxDCk+CR1sk5/D9G7iXCJNbzlCtwMboP/Ymqc97J2f4E7Aqqag==
X-Received: by 2002:a17:906:f5aa:b0:b3e:e16a:8cdb with SMTP id a640c23a62f3a-b76c5352f46mr447862366b.12.1764102194273;
        Tue, 25 Nov 2025 12:23:14 -0800 (PST)
Received: from localhost ([151.35.128.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654ff3bbesm1674127166b.51.2025.11.25.12.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:23:14 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 4/9] iio: imu: st_lsm6dsx: rework code to check for enabled events
Date: Tue, 25 Nov 2025 21:23:02 +0100
Message-Id: <20251125202307.4033346-5-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251125202307.4033346-1-flavra@baylibre.com>
References: <20251125202307.4033346-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2722; i=flavra@baylibre.com; h=from:subject; bh=DqJyjrJckqTFCFbsp+ufeGsL49os8RH1HQOvg32AKQk=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpJhADMQVpJcwRohUAGn+A7Rc5GiIcg+Cr4E5+E EzqWf8+OkWJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSYQAwAKCRDt8TtzzpQ2 X+MyC/wMDPp1XD/LQyq5jGU+UkDGYKK9/xkEjzCySgK4pBi083KT2QpF33bhob6gdTg7PTMHec2 IVDXVKvKBgGBtpgkioBtErY8Gii1R60Xf/BQRaHZcz+DHG102PgGWo0NV+Ijc83QKXTUSClaEE2 wAjb1O3BWzx8t1j0wvh1t10Gp82IBa/D1Vf5D0gCwUufP9FplacQGKaie9iP1zLYNdFydLVr4MU G33oJ2JUBAjOMaQJ8zgjWe1AL3NAsAP7L/869/q1mhiPaO1eGuk2iDb039fQocuHUmRrpAR8jqK 8KHmFSFHDxbyRfdqxrtWVMvwpFBX3So0wTCE33IfPPVcEWHX4Vco5lPDiMevHuSPLsVMwHWVrwc +jeoowGnf5nfINARwB7glrzQ9u3bWNHeTDg59jpooYIxUqH29c7vh44gpnxl12iosfkBC2y+OGF KLBBxcxeL7RDd2HCJFh+mERUIVKPgJF8j96p65INJFc2sDCngIwhnrlk9g6rOTjs1tx1c=
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


