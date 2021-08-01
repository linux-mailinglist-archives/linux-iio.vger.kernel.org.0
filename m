Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18D13DCD58
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhHATk2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhHATkZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:40:25 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA6DC0613D3;
        Sun,  1 Aug 2021 12:40:16 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id x3so14740172qkl.6;
        Sun, 01 Aug 2021 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hlz1mlRz0pIJ2/uHlMEkfOBEElQWI/RnQqjZdJLYyew=;
        b=oISa7DuCKwko9vd6uCu7LUGn+NDiJeJyTVxDcHYTHFiz2bFiXCG8mlP7JOtJnFbkoZ
         fVv4G/cn2DSFqOO9QsAOC+pzs6LPDMQv1ot1EaER49NYhyaTnjHg28VJZ9hf53RdhTPm
         K5zwb68ZcIsMA7QJAGXDvF+3jAC/j/dE6+wl/HFBsdBtAaEQ+DzIVKC8wJglrNqj3aDF
         Gqc9j1sYrU7VfNRR8VYqNCPJvzKR+PCdmK2mW8d7IwCPZD3X505bV/GDMgcfn9t8pQCE
         FmGXLcZ2m8uzgHwHFtdPSWLAwpOR+QRzlVyuIi49iv/9gdBSQZRMfD7rn3yn2f/3WBQ1
         Z6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hlz1mlRz0pIJ2/uHlMEkfOBEElQWI/RnQqjZdJLYyew=;
        b=a6llzC3eXzYKAwdSki4nm2eNNDG6iCjg24CuhLWIsGMDlr8n106EYyR2K/jJ8fT2mN
         EYC6fAyQc0MjXJbGyoDCfC/gx8zw4jLNmkodXkr93IXdCWsFdHc8FwCxfe10Hta807oA
         1rDpzG2XGgJ0+jDiZ3gd4XOx1/hGoItwyLBvgBEp6oMZr05qmdRSQemn8BHMWkoqgj8t
         pZmrRWUXM9XtKonmxlXY7kaMrHaALYazH7uIokmlcukAYHLHPW98vGF4XxO/g+BnyX83
         /F4xYJ01A/JqA7MIwzxEDejFE0RZQlJCIH6yaUjXhjFIttCi2z0J0lGRa1gTDJ5zxVxb
         Dshg==
X-Gm-Message-State: AOAM530r5lFRAmzhJu+awLqti/H9I55zekhoF18FBp15IMWNzUih8siB
        I5Vx5gUQjFiUt27ToI5kdyM=
X-Google-Smtp-Source: ABdhPJyQv2g8CrhE2Dufi5BzY3omQa53Ek9urWQnc9Lc1jkk3nini1/rKqwSUmvQAw+tBjoneUWEhw==
X-Received: by 2002:a37:a004:: with SMTP id j4mr12193562qke.499.1627846815634;
        Sun, 01 Aug 2021 12:40:15 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f10sm3621606qto.31.2021.08.01.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:40:15 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v7 05/13] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
Date:   Sun,  1 Aug 2021 15:39:52 -0400
Message-Id: <20210801194000.3646303-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210801194000.3646303-1-liambeguin@gmail.com>
References: <20210801194000.3646303-1-liambeguin@gmail.com>
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
index d0669fd8eac5..615f5d9cbb8b 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -22,6 +22,9 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	unsigned long long tmp;
+	u32 mult;
+	u32 rem;
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
2.30.1.489.g328c10930387

