Return-Path: <linux-iio+bounces-13804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786B69FC650
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 19:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739D91882766
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 18:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D01A1D1F6B;
	Wed, 25 Dec 2024 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NERIU9vK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770841CEEB4;
	Wed, 25 Dec 2024 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735150444; cv=none; b=neBRcY19mNS/Kfh6Oz5dw9NbEC5S9H5iIixQnemcTPNeS7+osxKwMJGqJBg0RpN3K+46bGDAww3G/I/iJrrHTkopOyE+0Pczsg2/duBWEbN43VP1T8rrS38egzsnW+zcerMS5azK9JWbV9GWbm1YapR4UPVnJfEIMO6Byh+/+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735150444; c=relaxed/simple;
	bh=s/2Sud8tbTn3DV/gVz7omCuTc6DCCbix5hAZkUvCcyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qB8mdzyLcelgSaL+jQybk6w7Fa+wTNDUPeUnHvl7+cFo3uX1jcZy+oOLjoXuyKmlK4qxNP+vP/28ZuyDaQUotLjllZy1zCUHc7i1VgGDdwAHph0vjpn6vcj6xDe7XMU1lyXSVP+ggKgq3S4V28al1QzspNYnzqLNRSxgyiAUY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NERIU9vK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aab73e995b5so108986666b.0;
        Wed, 25 Dec 2024 10:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735150441; x=1735755241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYq2MT/kLJ5VNDS2ggKYbL2pEgZu56efpig6dGEeYSQ=;
        b=NERIU9vK3wYVexb1CbTAwY/MQ3lo71xY+OPovy144ncCQPwTzqgBck4QwcKGIlInYA
         4GwwcIG9vPBuDe3YV9MMfhs3BjJSb3yu3YqTV0dpVh3SUskRRQR0jURAnlapyMGkl3W7
         cCmbjdQ1W7dBKv7GEUYL6nUob6N4548aYOIIXHARDziT1AS94MLAXHq5wZJ1SpVIHUwT
         B+CfSPvq9nkvXTvjsPSYYRYmUPeGHPIio6v5eadqZIJd9aCZoCEZX++gladM+Zmpw1XG
         1/huU4toV4XZDzdNpvsO0OWRMjG7wVIfgDuHBUbu+jvoDVFDX9e3tZal379XSurTqqec
         kgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735150441; x=1735755241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYq2MT/kLJ5VNDS2ggKYbL2pEgZu56efpig6dGEeYSQ=;
        b=gfAGbfEMqos6zqH82sLhucdQyWwaURTHv3WjD7PzDMnUpWcULrhp1khDw5v11xC6Gr
         56IGrGhd8fa8PLiMZpaguRHPhUM5qGHl8kAO45la4yBUM5FhTTy2yXlotOE5vtFuex08
         3w0Ovbn0NvDZ6Ues+pRf78Nl9C23Gt0/BlwInu0M9gyHG1qEJPOrYyd/gRi5UD9I9ea6
         kgmWivZPQ/xBhTxqHJ5Z5FDjdmQCXypmTNWPwRBljaGnYV8+BMLpfEEphnjZQLplduky
         DMWuqRWN45B/8i+PAnljHHFLam5Iw6fBTIgPtrw5jvTGZIHcA0QllMjtXUraKaKQvx3u
         YIwg==
X-Forwarded-Encrypted: i=1; AJvYcCUdKR63hCHHk8eJqBQ/mqxucAyBdXIMwJxKrkUG7t1/Vmf7kzhhCZ5CWpITKo4Ic+SsMciBONLWaSw=@vger.kernel.org, AJvYcCVO7w06Q+L6lEKQvIKFo/WYvWuoFzqWSKQnYprbOgcfe3qdiptuqTgMA5eCRlXK2LRjI9QYdyYufQhSTVm9@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXKaVkk34Fn7KeTAFTR6YBzJbh7mJF3HP0DqYNay5BDdLsRxG
	EQiQArKgnL4FRTnTZQOXmO93CRZyg3ZVnlpA1ICWs4CwQl9RSTUY
X-Gm-Gg: ASbGnctfFX+y6rcd7m9pBB1c9qpd0l4SPZh6JhkFo3SykX+vJ54ZkelVimmliaSl5RM
	ouCrZgADVw3qqTFFhNXRk+zSCXMbSuSf3i0eFZawIILUa5anxg5NhwsaJHGomnzNxCrUtWh5LYo
	A23X2vJYav1RnT7u+B1lHdtpuCcU99nHMatheM9gnlQGqxvIO96kG1JLUBV0T+IegZq+8JQbsiK
	vSA4xQ/xpc7h8K0mzMElGrLWbC2BbssV8huTh4UinqLZG/mCKRtIE2Xj4vxdK0jQlMO40L8orC2
	BuBNrPWWANfkR+iV7SqyOdocyyLrTgsSac4=
X-Google-Smtp-Source: AGHT+IF6H0bMBaPLluCSQabzlTudYAwuj5SbVP2NOXXbbHTsdrugpv+mucLR3NL6+vnLMnQ/uoBu3w==
X-Received: by 2002:a05:6402:5109:b0:5d0:bd3b:b9a9 with SMTP id 4fb4d7f45d1cf-5d81de1c38cmr7396409a12.8.1735150440821;
        Wed, 25 Dec 2024 10:14:00 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm7721141a12.88.2024.12.25.10.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 10:13:59 -0800 (PST)
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
Subject: [PATCH v8 7/7] iio: accel: adxl345: complete the list of defines
Date: Wed, 25 Dec 2024 18:13:38 +0000
Message-Id: <20241225181338.69672-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241225181338.69672-1-l.rubusch@gmail.com>
References: <20241225181338.69672-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having interrupts events and FIFO available allows to evaluate the
sensor events. Cover the list of interrupt based sensor events. Keep
them in the header file for readability.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h | 57 +++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index bf9e86cff..df3977bda 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -9,10 +9,35 @@
 #define _ADXL345_H_
 
 #define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_THRESH_TAP		0x1D
 #define ADXL345_REG_OFSX		0x1E
 #define ADXL345_REG_OFSY		0x1F
 #define ADXL345_REG_OFSZ		0x20
 #define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+
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
+#define ADXL345_REG_TIME_INACT		0x26
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
 #define ADXL345_REG_INT_ENABLE		0x2E
@@ -34,20 +59,40 @@
 #define ADXL345_FIFO_CTL_MODE(x)	FIELD_PREP(GENMASK(7, 6), x)
 
 #define ADXL345_INT_DATA_READY		BIT(7)
+#define ADXL345_INT_SINGLE_TAP		BIT(6)
+#define ADXL345_INT_DOUBLE_TAP		BIT(5)
+#define ADXL345_INT_ACTIVITY		BIT(4)
+#define ADXL345_INT_INACTIVITY		BIT(3)
+#define ADXL345_INT_FREE_FALL		BIT(2)
 #define ADXL345_INT_WATERMARK		BIT(1)
 #define ADXL345_INT_OVERRUN		BIT(0)
+
+#define ADXL345_S_TAP_MSK	ADXL345_INT_SINGLE_TAP
+#define ADXL345_D_TAP_MSK	ADXL345_INT_DOUBLE_TAP
+
+/*
+ * BW_RATE bits - Bandwidth and output data rate. The default value is
+ * 0x0A, which translates to a 100 Hz output data rate
+ */
 #define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BW_LOW_POWER		BIT(4)
 #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
 
 #define ADXL345_POWER_CTL_STANDBY	0x00
+#define ADXL345_POWER_CTL_WAKEUP	GENMASK(1, 0)
+#define ADXL345_POWER_CTL_SLEEP	BIT(2)
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
+#define ADXL345_POWER_CTL_AUTO_SLEEP	BIT(4)
+#define ADXL345_POWER_CTL_LINK		BIT(5)
 
-#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
-#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
-#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
-#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)	/* 3-wire SPI mode */
-#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
-
+/* Set the g range */
+#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)
+/* Data is left justified */
+#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)
+/* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)
+#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)
+#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)
 #define ADXL345_DATA_FORMAT_2G		0
 #define ADXL345_DATA_FORMAT_4G		1
 #define ADXL345_DATA_FORMAT_8G		2
-- 
2.39.5


