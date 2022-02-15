Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E028B4B7772
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbiBOQz0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 11:55:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241972AbiBOQzZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 11:55:25 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B8A119F10
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:15 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so1915052wme.3
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Swi01zs1Aek9C9Aenj93GPF/NdOk2jeLKINKBsWtsPE=;
        b=vKwxljKk6S8XX1j0GMsWuJ/i/SKLoRTmsaTrBDP2QeBbHF03+/AGil3AfJSHxkWuTc
         nHIPtyEOr6+kyphQ1EPT6+XjwS9kIBJeQblspJiNgH8ijy8JxVs4IQ0uYhnAaXIae2KT
         E4wNON7INsWidjwaPb2olfzziTsy/Uqw88xcUykirmtEj9M9QmPPg9p1ARwbHIFqlR3Z
         Clwtjr9R8d9SYDGVPVMhy3uN59/0/r2vV9ewIe1m0W96BJD1YL/7dgr5hQB4FrRlkdzM
         A32h395Xtju8KCpSiYcvYTqw5aL8REM8ydWuWmI+OG9zQMBUV1gxMxmrpzx+guqJ/Q5M
         HMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Swi01zs1Aek9C9Aenj93GPF/NdOk2jeLKINKBsWtsPE=;
        b=0H281u/MrSJsjT+B9bvJM/T3Dl2LQ5xaCP44qydzYav/9CDaBHKHz6qmxQRED0GDR5
         UcA8f//+bbrndBWezavg8vhWR0cfEPdLmtzmX8s+SZyFthYUZTqpVN9NAhJsQbQjMHG7
         tCWEi+yhJag6SGkBjg7oyOonv/AzSz8uqkeKSqBCbDsiu4mpST1+XpUTlLp5nUIoMTGv
         AeUP/uSlNh5BDzmZiZBsWZsq34HJ9BQiiQ7dIuGx4T+73e/39qOJ+vdiO7dCCG/4dv3z
         gNyGLPaN/jG59mH5xfMd+T2d6McvTp+g8sCKqootXNMtJ4SgRi7u7ifZ3fr5ByQVdGDF
         Jg+Q==
X-Gm-Message-State: AOAM533oYZituR1ucmqSoEPVJVgQJq/A8NvITzchNTERunVrKf3bwXGc
        6OGIHkIiCLvFtcG6DyXHmLzsuA==
X-Google-Smtp-Source: ABdhPJzPn72jb6qRBRw7JdWF65eN1GK0XwwDwaYELn2FLXBAmo9JV4T28Y232vAJE1AOsqLBBMHJjQ==
X-Received: by 2002:a05:600c:5c1:: with SMTP id p1mr3843147wmd.151.1644944113856;
        Tue, 15 Feb 2022 08:55:13 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id f14sm15373652wmq.3.2022.02.15.08.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:55:13 -0800 (PST)
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
Subject: [PATCH v5 1/9] spmi: add a helper to look up an SPMI device from a device node
Date:   Tue, 15 Feb 2022 16:54:48 +0000
Message-Id: <20220215165456.1205583-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215165456.1205583-1-caleb.connolly@linaro.org>
References: <20220215165456.1205583-1-caleb.connolly@linaro.org>
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
 drivers/spmi/spmi.c  | 16 ++++++++++++++++
 include/linux/spmi.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index b37ead9e2fad..d2e425e1d4c9 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -386,6 +386,22 @@ static struct bus_type spmi_bus_type = {
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

