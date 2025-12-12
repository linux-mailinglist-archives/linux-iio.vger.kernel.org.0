Return-Path: <linux-iio+bounces-27035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F96CB7B43
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 03:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 903683066707
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 02:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC413D503;
	Fri, 12 Dec 2025 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaoAKfpK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69000EEAB
	for <linux-iio@vger.kernel.org>; Fri, 12 Dec 2025 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765507549; cv=none; b=JcS1iVeAeIDoVV3KgQiNwARkI6DZ+aVkYeo9hWEYNTG6uate1wpId4ET54Zt4K86E2kQzJSU8dCutuGFKEIxFLdkqfHXlYyY8wyhAJrXFE4tjHuxEUnDmr9U01mxoDloCEBr3SeMMyCpHTfZ6BDdFLTT64ju9ZgEL65VJu4cLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765507549; c=relaxed/simple;
	bh=m4docKzSN6U3IisnQGU0vDNlqcdF+sgdQ/746l+2whQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hrOvTR7LyKydzTZRnGBwYk0WLoUMgTgoeUVATZWxqFzh2bfeGGnE3EpBmZFggGt3tJ9O1uFLbHup3jAMfQQ1VrswZGUf5McLhCifckf7lu1qFN1DlNxqJfEyRM0OD9PV3HKRcxQLP2RRjYw7L9VRFCNvihvQrjYC0RE2Z0QRHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaoAKfpK; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-55b26461e78so236932e0c.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Dec 2025 18:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765507546; x=1766112346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZxE86UOpBkEr43S5oO3m/muydq3y/4ppHxIwZHfNzc=;
        b=SaoAKfpKRDp+Pf5nRlOYCPsBb7uyOwpVe/VI0nsJxnOuf0MDhieXaKaoR2djWH/j13
         m4qPp2GzDxJ2W6qMy2+rWzfE8EAsnpJjhNET5mdt68Gykh/SBTafbDkhyZ8kpc8wFE5L
         nxdxVz63trEvcAyOgyj4CTGJEu8WLq6liXe/hXbA/g5zZO+a7wunqoTctT4NNX6UdhPJ
         DFuVtvmi+eHYQ0jgdt6kv3rGPUPD/jycAoCkAjvy8OmRYgE0+lmH9hExB81vfsJJXbZa
         rvIiZsrKJ+ZkqTKJO29VLGZDyYLRfe/WQ+TDRZXp0tsLMNWqtSE5mv3UNJC6lT/60Xh6
         8+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765507546; x=1766112346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SZxE86UOpBkEr43S5oO3m/muydq3y/4ppHxIwZHfNzc=;
        b=g4E80f5JJzMe/sQHBoP/QqleXA3u4stZTDSgKbJpg0Ges3PJltwS+oo5Gg3lITafoo
         XE6Z263aRrzeBXQgHK7Xq/4D/9moN2AgoLIXl7tC5dA/F7IT6a0aJL+ZJSMYeRoLa8yg
         I+/NFNY/Ix70AKguyhhOtFKYrX5L73w99aFTA7Y98NluabqfiZQ5u7KtFH3VLTnwe32y
         Ajsvl6RjXNQjwhUQpQqUpQhdO7yFkb6eY33KeLjSqxZkEvP/M+ujl2NA4LoncqAK58/l
         Zi0b3vJS+kqwJyj7tSOjgFu/LJJ3qsl9Xoo9vD0rgtn8EFvU4rc0cvgk+YHa9v/FUSGN
         0G7A==
X-Forwarded-Encrypted: i=1; AJvYcCVf/i4so9htW2MtF+MTRjs7XGWV3DTKtN581XRg6rigZVNodmYYVSqIBSzTH+tpk5dqvo83f1mYtOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBIsT3ijUyFgq2HHZSFYS1ZBGp5Weif+OPDYnxRA+nl9I7LTLW
	b+jjjtG7qA7A5gPtTqJWxnAxCKVJWMTKr+2hfAJWleTss3R4wv8Wfscs
X-Gm-Gg: AY/fxX5PYjoZUIbOF2nIkvCsYCxXLbaLAkMGl1yvruhrv1aJQRfvqBlBVeUwvDh2NnT
	qnMgJtt2UOgr9yfHQmnOhp810qUNtU/9oQAGbb6Clsww1YuDEtJkaXkC5p5qFzAq2hj4/BzoOeJ
	N97X70Ec/h0mIwq/ELFNz/hoKjAbzWdotyjsv0ECi/A2/TqK+0biC1TY3moT4rxJtC+TBMir016
	nh3VoFG8GM3qP7w35SHmv7zPrap/6HzUhcSxNaz4Whg+I0JDYBJnFKER44iqV+kTqcVC7YKt7Vo
	Ct+dE2HnN9QiEcw8JvyZHbsAqXay2Q+O4nvqgu1QM25Fg6Zl9CzN8zJimniNGgvSaawrSZaZ2dz
	HpmiWqFqTMLiSAxcleQafrUNAktYaruAn0A8MVvBaQnnucOv4dpiCxosyiym9SUUhDrVi7t7VDL
	A10oLh4wyWY5xL
X-Google-Smtp-Source: AGHT+IE6R1SPTPYAVrVVaJYQAbRBZp7N0gNjOqqIWn71FlnxAZHPp5xMi1+R7KzVuAZ/J+ZqU/BtQg==
X-Received: by 2002:a05:6102:5a9a:b0:5dd:84f1:b51a with SMTP id ada2fe7eead31-5e82788200bmr94910137.43.1765507546232;
        Thu, 11 Dec 2025 18:45:46 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e7d0f25ce2sm1693762137.8.2025.12.11.18.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 18:45:45 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 11 Dec 2025 21:45:24 -0500
Subject: [PATCH v2 6/7] iio: health: max30102: Use IIO cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-lock-impr-v2-6-6fb47bdaaf24@gmail.com>
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
In-Reply-To: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, 
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1978; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=m4docKzSN6U3IisnQGU0vDNlqcdF+sgdQ/746l+2whQ=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnWjSf782TM12mtP8/XLVE3/SujM+vX+E7D3v0PsgoT4
 7rSlvN2lLIwiHExyIopsrQnLPr2KCrvrd+B0Pswc1iZQIYwcHEKwEQO8TEyXOz/F91xtu8Zq0IN
 k7oqW+9J0QJmwWzmaWVZK+Sm75UqYmSYWfog54KZl+KBeV8agr+f2KM/yclxx5tNi3Y3TJomx2f
 MBQA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Use IIO_DEV_GUARD_ANY_MODE() cleanup helper to simplify and drop
busy-waiting code in max30102_read_raw().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/health/max30102.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 288c2f37a4a2..94e15598ffe7 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -467,44 +467,29 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 			     int *val, int *val2, long mask)
 {
 	struct max30102_data *data = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
 		/*
 		 * Temperature reading can only be acquired when not in
 		 * shutdown; leave shutdown briefly when buffer not running
 		 */
-any_mode_retry:
-		if (!iio_device_claim_buffer_mode(indio_dev)) {
-			/*
-			 * This one is a *bit* hacky. If we cannot claim buffer
-			 * mode, then try direct mode so that we make sure
-			 * things cannot concurrently change. And we just keep
-			 * trying until we get one of the modes...
-			 */
-			if (!iio_device_claim_direct(indio_dev))
-				goto any_mode_retry;
+		IIO_DEV_GUARD_ANY_MODE(indio_dev);
 
-			ret = max30102_get_temp(data, val, true);
-			iio_device_release_direct(indio_dev);
-		} else {
-			ret = max30102_get_temp(data, val, false);
-			iio_device_release_buffer_mode(indio_dev);
-		}
+		ret = max30102_get_temp(data, val, !iio_buffer_enabled(indio_dev));
 		if (ret)
 			return ret;
 
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000;  /* 62.5 */
 		*val2 = 16;
-		ret = IIO_VAL_FRACTIONAL;
-		break;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static const struct iio_info max30102_info = {

-- 
2.52.0


