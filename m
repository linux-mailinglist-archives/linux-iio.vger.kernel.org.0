Return-Path: <linux-iio+bounces-24185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2996AB5A385
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 23:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB8FA7A4A08
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 21:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC44328725B;
	Tue, 16 Sep 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nfTGOknD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FAC2820BA
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056635; cv=none; b=WmQbnrmHShM+9/L4eXlrgWiLceSYvncv6Jjat3v8Zz+y5lMP4n0SCb3eHjpUaI07DEMMddFQrvgYRzcLqMO2fcos9gIYblSwQeLnIPaXX9iDxGqnaWna3kCMQ9/Tid1xJqx2CZ07xny4WETd9JFpJKCFVRzdB/9sHfB2wIZ2OGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056635; c=relaxed/simple;
	bh=pvW5zRcWfeyVBSqoz2YuVw11X5u2Bz4r/sM+Ny8NzaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNX/40rNGWUqgWLx/a4jBOp42v+WiR6MANm1LDWVup4grObkPL2ySrbRUVkZdBdk5wSVStwpZrFaCEVTGspKFACh13DsMKapBG1vrVxOazbXzoUv4BjtHkFZbdVuHcwvMMOnSkHyRWobsrtINTkdeWYJa/Fqo0sm/t3XQDBkZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nfTGOknD; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-43bf671ee52so161267b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 14:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758056633; x=1758661433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HL2e/WuXZjgQ+ibL3M/EC4K8mQrgrMrBA77dFAoob1U=;
        b=nfTGOknD6Z2H8hWDN4zHeKrjz/FbQNgLUfkvadFoRljurYf5LY+Bb67ugx2GL1YUrg
         60zBr+vfSqI+3tLeSL1Xt33njNMrSRtPAO9tT7g5gG9GpjKDkW/aj+/JOfippCKuXehl
         MHW/xtnNAUfhTO9TMHfEbMiadaYMCc3KvDEK6Hhrjf2Qo6DCCjOzreNrYgodvWdBKt/l
         9tBWYDn8j3L2qrdfYNBZVVaNjx0vpmaTNCVUDBsxQf4+dIZaxCIRM0GmKifXdVF4q3/P
         fAZOy9yXnClALn67bC+mJo/reDjl5GPs21pKYMhnXZAGAHxlyYuZ5UBRZ2cjmF7v2bKK
         BJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056633; x=1758661433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL2e/WuXZjgQ+ibL3M/EC4K8mQrgrMrBA77dFAoob1U=;
        b=PdwUlD46y0K/htn1o8XHdZMW8p/AaU+z3zN3PvDhcq+vTeG+5SHGOcY0zjYlw7hRgF
         UxGFxDij4qUp4kkkoUUqemrWdflNyLvZfGZDbGXG1M8tko19OOi2nRca0y3PqsLRNJWD
         dXBiEVYU/1hVnnZYMRKPOPkwObCuvtTaKcaByxxvi1MJ9Ws9yjGQ2E4E27jfVEYLH9JX
         XX0Pv0ifqfjB7MgyGKW5RiGNitXsRDt+MvwJmFG8NyySmrpphynMMJqc6m4EPs9Ih3iW
         +ivYI0N/NAcBOsYawMV0l1PwnxMNua/KDeiiq/khlJdCPZOSCf9yp5/1FF44KQMT3AuT
         V13A==
X-Gm-Message-State: AOJu0YyCukK6ZQXI44/9Dwm12g+4vpMdXxjzZw8dJyVJtyiiBFLWQaSD
	DkZ4FP9dzreBhNTNYDXov9UvXkgjM97Wv4JLJnUIQKvM6nrapxL8VYS5pit/2BYAbDU=
X-Gm-Gg: ASbGncuTlQelm7l+OOzvYIQHI0/S5Xm6guShOXk0yp3z6GHyHzAKP46dCUzDRwE3POc
	OvLpfDxlr6HFdzKY3/756uaVNCSeJALadcqtAg4Fel5EmxZf+t9BcVb2wUT6XpUFf/iOA0zm7Wh
	esfm2wsWcoujEMi7BRmYrCXu4VVK1fzHNt2jysKExfH5DqONN3741ZBGUhQr68s9Re4WYyySHF9
	VgX0FPXBVLiW3gyG7saG7jLLnqBhciq8UN0e1AbKvkw8OTydT2e2BC+C557JRppcnxSEsccVnZN
	B7H8Tfuei2plQp96aKhYl4PzG6OadK9B3Ibn/lf6AocBFmVN2fky0DoQMfxzOWV1tcbxsA23VTi
	N0H1K3qHuw4Bgfp1QYs98KvO3/3Io
X-Google-Smtp-Source: AGHT+IFCkDG2Wd7hYTlZ9YHQ7MptC+whdynNDap9Jf70c5msRHifOUMwG7G/fxQ283A5VlxFfDvFTw==
X-Received: by 2002:a05:6808:4f4b:b0:43d:2454:b694 with SMTP id 5614622812f47-43d2454ba43mr5452806b6e.2.1758056632935;
        Tue, 16 Sep 2025 14:03:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b8294ac06sm3540044b6e.14.2025.09.16.14.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:03:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 16 Sep 2025 16:02:51 -0500
Subject: [PATCH v2 1/7] iio: buffer: document
 iio_push_to_buffers_with_ts_unaligned() may sleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-iio-doc-push-to-buffers-context-v2-1-8b17937a6cc7@baylibre.com>
References: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
In-Reply-To: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=pvW5zRcWfeyVBSqoz2YuVw11X5u2Bz4r/sM+Ny8NzaE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoydCGz0nb3t98zgUS4Vy0mVSAHDq4Di0yBzGlx
 Ad7/z0vBWOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMnQhgAKCRDCzCAB/wGP
 wDvRB/9K8/CMqZk+CvwWOwTNLvv+TYQg7ZAkUbXyhvoRnbq1pRVxfx40S1ft1ETBBhsuwkOPuEo
 TQOXcJsMOIaY53M1OjIG5/Ki/ZcaT0ZG3l8v2BymVa4+mWzK+SDs0XIq9dikRACQmCTPepxzIje
 WpRaiXmhy1S/8bdEVdX9g9lWAWFViY2vvX1v0R6HaAO83Nyu7xX4YcDxCh5FKt17RAPXiHIcSD8
 MBkRm5SyEMogpzHe3NAh+StDDaqkqIrXM5VCXzu4H4lXxBVJeFQXnDBjLB3HClV/hHZPWhswUrR
 fl5wKxqlZIJjfLO0BIqrdwVzp1HZUTdSzL84wQz1Y4Wo7qyX
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add Context: documentation comment that
iio_push_to_buffers_with_ts_unaligned() may sleep because it calls
devm_krealloc().

Also document Return: value while here.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a80f7cc25a27109cfe22ce447c4117fc94bc8310..7da43a1f2f75f32dc93b9a5fe903378a79e82fe3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2401,6 +2401,9 @@ EXPORT_SYMBOL_GPL(iio_push_to_buffers);
  * not require space for the timestamp, or 8 byte alignment of data.
  * It does however require an allocation on first call and additional
  * copies on all calls, so should be avoided if possible.
+ *
+ * Context: May sleep.
+ * Return: 0 on success, negative error code on failure.
  */
 int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 					  const void *data,

-- 
2.43.0


