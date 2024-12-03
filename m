Return-Path: <linux-iio+bounces-13049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7666F9E2E24
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 22:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C24BB3D95A
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE1C20B1EB;
	Tue,  3 Dec 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C55GOJqB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8620ADE1;
	Tue,  3 Dec 2024 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259194; cv=none; b=YEnb1ePEYY7Oj0dOeEf39AFoygi0xYNBRiWJryB2DtXsW/Y1YeHE1E5m/gDBJLghr1U9m9OZLZRUIR2yTwdw0WKKaWF9xHgeaazKXb+ZRxNBLD4H4yNjnZdUxBARYdjhfBcgJOMN/uJ/YIL2b8f+8T5sSTvf/NVt1jb+X2lZUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259194; c=relaxed/simple;
	bh=7x6c4McqriE+EY2lsVFpTBN7B5n6vTorPBvTrqJAZQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSJMPQeZvWniILYu3Z6vuoj6qVl7WvwqX8KKjgY+c3vipZUtZLyCW0G3V8pghMa/PvAoWlUKZ/mHYnaZfe3GhlwfIxZuLOe55I+Bv8TNDoUCJPQFaLIQ0u8PQbHJSceJQ1CbZZ88E8om6DRxGt6YkBB/cMnF+VqvBcQMuQq+Oao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C55GOJqB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e44a1a2dso156449f8f.3;
        Tue, 03 Dec 2024 12:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733259191; x=1733863991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3z8OPkTXyo/oK61J/lQvQSxHrdZAWZaME9/d3kJunE=;
        b=C55GOJqB63jFZw9y5MrqMPa76EKApRAIB6/VVvwrURR8K9437E/ctwmYUyHtnniyfO
         z8R49kh4La4otm/8hdOHEBb6cIj0QN5I97vXEdK9Yfymm1yjJF6BEvUQcDhPTHJVJuBp
         aucfnLDlEHJZg3QLG8DAEaXDM5va8EP6IuxYuHVSKBhuutwVGF3mT+rPJ2EsSP64WbsU
         xr7wqeIDGfINnvR2FEtpmzDSjep4nbr9NUao1ou6g+RPnDptx5lmgqQexgKL8hpsQHcW
         aCd0K1bnB9IKz/ddVBIu/rbMKaCT4Zo+f32FzXq9RLgAwpPQS7iyDmL1XckDjlEsZQDt
         /j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259191; x=1733863991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3z8OPkTXyo/oK61J/lQvQSxHrdZAWZaME9/d3kJunE=;
        b=vHn1+n1N1D7m2b66seyFzwQhvzpqCaAR1hPfjeU+0N7EX0uQik9vE66fbHk8weiwTW
         2Uka8+5XSwRCyrqcKqEdsjkPc9cE3dnp/Bv5UrQk52TcF2ewvmztPYo0LVAkzydxcUSb
         Y7SrVUd8aU4ATIo4f/G3M/gGLlmdOIyVjo9O1A/KjBJA8+tw8rJZ8evuqafYjpkt/PoF
         6ELYzJKOlAlqK8mpOO+PegwxVrs2N6cbFQTFFDtoL1pAiv+RhTnDvS+7JoT6oPrG+IuJ
         u4S+3re8qw9WSH7l63vQre/j3Gx3UElzugqZ1xjI52bIHug6SFGwSz/9BHrTOlsdWH1s
         1XtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSpC/jcSbLkQb1AAw6BpiBQR9cXNxMdHW0rt1uplrm0bjyyQUeqHKb5rMIvirSIwA6kdCPfqHQM9k=@vger.kernel.org, AJvYcCW7IjRY4XgcayQZyOSYXrX+sZnMi+a10rcaliW1P9Rcg6zfIl9q2pRzi2x+GRtsL2V2dkvBgF1+rezGNRSd@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/knsFfXuMn79gzeh2D9lEXcFCdnGZuwWvFPqsDmZavhvEooc
	OhNZjeNVDaPSRp81ZpiWDUMI9pGZSi/1pjKFik0hYv+CuGiszlgeITGZRw==
X-Gm-Gg: ASbGncuvXFzKWgwd2WM8L+4AVoaO2dnCLiKL11hxs16+LWyHWp4MSxob/m2f+Wtgye7
	pr6I4iIND6FLqKpYwBhlqWuCwt4TuEv3Owov6oVEhMFjxy319Q1WCHPcrZ0BqKtd6YLxAJisSTK
	MW2hzX2CB0wcZDq5l5mLJYbRe5Zny9RBLysIKSAw6WsLXutyMjFvKwTurEVbGXzdEZy6zz9H0vO
	PZOvbgxzjOwleANoDwTm2vz3LWUK47OEDtcT4QVK6jsiarI5aTvuTJU1gxvOT8sbAdxxYPD7JnQ
	1H1N4pnA/ARckwPMudQi3I50qgOj
X-Google-Smtp-Source: AGHT+IEuDTodDy+Zqsc1eozHcG4M3AcivjQdlyyXofSRfyTIb/0I0TlTqnvGpWSrFep1zsby2lY8lA==
X-Received: by 2002:a5d:47c9:0:b0:385:ed78:e17d with SMTP id ffacd0b85a97d-385fd36ca63mr1563307f8f.0.1733259191359;
        Tue, 03 Dec 2024 12:53:11 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ebaf3bccsm9042750f8f.68.2024.12.03.12.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:53:10 -0800 (PST)
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
Subject: [PATCH v3 05/10] iio: accel: adxl345: extend list of defines
Date: Tue,  3 Dec 2024 20:52:36 +0000
Message-Id: <20241203205241.48077-6-l.rubusch@gmail.com>
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
2.39.5


