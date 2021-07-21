Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902E33D0721
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 05:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhGUC1C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 22:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhGUC0b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 22:26:31 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F26AC061766;
        Tue, 20 Jul 2021 20:07:09 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id q15so1065247qtp.0;
        Tue, 20 Jul 2021 20:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvFuB5OUIFHmYXYGJ6m3xV8M488XLtaqGhWB8Fo0+4g=;
        b=K2LHgLhqnaU3AEwamjtgb5YkW/HAdmkf+0JMgoBUvBaQ01NVbmMbWZhyZJ8hfbYSKW
         1yYh/VAQQq9ts4iE3nCiRM69TfKBHmslL+7iLTBf7cmCaSSl/bxKhqLVH8WrPWGzrWqW
         nR8geF44ZQnquh9P32l8uVzC1i+xK3C/AXcWKwwFM3kb4SgDgYS6AA+n0DyfElwHiT/P
         8e+s5ADxz6PndKEb2LuIltbyRdoIYpuex4yC/4J/c1Bejoq0QxR/l/nxgD7WPEpmRr2A
         kLHYMk1YTZ0nDo5YXtgd4jzaduTM0LeXWGBEVxjC31VPkozBjkarsdxJLMGX/IrpZ7/p
         s/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvFuB5OUIFHmYXYGJ6m3xV8M488XLtaqGhWB8Fo0+4g=;
        b=NrIl9s5WhSWxW++6/JcvPR1BVxoOT06DonIO/o0NnRer1/dN/S0tJl8xwDIsYdoN04
         PQUCiv2XM/KepfeaAVMaLAsww231IsPQB1qbPLkYnLw62LwB3PMIHI1FMFGgsdmvV2CS
         SVYcCrwJD5eQWi6eWbFUC3fwwoeIbMVWt8qeIyKRZcqOh/z0Lya6TanWyoE+0cKafFOm
         39CXkM2vDUYMm8wEoiYKgrepTsH/2yCBzTCGDE7N+LTlZ0usIHMtFCGUI1s3aPFdP8ZL
         mBFIauFJ+FhSva6aksuPAZUbCRmTlo6ZWqDCam6wUM9Bad5ECwj2Kqg95E/mRGPbVTd+
         h7dg==
X-Gm-Message-State: AOAM5310qg0SL5PNhVjxbghvBL/1lujBoFFkNkyFid/EHCiArsT56QSX
        6P7xUKynaeG9R6nW1N7KQZ4=
X-Google-Smtp-Source: ABdhPJzwlAXvpv5XALNTDrC7fIGOCR+/RPCmHXkAv/Ucf/N19DiYub+YgIVxZck2DzNLT312xysdgQ==
X-Received: by 2002:ac8:7e89:: with SMTP id w9mr29865082qtj.8.1626836828418;
        Tue, 20 Jul 2021 20:07:08 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g76sm10561024qke.127.2021.07.20.20.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 20:07:08 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 09/13] iio: afe: rescale: fix precision on fractional log scale
Date:   Tue, 20 Jul 2021 23:06:09 -0400
Message-Id: <20210721030613.3105327-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210721030613.3105327-1-liambeguin@gmail.com>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
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
 drivers/iio/afe/iio-rescale.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 35fa3b4e53e0..47cd4a6d9aca 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -44,12 +44,9 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		*val2 = rescale->denominator;
 		return IIO_VAL_FRACTIONAL;
 	case IIO_VAL_FRACTIONAL_LOG2:
-		tmp = *val * 1000000000LL;
-		do_div(tmp, rescale->denominator);
-		tmp *= rescale->numerator;
-		do_div(tmp, 1000000000LL);
-		*val = tmp;
-		return scale_type;
+		*val = rescale->numerator * *val;
+		*val2 = rescale->denominator * (1 << *val2);
+		return IIO_VAL_FRACTIONAL;
 	case IIO_VAL_INT_PLUS_NANO:
 		tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
 		tmp = div_s64(tmp, rescale->denominator);
-- 
2.30.1.489.g328c10930387

