Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A503BDB14
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhGFQMk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 12:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhGFQMc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 12:12:32 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92478C061762;
        Tue,  6 Jul 2021 09:09:52 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id s4so1998867qkm.13;
        Tue, 06 Jul 2021 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zhQeMelYWNMHpFAMGtlyl1sUbg34IFFWmo4FOYtEzaY=;
        b=e0hCouqsW64PHJjeDsZcvlMX0fF+yG2B4GOys0Gnr2fBJpupvojuz8dY/Q9A8679FY
         S8MHosmBnXJ7UrYak1JL3q/DuhWU2au4hTL9YhQUv5PtyVnu+MLTFfhrAiKcCO9Vxthi
         u4rmSR8D5nakvZ2g1Wah9RqVN+Y0Uppn5wAxKYrEwBHTU3hDEOjmsdkFzUiQ9yI2qnK5
         3ZemMJbto7Bu23LdOwROmHXKF9pUXluFI35j5Y8h4yEI8gjVHGB5k1DsVN+El1QWsLFs
         uEc2nEkgluTOYBL/S4jRmPM0sMrWVoAChqyAntF/quXozIGHLoTHCq4UUloX6SksXTQ0
         hlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhQeMelYWNMHpFAMGtlyl1sUbg34IFFWmo4FOYtEzaY=;
        b=KTUEh6CZuAT3nXrgYfYgsRCOiIBnwE6vvD5WcqBK77lGjIW0lpBZT2ywj16PBaoud2
         YISDNRkjj5OrXvHGX3iieDaFazmyTzf8xMeAPTxr3iOumq53Me2ciAmxfFyesRcYMYbt
         ssA9c2nUvQTgGkyeclsBht4mZUD78uq2OkC+yGYGMgYeJ+5245vA0Q9RZ4PzRl+mBnF0
         0pgd3LxKZtXH1R3BJVyJ3j8E4JKdSv0RRgDLnDwgwm+hcV7ilahmq0RHBjcnwmCHESG3
         gSBeKwPIaSgtC8z9891GlwIBw5CF5w5K16c2rMxHnKbYPfS1rRd6I1DttqdoneT7rmvJ
         ibuQ==
X-Gm-Message-State: AOAM531Ty97NOorWBCfK0MXeYIkSQDPlex4A6fCNBA12pjovYrVZbHK5
        FLlac9/bpbCoKiHu1HwHcX4=
X-Google-Smtp-Source: ABdhPJzdxZQwbe9P4qh/yzdn8sxRTWBkNFxFgn/AxzjugkpgplSlI+nloIU4RnToC1ARVEBZMz4H/g==
X-Received: by 2002:a37:a688:: with SMTP id p130mr4641361qke.257.1625587791818;
        Tue, 06 Jul 2021 09:09:51 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n64sm6995371qkd.79.2021.07.06.09.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:09:51 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 03/10] iio: inkern: make a best effort on offset calculation
Date:   Tue,  6 Jul 2021 12:09:35 -0400
Message-Id: <20210706160942.3181474-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210706160942.3181474-1-liambeguin@gmail.com>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
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

