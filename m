Return-Path: <linux-iio+bounces-7825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6066393A467
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 18:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC671C22791
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4036D156F5B;
	Tue, 23 Jul 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zOjW9uRX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406914C5A1
	for <linux-iio@vger.kernel.org>; Tue, 23 Jul 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752349; cv=none; b=K/Fvet4HWh0+VaoFwQDjG6OmxG5RYa+sMdL8/XxTA4jwxy9VMsXlhDqtj9OzcyZAheSyDJuNU8XT9LYN/EIXJna4pvnmPbmVFJkoITj4Q3qYJ7poD598eXO6I/V3Pj4BNl7cn+cLYMXBmU+6XWBG2kvaE2B1F3QKnVoWJQze5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752349; c=relaxed/simple;
	bh=n2lu+xc1damMhtV2/Q38OMCRvnhU8153f+AK+DY6Btk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j/A52YltHv2cGIKvzZ1GAIWEh/p7dDi3B32OpKKcWz+4posZBbAMJahC+3ryELxHNbVVX4ZJrZEhZp+UxECBWa4sjfxbMPZ7eX4DC0UyEPYQUFy40lribVhpp5iFG3igaa3gbyUtAvPkxxsXvVEM7H5UyA5+10MS4ule0IXV8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zOjW9uRX; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d9dbbaa731so2735691b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Jul 2024 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721752345; x=1722357145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eN7VRIp9/i/dgG/hm5p1+wIzMlzlNC3hGBHE6dGW4+I=;
        b=zOjW9uRX4R49Xd21rczLDuyZIfDKcrTdDrb7bgCbWPL6djBYxpXj2npWKNdT0qRZys
         gQ+KRRriD8snxupYu03Qh/0TfJTvnt2pr6ioI168RYicoA2fGsSKp8KpcLIswAb4dnD6
         8QbkEddz1IzljAbT4oExGJMgpp4dg+24vmNhKG+ju72nN3g8XV/fpAfKTmmIkNPUUjVe
         +xluj2d3jzpRcYkpc3bH8NwCcSGhjZaiksuEPfh8h1gNrGx/oT+ObAzgp90+k/XqHy5y
         0XXxK5nXsqsxVfL/Tv2jtAmAimVNQDRr3Q9JsQZyTi9DbIJUkdeNapY3uj8jhGZBay/p
         wcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721752345; x=1722357145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eN7VRIp9/i/dgG/hm5p1+wIzMlzlNC3hGBHE6dGW4+I=;
        b=JJ6Yxk5gV4C1Zs29AuHQ5XDHP2MtfK6sReiwKu8UtYxPjrN1Knzd++xyWhhuWB5AXe
         RqNPB5xwSSG00xHTMXYD1oLEgsZcZ6kQ7MrGhhZ88IYVVq4b1FZJ3qs9N2nrH4Wdd0fk
         FhaafEE9tkRlpPZcJajN3uUfYsokK4lIOuWb+B3GKY94+T0U+ggdblpRLIfwItNMpNtY
         pWD6WsSeLaNQc9q1/GTlbEVaeB2u/OIAANSAv3xnWTeZuRKBzZZZG6yO5gByyb0isQYW
         lleKZkJDl/X23LgLoHXJqNTB7jHrDrKDVupRDHZwB9p8dQVDrbvVPi1HWq/R33E7YUM4
         coEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGeOyn3O2plJUDyrEsLXIrMxJCscQbWj9j2x2gov4BgDksf7PDbFAHYcytd9olB6zn17GUWlKnOow6GyE1VWh8N4W6/8n1klA0
X-Gm-Message-State: AOJu0Yzs+h1DOLejjVSzZtcSlZOLGsjAhPi8LKyJpaKshkJIrtoHKGcL
	vvQH2ZbFNPn4huvAH7niyB9TquDvyR6OExpJV+hrz6o3CaKBdx/RhJQPJIBrKyw=
X-Google-Smtp-Source: AGHT+IElYjqtlntweUAQ9FRLwEP7QASzifJEEDV84BIjUwY6wMHfHDqut2WWeBHjJL9aw8WVaRqjAg==
X-Received: by 2002:a05:6808:444b:b0:3d5:64f3:df63 with SMTP id 5614622812f47-3db06d751c7mr356793b6e.17.1721752344817;
        Tue, 23 Jul 2024 09:32:24 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae0978889sm2032885b6e.13.2024.07.23.09.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 09:32:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: buffer-dmaengine: fix releasing dma channel on error
Date: Tue, 23 Jul 2024 11:32:21 -0500
Message-ID: <20240723-iio-fix-dmaengine-free-on-error-v1-1-2c7cbc9b92ff@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

If dma_get_slave_caps() fails, we need to release the dma channel before
returning an error to avoid leaking the channel.

Fixes: 2d6ca60f3284 ("iio: Add a DMAengine framework based buffer")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 12aa1412dfa0..426cc614587a 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -237,7 +237,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	ret = dma_get_slave_caps(chan, &caps);
 	if (ret < 0)
-		goto err_free;
+		goto err_release;
 
 	/* Needs to be aligned to the maximum of the minimums */
 	if (caps.src_addr_widths)
@@ -263,6 +263,8 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	return &dmaengine_buffer->queue.buffer;
 
+err_release:
+	dma_release_channel(chan);
 err_free:
 	kfree(dmaengine_buffer);
 	return ERR_PTR(ret);

---
base-commit: 472438c7e0e2261c6737a8321f46ef176eef1c8f
change-id: 20240723-iio-fix-dmaengine-free-on-error-6e6e8b4dd058

