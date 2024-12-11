Return-Path: <linux-iio+bounces-13376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B39EDAF4
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 00:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568AB28389E
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 23:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF3B1F63C1;
	Wed, 11 Dec 2024 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LacziqSq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914BE1F4E3F;
	Wed, 11 Dec 2024 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958430; cv=none; b=QynwI9PhEWiJ9f8UjucQ5rzpvM/QmIPyzsXO4u0hoyesC66pWxJ4cDWAa+dUnWLAfwY6LxITDCYPcgqZXTXxzixbLH2bHeKtBnchCAFnJy52mrKsQPcdIYVluS8d3JAJzZd1klLjoxpfnkmSTtHD5B/MbT9DKbBPIqYmXWWwePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958430; c=relaxed/simple;
	bh=OnEi/NtWpRQrR4crDgkQmPpkIr60sP3pUIwvNBRDZyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlD/htOJN6arpSNfXh2/f+UdDq5Jqr9meLKLQyEAc9Fe1CNXo2o40M/JQ5dH6AZ3Bh8NH19RO48VRgnNEoY4kSWcD9HDlnmY3Y4CaoQI7qFJTz4np3CjD1NDzSlvXwvNSGah4zJsI9jhW/epGtLPNQjWoIHBU0gN1MhF2RT2LCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LacziqSq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3be7f663cso871986a12.2;
        Wed, 11 Dec 2024 15:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733958427; x=1734563227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWLUOvAYC/+QKYOvlVecoPGtDiIOOdHySdnie/FYzsE=;
        b=LacziqSqUsHJmZeXlpvRrlLGDUU9Fsa8lCGiXptAPqVdQUH2WSqMn7Mfdwk0qd99hb
         Roztf01NbP7Fj5LgRbr6gb0GZIypQQnXW3a19qMuLuVLj9KxljHy9UT1HwWilNJi8O3u
         jRsqXGeVQZ4ku45g/vQBCFtfZvezG7FkIwppDRxOklwzHoGemevBET64IFo+J+nIAlJm
         8I56lD6H2gXo+wDvxaqDiBVc2jwILtWpC/+dtJ28suu426oC9y2hwwFsGOmzSicJX7Wm
         0zHz31//BG+8tnSfCcHmRQk1sd/CBmlK4U+U/a6jqWos6WZTGL+/jxQkSWckRCvYi9Mm
         N3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958427; x=1734563227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWLUOvAYC/+QKYOvlVecoPGtDiIOOdHySdnie/FYzsE=;
        b=cFs1l9GMGskuwMooi4cIZ3Syx2rDaR23kgyjLbVRShTDFnZaKvJ1Jkc1XQZwwNd8NX
         q/YOl1sc/6Dl0aXrcDInYAJWB/tjyxG8zQ9JAxc94tKom9GLo/9ZU7sMznW8MBADrLsa
         DL+TbKpenll5GtjnV7Ql4qSIGUGPGLA+bw2FavFlSZLcIuLUpInJqhRXn1Nl7hljM3qz
         AJSqBUCgcWVfXKTQ9aMvXUCMNtCctXVKRYtzZ/fSzAZy5tGWX16chO7w16Ijjq39ZRR2
         4a/9U9gX0QGwLsygUgaT/w1H6lf2YT8pLDFUwWL2ffYliSR4x4SRQCz5LnKr7+XRI/V4
         I/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/DpBX3HVseqXi9TICw/C8DE2sSWoH0GXDFsMli7RCVB+tTsZUL/rkD5L5EB9U/jE++6E+ZEQtEboW/Q8x@vger.kernel.org, AJvYcCX5qw0Xc0Ec0UTxRYeqrugB6ZvUAzsXei/5vACpUjvaAv8Q8rOfd1bOoZrZPH+Ie6/oSkeT6aaMtS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVwVOzwVV0omfWvZRvM07pSWViKxaTOd2GPVfAZlg3FeVCJjsf
	Sy3//zkp5bk7MscvNGvksjsbRqiixk3Wwhp27N1H922docUDi1dP
X-Gm-Gg: ASbGnctX+PI108UVng0nhUV/Ju/nV1969mn5FvYyRqHqZ+g3p2IbfWDW3DOKt5T3gBN
	az5iUSG98dSyv3azNUaQ+iv8Ifm8pQwHjfGjwp/kIrvHuolLVzrdTkDmbmiTJSY5ySNDvOyB2DE
	cHdZNuUHx6sqCuLvGgc4Bv5RnbIyzJXrs1sdw8TA2d/RA2CGaVrvzqjDmBIS/QR6zVKUt03zhqE
	SAOOCa8b/tzt2WmxvsL0ZZ6GdIU5oKXZPHwD98745syq/ZbiplqVZt8SwvdFN/c2FAvFo3nzW/e
	2kX01i6fCV1K8sgqxz9Vsao/v353idtQ
X-Google-Smtp-Source: AGHT+IEbMeN+CFn5kcg2r4O75MDjqNXtmni+IaNtiGkbeq9G0JluHtLSqTHNITX1PXbvALxreETbhA==
X-Received: by 2002:a17:907:94c1:b0:aa6:273c:a616 with SMTP id a640c23a62f3a-aa6b117f479mr185961666b.4.1733958426755;
        Wed, 11 Dec 2024 15:07:06 -0800 (PST)
Received: from 34fd2088d136.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa655653d96sm747350366b.185.2024.12.11.15.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:07:05 -0800 (PST)
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
Subject: [PATCH v6 5/7] iio: accel: adxl345: introduce interrupt handling
Date: Wed, 11 Dec 2024 23:06:46 +0000
Message-Id: <20241211230648.205806-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211230648.205806-1-l.rubusch@gmail.com>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index b48bc838c..fb3b45d99 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -11,15 +11,22 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
+#include <linux/interrupt.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
 #include "adxl345.h"
 
+#define ADXL345_INT_NONE		0xff
+#define ADXL345_INT1			0
+#define ADXL345_INT2			1
+
 struct adxl345_state {
+	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	u8 intio;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -213,6 +220,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	st = iio_priv(indio_dev);
 	st->regmap = regmap;
+
 	st->info = device_get_match_data(dev);
 	if (!st->info)
 		return -ENODEV;
@@ -263,6 +271,15 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


