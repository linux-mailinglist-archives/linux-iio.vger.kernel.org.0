Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC383C9634
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 05:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhGODPe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 23:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhGODPe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 23:15:34 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320B8C061762;
        Wed, 14 Jul 2021 20:12:40 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id i4so2147996qvq.10;
        Wed, 14 Jul 2021 20:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zhQeMelYWNMHpFAMGtlyl1sUbg34IFFWmo4FOYtEzaY=;
        b=ktixEYDEVNnbF74lVxjv9jgUdBZOLbrHEfbaIXe+S9yjG0+RMCXjpopBCzHmDxq+6R
         Dj4c+QK0cQtwkV6/ZV8sPSZILtTLZhP3I6SUxzjiRsGgGTz5kxfmQ98IlJbfAboD73OK
         owzBT9PM9wsTNlLdKyLSDa1/kqLWr1jVNNp1Y9K+6bGERaA/I9RaGF4ERnBmdM5l1Jca
         FrGwtJktm08v2gmdEJO9Q+bVY6emN4jU2B4igq+HUKHWqftSMZLq1vLUxHZCGkAbjYFx
         lU/6qWidSu+UTMtSz3pJwg95vXnZpAMCS43ZBjQQaY/pGzp9veUh9hSfcRUFsyMRm7F4
         Cvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhQeMelYWNMHpFAMGtlyl1sUbg34IFFWmo4FOYtEzaY=;
        b=ASmFYITtJ/CPlyzSFvO6llvfygHsXMPfLjj4g9136rBS59ahfkl+tZBGDwVETFBb0R
         t7IahSX/RCTJrFXiroZggYCq7ojS6vV76BvTZOUbjgNhIZuOmKuO+5EZrh/jsD3fVTwD
         hkaqjR95crbk71zXZEzj07JU8thSa6lKKRFZkrJKdXW+lKd5VPghuOdiF5PN9qeYt7Ze
         WXJ9WAnokCTg9o/NJng2bfSWCGX5GRKWmtns0Vv1TyZb7OQlSm+8v5wsRAk9/cYLg1TF
         pBy2P1z2WC58pIanHOiu3AE6/FmPR7S21JofzDWXr6CkjIiPu1YPtwU89Mrh2y/GoBWf
         iQFA==
X-Gm-Message-State: AOAM531/EnRiIft81cH4Hpeu1b/SZGfnElOF8akZ3bYsJzqgLNOOuj+L
        STEd6Fhn/I7+IheO2QuWj6s=
X-Google-Smtp-Source: ABdhPJzIMh0zeoSBwJFrjf+LAo5y5X5Bp0wecd1qRUmjTxiQne/KjylzYcrTCoO/vvCTPM0RQZZfiQ==
X-Received: by 2002:ad4:5ca6:: with SMTP id q6mr1604863qvh.23.1626318759467;
        Wed, 14 Jul 2021 20:12:39 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id t125sm1932847qkf.41.2021.07.14.20.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 20:12:39 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 03/10] iio: inkern: make a best effort on offset calculation
Date:   Wed, 14 Jul 2021 23:12:08 -0400
Message-Id: <20210715031215.1534938-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210715031215.1534938-1-liambeguin@gmail.com>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
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
 drivers/iio/inkern.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index b69027690ed5..5e74d8983874 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -578,13 +578,35 @@ EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 	int raw, int *processed, unsigned int scale)
 {
-	int scale_type, scale_val, scale_val2, offset;
+	int scale_type, scale_val, scale_val2;
+	int offset_type, offset_val, offset_val2;
 	s64 raw64 = raw;
-	int ret;
 
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
+		case IIO_VAL_INT_PLUS_NANO:
+			/*
+			 * Both IIO_VAL_INT_PLUS_MICRO and IIO_VAL_INT_PLUS_NANO
+			 * implicitely truncate the offset to it's integer form.
+			 */
+			break;
+		case IIO_VAL_FRACTIONAL:
+			offset_val /= offset_val2;
+			break;
+		case IIO_VAL_FRACTIONAL_LOG2:
+			offset_val /= (1 << offset_val2);
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

