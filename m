Return-Path: <linux-iio+bounces-18327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C238A943A9
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 15:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC20179D14
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233531DF756;
	Sat, 19 Apr 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrrtT06l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591601DE4E3;
	Sat, 19 Apr 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745071007; cv=none; b=GzFNzrTabSrjqjyJBuEtB8U/vahiw9tSzq+1HZe3QuzqYBfsnQXU9oi6dyYWKFNMXngBl8VhWX7hcTdRdK5SCVC/lZTf0yLN7FX+Lvc3SfBZVCavSojYUQYmpVPeCQb5US7hoFCXhJ6NYbeGO4EeAsJNwdfntowiVUTqaA/xeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745071007; c=relaxed/simple;
	bh=Ubbbw15hEAZ+J5L1Ub1FKSI3XNWrOXLdqS9DAd1ONgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhcH4Tyu/s5YujaKrV3OANvUjrMURa8JYhbx98YDWFo4FCWL+jLmRZeL9u/IQFqqtwPvcXmmTsgLa/ejjmBz3TfJs90WMfJQJl37vuXqpLc74cmlgSW3iD+Q1W8e3+p/QQifW9sXUY7nb13oDi9UQ//MoeMGdN3EnNIoWX6SS48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrrtT06l; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5ba363f1aso348226885a.0;
        Sat, 19 Apr 2025 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745071005; x=1745675805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXLzgwUjjblsXqDwVt3NWjFIy+rshNgbw5xBdqozz6Y=;
        b=hrrtT06lJXVAIxITzNZJ7zdPxhodZHC8tEYIfuz1rtvL6N+6D2b0T8QlXi4v/J1jTI
         lRpqvSzeyIT5p1IB4TNGMnEvM6cPvEWXuuTK8mUMfuaeVB1C9MDG79l0eGuwRg6E8nOv
         GvsgaAyoHNozfjHzb/93GBubi7VrMOdgFWdjBQ0xhw7RJYvGxjb1hQoXSpOIX9U59vQM
         u8vzSQlEP+51gfuZ+jClBQPjl6ZJ14oISPGNT6G3eR8Hdoz5kJgdzdxoMPk+F0aVcjub
         5tNR8WUCrl29ZOPK7D2EPDEDtLFxz31OILCZddcV8URCGBjuYRjtc7+g67ZFHGc0ua8M
         9bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745071005; x=1745675805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXLzgwUjjblsXqDwVt3NWjFIy+rshNgbw5xBdqozz6Y=;
        b=XLy4OA2GYU7t5lJmJ2pyBueMKIx5R5Pq7+qFelN4Lc3e7BSO2zlNzTdXKfXAtm2DqU
         eh67tV8wSyepRiNIlGZp31gLu4IRryfybyKocFa91urh5bxUZk97aTvaHAS0EzBNU0Hr
         KCdMUG/trRDO68XgpP+l0+WogI4dGlgJjkkDyDxzoZAeM+03lw+BZNUKtIC3ow9MEriK
         iyZ8zpmP7aCoMWPxECGmYsyiqlR5n0+IJECS4JU9Ij6UCI+zQAHsU9PE2eZZ0ClAl8eG
         YN5XPojzxhDnTuMFl2m2rflxqlWC7rhfy/QouDsHHBif6sYEo42OHA+eSAgeiFU6k9BD
         a38g==
X-Forwarded-Encrypted: i=1; AJvYcCUR+smzRulaNWq71mhNkyIv/jev1Quyfs1H4PRFkBBIUdJBO3VX7t84Mas8mLhu0yF14F0U/hd0IE4=@vger.kernel.org, AJvYcCVOlajSL9Ni8r9d4rHsAEN0m0eXDEUs/euBZuI04KXctdYTgS/ZJ+6aiRsSMrnVMXDukqAIExNUl3GKhBzl@vger.kernel.org
X-Gm-Message-State: AOJu0YyeH7lSw+AWOtv5SLK8ls7cjBQskTLfDH77434ljTTDNE7jcCXr
	UgUUeCzh55C8u7dkVzRFjx2hu24Ufd19SFAj2AiQw7Ijxrvx8i2R
X-Gm-Gg: ASbGncsD+wXgMpWBNlCH6tmN1fV6YZRLauDWgV4hiZN13dkyaNQdw0Kjrov6swfDYDE
	2xJGKSzbTX9Y67hpwLoB+U0IcgjiiAGz4VTQP9W6CNlOLQqjsKNhGfO34e3rNF2jEXjzQrYmxFe
	6O34vXl0ZdACqzsjq72o83CLsYw4rDGnBhImrbLouR8adXo/GswveNDfrcwEow8fUinQ/XYXJ9s
	w08E/DSOCAd6lTWiXPNqS3AhQQe21elVU2TlaDD9of73PllVsUWgb0SabPCpQJAy880aMlAeE6q
	ghYVY3tirCJV5a7e85nIFq8+WGJ5yCdJsWM5uhqcC08uax/LAl4rwRI=
X-Google-Smtp-Source: AGHT+IEY8DzCnNRzJzQfqd4P+slFQb/ni465buefMU1Eu3pZIczpyhT3BmlaRKBhgbKTouNSjsq4gg==
X-Received: by 2002:a05:620a:4694:b0:7c5:4738:8a1b with SMTP id af79cd13be357-7c927fb19cemr812146285a.28.1745071005256;
        Sat, 19 Apr 2025 06:56:45 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925ac4749sm214350185a.59.2025.04.19.06.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 06:56:45 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com,
	sonic.zhang@analog.com,
	vapier@gentoo.org
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 5/5] staging: iio: adc: ad7816: Simplify channel validation using chip_info
Date: Sat, 19 Apr 2025 09:56:38 -0400
Message-ID: <20250419135638.810070-6-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250419135638.810070-1-gshahrouzi@gmail.com>
References: <20250419135638.810070-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the channel validation logic within ad7816_store_channel() to
leverage the max_channels field previously introduced in the
ad7816_chip_info structure.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index ab7520a8a3da9..7a59cfbcc6e33 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -204,17 +204,9 @@ static ssize_t ad7816_store_channel(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (data > AD7816_CS_MAX && data != AD7816_CS_MASK) {
+	if (data > chip->chip_info->max_channels && data != AD7816_CS_MASK) {
 		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
-			data, indio_dev->name);
-		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1 && data != AD7816_CS_MASK) {
-		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7818.\n", data);
-		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0 && data != AD7816_CS_MASK) {
-		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7816.\n", data);
+			data, chip->chip_info->name);
 		return -EINVAL;
 	}
 
-- 
2.43.0


