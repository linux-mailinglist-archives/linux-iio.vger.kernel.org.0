Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA152224124
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgGQQ4E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgGQQ4E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD07C0619D2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so15965817wmj.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAAjM1mVIkO+nJSIb50glO5h9HOq0tsEwp52kRso+4M=;
        b=diGqESAPD2yg592c8LXDZUadk/s4W30i0sy1gOfHfVL8rkg/bSc9SLulra7mzvbh6q
         tuEL6z3Ah/YSeL14hltOCwWppAmPt9ShSHMKVUYb1l9qxcXUKIq3zTM4yzvIsbo3iu4q
         Ykl7tRihGTqXOJZh9Cs0qp94pb/2FYwjxDujVZoKALn49L4H3l4V5PCd5jLqVtsS7beD
         22JzY3Ro0UmLJsBfPgiEIAOxKd3eSn0tZAWAokfmdtwS1UnVx4x70bW1Hh+KxeUgefEx
         u0NqUPGOR33Su4RnGuvF9P8VjlNBWNlC/ezdUIbKIArdrdAqQTZGQ9DjBwz8xh5LjUs3
         uwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAAjM1mVIkO+nJSIb50glO5h9HOq0tsEwp52kRso+4M=;
        b=gjE1/m8MqI0Tp4EG6fwENUAWEoo9QReHXR8qUDtfGeoFEuSIDa1KjzPn0Jmf8vUxpz
         UMddv/3lKfHmaos9rbP9ncdKBEitD4P6yADCWexY6ZjzawvGuJsT+11xE6CTDBd+EebU
         6URGhDQjDTeL4wkoSwQ8HHdts5ReXISaaHhqpHJp2LCc9o74MuwRuXIQcF1typts+TZu
         JwhWFlOWsbw7e9WCzmUDHw3ftzClSdhRn+Kzhgel/IRCSQ5ud2afAjJQy8Kb88iwj/qk
         9Tm/sMwmzZg0/yPjsxQ0liv5RHaHjJDva1bNf94jPTBBWv+T+8TzHMqSAZvWOn4uTS5I
         dHcQ==
X-Gm-Message-State: AOAM533e3NTX3KMMlr7pR01LeZCMCU9fEE/Z2CFv3bB70a2WHLWa+Oa2
        WcexuOq4JC5XhL8gq+un28K9Qw==
X-Google-Smtp-Source: ABdhPJxBjePr/D/nJshvCMDW+pFxohRxj6BB8ic0aMowVQ5331Lh4fFUBQZq7R8GCcKKIDDyto7/3g==
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr10975426wml.185.1595004962476;
        Fri, 17 Jul 2020 09:56:02 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Josef Gajdusek <atx@atx.name>
Subject: [PATCH 04/30] iio: magnetometer: hmc5843: 'hmc5843_pm_ops' is unused in 1 of 3 files including hmc5843_core.h
Date:   Fri, 17 Jul 2020 17:55:12 +0100
Message-Id: <20200717165538.3275050-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We know that it's okay for 'hmc5843_pm_ops' to be unused here.

Fixes the following W=1 kernel build warning(s):

 In file included from include/linux/device.h:25,
 from include/linux/iio/iio.h:10,
 from drivers/iio/magnetometer/hmc5843_core.c:16:
 drivers/iio/magnetometer/hmc5843.h:55:26: warning: ‘hmc5843_pm_ops’ defined but not used [-Wunused-const-variable=]
 55 | static SIMPLE_DEV_PM_OPS(hmc5843_pm_ops,
 | ^~~~~~~~~~~~~~
 include/linux/pm.h:354:25: note: in definition of macro ‘SIMPLE_DEV_PM_OPS’
 354 | const struct dev_pm_ops name = { | ^~~~

Cc: Josef Gajdusek <atx@atx.name>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/magnetometer/hmc5843.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
index b0dee87a8b20e..3f6c0b6629415 100644
--- a/drivers/iio/magnetometer/hmc5843.h
+++ b/drivers/iio/magnetometer/hmc5843.h
@@ -52,9 +52,9 @@ int hmc5843_common_suspend(struct device *dev);
 int hmc5843_common_resume(struct device *dev);
 
 #ifdef CONFIG_PM_SLEEP
-static SIMPLE_DEV_PM_OPS(hmc5843_pm_ops,
-		hmc5843_common_suspend,
-		hmc5843_common_resume);
+static __maybe_unused SIMPLE_DEV_PM_OPS(hmc5843_pm_ops,
+					hmc5843_common_suspend,
+					hmc5843_common_resume);
 #define HMC5843_PM_OPS (&hmc5843_pm_ops)
 #else
 #define HMC5843_PM_OPS NULL
-- 
2.25.1

