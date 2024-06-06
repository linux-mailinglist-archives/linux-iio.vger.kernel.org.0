Return-Path: <linux-iio+bounces-5915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EAB8FF14D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 17:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9EA7B24160
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 15:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9369197543;
	Thu,  6 Jun 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OFu3pOar"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C937D196DA8
	for <linux-iio@vger.kernel.org>; Thu,  6 Jun 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689265; cv=none; b=S75DCiHg1DHJ3ORHJpZZ/Xs2NzTViFyrEvEjNg142CpDcgXM5TT5H0NuFR5n1ygYRHDVJlBv848ZK9neAfj9rSbcx6X07gVM2R10y9ltbOEYHJeziS34KQ5GvNgvkz/+vbRqcYdj8SGmjt8i63IKbmyyj/+xBxsQcf8Bl2Mhyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689265; c=relaxed/simple;
	bh=Ek8uvkVoQwtrbJBja6EM5Lcgx+Z0IlAX8pZOfk/I1zE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ThL6otg2kDf3ijk4BDVDl/9lmVedkcQOW4/tCkaIZm8Ct2V3zpBCQSozv/IWfNcAWpAyaTxRTZ1y/GDewuVI8fo5d/kgP0F0z/UxWpe9NF9wWnG8truUukCgu3PIlSpwCaLRLDE0DdWK6+NDV4wI5HSbJvHXV9QaXFJj+6C4dVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OFu3pOar; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42155143bb6so11723195e9.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Jun 2024 08:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717689261; x=1718294061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7RAALchSArLdEez8weaABgh2SvVfCvHFLfQRisjhOk=;
        b=OFu3pOarAomchMHRfDAfB7IY9/k/0vnmldvl8dwvgLcEm/bzrGhom4YTL506qbbmcV
         zPd49ny7Zx0zbaCBjdbFT8YwX6++YTqQLM2Shd5dDt4UU+LyhQQgppBU8wpyhddw3ID/
         jN75tacdq8YRG6U7ggVcwT/11hL2jRjJVCcJ7h7ic1FDpoNxNwYxUDyYEyU4CAPFVzaj
         KWXHYg7PGDq+Y/HVH+hmyg9dKykPXYbvvzITTpCrH90GiQcEheEuSWJI8Z0rcuHibzc4
         QMsafZtp4B4B7qGdsWrzhRnednbzRY7P2I5g7hzaYNKOq8wIRy+aruvqNwJB/j+8xtOv
         PpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717689261; x=1718294061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7RAALchSArLdEez8weaABgh2SvVfCvHFLfQRisjhOk=;
        b=ApA2YBx4NcQa8a//iU+9SA8X0l1DzK50sux3w1FLAcnMgvGLP8KfJEEyI3Emepg8cg
         R00TN6vo4jznQ6mVScMjL/wIc4EMzJmHfX41Y6DYi2OeZL+3ogk0TpyY96qbeZ/9e24e
         OG7fZu/qy92x85+vBmRU4WMVTi5u0rCbqxusMn0FK+SjjMUUHJDsCPSBavdjAdecKGJN
         2gUcpQx+rKhMJ9knw6iFPHOF87g+06n00K9WtuXL442tx8WMlQOhBDbB4JzevghOgqM1
         qOnuX1iW6nArveYco+Jq7mDbRE32IOzxVks1PQZ0rYbEgAXj/8rHs1m2/c2Lsypz1N4c
         Sw/w==
X-Forwarded-Encrypted: i=1; AJvYcCVea8PprY8lQ4TnK2TnL+ECsnScSVVt7T1GEGPquFDunY/UZcZYjHr3FExcgrRoiXnEdZHaEdKygbe7SfXxM564s7ZGqA5biLFG
X-Gm-Message-State: AOJu0YzMgkoSEBzOMUVSKD6GX7o0zXMI9ZXctYgEekyyPr5Gr6YfZ+Dm
	7IhM8bVXf0j9GPE9WDiTDJAS2EMMHmVJmwHCoNA37lwTqimCT3+OID/+ErMWjRs=
X-Google-Smtp-Source: AGHT+IGcJ78wf//iyjMcVhRRQucY6jo9NOu0cxE6uq3JHMLnWlhl+nIhsgi75WLvHdo+juV6Flk7FQ==
X-Received: by 2002:a05:600c:510f:b0:41f:afa6:3d85 with SMTP id 5b1f17b1804b1-42164a28f8fmr913945e9.31.1717689261173;
        Thu, 06 Jun 2024 08:54:21 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe366sm60119245e9.7.2024.06.06.08.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:54:20 -0700 (PDT)
From: "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@baylibre.com>
X-Google-Original-From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH] staging: iio: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Thu,  6 Jun 2024 17:54:04 +0200
Message-ID: <20240606155407.499344-1-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c         | 12 ++++++------
 drivers/staging/iio/impedance-analyzer/ad5933.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 6c1f91c859ca..e6ad088636f6 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -109,12 +109,12 @@ static int adt7316_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adt7316_i2c_id[] = {
-	{ "adt7316", 0 },
-	{ "adt7317", 0 },
-	{ "adt7318", 0 },
-	{ "adt7516", 0 },
-	{ "adt7517", 0 },
-	{ "adt7519", 0 },
+	{ "adt7316" },
+	{ "adt7317" },
+	{ "adt7318" },
+	{ "adt7516" },
+	{ "adt7517" },
+	{ "adt7519" },
 	{ }
 };
 
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index b7af5fe63e09..cd00d9607565 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -721,8 +721,8 @@ static int ad5933_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ad5933_id[] = {
-	{ "ad5933", 0 },
-	{ "ad5934", 0 },
+	{ "ad5933" },
+	{ "ad5934" },
 	{}
 };
 

base-commit: ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f
-- 
2.43.0


