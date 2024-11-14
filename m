Return-Path: <linux-iio+bounces-12278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623A39C95E3
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270FD28286D
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A011BCA19;
	Thu, 14 Nov 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oxx1oDNO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24D1BBBD0;
	Thu, 14 Nov 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625828; cv=none; b=GNmoXx8F785bktntuXIQJd9kkUcEJSZ/B2CDvZGfai7VjHVrPgX8K4DCleQjbRZrRJEIi8PNRMhqSutx4lZn/P5z+Bz4GmhsMIDRA8dOkKCwCyoSnh9EIC0DV+SY5RaI+bKDYcpn0ozNQaLpsf0V9Z1LGy6c9WQQRmZH9b+91tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625828; c=relaxed/simple;
	bh=BJud18EDREVXZJkzHnfXHc1yREntMLZOOXob7nNkI7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dlilUYS/n+nd3GmD5xbuss1R3Zt7eJfCvzBAije7gGb4hwMosvExwx7GkPYGQ75MPjIBRKGnIfOD18GekVhGE4+WheI1TPxvPWCB9F7mGkroqcQUPmkcWOYiXEJ/G/SRzT3acNSpSPrZ1V9Izd6xTlCsNRZNC+WFp+LdYUQhygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oxx1oDNO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43152fa76aaso1070055e9.1;
        Thu, 14 Nov 2024 15:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625824; x=1732230624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7GEt5vc7jPXUU2i44DeVWa773kql6tCMRoKXi+rtmQ=;
        b=Oxx1oDNOy/+QXpy8vr2QYOu1ljoxR4DXIrZvNbBhooTQc9gSC5Oiu2qfOwvfx+TtEO
         Va87TBk/DMNxvOAvxIQD6tjPVTPkDWr3aJ6tZaeqntRUbjAo+2pzyJWw2yNcezTW38mH
         bSbdztr8viE4WMW+p/7ABgG/FOtc2Lfqeh/IDzGHfMqbx05DFPU71Zi3EBLMKpvKHeoL
         gw5uc1yGabE4j09uH2iZ9hWapw3Od2VfcRGmBiowcA9AUW+BWGj0z/Yl9z5kY5PXUqkf
         M+JBBn3S1Wlo9nOYq0OhoRNsHueYyq+bLDrr1Yv65OYvCf6mwsP8i9h+OXK/MRpD1+ls
         qf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625824; x=1732230624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7GEt5vc7jPXUU2i44DeVWa773kql6tCMRoKXi+rtmQ=;
        b=f390EjQZCBEJAUeJRq+JyN/3kirf0SgdWKqwZt/+9YF4rwGwvmvi5tBHTecxKE+OfA
         fWZaIguA1Qi7SFnqrMbs9Gl5MXKmxt3nzpqUitL4bj5XwZ1A5dpZ/tFQ5kii5ldFGQ56
         hr3QRTy+hC+0hAeW0hbrRStYH9bYJv997PHFv9YJlHkPRu9oCNdc2AV819qZIZQteppW
         yzniah76ycpr6JDlnuUvmW/cyfPSj9MkC+lPK3ZUd3UAWzGv23mDI+1ceHvE8dDsstSk
         iiilE6o9BpXwiC/5DnMcnkvCQYW7YQF0/4x2PHBTri2qv3rVuL4lkfjD37wSJiQj76wE
         lu3A==
X-Forwarded-Encrypted: i=1; AJvYcCUBYZZr+YxPDwkxaWvHyd1QtK5QrgOUb66/7IPPM5q9EI6y1L84Lad1kuBzUNwstKFG6dYD3pIBkng=@vger.kernel.org, AJvYcCUQjZKbJ53hPWeSSynfP7iEcvWm3Z17OeBUXhxAnxdmWF3j4KkuPSaq1IW83UBJMDFsDCQHXiL5YBZr/RmP@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbC6WZddQNgokofHraLbs/oR+ewKfU6e3wA39WKlS7Igm9/WE
	X9uRKDbXXtJjzjlvCSrGy+137sobkJRdHQMd1RrBPXVopvHvMf4l
X-Gm-Gg: ASbGncvKX7cFqgUNPE24MZ+J40ddQzJG21mMI0pKIcD+nnwJuA1HhOLaNIp7ADLrNs4
	8FBFHMTOdBzpmcizJooeSYhjyctqYRwnmFvzpRJc1w3UtH64urEG9Q+uZYlNhdVXrGJVIGhbveQ
	pi2ApdLPB23m8Ep5ByfdT+WATYVEgzsCzzY70d+7ZaCSSKoyimPDNgb7dsqa1M5H8fcPR7cfX/k
	u3vU/Mvq1AKzwaSKvXtvtsgyrxD9DyEJSI/0SbXuH6+3I2tCH3nKfcSy0tmaHbMZJ8AsQo/WGjs
	YjZ3+MZcnfDQTYNxM64/9/2RJ8Yf
X-Google-Smtp-Source: AGHT+IFcjQSnNlUFYpmye+fKVSoLZiKP1rGGoo7/HK9K+9eGATt3VcPLXYElzMwwkcABZ7BHTvzRnA==
X-Received: by 2002:a05:600c:3b97:b0:430:4db0:3ffd with SMTP id 5b1f17b1804b1-432df78c83amr1587255e9.4.1731625823965;
        Thu, 14 Nov 2024 15:10:23 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:23 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 10/22] iio: accel: adxl345: set interrupt line to INT1
Date: Thu, 14 Nov 2024 23:09:50 +0000
Message-Id: <20241114231002.98595-11-l.rubusch@gmail.com>
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

The adxl345 sensor uses one of two interrupt lines, INT1 or INT2. The
interrupt lines are used to signal feature events such as watermark
reached, single tap, double tap, activity, etc. Only one interrupt line
is used and must be configured. The adxl345 default is to use INT1 and
in many installations only INT1 is even connected. Therefore configure
INT1 as the sensor's default interrupt line.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index aac49b3d03..949847fad2 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -131,6 +131,7 @@ struct adxl34x_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
 	bool fifo_delay; /* delay: delay is needed for SPI */
+	u8 intio;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -343,6 +344,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENODEV;
 
 	st->fifo_delay = fifo_delay_default;
+	st->intio = ADXL345_INT1;
 
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
-- 
2.39.2


