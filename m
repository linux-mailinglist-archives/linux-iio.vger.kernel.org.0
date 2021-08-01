Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6F43DCD5D
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhHATkb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhHATk1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:40:27 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F87C0613D3;
        Sun,  1 Aug 2021 12:40:19 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id d3so7920605qvq.6;
        Sun, 01 Aug 2021 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r9noamx1Lea6uM4ckRlZuCQifseImk8SgpqIftuzmWw=;
        b=rU7aL0sXno4InxJ3qI7n0CaL6/QT223xMb5SMKSH1a/08QZWB6INzjeZq4RfQhJygg
         Agqkmj7nUPOL1+qwyrNvFPIWqfMhuyqhFs957ufw9ZzSYIhLWRXvHPYVCbSQaPsu3Csp
         Mg+kowc75abuhjnQI1PHaKcJg5XCwF0jIUCohL1gY/8N7jW7A6jzHc11ShTSoZo2DnNo
         7GHDVmh8JaSO9AMpyNa3LLZyYHNdHUfsS4X4L0mSSQSMfvBnQqoEXHSVTVdUMllz1ijQ
         W7sYMzifcT9iM5kBzgZgMh7rGQ6BK82/Id2YrTXZcw8meXaTiidGqyThDHZDSk4amg4I
         htYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9noamx1Lea6uM4ckRlZuCQifseImk8SgpqIftuzmWw=;
        b=IoHGGryTgmWmvWZ8bjSc4F3KRSGWKZhWaiBSopiUe+Es29O0v/v08RhnKWAT0IBSgA
         f71v/dgKIKCdxLz0nkeJ/Krr/Iw4CuT1kWjOQmLsvAu9TnSfy/qvcz4rbKODdebhjycn
         1IMAy7EhSQQ8WGsTbbxuI4UeWdFDPnhpMWeeJsQ3ysyO5m4t1azl+Ap+4+C4/dMbGNHX
         nSEK+lUS7xyI4Yy4ucxfWNLQWjG4ZoRyH3bbVteHj/1OoZpoPAfohCvQ+btX8dVQsQtk
         yoDoObBSGf5rLtT+L63gt+5Fs5UwUpQtxluahluLG2VxaKHC51yaMnJxDYQQ+G5MtIEL
         /NJg==
X-Gm-Message-State: AOAM533f2r8Io+yxUHG/MamLk6XTx9NplBAIp1hLaQW4fvdKud5x0T/x
        Ka35h2OxY9woofWrbPSMNNQ=
X-Google-Smtp-Source: ABdhPJzxuNUFugRAkv2VJtND5tNBzLF/XUF76s37o8ZAT/Wo4GTzUv5JdIQ3XZhKKjtlrpqpJ2pwEg==
X-Received: by 2002:a05:6214:3001:: with SMTP id ke1mr13377381qvb.52.1627846818542;
        Sun, 01 Aug 2021 12:40:18 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f10sm3621606qto.31.2021.08.01.12.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:40:18 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v7 08/13] iio: afe: rescale: fix precision on fractional log scale
Date:   Sun,  1 Aug 2021 15:39:55 -0400
Message-Id: <20210801194000.3646303-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210801194000.3646303-1-liambeguin@gmail.com>
References: <20210801194000.3646303-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

The IIO_VAL_FRACTIONAL_LOG2 scale type doesn't return the expected
scale. Update the case so that the rescaler returns a fractional type
and a more precise scale.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index abd7ad73d1ce..e37a9766080c 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -47,12 +47,17 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		*val2 = rescale->denominator;
 		return IIO_VAL_FRACTIONAL;
 	case IIO_VAL_FRACTIONAL_LOG2:
-		tmp = *val * 1000000000LL;
-		do_div(tmp, rescale->denominator);
-		tmp *= rescale->numerator;
-		do_div(tmp, 1000000000LL);
+		if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
+		    check_mul_overflow(rescale->denominator, (1 << *val2), (s32 *)&tmp2)) {
+			tmp = (s64)*val * rescale->numerator;
+			tmp2 = (s64)rescale->denominator * (1 << *val2);
+			factor = gcd(abs(tmp), abs(tmp2));
+			tmp = div_s64(tmp, factor);
+			tmp2 = div_s64(tmp2, factor);
+		}
 		*val = tmp;
-		return scale_type;
+		*val2 = tmp2;
+		return IIO_VAL_FRACTIONAL;
 	case IIO_VAL_INT_PLUS_NANO:
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_type == IIO_VAL_INT_PLUS_NANO)
-- 
2.30.1.489.g328c10930387

