Return-Path: <linux-iio+bounces-15829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C57A3D710
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856A43B7404
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604371F151D;
	Thu, 20 Feb 2025 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8wPpLT8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EF31F03E5;
	Thu, 20 Feb 2025 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048164; cv=none; b=g1xDHOa99OUzVBgCtyIxwyrPOFVmISpgcusf8R5j6BbIFseXaJaYylrtEm6BN48Yf1xRY/mxRKeThGeHhWardr8fueJWqeCKNdGnesb/oCNjWMReu7LV3cJhv2uZi0X7kfkzvZaK5z/cEBGNaRgExGLEfKIPM4oR15fdYYCrIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048164; c=relaxed/simple;
	bh=4lgqPxMFIxcu6DJtyKvsa6jPFpK3C+Ewcmj6hhpH5wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SmnBA1adFt4ZqlgglewJ4653zBkvpDf9iUy3xshN0kV3gZlVKbyg0XfcWTl/2+nTeHbnY+tbM5H5iPjouqeWOT7PT2dM1FE6JwDK7D/AtCp4BWhT1F9RxhvEGflWftXivsMgJIBtUyngT0ciPK3K02l139p5ExuNewQU/DVdcG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8wPpLT8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb88d2b67eso9750766b.0;
        Thu, 20 Feb 2025 02:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048161; x=1740652961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OpRgAIuBhfsxGTEjf/p9nsoY6yTj5Mb2FMWgMOeJw4=;
        b=g8wPpLT8jlwW9g3Hm3YMP13TCRKythq4GFmeANtsCnjKjwH09usYs97iLbE/vO+bwJ
         56N3CGl2zSl1pQ2nNuUYX1rfMXqCqJbylLhrEosJGjrCSkJcvCjKwnJBOxF0B6RB8tvK
         KMMVFk1BbMq8RTXabEt/ZulIsgA7YuwTHJRdoYbG6FZMK1iT3EqntFxS98/eHD5jiO5x
         HLoCymBhjpVB2AcVA1qmKUkNHb7XxD/Mw3+mb2giINSqcTJPO5L6XTNR0d0qq2hfMl1O
         28iXq4p4nQN4iXS6WcYkY5mrGmDCVT4wasEw/CUbhPYfuGCKjw+IzCs9t4u7PGbDYDcd
         ZA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048161; x=1740652961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OpRgAIuBhfsxGTEjf/p9nsoY6yTj5Mb2FMWgMOeJw4=;
        b=ORgfw7/bTyUYd4O9I91pCtqInULMGWF+uxOhxxzDPbtpB8qwC2WfzmdJAWMyXhvk8M
         XA2DQruK53FilDH6jEcIyryooUwyDCJFvmQK87kYROC++4SQ+rIUJagSW2cpSO7Pgd6p
         EZ+mGNntlVbOPnse9OWStAcw9cZmDbeiswZYKUDmQ5HW+YvrU8MYMN+B+O5akG21bKvY
         xzT/QECdgYtrT/tbiRmoS4ddAZPLkop4WtQlzAS1mQwdlgxn+J3Ds1XyuAp2cO38jpS2
         k2SQWJRzi2r8Kp9b/4fjwRJwi1VRReBzZncFsp43+wKMMLqJ7kXMCaMGQ2MlKDqkbdLs
         lpGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9J5QfbEiGY7NHNU08fauUZkM+8vrE8lPwJVwn9zLIfCQUJeOinEwZonHLnINi3EMP83k1jd12yIMN1EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPKixKCOLWWMb5VpeOJdFIBgyTn5Lt81vU3sTuKvjOM+L7c7FR
	Z1O6yAxnALOfKN+yjRdc7tyy2jHjTCIBNWgWt9C1CpksE4kRMzVBkIrzToIq
X-Gm-Gg: ASbGncumn1FtYm70MzRvk1YsMM8rtAUHCRCO4ZGR8gBGStsibNl+Xda5wFW7BYyzByY
	1GfvrwcePYwMxPuXJ7TxyYjOn9TyplWJxEOzjBwX7ZU58aY1hYTOnVmymbwOgACAMZ0fXrk2VMW
	1JfOKZSE2M35c8nNFZ7GsvCf+8hQjcSLXJ4ywdJpaLR8oDi2YtQe7bXEWsRRldX5qCr5Jem7AaI
	cwW5kW4GpUIXkgYdJFVGb34Js7XvYR8W9vbWSI6MUNOcLp9n9lpiZsU0P45szceQW3yJOENq9Si
	Zpje+qqpsJj/JZBagdAF4R8vH5Jhdxvm9qz8Cmigb9Mw9RVTWyhKSZQSzWP7G/OYD1mjuA==
X-Google-Smtp-Source: AGHT+IHnFoe6bIJfsSDBY7fpovozMf7SUh1HcrEqkNrZXuhExvE5KIsUs/T2iEUh7f+0Qg6FZ8yovQ==
X-Received: by 2002:a17:907:96a2:b0:ab7:cb76:1b0f with SMTP id a640c23a62f3a-abb70e2a93dmr799471366b.12.1740048160491;
        Thu, 20 Feb 2025 02:42:40 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:40 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 02/15] iio: accel: adxl345: add debug register access
Date: Thu, 20 Feb 2025 10:42:21 +0000
Message-Id: <20250220104234.40958-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220104234.40958-1-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the possibility to verify the content of the configuration
registers of the sensor in preparation for upcomming feature
implementations.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c24692c51893..468d562de227 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -202,6 +202,16 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int adxl345_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	return regmap_write(st->regmap, reg, writeval);
+}
+
 static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
@@ -467,6 +477,7 @@ static const struct iio_info adxl345_info = {
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
+	.debugfs_reg_access = &adxl345_reg_access,
 	.hwfifo_set_watermark = adxl345_set_watermark,
 };
 
-- 
2.39.5


