Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E1F3DCD5B
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhHATka (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhHATkX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:40:23 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60989C06175F;
        Sun,  1 Aug 2021 12:40:14 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id p38so7911721qvp.11;
        Sun, 01 Aug 2021 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zhQeMelYWNMHpFAMGtlyl1sUbg34IFFWmo4FOYtEzaY=;
        b=l5Kb87vnrHyjiimiX1rx2Duk6q8wFU9ih6mRQNbq/BMzM0Z5Ulig0sQUeyQ82GzMHQ
         8icw6LDh8AC4K0U1EC6/J16qwctiwWkJP9uwH8RflV/KRjKZa2Cv9vJfDrjQ6lOATUTG
         nJwEGZvl1rbmvaKLzlOU8flUnfRurpF24v8KCScEIbvfwACLQLh+2Bgs52tCtnqWoydy
         6fAWMtX7CqpaaGX8Gz3QT+lCMOGTQKTrQAqqkHeCTcmEYTMlTcz06cH71e1AolUYKKUO
         pgOTtSSfvlwhmZxW+IlzSon07Voa3pQXFSLkCc6Z0UK0gtfElKhTkDdj3DYjzhVdvBwj
         rHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhQeMelYWNMHpFAMGtlyl1sUbg34IFFWmo4FOYtEzaY=;
        b=Py/F+ZV6TbSOt53a3lKjtF84QO/S78C0mVTQEk/ysbMBePKZbKbOqsF+Hvph0rn56l
         rpltrrq1hwNc7AfM5hPSPXWnLWsg5aDMj1ECD3MS3p/azYKG+vUzor3alMpYyeY0L7bi
         Tm9Zed0NS25bB3J+gc1ktMQiZhDbpgK1ZQD9s6yf9NfzYNRfjbLh/UnNmhTptucayZyb
         YajnZq6q18K2EdHH1IaJ1mRVJLWmMcIWFCcPrFMCQheCBqql7u9O57DLHt4gwZUyUsZy
         LTWOepKsxOCZBj/35NzY0u0pVyECCWL8Bw2Fs07GQ4H2ZKasG7ElAtNA9Bi/Yl9pwNBJ
         FFZQ==
X-Gm-Message-State: AOAM532iQL04uyOILf/QOftQAKwHhR4AOeR0O7pBieLqAhSRkQcITXdv
        qvC/hOF6gZqypkOLN8XsySCp9BZVSbaLHw==
X-Google-Smtp-Source: ABdhPJwmVNiCFKDo7HlknpSdx1gyZIC9FQU9o3L/BdlZZN7gZF3gXesp4V/pXPBgKvGEBRX/irqwTQ==
X-Received: by 2002:ad4:5ccc:: with SMTP id iu12mr12331806qvb.47.1627846813573;
        Sun, 01 Aug 2021 12:40:13 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f10sm3621606qto.31.2021.08.01.12.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:40:13 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v7 03/13] iio: inkern: make a best effort on offset calculation
Date:   Sun,  1 Aug 2021 15:39:50 -0400
Message-Id: <20210801194000.3646303-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210801194000.3646303-1-liambeguin@gmail.com>
References: <20210801194000.3646303-1-liambeguin@gmail.com>
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

