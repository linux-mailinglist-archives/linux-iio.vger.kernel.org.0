Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062F53B8B7A
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 03:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbhGABDU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 21:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbhGABDT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 21:03:19 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF71C061756;
        Wed, 30 Jun 2021 18:00:49 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id j184so4456504qkd.6;
        Wed, 30 Jun 2021 18:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8M+IZsg6mC9vNYvrvfewfcCtryWP0CDkqJ0WF7tXO24=;
        b=DT3O6vY/81RoS2jUjaLvhy7Oc++xRCCbKX/ji56XSR2Yt6Zwo4y3qiR6uWcBY5gCT/
         ONCN0LzfnFqNY4pCmsKmSW6CFCivW240jJHwg2sGjxTtVqeqV+xTiPPla8TcHQ3xrvYp
         jw91zyh5Sd7xY+fjxm+piPmVXmed8SWuEdW25FrCZyHCsplz/3Aymj2to1QJ45rcO1cn
         weDOMBY4VytU2YZmsE4NJ/IdnEo9cpt097sgC93RFZeNpHT2XwqSEyfdQM5mSXhErwaF
         YP7mFYeTpdTAvqD2DSjtlv+FTE//ZF5ElilpOTeMsscUk5Qs/p8Hex/Xhqwono5WDh0w
         0wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8M+IZsg6mC9vNYvrvfewfcCtryWP0CDkqJ0WF7tXO24=;
        b=DKk0zhLIECMBvAdb5uxwyCmVff8FbkD/nTLmv/ALsK9pjhd7tx31vwMrh1aFWvtkJG
         KRXqU5OOiNb+zMx9rO8LPIsIjgayvWgV5JdgREIZDdp1k8cuIR0qSdhh9MorbI7WhtLs
         J1vSOe5HW1LjmrHO0EbPlhQFkO9pHPy1gjqCJVP9WwuNU0o27rWDxPLrVNzbWEhvKv4I
         8AJy/K4AoPmfBdsT95/xDijJylR2uqrwuhZNp+rabVurpbwiQY5XsApzDSz0YLQMxrJS
         xh0yKuBfiX5OmF2C0CJTRy5r+Y/mFghVcMOT9zWIDEs15BL8NryTcMIPSwIW2FNDLYOU
         IJSg==
X-Gm-Message-State: AOAM532+7hTg/R5kWpnf8yH4eI8yZxtWue+aQZQj4TCB8fxppfnwsC8E
        VWKVbaNfTXu6V24VEpH+v0A=
X-Google-Smtp-Source: ABdhPJzkn6SzdttbtN/lu85HAXmsCUHLOya8f5vC7lHOn3zOa0Z089KC3PG3mHvM/Tz3yY+gyETsJQ==
X-Received: by 2002:a05:620a:cd2:: with SMTP id b18mr39228411qkj.221.1625101249082;
        Wed, 30 Jun 2021 18:00:49 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l127sm14087782qkc.64.2021.06.30.18.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 18:00:48 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 03/10] iio: inkern: make a best effort on offset calculation
Date:   Wed, 30 Jun 2021 21:00:27 -0400
Message-Id: <20210701010034.303088-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210701010034.303088-1-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

iio_convert_raw_to_processed_unlocked() assumes the offset is an
integer. Make a best effort to get a valid offset value for fractional
cases without breaking implicit truncations.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index b69027690ed5..e1712c1099c5 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -578,13 +578,39 @@ EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 	int raw, int *processed, unsigned int scale)
 {
-	int scale_type, scale_val, scale_val2, offset;
+	int scale_type, scale_val, scale_val2;
+	int offset_type, offset_val, offset_val2;
 	s64 raw64 = raw;
-	int ret;
+	int tmp;
 
-	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
-	if (ret >= 0)
-		raw64 += offset;
+	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
+				       IIO_CHAN_INFO_OFFSET);
+	if (offset_type >= 0) {
+		switch (offset_type) {
+		case IIO_VAL_INT:
+			break;
+		case IIO_VAL_INT_PLUS_MICRO:
+			fallthrough;
+		case IIO_VAL_INT_PLUS_NANO:
+			/*
+			 * Both IIO_VAL_INT_PLUS_MICRO and IIO_VAL_INT_PLUS_NANO
+			 * implicitely truncate the offset to it's integer form.
+			 */
+			break;
+		case IIO_VAL_FRACTIONAL:
+			tmp = offset_val / offset_val2;
+			offset_val = tmp;
+			break;
+		case IIO_VAL_FRACTIONAL_LOG2:
+			tmp = offset_val / (1 << offset_val2);
+			offset_val = tmp;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		raw64 += offset_val;
+	}
 
 	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
 					IIO_CHAN_INFO_SCALE);
-- 
2.30.1.489.g328c10930387

