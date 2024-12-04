Return-Path: <linux-iio+bounces-13095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E609E4356
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 19:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08D028244D
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 18:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FC01F5413;
	Wed,  4 Dec 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqclULk5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1E1F03C5;
	Wed,  4 Dec 2024 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336713; cv=none; b=MmvvmAETJAGikrBQkVV22E9mXk6FnsDldtDrCYoT34rE2/ZV/FkTOQZwfoleiW1h3z0gMj0wjzC5hTfQ7HwkZLL20buoN7B2ZcKvQDOlKKBqCfdR8Y8qaHjiFaaiFgR9csPSGn6IG7pBk8CEbSFb/OqUfqHOs/QwRLKa8QnU8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336713; c=relaxed/simple;
	bh=ovRKtQYK618KQAT7xksv0b6oZxulWAFP/r65yBLnjJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kR5o0cjqKsSs4XshANTgP0hG57SLwOohCvG1D0iWrm//1E/6lDmAuha6eWg6nP3pf41AqeX9580E3HLJKoRxFtWRpNmP3qFfEdszPMOCnwhT3nHsBwwcc8ZTiiTlm1xpa7F11jIi8aPVx0S5ZnWbwVkqbE/lsvXqImtjr2J7ozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqclULk5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4349ec4708bso84065e9.2;
        Wed, 04 Dec 2024 10:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733336710; x=1733941510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7z7JJ9yAoVzYehdb1uFB7loYdyMG6J39Tna2NdUaaw=;
        b=EqclULk5jVMWt7vx8leooNUXzs5TxEDzHhVthYYY2Vahb5dVLritEhoJiGH1r9sGxI
         EblujPYnub3TE21cDeI3U6iL0toRUY3obFe+k2U48weNLFcXF10sB1abIBZRZ4wrHY1b
         fKNeIhuR3Nw7ooEKb1Z72ckxilcmF85l4/FVh2ZXNbb9ETnHbHcQ6vBNDBO1E94gtBSD
         TpDoMPZmNAyWQ+TTwj713JnoHqLWjTCAMpvFoCj6GgmzxSfWpxq1brAAOAVtBtDup80q
         KYcH7eevpK0Ytodw1dhIWa3uDhlsU8BHDMizhmIPCYft9hKEvqk7vyAHRrbjS19xZKbW
         LGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733336710; x=1733941510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7z7JJ9yAoVzYehdb1uFB7loYdyMG6J39Tna2NdUaaw=;
        b=d5k+Vw07dCCPn5W1N1K4wX85KkuNW/GGcElDjxGbzy3roPwflMZLHk2Msj/9F/mzzz
         Jc5sneGHp0mG4MfonGV5i5dzj7if7MmspLSvjHD09EYwH0mUqS1QycndmvJctBzc+EQ6
         6ytbQIEifDQS1CV00yQ6/3ltpwTonxRnNL7niJ5ocYiko9JsrIIOhSRLMXYqtwyMlzXH
         51A7Kxugd+FcTYUgD4MNPA6K2VETsbqhIT5eOmWqULhC49rpC3n7K9dwtgqbinVLe+CI
         j0NYJvT2llP0KPbnVfKSZjFVuXhqZ+xJH8A9HQj+S8nTzV5Uwze+OvETXWu58uAd+6z5
         g/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg8cI3DLbkosVqon88TZg3Stm87NAaSlnTZmmoFGkq2xItYEJXYqBldA3ihevRlfl4bLCvTGUr3cmcBRtS@vger.kernel.org, AJvYcCWif7jViRnbSuK4bfD/oVVyJBWvV44FdiEiaQdBV1ahvSJLQ1MLHivAmYhIsi53spc6VV5WMwieqO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+4ZKulYzWiXSV9PjodwYCS12iFEzBVyhi7UPpFBKxiGTnnu+
	tZ12IAnyXCu12Lzmu7xNKQqaEoneRpDPGHb1bsl9uGMqwFamDxSk2p+tuA==
X-Gm-Gg: ASbGnct7VCJFxao3O74/kw48i9KoLWg8HoyY2M9b+ziEIJLmu3lXkOw9LIytO3FSecp
	QbTXRRw/0obQzFiyjm16kTfrlULbY2RL8tMZR54yvr5W66uHsONNj5Vb25KdLMKi6M2/lcvBLDI
	sdgiXjVWaY535l7SCvAT2AH3s++Y8vESWSm3HjZBpxqE4WGBCBqZLpoc4jZ4aZbMhIOY8yWLWoz
	0YlMAPLwHvZyXSrRR8WDrknMds1EyPdTrdwuGsdNfVjaBTV2wPpcu7WVhoIFa5RKVBkYPeDWLhW
	7hRoGz8ofAMn3xoJ2comiExOjWYd
X-Google-Smtp-Source: AGHT+IHE8SXsbpXZSHNLMaGjZ2a2vzAycZ+3bDp+ty6QQecn0m681DvDIp0IxDnOFuMhww7hC/s7JQ==
X-Received: by 2002:a05:600c:1ca2:b0:434:9d0d:1347 with SMTP id 5b1f17b1804b1-434d0a03f25mr26594415e9.5.1733336709510;
        Wed, 04 Dec 2024 10:25:09 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbf57sm31959755e9.39.2024.12.04.10.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:25:09 -0800 (PST)
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
Subject: [PATCH v4 05/10] iio: accel: adxl345: extend list of defines
Date: Wed,  4 Dec 2024 18:24:46 +0000
Message-Id: <20241204182451.144381-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204182451.144381-1-l.rubusch@gmail.com>
References: <20241204182451.144381-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the list of constants. Keep them the header file for readability.
The constants allow the implementation of events like FIFO-watermark,
single tap, double tap, freefall, etc.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h | 89 ++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 3d5c8719db3..ed81d5cf445 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -9,37 +9,102 @@
 #define _ADXL345_H_
 
 #define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_THRESH_TAP	0x1D
 #define ADXL345_REG_OFSX		0x1E
 #define ADXL345_REG_OFSY		0x1F
 #define ADXL345_REG_OFSZ		0x20
-#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+/* Tap duration */
+#define ADXL345_REG_DUR		0x21
+/* Tap latency */
+#define ADXL345_REG_LATENT		0x22
+/* Tap window */
+#define ADXL345_REG_WINDOW		0x23
+/* Activity threshold */
+#define ADXL345_REG_THRESH_ACT		0x24
+/* Inactivity threshold */
+#define ADXL345_REG_THRESH_INACT	0x25
+/* Inactivity time */
+#define ADXL345_REG_TIME_INACT	0x26
+/* Axis enable control for activity and inactivity detection */
+#define ADXL345_REG_ACT_INACT_CTRL	0x27
+/* Free-fall threshold */
+#define ADXL345_REG_THRESH_FF		0x28
+/* Free-fall time */
+#define ADXL345_REG_TIME_FF		0x29
+/* Axis control for single tap or double tap */
+#define ADXL345_REG_TAP_AXIS		0x2A
+/* Source of single tap or double tap */
+#define ADXL345_REG_ACT_TAP_STATUS	0x2B
+/* Data rate and power mode control */
 #define ADXL345_REG_BW_RATE		0x2C
 #define ADXL345_REG_POWER_CTL		0x2D
+#define ADXL345_REG_INT_ENABLE		0x2E
+#define ADXL345_REG_INT_MAP		0x2F
+#define ADXL345_REG_INT_SOURCE		0x30
 #define ADXL345_REG_DATA_FORMAT		0x31
-#define ADXL345_REG_DATAX0		0x32
-#define ADXL345_REG_DATAY0		0x34
-#define ADXL345_REG_DATAZ0		0x36
-#define ADXL345_REG_DATA_AXIS(index)	\
-	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
+#define ADXL345_REG_XYZ_BASE		0x32
+#define ADXL345_REG_DATA_AXIS(index)				\
+	(ADXL345_REG_XYZ_BASE + (index) * sizeof(__le16))
+
+#define ADXL345_REG_FIFO_CTL		0x38
+#define ADXL345_REG_FIFO_STATUS		0x39
+
+#define ADXL345_DEVID			0xE5
+
+#define ADXL345_FIFO_CTL_SAMLPES(x)	(0x1f & (x))
+#define ADXL345_FIFO_CTL_TRIGGER(x)	(0x20 & ((x) << 5)) /* 0: INT1, 1: INT2 */
+#define ADXL345_FIFO_CTL_MODE(x)	(0xc0 & ((x) << 6))
 
+#define ADXL345_INT_DATA_READY		BIT(7)
+#define ADXL345_INT_SINGLE_TAP		BIT(6)
+#define ADXL345_INT_DOUBLE_TAP		BIT(5)
+#define ADXL345_INT_ACTIVITY		BIT(4)
+#define ADXL345_INT_INACTIVITY		BIT(3)
+#define ADXL345_INT_FREE_FALL		BIT(2)
+#define ADXL345_INT_WATERMARK		BIT(1)
+#define ADXL345_INT_OVERRUN		BIT(0)
+
+#define ADXL345_S_TAP_MSK	ADXL345_INT_SINGLE_TAP
+#define ADXL345_D_TAP_MSK	ADXL345_INT_DOUBLE_TAP
+
+#define ADXL345_INT1			0
+#define ADXL345_INT2			1
+
+/*
+ * BW_RATE bits - Bandwidth and output data rate. The default value is
+ * 0x0A, which translates to a 100 Hz output data rate
+ */
 #define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BW_LOW_POWER	BIT(4)
 #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
 
-#define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
+#define ADXL345_POWER_CTL_WAKEUP	GENMASK(1, 0)
+#define ADXL345_POWER_CTL_SLEEP	BIT(2)
+#define ADXL345_POWER_CTL_MEASURE	BIT(3)
+#define ADXL345_POWER_CTL_AUTO_SLEEP	BIT(4)
+#define ADXL345_POWER_CTL_LINK	BIT(5)
 
 #define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
-#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
+#define ADXL345_DATA_FORMAT_IS_LEFT_JUSTIFIED	BIT(2)
 #define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
-#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)	/* 3-wire SPI mode */
-#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
-
+#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)
+#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)
 #define ADXL345_DATA_FORMAT_2G		0
 #define ADXL345_DATA_FORMAT_4G		1
 #define ADXL345_DATA_FORMAT_8G		2
 #define ADXL345_DATA_FORMAT_16G		3
 
-#define ADXL345_DEVID			0xE5
+#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+
+/*
+ * FIFO stores a maximum of 32 entries, which equates to a maximum of 33 entries
+ * available at any given time because an additional entry is available at the
+ * output filter of the device.
+ *
+ * (see datasheet FIFO_STATUS description on "Entries Bits")
+ */
+#define ADXL345_FIFO_SIZE  33
 
 /*
  * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
-- 
2.39.2


