Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5B43F3478
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhHTTSq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbhHTTSl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:41 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076A1C0613CF;
        Fri, 20 Aug 2021 12:17:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id u21so5324112qtw.8;
        Fri, 20 Aug 2021 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMRICZfY4ADl2DVliKOzvM085ZlUKV9RB8+CiwFV7h4=;
        b=t+5nTxWjFzI2lu2FdMy+BNYLCV4KSo75259r877f9nIyabDDD61UzR1MdQ4A3X/nQ+
         3QiCoMyb7SS+0Eqt3ersa4D98AnIh9ECz+NP6jL76WmSBDuKK3oDnSKkPW3qdrOVIiaX
         XWsMnSEjCsCiACreR4LeIjLAOPe6RTUxiu4tTddywTj1Hbx0/zRAOAaheGspv9KjM3nu
         B2gocB6sA5sc8KJScH3/EHAPb4bUEUsZHdOpfl1UE+EiT6gSd58CATvoQGJEqBlXoKpc
         bT2sKgB5CNzw2e4izqKCURJM5Te8vOzVym2p8usmtYuQmdiSDdFopHJIw4ahlCAZ6TnP
         hQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMRICZfY4ADl2DVliKOzvM085ZlUKV9RB8+CiwFV7h4=;
        b=hw4D+4Hoqw0H62ZKmjo8RyeF4YPkQiQrI2Lz1GyF+tTS5pHjsZEVjiWNH2B7ozJFkR
         aj/w7udWmWoxsHeRjUUoOkk7WzXZW4iH/5OU6qGx6mf4KDOcr/2brkEIRB5lW2Qdbp3S
         BVSamVOce95w9tjrDUAeEawHmpNwd+KJWvepnWnzNcPf8YzPrKHj2CJiF8TGz7t5nBvL
         qe1ERML73VvYzfqkmfh61+D7dtPeD2dKEbxdR+txhceDEMaUgr6d86zq7pda/Ktfe3T1
         gGhCPJ1wZk6GfJ8w9s7UvjuPxxSf1FyCr6/6utkZ99BRShndcIeNp0pysN/2EdxhBHTY
         JgbQ==
X-Gm-Message-State: AOAM530lx0qEV1IY7cxd5+LYZfeMj5ePLvnLpodh0Mld3Sl6PVGus46Q
        JeaeZEF3rLZJHZz//3r6gEg=
X-Google-Smtp-Source: ABdhPJxY2csI8jtU7G//w3xPsyByEj3Xe705LcgNd/G71DQdjCLq3w/J9xHNeOK+PGCa+mXPGlOGxw==
X-Received: by 2002:ac8:7612:: with SMTP id t18mr19270274qtq.324.1629487077251;
        Fri, 20 Aug 2021 12:17:57 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:17:56 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 05/14] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
Date:   Fri, 20 Aug 2021 15:17:05 -0400
Message-Id: <20210820191714.69898-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210820191714.69898-1-liambeguin@gmail.com>
References: <20210820191714.69898-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
Add support for these to allow using the iio-rescaler with them.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index d0669fd8eac5..8488f1d83527 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -22,6 +22,9 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	unsigned long long tmp;
+	s32 rem;
+	u32 mult;
+	u32 neg;
 
 	switch (scale_type) {
 	case IIO_VAL_FRACTIONAL:
@@ -40,6 +43,38 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		tmp *= rescale->numerator;
 		do_div(tmp, 1000000000LL);
 		*val = tmp;
+		return scale_type;
+	case IIO_VAL_INT_PLUS_NANO:
+	case IIO_VAL_INT_PLUS_MICRO:
+		if (scale_type == IIO_VAL_INT_PLUS_NANO)
+			mult = 1000000000LL;
+		else
+			mult = 1000000LL;
+		/*
+		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if *val OR
+		 * *val2 is negative the schan scale is negative
+		 */
+		neg = *val < 0 || *val2 < 0;
+
+		tmp = (s64)abs(*val) * abs(rescale->numerator);
+		*val = div_s64_rem(tmp, abs(rescale->denominator), &rem);
+
+		tmp = (s64)rem * mult + (s64)abs(*val2) * abs(rescale->numerator);
+		tmp = div_s64(tmp, abs(rescale->denominator));
+
+		*val += div_s64_rem(tmp, mult, val2);
+
+		/*
+		 * If only one of the rescaler elements or the schan scale is
+		 * negative, the combined scale is negative.
+		 */
+		if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
+			if (*val)
+				*val = -*val;
+			else
+				*val2 = -*val2;
+		}
+
 		return scale_type;
 	default:
 		return -EOPNOTSUPP;
-- 
2.32.0.452.g940fe202adcb

