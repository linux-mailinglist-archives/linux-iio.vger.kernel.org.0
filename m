Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797672DEB7F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Dec 2020 23:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgLRWU6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Dec 2020 17:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgLRWU6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Dec 2020 17:20:58 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DDFC0617A7
        for <linux-iio@vger.kernel.org>; Fri, 18 Dec 2020 14:20:17 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o19so9318248lfo.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Dec 2020 14:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nBJw5V5zd2uYISGPXP0zWHf3OtufiP9E/K+7pvCrjD0=;
        b=FZBCPnjnx5AjpUUozo1gHqwSd/UJnpxti3PBagDdMl2A5YAjQfhnx6+ibsP1I+aFSD
         Bjgge6o2tw2T4+CjLXvj6dl38ILxFlJSWr4BTmfQgL/sdbKliIqhsNfmGQVn8jpbUoXS
         1iQ0eA8XOpq/f4eXQt2sp26HvZk7fzrANhxehUQa3+Lty4p2AIrDMOIeCWbcum03wCvY
         VA/tOGyUOi6rCpWmZm9kKPf5DFjCLf2WunXUitaBAhvGUuOHk2A8V2TKNpvN9CGEPdn3
         0V0NvkNh1pZ61c42ESAf5lmrq6OmrcKeFSlFhfhqw76EyRp4SHnLD3xU3JN0C5hfAjVQ
         bKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nBJw5V5zd2uYISGPXP0zWHf3OtufiP9E/K+7pvCrjD0=;
        b=H7lmoDNPA7qpF12fwoqgL48jGL5pdG4txy/nRLrYM1hQbvRYa6EBwevvMI//HAzWJB
         wj8T8kIsGU5v9HQRw1NPRXSbBVb1XaflA9aboyQD7rvnm+JtHVjiH8ICKYrLSvmaAIE4
         u/3Ho20QQYYG1amPpkFY5Du3jmdmhxJ8w/oJQeYhLEi6l5Hg5v0YPIPXJW/RidC16z3S
         AziDGL7HnUhSneNpNbsVtsaSiZgf+UkZhZA5t5CqDjW6Dvp8k/FGCLI5tde1eyYlakJE
         Uaqiqv/FtT1zlYKxrJKpF3IxRXNfEyF6FtIkQXmpA2TPD0ZMhqk43wkNotaGadfRzQt8
         cp+A==
X-Gm-Message-State: AOAM532aea9bS6ZK/ZEUIQ5WpQ84l+CYVfmy3wqkAfybrCyYh6TfLJGl
        5PiTHdr8NlYOpAw5SxwIRO3U0w==
X-Google-Smtp-Source: ABdhPJwcmyhGxIoIo715psTRsUeDG3SiKhfDUnzYim26pmyanAGev6RFyhzoaMOf/AcvNZcrNma2hw==
X-Received: by 2002:ac2:46ca:: with SMTP id p10mr2151804lfo.53.1608330016234;
        Fri, 18 Dec 2020 14:20:16 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id l7sm1186773lja.15.2020.12.18.14.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 14:20:15 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: adc: ab8500-gpadc: Support non-hw-conversion
Date:   Fri, 18 Dec 2020 23:20:13 +0100
Message-Id: <20201218222013.383704-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The hardware conversion mode only exists in the AB8500
version of the chip, as it is lacking in the AB8505 it
will not be in the device tree and we should just not
even try to obtain it.

The driver already contains code to avoid using a
non-existing hardware conversion IRQ at conversion time.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/adc/ab8500-gpadc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index 1bb987a4acba..6f9a3e2d5533 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -1108,10 +1108,14 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 		return gpadc->irq_sw;
 	}
 
-	gpadc->irq_hw = platform_get_irq_byname(pdev, "HW_CONV_END");
-	if (gpadc->irq_hw < 0) {
-		dev_err(dev, "failed to get platform hw_conv_end irq\n");
-		return gpadc->irq_hw;
+	if (is_ab8500(gpadc->ab8500)) {
+		gpadc->irq_hw = platform_get_irq_byname(pdev, "HW_CONV_END");
+		if (gpadc->irq_hw < 0) {
+			dev_err(dev, "failed to get platform hw_conv_end irq\n");
+			return gpadc->irq_hw;
+		}
+	} else {
+		gpadc->irq_hw = 0;
 	}
 
 	/* Initialize completion used to notify completion of conversion */
@@ -1128,14 +1132,16 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(dev, gpadc->irq_hw, NULL,
-		ab8500_bm_gpadcconvend_handler,	IRQF_NO_SUSPEND | IRQF_ONESHOT,
-		"ab8500-gpadc-hw", gpadc);
-	if (ret < 0) {
-		dev_err(dev,
-			"Failed to request hw conversion irq: %d\n",
-			gpadc->irq_hw);
-		return ret;
+	if (gpadc->irq_hw) {
+		ret = devm_request_threaded_irq(dev, gpadc->irq_hw, NULL,
+			ab8500_bm_gpadcconvend_handler,	IRQF_NO_SUSPEND | IRQF_ONESHOT,
+			"ab8500-gpadc-hw", gpadc);
+		if (ret < 0) {
+			dev_err(dev,
+				"Failed to request hw conversion irq: %d\n",
+				gpadc->irq_hw);
+			return ret;
+		}
 	}
 
 	/* The VTVout LDO used to power the AB8500 GPADC */
-- 
2.29.2

