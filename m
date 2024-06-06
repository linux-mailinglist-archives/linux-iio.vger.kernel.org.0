Return-Path: <linux-iio+bounces-5946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5EF8FF6AB
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FEB1C236AF
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCFC1993AF;
	Thu,  6 Jun 2024 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVVtiyy0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9AD1DFD1;
	Thu,  6 Jun 2024 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709037; cv=none; b=pXSKPnar5sUWLeivc3kcvyQKEzx3lxlktqSd2BpjwFvH8tDOE5xGby0cfRvPVuThP0vntdWWposz6OccTzM2CGUx4Ty4vYOk6Hqs1IdfCd1j5LJyKbC1KPDGgpsOWbwSbojqgZN4082Rnog+WAEl/MEyZzvVijh76rWjcJloYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709037; c=relaxed/simple;
	bh=m2IKnODjMy+OgGSHaDEHUWLLYrgrKmuucnLbTK0kx/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nca1S7qvHEsZsBHr780qiZpRII2hIzoD4cV4wojxfvgdDkhFWNUbhP2NZJxDnwDHn7WnPETwAcKen8Pv+KMhDVUlxSV5mJfpsVUf9hiz2tiwgpE8aA9Tnl1a7/Hzbbq70jJIB4lbQOOTppg8UIrhH0HDVNsAOVrns6ev2VpTgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVVtiyy0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52b83225088so1738366e87.3;
        Thu, 06 Jun 2024 14:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709034; x=1718313834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JruR15ozbEHNR1YoZsNkt40bHl56igHmevH/tHHXsU=;
        b=PVVtiyy06qkKHGS06BdLceAmLh0gW11b44Xb0udYNukisrkiWOhqtTJwNElPexVHUc
         TLeRI/DnAIAL0U703/V9psJANsMhbtowLimpdmkUKl+za3pFineKS0zwZpDircvbEp9f
         KRFyqeJQMA7JxxSgZJV9gX+rTRr/+ikM2cPWX8V6dRZGTQV7t8/EDcbxeKG/LA2gENZ4
         OPZOdHbr3H0+gGZkTwYroZ7sHoOdcrDbwv2epfDplqoVNrPeAZ4XQohtaQ4xUL2ivWz6
         +nI8W/JzLFUTttTl70AAgV6/tADNLEVH4vWV0lw9bQWJQtQjpg2rlN3ZW1GATHLnk77c
         8g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709034; x=1718313834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JruR15ozbEHNR1YoZsNkt40bHl56igHmevH/tHHXsU=;
        b=roFZIKPQ9rIrznjCzCoWJiWitjUZPA/l6sTTGMrAf3LkkaxRVaQ1Jcs0/fe4rYyqMd
         WUYumVE/oPR74pezy5RrSUbLZQkdAbdj6p8+ZzKtRxLY9gnnewL44ZAsdD/nnC+lL9Ns
         gCxiy8uN6VYQTgXVi8mYgoW4/zWlUwJkFQBmLw0hicGGdFl83AvtUkK+5VHJhH9ZFTYX
         w7gq+obPa1SbjWjNtohzmhGxrf1V3/QqwhPzmwCzSAhRwIq9jdqTTIqRwvnkH7wuU0Bt
         L2zUBbe8Ao5zDKfrpK0XLG5y/OBS0P3sXzhB53PXvM9m2fnzp9XdCriYObYTBJkYqo2Y
         yDpw==
X-Forwarded-Encrypted: i=1; AJvYcCVHZEQ8iKh6/4IfwrDEgIWkwx+RWWTtRGtqaSe3ZZ9L52lFTZyfxvoOL5bsO0bx17gckVm1lABQ8JzZ84211l5YbdyviHzpW+5eieJ+syiFI6L/4Q7ZlO5GwqvKz1JkV9JB2OZ96idy
X-Gm-Message-State: AOJu0Yy0fLklzsJMYBY4QtIczFibwXm09FjToQVCSobht94hiVmqtVAH
	5EJPlOg6ChtIXLTxMA6r4wfsy6ozhwSI9iZfMZkr4/rIEEsrBSw4
X-Google-Smtp-Source: AGHT+IG3OHlUVX6gOhLLBiGaM4fS38vrvGZDcgO1+ONoR+imGU+E4UulwZfDHk8ZWrxkltai9JhF+A==
X-Received: by 2002:a05:6512:e91:b0:52b:8417:fa95 with SMTP id 2adb3069b0e04-52bb9f85437mr522455e87.41.1717709034124;
        Thu, 06 Jun 2024 14:23:54 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:23:53 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 01/19] iio: chemical: bme680: Fix pressure value output
Date: Thu,  6 Jun 2024 23:22:53 +0200
Message-Id: <20240606212313.207550-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606212313.207550-1-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IIO standard units are measured in kPa while the driver
is using hPa.

Apart from checking the userspace value itself, it is mentioned also
in the Bosch API [1] that the pressure value is in Pascal.

[1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x_defs.h#L742
Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index ef5e0e46fd34..2c40c13fe97a 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -678,7 +678,7 @@ static int bme680_read_press(struct bme680_data *data,
 	}
 
 	*val = bme680_compensate_press(data, adc_press);
-	*val2 = 100;
+	*val2 = 1000;
 	return IIO_VAL_FRACTIONAL;
 }
 

base-commit: b3019fcdeb286b2cfe45e44bccb44dbcd8ff66dd
-- 
2.25.1


