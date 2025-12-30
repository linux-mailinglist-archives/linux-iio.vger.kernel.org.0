Return-Path: <linux-iio+bounces-27427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 608DDCEA9FC
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 21:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 219F23042291
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 20:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE3827700D;
	Tue, 30 Dec 2025 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnhTkbX+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6221274671
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126940; cv=none; b=HpcF47iS+Ewv26+EBRkFeZO98/I1Ko3A964NUTpRlZhTUxAk82c8kXWc1JM/lyO+gQDuJOGmivGyj7wPjXREq5XpHL3w8Dz4pGT0wF0BZS792EDDFybrWP5joDalT7ppviejEM0Hs24mqVY+BT23z6RIkrWNzmW1EKmLD72BnVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126940; c=relaxed/simple;
	bh=KhOG4N7N+3XuIAad+gpMd5RqaKSj5wsS75InoOIZgYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJBM+lY4cNd2qUiJdDUGs2LkxVx7VYBozmojYwYvqc8ETe3tgWRfUFlN2TTi+tn0UjHJcmYaQhT9Pe3uEf1+Of82rxkrhlDB88bnSlBLsn7g39Mjpw39Vq4CxMpsL8F102zfxA4NEoiY3fK+wwmogKXEnY7ZPvudUunnP7ucZDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnhTkbX+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so91492105ad.3
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 12:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767126938; x=1767731738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2JkxCT9+3YP4D28HHgDiKativOskj6ucx01bNwJC+c=;
        b=bnhTkbX+jA0NV6KzYPOMEAA8dRL7z7i9P582Tngvf2MO9IxvCOb2NJ0ico64AdfgdM
         YSPK54oLcgt3tkWB6LZjBMO2iQr8Cc0QPidAY8bq7Rt5Mq9O6wsByofADDBpBtG/KmA4
         a2wYEWerEazVT0rFzo4s9lmtDT45zxeXoQp64o1dwyXeGMharkOr9Vu4Uvq2VG3fLDA6
         DeCCCevgp0R+zMTJBTlbfBSip3Cr2XpbcSjJqURSSEfFZR0aDqnjEUu3E4kn+In+aVHL
         HMjpQ7ARhmj670TXYPR05Q5+alEabyMPfCLktPaPKeA9gTuSY7uq+7ehWh6dfPUhrsiZ
         Lzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767126938; x=1767731738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R2JkxCT9+3YP4D28HHgDiKativOskj6ucx01bNwJC+c=;
        b=ngMMzrgUMvzbg847VrDybMlUaam+cII5gmR2GT1fC8cFvwQH5xThiWaZrEUuFMCkY7
         WfP0/0bp7PR0IjjC9yEhN8pXar2WiSnq1NuNFiXqPelOWk+d7yiaeB6JWTA+ycRvMcWU
         B1Y1jFIH2dLI0M78UETX08FlpYsFxHs/T8Hcpif1o1SHkRRU0+QeaYzy7N3maHna90WN
         ftn4Xq8XIHLK7JOU8Zq8sIdrl3SiaAvSRM4f4iKnO5x4P59n7y9AUusllr4XHyJYvmCC
         /mOCQsGAzg/0QNdIs9Pis+ZDep+yK7n8mgz8Tqo5Ji9UkJOjcZK6xpvlLEMEjkbxYQtn
         8t/A==
X-Forwarded-Encrypted: i=1; AJvYcCWCGMsLsA6CFAag4qvAmFyVRfSLdBqs9k9zhQgQA0DfNujasjet4/hTO1aGgcr9+43hLaaKd3jz39s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRmMxdxVGJiphvPDyE1ifaFyQ5VdXD4luoOSZ+i/XFI42Q9Yz
	scKl4vw54A/2dPUKO7py3+1GyYzUeJVN6qOIWaCT1QaZmfAw7SNgxwjj
X-Gm-Gg: AY/fxX6TpjqixL88nS2rd0iQOAH42/+TWxllQ3v0ULr8+L9mEvoC83y05voDLHwD0Q9
	LwdBP1W0M7cvAMcPTtWMv8RwkbFKUjN/bc0PH3AZpEE28pDWd2rY3zk4Ah6+V49izaAEYvyFMSB
	yBQEtUsiok7PqPcxObybn6MsU441ZBf+FgvxB4hFZkIinz29erESxLrgK0TVazCL5lo31zH9Xcw
	fraLizqkVoWjk1EZy0ncdCVZw5U4m7Yi8UBNNAgnwoRjF3lorV/2Dhg3WNg4My2OlX7BTbgMe0O
	tY2LsyNltRLn31Kw3RR648g9O4LzeW5XmWcANZnKHG1l06aiVJhXU7wD9Vj6G+OtPWDNYfh2AdW
	DF4ZGZccjRwKmoowHkH3zWu+Q87vXBJrs3ASYS4g7JdTlHab7+s3Dh88ssWh7t+cKvg6YD0fPnL
	mbmdW6At/JeP82w+S+ezOttBGkbI5rkGgRMOxffG28TulvFLwlDvcglRX6nwkLSeA96VJutNtvk
	LRMM2THlcxBBtL41edRWQDdodTIoIe862PL+aVXRzsF7j+4nUh5FHWtwb3G1rhYLZDHtcsX4Xu5
	oTXzlKU=
X-Google-Smtp-Source: AGHT+IEr7/wv3OVwsFVrG2Eawia8meD5YSTnGD52R8yUpWj3DwfbpL64WGbA/Oz9enaVheaZVHOF+g==
X-Received: by 2002:a05:7022:6291:b0:119:e569:f61e with SMTP id a92af1059eb24-121722e12e7mr27372018c88.23.1767126937719;
        Tue, 30 Dec 2025 12:35:37 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.75])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c23csm128074981c88.9.2025.12.30.12.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 12:35:36 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [PATCH v2 4/6] staging: iio: ad9832: remove dds.h dependency
Date: Tue, 30 Dec 2025 17:34:57 -0300
Message-ID: <20251230203459.28935-5-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230203459.28935-1-tomasborquez13@gmail.com>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove dependency on dds.h by converting custom macros to standard IIO
attribute declarations.

Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 37 +++++++++++---------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 4bb203a67046..aa78973c3a3c 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -24,8 +24,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include "dds.h"
-
 /* Registers */
 #define AD9832_FREQ0LL		0x0
 #define AD9832_FREQ0HL		0x1
@@ -238,27 +236,22 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 	}
 }
 
-/*
- * see dds.h for further information
- */
+static IIO_DEVICE_ATTR(out_altvoltage0_frequency0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
+static IIO_DEVICE_ATTR(out_altvoltage0_frequency1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
+
+static IIO_DEVICE_ATTR(out_altvoltage0_frequencysymbol, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
+static IIO_CONST_ATTR(out_altvoltage0_frequency_scale, "1"); /* 1Hz */
+
+static IIO_DEVICE_ATTR(out_altvoltage0_phase0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
+static IIO_DEVICE_ATTR(out_altvoltage0_phase1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
+static IIO_DEVICE_ATTR(out_altvoltage0_phase2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
+static IIO_DEVICE_ATTR(out_altvoltage0_phase3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
+
+static IIO_DEVICE_ATTR(out_altvoltage0_phasesymbol, 0200, NULL, ad9832_write, AD9832_PHASE_SYM);
+static IIO_CONST_ATTR(out_altvoltage0_phase_scale, "0.0015339808"); /* 2PI/2^12 rad */
 
-static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
-static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
-static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
-static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
-
-static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
-static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
-static IIO_DEV_ATTR_PHASE(0, 2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
-static IIO_DEV_ATTR_PHASE(0, 3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
-static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL,
-				ad9832_write, AD9832_PHASE_SYM);
-static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
-
-static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
-				ad9832_write, AD9832_PINCTRL_EN);
-static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
-				ad9832_write, AD9832_OUTPUT_EN);
+static IIO_DEVICE_ATTR(out_altvoltage0_pincontrol_en, 0200, NULL, ad9832_write, AD9832_PINCTRL_EN);
+static IIO_DEVICE_ATTR(out_altvoltage0_out_enable, 0200, NULL, ad9832_write, AD9832_OUTPUT_EN);
 
 static struct attribute *ad9832_attributes[] = {
 	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
-- 
2.43.0


