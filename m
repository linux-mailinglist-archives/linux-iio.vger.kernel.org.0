Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4A944FDA5
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 04:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhKODrP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 22:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbhKODqq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 22:46:46 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F014FC061200;
        Sun, 14 Nov 2021 19:43:44 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id 8so4756047qtx.5;
        Sun, 14 Nov 2021 19:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l0Xi6ZFTcGrFltb6tqOU/b1e/rqtTlkrNbyKOULVJ8Q=;
        b=oQag/Q37DaqugGCMp7S6eHvewC94q2DDuB47+Ldkx7Sskw1NnyQ4Z2t2FKL1i42AG2
         DkNlFyV0oz/7xOOM0Oe3j54IZNGZGC96gPYz46eMR7qAq3SO/9OPKLT7iKlMyqIwRr4X
         PRTeFZ+8bDnT/8MdtWypStLdWOMgwkI2HqEd7i+/5fdYYlx+hbxH4dbpx0CTlxd5vU+A
         le2MPorPYCFEUtyxaJ8vIwqfgPQfJcwhqSch+2VA9au6A0oz7JNb/qwusb2Dxh0pe18U
         9Ie0+18QM3kkhMMHh+9xFG1Tq4RnAXLl17wssh8obNQ6wm4DUsCmNivmBefvNyXX1u/+
         BFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l0Xi6ZFTcGrFltb6tqOU/b1e/rqtTlkrNbyKOULVJ8Q=;
        b=Xaeo7ZNYuscv6U+EbOvTAz5q0gHckDfkuZrRdSuSIDBui950DoFFJ9fuuz0+NXBlNW
         VH5X+Na+68AiBqUws9vbo8HZtTQv0GSqw2OAoJfEOQTpqvOpY+dKXEmMDTXIGuJWhLk0
         nYA7WloLYrFbY6if0GC9qFNOOESXVQZrL1wwy8+VRfoZ3pmFIpxyo1zRF4lfpYUM15I9
         NvWfCucJur/kfZRTEUFKJufxwWv0sJwRcPqLBk5w0ENiuOAj1xyFeo97RUxXJ5nWEL3w
         zXHL5Y0UYf53w4alRwQPovmB1WzOLIUzRPfRxp9iZqKnwWCjBbnFlmDuLLZtXEqm3NyW
         AgoQ==
X-Gm-Message-State: AOAM532V8ozzrEnz1Jb1UrfbTrmVrSEEjuKI+3+Heq1WNO6lEqh/s3j7
        d9edSG/Q0AYhQinHbSB3PiinTMLYLgA=
X-Google-Smtp-Source: ABdhPJw/NfKZ1RKmNhtiw/zJakdR2nQvGutBolbVL/GcsTHwahcHsSLlSPcMXM8lqRvjTmwvBzVbIw==
X-Received: by 2002:a05:622a:1484:: with SMTP id t4mr36756230qtx.57.1636947824160;
        Sun, 14 Nov 2021 19:43:44 -0800 (PST)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h5sm206519qkn.62.2021.11.14.19.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 19:43:43 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v9 03/14] iio: inkern: make a best effort on offset calculation
Date:   Sun, 14 Nov 2021 22:43:23 -0500
Message-Id: <20211115034334.1713050-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20211115034334.1713050-1-liambeguin@gmail.com>
References: <20211115034334.1713050-1-liambeguin@gmail.com>
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
index dbe13fad3cbb..aff6d2d3447c 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -595,13 +595,35 @@ EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
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
2.32.0.452.g940fe202adcb

