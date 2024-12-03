Return-Path: <linux-iio+bounces-13047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D5D9E2D9F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 21:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7C6283DF8
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E05920ADC1;
	Tue,  3 Dec 2024 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj+xJgEp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF5220A5CA;
	Tue,  3 Dec 2024 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259191; cv=none; b=OJVT6R9ZXsGpJFjYTzYykCJNsbvLODK1O+wa4ZLhOIa1QdhJAfZuhtMMhOpBuuEfVY8tok3ApYOyAdTUT1JIogvjzuIbrNl+58UdLltxQPY7Q2xSjXqQz5tl+gQ/SdVk37CoNARrpnKGY60LoGalM5IsuxEfoI6AhBadWWmarp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259191; c=relaxed/simple;
	bh=PjjSMoBAaP8xREw/NXNd5PdGomIPOnLYq3NdM0KeA24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z567kI4R5UMa/0GT8ph5hEo9oa5Rg+YLArx5zDIhXx/56amhQnDGGR4fflNrLj35sJxKIdw4gkcss/Bkbz7wo2XdXaBqtyxY2vlhWLgOUyaswbR0OZFi4gb8YQIvMGtUx787cUEq4NTNpWMyVhE/ECUztps28VZFbiJYtWOyuJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj+xJgEp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4349d25eb5bso5220375e9.0;
        Tue, 03 Dec 2024 12:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733259188; x=1733863988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcYkZV2v/0D/b0Rbyi2m87m91Wb0IUp9ItaugSAHWxk=;
        b=Hj+xJgEpt1jquLdWncxd9kZrE6k5TXmOOFRcs1saTnTkmvDeUXfRhqCQ7VDwhQj6AY
         Fz7rYk8GTb7yYpWvmSLOh9Nhf0DPQ6aKT/7X7gh3bCwVtt+sxkM1S+99Q4CL6T73ihxm
         dBizYWOT+Ea16AQQ6Oh5N7St+PZ++4jRBHO2/x5yo0y/Aq3sfzwcQpTwxtR/H56z80ro
         TpwUR1aLhj61Ub3cNiqsaYKzf9tIM2yE3+wAE6C4LDxhwRtaA+4WbAOcsTxmfhRE9p4z
         xEsvGeo1VfEIpp7K4WHuO7SZK7h5/4LbZwjph1ObzeftP94lAPm2FtN5SrAcmlK3RsDh
         Ik4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259188; x=1733863988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcYkZV2v/0D/b0Rbyi2m87m91Wb0IUp9ItaugSAHWxk=;
        b=uKckJZOyXnB4HSVC8Xgqs4KqCRQwSURtnOuoOv29dN8QE39GpALsB3fdM69ATGdVT/
         RSJQzq335J+Q4LJ20Z4zSk/ZGLBomhSJMufwfmaMz4s36KLfhEJ7QeU3z3iNsxu2OWiu
         wH53tublYkCX5ENDd7z/2/PLQfx7gHrNVnlnqah+nCRXY6C4zwYFk3ytRDVBCXJqPQCg
         WgGjoBLlspucEcVtWaN0kyo4LzkFedBWxqXKp0oogTKS/uM+CfbgSqIofAkAiiEpQIDS
         vj+vs4pWXo8NhUWTgv5d23c1nOGr5YJPHrd2fp8P1rTnwV+DzzkwyS2hsgw5gDVjkdKd
         Uucw==
X-Forwarded-Encrypted: i=1; AJvYcCUrV3znYpIfaR0BvHxAQro1YDZMbMW9NX+mOYb62poHKt1IuiaVcMtWR842XLl2kMD0xhsNL+W1vig=@vger.kernel.org, AJvYcCWg4vOjn7kUDqjt1vbBtIeBjmym+1yya1/VOEzQ6olpuh3z9sGYTmXQX7oMLC8O+1hKWbE9Yi29mVOH1XWg@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDgdnDWhjEYrbydB9lUACPqF/bfuv5VZxIxxt42ECpaf90I8U
	LKWyEP/Y5TPUFPFxP3PbHlQyfON2WgS9jpzSbWs8OasAZ1wv/JRu
X-Gm-Gg: ASbGncv0OJFXLjA85G+UkWmJPLdMZLPbC6xmEREEnNpRmkjATvXEj2zG2mdK+Rf854v
	avQOZDf0f5NBFgJCnl8zpNgcq1am1ZKXwXKf3uQW3kFxB2cL1qwYYDIzsNGWjzBc4zelidHt/gT
	J5zDCRGx3Rs4BKKWOZJFNltkvkgn+V+3zfFd7gxXrS4/OTlUkgsGyYRW4viuZDGyfZeSRw3mdmy
	K20bjF7XBOsuzmxWh1z6EG7i7aH0rpR5KRyQpL0wP3kLp+DzRfzqZhokj8M9TjwNB7VCSW/Z1V/
	m/ocV3B68LJekVsli79F0+eG8/da
X-Google-Smtp-Source: AGHT+IEK9CvgdgDUFk83v1wV+AV+MO2pq7Dzf7qbT7cfmnId8BTzI/AHIpClzwr7dJhgMR191s8mYA==
X-Received: by 2002:a05:6000:1a8b:b0:385:e16b:72be with SMTP id ffacd0b85a97d-385fde34e60mr1107170f8f.14.1733259187746;
        Tue, 03 Dec 2024 12:53:07 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ebaf3bccsm9042750f8f.68.2024.12.03.12.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:53:07 -0800 (PST)
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
Subject: [PATCH v3 03/10] iio: accel: adxl345: measure right-justified
Date: Tue,  3 Dec 2024 20:52:34 +0000
Message-Id: <20241203205241.48077-4-l.rubusch@gmail.com>
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

Make measurements right-justified, since it is the default for the
driver and sensor. By not setting the ADXL345_DATA_FORMAT_JUSTIFY bit,
the data becomes right-judstified. This was the original setting, there
is no reason to change it to left-justified, where right-justified
simplifies working on the registers.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 0b613f5652e..11eb0ceef39 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -184,7 +184,6 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	struct iio_dev *indio_dev;
 	u32 regval;
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
-					 ADXL345_DATA_FORMAT_JUSTIFY |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	int ret;
-- 
2.39.5


