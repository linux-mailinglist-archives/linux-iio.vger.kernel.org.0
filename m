Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EE82C86B2
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 15:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgK3O3A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 09:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbgK3O3A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2020 09:29:00 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4423C0617A7
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2020 06:28:14 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so18643515wmc.5
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2020 06:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YC+CHaCok09rYh/O6VeZFt906CZ5WncrdXBXZsu9Deg=;
        b=x0oInSN5K0DGybItSGSqgocXAKsO59Tv43WwTYl2mFz+HUgmEdGSZx8FctCdW+C92C
         pJIp3ryu/Wyy5XmVBOFcLcHDfIdsGnINxK9zcwNSkDqqK15ggpG1N3ERtg7aymUFEmr6
         HudBQPGsbVNYbktGhwOw7/KJVsD6drHpctT83bbLkycNjPyLykFfBdCeX6W1eNCa1tLL
         ZQnwg3UucEj7vpp1Fi6bTcoMQWCVoASU7k37a1pfiUY9BMyHeQ6dfO5vY0Kg0sDENuu0
         5EtRvVWmlufM6tOqzAwIRFVL092QR7sM3OGY6p/IMYh7t+INxdKE8UosxJw5SKvS0jIW
         XYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YC+CHaCok09rYh/O6VeZFt906CZ5WncrdXBXZsu9Deg=;
        b=TNf6MBmhnWD3/03PUOcH9r+kzR9EylELsa9c48dFvh6IjvVox/5jDsk812QipZm9oj
         YK/Dl/EXKk86r58odxIe+g5h8RIVqlD1rcsj2BaB+wWtDAJ2HvJFHNgt2YguIOLphgpX
         NHISwPjTboSClYSODZ0cvH7GprPqj/y65ep+lULArHgRoYp9ZyolMclYplPW+S8DjMZD
         HvrHGhU7aERlvKHTdoYHpocOrIzgAinB6BPaDJdu3ECLevX3QmXgIC/4MPa2GUsyD41D
         lXIbH1mvDKzgpGycZ0iPOhbY9AMrJzLMJGAzZTK3J0stTiRNg/pfLa2sfnuUEiYgkOzk
         Zigg==
X-Gm-Message-State: AOAM530pCuUtAoeNuXgw8o34+n23vwLQQ7nkAcy0nYgiwFjKBWZr65U5
        TUO1NGNbeF0yk5MJ308+Z2zA7A==
X-Google-Smtp-Source: ABdhPJyQFIZ33gaXyeO/XB+ll3rZvsk+O2uAhu3h1EtSn3BIE/hzSR7hvSSXXS+PqnDmhPSd+Od8uw==
X-Received: by 2002:a1c:b107:: with SMTP id a7mr23490658wmf.121.1606746492513;
        Mon, 30 Nov 2020 06:28:12 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id p19sm29446044wrg.18.2020.11.30.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 06:28:11 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATH v3 2/3] iio: adc: xilinx: use devm_krealloc() instead of kfree() + kcalloc()
Date:   Mon, 30 Nov 2020 15:27:58 +0100
Message-Id: <20201130142759.28216-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201130142759.28216-1-brgl@bgdev.pl>
References: <20201130142759.28216-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have devm_krealloc() in the kernel Use it indstead of calling
kfree() and kcalloc() separately.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 8494eb424b33..6f89a97bb127 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -585,15 +586,22 @@ static int xadc_update_scan_mode(struct iio_dev *indio_dev,
 	const unsigned long *mask)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
-	unsigned int n;
+	size_t new_size, n;
+	void *data;
 
 	n = bitmap_weight(mask, indio_dev->masklength);
 
-	kfree(xadc->data);
-	xadc->data = kcalloc(n, sizeof(*xadc->data), GFP_KERNEL);
-	if (!xadc->data)
+	if (check_mul_overflow(n, sizeof(*xadc->data), &new_size))
+		return -ENOMEM;
+
+	data = devm_krealloc(indio_dev->dev.parent, xadc->data,
+			     new_size, GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
+	memset(data, 0, new_size);
+	xadc->data = data;
+
 	return 0;
 }
 
@@ -1372,7 +1380,6 @@ static int xadc_remove(struct platform_device *pdev)
 	free_irq(xadc->irq, indio_dev);
 	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	clk_disable_unprepare(xadc->clk);
-	kfree(xadc->data);
 
 	return 0;
 }
-- 
2.29.1

