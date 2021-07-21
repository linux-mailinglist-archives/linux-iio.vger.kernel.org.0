Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662E83D0717
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 05:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhGUC0d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 22:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhGUC0Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 22:26:25 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5770DC061766;
        Tue, 20 Jul 2021 20:07:03 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l2so997565qtp.11;
        Tue, 20 Jul 2021 20:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zhQeMelYWNMHpFAMGtlyl1sUbg34IFFWmo4FOYtEzaY=;
        b=t4HfGx2mRk4Enty4f/qmaF+qBssAiTHaDR89eTSAuc9Y2UZX2oaM3M6RiSx3aMpxoi
         qEI/G18uDyuwIkfUYYjjsd75LNBjxa7eIueTXTcOEWfgjdPfBnRDF9G+sAjcvqxpgkK1
         t8e+wXwT/41xnf50dNkiSoNpt0jOd8H0yQC/lldijsZHfEGhHlpKxK0URqy6EPf4Zbnn
         dZD5L1YrZ5IPMLOHjWkE2TvKl6DFA6uvaDhdEf0lbQCNeGmg4/rEL0GbypH1BcOjW4SM
         h7Tf0Zu3T4JysRNiQfW07G/0eS6dR1OD9dKZf4jOTiv8WiPHB2dqkj21pxpTR1LuZ5z1
         snXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhQeMelYWNMHpFAMGtlyl1sUbg34IFFWmo4FOYtEzaY=;
        b=P9u5Lpl8u9h5IZEGU4qTo3qCDgJe2SPBlZ3jHUViHy2oJ7PLu9hO0XCNMAXU1zU0Ae
         Qv4hyUD9p6Qzf75CGXSAjtEdqwRhNFLbV7omDDsaw3Mw/puKZR5ZI4+F78HbM4DLgXnl
         M7EyDrrJKaknkp51FfBmj40k/yCjp8blNmkR4rnuFylmfF8Et5DQGWP0Q257KG0JjDUr
         G5h/Vh9Tl4K1sNICrt239RDqNAPW/SJsoX2EO6tNpoEccH97gBHpN9x3fm95mVjKWDzg
         iNvA6sH+MoVX4i/hzq3aYcepsvsvZfy6AXujwxSs6EN1XWl1+cyxE46QnGqttIQagB1U
         2FaA==
X-Gm-Message-State: AOAM532AgiuuzyrSS5Et654wnW3mSLROMPOWFJSoOeGfJjsHzPJa7uFD
        e1NNhtOAnUlNYMEyQWnEdcM=
X-Google-Smtp-Source: ABdhPJwk5XWCwKz2yJJDCS5aofZDVi1r5JysgMI4wNphzDdo1ML5lupw1P/Ec2aCdaK0gmB+GbP27w==
X-Received: by 2002:ac8:7ee6:: with SMTP id r6mr29478049qtc.199.1626836822598;
        Tue, 20 Jul 2021 20:07:02 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g76sm10561024qke.127.2021.07.20.20.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 20:07:02 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 03/13] iio: inkern: make a best effort on offset calculation
Date:   Tue, 20 Jul 2021 23:06:03 -0400
Message-Id: <20210721030613.3105327-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210721030613.3105327-1-liambeguin@gmail.com>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
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

