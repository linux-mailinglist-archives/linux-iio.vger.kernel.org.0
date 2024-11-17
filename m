Return-Path: <linux-iio+bounces-12348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA419D050B
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BDA282260
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636EE1DD0C1;
	Sun, 17 Nov 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpsUFiXK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8BD1DC198;
	Sun, 17 Nov 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868103; cv=none; b=P1NzzvDAn1/XSgXmejPaGUlB/2nBU0I+MbfHrXGjHo5haR8ufBmTvGKBZ7/FiUF2WVUy/qA+8ucB1SjyWHl2hkKWua1CsSAxWIJ//8S5Nyw9sIKeBhfhWlFFKZYHuTqCz5kBAkotwfXLAKnOvJqXn3FiUX2M8sd4MCVylkaEIqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868103; c=relaxed/simple;
	bh=sCjWcbEyD7LriiRtOAzp80ukkSkCm2A8Q8W2wmqD4rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7Ga7Mf7GTksLjxhl/MJDzFOiV8GneY+gsS5qj6QH4LyIyNefRXfJK+PzyDrzlgpVzVd5i4A6aGLODmduqWKVvJ8V2u5hlkTcVb3+l9zcrOphScbX6ceTaHh84gurqZId1Xa/syNzJsp5au/4uSI+JbGwCLC3H6f8u+aSDTFiG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpsUFiXK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315b957ae8so1868095e9.1;
        Sun, 17 Nov 2024 10:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868100; x=1732472900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuMbsXp1aimZf7eMQWmAB0t6+KXECwYUsZhziywkPVU=;
        b=gpsUFiXK3Sdo8J8anK5+pCTb64QGL2SakQkf3yRi+qFCLSdqO3AZuZ9a+kjJI7frRD
         eacVRf2HXZBIw9a0peSycmmWvQ1UrSHifxAE/va9S4/1UDMLhMtabHMFpZfSy3ixH8IE
         fffcXhV9FdIppE+eWFZka701j/lNGHTJjpv+b7/Io0neLMLRBKGBEroU1Zac4UMyMbLg
         X8K5eBwVlRS4UalwLuvnp1lmhyshszSjgsV6pptZQmwLel7/TnGJTiHyM3BzH9jDaMnR
         EooWDUkH+Ci8i/2XWPDfcOr91IsN7uZ0a/K5M1YP26kh+3VxVwdRf2fyk7G3RlPAgcCx
         MWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868100; x=1732472900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuMbsXp1aimZf7eMQWmAB0t6+KXECwYUsZhziywkPVU=;
        b=SOGyy64vWzQheo64YYzCeTgqAKKbuGe93A7NUd9LNMwJbOfqniY6GKKm78BYc3g8yI
         +3gRqT0kxf+6r51YotNocN/ODETEaNE2HwXPG6FdOOom5uLn8lMRO0KXR/iBCJxDODU3
         +rFOgu4BxXMwxARliTgAUgj7RZF+PdtPOMbW8IGzAG9x5bVz4wrbLgjW4D4mqVqcIwFC
         d6X18OSbtQ0VYMp5zB8H/VmAtYAH4jX1+54l0MXT20FhcGa0jsKDVsjhNcIfJc/qjXcO
         BYjaJQQqYyOGh5K/mEEFi4cCqqSKbavwM6ndRVha3PFdBLTB0xXjZTqQm0H7KK6MWS9x
         cFjA==
X-Forwarded-Encrypted: i=1; AJvYcCVGMl6/Tqo5Qc5Yg1M3rDBiPdtDSmZdI5jY5IT1InKIJqsau90221kIGOjdCbI776PAE2I/Q0K//Dy82nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1LoLmi7FiZi+VdJjmhTHodX8p40TEnCKt+Retewriza0qFqbV
	rwvxAQRyS1Ml08fCI7IWiztKcCi792yKx++SVzAZxYBl99eAFlsH
X-Google-Smtp-Source: AGHT+IFrXlcEfnDyLN/DAOYLUuRIvqP2BsiP0sUcBuIMY8pAFMAxclH/PGeSWt2e+t3CSziG2fst4A==
X-Received: by 2002:a05:6000:400b:b0:382:4538:c0d with SMTP id ffacd0b85a97d-38245380e2bmr506027f8f.2.1731868099749;
        Sun, 17 Nov 2024 10:28:19 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:19 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 05/22] iio: accel: adxl345: measure right-justified
Date: Sun, 17 Nov 2024 18:26:34 +0000
Message-Id: <20241117182651.115056-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241117182651.115056-1-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 2b62e79248..926e397678 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -184,8 +184,13 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	struct adxl34x_state *st;
 	struct iio_dev *indio_dev;
 	u32 regval;
+
+	/* NB: ADXL345_DATA_FORMAT_JUSTIFY or 0:
+	 * do right-justified: 0, then adjust resolution according to 10-bit
+	 * through 13-bit in channel - this is the default behavior, and can
+	 * be modified here by oring ADXL345_DATA_FORMAT_JUSTIFY
+	 */
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
-					 ADXL345_DATA_FORMAT_JUSTIFY |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	int ret;
-- 
2.39.5


