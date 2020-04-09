Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB41A36AA
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 17:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgDIPLo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 11:11:44 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39393 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgDIPLo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 11:11:44 -0400
Received: by mail-pj1-f67.google.com with SMTP id z3so1394297pjr.4;
        Thu, 09 Apr 2020 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=Uyv/46Juj5lfxcr3X6PKHvpdHN5/CAT3a4tPfLzARdM=;
        b=pnlwXTJGzos2ogii+pXTu2z1dU1WlWajjcD9NxY6gBuekvamSXZTdOZiB/DAIr/wsH
         TG87wBTFk5jBzdeez1DuQe6H6DlPvRz4GFgceEaeQh/ruyeiVhR610KoG+WIVAPBOuIO
         +u4jh/ujyvta9oWDtpzEXQM/q9HoIPXemre6qYRz6cS2LROgykzVj0GNZ4fatX8G9NEP
         7Ql5ru+fn077/80MqdqcJUNH/lVJkwUj13GxCT0zP/L/Craz1AXpgAYn+oK6nUkK8mfz
         jweku9IBKesjmlxrvRlH43f9PJrAgcwzUz21KqToVjydwo+jPyj4+CJMcTJbdWTiDGlA
         wlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Uyv/46Juj5lfxcr3X6PKHvpdHN5/CAT3a4tPfLzARdM=;
        b=j7BMHSpyvCtATkcuU1tXB5aM20cNmid5dkzW2c+2oewlvnoc1EJ54YDYSGeHHTHJ/Q
         LBWeRUu99YQNE4WCyVBqedJ35wxzIZ3pfzfxUk4Nv9OInEPq0ih5ru1qLBfUG+3OW2QR
         6YrqSnCeKxuBNk9P9G/ilG6exHBGkSUkYkWqoLbPHYT0GtVXjw7BboB1DRJ158YfDZ+a
         hq54qlssn1tCWsVK0dNNgaiC231VAGeF/wWK8m8xnBvWQX4FcH+bUJExBcfryeXxsGbW
         0rQRBBPKva4AEWFDe1qUxUcxN8AWhmUpthet2SC0+BZr/ghXovuRQgpuzgeH+r3YTwOT
         5E7A==
X-Gm-Message-State: AGi0PuY/ZzsRdwcvZAi4cgbY/L0oAG4Nol4CryOjwREoi6pM0d+qcqDS
        og7inRDdNekx1e9pr6Y9dio=
X-Google-Smtp-Source: APiQypIRB49qL8jGLWw50RsGEtKpAFea2tTVz3FzmbuF4LyW3fyWIJKa8TcU+jZhRNPayvyUyvafUA==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr91051plo.12.1586445103298;
        Thu, 09 Apr 2020 08:11:43 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:700:a20f:d50:b01b:c4e4:35ad])
        by smtp.gmail.com with ESMTPSA id s39sm2493358pjb.10.2020.04.09.08.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 08:11:42 -0700 (PDT)
From:   Aishwarya R <aishwaryarj100@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Aishwarya R <aishwaryarj100@gmail.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: at91-adc: Use devm_platform_ioremap_resource
Date:   Thu,  9 Apr 2020 20:41:23 +0530
Message-Id: <20200409151125.32677-1-aishwaryarj100@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the helper function that wraps the calls to
platform_get_resource() and devm_ioremap_resource()
together.

Signed-off-by: Aishwarya R <aishwaryarj100@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index abe99856c823..0368b6dc6d60 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1152,7 +1152,6 @@ static int at91_adc_probe(struct platform_device *pdev)
 	int ret;
 	struct iio_dev *idev;
 	struct at91_adc_state *st;
-	struct resource *res;
 	u32 reg;
 
 	idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct at91_adc_state));
@@ -1182,9 +1181,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	if (st->irq < 0)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	st->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	st->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(st->reg_base))
 		return PTR_ERR(st->reg_base);
 
-- 
2.17.1

