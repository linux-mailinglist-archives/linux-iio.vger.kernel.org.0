Return-Path: <linux-iio+bounces-25644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC6CC1EC03
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A38E189A432
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 07:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A95339B44;
	Thu, 30 Oct 2025 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vPizLmos"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F9F3385A3
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809286; cv=none; b=Gp/bpZXzbkAy4OAbTd1kwa0JmUqeuY0zQzhc5GnUfI631SceYefryDTKGkCzaHLyufbTGq4yP2ne8Y375f+Kvs/0v4BA43XWsU7H2oMS9iEKQkgM8xsCJe7rBNoWWoPSzgSBqSbCCkbIsAoyCAtPHUxD2hcG+WGY2IQvNbcqFhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809286; c=relaxed/simple;
	bh=Q+pY5HlZqzp8d24g9WNWApNUCq5yqQgOxp3B34hW/uI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjtqv89AHRVfdX8TJDROMY9SrR32CwC98GmXyGcct/YhJuUyZSZWe4RhOvnd5KG/SnKDWPEDKvTraLn9R4EBXSyfAxyk768Z4E4b6KJp027HD/lTRbv82Guu4JeESiso6PwNz2RsREfdR6o9JxuzahKS2S7wp6rO/2BTzK1c6Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vPizLmos; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6406b8e1fb8so220376a12.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 00:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761809279; x=1762414079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eykfaIYOJ1O3INq90WvPnPMlXLtVxr6TQYwO1to6mmA=;
        b=vPizLmoslaMEXu41tuytJwx1CBYYAOawuFJCrVrShp7ZmabAMBacMjHYjbsYy3XIfF
         n56b7G85d2PwvdWPqUvRB6ZscyE3rb34jawwJrjiLK7v7RDLMCX6Ssyk+B5UVG79jYBZ
         ZTt4pwbcfyfKo3m2R9mdTWoRJOmp4ay0nHTMk7XGeBtVeoR8GxPUGZHa8k5INmKQ7Wk9
         pzV9dHq6Ca+vgy7QxiwXMP5fom0bC3ym8fthGPtADH4NYdqF/EzPVNPjQzRnhzJVFzc+
         uVZ4ewtRmBlYOYG98HMg9ftfDBJp+7wN/I2XIe4Q/E0/PSDKDwZBeDeSTGO1M/i9Faqs
         zxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809279; x=1762414079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eykfaIYOJ1O3INq90WvPnPMlXLtVxr6TQYwO1to6mmA=;
        b=OrEDZwiVycMYMndJeAWDOIB6/1bWKNWa3WfIXJWsG4PNuCsYg+EZMIJ2+biSd9tW47
         U0nLrqDuN6K1XtjfVPLTjlL/CLj/27fn8gUXIT07HTVyyG1eXIp1dXBN8Wwb2bRG3YLc
         9xoVkc1AknmgISRd7Wn/12tRAeU1C1Bzc3Q70uoAO3491TetTCV/74WkB3zysIjjMFpy
         NWHd3+XwamnZ+wv4+XzazbeONocVFvRZ3oZdv4a4NqWCVwPhS7NkWwxlCc3ThavmaAiT
         vHmZZivB48Owxa2/AT+WfyeFYxUkAKUUkTkVpX8sV5HwELPJd08YY7TqPkIc82X69oDD
         qoYw==
X-Forwarded-Encrypted: i=1; AJvYcCXXlQhWmvnyDYp4ZI0vVFO6j0crOkpqwYl/1UgHWAMR0feOdhIpK/UPQggQnH92XOGByGCTMGINIcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvbyC05JJoQgMhpCRHZnk1ZnJ9z1zdshhlYQLNDyIIwvEn6Mjm
	uHxeFyqMWq++CLATRJ7nriio1lJnYMO8UfPJ69rNWxyCTd4zvoSgRWFW0vSw4ICCKuE=
X-Gm-Gg: ASbGnculdYSfiEkG8/YL2jDo53gFRAX9GJP9vI3fnkBGK13KMJc4d/UiAkIv2qlFk3t
	eACeMRC+IFXfvD1fbOWOIb4FRKP109wXe2WxgEH2i+c+oRlhHrZEUuUntUJVvSVXS9HAXMNQtRI
	IXkFidW9rSlC3hl6wXuFu5cKoXVGiSSr7gvmFg08uW2etq9k4TPaqTDa9glT5/X0REC2wn6C44X
	lAn48HgT6P4MZ8NerqbftwOLpGpbfcAjP1dwoHXMKKhjgmr5C+0AdGZAh+Ve84hvA1xBNGw61Jj
	tzKAFunl/uOefognqndkD6losJuwH3Gvw+xIKFVQGuh+g2B99mCpkMP4FqVOaUUknaCqBVpuFNz
	fu+INbF/6zbs2JF0INJn+VPQpRwtcH7nNKp0Or6uNzH6d3Ipt20l5CRdqkQJuPZ7dCVncZsJ/S1
	8XHdr9GuXPkOy2HA/dvgokN+6wPA==
X-Google-Smtp-Source: AGHT+IHYWU9UwqdXA1AtOzYeRK4XQDCqB2oVm2eTFxu6lZwncXbBg4xxA2xQx+z3ZdHxqH2Ww6Djtw==
X-Received: by 2002:a17:906:7305:b0:b41:e675:95cd with SMTP id a640c23a62f3a-b703d2da8dcmr670932066b.13.1761809279239;
        Thu, 30 Oct 2025 00:27:59 -0700 (PDT)
Received: from localhost (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8536968csm1685933366b.29.2025.10.30.00.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:27:59 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] iio: imu: st_lsm6dsx: rework code to check for enabled events
Date: Thu, 30 Oct 2025 08:27:48 +0100
Message-Id: <20251030072752.349633-6-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251030072752.349633-1-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663; i=flavra@baylibre.com; h=from:subject; bh=Q+pY5HlZqzp8d24g9WNWApNUCq5yqQgOxp3B34hW/uI=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpAxNJKCWlxgi4/ZnYsQDZ4vSnVm8krv2CHT0fN us7wnzgonaJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaQMTSQAKCRDt8TtzzpQ2 X6S/C/9vHbJkvEDDf4MRA1ZyOsLosL+qRvBHwdceDO6Ecw1q9QByAliTbIv+Lkjwz8uD3lci/oq wgS1zTlMzkVcwQiM4E3HGDIqEYLiQrGoTnIFlTMfRJYrOJZIHzX9HcAEsqGKaf230JzEsxipoQu E6YrD69YFpVxeJIcIhNqIB554PB9f0Cz/nORQRFASxd5KKjq1NcOlT0jQtQXsN9UVsmEBLrvNY8 YCz0mFrpWbYuiBdQcNz7OQBaKnd5/Qdfa8N1JNdt1JDwejj3hPuezzaABNN9p+qgs3wHJ44xmAQ ece9ybp7LEIgcM7Dlunsdg6ROtMr8N+cXYBFbIjTh3+bJTbVOBX1b7/Ig6TKFtg/uqVLiZHjHXV 3MUHzqIUajFzeWa7gmsRm+tGzFdrDPCfLpYFO4Ls4v9zqKMelLVjq22bTXTHzD0NhYAgCI2XGbV mfTMph1i6dPwqMMRk7xbR4vy886UHiD2Fu2gnA1xNaXM2RH2Dl95aQyt6XFgPHQEJnfQE=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The enable_event field in struct st_lsm6dsx_hw does not lend itself
well to handling multiple event sources, so it will have to be
modified to add support for more event sources. As a preparatory
step, remove references to this field from code that does not deal
with event management; rework the st_lsm6dsx_check_events()
function so that it returns whether any events are currently
enabled on a given sensor.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 76025971c05d..157bc2615dc6 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1670,11 +1670,11 @@ __st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
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
@@ -1683,7 +1683,7 @@ st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor, bool enable)
 int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
 				 bool enable)
 {
-	if (st_lsm6dsx_check_events(sensor, enable))
+	if (st_lsm6dsx_check_events(sensor))
 		return 0;
 
 	return __st_lsm6dsx_sensor_set_enable(sensor, enable);
@@ -1711,11 +1711,9 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
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
 
@@ -2743,7 +2741,7 @@ static int st_lsm6dsx_suspend(struct device *dev)
 			continue;
 
 		if (device_may_wakeup(dev) &&
-		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event) {
+		    st_lsm6dsx_check_events(sensor)) {
 			/* Enable wake from IRQ */
 			enable_irq_wake(hw->irq);
 			continue;
@@ -2774,7 +2772,7 @@ static int st_lsm6dsx_resume(struct device *dev)
 
 		sensor = iio_priv(hw->iio_devs[i]);
 		if (device_may_wakeup(dev) &&
-		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event)
+		    st_lsm6dsx_check_events(sensor))
 			disable_irq_wake(hw->irq);
 
 		if (!(hw->suspend_mask & BIT(sensor->id)))
-- 
2.39.5


