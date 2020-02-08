Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFBC156436
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2020 13:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgBHMeH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 07:34:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36190 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgBHMeH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2020 07:34:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so2162569ljg.3
        for <linux-iio@vger.kernel.org>; Sat, 08 Feb 2020 04:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvVvVSLhYDMVx4cSjepy0hm3VnNyMvK1awoAq120xmQ=;
        b=SjDK+gA6DyxwSadPU/QkRTZAE7Gzh/IqXJfc22Gw0F1R6TDKQWkphgMggLweCjZvfR
         YXZXrJcnPLL9o6InmvpOGCiEKbLcJuTYaybpzUv3n+N78hcKQC3GGApiqlpzlK/benJz
         154qlqZqDoGt0VUnhQMSLcXMyEno9H25asmKwnuDwMZUdjPvElSPnfuqNRjrNqLVhxbM
         1AkUKtCAKaPuUZVdsQ28KkucxSWuEBR7lUiuV4UOHOnSIf7tymEtqujOCNSQe3+4Sl2V
         sCaVnr4TfPlpvOI04lCmDGGBzuSLWfB5TlELYkqad+dr/2+27Y2pT4mwEbH8axHkV8y1
         n4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvVvVSLhYDMVx4cSjepy0hm3VnNyMvK1awoAq120xmQ=;
        b=SyvR48wyRxNQL2YCLRsXhtDvnCYTS/zkPEyolS7/4Ywx+1jeOXiZY+fSaqwtZQBVtz
         fhlVa6ptWIUPKQHe8Ej+7S/vS+z6DxWU1YLVd5H5NdR8HTdG7ZQ4DyUspM0k2vVQfo5Z
         G5yppjD+XAi4Vs74suRasPQT8p8va0SH7J7vGgYcbZxLpMeu+IXgTnMRq/zcD41pXDMM
         jqOagRGevqU4OQsUk5eI8gtVKoh0E10GZ3Vd8HcFcuwyeHkxzGeJv1lhkOiwy9j4wsuX
         ZW2d/flT4Jlymk236XXwre9CWzC9c/qtTm+61/91578wyhSw68LVMwMGmGZXNogI5x7h
         8Vhg==
X-Gm-Message-State: APjAAAU6zy/8gEAQxrMSg/I8q3duTyQTo5Z0QTgugp8RQSDbMsnJSHOo
        cvMMskOVLV12dB0yshQUxWdALQ==
X-Google-Smtp-Source: APXvYqw3gpk3IB37TjvEug9aLm9RhxkldcfKSP/0Qcd1HoSm0ZOeAu22yL85PHDhtlSfwf4IOa309w==
X-Received: by 2002:a2e:868c:: with SMTP id l12mr2603630lji.194.1581165244379;
        Sat, 08 Feb 2020 04:34:04 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id g25sm2954871ljn.107.2020.02.08.04.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 04:34:03 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH] RFT: iio: gp2ap002: Replace LUT with math
Date:   Sat,  8 Feb 2020 13:33:59 +0100
Message-Id: <20200208123359.396-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This replaces the current-to-lux look up table with some
integer math using int_pow() from <linux/kernel.h>.
Drop the unused <linux/math64.h> in the process.

Cc: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I would appreciate testing that this give the right
result. Using math does look a lot better.
---
 drivers/iio/light/gp2ap002.c | 94 +++---------------------------------
 1 file changed, 7 insertions(+), 87 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index 433907619268..153ae0a163ab 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -33,7 +33,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/interrupt.h>
 #include <linux/bits.h>
-#include <linux/math64.h>
 #include <linux/pm.h>
 
 #define GP2AP002_PROX_CHANNEL 0
@@ -205,71 +204,10 @@ static irqreturn_t gp2ap002_prox_irq(int irq, void *d)
 	return IRQ_HANDLED;
 }
 
-struct gp2ap002_illuminance {
-	unsigned int curr;
-	unsigned int lux;
-};
-
-/*
- * This array maps current and lux.
- *
- * Ambient light sensing range is 3 to 55000 lux.
- *
- * This mapping is based on the following formula.
- * illuminance = 10 ^ (current / 10)
- */
-static const struct gp2ap002_illuminance gp2ap002_illuminance_table[] = {
-	{ .curr		= 5, .lux	= 3 },
-	{ .curr		= 6, .lux	= 4 },
-	{ .curr		= 7, .lux	= 5 },
-	{ .curr		= 8, .lux	= 6 },
-	{ .curr		= 9, .lux	= 8 },
-	{ .curr		= 10, .lux	= 10 },
-	{ .curr		= 11, .lux	= 12 },
-	{ .curr		= 12, .lux	= 16 },
-	{ .curr		= 13, .lux	= 20 },
-	{ .curr		= 14, .lux	= 25 },
-	{ .curr		= 15, .lux	= 32 },
-	{ .curr		= 16, .lux	= 40 },
-	{ .curr		= 17, .lux	= 50 },
-	{ .curr		= 18, .lux	= 63 },
-	{ .curr		= 19, .lux	= 79 },
-	{ .curr		= 20, .lux	= 100 },
-	{ .curr		= 21, .lux	= 126 },
-	{ .curr		= 22, .lux	= 158 },
-	{ .curr		= 23, .lux	= 200 },
-	{ .curr		= 24, .lux	= 251 },
-	{ .curr		= 25, .lux	= 316 },
-	{ .curr		= 26, .lux	= 398 },
-	{ .curr		= 27, .lux	= 501 },
-	{ .curr		= 28, .lux	= 631 },
-	{ .curr		= 29, .lux	= 794 },
-	{ .curr		= 30, .lux	= 1000 },
-	{ .curr		= 31, .lux	= 1259 },
-	{ .curr		= 32, .lux	= 1585 },
-	{ .curr		= 33, .lux	= 1995 },
-	{ .curr		= 34, .lux	= 2512 },
-	{ .curr		= 35, .lux	= 3162 },
-	{ .curr		= 36, .lux	= 3981 },
-	{ .curr		= 37, .lux	= 5012 },
-	{ .curr		= 38, .lux	= 6310 },
-	{ .curr		= 39, .lux	= 7943 },
-	{ .curr		= 40, .lux	= 10000 },
-	{ .curr		= 41, .lux	= 12589 },
-	{ .curr		= 42, .lux	= 15849 },
-	{ .curr		= 43, .lux	= 19953 },
-	{ .curr		= 44, .lux	= 25119 },
-	{ .curr		= 45, .lux	= 31623 },
-	{ .curr		= 46, .lux	= 39811 },
-	{ .curr		= 47, .lux	= 50119 },
-};
-
 static int gp2ap002_get_lux(struct gp2ap002 *gp2ap002)
 {
-	const struct gp2ap002_illuminance *ill1;
-	const struct gp2ap002_illuminance *ill2;
 	int ret, res;
-	int i;
+	u64 lux;
 
 	ret = iio_read_channel_processed(gp2ap002->alsout, &res);
 	if (ret < 0)
@@ -277,31 +215,13 @@ static int gp2ap002_get_lux(struct gp2ap002 *gp2ap002)
 
 	dev_dbg(gp2ap002->dev, "read %d mA from ADC\n", res);
 
-	ill1 = &gp2ap002_illuminance_table[0];
-	if (res < ill1->curr) {
-		dev_dbg(gp2ap002->dev, "total darkness\n");
-		return 0;
-	}
-	for (i = 0; i < ARRAY_SIZE(gp2ap002_illuminance_table) - 1; i++) {
-		ill1 = &gp2ap002_illuminance_table[i];
-		ill2 = &gp2ap002_illuminance_table[i + 1];
-
-		if (res > ill2->curr)
-			continue;
-		if ((res <= ill1->curr) && (res >= ill2->curr))
-			break;
+	lux = int_pow(10, (res/10));
+	if (lux > INT_MAX) {
+		dev_err(gp2ap002->dev, "lux overflow, capped\n");
+		lux = INT_MAX;
 	}
-	if (res > ill2->curr) {
-		dev_info_once(gp2ap002->dev, "max current overflow\n");
-		return ill2->curr;
-	}
-	/* Interpolate and return */
-	dev_dbg(gp2ap002->dev, "interpolate index %d and %d\n", i, i + 1);
-	/* How many steps along the curve */
-	i = res - ill1->curr; /* x - x0 */
-	/* Linear interpolation */
-	return ill1->lux + i *
-		((ill2->lux - ill1->lux) / (ill2->curr - ill1->curr));
+
+	return (int)lux;
 }
 
 static int gp2ap002_read_raw(struct iio_dev *indio_dev,
-- 
2.21.1

