Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D363C9639
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 05:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhGODPh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 23:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbhGODPf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 23:15:35 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F53C061760;
        Wed, 14 Jul 2021 20:12:42 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g8so3556201qtj.1;
        Wed, 14 Jul 2021 20:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLWy0WK3+ERUVTzvLsLdoDiohksSvGaMH/lm8OdurSg=;
        b=fJiKfBdFQonXOMJ2QOZC9NrQf65f+pBqU/sjEOoUx2qPRgqTzs7TAtA6gB5p5yyi8m
         MVhrGXTJhaedinyYqEI6XP9wKi/+xIjvP58GNDLBSoFcf7wo2fcsBrUJgc77uVaVY4Tu
         V/YgvhdfWD9mOqmpptgxPVkMK0ZIPFxRpXRX/F5fpQzflvCVc/siRrjVFHJGwsiDRTZK
         d0Azlgpdnz9dOLwjwplRYM3Pg+8sLmCnOMLuj3/PM21l4S4rlaOFpF/ojCs+5XbsUAZz
         ORpjArA1kaqgYps88mr3k5k1i9vImAR5EMNeeMDcv67WJvXEpRNpHD4kg2smsRLsSUNE
         gc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLWy0WK3+ERUVTzvLsLdoDiohksSvGaMH/lm8OdurSg=;
        b=oJaoukPxFyOptxBWK7QnNmYyGsXGfc74V14d9oJEneux9i/xdZE73ljjICqiEddArb
         9MqKCg6CpEM5TPUG2cbU86+76ckBCgYG68Q7rLAmn+FVOHEFAT6lD05ZRA7UFLEFAFcT
         2/fewjBo1MjixLzr7924gt65ubxh8YBnL5f1abq6SpUeD5grr4AkkAmxC9oglKVqIFrm
         bvBA6X3dQ27F3X8VvFBgl2df1Ljh31kAZnnYBKDIK/YnTk4jZ8ZsdnCrv9snPgL679Jd
         78p4HjSXi4ExG5vUf2Mijkmd2k351qG+pe+Fe5kJFgr/SlfgRftIYo7XfRKC0ZUEoJ6f
         Cxcw==
X-Gm-Message-State: AOAM532dIJYnHStEbobGj+VH4Uge2DqYCqFxt4YDlYX1TzD+4lrPmnLW
        aHvCzuSIUbdfg8NDg5uPEUw=
X-Google-Smtp-Source: ABdhPJx+5UrwYVMjlXUdPd3/akPUbcWCZSBNSi02lW/icOsZlzzssGlJ+2+tVPp/4tkmU8/u4NxlOA==
X-Received: by 2002:ac8:7fd6:: with SMTP id b22mr788094qtk.235.1626318761533;
        Wed, 14 Jul 2021 20:12:41 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id t125sm1932847qkf.41.2021.07.14.20.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 20:12:41 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
Date:   Wed, 14 Jul 2021 23:12:10 -0400
Message-Id: <20210715031215.1534938-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210715031215.1534938-1-liambeguin@gmail.com>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
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
 drivers/iio/afe/iio-rescale.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 4c3cfd4d5181..a2b220b5ba86 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -92,7 +92,22 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			do_div(tmp, 1000000000LL);
 			*val = tmp;
 			return ret;
+		case IIO_VAL_INT_PLUS_NANO:
+			tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
+			do_div(tmp, rescale->denominator);
+
+			*val = div_s64(tmp, 1000000000LL);
+			*val2 = tmp - *val * 1000000000LL;
+			return ret;
+		case IIO_VAL_INT_PLUS_MICRO:
+			tmp = ((s64)*val * 1000000LL + *val2) * rescale->numerator;
+			do_div(tmp, rescale->denominator);
+
+			*val = div_s64(tmp, 1000000LL);
+			*val2 = tmp - *val * 1000000LL;
+			return ret;
 		default:
+			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
 			return -EOPNOTSUPP;
 		}
 	default:
-- 
2.30.1.489.g328c10930387

