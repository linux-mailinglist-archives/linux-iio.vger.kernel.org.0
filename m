Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F733F3471
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhHTTSg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHTTSe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:34 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36EC061575;
        Fri, 20 Aug 2021 12:17:56 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id q6so6050735qvs.12;
        Fri, 20 Aug 2021 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4cgnObxx9glG9jRFcAKtSHXIEK1QCoxWRUeDTwcnOA8=;
        b=he3Ft2wQmkNC5qd1X9fkCZBI+yG+NzN6amogJDB3OCtIIErxPq4ENQaoDlQ4S9oZVI
         Jpf0uVSnewAPBG+BmgJkg48H4UOFa1EiuvHaQWN8OPP7JNh6ENPxkszv+EVAwysqucJG
         9qRvVQKO6qO6b9QHM4PgT/+NbX9Hs1jNBjt/a3RYt6FUBeBWgKjyh4AwgAs3AQB3y3+i
         IkTG56OfIW0aAClU9t3P+WgAp+kJmiWcsi+jF5Anyqbg7orJMwLRXlg8cGQcau2MXS1z
         /ZZ2Kux1YmvGya9L5qHIYowOGzqCKG6T5RdXd56OK/WKT3CJvPHs+aqO8I8t7jInlNCu
         s1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4cgnObxx9glG9jRFcAKtSHXIEK1QCoxWRUeDTwcnOA8=;
        b=h4FpurwdnOd+OeZLbm+Y5yld+DWWBFcI+VjD11SxRKQ7QoI/q933frvtwu6gfxl9Ih
         OPXeqJtO9pWAEHmNrp2J0D2OK3S2Q46HUUNPoojzj4pkWjhSEBqDmX9WGltxsfOYh/9k
         TIi5sS6jErLY+KXrFMCwWgyUc59X8kBMGbTcJESYH7fYRGKudqWFRbjqA6MuywEWNTwb
         YGRu4sKTP9k4q+8/AywpGUQOfJZDumlCkHi6+WZIVXCh3ESeqvgLH+mEva5xKqgm07ub
         dx5w+l66pggGGVywoo7+Hvpk32k0XxgGjOxdpM6y2iMCSz5rT3HjrfO1+aAqKrYDKH7e
         tp8g==
X-Gm-Message-State: AOAM531iWwxWPL+8b7YjSMIaRILBpgtISzeDfYDJimY04kqqwxI8qAR1
        UBYLuejc8/d3NVXCmnvqoAw=
X-Google-Smtp-Source: ABdhPJxBROzBsMLFRtYzUxSOHXMlYCosdKvgqH5yzHxYsm2XB0wkq5TCVzdoYwAWikXd2y+Ct5G2MQ==
X-Received: by 2002:a0c:85a1:: with SMTP id o30mr21932403qva.57.1629487075437;
        Fri, 20 Aug 2021 12:17:55 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:17:55 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 03/14] iio: inkern: make a best effort on offset calculation
Date:   Fri, 20 Aug 2021 15:17:03 -0400
Message-Id: <20210820191714.69898-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210820191714.69898-1-liambeguin@gmail.com>
References: <20210820191714.69898-1-liambeguin@gmail.com>
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
2.32.0.452.g940fe202adcb

