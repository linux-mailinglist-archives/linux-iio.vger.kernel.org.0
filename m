Return-Path: <linux-iio+bounces-24025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E41B55477
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 18:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1A05876B6
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9F231DD9E;
	Fri, 12 Sep 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ApXI3buA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80F31CA53
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693222; cv=none; b=nVCyg9p+MQ8JSmGTSjiSJWtYt8YSQVGOrBnVJ5u34q6jBu2oY2w+27CMbsgqYRZ/RUs8jgagQimmQocCNxTtV+dwfvigkrsq9VF4WFJjTgRA1D0cVavydqbmNUSDUxzicwL+/FzW72xovqQaKpzMxjW059ftk92QLSOPIxICF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693222; c=relaxed/simple;
	bh=7TqvcYTMBp51/HUM9YZ5b9Xwf4ZwYLxzxeeJRmV5Wp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U3XyNyUDVcQOu4ED+ZGO0HYebViiTGFwuc0hXdQmVPKWYgsL8xedCRARCUPV9csX83LlYG5F576WheYB987E4aZdlO/R2gGIp2wkY6RcYInG9jupyKXKkXOrnvspqp09C05UmLtfl/1LvleNm1houDe5w1k2Bk2ZAGcJ9VyXR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ApXI3buA; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-753b6703f89so773209a34.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757693219; x=1758298019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qarimMMaMap40cHQ862INRj1ctQccJze110lxw4H9TE=;
        b=ApXI3buAH6MS6fB+GlsXaD/0SBig6KoammngD5DbWMgRcz7ntvKXbq1+yx+/Zc9oF5
         l6d5IcdwZooKmkUHxCtmeF1qRjxD8OkwthnjVIrjpMXFgitWZ62kMNN0yPhE2AA9Kb7C
         NpFUSz/Wjq2ojjvOuDDyK40dZDEXigcCtBXcnEsUH/AFnZNE08HksjhCoB0al9IvGm9Q
         BLptMVRCuatMoPLce4jglYr/BYL3NbFw59vyWzVMkdAxFPkAG8jiXR/DgJB9uWNPhWtU
         ObYRJO6QkR20VnIL3FSYGOx+lzJmpUB1dJkaBz+a12QZnXzXcgUgK/C/3uCxG1jKEIpp
         FDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693219; x=1758298019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qarimMMaMap40cHQ862INRj1ctQccJze110lxw4H9TE=;
        b=MTru03RZhOwxxjFieqF2ApF4bR05DgQyrEnC8l40N0ZopfSIflNsJQ15B5EfufK/EY
         a+UUyUW81caIO2ivYD5OnqOGTfbtsPpjhNELV/2DQUvYp/SJ9UMfpQXcW5a6WGDn7a/h
         WAYODMvydq2AdKtcar+2/ROcmm4In4HN952yGH7uhtkY9tiWA3WSLbKL1U5DgphkR3Qj
         Ck3LcrvLUS7lQF6WxCiGfl8dXYwVpob+3niSr3I3EUnM197pOwTLNdKOT/VtcIoRAdzy
         oTb57+5OHyOJDPrtd0+dmo7vulJziwV6hseQiCZzCwnzI/vmtCFbmFoFnKRVODCVOdZm
         s83g==
X-Gm-Message-State: AOJu0Yy3gjY0wder2KIkUtSltgGreBIe2E8x/inZAe+Zo2B92MogcBKV
	CSMCUnJQQaTgU5RF5EaG2dZyk9HqZtLEsxcLVWdtSChIkNUKy9B/MGbsnKN/loc8P6Xqr4Mb/st
	+U7YeypE=
X-Gm-Gg: ASbGncsbzlGlZhDfhyaCpjmS7G87Myd9wO4W+GX9UFYUWI1OE+XnnXNFxpGBsv64n2Q
	LLXbYzP3+Xs4veNjhSXSE5O/Z7Si5cb9Ws9Y0yvXx+w9cctmfjHrn88+90K7joK1sEUb5zbVQGn
	ofGH0/1ti5ELLN8OZf39BHNeISAMn4dRsnZo2vZ8HAApTDMrAmsTNxBv8IaLFQ1r60FSYqzNhO/
	oyaQfSlV2oeEJaQ9dIhsj81ufTUNa2MHDvqCQvqXXbxr5SLIWiND78Z6QtT3gqLEYe7dsec2h5f
	xuWGYb1PfZDYZXSnSYiXxb4hRmYNrPAs0uFCgCHbUuInQNyTvZt3Csjjh5+DZo0195JhqqTsV7e
	/mf21afTZSfe4rsA578TahczgVhDz/M6WDj/hRSY=
X-Google-Smtp-Source: AGHT+IE9e0ybyQKyJ//4kGPLbVl7PIgqS7VfHCK6F815HZBFYxMRTycI2FtsrSV2yYmsxyF6/hyorQ==
X-Received: by 2002:a05:6830:2a0e:b0:73e:8c8b:749 with SMTP id 46e09a7af769-7534fb80fdbmr1972971a34.0.1757693219400;
        Fri, 12 Sep 2025 09:06:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a39ecsm1073863a34.23.2025.09.12.09.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:06:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 11:05:55 -0500
Subject: [PATCH 4/7] iio: buffer: deprecated
 iio_push_to_buffers_with_timestamp()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-iio-doc-push-to-buffers-context-v1-4-c4aad013d96e@baylibre.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
In-Reply-To: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=7TqvcYTMBp51/HUM9YZ5b9Xwf4ZwYLxzxeeJRmV5Wp8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxET+EJWYdQcYzUzsp9PpgPfnKKv+VZ6ATmTtR
 8v45AiaQYSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRE/gAKCRDCzCAB/wGP
 wO2OB/0RD7F8XblbmZb46MSGf0H/G+n0y0/cLLx62zICRmCS+uOEJ20tCR5dztCnXNneYsq7Nbs
 UpxXnyxZaQ41OmRfleXqJgMQRhJgu0/Chk9rerrmdQNwuHpMd5RcNk+7vutTVwdIVebvTeSP62n
 s4PeRVnR4XtplcouUtwSl57pk6Xapq479vfPZJ2EaOfBiBEDl/GPa+V3ubfiO1YPfBYxkk21pAD
 YSbuz9THFWk3fJ5etbtfj7nupMCNBzqsb9br+NSsCfaaEWG/UpU40+VFtXJ5O0lumtIgWOSn1qP
 tKyfg2noBPxtmzPehzk2px+PWxrH4vBSPZKZ7RBMFt8Hsiei
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace the documentation of iio_push_to_buffers_with_timestamp() with
a deprecation notice pointing to the preferred alternative.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/buffer.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 47f23bc0470eaf308fc3a739faaf9b56cac0ef67..f07f6bae0cb25b0f51bd671206177508d1064b79 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -26,11 +26,7 @@ int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);
  * @data:		sample data
  * @timestamp:		timestamp for the sample data
  *
- * Pushes data to the IIO device's buffers. If timestamps are enabled for the
- * device the function will store the supplied timestamp as the last element in
- * the sample data buffer before pushing it to the device buffers. The sample
- * data buffer needs to be large enough to hold the additional timestamp
- * (usually the buffer should be indio->scan_bytes bytes large).
+ * This function is deprecated. Use iio_push_to_buffers_with_ts() instead.
  *
  * Returns 0 on success, a negative error code otherwise.
  */

-- 
2.43.0


