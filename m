Return-Path: <linux-iio+bounces-27127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00392CC5A45
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 01:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC2A93026ABB
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 00:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41F82253EB;
	Wed, 17 Dec 2025 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjSBQDiS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BAE21D3D6
	for <linux-iio@vger.kernel.org>; Wed, 17 Dec 2025 00:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765932748; cv=none; b=UXRyjxt1VbWwm2/UfSyf/vOgNfpmogbQDDgqDTNlrl+ZMrUmR2Mggsrc9Oi1O6CWgDTnEFOXvOjgxebLpJdmTV4R5wqkYsPElXJLbq0g0iE9nsfyWvEe9yPbbLYNV84QiFYK0Npu6QBLb5fPt+ir4jFgfh16mI6RGVW5WhSKdVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765932748; c=relaxed/simple;
	bh=OIBwUGMzURsVxHuDAfM9+cndMbjXayjCoeLJwgkHp1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mLqJpqkiUZr2Zn/RaMEvI0I5QNHGo6NBy/KwQdd8Y+uTmCFigQI3woHoev9P8Qk/vtnF9O1E/7p2wAv3TsISJeGauZ6DsO1MiJHQsDVD3N2KPabiVtNXkr51SfzWWXsTNNP410/AqZJaDwgWmz3+4D6ha4PogKbIJoIvZUUOzXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjSBQDiS; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94124140e02so2937060241.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 16:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765932746; x=1766537546; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31v0OvoF82nBFlvwEabpAGVFX3z/UuM7c1Cky+CLtVI=;
        b=WjSBQDiSgshAJ382WE6+NQ4uKnHyy86FVyEeMLKQJavgu2ry/FVb3U4neE/hECNS01
         oh9TglLwy/iGUL5tPfJ9QCUPr2jqaIGg2XhcxW92+H2HqHUEmRgm99o3aX5i0FBFGYaK
         s2IMLVHXkf0sLh+QEV7nIIFrsI1CXnqnSpKWj4bXr8kRwXJLrK6yZoB1nR2WOTTSovx5
         62Pnhxihl5zsZAJiuVIlp+d+q9UbWyUY/N/DKVZUKHgS/nWZYES8b75xsZTptSEkGHAu
         NFH8nLctyezjXraKA2aqSzed7fg7o2RyQ621h/GeVzrhdqtzqvojGOOeH3Na4xjCD1mw
         9PbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765932746; x=1766537546;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31v0OvoF82nBFlvwEabpAGVFX3z/UuM7c1Cky+CLtVI=;
        b=M+9xrPAYK3+t/5/gLkcMo5x1Pvm6EKIlMBdUYMcAdcOs1otnrcWXaxqVURsepQmVVg
         pF0vHOeq+bKjkGYSDmkFL/ItOQVlTEuoggumZsnlRxhDeqj1+F0gNg0uPZYJSazOokNg
         cxZUO+0Dx0oqw+RwTwDlivQ1ZGydQd1MO9CX75AZHMUaE9/pnMAKPEH+pMKI/78WbZHa
         3FW/O3NvD0M680q3BaHeuy/BvpuzekHqZhP7LgBV1R1MOYprk/f86G4Pf5OhpS2JdZva
         in7UFX4MfM9OVmRHtOgBpAmMv+bt4ohN+mSy8YSHwNjMx2TyrwMChzQXJidI9WpnEzo9
         y5GA==
X-Forwarded-Encrypted: i=1; AJvYcCUzMBy369LbEOsvfsr4+1FCGGpSgmhAxcvds/P/pkCA2o2yFfaPdHWkVBibreEOFHfUWazYoYeO3NM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0u87vUB8i1HSnbwbR/h++LA1ItzqasQqBnTQ8VC7Kk1Y9vMqe
	RL7DA9m3nwJy3/IYtYHzYVqagbrqLp6CNgmxRdcXoXUTb1Tot8NOk5va
X-Gm-Gg: AY/fxX5gwDVe8nFrmmJRH67vNn+4Net2n1uuJA1/JUYC2ku/7Rp5KCi3UJWJnQwswLe
	nRZk3TNvfv2mHrDcQ2/Ph7CxJFLMgl8U1rCsD5ifSEFrMW4ccaoV1e4Szq4tRkz4VXyhpf8VUpO
	NFkP8Oqb8devpZhe8euCPzRty59rJnJJLBSed56qhKkYUYBzDuXkC/hKvYPMk/gTIWNHX7GkPEV
	ciuEIFuOAzyJHb5OZ3Elpy4HRdkshU6rH5VEfzKAW4WgGi+LjJ0+grHAEneP6jiBANHE+TAaGqn
	UfrI4eDDEHVa6Na8NA6aS3r1xB2/G6oRH6ogdyt6N5vkElZOWxTnGGASkG2FhpDS89Gh4IO1vRD
	cRV0AxArhV2timNC1S5fSx8PDaBw8tWZZXyvolh8FkZ62+QsotYX2tVrS4W5WvOUMUZ4AhnmT6m
	iQwuHKk/y6tTCghA==
X-Google-Smtp-Source: AGHT+IEt434s6X2fF9D6aiTtzTp5M5N4ionDEdscyhDZReNu8ZOA8m8/JpzjWnCf0O1Iw1FiQk+H7g==
X-Received: by 2002:a05:6102:3711:b0:5db:9ab3:4291 with SMTP id ada2fe7eead31-5e827836d49mr6481794137.33.1765932746056;
        Tue, 16 Dec 2025 16:52:26 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:11a2:c6ad:1d0e:15de:a612])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5eaef3999a5sm190289137.0.2025.12.16.16.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 16:52:25 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 16 Dec 2025 19:52:01 -0500
Subject: [PATCH] iio: adc: ti-ads1018: Drop iio_device_claim_buffer_mode()
 call
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-ads1018-patch-v1-1-cf41d193e187@gmail.com>
X-B4-Tracking: v=1; b=H4sIALD+QWkC/x3MPQqAMAxA4auUzBaS+IN4FXEoGm2WWloRQXp3i
 +M3vPdClqSSYTIvJLk16xkqqDGwehcOsbpVAyP3xDRYt2VCGm101+qrkNuRBR12UJuYZNfn/81
 LKR8PVlCcXwAAAA==
X-Change-ID: 20251216-ads1018-patch-ad02382e0a04
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=OIBwUGMzURsVxHuDAfM9+cndMbjXayjCoeLJwgkHp1Y=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJmO/3b3RTRLrFvB/n7v9L5ltk2aRVsXVts2un0P3CGTY
 7d1CSt3RykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAEzkRQTD/+I55+be/85ZnHNo
 b6uDjMj/T5dsQq0W3q2ve9nsZeCpfZHhf07Cidp9PfM3bpZbNltxutSbts8nfbymLllTenRzctj
 GZn4A
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Drop iio_device_claim_buffer_mode() call in ads1018_trigger_handler() as
it's not actually protecting anything.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1018.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
index af08702b62d2..b34184f68e63 100644
--- a/drivers/iio/adc/ti-ads1018.c
+++ b/drivers/iio/adc/ti-ads1018.c
@@ -557,9 +557,6 @@ static irqreturn_t ads1018_trigger_handler(int irq, void *p)
 	} scan = {};
 	int ret;
 
-	if (iio_device_claim_buffer_mode(indio_dev))
-		goto out_notify_done;
-
 	if (iio_trigger_using_own(indio_dev)) {
 		disable_irq(ads1018->drdy_irq);
 		ret = ads1018_spi_read_exclusive(ads1018, &scan.conv, true);
@@ -568,14 +565,11 @@ static irqreturn_t ads1018_trigger_handler(int irq, void *p)
 		ret = spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_buf));
 		scan.conv = ads1018->rx_buf[0];
 	}
-	if (ret)
-		goto out_release_buffer;
 
-	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
+	if (!ret)
+		iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+					    pf->timestamp);
 
-out_release_buffer:
-	iio_device_release_buffer_mode(indio_dev);
-out_notify_done:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;

---
base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
change-id: 20251216-ads1018-patch-ad02382e0a04

-- 
 ~ Kurt


