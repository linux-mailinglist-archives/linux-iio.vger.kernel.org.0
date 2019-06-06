Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC6369C3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2019 04:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfFFCFs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Jun 2019 22:05:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37564 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfFFCFr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2019 22:05:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id y57so945413qtk.4
        for <linux-iio@vger.kernel.org>; Wed, 05 Jun 2019 19:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s7zz+DGVhGZOuKwqgru6qux8LX3G6f6pOL/orDBaNeA=;
        b=mZpQljdGJfPhxL7V1ydW9yqeKDfhLmOTc6DyZ6UPD4Ty0rH4GEnfAeSraGWwwzsTn9
         Z/ipawuWU2ovtq1D0s9KWvfAAzlJ7l6hAcXiHxOhmgi5HCD4Xrjvc3rbdBeSw1CyLOhl
         /pwkk8s/6m0EANvSI/IPqArB0cO1muxh07xdc5VyF1OQZRk3cTyyFeIV/361qODc/m5K
         loiApIoaTX/ajSxj/cVdidvIi+lYMvJFzIzLK2+63SsThf1CgFBczx1H624012aLu+ZD
         eKpHM++xmU79FPFPrM5VtPzn5XPzeprfDsnt8zVaB+HE75ajfUl7rVCWWmuNDaVEGp8T
         VZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s7zz+DGVhGZOuKwqgru6qux8LX3G6f6pOL/orDBaNeA=;
        b=pbiV6z14vBrivNlgTEOQA1wEwSzvJhBlv3Z+0kpvfceo4kUCvK+yoBDf8D7DPHspe4
         XrC8MsPAPyVjmYe9/9nCqtt9YQk9bLsYQv/8t/AAxLk5FI10Cyu6GlhjospU+lDerpLL
         vvcRtpiIcBeBk1xSQUnUIlzgkiq8XqnYBY77K8JzW2lXZH9fSObOz+BBRcpSpSHksLPo
         fqu3YyTtF6cxiczImh5qvV8Vad9jmsNm1sa349xq1u5d6g7mt7rsHRqaV9fEj/fTHF0y
         o5O6DFunhPrFLcQdXNMfm1Bzhqpq9QgauJyqBA6wMgPcNmS3VIb68WhHy2Io3gjkGfSY
         EXpQ==
X-Gm-Message-State: APjAAAUNSJVJzH90oebVEKIXmkOIvHgmHjyzxia2Ew+wJq0esrMgpVCh
        UEbdsmU/yTueJCWThuncFSg=
X-Google-Smtp-Source: APXvYqw4w2pejj8TPjeH6918oIprPCHDoJrHQOqrHBsMWcVbthTeLgjyk7p5yH2DTkEcn1cpZIRWuA==
X-Received: by 2002:ac8:3345:: with SMTP id u5mr38644559qta.219.1559786746756;
        Wed, 05 Jun 2019 19:05:46 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id b66sm207532qkd.37.2019.06.05.19.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 19:05:45 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        rdunlap@infradead.org, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        preid@electromag.com.au, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] staging: iio: adt7316: Fix build errors when GPIOLIB is not set
Date:   Wed,  5 Jun 2019 23:05:32 -0300
Message-Id: <20190606020532.4864-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On x86_64 when GPIOLIB is not set the following build errors
are seen:

drivers/staging/iio/addac/adt7316.c:947:3: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]
drivers/staging/iio/addac/adt7316.c:1805:2: error: implicit declaration of function 'irqd_get_trigger_type' [-Werror=implicit-function-declaration]

These functions are provided by the <linux/gpio/consumer.h>
and <linux/irq.h> headers, so include them to fix these
build errors.

While at it, remove <linux/gpio.h> as this driver is a GPIO
consumer and not a GPIO driver.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Remove <linux/gpio.h> - Phil

 drivers/staging/iio/addac/adt7316.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 37ce563cb0e1..9cb3d0e42c38 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -6,7 +6,8 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/irq.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-- 
2.17.1

