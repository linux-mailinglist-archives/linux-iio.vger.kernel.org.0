Return-Path: <linux-iio+bounces-12272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0DB9C95D6
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DD52830EE
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7931B4F2F;
	Thu, 14 Nov 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4vFl3zo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F11B3930;
	Thu, 14 Nov 2024 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625822; cv=none; b=Rnb2Vj8wwlhAAdinzz7cHOUGKoGpeZJttNh6VDx2U4BNY1Qm9Efub5MEQjGfsUom/6RpRqMImKU9lFsaF6KG6J+ACYJIP7ou1Cp+eXBFveJ1bxCjJMAVBtxN7RSiHjumDQ3mX+NWLeVi/QvAB9VoLUQxsECCej2Nhy0iG3yJqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625822; c=relaxed/simple;
	bh=+PHQLrTNWeQsXdijBQ7PsCkFbdsNKrzTG1/AdiqprSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c/ZUyZwpReZIQ3P7i7RgMqavVhw7jH2O3K0WM2qnlEVzWmpgOjRNAuYu9NJzXtumvuCqheQrSbyF0rCrCqCXBxW30i7ZJ8L6tF1Fd9Ujk+5nKrWIzq5kH9H5VDkwLofBTQJ4TQbI2gK24d7TckJKTzyYunTMQV9jjvHydmjIzK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4vFl3zo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43158124a54so1398085e9.3;
        Thu, 14 Nov 2024 15:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625818; x=1732230618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqLCx7ko/pTUy6BjX7kjCxNomdFNpbjuzoAFnkseXBA=;
        b=X4vFl3zosW5E1gtNfuOtAnzS+bDXVRQvuGc+dBNuI29mZYRcAnV+eaaAu4IX2+GNmr
         qNUKr+u16PjwIMRUOZ216JCxdmYMCj/kqL0QrBBoihF5H5QQxO4C0+nxAANy+OL93CM+
         MMEfWKCoO+O0j5iufkoJCn6RRxUThadFUx61No9yyaOgm/I0ZckPRxjjC69G2xCESSax
         HBC5ss53xFpoWyTF2TTazImbpcAfErktHZHQrEFeBCYm5vkrtlEWMhceDqgE4ajivRZe
         MXhpqBskmp6tIek3T2Lh4p0PpfQXG0KTNIbqEmjoP4ziIpefjbRlWHC2qYR83RQg2llt
         hEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625818; x=1732230618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqLCx7ko/pTUy6BjX7kjCxNomdFNpbjuzoAFnkseXBA=;
        b=n70C11PuAyExE23sjpiyx9b32adtOwN7dGiMplwi2V8bYwhlmLhIY9SuJNUiMZTKBd
         WxKF6pEJltePKay57NMmTkyrnXibwbLEHHipLZvzjiY+iGC6jEagEkNTbzy9GLSoJlnU
         fGWtQkTmuWH+zs3j4IMY2uq8tU1xKgB4W6hYCQ0WaV/PoVeK5mTiazHDt+Gtnrar1QIe
         juJJk0Cd//W4pe/630o4kh5Agx6A9Yj24F/TuWL54fef/0Umn7CoPhf2pHV+nCsSw7/+
         CC9sitSzRzAsFWwnf0IV6SeSSSCFK67EeAnFKVsYapR1Kv9qMguvOAqAUWZBhFAiB05a
         8OuA==
X-Forwarded-Encrypted: i=1; AJvYcCU7E8wmIBe9eNgU8aKczEuBEwH70O2dqcjiGK4FgXLdyZPkYoeHuBlr9J+kqKEF8eQbVt0jqrLNvPVWOQHX@vger.kernel.org, AJvYcCWbwdvYpwOHFK9N9H2XVW9YONVn6ANq/2o9fp+WMU+qSZI1sVOlpEn6snfUJNmlnZLXg+5rSmOrjAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdB1Re8oPqnq0IhtXF0PdMBY9h5O35avWekbEp0MjwoHdZkjgq
	kmlYn2YcISfZvs6Zyad+dyZU3Zq3JoFBBH3GL+JiyBacwczatAt6
X-Google-Smtp-Source: AGHT+IHb+tBVY+6h0mvrGFljj2gzLndNaKfnXnQk9XMn0RgE/qcWzg1m+TsyPeMhNSplGRMWrjxD7Q==
X-Received: by 2002:a05:600c:3ca8:b0:431:5316:6752 with SMTP id 5b1f17b1804b1-432df71e06fmr1709965e9.2.1731625817658;
        Thu, 14 Nov 2024 15:10:17 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:17 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 03/22] iio: accel: adxl345: rename struct adxl34x_state
Date: Thu, 14 Nov 2024 23:09:43 +0000
Message-Id: <20241114231002.98595-4-l.rubusch@gmail.com>
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

Rename the struct "adxl345_data" to "adxl34x_state". First, the
data structure is supposed to be extended to represent state rather than
only hold sensor data. The data will be a separate member pointer.
Second, the driver not only covers the adxl345 accelerometer, it also
supports the adxl345, adxl346 and adxl375. Thus "adxl34x_" is a choice
for a common prefix.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 3fb7a7b1b7..30896555a4 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -17,7 +17,7 @@
 
 #include "adxl345.h"
 
-struct adxl345_data {
+struct adxl34x_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
 };
@@ -43,7 +43,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
-	struct adxl345_data *st = iio_priv(indio_dev);
+	struct adxl34x_state *st = iio_priv(indio_dev);
 	__le16 accel;
 	long long samp_freq_nhz;
 	unsigned int regval;
@@ -99,7 +99,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
-	struct adxl345_data *st = iio_priv(indio_dev);
+	struct adxl34x_state *st = iio_priv(indio_dev);
 	s64 n;
 
 	switch (mask) {
@@ -181,7 +181,7 @@ static void adxl345_powerdown(void *regmap)
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		       int (*setup)(struct device*, struct regmap*))
 {
-	struct adxl345_data *st;
+	struct adxl34x_state *st;
 	struct iio_dev *indio_dev;
 	u32 regval;
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
-- 
2.39.2


