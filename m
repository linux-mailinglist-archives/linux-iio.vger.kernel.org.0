Return-Path: <linux-iio+bounces-10271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD58999273D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00481C2299E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 08:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F26718E741;
	Mon,  7 Oct 2024 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyPjUdb6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D060818D637;
	Mon,  7 Oct 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290290; cv=none; b=EU8cZFdDWgRL0tmXbUqVn3NoMpZSAML0vQzBkuzHiyByOrIhU39uU5jtejZ0+47AL2gQ0XhRGh8o+haVdFAlHC4KwlXu1oNSe90JZlaCumAbGw79LRzRHyFksIjvlBgc8odq9TkOCbx9n2zn62lsTv1e9SVyOBM2otlqLjJDD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290290; c=relaxed/simple;
	bh=mIojD9CDR7umMqrpnB2F3ciGt1tvIMi9E/u0hIezCWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ieCjfClBfOvrlr9me1uxntAHThSoRjjQ2Oi6XVDHKRKkpo2XnmhmnLFTh3ZUhohPKXGoOGynUNNAO0vfMwiY6u2YKuref+Awknrab9/O2GDyvsmp/7+GuGYsfekTWFPHH4Xj31KQm52uXdlyRgNBNW3pP6y8LkMGgHzY/1QGb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyPjUdb6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9951fba3b4so123672666b.1;
        Mon, 07 Oct 2024 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290287; x=1728895087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKltXJ63QuedW8DsSUo0BYVkH+UQGKq0Hkk8QNeBeDg=;
        b=CyPjUdb6oqCmnPR35JuiJMG3UmNbrRH7HBcULvu+Srkgb1mlRVQVDFAre3UAC1DQLE
         l0NOS7w0LHhvRu6+pDb/m+tsaykZlLtFUaxG+8S+u65nyQWrftIAv6vyMr7irpC9b2Dx
         fMowwhyfVWkwJB+ZpsOE9YV7L3jB+b98LN4Jhbr2LqKipXToORl2yGx6dJyMDd9Sn3Yd
         EHfm3+hqxCmSpb+VrkS0MtGJGqLKcbRzzvuAlv6axbkyNwT+YJXkUFZUZivs2Iw6PGMi
         pRPJ/VzixsrDvXxs4bAP5UdRgsMgixDeFnx5FRgIbmxpWWlM2WWbrYpEDN/j8wxFt2UK
         ItZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290287; x=1728895087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKltXJ63QuedW8DsSUo0BYVkH+UQGKq0Hkk8QNeBeDg=;
        b=hv514cm/ZdHHrYmf95HEBKqx6weTTLsOQuN8iQYic3Z6j4AfEfSLzQBVwpOvdcNQVq
         mEn7kby0ZqjM9r/TLGKCS/AIsqmTJ93O1IPp1LV+DUh3f0XkbcO8SO0qaLsRP0nES4Xx
         bhYWXih1r1Yp5ke7H9hQtP0nMUnaXWpVAN0JklFkatx41ESxrlKL8TFozcT2Yr+OR6UL
         UbscwqhcYj1+RgSZrbuRyccTyuyWH16vLlInRyLKOPx6xP4ZxRw3VEJRIm0vl6a1WybQ
         Pq7aVUPDSz+AS/2pqxN86jhyxhy+6VhnmpwRRVPQnZHyPPjk+xQixLHpXJjVnLn4eEkX
         5MaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6fspWrwknXCaqmFkb4/6hueYXrDBNBIIjW9BF28dgkBR16zNNGudkAdCDU5aEMszqwPOQF/ndeZ1DYg==@vger.kernel.org, AJvYcCV8hOfBpb9HDU1dIyjB4QpMnxVBKoYd5VTW4KUp9v73eHHvo6FrprSFiqSNTegZRFoFh3HZiY6hkro=@vger.kernel.org, AJvYcCXj98uW2+EboeIpBcL6MuzEOmGQRo/LAAL9trFxCkrNyddkz2cFTRgGoeg/20EPyNMXsHBaNat1TUjN1RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnsjc1Tu3B+gKRlS9MFb6UJrRzo9hYiCqW7o3qktCBGmVEbMOX
	y3KPy41fbqX6aIUeRI20zTbi3H6EG2Zs1PzHmpTqwR4xCsVSuNLX
X-Google-Smtp-Source: AGHT+IHowlj9xEF88dnf54Y6o+cqTSCDpvredrMjpaDbjhyspMpJEWwL7BumMGw6mcaRzgRxFQfWig==
X-Received: by 2002:a17:907:70a:b0:a86:7ba9:b061 with SMTP id a640c23a62f3a-a991c02397amr1249862866b.64.1728290287045;
        Mon, 07 Oct 2024 01:38:07 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9953d48594sm121254166b.176.2024.10.07.01.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:38:06 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 07 Oct 2024 10:37:16 +0200
Subject: [PATCH v2 7/7] power: supply: ingenic-battery: free scale buffer
 after use
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-iio-read-avail-release-v2-7-245002d5869e@gmail.com>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
In-Reply-To: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisa.roman@analog.com>, 
 Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, 
 Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

The iio_read_avail_channel_attribute() iio interface now allocates a
copy of the available info buffer that must be freed after use.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/power/supply/ingenic-battery.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
index 0a40f425c27723ccec49985b8b5e14a737b6a7eb..3db000d9fff9a7a6819631314547b3d16db7f967 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
+#include <linux/slab.h>
 
 struct ingenic_battery {
 	struct device *dev;
@@ -79,8 +80,10 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 		dev_err(bat->dev, "Unable to read channel avail scale\n");
 		return ret;
 	}
-	if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2)
-		return -EINVAL;
+	if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	max_mV = bat->info->voltage_max_design_uv / 1000;
 
@@ -99,7 +102,8 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 
 	if (best_idx < 0) {
 		dev_err(bat->dev, "Unable to find matching voltage scale\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/* Only set scale if there is more than one (fractional) entry */
@@ -109,10 +113,13 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 						  scale_raw[best_idx + 1],
 						  IIO_CHAN_INFO_SCALE);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
-	return 0;
+	ret = 0;
+out:
+	kfree(scale_raw);
+	return ret;
 }
 
 static enum power_supply_property ingenic_battery_properties[] = {

-- 
2.46.2


