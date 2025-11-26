Return-Path: <linux-iio+bounces-26493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5FCC8BDEC
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 21:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA5564E2604
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 20:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA153342534;
	Wed, 26 Nov 2025 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxTNxxJO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F77033CEBD
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764189183; cv=none; b=Yy6CxnwJ/NdGZ+Bn2k32z31KWx85ZtO/esmusQITwRVVL5OiHZdTVbExk/UvgSVW77lhyK4ljOayU/cSBwf21Tmv3Ljam7gDbWbRDa34w28fd/sQjOPvKEwxIo28Dk56sXZynunDlhkt0l0PyhHCfmLI5PMvXcMwSRjHnrNl5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764189183; c=relaxed/simple;
	bh=OcCJWTIODqW7TIcFVJGQzn+dDIxvYGjc8NCyKSND5pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyF3fvb3eLzeCdKjZFFSvBpo4lzqvpvWrOqBmyMjkp9pW8UzaCVkK7sojr/T7b9mylznPM5HKjL0I0b2s3mUEKFJ+0ySH/fY3OWwhpyWMeugrQt3BA15iZp216TDp4xj6yZl6b0UaCXjnqjueBsLWTJqiUYFXVqwSSXOetyMOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxTNxxJO; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5dfd4a02638so41744137.2
        for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 12:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764189181; x=1764793981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExXVu4E8deaOdjHxg4z5w9l+p9F94Q0P0PGH7/LEDOc=;
        b=bxTNxxJOXSIYSn2/2gnndk9RjkZXggytlxNKvdwgV78ww1W9dmMmyk9jaqVLM1JqG+
         KORmuKIL8HtiuFjsO862PqDpl2yhvbsQ2sEqYlQEK2mv/oe9WOR8jneFadGKo9COFHVo
         aFKi2NZt58BHd12SZQwnWK9LT5XjGtBUWK/n0ANS9/tA4E6kVIc8yyiTyfYr/OMHcnfR
         bimtbSNZ1lUuFIqquC8FYd+Qv2CFyk8euAKhFmvWyuUzDG0CUZCd9xz+3cLDL1jSZidV
         dLVbOYGfRc72DpV26lmPSFO7LYoPtvtbWIrdg7/uvzFshYCRUbCGI6Dg0gQkEjFOg2Hh
         6HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764189181; x=1764793981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ExXVu4E8deaOdjHxg4z5w9l+p9F94Q0P0PGH7/LEDOc=;
        b=sTMAyFR3iYfLricb3ed9fEaYyNi7egyJud7F0veiYqzRUaZ68SOGSreQE6psvMUGPU
         ciXr/ff7VRdSJu99Nv0cSO+jUjJ9ANcmlso43uqUt2exsib4rflqrlG4LNROTuQiwSuc
         L4Hqgviqj1CYgcOuIaUUUnA71sRu2wi8FYzGB4w1vQgYF7AQFP80F1yugGop8Tuyb1N3
         nstm5ctOgkgK4N8OBtgaeAbI7pL7HunSm3h6mr8iCFQN2Cinvn5Ii80PFZ6HZu5Ms4Gs
         p9dY2WScBLpA7CyNStcXADs6tuPrP2cHsCT4RAN3YamoZLFPxxOIpb1VgidNsxtUN3ZI
         bmIg==
X-Forwarded-Encrypted: i=1; AJvYcCX6nprI6VMDKVA1+nwvUjZmW1SDNlJXQ63aKqL3WuzP+Du4hgW0Q2h/447ubavcFLxUevIHNoKCDmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcGx6iZ0snPZoZDQCAaTMWKOnBtTO977EjV1bdlZK9Wlpo9QU5
	Vr6bHFWnQFQQ9pV7SHq3nyc4vsnrPhFIPECXRiJAB5YH0nWeUXQuITrR
X-Gm-Gg: ASbGncsXqurfATzzraSYWNpADsey+7aekUKDN75+uBQbs3K/T6zVSfn6NTxylI5Yh3D
	BUYE9QAfC1SCqSrTsOLmPlJCAHFH4Evs8qAPKu88swhBQlVBaY5tb/QiKrIjfnwaCzAXeiwmFat
	h/tWA3BKtbxPt5LTuN+tUoNUl22888z4r5JfgofBM7E/dy5Rdfg9bho7qYocVq8vbh0qmsRipdw
	lPJMhFREZmPEPxgmrpYoqq09Vy1wZH6Pdiwn5GHgX9cKHlR21CB8/Z/uAMJnvR11I7B1o4drVUA
	6Sug8bUqD+YLLnGhAuhawKqWIoctcYjRXvBnhd6tiN3lvgrvExU6tX/YpoqY8X8bAwo3ZAel35I
	TwbropuFxFUw9FTVOzJlhlLrmAacT4kHxWFWBE82Ftd+ueXTF0cgoj0VM8lW0DktZ+6KixmkbAF
	asO59PKXTyKKJvJPwZsZluSJyeebqfhrEEfGz54lq9mTwVHaSM/mjPzEWuyaTMqCACuSdQo1q2P
	s6V3GzGlE5QePMHhOCAXItLUenScug6wR+b0MD42Y9hvRttNYGGcRdc9pSmECm1PLqFowcJbw==
X-Google-Smtp-Source: AGHT+IFFnpg/EgbHbhvlZfcqJFLaxhOtKzuQJ3sF7g9Z2WLgv4B968LMG9bUk/V+49vrvNHQjCyz5Q==
X-Received: by 2002:a05:6102:1513:b0:5dd:b100:47df with SMTP id ada2fe7eead31-5e1de1375a1mr6104972137.4.1764189181011;
        Wed, 26 Nov 2025 12:33:01 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.230])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e1bd9687b0sm8112832137.6.2025.11.26.12.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 12:33:00 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: jic23@kernel.org
Cc: andy@kernel.org,
	andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [PATCH v3] iio: isl29018.c: replace sprintf with safer alternatives
Date: Wed, 26 Nov 2025 17:32:40 -0300
Message-ID: <20251126203240.13466-1-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126172432.5532-1-tomasborquez13@gmail.com>
References: <20251126172432.5532-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces sprintf() with sysfs_emit() and sysfs_emit_at() safer alternative
with no functional changes.

Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
V2:
- Fixed recipient list to include all reviewers (no code changes)
V3:
- Improved patch description and fixed indentation

 drivers/iio/light/isl29018.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 1b4c184230..b6ab726d1d 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -273,9 +273,9 @@ static ssize_t in_illuminance_scale_available_show
 
 	mutex_lock(&chip->lock);
 	for (i = 0; i < ARRAY_SIZE(isl29018_scales[chip->int_time]); ++i)
-		len += sprintf(buf + len, "%d.%06d ",
-			       isl29018_scales[chip->int_time][i].scale,
-			       isl29018_scales[chip->int_time][i].uscale);
+		len += sysfs_emit_at(buf, len, "%d.%06d ",
+				     isl29018_scales[chip->int_time][i].scale,
+				     isl29018_scales[chip->int_time][i].uscale);
 	mutex_unlock(&chip->lock);
 
 	buf[len - 1] = '\n';
@@ -293,8 +293,8 @@ static ssize_t in_illuminance_integration_time_available_show
 	int len = 0;
 
 	for (i = 0; i < ARRAY_SIZE(isl29018_int_utimes[chip->type]); ++i)
-		len += sprintf(buf + len, "0.%06d ",
-			       isl29018_int_utimes[chip->type][i]);
+		len += sysfs_emit_at(buf, len, "0.%06d ",
+				     isl29018_int_utimes[chip->type][i]);
 
 	buf[len - 1] = '\n';
 
@@ -330,7 +330,7 @@ static ssize_t proximity_on_chip_ambient_infrared_suppression_show
 	 * Return the "proximity scheme" i.e. if the chip does on chip
 	 * infrared suppression (1 means perform on chip suppression)
 	 */
-	return sprintf(buf, "%d\n", chip->prox_scheme);
+	return sysfs_emit(buf, "%d\n", chip->prox_scheme);
 }
 
 static ssize_t proximity_on_chip_ambient_infrared_suppression_store
-- 
2.43.0


