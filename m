Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A43A10E6DB
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 09:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLBIXG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 03:23:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45561 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfLBIXG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 03:23:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id d20so9166978ljc.12
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 00:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iCkT43g8FRL73l9cq5oE1hMrMzMb5sVzTJRUPoZg92g=;
        b=lI5z2MB0wbDt8F8Cqh8wfZa5mZDb6oUE/g043OWjyTU5zEJqZQZ0y3qnJUWLVnzbiv
         z81NztNnk5/q7OswElmPuj/T8fyGk7Guga0cMhfxbLPhGOAMEUPgB+FEcu1PwSmhG2MH
         OsqebvcSk+yzWFcQJx+7L41KjmmQ3fV12KpkwdoearYUyos+NlJWHt+VOYOJ/0w35Dy1
         gZvbyU/OYxJ7O+xf01DoTXbd10LlDdgalAZ9KnplLdITc86d3CyER28cFF8DS9UbA2fH
         g/KZ8wuCxRJMYTd4vas7qwQVjx6AGyGi3pd5f/G2HLXWwjyDOucIGHkToPX3KMmQDzyg
         hBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iCkT43g8FRL73l9cq5oE1hMrMzMb5sVzTJRUPoZg92g=;
        b=JCX9JFCCb2epABOgrxevtDRXvC+VH3VzsYxFyzL5/tQ7hZG78wcKqUg70BInEl5DrT
         9rZqOw2aTUNnNKFXvOQVFHj10/YYcuzd4Vfu0UKSY9DkEDGW4aD+8/s/ZB+katWItjS/
         BDbgVQFT5AUB5k8OYUs5rH+tyca+cgRRMpynT8oY8n5vXfvGxy7xZjVHIEfDXmSEKpnq
         g9T09+m6ooT1Jp4xUEu8WXFD6orEXoNvu1YrJcQVYi8ZDrPfU+ivZULm3srtD/qbZtex
         6qZ1B3HULLnHyoSMJbLSKHcZL3lyM18gUhomgz7ZQhZOYkDiQfd5j95iqFdpVS4b76d1
         ddaA==
X-Gm-Message-State: APjAAAW+7rF9D9/DwLQmmFF2xBmwe2m9OxF1XiAgwPDk9AEm1HCZoDZX
        kAGncah/EQo1ONgBWB/n41cxvg==
X-Google-Smtp-Source: APXvYqw5iy1N4Hadf3LH5HV29CFK/ViXMdP11C6PsNLNonw5F6iC7wqcVIWs2oN6zo0BEV1X00jZBA==
X-Received: by 2002:a2e:9758:: with SMTP id f24mr45892208ljj.105.1575274984516;
        Mon, 02 Dec 2019 00:23:04 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id a11sm6807059lfg.17.2019.12.02.00.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:23:03 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: ad2s1200: Drop legacy include
Date:   Mon,  2 Dec 2019 09:23:01 +0100
Message-Id: <20191202082301.62599-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver is using the GPIO descriptor API but yet includes
the legacy <linux/gpio.h> header for no reason. Drop the
surplus include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/resolver/ad2s1200.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
index 17b89623418c..a391f46ee06b 100644
--- a/drivers/iio/resolver/ad2s1200.c
+++ b/drivers/iio/resolver/ad2s1200.c
@@ -10,7 +10,6 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-- 
2.23.0

