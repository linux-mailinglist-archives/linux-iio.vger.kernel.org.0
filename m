Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEAA3C9636
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 05:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhGODPg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 23:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbhGODPe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 23:15:34 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D804C06175F;
        Wed, 14 Jul 2021 20:12:41 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id m68so3825510qke.7;
        Wed, 14 Jul 2021 20:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dYEOBrpAYyNQfBDQxW1uLYBvGUr+L0xKm/KEyDQXKhE=;
        b=cJjdur8tABy/VLR+w+f77wVdYMc0GMgvMMbxiUPPZgddOmhQeRIimS4PQLmYn5+GBE
         EFNZFFfsXwIq6ourajjOChBOWpFk+sGTCJuvdGWSxVJmbH2QUmTnSK4LJrkc/YSZJ1tD
         7wspTwCfbgMsEW94A14KZ0+MvuEEJnrHP6qYPdYW03IoKc1GyR9Vz2tyGcU0iHMa7yph
         7Bx26OeapTcIrPBwV2vKAcO5bF6qmlIdaSzKbIIx9SZA1fBtSyFyR4frdXzQ2cwNmDU9
         iDzEj9blbNQTuiPwQ/1EMOTGadA+s1QjHX3B/mGBhGjZTg2ZV1C3w9ppHEYr+Xu+jtqA
         8Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dYEOBrpAYyNQfBDQxW1uLYBvGUr+L0xKm/KEyDQXKhE=;
        b=YqxvFQf3y/byeQUkq/ipN9roPHq3BReoaOEN0GxxdSQvc5dMjKql28BcntQd6YtcxK
         kVG9ud9/i0n28kUxRqwBgEaBL22HGZTc71CvxgVbNs4lFyP0c80H08i7hf9nOIly/aVc
         S2HTuNoREgYF+43EBu7YuvJ6AzImjHuPKPPU7F7Qbzsi5/dwlqTPxOuJwu+ps155j2+j
         N773sLm7216F+r6sbYN2M8DI2wYP0f6ExQSdpi8nRelG/+Ph+b5ouN6mclKvbyDlIcCu
         diw+NfHvZ8JA+lcVF9tQNAoFNuo30RNkppXPRYsHCXW5LO1WmDw7V892CVg9rY6vH28N
         NmnQ==
X-Gm-Message-State: AOAM532RIgn7mJ+QQDTJ63H/vs53kmbOkRX4LoLMdh2hjVlCZydxMvZQ
        VLkIdWlxAfJi/OsemTux1og=
X-Google-Smtp-Source: ABdhPJyBerwnEKytxdD5Zqze+Qfla90OkskFeJoZ6Cw33TCtWZSRVgn017zGl7MW8dIyy1Yh7lB0FQ==
X-Received: by 2002:a37:e20f:: with SMTP id g15mr1491236qki.332.1626318760527;
        Wed, 14 Jul 2021 20:12:40 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id t125sm1932847qkf.41.2021.07.14.20.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 20:12:40 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 04/10] iio: afe: rescale: reduce risk of integer overflow
Date:   Wed, 14 Jul 2021 23:12:09 -0400
Message-Id: <20210715031215.1534938-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210715031215.1534938-1-liambeguin@gmail.com>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Reduce the risk of integer overflow by doing the scale calculation with
64bit integers and looking for a Greatest Common Divider for both parts
of the fractional value when required.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 774eb3044edd..4c3cfd4d5181 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -39,7 +39,8 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
-	unsigned long long tmp;
+	s64 tmp, tmp2;
+	u32 factor;
 	int ret;
 
 	switch (mask) {
@@ -67,8 +68,16 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 		}
 		switch (ret) {
 		case IIO_VAL_FRACTIONAL:
-			*val *= rescale->numerator;
-			*val2 *= rescale->denominator;
+			tmp = (s64)*val * rescale->numerator;
+			tmp2 = (s64)*val2 * rescale->denominator;
+			if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
+			check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2)) {
+				factor = gcd(tmp, tmp2);
+				do_div(tmp, factor);
+				do_div(tmp2, factor);
+			}
+			*val = tmp;
+			*val2 = tmp2;
 			return ret;
 		case IIO_VAL_INT:
 			*val *= rescale->numerator;
-- 
2.30.1.489.g328c10930387

