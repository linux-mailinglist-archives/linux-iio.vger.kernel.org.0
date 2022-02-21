Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECEE4BECE9
	for <lists+linux-iio@lfdr.de>; Mon, 21 Feb 2022 23:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiBUWIX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Feb 2022 17:08:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiBUWIX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2022 17:08:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEE722BEA
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 14:07:59 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s1so2933808wrg.10
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 14:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46n4LaD4ZyMBoEv7QyqZkVx2QkFYWM4XtM2ZRYBTQAc=;
        b=S9lJPgC5IiaAkUPxTOR6pCbBmqHzJ273ONgKjTf6kz6WxV5MBzqonQTVOKd1sckQXZ
         IDV10h7E98kCSM7jKMdSPbhics6Dgep2Ljv6hHDKWq6IYuYUBxDSFtmDh6kzKzPcS0w8
         dI5yL49bUQh5MXjuLSzMecg1dQxRKWskmYsC2NlkEWIRuvfVr0eBqCqsouszfNPrFYTa
         fPHXCspgs9pPjOSr8UEA+nzGquf+D7RN+ZsZ2ML4JWDm4fupupDfHwnZI2c0UT9PuA+L
         heNeH1VNtE+4azA/CRC1BfqAwNGsfPjzUL5jlwbpehIcrABVCrJRsgtaMRQHWa+BzELA
         DdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46n4LaD4ZyMBoEv7QyqZkVx2QkFYWM4XtM2ZRYBTQAc=;
        b=rwOEbQXpHCYQ5nCukHi1/YNalOtuVbI+3V6up3YYkqgaTGRsNYSJ0X9G0qh1HMTN0f
         f6JQ8NvtsbTHxCd0A02kGmjFDyT16aMqqNdSLmwv9+RofcJBtqRG4YTbIStMFXaym7a6
         nkOi38Y9fuslao/B85/j019O7lC3M0926zYQQSshVUVKVZpjZyCVCQnQpMj7R3dPisQM
         gdGKVB1kAqloGTHqyZS+izWDSlh9kMQ3uLFWO9xcwyS9DPeEoQzWXX+mLMbGGkmZcG4f
         dBJMFf7oCICypRstmMsE6RPwS02p9BqsCVf8Q+DMe3NtvwGkei34W0YRmaU5QaMEVDoZ
         2FQg==
X-Gm-Message-State: AOAM5338QdQES1DU6bZH1YPodP7Ms2Rf60UwvcxMYM5tC0KAr8tuB8KT
        FZ4z6El9QDzuze5/a8Fx4UnMjw==
X-Google-Smtp-Source: ABdhPJyZO6pJpT1Fi1MbU0H1hFrOr6VklHoXSDG4dhj/GdcBFoZd1SHgepz8UzU72P/BcWzOAm7fPA==
X-Received: by 2002:adf:80ad:0:b0:1e3:238a:178e with SMTP id 42-20020adf80ad000000b001e3238a178emr17952135wrl.551.1645481277661;
        Mon, 21 Feb 2022 14:07:57 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id w8sm51626093wre.83.2022.02.21.14.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 14:07:57 -0800 (PST)
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
Subject: [PATCH v8 1/9] spmi: add a helper to look up an SPMI device from a device node
Date:   Mon, 21 Feb 2022 22:07:35 +0000
Message-Id: <20220221220743.541704-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221220743.541704-1-caleb.connolly@linaro.org>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

