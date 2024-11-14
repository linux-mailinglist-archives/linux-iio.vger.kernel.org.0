Return-Path: <linux-iio+bounces-12285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FE49C95F1
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CCC2825B8
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546711C243A;
	Thu, 14 Nov 2024 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTCHNLJl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0511C2323;
	Thu, 14 Nov 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625839; cv=none; b=gQo7UkeCkimNjI05VUnikrugZoytHfmj5ENtZmsirq1BzFG2qVcogLiKdebNOmzf1ff8dmmJ7ii78N6xEKYrVlKqilOhd4Tv7q09km62Eny+eET+UAqA6dCxB6D3V+HL2u8Nvaq0BzTFQjwfZySkkSwWc54zoyvlmuPXYmGODQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625839; c=relaxed/simple;
	bh=qR/sCQci0olPDHNGyPvQt4E28w+O0k5TA3wmzOJrj0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XRixYMxmmZegQ2u++gsHrpaVm2Wra/C206zTOh91DWBpeQtcaXgL1/8bijA7HaXHJ1ARwnepbRoGNqkp/8iDNgPxDcUGkitxJ8iiL8LJ/uJF5fKmHsTcdhXyZdhEc7shjwXPiFizjPKHYlpm7IKFWaTWcGp3FP4f/4qWtFq7Ujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTCHNLJl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315dfa3e0bso1419205e9.0;
        Thu, 14 Nov 2024 15:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625836; x=1732230636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1YfXIBJlmygh5jtMiNQIlnvrPVWfGPBojvJxihEMvs=;
        b=ZTCHNLJlvFHqqghHnCXhuAqGXDStLQvUd0Q6oOvxDj4wKi5JIg3iYZ4zQjhv4gK73V
         wskTE3SOlTJOfcj5u+HLwcD9WVQbbnDtGufxtD8DvbftU9J/ChDeE2CLmwcThXuL/iVx
         /kyk7HhJhV8LLEn2ijb2mzimhjlvHjTvqBTnCMaQY10Oj//XUal03mWxNeAq8KraynET
         cz/BpIljIMgYST8vpSOa40jVghW/qpcfG/82Hj3RiG+8Di9bucIQh/99dPq7+rmTKW/3
         i+B+AfZAQNgbtV/ynhUpyLOx+A0+3XiIe2hGTgv1vB+h6tStZAg7sTG3vcLILCTmW0hP
         MW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625836; x=1732230636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1YfXIBJlmygh5jtMiNQIlnvrPVWfGPBojvJxihEMvs=;
        b=NHcp3Ho7hGjBTc2Zycvatb/7KzXkIZszTQ2ZOSxUADw+MDlkCMkMEbxUPQbVi06V+I
         wQnsG3MC0IGGNka7SlbrRPMk12KDApwq3QdB8SxcHvZozVZoyLn5tCv3GEFSIhSejtnJ
         2zDyKQU0Dr7bkTV8kHlCf5ITj2w4qV7ieBWgVVzJridcw2emYn9IMkRphbGDUVY3uSzf
         Mu9MH92RF9pmAvUFzwdyFVmzZ421ukS9T7wcyCd6TeNy7lQVBNrZqCKuhTVmmzYpkrMF
         jQyDoro9EtExXY7vFSLYAfuk/jvOj2vDIxHDfEXWe51Q785+8TJFqZ3VC7dMI3XZi4+W
         xXZg==
X-Forwarded-Encrypted: i=1; AJvYcCXDGDVM2t7kBP0bVuh/CGk+9M2TtunI9JtlJ1DVMhxY10+srKPKCoqKHzu6pCJjv0zndDN8349+elE1vK1y@vger.kernel.org, AJvYcCXNOa3uXCY4fyamBwFdUeHcf+3iy9IwiFnbbLq+8+k4bbFNCz0yGo/6gclySAxaBiiECk0fn4iqj/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze7c720rtXyzJvRy86dbopApBT+2GQOTlD4ANPPkvPigwcHo+Q
	D0SGKTDm1AADswROesoSsVmrbzfl2RrUMFnvHThHjmsH44H57asz
X-Google-Smtp-Source: AGHT+IHelWCwPBw7LJw1a+gm+mce0LetN3EoVahQMD1vsZynmcWULUKrOhwig+e5HzuxGMqijhSOKA==
X-Received: by 2002:a05:600c:3ca8:b0:431:5316:6752 with SMTP id 5b1f17b1804b1-432df71e06fmr1712075e9.2.1731625835730;
        Thu, 14 Nov 2024 15:10:35 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:34 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 17/22] iio: accel: adxl345: push FIFO data to iio
Date: Thu, 14 Nov 2024 23:09:57 +0000
Message-Id: <20241114231002.98595-18-l.rubusch@gmail.com>
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

Add FIFO and hwfifo handling. Add some functions to deal with FIFO
entries and configuration. This feature will be needed for e.g.
watermark setting.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index b917b02245..f686037df3 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -420,6 +420,41 @@ static int adxl345_get_status(struct adxl34x_state *st, u8 *int_stat)
 	return 0;
 }
 
+static int adxl345_push_fifo_data(struct iio_dev *indio_dev,
+				  u8 status,
+				  int fifo_entries)
+{
+	struct adxl34x_state *st = iio_priv(indio_dev);
+	int ndirs = 3; /* 3 directions */
+	int i, ret;
+
+	if (fifo_entries <= 0)
+		return true;
+
+	ret = adxl345_read_fifo_elements(st, fifo_entries);
+	if (ret)
+		return false;
+
+	for (i = 0; i < ndirs * fifo_entries; i += ndirs) {
+		/* To ensure that the FIFO has completely popped, there must be at least 5
+		 * us between the end of reading the data registers, signified by the
+		 * transition to register 0x38 from 0x37 or the CS pin going high, and the
+		 * start of new reads of the FIFO or reading the FIFO_STATUS register. For
+		 * SPI operation at 1.5 MHz or lower, the register addressing portion of the
+		 * transmission is sufficient delay to ensure the FIFO has completely
+		 * popped. It is necessary for SPI operation greater than 1.5 MHz to
+		 * de-assert the CS pin to ensure a total of 5 us, which is at most 3.4 us
+		 * at 5 MHz operation.
+		 */
+		if (st->fifo_delay && (fifo_entries > 1))
+			udelay(3);
+
+		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+	}
+
+	return true;
+}
+
 /* data ready trigger */
 
 static int adxl345_trig_dready(struct iio_trigger *trig, bool state)
@@ -492,6 +527,9 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 		if (adxl345_get_fifo_entries(st, &fifo_entries) < 0)
 			goto err;
 
+		if (adxl345_push_fifo_data(indio_dev, int_stat, fifo_entries) < 0)
+			goto err;
+
 		iio_trigger_notify_done(indio_dev->trig);
 	}
 
-- 
2.39.2


