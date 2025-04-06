Return-Path: <linux-iio+bounces-17700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70123A7CF25
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E4816BC48
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6984183CC3;
	Sun,  6 Apr 2025 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJvlAyCq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ADF1487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960052; cv=none; b=FB1gnRwVm5q7ssVrzhlKboUzkgrIbS2HjTtrRl6i9R3xSkaCCr0UO4rpgP1U09ez/xUyZu/6LCZaM03oU5aGKibvpdqaTy4fKEosTQYSV2uy2kBu7PyJoPdPC9VsRvf0NAa2xA+Fk7i0qtuw/dH09Wvgn6N9i1xCNCSoetBP4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960052; c=relaxed/simple;
	bh=zrG5xFKeYlA7zxnU4/g2pIMqmBGn2uG9o8FJf3eKWxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FybXHCLT/eKZgvfkEIBdy5gIzbWN7xoRLP4sDD8H1tgws9WgwkByl21ndZbeUMLt3EtdHNwxfkqQtipxiHGrcptB2MCF79Am1MhuDyStZgQXLX1ZtUuurPd8QR2JMXmMbYg/Gdbf3jW5yNFwycxsOeUZ2FSwU5xc6vz6LEQBYQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJvlAyCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F14FC4CEEA;
	Sun,  6 Apr 2025 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960052;
	bh=zrG5xFKeYlA7zxnU4/g2pIMqmBGn2uG9o8FJf3eKWxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJvlAyCqPT7nOePiYm/qgQQB8KesEOID7iGLrDWJYrThOZ01rhwREXLw8S4P5/ZYW
	 5zujjYZ8E0wiuYK0pT/6A0ArrjXPfdnlOFAimWkgG0Yd38JH6uAQSox7kNcbkEdZHI
	 jHxx+Ad8BnMnEovcrlSGAyDQ8oYFmtCri5oUYVi8ZmDi4on/+3MfFsb8e5sR44s72G
	 KGg5ln6S690K4cPwwZ1sl+d+yGF0ZXslM9XWRUWqJn0meexlE/UU5471tVfuSctoC5
	 weHaAkldohqgySdgaR9YZ+Fmn//vdYF8KxNZPJgipNHDyk2z/mB0Id0FVYSu6THzHk
	 QGIFi+FMdFXtQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 12/20] iio: chemical: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  6 Apr 2025 18:19:53 +0100
Message-ID: <20250406172001.2167607-13-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406172001.2167607-1-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This new function allows us to perform debug checks in the helper to ensure
that the overrun does not occur.  Use it in all the simple cases where
either a static buffer or a structure is used in the drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/atlas-sensor.c | 5 +++--
 drivers/iio/chemical/bme680_core.c  | 4 ++--
 drivers/iio/chemical/ccs811.c       | 4 ++--
 drivers/iio/chemical/ens160_core.c  | 4 ++--
 drivers/iio/chemical/pms7003.c      | 5 +++--
 drivers/iio/chemical/scd30_core.c   | 3 ++-
 drivers/iio/chemical/scd4x.c        | 3 ++-
 drivers/iio/chemical/sps30.c        | 4 ++--
 8 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 593b73ccbeb7..39181bb3e953 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -458,8 +458,9 @@ static irqreturn_t atlas_trigger_handler(int irq, void *private)
 			      &data->buffer, sizeof(__be32) * channels);
 
 	if (!ret)
-		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-				iio_get_time_ns(indio_dev));
+		iio_push_to_buffers_with_ts(indio_dev, data->buffer,
+					    sizeof(data->buffer),
+					    iio_get_time_ns(indio_dev));
 
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 9d73fd2cf52c..3e850562ab00 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -1120,8 +1120,8 @@ static irqreturn_t bme680_trigger_handler(int irq, void *p)
 	gas_range = FIELD_GET(BME680_GAS_RANGE_MASK, gas_regs_val);
 	data->scan.chan[3] = bme680_compensate_gas(data, adc_gas_res, gas_range);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 1eab256a1e00..998c9239c4c7 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -343,8 +343,8 @@ static irqreturn_t ccs811_trigger_handler(int irq, void *p)
 		goto err;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    iio_get_time_ns(indio_dev));
 
 err:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index 152f81ff57e3..6cec60074827 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -267,8 +267,8 @@ static irqreturn_t ens160_trigger_handler(int irq, void *p)
 	if (ret)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index d0bd94912e0a..d268d05cdec9 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -126,8 +126,9 @@ static irqreturn_t pms7003_trigger_handler(int irq, void *p)
 		pms7003_get_pm(frame->data + PMS7003_PM10_OFFSET);
 	mutex_unlock(&state->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &state->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &state->scan,
+				    sizeof(state->scan),
+				    iio_get_time_ns(indio_dev));
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 3fed6b63710f..8316720b1fa3 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -601,7 +601,8 @@ static irqreturn_t scd30_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 4877bd3e907b..2463149519b6 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -675,7 +675,8 @@ static irqreturn_t scd4x_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index 6f4f2ba2c09d..2554ef74e141 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -117,8 +117,8 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 	if (ret)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.49.0


