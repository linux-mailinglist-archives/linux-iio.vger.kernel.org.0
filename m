Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254A710E6D1
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 09:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfLBITs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 03:19:48 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35745 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLBITs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 03:19:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id r15so24248451lff.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 00:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFmdK1X7DyFYTiGqTJdwYRjNBeePgnZ5BmgCct6frJs=;
        b=AgxZHdko4HCKKn++EfNJx+/DaTwFbR2UOqNtIScNLUgvo67d88J3nzb1HIFTU/EwQ+
         jbK3gqc/ltDU52yX616q4l7FUGi/V+DbUU+gOKm6MDrhLTRrc30oniYJaKTvuge99ON+
         BZPSUcgLjDnnCGbdgVZnyaVRoUUleBO2yteVEiybIC93ZNT7UQUuKz0PBKLdZpGKE8Hy
         T/whWACrXKP+BsLQGiCli32kuwqTjzYDxiwccXSKLPvnntJhPAj6HsF1R5y6/zVAx3WT
         IrHmkPYDKiHSBTxFNh+lZsMNBxE7lU3u4MmjC5Vrt5kBhvCc58BR/+FUZNRxFxZmt4YX
         RLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFmdK1X7DyFYTiGqTJdwYRjNBeePgnZ5BmgCct6frJs=;
        b=XfrTM5H2PgucuFpVI5TbI1iUw2a3JR0vnWcD1WFOhYU1RXBU6eXQThvS0Y61s0urBX
         R2/E3iwMX0NBJWG0lXihUrGuL3RKuah8QdjAOI0zE/RfJNZFp1EQPE8AFOmhOBwlVycT
         iwo8DaUK5znROQXGzpa2KPyubZS53a8HMxfHLncBugPg9sElPS4EpiDaaq634woo5b51
         I7O+fT38P+g7g+E5mPYzRaRF7jr8dSddz0DR+UeSMEtgMQHYRV40UGNm2uE4+xXEmhtX
         km/6VnUT8Arc5bVTod5p7aRrJipowjrKzh/dKL/aGQzptK6NyuZ1xfpnXPbUGDcZPj0c
         iJfA==
X-Gm-Message-State: APjAAAV7n4qg+ESqP0wywbh2Ew1EZmW2gjLhYPb63djTC5TID+hp4kDU
        TVqsY0JW1y3fx/71nPuVc5g2Vw==
X-Google-Smtp-Source: APXvYqwOVSRKBF8cUApjcgIsYwlPcF1T6T5XE1xCKRFsZC5EZvHXmQqGCUXpvtTzMmoDQxeSzoth1A==
X-Received: by 2002:a05:6512:72:: with SMTP id i18mr18909812lfo.131.1575274786134;
        Mon, 02 Dec 2019 00:19:46 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id g26sm4055571ljn.89.2019.12.02.00.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:19:45 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: as3935: Drop GPIO includes
Date:   Mon,  2 Dec 2019 09:19:43 +0100
Message-Id: <20191202081943.62073-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver includes <linux/gpio.h> and <linux/of_gpio.h> yet
fails to use symbols from any of the include files, so drop
these includes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/proximity/as3935.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index b591c63bd6c4..bac9a433dd19 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -14,7 +14,6 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -22,8 +21,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/of_gpio.h>
-
 
 #define AS3935_AFE_GAIN		0x00
 #define AS3935_AFE_MASK		0x3F
-- 
2.23.0

