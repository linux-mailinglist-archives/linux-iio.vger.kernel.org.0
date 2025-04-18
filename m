Return-Path: <linux-iio+bounces-18274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6790EA93AB1
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AE4920119
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D979228CA5;
	Fri, 18 Apr 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cL8AEPef"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4018C224B0E
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993068; cv=none; b=QGcHRUZEqB8Q2asFfxHOujcb5AXlaI7o3V/NyrJQAzhY61qhIE+xLNsIgw1xoUYZ+kIqaQ4z7wioUGjCmPO21lWGdjv/zcmxbbRw2BsMHy+v5OIClXcX4dqmJl9utCZy1G3E7iRWDr92R/pv6OHvwuKpAGy2OEfkvFPUp9COAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993068; c=relaxed/simple;
	bh=1wtIn7CJXtk3g4VLCatc9DgGvfufdZmAjyuID1TVKOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a3p5rrtJlgnCa9IXg14SppKF0sMrVM59mKazCGnguvPH2SU8yCJExy8+fPD0za673h8+Y5F4lzGOl10tdPAhjhzyz01kgnoEdFzerLwePmUzDQ85jygIqBw28+Hj+b/Fj9XmX5R2uUnU/eNUT4RD+t6BYUSoA94OiOJor/BPYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cL8AEPef; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f9832f798aso1268996b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744993064; x=1745597864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TynQ13j4hhf8OB6oVT9I4vSBya6cspCoy3kqZvDiT9s=;
        b=cL8AEPefoFA0ighUPqstzk40z1+htIjDtobjFrzofj/yjccYMoDeiGmqLKJCemoz20
         ODeVq0NZKpQLRuXnANTN8IlDOWc/+ciFYFdbHZew//8a+xrQZGd9NaQj80pHCXNODClv
         m9iQJyc19OdVoRSPYn19MK+AS/H/ut//FsX2uWox5hoAwYUCsTsvyw4caQtYX64TLMP1
         mAKQvjiO/5+ejrshccv+8w4aqcOGOMTb6LyGwHwSEmc+aVjUoq2OfIe6afiFzFFEmlHe
         43SyYUcwcsj/xHlZp4QbEcDcuIdpV6Z4TKbJS+O1DelSe7QoVfzGM6qRB9lvD9vqkqF5
         lgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744993064; x=1745597864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TynQ13j4hhf8OB6oVT9I4vSBya6cspCoy3kqZvDiT9s=;
        b=c+CNvWc+Fd3s8beIh9QyGYx5Z2PnrzTAUcUU5HbUVwgfeAkT7aJdBPVeRQ3J0r/0ga
         Jit8N/ZblKotyXY4joW64Jnp+cY3nra/A56LxO+DtpQczt3TlkcnjG1EcuxRBIWncDc5
         Zdf73dW/Xl5Oa1MsOvTniAcSCAqAS12W4i3vNeTqNKuzCTLi1wdZ07sf9vFbH9iRv4Em
         uWH99TKJAalagvZ8dWKctMvclNjaQFqlol/m0FfNN9E7EMCwB1WQyE3xwX+8N14+Bg/X
         xzyo4TJ7fl1E/VO9xCpt8V95w80ieInN39AfBaWWW+y9KfXK/zhEc3Gp1G3op4IU6mgO
         ctlg==
X-Forwarded-Encrypted: i=1; AJvYcCW2/5o2lF0vg9D8EnguX80vBkkha1hVyL0pMLeWULT91qZpyPLzUqYmCMlnZaPYSvsrbjrBsyf+AOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy72o68OqIzNhjrSvQGRzvAWrbzwbkzY5HR0z3cZTaQLAeB/PU
	Y/P0Z+nMz4aSpRFzUcxekiLaz7e9rxdOCpWvyCCYB/9qcPJcb2rsdiFrSISSbac=
X-Gm-Gg: ASbGncuMGDVZsIdUOEG1Zm6+vh9WYtiLmGQphP9DgMOyitt3CJQppqKaRuYJc/Ip3Jd
	TTyBLV/4jspiYBz6Nx+geRgYVtX+EpTVPMzOSt245jJ9u9GJmye0NksUNtaIGj4CTNRn3Cev/5p
	5UcxEJMH6egmgX6htAbWTM7Tmh52W+ZELKY/Au0Ky2aGwUTYluWlFvH+hKSm8Chxc/G6grJIbp3
	zlQILHTRo4d4BNWm7t4D/VxeUG4VWygPWEJTy2JRJEjvNyTHikzE7aH8pQk+72cuxE929OQtHbJ
	I1xSmX3a6U7hpC7MUMer/ltk0HYvDVQ293mkM4S4Eo+mE/eDAP66/GhDog==
X-Google-Smtp-Source: AGHT+IEGuX3l8cvXre3lim0vyaT+xu+naSJFYSt1e3WO9Ohfoeea27ewXa3xKRNK7Kd2y0l0LoD3ow==
X-Received: by 2002:a05:6808:4e01:b0:400:fa6a:6726 with SMTP id 5614622812f47-401c0605f81mr1435230b6e.0.1744993064239;
        Fri, 18 Apr 2025 09:17:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeffe05sm384929b6e.30.2025.04.18.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 09:17:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 11:17:14 -0500
Subject: [PATCH v2 2/2] iio: pressure: mprls0025pa: use aligned_s64 for
 timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-iio-more-timestamp-alignment-v2-2-d6a5d2b1c9fe@baylibre.com>
References: <20250418-iio-more-timestamp-alignment-v2-0-d6a5d2b1c9fe@baylibre.com>
In-Reply-To: <20250418-iio-more-timestamp-alignment-v2-0-d6a5d2b1c9fe@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Robert Budai <robert.budai@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=1wtIn7CJXtk3g4VLCatc9DgGvfufdZmAjyuID1TVKOc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoAnsbarEGwdUVezFqkiss0DxyU3hndy/FbAKz+
 ZmqOnGR4/aJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAJ7GwAKCRDCzCAB/wGP
 wOuxB/9gebCEcJXGXYWnk4SIwC66JDYX9m7hX0urZpIY7OzDRmxCKGtQLlqAuwouHvQjRmeDOvv
 ssaw1fGCg8aK7mJkxzY5x1Si1J5eGTLSFjt074psBz+QGHm8iTItK2HxpJmVjTOOJQ3MkZVqZ4V
 h1KM3QyncIBaVxKKFpFGhgZsO95/HL1RUdp5IwurxwwkOVMqj90R7V0SzY6fGnENondt5yx2gvn
 x9BB1uFAinIRmi5rD6TGOnvvvTVLU4TuxtCcMJKRN8bXu1bXcLUda8pJWIO1yLcG0R4WWTGOZWN
 t294TXLkPxrJBkUh6/YI90LVvkOYCHh5ymRofKZcLM34mPF0
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Follow the pattern of other drivers and use aligned_s64 for the
timestamp. This will ensure the struct itself it also 8-byte aligned.

While touching this, convert struct mpr_chan to an anonymous struct
to consolidate the code a bit to make it easier for future readers.

Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

I didn't pick up review tags on this one since removing the struct
definition is a biggish change compared to v1.
---
 drivers/iio/pressure/mprls0025pa.h | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index 9d5c30afa9d69a6a606662aa7906a76347329cef..d62a018eaff32bdd0dab046057fcd9d60befa3ac 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -34,16 +34,6 @@ struct iio_dev;
 struct mpr_data;
 struct mpr_ops;
 
-/**
- * struct mpr_chan
- * @pres: pressure value
- * @ts: timestamp
- */
-struct mpr_chan {
-	s32 pres;
-	s64 ts;
-};
-
 enum mpr_func_id {
 	MPR_FUNCTION_A,
 	MPR_FUNCTION_B,
@@ -69,6 +59,8 @@ enum mpr_func_id {
  *       reading in a loop until data is ready
  * @completion: handshake from irq to read
  * @chan: channel values for buffered mode
+ * @chan.pres: pressure value
+ * @chan.ts: timestamp
  * @buffer: raw conversion data
  */
 struct mpr_data {
@@ -87,7 +79,10 @@ struct mpr_data {
 	struct gpio_desc	*gpiod_reset;
 	int			irq;
 	struct completion	completion;
-	struct mpr_chan		chan;
+	struct {
+		s32 pres;
+		aligned_s64 ts;
+	} chan;
 	u8	    buffer[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
 };
 

-- 
2.43.0


