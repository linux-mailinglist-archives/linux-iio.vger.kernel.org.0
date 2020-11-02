Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFF32A2CDD
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 15:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgKBO0N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 09:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgKBOWh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 09:22:37 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1032BC061A04
        for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2020 06:22:37 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n15so14860620wrq.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2020 06:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9A0YZTtyChgf0u6PFbkMOtS/8IXdoUAvGcveYosNg8o=;
        b=Iz+6HeRyJ0MzqEaZdma++F+Cl26ft+hc4SvyuEOwHNxpA9O2d9Ccrt//8K9HHCIGeZ
         PN3iov4vxUF8uIwsXYRP/xOxjR9AG1Icc1aQarzzAZ9ds+u7ghaZnJwLeuYXdoqYJprL
         xB8zPvuA1ahdRu3rRVh598nguAmJqCg2KA4KTNPDisAigjNyFkA8Z/yh0W4W40YktLVg
         bs9JczBvspN3PnSZ738KfquAPGW2rtBneSeDWY2SSINssmt+xct8YHlDqWDp7jPOL6iz
         HGjKojUFxD2tr4fe/2JUXl6sZ7XjLoHEzurMV9I0JIaQxwP7qOFQl8Ps9bd6R/LsA4XY
         CUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9A0YZTtyChgf0u6PFbkMOtS/8IXdoUAvGcveYosNg8o=;
        b=eFYCGUX7vazR729ldll0h70LymKMpuN2XDIw+ZHrGUSa6mu0eIty5z9KtgiqJrL9FC
         dLPG6Tr72PiNK7tbA4PmFooRRKDTCCqkKq1GfQqX6SyKfd4T0opOWyCXhELN5wwFkE3/
         qBuQdKvgNJDoKuC5KBDkCDXjH29LxU13guHX19qvUvCKUF3QAxIm1jMfE5dRv6xtQ/AS
         onhmpVWmDw67lA/RrelnhKgelfbn1TijlOYpNrEeeRy0H5hYgyl3rrBBhFboQb6oaqv+
         C1fwcWQC3Sn/UeKibdt13CEnypG4lTQ27gsZ2P3yaXt+F4DZ7ZqS7cjmfb5dyq1KrtjZ
         FBjA==
X-Gm-Message-State: AOAM5308nIAGFtCisl5LPmWBrVSJ5t/rrIOFHeam5EwsYLfXEwkjQYP5
        gpZNn3ZCepe7fzLhmHtn3Yu6mw==
X-Google-Smtp-Source: ABdhPJzEMMHZfL1mdwXFbBpQAWTyd9NcamKKsSu8d3RLFB6kvwNmlyzoTY0otzx1aVegApUhQc86jQ==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr21799947wrm.251.1604326955882;
        Mon, 02 Nov 2020 06:22:35 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id 3sm16182987wmd.19.2020.11.02.06.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:22:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/4] iio: adc: xilinx: use devm_krealloc_array() instead of kfree() + kcalloc()
Date:   Mon,  2 Nov 2020 15:22:27 +0100
Message-Id: <20201102142228.14949-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201102142228.14949-1-brgl@bgdev.pl>
References: <20201102142228.14949-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have devm_krealloc_array() in the kernel Use it indstead of calling
kfree() and kcalloc() separately.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 8494eb424b33..7792aa4cf9cb 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -586,14 +586,18 @@ static int xadc_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned int n;
+	void *data;
 
 	n = bitmap_weight(mask, indio_dev->masklength);
 
-	kfree(xadc->data);
-	xadc->data = kcalloc(n, sizeof(*xadc->data), GFP_KERNEL);
-	if (!xadc->data)
+	data = devm_krealloc_array(indio_dev->dev.parent, xadc->data, n,
+				   sizeof(*xadc->data), GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
+	memset(data, 0, n * sizeof(*xadc->data));
+	xadc->data = data;
+
 	return 0;
 }
 
@@ -1372,7 +1376,6 @@ static int xadc_remove(struct platform_device *pdev)
 	free_irq(xadc->irq, indio_dev);
 	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	clk_disable_unprepare(xadc->clk);
-	kfree(xadc->data);
 
 	return 0;
 }
-- 
2.29.1

