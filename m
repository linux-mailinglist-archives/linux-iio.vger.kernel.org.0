Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F06298E20
	for <lists+linux-iio@lfdr.de>; Mon, 26 Oct 2020 14:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775671AbgJZNg2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Oct 2020 09:36:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35766 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780241AbgJZNg1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Oct 2020 09:36:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id h22so1409926wmb.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2020 06:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXWR59MruOI4ftzXqa49n6gagW95FuEqQ5BRdlBW3D0=;
        b=BVb3ChlTrKd6RBLbM7FQM9prom3acrYkxX+BkBhdIp5YYz1kU5+7cXLDmQ2i7s+Dif
         Esu1jX49DCMdRmMs03hAYnBBBLUfCE1fdV4J4uDyTsEoM2PC6Uc+WZQPiN8yIGh1Ni4d
         A8oOGmUPlXHj8AwVEIu0HPwQDBhimy505MPCBUGYDB4fyeMv3bOCZsVEG20CKkE5hwRQ
         ym/uK5blzf5j074tXR6+Euos9aafumbqnueCOUHdoVkF9Nrvkz1NYRiyLZp/WatIzrnR
         Qp677pDVNjFTvL03E47ww4HVQkPB3DytSrBRLcaHtHQ/unzySoY/bIM3c7zm/QJ5xie3
         fbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXWR59MruOI4ftzXqa49n6gagW95FuEqQ5BRdlBW3D0=;
        b=oD5BADlZHPfAUwLgxJc8OtuVwR8d+b91EY4c5oPy4KQEtt7MZ/HNw77ZdWE6u9gITJ
         ekZQEWbwZykzV6n+YLnxVYpOUCzWk9X0J0MMffWNj0QbXGiWoby9NW6L66QSAlnjmuAW
         DX46D7VbnUHIRIY0qHQk4Aj7pIU6723xrgKPpTjqJARf4wdVhDQkNDbPa8dhg+lFwcZj
         jUxXLD9voO8ubC/9XOflbgRiM3hjfNWYhLB7N4Zgi/q95o9YYCjHyiHRn9MzMY5EMB37
         3VzPrl+h4ViMBsPnuZ+nbei8nlCbwnO1RT8915FpRdntnacrpZ9YCY4M096/yuZKeVZZ
         xWLA==
X-Gm-Message-State: AOAM533PWTcLo6on9ut9vIsFzeIQTMpOtKHfRbhVaGywef7KGaXx4WhX
        8KI/ti+p+NXYkgg1jnQjQ3GnpQ==
X-Google-Smtp-Source: ABdhPJw6LD69F2GZpzdLF6iY8OEb0BrDX2HHqT/seQxWtD4xu+ljXFDFvPheo8jlC8zEpYAwcDhrSA==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr15804816wmi.120.1603719385163;
        Mon, 26 Oct 2020 06:36:25 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id f7sm23688991wrx.64.2020.10.26.06.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:36:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/5] iio: adc: xilinx: use a devres action to disable and unprepare the clock
Date:   Mon, 26 Oct 2020 14:36:07 +0100
Message-Id: <20201026133609.24262-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201026133609.24262-1-brgl@bgdev.pl>
References: <20201026133609.24262-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

In order to simplify resource management and error paths in probe(), add
a devm action that calls clk_disable_unprepare() at driver detach.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index b516280ccbd4..e0da6258092c 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1185,6 +1185,13 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	return 0;
 }
 
+static void xadc_clk_disable_unprepare(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
+
 static int xadc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1262,6 +1269,11 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free_samplerate_trigger;
 
+	ret = devm_add_action_or_reset(dev,
+				       xadc_clk_disable_unprepare, xadc->clk);
+	if (ret)
+		goto err_free_samplerate_trigger;
+
 	/*
 	 * Make sure not to exceed the maximum samplerate since otherwise the
 	 * resulting interrupt storm will soft-lock the system.
@@ -1280,7 +1292,7 @@ static int xadc_probe(struct platform_device *pdev)
 	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
 			  dev_name(dev), indio_dev);
 	if (ret)
-		goto err_clk_disable_unprepare;
+		goto err_free_samplerate_trigger;
 
 	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
 	if (ret)
@@ -1344,8 +1356,6 @@ static int xadc_probe(struct platform_device *pdev)
 err_free_irq:
 	free_irq(xadc->irq, indio_dev);
 	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
-err_clk_disable_unprepare:
-	clk_disable_unprepare(xadc->clk);
 err_free_samplerate_trigger:
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
 		iio_trigger_free(xadc->samplerate_trigger);
@@ -1372,7 +1382,6 @@ static int xadc_remove(struct platform_device *pdev)
 	}
 	free_irq(xadc->irq, indio_dev);
 	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
-	clk_disable_unprepare(xadc->clk);
 
 	return 0;
 }
-- 
2.29.1

