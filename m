Return-Path: <linux-iio+bounces-13849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 963609FDCA0
	for <lists+linux-iio@lfdr.de>; Sun, 29 Dec 2024 00:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930941882AFF
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 23:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C951991D2;
	Sat, 28 Dec 2024 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnaIXdt8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D1197556;
	Sat, 28 Dec 2024 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735428601; cv=none; b=RqZnU0rPfIPkKRyD9NlWAMHJs6ZQjyFRNfP8WnSqYkE2SyoBrB3W9xHXTaOz6aback0o8d/6z2MC8veeixck+hd4IyAp6lkQGIctFdX3/yP2sBgztov+Xo1uUBsGd8X9jZb27k41AquZfqW976Oi2SrhtnQtz2LU1JtevndxBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735428601; c=relaxed/simple;
	bh=muD/nJJlClqgww6SxT3wbYOjpIPUZERAZ7g3O/5sAks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nOK4GvJwBGzH8KecNyslytPORgPuXOCWYAl1oVp8lfZ7idfHi3gcS72qVSn8E+lopwNaPeG9qZpMsBaDdcnrbOC1pQYTINK/V66xji+acWbpjdBw4QF2d5py9wFhhlGBUt9YZDttf+rIH1nJZCRTUhxYRcjdOfSfqXSb0W2di1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnaIXdt8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0ac3be718so1484056a12.1;
        Sat, 28 Dec 2024 15:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735428598; x=1736033398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DntmeBaXtuyXrfh+kAwMzaleGIsyITJbBXEuuRaR7ig=;
        b=YnaIXdt8ys+ixXcEgDt2+7ain63vZPq4eAVpiiXNnpnX2yYlirXOGmU5dd9rLcpAwQ
         F5aWZLoN/eFebTu0DCQ3zXC6PizIf+m6LtDpPsJePIl7lk+SMWfC9BMIwgBGY7cphiGa
         K08k6doBg5JJ/jQiuKSmzvySXnf/MsgQOcnX1X8bnbr6+RfBSgXeFTO2RH04dJ5H2Nts
         9G+FtSv8VjMc9kmtr3eDTGn+mH3AtDPCFWoGvMyeqyr4Q8NcB7oOxKWE8W8HC1ShWp4P
         46C5TrLQ7+mk/pLRdGj2ud/R6cafbluj4WEZvRNMINEswMr4HiEVmtiOiLKeJT15Z7ah
         9stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735428598; x=1736033398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DntmeBaXtuyXrfh+kAwMzaleGIsyITJbBXEuuRaR7ig=;
        b=JldnNnreFH+HpQchaK1SN62L75PbsmTk3DYdTyVHIUkkE/cOaF4SPUyoaEpJfjuUgu
         GuuLaHM01f9M0Q2aHYtbRgrGHNS5Bk6ui2R7bxNsdGwr05nb3K54p19HJ2LbTqaeGDMP
         ftYI5Wf9MKj0dkg0IdqpcUWqt39Z4v0ovFQhJ8vPgj7nTNXKNmp9ZF2VuUV6cWjUHSP9
         ar4bkzqHxD91NEalsuSEJszq/IWadbWTOWCKPMVcYPtEP0+mSqO8KnXVQLTp2UKUFAC6
         o5IzIWcUfITDH573AgttMbh9bhuNXPMBoOiIzyjcNcIBbH/Kjtalx0xy+CRBu+6NpDLa
         YmZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6mSBkuyjmcOqYkTN7AN4n5bqrOo/8m/Yv2wBVgWWKDLuWbu0WLS2tRQVmaJp8x6Deo1TJLGeR751Re4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVRvhbEe4creFf46Du9UHu+W0owaMsSb1mcNem4xS0toZ+8DT
	YsIeAOgdb/fWh0kbb7vP3U35Ba9jr1pMpr+sWk9eykc77wmnMvyf
X-Gm-Gg: ASbGncuMGzjmx7gbWcEN/o0FBycpHXZMiJL5/84L9satuV6TJJRO7J5E+eDU0dTr7aw
	c6O5+ja3Dkc6DeE1RjIi14ClmUNZXQcxtpDq4doCbbgigQGLB6sqbdf4gmRSiNbxjodWJWm5XEy
	sSdDVNbhWsWYdQ8y75CjroFYgakoCEc0pCaK/Ev8UX4iklf0nsMZb0/vX3FcMM9B1yKZD7HQWv0
	6ZypZZKUbnAg+/iLtw+fl0EzUSeFYK9YfrwmaX90Ishr3uZNMRxq29VQGW1r3IqJ4ZT8JfJLK3w
	l42T23tFxF54X4Na4lNEvMmkmObxxVKVaT0=
X-Google-Smtp-Source: AGHT+IGgnJPGi3LPHpDAWjheAjZnll4WUhubLiTvaf7jS+dzehFK+iKUUunqFlmgwhWy4lv65FRhRw==
X-Received: by 2002:a05:6402:2355:b0:5d3:ba42:e9e1 with SMTP id 4fb4d7f45d1cf-5d81de064cdmr10690169a12.6.1735428598301;
        Sat, 28 Dec 2024 15:29:58 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ac68sm12635156a12.78.2024.12.28.15.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 15:29:57 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v9 1/4] iio: accel: adxl345: introduce interrupt handling
Date: Sat, 28 Dec 2024 23:29:46 +0000
Message-Id: <20241228232949.72487-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241228232949.72487-1-l.rubusch@gmail.com>
References: <20241228232949.72487-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the possibility to claim an interrupt. Init the state structure
with an interrupt line obtained from the DT. The adxl345 can use
two different interrupt lines for event handling. Only one is used.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 27d70a1f0..134e72540 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -7,6 +7,7 @@
  * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
  */
 
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -17,9 +18,15 @@
 
 #include "adxl345.h"
 
+#define ADXL345_INT_NONE		0xff
+#define ADXL345_INT1			0
+#define ADXL345_INT2			1
+
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	int irq;
+	u8 intio;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -262,6 +269,15 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret < 0)
 		return ret;
 
+	st->intio = ADXL345_INT1;
+	st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
+	if (st->irq < 0) {
+		st->intio = ADXL345_INT2;
+		st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
+		if (st->irq < 0)
+			st->intio = ADXL345_INT_NONE;
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);
-- 
2.39.5


