Return-Path: <linux-iio+bounces-16116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C32A47C57
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 12:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78D41889602
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D0622AE65;
	Thu, 27 Feb 2025 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aQ+E8cRB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29F22A7E5
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656148; cv=none; b=NlFqFzDoT2jNPGI4wJYTdUE4g36clq0xwRTLh/dsLmQMAx9eJ7i9tOFRsN8WcnJUzkXDbtAKs1KjHXAScgWKhs2jCeqxUFJvMWwA2TP0imfaw0GXzZO2Oqc5nx7xSQ1Zk1+S0lI+CCoVZHv4L2jsPvgGLFJbjjPBHEsyTI/lHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656148; c=relaxed/simple;
	bh=QD0m6rBopUmavdwYKjcgOaKorjDwpda06/hMy7aTHlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWmped0SW+CC9gPyuZE7sZcjattogy8lP7mjVpxVG6W/YiiwLkYUGlP8z4oHyrMkWvnvT5i2z5zCjInZlZga3qxZEu4zVywt9UP1+ScJTkKEZGd8+ZGQyndjdnZ2wWNAcLi1ftCG4KqYo2LBbgPLJC2z40yBTLLqvryC+dh39ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aQ+E8cRB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb81285d33so165928866b.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 03:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740656145; x=1741260945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSf6Pynb1Uc3tglXgn8N8Sr+U+sc/b+e2CJlvNTsamk=;
        b=aQ+E8cRBReLZNRgx9p3hM0bDsQHjletTXD5EsyJ5gyB6rE6cCDocLgTuB6canj+Hil
         USV9SlbrUmjidwxhV1OcAGI3s3USY4FfyRHEfbMaBFxm6hHpzncW1bb2KRGI06HR+F+v
         CtpGEQd4hFicq/a9PQaLFipJMqnGI0xOecFlsxlZyG8dkZeBlq0JaeSWkf1rJQpuHT9J
         21Tz7aV7eCphIUpelW5JpJi06x2U7mDtlPiO3cramusOieUj0sYByFUiDEA2dWX7PKTX
         zdyTAILyfiLdxm7NyrM793f2cGkOpcAff/iDuV9o80XMhElVAnauLOMvy32Lneq0FyV8
         ZojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740656145; x=1741260945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSf6Pynb1Uc3tglXgn8N8Sr+U+sc/b+e2CJlvNTsamk=;
        b=pgKFjBJ7QYu5mcZ1WrTZPvScFZ7TJhNEU9sdI3ahLtAiqX7d9RW+zHOzl+34XosXjk
         Yk7T/kYkgzeIyhWp92pA0jK+ZC2bdIDYawHfL0e76jPPd4r3dOlQEYcOuxWmjjykEtn4
         OnztM4xLpKDsfYUo+OCa6ysvf0iLrS+y2VIXr+Ls36TrQKI3xZD0WF6o15RNJ0DXj7HK
         sDBmg3SecQkX7xn7K8uDfxe1NLrTd9aScs0kZ8Mbflu8KUx2d41Hc7A0C0RjXsvGDCJu
         FwUu7PfEEX5UfaprOna6RJrnuiPXCViWFTFlRFquzgsFLkxvToNFrbZ22J6YOYmcj839
         0K2g==
X-Gm-Message-State: AOJu0YwW9vUK8MAGDcGJkLjGNQiUlSvlU1F1GMGYUV4eR2OJ/GOBgMXx
	q8s1ZQuvClC794aYCQScNNOTBzkjw1WGE3ys26iMO5m8H7kOSjF4QUePOtpw1qw=
X-Gm-Gg: ASbGncslWJ7ghiXHJZzPHtDLO2z9bEQJfXPwlNHTcOSLOByi/hQIBUJNeNwzS8zCuAL
	3o/UVNDWQeRwZVyWkl5mlnHzCmOuAMxZN0vO+2NF3STREhw7X8P3Qpn8PVrgKSkxJIxWvfvkYJI
	TqbXKzY1KSqLS2FH7h+IPNIgxrvbgYlaE1fgDyGYLHIuiL4/cZ2erpDY/hN3MOP4MFJVN8/KzCi
	8LXTg4iH4M0KBkela3vz97vOZ0ugKraCGPAsmbD5cIAw8C+jkFpvypLkLVzM/ZPOSfG4qePwjRE
	eG9jl/UXg2tlJKhRspdh6zpTjwZnOGN6ycH4oDEULmP50bo1SfyZiSI/2o3CxbA=
X-Google-Smtp-Source: AGHT+IE7DmDBxfgEdtU2ukfaXWxGFL92rCHbZmNK2Upg7MZVeWOAXf/X5yKFxY6g67NORml1eUj1/g==
X-Received: by 2002:a17:907:96a5:b0:ab7:fbb2:b47c with SMTP id a640c23a62f3a-abc09c1a51dmr3006408366b.35.1740656144516;
        Thu, 27 Feb 2025 03:35:44 -0800 (PST)
Received: from localhost (p200300f65f2c000000000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f2c::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm108027366b.136.2025.02.27.03.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 03:35:44 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Mircea Caprioru <mircea.caprioru@analog.com>
Cc: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH 2/2] iio: adc: ad7192: Grab direct mode for calibration
Date: Thu, 27 Feb 2025 12:35:28 +0100
Message-ID:  <8aade802afca6a89641e24c1ae1d4b8d82cff58d.1740655250.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740655250.git.u.kleine-koenig@baylibre.com>
References: <cover.1740655250.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=QD0m6rBopUmavdwYKjcgOaKorjDwpda06/hMy7aTHlU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnwE4EluCX/iie1xcnkyHjZoH6mNJXiFRzvfqeP 2c1k4ZUe2WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8BOBAAKCRCPgPtYfRL+ TjUfB/0b32Iyq0kZRLUtcXIzCVQPi7abH4TVSOpULxzHveCuBFK2TSF+o933srKlXRzX62ezDXf HeEbM/TUCI7FwVZ5Jg+nG0jlOmret9BFC3EHeplFnvq7v2HJUijuQYb5BOjxHHZSfczCvxHJtvo we2nucpF2d8Sjg4GXsR35aKcnYdNtlDAWIfL1TYoGFS+Da7UsLLdkDezpq8snD0enbXdrC1uEgW RxGgMoqNznQU02EgEQxCyfdPINs0GEhih3hFC3q87GPMf6z7fG2Vx0aDe53GUs2OYiQOuEtl6a/ 2p1ZR+G506iE5a8/MJG69O737JjIxlPOiPLaccTJTUszSDUJ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While a calibration is running, better don't make the device do anything
else.

To enforce that, grab direct mode during calibration.

Fixes: 42776c14c692 ("staging: iio: adc: ad7192: Add system calibration support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7192.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index e96a5ae92375..6d06c48612ed 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -256,6 +256,9 @@ static ssize_t ad7192_write_syscalib(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
 	temp = st->syscalib_mode[chan->channel];
 	if (sys_calib) {
 		if (temp == AD7192_SYSCALIB_ZERO_SCALE)
@@ -266,6 +269,8 @@ static ssize_t ad7192_write_syscalib(struct iio_dev *indio_dev,
 					      chan->address);
 	}
 
+	iio_device_release_direct(indio_dev);
+
 	return ret ? ret : len;
 }
 
-- 
2.47.1


