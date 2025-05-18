Return-Path: <linux-iio+bounces-19617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BECABAFBB
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 13:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809417A27C8
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 11:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB781219306;
	Sun, 18 May 2025 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL/YO7u1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A7217F54;
	Sun, 18 May 2025 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747566820; cv=none; b=ruRZ7RlMxk6QeM1ksHMBc3mM9DOK7SNDLNcKZUGx81btJc0nTX31FJPEjMtDjXvU1elIhvKgWKbjxY2+DVrJfQB9rxz9+BEFSr3SqU+EW6SfAsPxwboxUr8anyIzFkbLbMDTV2VjNb+15N5bqalM1VCwBjgK7lGChlA77otAxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747566820; c=relaxed/simple;
	bh=scWhXzW6XYq/l4wqrxqgJSnKTwwONvDLqVBlfzHMlX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZ0U+fTwN/3585GpwAXn8kB9SL5hn9tJROW/1oZj/f3rsmEOhH0YgNlh6KvhvoQAHF3fnibwWB1Qit9aE+hHNzDttxSu/cn3WW9BGwfyqQQ77+3UuDTq6gXlOpMq2NHyvEagF2R9b4JtrP1X2822sc8ABeqRWfTDu1oduP+u+pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL/YO7u1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a35c339e95so344820f8f.3;
        Sun, 18 May 2025 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747566817; x=1748171617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCY9+1WX1qMGi6W5sZlmi9awN4nnMi5MaeIyZ+3NCK8=;
        b=iL/YO7u1eb3IrInt04xfJqGCMfCYrpAHFb9Ur3OUeTkQWlHLIKBr4sEZJ4Z5T5G5w6
         hnvyQwpUFTCV9WTjCyJC1e+6pVqkhGnrogFwdY4YC5rQ7zZ7+1BniaHRNxlP7J/vDhlq
         Js7KRwjyXyyTbJyhHer3LsHROnEXwKchsAJLgyjGrOtxwXjIDF0tXnMBVPybSqN8GYhz
         /59NU01jrCGW0alHiGib83dRe7+Oh/rn8eM1b4ls4P226dUS7JE7N0ANPT5D5pMD6BGL
         vvsF9Ye9GlYL/lTNYecpKsX1NZroM0rZQhQktGD1HNccvnt70geYFIQk/kw03XU++TM+
         a6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747566817; x=1748171617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCY9+1WX1qMGi6W5sZlmi9awN4nnMi5MaeIyZ+3NCK8=;
        b=RhLdlV0v9mJNIxuUJZN1WVdH1x6ByR2mBRRaZ06EReBOoAcCDjz4zCU9+JfLhHME3j
         LP5HvQPL5rEG3usRppgwpj7hi1GArneYRAuIpeZ1i3905AJK0VyOzbxyW6VR1jaC598l
         o8NdOntp5qKisLLK9IpSDRK3NxiiupAqPYPJnhLAv+Wm3N5Jb+JxSsXWILhAIeLZYxw7
         kFV8MCbDvNCtPsq+3OYnE5u/56kPx5Gz0C9ZQ3R2HQHQwfKd0By9GqxpoX04YwHvHJei
         Z4PSseH5LbUEZvcTvQhtOrewk6S1nNUbBPhI68QJk2zE4/wUGTHjZnmCGjgKyZydnAHE
         bDUg==
X-Forwarded-Encrypted: i=1; AJvYcCU0skj8A5DMEgOtKJjAdiU8uklW+N65QfcJYE5IjmucskGgThYbWwrI2sJRRIEIl9J2PvC8f9ns10Y=@vger.kernel.org, AJvYcCWzJtSVhsUDUy7o0mIbCX/00XxYrMAF8BaatfiTzmCYeORVKSKOFsWnLkd5rcONznf/ZDgzJS3AoCqTneYN@vger.kernel.org
X-Gm-Message-State: AOJu0YxhBn4E5lbl905Q/c/7/K4mOdcna9ms5Vj2btNVFPEUsPVCWO4j
	l8xQdSpsndn8qkRRx+qh4JQjmeMNmpPZg/CAGEGY9zEgx6CgGqtRd5Wj
X-Gm-Gg: ASbGncvyrGL/4S9ZbbxiA4QlSDDhhbiJGJ1zlgM92jU9FKmsG+1Qp4a5iQa8MxHsats
	Yt0K02Fqc6LI6WbijyhFJzPCJFxv28GsQR9hN3gEXwllh4IzVJoZozX+wY8wCj6QIfVeS1zPqIe
	ZMMPw5yNMiuKNTOwE0zMH7wE+EmR4LjTA1g+DK35JakZ23C6zy3OPjNUFp1WSkwQoqa/MIed6vV
	zvSRP98fQ7Aw5xuJf/KpydETXlZZcRnqjj08QOZiY29M/aV+jLZf7k6heoWD3Pq0nPjnqIZO6OR
	8sUtAXLu5qAfgV9jXfqSnXfdhaAReE5QHYuhuIwnCsj2QHWj0Fp4O9n528q50+j7Os2XCswFnyy
	Z8KpVxLpr+XdjhoHduDeVag==
X-Google-Smtp-Source: AGHT+IGQoCXmoojOsMN17ZBB476hrBvPfhJkoVvNIe8AY4ac2APXeyaeKA+pyQhdpUThMSApzVYmoA==
X-Received: by 2002:a05:6000:2210:b0:39c:30d9:48 with SMTP id ffacd0b85a97d-3a35c83e858mr3467095f8f.6.1747566816898;
        Sun, 18 May 2025 04:13:36 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm9287446f8f.18.2025.05.18.04.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 04:13:36 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v1 02/12] iio: accel: adxl313: introduce channel scan_index
Date: Sun, 18 May 2025 11:13:11 +0000
Message-Id: <20250518111321.75226-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250518111321.75226-1-l.rubusch@gmail.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a scan_mask and scan_index to the iio channel. The scan_index
prepares the buffer usage.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 2f26da5857d4..000f59e2db87 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -171,9 +171,10 @@ static const int adxl313_odr_freqs[][2] = {
 	[9] = { 3200, 0 },
 };
 
-#define ADXL313_ACCEL_CHANNEL(index, axis) {				\
+#define ADXL313_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
-	.address = index,						\
+	.scan_index = (index),						\
+	.address = (reg),						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
@@ -187,10 +188,19 @@ static const int adxl313_odr_freqs[][2] = {
 	},								\
 }
 
+enum adxl313_chans {
+	chan_x, chan_y, chan_z
+};
+
 static const struct iio_chan_spec adxl313_channels[] = {
-	ADXL313_ACCEL_CHANNEL(0, X),
-	ADXL313_ACCEL_CHANNEL(1, Y),
-	ADXL313_ACCEL_CHANNEL(2, Z),
+	ADXL313_ACCEL_CHANNEL(0, chan_x, X),
+	ADXL313_ACCEL_CHANNEL(1, chan_y, Y),
+	ADXL313_ACCEL_CHANNEL(2, chan_z, Z),
+};
+
+static const unsigned long adxl313_scan_masks[] = {
+	BIT(chan_x) | BIT(chan_y) | BIT(chan_z),
+	0
 };
 
 static int adxl313_set_odr(struct adxl313_data *data,
@@ -419,6 +429,7 @@ int adxl313_core_probe(struct device *dev,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl313_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl313_channels);
+	indio_dev->available_scan_masks = adxl313_scan_masks;
 
 	ret = adxl313_setup(dev, data, setup);
 	if (ret) {
-- 
2.39.5


