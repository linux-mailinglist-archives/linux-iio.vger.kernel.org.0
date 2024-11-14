Return-Path: <linux-iio+bounces-12289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A52459C95F9
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2521F214D1
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2191C4A21;
	Thu, 14 Nov 2024 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WS6QGxjA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AF1C4A0A;
	Thu, 14 Nov 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625846; cv=none; b=HW8A7gLI0/i7wpflHGYQRs6Pf7fbbN2xlzDkIJzpLv0Mzvfdy6JVXlS43ROnTT/MR0n0oDyOgzLd3KDDCFUFgrMRrSxXqxxe0UDwfDQ6kLfU1Oh1DbUZFJRI7BlAuoX9GrUh+/TLglBeD104TBTlhCzR+MXmAvnwIbYES5FeKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625846; c=relaxed/simple;
	bh=qjcvQiDwqWl74/TaQREodbiQV4n8D4Oz2kxdCCVLkkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ErOUDxThWLUGMlWubjZeVYFDZiYTLrp/3N9Lza98Mi7LOCnrLSxOFzuOxbcNGI+U3CL1Vx2AM4LrWF07QSPuiT8GR/Re/tGH8DqLJfk5hsmEto122mcBNUV8fFUHxVjLeNhDjdOMazeAPQtNDYwRhOYvKCMN1SBwE9CNxRhL4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WS6QGxjA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315b957ae8so626835e9.1;
        Thu, 14 Nov 2024 15:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625843; x=1732230643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhHizrLkDaUDWUHXJf8ydQRCylx5R9sjJE+vTDEeYi8=;
        b=WS6QGxjAjvEYuJYhBTUVwF2YWWinXtTNhIt5fOBVHaF76Ko3/dv5XRImX/XWUDx8tr
         g03iW5RRmUkynljxJJVDo/irbNGss4nbZ0I4eIqD/V7LRNGXL7gFESCxTEic3iKdQa59
         r//e/DW/l5uvNsG9EY8jvTXAfa8IMWqc1035DlYcfrpHuAu+Nf8wM+Rln+3NCQda+L0T
         RHRbZcggFFeqCBDpKNyM+zU2JRja9mi8/neNumWS/UGUbOyrQYezpNfrYaFJk8yUcXh/
         eLwmMo7YD4r9hopHUGb1J7O4ODW1ozOAm+IhA2HYLWeBSLwCsqysyBfLqeRbiUDS0jFf
         eOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625843; x=1732230643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhHizrLkDaUDWUHXJf8ydQRCylx5R9sjJE+vTDEeYi8=;
        b=cq/Kx5yiS2zs7G+a4TNpqFWEOxC6WErwfGv6fDjqitKLsTxgZmVmpq5iN7esqPMsr9
         zgVcjeoS+ae3yLigtItJrCrGPLcLWELu725/uGbsAXAZcN0/1ZtYytY8QZLSdTMWEJfU
         0QgmCb09CnUXFq3CyMN5PCLzCgVtGWYSXbwbPrYTxwHSs9gqFZmABay+MQphwm3Nj26R
         WC4EBQ8wvlpK6xr8ocdRz9sTsH6ftPj1vGn4YqFilSSTxVI8iZdWnqxS5Hhv9CKInF11
         r1eJgWucmwSylBJ10AxzMebxGaEJLoOkYJvE9TUuvhvw7qlrpCaoA5SCyoP4qnHZaWGL
         S+ww==
X-Forwarded-Encrypted: i=1; AJvYcCULWA+SUhFs2wLAQJyoTJ78y2t1XQtS/ntnfh/UzcUEpHnPWspSjTiEZDCQYeAxxdJNwN01E44FBknZLLDS@vger.kernel.org, AJvYcCUPbNYk2ZBL/xTGQCoUyrLFKk3vAHqJ1QbB9HgWmLcKDu6moLUHuk/NoCL6kBFxnMoeofr8ECIoOGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNJ7hcEIqcIKc2s0C7UbqUe+1xDU54ky/ZKQow4U8GoYutyoVl
	MJO+mJl8CZhyAXiyaCuuK4nVBI8mVoCupjfIqKeWizq9DONtdEp3
X-Google-Smtp-Source: AGHT+IFguQvS/rPoEmbopV/ojY5tjFUWE8vkv9yEqF+Mg534bt6RxXEnD23G+ND+KZ1THEN++M24DQ==
X-Received: by 2002:a05:600c:1d0f:b0:42c:ba6c:d9b1 with SMTP id 5b1f17b1804b1-432df78abf8mr1626495e9.4.1731625842826;
        Thu, 14 Nov 2024 15:10:42 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:42 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 21/22] iio: accel: adxl345: sync FIFO reading with sensor
Date: Thu, 14 Nov 2024 23:10:01 +0000
Message-Id: <20241114231002.98595-22-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241114231002.98595-1-l.rubusch@gmail.com>
References: <20241114231002.98595-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pause the measurement while reading fifo values. Initially an interrupt
is triggered if watermark of the FIFO is reached, or in case of
OVERRUN. The sensor stays mute until FIFO is cleared and interrupts are
read. Situations now can arise when the watermark is configured to a
lower value. While reading the values, new values arrive such that a
permanent OVERRUN state of the FIFO is reached, i.e. either the FIFO
never gets emptied entirely because of permanently new arriving
measurements. No more interrupts will be issued and the setup results
in OVERRUN. To avoid such situation, stop measuring while solving an
OVERRUN condition and generally reading FIFO entries.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index ab39fd8eb5..8025dfeb84 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -714,6 +714,11 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 
 	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
 		pr_debug("%s(): WATERMARK or DATA_READY event detected\n", __func__);
+
+		/* Pause measuring, at low watermarks this would easily brick the
+		 * sensor in permanent OVERRUN state
+		 */
+		adxl345_set_measure_en(st, false);
 		if (adxl345_get_fifo_entries(st, &fifo_entries) < 0)
 			goto err;
 
@@ -721,12 +726,15 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 			goto err;
 
 		iio_trigger_notify_done(indio_dev->trig);
+		adxl345_set_measure_en(st, true);
 	}
 
 	goto done;
 err:
 	iio_trigger_notify_done(indio_dev->trig);
+	adxl345_set_measure_en(st, false);
 	adxl345_empty_fifo(st);
+	adxl345_set_measure_en(st, true);
 	return IRQ_NONE;
 
 done:
-- 
2.39.2


