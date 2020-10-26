Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A78298E21
	for <lists+linux-iio@lfdr.de>; Mon, 26 Oct 2020 14:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780220AbgJZNgs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Oct 2020 09:36:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34831 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780249AbgJZNg2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Oct 2020 09:36:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so12604705wrq.2
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2020 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ELZQG2NaQttMYr9kJgm589fBatjQILmOfzJPCuqc5Y=;
        b=UnKuxJDLDxWVkgZLJZaKbCEGY8XmPdeCTb13G4N7oB+0BCGxI2N1raabhO7DLxB9gt
         baq0L2TyGPLzvLPriFZb6iprKVze14yzvC2oi0IHGX0VQ7eIziDOOfHhkHGhjZ+/pG+J
         DRrMOkin1ClHgXmGdfzMQkZOEhyDXcwGJn1RODHk8RkTyLURuFYcdBZcIoVFMOUXQ6sW
         mqF8fDmb/NRHoxLyR/+p572ecPm48+Vr+2Wp7uqv6GIKKdaQHv3CoJXZADWcgXwgplrm
         rrowddeaQhtAnDT9f4njAIUti8jdp9hszOl0iCQEXAqh0vqql92EqKpeugFKcb07SoOa
         8Lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ELZQG2NaQttMYr9kJgm589fBatjQILmOfzJPCuqc5Y=;
        b=HDyCvWlHVr5eZVG5PjzUNegwodK0wUqROtDLKF4baDO+XcSx1on9Izp8gWNFalOZ8f
         pJBfZ9twYeY+BLZY/xsfSza9eF7hWVKOwiKxS9W1lgYPsukcBh2M9bHfAz0N3RQRIli0
         VR7y3fL3OCh+k3tXyZmYFTYbyPAOmz2O4Kpfkn4JGd6PWLPQA/CF/qk7ggl3SGQ4zNuM
         /I1l8OfoPFAOGPL/m0FbYfaZnBYYVEeRovCVswBUVVgfRvdAkk7pBVlikuKTVOTeXH3O
         +D7ZrYAuYSKMrWVizLuj5arLGO+zUbSU3xgMjgW+28zczxggcxnmbtz5VyFY/o/o5W00
         Ki8g==
X-Gm-Message-State: AOAM531SwYEN6zA4bpuC0dB421Eu1WN8/Bly80DdjG0cCsBeQcHNlMPw
        8X7rJQzvlXXdVI3sgF6KDd4tPlXOLIfxvQ==
X-Google-Smtp-Source: ABdhPJxhDAD5/YV5fDmGymJd9GlecQXRex3X8eVcy0qKcqKJI+LHTdOXOv7purW24dthsFu4Ih1bUA==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr18112929wrw.370.1603719386608;
        Mon, 26 Oct 2020 06:36:26 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id f7sm23688991wrx.64.2020.10.26.06.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:36:25 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/5] iio: adc: xilinx: use devres for irq handling
Date:   Mon, 26 Oct 2020 14:36:08 +0100
Message-Id: <20201026133609.24262-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201026133609.24262-1-brgl@bgdev.pl>
References: <20201026133609.24262-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Further simplify the remove() callback and error paths in probe() by
using the managed variant of request_irq() as well as using a devm action
for cancelling the delayed work at driver detach.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 35 ++++++++++++++++++------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index e0da6258092c..4440b7a9bd36 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1192,6 +1192,13 @@ static void xadc_clk_disable_unprepare(void *data)
 	clk_disable_unprepare(clk);
 }
 
+static void xadc_cancel_delayed_work(void *data)
+{
+	struct delayed_work *work = data;
+
+	cancel_delayed_work_sync(work);
+}
+
 static int xadc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1289,14 +1296,19 @@ static int xadc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
-			  dev_name(dev), indio_dev);
+	ret = devm_request_irq(dev, xadc->irq, xadc->ops->interrupt_handler, 0,
+			       dev_name(dev), indio_dev);
+	if (ret)
+		goto err_free_samplerate_trigger;
+
+	ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
+				       &xadc->zynq_unmask_work);
 	if (ret)
 		goto err_free_samplerate_trigger;
 
 	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
 	if (ret)
-		goto err_free_irq;
+		goto err_free_samplerate_trigger;
 
 	for (i = 0; i < 16; i++)
 		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
@@ -1304,7 +1316,7 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
 	if (ret)
-		goto err_free_irq;
+		goto err_free_samplerate_trigger;
 
 	bipolar_mask = 0;
 	for (i = 0; i < indio_dev->num_channels; i++) {
@@ -1314,17 +1326,17 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(0), bipolar_mask);
 	if (ret)
-		goto err_free_irq;
+		goto err_free_samplerate_trigger;
 	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1),
 		bipolar_mask >> 16);
 	if (ret)
-		goto err_free_irq;
+		goto err_free_samplerate_trigger;
 
 	/* Disable all alarms */
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
 				  XADC_CONF1_ALARM_MASK);
 	if (ret)
-		goto err_free_irq;
+		goto err_free_samplerate_trigger;
 
 	/* Set thresholds to min/max */
 	for (i = 0; i < 16; i++) {
@@ -1339,7 +1351,7 @@ static int xadc_probe(struct platform_device *pdev)
 		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
 			xadc->threshold[i]);
 		if (ret)
-			goto err_free_irq;
+			goto err_free_samplerate_trigger;
 	}
 
 	/* Go to non-buffered mode */
@@ -1347,15 +1359,12 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto err_free_irq;
+		goto err_free_samplerate_trigger;
 
 	platform_set_drvdata(pdev, indio_dev);
 
 	return 0;
 
-err_free_irq:
-	free_irq(xadc->irq, indio_dev);
-	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 err_free_samplerate_trigger:
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
 		iio_trigger_free(xadc->samplerate_trigger);
@@ -1380,8 +1389,6 @@ static int xadc_remove(struct platform_device *pdev)
 		iio_trigger_free(xadc->convst_trigger);
 		iio_triggered_buffer_cleanup(indio_dev);
 	}
-	free_irq(xadc->irq, indio_dev);
-	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 
 	return 0;
 }
-- 
2.29.1

