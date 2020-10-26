Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EAD298E17
	for <lists+linux-iio@lfdr.de>; Mon, 26 Oct 2020 14:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780247AbgJZNg0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Oct 2020 09:36:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39585 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775552AbgJZNg0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Oct 2020 09:36:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id d3so12501737wma.4
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2020 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjmXhl5JLo4J/PxFbte5j14dKUd6PJral95QAT5RzjQ=;
        b=AE5uYd3q/mN+YF+UoNFzyWfn2e6aNplcHY2J7LSmHYbHDV+AteEfF4NyzxqqRYZoBc
         n/H3yCCMtcPvc+nEf7l1mv8FXlr1u6Z4ulvrO6bNG5QpWlJOX47vTf9rnpKY9axYH6n2
         Lzlc+XzrljZQ7kifz3e3pRSUIOy6S64I4iKJuRFuQNVTB/yLAIgOUqIc7ZB6+jmZZmYU
         GrFyTr66j9EF9wpV0uVqawEulSwlRpU4G8o2LU0rE1udCvyx0DV1kIEjDiG0YhykpLEd
         4F4QKwsvlMIPm5ZU6OuSE8ElztOAfmqCVI07OgFG+S66sRWCr4pILeNQf+AedtxFXQZF
         uQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CjmXhl5JLo4J/PxFbte5j14dKUd6PJral95QAT5RzjQ=;
        b=Upuw6tdGmjcf2XhFzWr0Ire24O39qmLUb4ZG8a4w1MWG4WoPT7ezFaeRVOUw2Em/a5
         LP8tq73MDK01nL0naO+aRYVaQm2dzI+JivUR30q8vynMkEioywowoVT8wwYCiNO3vBvb
         Lst/iO1mQYdLsVoeGXRDgHVJa0ZuadOV9GQoHXusDCwLKUp32p4GyMDUoxxaa6AuuWG8
         weYQFhFO2LXxx0pqDevPBJLMqwZ0Rvg5j30Fawabd3l8oyug5atNlbnoiHu5Wnsaqz9T
         ukqPkHXV0sTC8bqLcjJW1aE6THK0zGdBAj07QtHNS3+06k+lZO4fJ3w7c/bqYQ/O/o9l
         WSaw==
X-Gm-Message-State: AOAM532LwlYuwT/ebRVbBiB/lY5opec7CMZLDAoTZD+iOYEEGTaGsXh+
        kHLxiokyafbZW3WZf6H+exEZtw==
X-Google-Smtp-Source: ABdhPJyx5XmliVgkj2HH8RoBGVNGyWBgD1WUqyjfZC8wakM0iZX/XJLYW/tw3KdwIN2ATgE39WAaww==
X-Received: by 2002:a1c:48c3:: with SMTP id v186mr17231235wma.16.1603719383782;
        Mon, 26 Oct 2020 06:36:23 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id f7sm23688991wrx.64.2020.10.26.06.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:36:23 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/5] iio: adc: xilinx: use devm_krealloc() instead of kfree() + kcalloc()
Date:   Mon, 26 Oct 2020 14:36:06 +0100
Message-Id: <20201026133609.24262-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201026133609.24262-1-brgl@bgdev.pl>
References: <20201026133609.24262-1-brgl@bgdev.pl>
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
 drivers/iio/adc/xilinx-xadc-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 8494eb424b33..b516280ccbd4 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -589,8 +589,9 @@ static int xadc_update_scan_mode(struct iio_dev *indio_dev,
 
 	n = bitmap_weight(mask, indio_dev->masklength);
 
-	kfree(xadc->data);
-	xadc->data = kcalloc(n, sizeof(*xadc->data), GFP_KERNEL);
+	xadc->data = devm_krealloc(indio_dev->dev.parent, xadc->data,
+				   n * sizeof(*xadc->data),
+				   GFP_KERNEL | __GFP_ZERO);
 	if (!xadc->data)
 		return -ENOMEM;
 
@@ -1372,7 +1373,6 @@ static int xadc_remove(struct platform_device *pdev)
 	free_irq(xadc->irq, indio_dev);
 	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	clk_disable_unprepare(xadc->clk);
-	kfree(xadc->data);
 
 	return 0;
 }
-- 
2.29.1

