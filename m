Return-Path: <linux-iio+bounces-13800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BB49FC644
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 19:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB96A1883365
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170471C878E;
	Wed, 25 Dec 2024 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0RU73NI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E51C5494;
	Wed, 25 Dec 2024 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735150436; cv=none; b=tCI8wzONOR9MMLSa+b/W1mi/aB1GPQTZ9FpnssYDZByv0ejpmOrGjHRZrLceawVsFhbqgV59Cu8/CW8aIrhk2RwaItOMWM7Z37599uKc9DXizt30ai9j/xoyO8Yi2OjDRHiD0Y+ITkXStw4iuDlMG/kVK3U7GzCN8wQupSShvx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735150436; c=relaxed/simple;
	bh=muD/nJJlClqgww6SxT3wbYOjpIPUZERAZ7g3O/5sAks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Imk0N6DrjAaUdRef6mj/IlFSU5yZHP4J/nLzuCv6ZV+wj9KchK8DSGhsMpd3PhTDPK+l6cHX1NkzcVwHSBv6L1l/c0EcZsQ1zv+FOl15PAg9eqf3YR/rNUy9vRG1o4/GrfWbjT5ESq8My1pHto4x2QIT4QDOJhphDTQoUmJC/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0RU73NI; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa69599b4b0so113726766b.3;
        Wed, 25 Dec 2024 10:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735150433; x=1735755233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DntmeBaXtuyXrfh+kAwMzaleGIsyITJbBXEuuRaR7ig=;
        b=Q0RU73NIuCjluIXa4ZH+9AQScmEExGNHcqrD72xJLTTguu/YTVG+gx3jcu6sDYyCj1
         zL324gFgE+jBZkN9EXpHTlNr6nbLGZaXe1uHDi4wyYyRFezu8Nuz7E+ccyEU3E1cUoyy
         mmFZfc8Yfsq2VT0SsbZTbBDhIHHwBEswZOk1UUNtqA86wgdZiOs0Y7ABpjclCuGW7WAg
         PI25EGiNlM+tngEit490v20dmYCcz4lFIDHbcQ1bfg5EXIJtFc+rcjvF6K1/J4lyGN2h
         gW7TnLZkfF3UxxMvdxoGJ68WdrL2mY2wNqGd4xUFIv3vGuF7q0NuZ3k2zie8J9yEgE8N
         GXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735150433; x=1735755233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DntmeBaXtuyXrfh+kAwMzaleGIsyITJbBXEuuRaR7ig=;
        b=NmzjYTmEs7Nz+FOh9pXgero0TSEjoMpy2Y9FxomKa+GiXDHj0TfO5GxNFSPqUzWYmN
         h6diCS03yWbKvpTThqXml5JstIFjIEo46JmBCUVOe+adcRi6X6jJc0nEsP019sAXO3tt
         75aoF//G9uQ70PIRUMYjeQTZktG0z/ws1h4YIj/XuvMrPQfUxAvHg1kCFX9RKMPOHmS7
         +Tym9sfyQ/FEtZ+y9AiL1w+l9TrTijbV6Ql9eWMzZFG4hJyqekwr9NX9aIb3OMhfWVEO
         hQvHSpQM0EbjcbJh8hk/RR0h60BYq0BxReBRrmcQGn+lkm3QZMJHlILVSBvw+3cpCsHE
         1afQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0DAPDDmbNpVgcS40gdeJGXRd05T3W5uHSaSy1Fza5ekPssZf1uTqCz9TY9Sb7ZswUbNzINsw+Qfo=@vger.kernel.org, AJvYcCW718HDvMKHeZNaqNDkRCPfky4DD7DQfKu8pfcKGcs8utSTKlINEFDTcuWVFHi2yKspdgbPEu9z2RyQDGeg@vger.kernel.org
X-Gm-Message-State: AOJu0YwawwQTVsGD83PvyeJAxf71zDGonigH26Ry7sxbcdpZ0hsykscQ
	xDZYAGUlI8fj0e3W/Z9/aN6cdomxc7zzL1XFCge596d9/0nqnEoZ
X-Gm-Gg: ASbGncvHKymZxYhKjE2cLg45S7S+U3MZy9k4w7V5D1zhavJWYpEcuEu1Gx1tQ3zloi4
	hnMd2YCojzqp4NklOSm0SzVZt1lb/2Wj++58FRPxNyvcmZeuKyWxbaebB8RVYRuNpaWNducr58G
	6XyJAAJsb6FwDzuWb/aOlQVhGgi3qIsMLxxhKLIci7FEDChPPiWsFmgHaIpq0Ew+uTOz2b/9NTH
	dfzwqniC4RVfA1MejxnJBfkiDLe31E/sy5uPTlB5XuHQXepzNwv4txs3Up21oHT277eY6jop1jI
	Nl2kPCDE5qxnAjBd4Ko7J4VQTSLbWV9nWzM=
X-Google-Smtp-Source: AGHT+IGq0pvTdzYhZbweSz1XNaJDd3dwLOIhmWuk63bQp2xmDngDQ79mUO7aqaVwPHDM1pQ57DzlaA==
X-Received: by 2002:a05:6402:5246:b0:5d2:d72a:7803 with SMTP id 4fb4d7f45d1cf-5d81dd83c73mr7324385a12.4.1735150433312;
        Wed, 25 Dec 2024 10:13:53 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm7721141a12.88.2024.12.25.10.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 10:13:52 -0800 (PST)
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
Subject: [PATCH v8 4/7] iio: accel: adxl345: introduce interrupt handling
Date: Wed, 25 Dec 2024 18:13:35 +0000
Message-Id: <20241225181338.69672-5-l.rubusch@gmail.com>
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

Add the possibility to claim an interrupt. Init the state structure
with an interrupt line obtained from the DT. The adxl345 can use
two different interrupt lines for event handling. Only one is used.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 27d70a1f0..134e72540 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -7,6 +7,7 @@
  * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
  */
 
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -17,9 +18,15 @@
 
 #include "adxl345.h"
 
+#define ADXL345_INT_NONE		0xff
+#define ADXL345_INT1			0
+#define ADXL345_INT2			1
+
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	int irq;
+	u8 intio;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -262,6 +269,15 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret < 0)
 		return ret;
 
+	st->intio = ADXL345_INT1;
+	st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
+	if (st->irq < 0) {
+		st->intio = ADXL345_INT2;
+		st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
+		if (st->irq < 0)
+			st->intio = ADXL345_INT_NONE;
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);
-- 
2.39.5


