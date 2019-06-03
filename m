Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D2D33921
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 21:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfFCTfZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 15:35:25 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43516 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCTfZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 15:35:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so1218999qka.10
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0g9ugQG0sAP10Eo+U/PQ6hS9dDpWYGb5C09T4WP9hqk=;
        b=cidDOwm/pSisEm8lZjFsnvweBbyPndNfSDURR0yfUP/XXYuRNXWdlKm5b48g7IFYBe
         ItD+RAZfuxCRn0UawIGzzhrv5o4s+USisEc2dgRl8WJEjsEJkTEkffj4qWbnoY+T68nH
         JHm6Qe2fdXpMre1x9zXZRs7+m4AwTqp+MtAucvWBpSKowLAsVXAbEkS6C+2pKfBEnNGE
         +KjqaGidrnl9fGvWDE3sXyH8tVqQ5dZ4cSEZ24Q+fAEnpPfpS7x1nXpWMQoP8pRJB4CX
         RUoPRcU+YpDrdymHUa4VlFenP84CBN/0BjqEQ6LPJTDQFOY7tNc9IY7Bhg3PNxTowieB
         XIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0g9ugQG0sAP10Eo+U/PQ6hS9dDpWYGb5C09T4WP9hqk=;
        b=j/luDEvPOEM376yqU3efRKFvYd3TUcQ3v/ndf6g8bBP3oQ/0LLUJU8T89OlLlKkv5X
         uWowTZPi++l/Gm6MUwISLKy9CM/C1RY/O3y72poKPtXjcbKHnkU8C8ZQHMA9VNhZuKp0
         b9nsgEJA9gZQMMw2NbXIwEoG+zVDLP9GUoN+ftlQ0u1OPL4ZICZfw8YsT6QzmS/txcAN
         9TFNR6Aqjy48xR+G1ayDpXG072aZByzZeCCIQW0GITHsxWIp3SMiCHFpZHu307VIzM3l
         qSilkjLwJPuApusKws/tfjCzvQSTtmvjkc7HPSJlbygKYMuDf+KKuL1sTBbmBtKYY8GO
         xTZQ==
X-Gm-Message-State: APjAAAU1lSJV0UAYWXnKAcH2lKjnvc3hfAX5FGIpYHIMIEFKVrxJFUYm
        OiUM7fZsCbox+DiZaY8+20I5pQiH
X-Google-Smtp-Source: APXvYqzBoBjdTm+1/wFdyVwgjjQMu/bPj2Q0FfrYq0JPsWw1sdDOHf8DkVW/mREt8zmsqxTC3Mo94Q==
X-Received: by 2002:a37:7786:: with SMTP id s128mr23420470qkc.63.1559590523947;
        Mon, 03 Jun 2019 12:35:23 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id t80sm7539231qka.87.2019.06.03.12.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:35:23 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     jic23@kernel.org
Cc:     andrew.smirnov@gmail.com, linux-iio@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/4] iio: imx7d_adc: Remove unneeded error message
Date:   Mon,  3 Jun 2019 16:34:30 -0300
Message-Id: <20190603193433.6394-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In case of ioremap failure, the core code will take care of printing
the error message, so there is no need for having a local error
message in the driver.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/iio/adc/imx7d_adc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 4fe97c2a0f43..23c7b0ee945f 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -493,11 +493,8 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 	info->dev = dev;
 
 	info->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(info->regs)) {
-		ret = PTR_ERR(info->regs);
-		dev_err(dev, "Failed to remap adc memory, err = %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(info->regs))
+		return PTR_ERR(info->regs);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-- 
2.17.1

