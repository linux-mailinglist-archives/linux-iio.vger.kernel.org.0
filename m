Return-Path: <linux-iio+bounces-27580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5308ED0BCE4
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 19:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59A523013E9C
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 18:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFEE3644C6;
	Fri,  9 Jan 2026 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YlDd+nid"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63FD22AE65
	for <linux-iio@vger.kernel.org>; Fri,  9 Jan 2026 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982536; cv=none; b=DUp6ajlQerENrrywWlh3hLTavZOPTeeKSLVchXrK3FNereC5d8E+ts9h3klsp+Lm3KSMPgreCWj0aSedkb4szR4dGsdRYKsS1wBpZGTXquuXaE82fd6DdLZiyCjlNJ9oXATGkIOn6leMF8vrv1uygIUQUNwnwK86mVDCXmrpCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982536; c=relaxed/simple;
	bh=ZOpc2KxPddw64+kCadhtkkyNHc9dGQ0OsK/5OVq5egE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xqri2VBu5aqAL7/CAWPzmggNzWC2hy9uzn4HytatskUgmeqoZ7l9VvFnneaM+SltflHJiBd4+SzlW/w/4imoYUUhUxPVJ48Dq3aVVNfH4YIQt90oBr/edq1Totdyp/XrEbSPYb0YB30C50rc+DTCF6lcA3hbjk7r2FLjos7twAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YlDd+nid; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b727f452fffso514950366b.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Jan 2026 10:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767982533; x=1768587333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dgqks7R0FZoV1F9cFxU5UZd69cs2yR4MsrhCcO8GYIA=;
        b=YlDd+nidQaVMvQBD2437+dMWJ0cz3PrHiHUMjlbLcrzdFOY7cr8Lp1syblXrgZg0pa
         g51NgU6RuHiL/Be7X0coVi0on+EYbZTnAsQwdny56Er1Ps2OeY0QHXuQ8P0FcnHJTGFD
         fitKCV6SxXLBg5q9CLGxpEr1lYpq9uoUJlsDdOz4kNkibV7+wmC7Xe+yOPgJ1Bebx/LK
         zDOgIuJC1TOvsO5akO9DT+zoCVaKLzQ0khBBgedgYrg+Cf9t6rcqo9sYEh1wdh9zHQUe
         jg06JFCuZ80M8l+sf2TwZSrW4dX7E5z9Oo+/04lQ/5hbxqtpkZaESulM1bhLYCm+vmh+
         z/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767982533; x=1768587333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dgqks7R0FZoV1F9cFxU5UZd69cs2yR4MsrhCcO8GYIA=;
        b=AZwIIFeR7Pcz23TCnHtcCLnY4F75n9Z+BL56flP/08BfhADtA6gGbAJSuQJJFtgbM6
         VmOOGUQGDlIOHb0EoQZvW6ympgWuuZUcYv9l93mYSwZpW9j5MlWs2GTSX+BWTM5+xAi/
         OMR6s+htAbRRu4DAojnOxgJm2nZM/gqpaAJpKScrvdZmawprHaenzCyKOv155hlcpsGT
         iRannV0eSr3RUVUrzV03P/CG9hRPIG2RfgkvaL9i94MsyvbiEQlHNxBZVgIaaBIcdoXd
         vJRrsiElys0Cphz6U93ABMYHUCCwIp1Rv1SC8agqwXIhPerFdKjaa81jcim1dwt1F2dp
         cszQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxKvbvA5GVCf5liE31RGh3aEImTTKuo0Lr84T3sMCMMnk/esQIZXuq+4ePmhtYtKSo7ci4I374Gb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJ7gDXm+KSpti8VKi+4UFl/Vl/Y0QdL8ZEw22ic2sZSep41EG
	XFZ0iF+bwGNJ3YSSo/0xGWFEv5OO+RUKdtTFpmxPKgQB4A4fxY/G64/IOhwlE2AhC6w=
X-Gm-Gg: AY/fxX4sXzAx9vOmc1aWKVIS7XEAEuBL2+C3QstncaLOgUaK6flynhMV1wKu1JWt9Jy
	V0ij/7iLXrvyPlIIqZ5RGK0ycgGee4ZKxQCGzJbF5sCVOwJsp5i+T3Ubr+2RHWDriVUZmcduVqw
	bsgOhRfKrq7tOQCWUhkFo4lDpSfDMG9YX/NENwz/HMKBlSlonIVtqFdxExVpjhivWtnG0A6+GEZ
	pmdel1hlR1q0dJLx0VPBmpCdluVQahXadAKaknVJ3fqp5oEnnmVB5FzBw3vr1LyvsyL++Pa4otg
	Mcgwix9iADsxSFDZ/Odbz49Xr6jDbpaSxN1tI6dSgW5w1tE3HHcAk+ANfE/lwwSxbqhdffw4h0U
	0JISLEgRpP+jXCcXsIOEv090GTFyyJeienwPEhIf8MVIHtXKos9DCnXt1yA==
X-Google-Smtp-Source: AGHT+IG8iWFuPY6KLX+yOq4PV+q/Os8YwVRbQEYUk+bVpfnwkkYWYheVzu2fIpEJUBt4tlw9GD1ejQ==
X-Received: by 2002:a17:907:7801:b0:b73:1b97:5ddd with SMTP id a640c23a62f3a-b84298aaaf7mr1044870366b.8.1767982533126;
        Fri, 09 Jan 2026 10:15:33 -0800 (PST)
Received: from localhost ([151.47.174.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a511829sm1169794966b.51.2026.01.09.10.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 10:15:32 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: imu: st_lsm6dsx: set buffer sampling frequency for accelerometer only
Date: Fri,  9 Jan 2026 19:15:26 +0100
Message-Id: <20260109181528.154127-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260109181528.154127-1-flavra@baylibre.com>
References: <20260109181528.154127-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=flavra@baylibre.com; h=from:subject; bh=ZOpc2KxPddw64+kCadhtkkyNHc9dGQ0OsK/5OVq5egE=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpYUWGnxlMsxmeQ4gVrt8dpFu7hV8AwHwnFxydf /B/JFZTOHOJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaWFFhgAKCRDt8TtzzpQ2 X5JkC/9rut/CdGQuqkN4BHgkmihEsa/eIQ84NQX359DJOuD45kbNBhwQOrwI3pgHvUQFEo2zNWm UkWhdukriXFFwq786FO0gedNQhpGsIrgp6OV3G+ZjJsyLjf+Z1kM+DUo+6383FaJQ5zqBESwgTy 2JxjWJSeSbs9qAUV0mTZGnp80rz8LfINfyjKcXetulatSuW633Bf0shNwX4Pn2DCxS8XsLUqkaY OuRaCF08UWkXzv+zCaYJPeV0BAAvQ3/wRmHe7Adgs57M0ofna1+aMB2bBT0evEXtX4TLgLsmqG7 A4ZNzOgESGWXg8AhPKMYeZOFMu6Y4yEnfTFrS+1EvUxP5dqcxiIJ7Q51Ysz+ROQPC1hklC4IFwB pi+h5SJqv0wVdtAVOIyo7ofIpkRoNpu/pgAG8lBXv8GTv0EtwpXQlFnm+tWqen18ASQ8uNJeapX hJIPbprrQ+ZvTYWkj2wUgCzypFOL0tlaAmOzRRfYY0iW05RZ57Xac1Sx9cdEGdVcgB1v0=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_hwfifo_odr_store() function, which is called when userspace
writes the buffer sampling frequency sysfs attribute, calls
st_lsm6dsx_check_odr(), which accesses the odr_table array at index
`sensor->id`; since this array is only 2 entries long, an access for any
sensor type other than accelerometer or gyroscope is an out-of-bounds
access.

To prevent userspace from triggering an out-of-bounds array access, and to
support the only use case for which FIFO sampling frequency values
different from the sensor sampling frequency may be needed (which is for
keeping FIFO data rate low while sampling acceleration data at high rates
for accurate event detection), do not create the buffer sampling frequency
attribute for sensor types other than the accelerometer.

Fixes: 6b648a36c200 ("iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 55d877745575..5ac45e6230b5 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -858,12 +858,21 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 	int i, ret;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		const struct iio_dev_attr **attrs;
+
 		if (!hw->iio_devs[i])
 			continue;
 
+		/*
+		 * For the accelerometer, allow setting FIFO sampling frequency
+		 * values different from the sensor sampling frequency, which
+		 * may be needed to keep FIFO data rate low while sampling
+		 * acceleration data at high rates for accurate event detection.
+		 */
+		attrs = (i == ST_LSM6DSX_ID_ACC) ? st_lsm6dsx_buffer_attrs : NULL;
 		ret = devm_iio_kfifo_buffer_setup_ext(hw->dev, hw->iio_devs[i],
 						      &st_lsm6dsx_buffer_ops,
-						      st_lsm6dsx_buffer_attrs);
+						      attrs);
 		if (ret)
 			return ret;
 	}
-- 
2.39.5


