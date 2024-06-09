Return-Path: <linux-iio+bounces-6122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138EE9018AA
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C32281352
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F283A55889;
	Sun,  9 Jun 2024 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/R97qGO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5215FBB1;
	Sun,  9 Jun 2024 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976318; cv=none; b=RRrfVofyR5BaiC0wgK8dp0lmPrJ6i3pIjMSzPLc6hnH8ImMlLCNlckFRfdkHFjrVC0w8QjGdks/277oYtqDzdwRFobCuhZijPAtplurt7EebnfRhHXm9Yegcx6FRotujGavDpbbz/A1z6X21NOrqsmJ88Y4ATczEH+szL6UxLZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976318; c=relaxed/simple;
	bh=DQy++SwXyATSNKkyA5DvKAjxCFRXT1GN9A5yTV1vq9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FHo7IhKgk5DglKUBHwG9hvzGVxRxk4NJ4W1ytp0bNJLmyX6uuEnm53oHu00+gjR7QFUea8zx+N53X2TxgSrevLbq1+DuErV00FJZYqKwoFuNrG7TLa1SwR6b627+6dbHLvPc66FH+cCuecswOjnmoIEBdTBO/XAMuxAQPJ2yS6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/R97qGO; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so2661985e87.0;
        Sun, 09 Jun 2024 16:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976315; x=1718581115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNURLBgWnSUQosa2pT+J1wTI3cPFItjzm7xacdHoCD4=;
        b=l/R97qGOimH7HJ7u3k/wAs3wI2hAQlc7xk5q/fyEtHn+7AW9LNqixk96/zDO5COGDk
         MHUIn0xRtyw1KdOFNy0mCnXk/lwUJTVAiii/BikSsSnQfFtX+OwrVAyUVHfbgCQROpcR
         k+DueYT3T7IHuExWBmm0kv0nCrZhsbTdGyCAgSSfRGp+qaU0kcTVhZc1Qb9Xc5vcRhji
         wmxUNXp001nFIwlFgvQKQii4+RnqPgCUfNyqxAEUi+YVr87W8k9T+18kBU3YJonXNIPg
         VAX6qdHJg9fc7VqBTsRYkiw+w8DAjupDhD9Tk/B2RK7TX2lGCiNpulIx0KyZyHWKElxq
         22QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976315; x=1718581115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNURLBgWnSUQosa2pT+J1wTI3cPFItjzm7xacdHoCD4=;
        b=Vn43bkPCp6jZUy20F4ixYMUFS3m0hChQNxhi72ze6dn7pvApKf7xn70zWKXRYIiJDO
         NUtxZEFkjS9A4hdFmbig7/qGwNiUaNPoPBGt/5/HkJHtxZAXx1n+pL9fX76Im54bk18p
         Qc8db949Sx/z1KX3lVu5ItXZoDX1q52J/saU2/fTT+hAXmSIcGAtA9mSs/AG4qxymgNw
         LRnu3rCTFea7ItmwB/lFu9PCdyf5wssDjIYcXGD0EivYc1yCzz3kV+N18nwP7sLcWEUj
         KO2RrBVKGjA2RmH+kMm8JUCCFctNDQRqymqK1Mc2Zbxg0iYSCqCF6Mf3YIb/jRmlfPuP
         ZwFw==
X-Forwarded-Encrypted: i=1; AJvYcCWdxQRItT1WMjnjnpoEtc+za1grCAJEGhCcfO2pVxjnotT2ux9JCLYOVZMJgI/9U1g5EEevb0VPwQTqW4tr7ar/dmUdgMHTNWXPG4HKTOcZvgIzaKEvfroGAL9EhT8Xdd33mSe8Pokc
X-Gm-Message-State: AOJu0YxmXjiMhYCWoVrFj+aMmN6TfDPOxdLUM6RmkBsLmTC19PIjaZbW
	wi1DAA37EMc33lfb2e3aLrfxzxQ90HZcfk/UbjqgHtPc/3KjbExf
X-Google-Smtp-Source: AGHT+IFND5Z6f/9aKPFUiwMQsfgLqbd/KRcmJs+mbUCJFyTlV/mpznTwFixUq/bvRkAYzfc0lrTmhw==
X-Received: by 2002:ac2:53a6:0:b0:52c:8517:c6ed with SMTP id 2adb3069b0e04-52c8517c80cmr1687525e87.0.1717976314741;
        Sun, 09 Jun 2024 16:38:34 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:34 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 04/15] iio: chemical: bme680: Remove remaining ACPI-only stuff
Date: Mon, 10 Jun 2024 01:38:15 +0200
Message-Id: <20240609233826.330516-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609233826.330516-1-vassilisamir@gmail.com>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI ID table was removed with the following 2 commits:
Commit b73d21dccf68 ("iio: bme680_i2c: Remove acpi_device_id table")
Commit f0e4057e97c1 ("iio: bme680_spi: Remove acpi_device_id table")

Remove the remaining ACPI related stuff to this driver since they are
not directly used.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 577237d4c9f3..1d2d5920fb23 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -8,7 +8,6 @@
  * Datasheet:
  * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME680-DS001-00.pdf
  */
-#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
@@ -927,17 +926,6 @@ static const struct iio_info bme680_info = {
 	.attrs = &bme680_attribute_group,
 };
 
-static const char *bme680_match_acpi_device(struct device *dev)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-
-	return dev_name(dev);
-}
-
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name)
 {
@@ -969,9 +957,6 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	if (!indio_dev)
 		return -ENOMEM;
 
-	if (!name && ACPI_HANDLE(dev))
-		name = bme680_match_acpi_device(dev);
-
 	data = iio_priv(indio_dev);
 	mutex_init(&data->lock);
 	dev_set_drvdata(dev, indio_dev);
-- 
2.25.1


