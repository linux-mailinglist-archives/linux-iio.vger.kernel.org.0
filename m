Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847B334BF70
	for <lists+linux-iio@lfdr.de>; Sun, 28 Mar 2021 23:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhC1VrH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Mar 2021 17:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhC1Vqv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Mar 2021 17:46:51 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F0DC061756;
        Sun, 28 Mar 2021 14:46:51 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id j17so5584072qvo.13;
        Sun, 28 Mar 2021 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4zN45Y9NetQY2opVdga1pvMAszygLa6a/w/iQR/Hj3g=;
        b=WcNWiw37z03fuWilWKrtDkAntPn6lZsVUedAtZeq6OvCR7pwVqqHx6Kg9is7a5udZS
         ZE2ybala+lRhg4/a5wqJ0A78gF+wOOn2HZ7e6LiehYVI04/mv72LdIDIBystTF7/CH+B
         B9D0XbFAyBUB5G5uC7n369pxOtmBacGT6wKSC+mUVcGC3HwGHwAyCwIfzrHPqlK8/i9M
         lLvkeKdYmalcTn1AOZaIIcs8Z6hdxjfLV8zxUgqYNfLbU1/OHPzRSlxBb1ztFeHHbRd2
         LavmCGDYBipgntdVqJi+e1/BiG+BBfKs9ncAGQRbWnhBAAubQ6W3BzrfdFzpxznLFuhx
         zJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4zN45Y9NetQY2opVdga1pvMAszygLa6a/w/iQR/Hj3g=;
        b=j9MRMwojIgP0Dhb52HbPWmR3V9Udwuxhh9q4ViMZOyFfwjaSlvOZVgbJJ3892NUhd2
         4KBsoxpvDBbYqxcZCxu3LKtKc+YEKtlNIBddoOE3GHz0X2aSo+3jiq+KBd/Z1P0RPkqY
         8A3+CqRRRGOffC8ahnNsJsM4U+2Q8zhoUCWckBB8xHbzmtZ68rxgK/J78b3r/oJ6eseW
         rDHyFJ02BXtobKaNMeThdRpgQwg7MM4KtjdWse+KQQovFzB/ecbYDJhE9i69+lmVscL6
         pL2+B0qp58U23o2HHFsErCdb+7tllm/HnT0lUmoJE1sirIEYTNlZGJMzqi1oZ+Wvnj7L
         PJqw==
X-Gm-Message-State: AOAM530VaclKQxNoJNL26CYPyz3lEyt6VtCxuX4Vda6t8eM3vOBWNNjM
        Y4m+LRARz7LkbRqjBmeFOp8=
X-Google-Smtp-Source: ABdhPJwXFnluIQeo82omzQhVXzNeL7ImgxHRHs+wALolYNDjgn38LTG9xlnYDjSyPd4vkkwY0bJ3Qw==
X-Received: by 2002:a05:6214:80a:: with SMTP id df10mr22731789qvb.46.1616968010307;
        Sun, 28 Mar 2021 14:46:50 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9e91::1002])
        by smtp.gmail.com with ESMTPSA id b12sm9910080qti.43.2021.03.28.14.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 14:46:49 -0700 (PDT)
Date:   Sun, 28 Mar 2021 18:46:46 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: adc: ad7923: register device with
 devm_iio_device_register
Message-ID: <b0146465d52f4e259f5f95c83c71e72f065093da.1616966903.git.lucas.p.stankus@gmail.com>
References: <cover.1616966903.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616966903.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Registers the device using the devm variant.
This is the final step of converting the ad7923 to only use devm routines,
meaning that the ad7923_remove() function is no longer needed to release
resources on device detach.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 drivers/iio/adc/ad7923.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index d07eaf3111ed..f7af2f194789 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -356,16 +356,7 @@ static int ad7923_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return iio_device_register(indio_dev);
-}
-
-static int ad7923_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7923_id[] = {
@@ -398,7 +389,6 @@ static struct spi_driver ad7923_driver = {
 		.of_match_table = ad7923_of_match,
 	},
 	.probe		= ad7923_probe,
-	.remove		= ad7923_remove,
 	.id_table	= ad7923_id,
 };
 module_spi_driver(ad7923_driver);
-- 
2.31.0

