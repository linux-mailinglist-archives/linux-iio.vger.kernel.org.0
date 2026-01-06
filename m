Return-Path: <linux-iio+bounces-27499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0930CF74DA
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 09:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98CB6307E259
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 08:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D830C614;
	Tue,  6 Jan 2026 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUHRbN2f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6030C37A
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767687457; cv=none; b=kpsMBT/fvDQWy4Dg9X/eXIMItiTdLAoO1gFtHXB88SVrXcFNEP0JvKxG0inoro0UVftPULq1mU8XIOxcLNnZL2XdMhvJltH+uM3JmMDJzoh7VrVA48juKFshLq4I66Rkxpd7nI4UmpgXIr14RiK3td+dEDAvFXWhvP4emaSWUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767687457; c=relaxed/simple;
	bh=FOPUkitsqaF8YzC66VZOfPEJZqQAjxcGjnj21GYvWAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=noiLjHjk202P3AprW98rPI5dGFCOjVZU+/VHtO6hiH8OR+PMgpR+XHSsP50C6oALiZsdZGrUM+h23CQ/tfRnpjS/IrTfVPJ7Nx3SKbEPcvRYaK+lcW+7XkHM1LjHd7lheV5zKfuRYgyrjlW9xq69q7wrrqjGoFeQA3cjEYQmycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUHRbN2f; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93f500ee7b8so331857241.3
        for <linux-iio@vger.kernel.org>; Tue, 06 Jan 2026 00:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767687455; x=1768292255; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ddGdp3Su2MO3oeW79PLeKeX536BVDQjrIolsAybpzg=;
        b=WUHRbN2fv6FA689+zOvzc8Ziekt32Oy0dV5BQTeL+7NEz99d+U0hrKBMy+2RE6+b+p
         cf7Gg5bwWbwtNPrngbtl1hBtjZ0G35qKQcZlOa7dVztg8N0HPiZrYpcl5gH3mLzV9e0r
         7J3c7R/jvWnqGyYQTVXMjkS/RDYMtFRDdPxYHaWAUArOlxKXVLrVhSEEw7fYpguRLFIH
         jnGkiuhnu/kOVgOkucUnUnFETqDw016w5Z8DqDseBJd4wxRMaeyddcVE8uizeSvZg2cp
         N92QUjJXtjhjMIorcnsxiNhFaqSlRoxcyY/2tuDIZRAXKD1C2JdMQ12uQuakjfiQyLqV
         tGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767687455; x=1768292255;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ddGdp3Su2MO3oeW79PLeKeX536BVDQjrIolsAybpzg=;
        b=jZl53F1Rbo99LUmfAqdEwTXbUaD0RbHXhNKzS5Gd3luYsbdG06x+XY3LxRgIG6GMi+
         Z9odaDQDDn+w4FmItXcrI9rbDGzz+m0r3JJi5pvTU+zkPY0cSOOFvh6oDHxano9IRp8o
         A45MVnw6HJZ1SSXXtUn1RdHp8YPYCmAcIRWcwvzNjVtClR99bTccCw8dIzcolLvmfCKp
         VrjZ7TlUkkiHj+rvGn/dsUAedGiafdI7kdnmXptR+Vv7dg3ilbroffmafAzZunONn/Bh
         QXfogLDJ6i2uDpvUodS3O8WpQcVGBUe6pg2yLFvTrvs5D6ocI6i8TdAGiz90O8samo1n
         ADPg==
X-Forwarded-Encrypted: i=1; AJvYcCXW62Kw5V3YI560X034+V/0/MXK+lzrgfxCYxxjBB+FQKJBjlk9PAFKPAUr1f6wFtwSI+7S8bIvHTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYV8KC0tkFRI07OACWvuqM8Lyp/rRFDvrb0+yg0nm7htBsxxu0
	ERAgh/gr/XHYq4eHyvK/sJyWK+FKuWvrYF1SktLCbEmtlfkhENsYP+r8vc+3Hw==
X-Gm-Gg: AY/fxX5HOAKqYQfhAkihUF1fEOMkg3arLm93Qh4HdkGxf3ZsLyjcouxXerSaiVrCk8Q
	8pVCZUQnpt4Fq9lWhHn0aOPUcpd5z2LOeS7aHBoylUccakJQ3TVjj+Byx6RGX72gEBSkuGk/YzU
	nQurjvf/qjL3EHjFi50YqhFteZGZ9NiyRjIp9k8YV/JYsvpa01YHFfebauMe9JWA6djPPgTU/H8
	iTg0Qj2ApVHQp2jqTe0JOaJLolwQzzkPLTQMuykP67YMWOJrZE+B9ZifGMYXCDNknB4kfJQNnMo
	KalgNtIbcW5A7zCFdsQRjHz3o8CWrywfRqRneLznRJMTbTltWZwjM3jUhGM2kqOISvgcOBy/FIW
	djS9b2KcFM7+Om7SLT0EF3V4Na/94RX8CGozhOTj/WsMHQ3vxq34/2tFfS2Q6tk47Mr2boZTiCw
	2VWc2yeJBpv8j1
X-Google-Smtp-Source: AGHT+IHHKlQ5vjlh3st7d386BQ191FebEFIku11RDeMl6skzeQhrdVWdk6pjpJ+3acXwO7/xm04sDw==
X-Received: by 2002:a05:6102:8096:b0:5db:331e:4c1f with SMTP id ada2fe7eead31-5ec74378154mr795535137.16.1767687454857;
        Tue, 06 Jan 2026 00:17:34 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ec7702eb72sm426510137.4.2026.01.06.00.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:17:34 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 06 Jan 2026 03:17:32 -0500
Subject: [PATCH] iio: adc: ti-ads1018: Drop stale kernel-doc function
 context
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-ads1018-comment-v1-1-315d50c2a353@gmail.com>
X-B4-Tracking: v=1; b=H4sIABvFXGkC/x3MQQqAIBBA0avIrBNGCZGuEi1Ep5qFGhoRiHdPW
 r7F/w0qFaYKi2hQ6OHKOQ2oSYA/XTpIchgGjdqgQiNdqAqVlT7HSOmWsw3orPbGagOjugrt/P7
 Hdev9AwgtrwthAAAA
X-Change-ID: 20260106-ads1018-comment-48d0a82c6826
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=957; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=FOPUkitsqaF8YzC66VZOfPEJZqQAjxcGjnj21GYvWAg=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkxR2X3fnh9tfZQ+4/KV48qt7x4t7Pv28yb4f6auyXVf
 C511/7p7ChlYRDjYpAVU2RpT1j07VFU3lu/A6H3YeawMoEMYeDiFICJ1P9nZPizXaL/Y/Pbbdtq
 zea5bN+QztkSmcuaaLDLfaNMhFJbbjcjw7otqid/XHiw7Hf829L0pqXr5GZvKbf3v3uxaZLsrVd
 FrlwA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

The driver no longer uses iio_device_claim_buffer_mode(). Drop it from
ads1018_spi_read_exclusive() context remark.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1018.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
index 286e06dc70b8..6246b3cab71f 100644
--- a/drivers/iio/adc/ti-ads1018.c
+++ b/drivers/iio/adc/ti-ads1018.c
@@ -211,8 +211,7 @@ static u32 ads1018_calc_delay(unsigned int hz)
  * Reads the most recent ADC conversion value, without updating the
  * device's configuration.
  *
- * Context: Expects iio_device_claim_buffer_mode() is held and SPI bus
- *	    *exclusive* use.
+ * Context: Expects SPI bus *exclusive* use.
  *
  * Return: 0 on success, negative errno on error.
  */

---
base-commit: fb2f4eb29a258145b0336601f00509cab6e93e7c
change-id: 20260106-ads1018-comment-48d0a82c6826

-- 
 ~ Kurt


