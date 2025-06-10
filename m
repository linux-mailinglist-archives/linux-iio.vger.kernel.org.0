Return-Path: <linux-iio+bounces-20387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DE9AD4542
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 23:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC7B3A1609
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 21:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB46286413;
	Tue, 10 Jun 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZHuxBQD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB30284B2E;
	Tue, 10 Jun 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592786; cv=none; b=V5DZjc10D5hlgwMYUiF2kPOEHbSJ3lG4d2nXAq4f4bKs6yi7WzBeycIOUxQ8P00nfSxWCWbg3Yl+bKseKR0ix6T/Ls4cV6zGQtEzVtMgRNj4TXL1CLUP/op2sL9i12WgvwVzfpkc0lUJoh5VjW4GYBjN+6ppoJMtzx3hbzY6U1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592786; c=relaxed/simple;
	bh=P/CvMntAZfwSjd7Rps/sieqyJ/DLxzwH2VXuz0YLSTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d6KqviLi6vnqHZzR6nDdFTIh3tyP7RhVjGp4FyViLmOcDxGWNs6tA/4ShubWg2xRKW6Ssy81n+EKM0AQAwEsKmzx3KsK8E4vb6vv3/5clp4blVIpmU4LLZKyBfo1hGI7dfucMU9FYK6PE9kNTQCUD7FWqh1Zg+wV9r0X9I9JBPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZHuxBQD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45306433f71so2014795e9.0;
        Tue, 10 Jun 2025 14:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749592783; x=1750197583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7FO+Je9Jcwva34+VYHJAZ+BzdqveRP/gaDdKN5wlsQ=;
        b=QZHuxBQDVRnkNFlfsKqlTao4i4w/7HhwzYIEjefFvxpDYgA4Vb+lVa5Woe37HdhuLN
         FKPhsweSzy+VpYAYHHCJDIYn8L/3qQNuLPoq2RmmEnbTVDLViYlrTMkJ1iUy414byRYm
         7g9VjS5OrHpdPdRrqkDsaiV4a10EJ8jItDUwukuh0V89g/SsBKNdWVJm3k8EGxqjbveS
         XfAQwnhp2iF5aDk8aDPTj4AYqOoGaesb0FYwfYA1g7xFlZYp3oM3qk7Z4r/32finaict
         Y/ZoAvzAOlVt5vgvsA+9CquYfsi5tWC+Y4JR2i+NvzoNx7UTqVoANWlF2jJP5/Mri3OO
         Asvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749592783; x=1750197583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7FO+Je9Jcwva34+VYHJAZ+BzdqveRP/gaDdKN5wlsQ=;
        b=PCY8lG/zAvoiO3+mcIuc6kdgKwK0AA0WvyyEIgnG0kuBO1ukIhFN9XRD3CDaX+l6qC
         X/MovDGeZlwn+Viu9WB49kdVSmzQrcr6RuccgZBmiMq/C2R6NSnWb2To/DtAOoK3HNyU
         NUbkTbhhAiWacHma/6aN439O/SN+xwi28h/LKwln3mMxb71PTzU/VMa59S9dJa3g7TIy
         cBj+kHIh1svjPsYEnkhVhUEJleJajHka4NmqAQyfdJyGSl6GUtAvQKWKou1iuNMo5lBH
         FRxQHCyHXGccSinCgk3NrFsKzjYSsUSyVCVhATq1EwHA68ESA5KHgOSzBT44CNUyNR8l
         20oQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6IRjY0bU2esAj45zWph6coEyiNdPUMjus9jt7X5TYdLq1cZQXlIylL55LQCZle7Jlw/jA5pJbKJvCZtP8@vger.kernel.org, AJvYcCVtwd/bZOQwUXuJGfTh8o4m5xNZ/TghT0O82zmObTd0P1DcvXkHzQpu+mvpEp1SaTeDugebkeaiEf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxRaqhKgKSFGsTLQc5j5zjshGTaaluN5BDAwmarwaAtg5vsRZ
	ap4C+bQamJY1DsGmHkk7MPw/skFS0ALawS68or92dU93o5bZS8C7+dyB
X-Gm-Gg: ASbGncvkpfCPxN/ngLJVVCWvOsTolo9LB9CgspF2DFt1DL9DS2JOmvpekkbJPlNcGpr
	qC3FF8311Z9vrfADd1V6VEFiXrlLdlcyb5JroPeC1clWMYeENt+kLaGb8InX59GB8K8V9JBFS/1
	pLTBiLaheZLKbbEX82kZgnLZmcGr+gKmkm4cygsWlmbq1cbm4UsmawGZa5bQuI1DY+84lZyQviF
	PMSEWpEuMBW0w3LLFnzOqlDqM9UmO/Hs8IGF/SV8NwId2hh4zatcWUrVBT2PrN96yjVhJMafAYy
	7avYOCSjlPW/LUkv4OylKaerHj1mcPwnepNbaIrXUebrspsGGIlwNHdhmxiEdPKW2H9N9LZlO9V
	Ci1EncbzKUebw6hrmD4jBCCyiy+10u248RB2AR6fHnDE=
X-Google-Smtp-Source: AGHT+IE7KTpu9246gYxZ165ddvXaFZhc5FqHKJuaRE0QQUUwGsfRiRI5icWbta6TyUMscW53nDtohg==
X-Received: by 2002:a05:6000:2504:b0:3a5:2ee8:ee1d with SMTP id ffacd0b85a97d-3a558a1ef01mr172863f8f.16.1749592782939;
        Tue, 10 Jun 2025 14:59:42 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f04dsm13312647f8f.73.2025.06.10.14.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:59:41 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v9 01/11] iio: accel: adxl345: apply scale factor to tap threshold
Date: Tue, 10 Jun 2025 21:59:23 +0000
Message-Id: <20250610215933.84795-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610215933.84795-1-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The threshold for tap detection was still not scaled. The datasheet sets
a scale factor of 62.5mg/LSB. Remove commit about not scaled threshold
for tap detection, and apply scaling to it.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7c093c0241de..d80efb68d113 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -697,17 +697,15 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
 			/*
-			 * The scale factor would be 62.5mg/LSB (i.e. 0xFF = 16g) but
-			 * not applied here. In context of this general purpose sensor,
-			 * what imports is rather signal intensity than the absolute
-			 * measured g value.
+			 * Scale factor is 62.5mg/LSB i.e. 0xff = 16g
 			 */
 			ret = regmap_read(st->regmap, ADXL345_REG_THRESH_TAP,
 					  &tap_threshold);
 			if (ret)
 				return ret;
-			*val = sign_extend32(tap_threshold, 7);
-			return IIO_VAL_INT;
+			*val = 62500 * sign_extend32(tap_threshold, 7);
+			*val2 = MICRO;
+			return IIO_VAL_FRACTIONAL;
 		case IIO_EV_INFO_TIMEOUT:
 			*val = st->tap_duration_us;
 			*val2 = 1000000;
@@ -746,6 +744,7 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
+			val = DIV_ROUND_CLOSEST(val * MICRO + val2, 62500);
 			ret = regmap_write(st->regmap, ADXL345_REG_THRESH_TAP,
 					   min(val, 0xFF));
 			if (ret)
-- 
2.39.5


