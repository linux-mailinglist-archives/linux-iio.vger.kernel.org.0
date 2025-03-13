Return-Path: <linux-iio+bounces-16790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51620A5FC97
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29E4E7A9A79
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF84726A1A1;
	Thu, 13 Mar 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENkyIL0B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0426A091;
	Thu, 13 Mar 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884673; cv=none; b=dG7NBp0oCGwCV6/Yg0fv1KSebwUsF9w02ApsF8icLBgXXRiwyGibZD9vP2Z3xbG9Qt0qxte+VJzGvKlWNpxyDBW84JUlpyrF0T1WkDiVWFMKwUYQADxdxmdhBjEtGB66QxegfmWbz1eSPT/F2nEGmwowZeTSzHjrXbLp2nB/txk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884673; c=relaxed/simple;
	bh=7Qu6SZ6XREm+6RZDbRGSt55eora3SguJtLGZwWkGwSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ops8nuuK361y2PMDpJBI+nSc1BMizeqKYI53NoYReDt8QPPdV3s+AfGB9bgT6MNRPrSIMbdghf07+5nSbAlut48Ryf4WUuPuhAgAulcG62bveevCAZ9QCU97zfvktNjnJRLT4+qQUZMFA03DybfkdlTSZH261bNEWche9GzVX5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENkyIL0B; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac250d158a8so17038466b.2;
        Thu, 13 Mar 2025 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884670; x=1742489470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kObAZCecIufgb8lKjH8UqZ2pqy/jGsTdnhjnK9Ujr8I=;
        b=ENkyIL0B94k4YWE/RiCVJSPY2+9374zVghUHqdhKqruvp/t4B3FdhQuPHDH+rt6lil
         3hpCQhSNZeqDVwkOKTDIUmSVbFQB4O0wWMYmC0p3yVZPEcuPtX/16Y2u9pzMBqQp2tkz
         3yYKyxFD8kGG89WACsE8bheEZVbUnSjfkmQn8oplO5OtvmLM5RnrVTWu6P5MRSysewoM
         bLOiPLoHzsBk3ICog+B5YGcH+R8R3u1q+blziH+VTr7lQ9tmAI7ySTm7KeHZcSepClaP
         x6So1rbvY4ph6rEHQWa451Twep+OD8gjeCqycTxwpM3PIywd8mmTYmpAmV7fsdIosXWB
         J+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884670; x=1742489470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kObAZCecIufgb8lKjH8UqZ2pqy/jGsTdnhjnK9Ujr8I=;
        b=Mjlxgolhoch7p7zryNObMPbaCOMHJ1nT6/NC9Rx3zdaDAPuZdaD5BqOEaNUsRG8iHn
         tRLX8KsqpkeyQY2v0Z4ZyIGGakCcFBht9XmGTxoyai0/ycjGDoXrybkcYhPVwtlKMwsU
         YptfievwfxfLor48PntDuX5LxjwQu8HgBHjrnmM8BLnrkGPBsdHu3eOwQK5LM+OPtZyX
         wLLhFKo4kqO+Zm7wev+4OWon68earOGtTgFJWl3Eo9sFdmm6DwyxVE5IDF8moilgNuI4
         K3NYEAskxzwaCvisH6UZbIJD4ptpyftZOOKq52bPXo4f8bf+diPBg+VRDLP5QAeXZ7wc
         ivYA==
X-Forwarded-Encrypted: i=1; AJvYcCVAAbsLicIzHrYSgR5y/g3FGYLjzKS1egK7y7s3pOEhqbfVmWU9uDs60AOjTg4G/lN3+FuLpcA5FRVJCUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwazDXsVrE0tdLmvQzSdQ7dN6LrSfnuktj59lmxyohNpPT+Shdg
	Caxx3XPZHopifqOOvkcTmf4fX4wj/MgEF47ENgxQ2IoaQdl/m+aj
X-Gm-Gg: ASbGnct6q2wf2L/kq1GJ9pqFNv3I0wjCChv60IkZi120M9f2In9Hm9qBAom6lSEwogz
	2tz7FE3LlJaVPN/S8PrRx8Of5kUEEc3kIPkSURcCh909XE13oVjX+TKsUir5lfFx1jpdA6oXF09
	nU2kk6TglxCKXQuzaEMf9S1xSEtSeMdle8xxPO2XclYERDBmdKcdcLCHVkqmk0m6ba/cfUkP4KK
	WDhM6xUs01h7cExqf+b73Va2IEo8J6DpXstPXmaON/XVALPH2N86nw7GL8WbLfUriGQnC5aSCiN
	osIP4ok7stNb9c/PrubF5Fnipx9QjkIZeT2Vm8E4+A+haLzLP1Q4YXfYZXEo4pMyaJp4+W+DM1Y
	n/E9F3F2olXo02jZeEhmBSgk=
X-Google-Smtp-Source: AGHT+IGMJe34PpQDvk/nscO0lijzrMROzv1dCtGiunTHz6QfD7rwjm1M6Fdf3soxh1I2CJlG2UT9Gw==
X-Received: by 2002:a17:907:7e88:b0:abb:eec3:3937 with SMTP id a640c23a62f3a-ac2b9ea1613mr604191766b.10.1741884669814;
        Thu, 13 Mar 2025 09:51:09 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efb0csm101370866b.65.2025.03.13.09.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:51:09 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 04/14] iio: accel: adxl345: introduce adxl345_push_event function
Date: Thu, 13 Mar 2025 16:50:39 +0000
Message-Id: <20250313165049.48305-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313165049.48305-1-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the fifo handling into a separate function. This is a preparation
for a generic handling of the interrupt status register results.

The interrupt status register is read into a variable int_stat. It carries
status for various sensor events, handling of which is added in follow up
patches. Evaluation of the int_stat variable is common for sensor events,
such as tap detection, freefall, activity,... and for fifo events, such as
data ready, overrun, watermark,... Also, dealing with in case error
returns shall be common to all events. Thus migrate fifo read-out and push
fifo content to iio channels into this function to be built up with
additional event handling.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index eec3f0e17e1e..d4c1a6f1559f 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -420,6 +420,24 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int samples;
+	int ret = -ENOENT;
+
+	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
+		samples = adxl345_get_samples(st);
+		if (samples < 0)
+			return -EINVAL;
+
+		if (adxl345_fifo_push(indio_dev, samples) < 0)
+			return -EINVAL;
+	}
+
+	return ret;
+}
+
 /**
  * adxl345_irq_handler() - Handle irqs of the ADXL345.
  * @irq: The irq being handled.
@@ -432,19 +450,12 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct iio_dev *indio_dev = p;
 	struct adxl345_state *st = iio_priv(indio_dev);
 	int int_stat;
-	int samples;
 
 	if (regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
-	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
-		samples = adxl345_get_samples(st);
-		if (samples < 0)
-			goto err;
-
-		if (adxl345_fifo_push(indio_dev, samples) < 0)
-			goto err;
-	}
+	if (adxl345_push_event(indio_dev, int_stat))
+		goto err;
 
 	if (FIELD_GET(ADXL345_INT_OVERRUN, int_stat))
 		goto err;
-- 
2.39.5


