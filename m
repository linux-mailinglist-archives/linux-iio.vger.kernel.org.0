Return-Path: <linux-iio+bounces-13053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FD09E2DA9
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 21:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBA6282BA1
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BFC20C029;
	Tue,  3 Dec 2024 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPoeXa8n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B120B81F;
	Tue,  3 Dec 2024 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259201; cv=none; b=BJibDEG2D3R1x8Whm4+2jgy4Kim7dEpSFe2zLaCiX/acgoKyuEIDY8G8yp6vEnTO3vvZ+yxOjY9m803UOP4Vj0w2mhkW5/uNTZ9fSOZbaWe2toV+Q806N1yVcvcGCsezjuRgjNmGo81vKd75mMUQodMrgxN7cw3lSXziRuZbpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259201; c=relaxed/simple;
	bh=9Bss6I5KJEiYKsBm3/rj1oLUsL1KavlBK7tLyDrLMkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BePhBCX/3Pa29QsrbcquNUz6UudwkLOLT09ILweR0tjHLg0odXbr9nkTrTSvlpii53PyONZMWzxq2+I/SR9o3kAPqOMc58MTYnd4y/BcYmtbTM0Hl5Tus6Do09SXj9t6JOgmua31GHHo2rTDq2QS3zRHYqcJ3E0NJkF23JtezxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPoeXa8n; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e971a2a0so195403f8f.1;
        Tue, 03 Dec 2024 12:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733259198; x=1733863998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TsozYlA/4LNEKtOtGZNm63GhiDqkuqNaZFE9mL8HFE=;
        b=OPoeXa8nCD7+WhgWJ96XptlXv6gWm/eFBhgMoxIgxbpOe6QkhTpX3Qzp+C/hFvQQPs
         bSkK00Ont0DY6+DGdtFlc7rIIMNI+FJ6RrXzVzg4tbttpkeFbl642sYAdb9hexBdWeGU
         iTIscQNpNaqkM2Su3VkkuGrEBj2wI9wCyRFK9DiEhekAHG0JSeU+l4yqEGitEJNNggvY
         H8kxgCOZ5rkp54vYLxAAqaufx3Ao+tDPVk13UC4jRlfPjdq2vGKPNd5xHqquG0wSzxmE
         azTJKOsKcFhoGZkqpsb50aaWfC++kheua7jXHYNn3JITeHgEv3q/lIMNt2VEkI7g/qaO
         aV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259198; x=1733863998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TsozYlA/4LNEKtOtGZNm63GhiDqkuqNaZFE9mL8HFE=;
        b=usI3bj7JW0hTFgdyURWLJP3YW8khqar1YUhc7lxp+onLiFFZthx2987PpO4plEp+1X
         irqrZZjyaTKhlzqzHoZajO3FqJ91md2F7HSDy0W8iz27F+vbyzlgZPmi+Bql9S4MqCC8
         8cW1m8+S0zzKp0p/ZGVoxkfm0LeB1BHPmcTimoA/OEYYXZYLqgq2jte3uu2zucZLfQlN
         S27U4fMw24Y1zIdwnbSb8QrIG//SYP8+whHc0rRE6U7jga+jmAAZGbdDMkrPX1kWMqT2
         6lLqAPkfRYAzdz4VG2B9dX1IlRdm/0ZaB1LyNwqW1cei3qdlQn/3xvbXwuVYR08Slsft
         1n2A==
X-Forwarded-Encrypted: i=1; AJvYcCURsSfXuoHKFbq+RBbmNFuDcA4ODIFIv0ONDQ0jQGc2ksrmGYobAznt2qDU1NAiIFHvhwW6x3qcMbtfUC0Y@vger.kernel.org, AJvYcCWv2yh4niykuG/GH3d8iA18dbv36h5m5vlZqz1ayK4ExpyHN/hCOoMr4E3OpP6AYZuKCZTXRsSEq/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3uOAs88SwR8bPWL/UmjMqqze+C2Lk+eCx4e6QDMJZvQiYIroc
	3WQHROQOXw0HER0yGu0JNxdJFct+iZpKL3a7IaowzKMOC2/pW0N/
X-Gm-Gg: ASbGnctXwNRgR57o65N8QOWYXqO3jcOB9++5mkhxsgdMMcn7/5o0ZgBfH96gfIxiRCB
	1/EdQ+wcF1qWH8mzKGT5zIteJ8UF1PgHi0sbzYxuEy2YHpf3Igo5nNFBW1/35qfcsF8Dt9V8JxX
	wU6MCDxsv6D6Wkpfbfd/KPbHr+vheWm77cdeX3Kog/jbUABj0BBYY1iXYZOJzLsSWAkvBwwocw3
	d97UG8ildj+ewjMGXcMCnSu6BMYX55A1m8comjW8Zd4jZhreiabh7FbnpoLzEV9WvKZGm5CV7Dq
	ERxl56wIhQtzFcU/6DI9byVmRSPt
X-Google-Smtp-Source: AGHT+IGxPsQa8ldQ+XfDQ/gSCNiezoyJsldfzfMlqnfmgxj8yLhBYvITVrOLYDMx+LON5+irHXo7TA==
X-Received: by 2002:a05:6000:4011:b0:385:df17:214f with SMTP id ffacd0b85a97d-385fd432843mr1370336f8f.9.1733259198225;
        Tue, 03 Dec 2024 12:53:18 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ebaf3bccsm9042750f8f.68.2024.12.03.12.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:53:17 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 09/10] iio: accel: adxl345: prepare channel for scan_index
Date: Tue,  3 Dec 2024 20:52:40 +0000
Message-Id: <20241203205241.48077-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203205241.48077-1-l.rubusch@gmail.com>
References: <20241203205241.48077-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add separate fields for register and index to the channel definition.
The scan_index is set up with the kfifo in the follow up patches.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 636b8ec48db..0a3acce2198 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -26,21 +26,26 @@ struct adxl345_state {
 	u8 intio;
 };
 
-#define ADXL345_CHANNEL(index, axis) {					\
+#define ADXL345_CHANNEL(index, reg, axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
-	.address = index,						\
+	.address = (reg),						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = (index),				\
 }
 
+enum adxl345_chans {
+	chan_x, chan_y, chan_z,
+};
+
 static const struct iio_chan_spec adxl345_channels[] = {
-	ADXL345_CHANNEL(0, X),
-	ADXL345_CHANNEL(1, Y),
-	ADXL345_CHANNEL(2, Z),
+	ADXL345_CHANNEL(0, chan_x, X),
+	ADXL345_CHANNEL(1, chan_y, Y),
+	ADXL345_CHANNEL(2, chan_z, Z),
 };
 
 static int adxl345_read_raw(struct iio_dev *indio_dev,
-- 
2.39.5


