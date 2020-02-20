Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1261669B6
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2020 22:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgBTVVC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Feb 2020 16:21:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34406 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgBTVVC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Feb 2020 16:21:02 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so4299995lfc.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2020 13:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8XTWqCnv9JuAcz5ZEdNqjV9Y9D8aEWGHiFyYvweUoY=;
        b=fc+xq7w7o99osROtYBRifJRrv/dxMasjUxerZ8CxOpzTpjeQEl3WyBOqjgN8/mOD/H
         6oh9jFDex24uUiVbUbTzdQo7fsFJoY3zGOstyVqf25gVyPtTA8MkEQoa12yv21VL6rB4
         NtQmnmDJkNac/k9FwU7rLIUmtNaQbFww/+++VpUELys+f7FhALs3nJo0fRRaaPS84kKb
         W1daql4poCsn8IBd8auR4ZBwjiOrMbYl+/S6DKxl2bACocLnzGQ5CyyyohRTKii2RRPD
         yxzfEXza+7t3R48YM2jxYB5+h3emFEAOO8CFaBGWM9IZ9rhQscqsBqlf5f1g6eUd+mi4
         q1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8XTWqCnv9JuAcz5ZEdNqjV9Y9D8aEWGHiFyYvweUoY=;
        b=ZdXYtjbkBX8mti45tTOPK/n2jW57qNDKsBi0/88OwDtcGJhnY4NhZNhZFeOeIQq9l0
         l31yj7a6bK7ZtcktpS35Cd2McHvUTMQytxjH0sQKkx69jg/PrWpKE/htwGbw8If3QPva
         I9YIo0xrv9AIqY3TW6Hyw0SZ2xoQ9M2+XpIXA+oBlRKnK+bxYP38wvisvBc5fV1qaAQ1
         vol5HuJMJWIUVf72eUZeVsg6mYb6qGxTiv3SsOSbkXI1UkbJ7pl6HB1EGguHKpLkU89d
         kHeFyS8ygir/v1k5/mll9YbdfgOuh4jnCOuYJtcsyowBufWZuBEsBW0MH6R9FWStMwWx
         1RVA==
X-Gm-Message-State: APjAAAWfHfZyBZirVBqWkMMYQwCRrbLec4KldjErpTy6CFhim2E5goEI
        IG96FPFDM6CEDH3RmsKW/ygEOA==
X-Google-Smtp-Source: APXvYqw082uzyBzdfDTkdZ2YkTlv1SEH7Th2j0wdQ8tFVsEnjSyWnUqt6Br9cBehdMXlF6mIwUKa2A==
X-Received: by 2002:a19:a07:: with SMTP id 7mr17549150lfk.66.1582233659414;
        Thu, 20 Feb 2020 13:20:59 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id n14sm343800lji.37.2020.02.20.13.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 13:20:58 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, Gregor Riepl <onitake@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: light: Simplify the current to lux LUT
Date:   Thu, 20 Feb 2020 22:20:53 +0100
Message-Id: <20200220212053.32577-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Gregor Riepl <onitake@gmail.com>

The look-up-table for currens to lux is simply specifying
all currents from 5..47 mA, if we add some values for 0..5
we can just select the index for the lux value in an array
from the mA value. Use clamp() to get the value in the
range of values in the array.

Cc: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Gregor Riepl <onitake@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/light/gp2ap002.c | 92 ++++++------------------------------
 1 file changed, 14 insertions(+), 78 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index f747a42882e0..b24f43f961c8 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -204,71 +204,27 @@ static irqreturn_t gp2ap002_prox_irq(int irq, void *d)
 	return IRQ_HANDLED;
 }
 
-struct gp2ap002_illuminance {
-	unsigned int curr;
-	unsigned int lux;
-};
-
 /*
  * This array maps current and lux.
  *
  * Ambient light sensing range is 3 to 55000 lux.
  *
  * This mapping is based on the following formula.
- * illuminance = 10 ^ (current / 10)
+ * illuminance = 10 ^ (current[mA] / 10)
+ *
+ * When the ADC measures 0, return 0 lux.
  */
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
+static const u16 gp2ap002_illuminance_table[] = {
+	0, 1, 1, 2, 2, 3, 4, 5, 6, 8, 10, 12, 16, 20, 25, 32, 40, 50, 63, 79,
+	100, 126, 158, 200, 251, 316, 398, 501, 631, 794, 1000, 1259, 1585,
+	1995, 2512, 3162, 3981, 5012, 6310, 7943, 10000, 12589, 15849, 19953,
+	25119, 31623, 39811, 50119,
 };
 
 static int gp2ap002_get_lux(struct gp2ap002 *gp2ap002)
 {
-	const struct gp2ap002_illuminance *ill1;
-	const struct gp2ap002_illuminance *ill2;
 	int ret, res;
-	int i;
+	u16 lux;
 
 	ret = iio_read_channel_processed(gp2ap002->alsout, &res);
 	if (ret < 0)
@@ -276,31 +232,11 @@ static int gp2ap002_get_lux(struct gp2ap002 *gp2ap002)
 
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
-	}
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
+	/* ensure we don't under/overflow */
+	res = clamp(res, 0, (int)ARRAY_SIZE(gp2ap002_illuminance_table) - 1);
+	lux = gp2ap002_illuminance_table[res];
+
+	return (int)lux;
 }
 
 static int gp2ap002_read_raw(struct iio_dev *indio_dev,
-- 
2.21.1

