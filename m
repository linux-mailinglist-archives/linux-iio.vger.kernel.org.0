Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D27E4B7890
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbiBORKR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 12:10:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242240AbiBORKR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 12:10:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0941D11ADD1
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:07 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so19501191wrg.11
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46n4LaD4ZyMBoEv7QyqZkVx2QkFYWM4XtM2ZRYBTQAc=;
        b=H/pVHnep84f4SO5mEUh7ccuxHhCZBOhnjSDZOxD0osdtblLDsY94M3esKJn6TdtW07
         us9EUXoRcIScwy8t4CVk8+2G3pLob+uD9g5HKJa/Jh/XP7V8kh5am3aqwXoIo/i2MoVo
         j3GhmQkVPGi2mz6EXqCxHJV+aPLhMzrDJcrVUqmrrcD7Iw9vE+CtF3SZhc/5imEdkmrL
         EPZNUWCuP+RYLTe3MMbqn9zwBP7yUyPJj2vAawjeYSpqgl7UzfiMgyT4JsVGAHEWWeXU
         FtDjDeHe6BeNKal560a9Axxd89ybP+tVXNkrMMp2nyqSAOpLszKiaG+YOEDhfG+b6e3O
         F+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46n4LaD4ZyMBoEv7QyqZkVx2QkFYWM4XtM2ZRYBTQAc=;
        b=Ols2MXyZnCqWs9d7UOOTXdBRgBz6/C9pFbsRWTv2tH/KsVXTDrUzz5bmq/cIx/2V5m
         CIwAzQ0SCgCHzOraRkpKyaMjRfmiB+OWjw3gDlfCcvzpSQZfib6m5Hpj6xKsttIWKRKF
         8NaadEJKjN1VKJV77/h2iQGDCO7aMP6r/091ptUo2h47IPPsnZvJd42+N/Dc66rS/r82
         rZLe4g53tTbbG25TpYUNLuwSWOFsvNYwomeeq+SrTpyFzPBW+aPdFNNdDvM1903WmPiP
         w5BcWDOOAXJbyt871g5usNYpGdFfEIhSsgwP8Z6M2rmnt5Mgv64at55r34/5VmJZd1Na
         17hw==
X-Gm-Message-State: AOAM533hXByGgNoAZ3Ptb4RWmXXZuXqk2O0f6fNmV8fo8+YuTcwM0VES
        EwQEuTwtfZdqHTcTHhpSS0shdw==
X-Google-Smtp-Source: ABdhPJz5pYDeTwmHDRpO+vYbnSvTuSh+CQZhIr3yipQ9zMZblDzDsedgRSWYZw/JHp+eFKWo6H5jLA==
X-Received: by 2002:a5d:59a2:: with SMTP id p2mr4078620wrr.304.1644945004462;
        Tue, 15 Feb 2022 09:10:04 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id g5sm15558474wmk.38.2022.02.15.09.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 09:10:03 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
Subject: [PATCH v6 1/9] spmi: add a helper to look up an SPMI device from a device node
Date:   Tue, 15 Feb 2022 17:09:43 +0000
Message-Id: <20220215170951.1233375-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215170951.1233375-1-caleb.connolly@linaro.org>
References: <20220215170951.1233375-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The helper function spmi_device_from_of() takes a device node and
returns the SPMI device associated with it.
This is like of_find_device_by_node but for SPMI devices.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/spmi/spmi.c  | 17 +++++++++++++++++
 include/linux/spmi.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index b37ead9e2fad..de550b777451 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -386,6 +386,23 @@ static struct bus_type spmi_bus_type = {
 	.uevent		= spmi_drv_uevent,
 };
 
+/**
+ * spmi_device_from_of() - get the associated SPMI device from a device node
+ *
+ * @np:		device node
+ *
+ * Returns the struct spmi_device associated with a device node or NULL.
+ */
+inline struct spmi_device *spmi_device_from_of(struct device_node *np)
+{
+	struct device *dev = bus_find_device_by_of_node(&spmi_bus_type, np);
+
+	if (dev)
+		return to_spmi_device(dev);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(spmi_device_from_of);
+
 /**
  * spmi_controller_alloc() - Allocate a new SPMI device
  * @ctrl:	associated controller
diff --git a/include/linux/spmi.h b/include/linux/spmi.h
index 729bcbf9f5ad..6ee476bc1cd6 100644
--- a/include/linux/spmi.h
+++ b/include/linux/spmi.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 
 /* Maximum slave identifier */
 #define SPMI_MAX_SLAVE_ID		16
@@ -164,6 +165,7 @@ static inline void spmi_driver_unregister(struct spmi_driver *sdrv)
 	module_driver(__spmi_driver, spmi_driver_register, \
 			spmi_driver_unregister)
 
+inline struct spmi_device *spmi_device_from_of(struct device_node *np);
 int spmi_register_read(struct spmi_device *sdev, u8 addr, u8 *buf);
 int spmi_ext_register_read(struct spmi_device *sdev, u8 addr, u8 *buf,
 			   size_t len);
-- 
2.35.1

