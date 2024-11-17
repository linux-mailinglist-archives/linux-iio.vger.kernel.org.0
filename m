Return-Path: <linux-iio+bounces-12364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD6C9D052B
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769BC1F21C48
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB061DE8B3;
	Sun, 17 Nov 2024 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNGuLPMm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450411DDC3B;
	Sun, 17 Nov 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868120; cv=none; b=dhgk9icyYV/uBWmYXMNNSsWjI1aTGm0HQDw2Q+CL8IYZBbVLddgCp7EUd1t5O5hfnzmxuQcm7BmqfFtM1OdLJfdaTpPrMKefde2N1G7X7aym4hA2lT0qU/H4aYSMXtjY/ZCBHR404UorX6eOTbEi8t961/EbB+3tRMBVe90RSKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868120; c=relaxed/simple;
	bh=YLkm6mn91SUYqJEfuee5sOiFr8W1kHKnBkYkooecUUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C3AQI681ZLlDSZWq/eswXsf3PImbnza/PhU7otyWUeS26Bo6advaaq4VFscb2oMDWCI4mAXvUrwERWPVsgGJJzIhoeum3tqiMTDykK2LpTgsVORsj6ksrrGqKtp8wCeVvvEoA33kMr3cp9i/sWO8W/GWLHki/yHBD1lGiX4RfdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNGuLPMm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3822e64b2d8so110363f8f.2;
        Sun, 17 Nov 2024 10:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868118; x=1732472918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI7RJ0jF3aLy07BJRiIYtdRjEbCy8KHwX14SXuqyAVQ=;
        b=WNGuLPMmuEO8Unx9slLX6CG/XfHHbXyO1SgKdpJbts8yn6DdSDcsJ1g6DWMzyKc0hu
         J98hNKnbC51x1Bc6niCcIxAaXW3x6MOvr3iuatbxl7pJHBpmPUeBO0W0w7cuqwr/0Cn2
         V00j/CJXpwTqt7cg2D6YuQqQtkMlLFRoU4ntDbSZitekR95quNgVUqmqTA46c6jzZb1X
         LLt6WUPuvWp4Cp973O4DBVGjbZ1eTmlFzhjAZdG3GUSqXfdH1X4kcXF4qCr1LXkYAdFh
         ItyjZR3tTKQAGrgJRWH6fbIciA6XF3XKY5tDof+v9BluzPfMNsojyB1bz0Y4Y+mXRHVp
         pnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868118; x=1732472918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI7RJ0jF3aLy07BJRiIYtdRjEbCy8KHwX14SXuqyAVQ=;
        b=RAmV1jGZLcxZXdpJ4jpFZCxo61BgIeR3vDub3P+HvYbwS/W+Q9Sq6YLYaAAbFkhTw2
         3WsZJkjxBu5Lnvm2AZtBUQ9MINcmDB0pDn7W/n3NatDCXCDUyvYlWtRqIHSYI2+0ipd7
         EqiVse2kHvCjaMnDJgrxjd17nJNL8hIFMd6ptUQjYZPdisqL6XCxD/2BcL9LJ0EvBi3F
         PmgpMDWBmnC9dmRuPRROubutVa6vS/HaG7zHFZsACA2TD02ilYr4/dwINYM19Hkt/Pwe
         8zPzFJqYHraZ3u3T0By9STmWBXcj2Y69Fu4WM3vck0YPA85EwgkHppN/YIUV6uvTm5ZV
         ddhA==
X-Forwarded-Encrypted: i=1; AJvYcCWfIxjN6kVpV/KREHCOpSdO3VJxnpWBIOSWLoLdcHA/4otwAKJeERpY2gyN//1B1FICRYY1tmNxd0mMYS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAVb5saxoQtm+RB2IyLnzEh5vMVEbgMQ0zDE4zX9mgFpmkhCWO
	fWdxbqoHayu3SE6Ffxr9JzrSer6s3kxIdCXjjHXlgn+TvrMAyBvD
X-Google-Smtp-Source: AGHT+IHWoki2ndPtcJuR0/9t1Um4iS6pYJkodJ0sK7bAHT5HE9xEPNGHDiab/51eSX3up4nn/7r76Q==
X-Received: by 2002:a5d:584b:0:b0:382:1c58:579d with SMTP id ffacd0b85a97d-38225a04ac3mr3554543f8f.8.1731868117566;
        Sun, 17 Nov 2024 10:28:37 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:37 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 21/22] iio: accel: adxl345: sync FIFO reading with sensor
Date: Sun, 17 Nov 2024 18:26:50 +0000
Message-Id: <20241117182651.115056-22-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241117182651.115056-1-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
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
index 07c336211f..c79f0f5e3b 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -730,6 +730,11 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 
 	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
 		pr_debug("%s(): WATERMARK or DATA_READY event detected\n", __func__);
+
+		/* Pause measuring, at low watermarks this would easily brick the
+		 * sensor in permanent OVERRUN state
+		 */
+		adxl345_set_measure_en(st, false);
 		if (adxl345_get_fifo_entries(st, &fifo_entries) < 0)
 			goto err;
 
@@ -737,12 +742,15 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
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
2.39.5


