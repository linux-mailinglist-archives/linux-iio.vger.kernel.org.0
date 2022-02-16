Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9E64B8AAF
	for <lists+linux-iio@lfdr.de>; Wed, 16 Feb 2022 14:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiBPNt6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Feb 2022 08:49:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbiBPNt6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Feb 2022 08:49:58 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE4B2A0D5A
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 05:49:44 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p15so4732358ejc.7
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 05:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46n4LaD4ZyMBoEv7QyqZkVx2QkFYWM4XtM2ZRYBTQAc=;
        b=R2xg/A4umSYaqwB+IDnWON6cWpWUJdRbV5ECKt1Aw2xZSJNRpz+f1i98qPkwQx02mX
         1EcbcikQeujSLIP9G/9cLZnZgt1epqSl/ajz7zLrYprOFU0bPVTAmO9isPVDYwu6ELep
         TYr0JOCzdCd0HuLsGS39GRC2WpbwhDxr5NQlc9RmV7/QL4mMW1gc+2T087/bEtuNF1cL
         nlSBiCjKqhzu4BeGd5YapegnT0LD1x1qpJgzkVESgkZJ90FqpUaB4ZTv0yldN+aKEHZ+
         lxC0mJGEb+12elginW9NAa7ylB1AEJvIHwbNEtokxOGoKxZ96zOOIFtVaU1NejXIOE2C
         vYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46n4LaD4ZyMBoEv7QyqZkVx2QkFYWM4XtM2ZRYBTQAc=;
        b=53VnxJtDuBygCItiLspcdIMLbVBI2odHrvwjpnaJ0fw5QbmNyYOS7tbD55Pn+A53xD
         dU9wySUWFLNGEm2gx95FX8Rgbc1GEvfmeeVjkU45cndZPSU6CNXs3NfVXNgSV/fAZVAm
         Jn9Vsb8FRYfE3+J1I3p+LYBCvN/8PvJibhmOVhmr+Fnam6xEGE9fWoNn3M/De8XVshp2
         EA5BcV6dBj3wZH4efJECTofLAtGLcWyroDdkWRH1w0yAYX4uR+E+o8KvDUEmxnvbKQ1E
         bJnGHPIkjQFUs1rJQxkn1BG0zUS6U7RNZMIWV8tsuCF7txRnQ/pduWRz3+LLF/4BITeI
         sbNQ==
X-Gm-Message-State: AOAM531Cxo4VaSXiYJ1IvnzT6xq0z9amKbF/8l/eCyGUFhkwDf+Q6R0c
        DDfhL3U+Gx+xKnl1CFflPt0fPA==
X-Google-Smtp-Source: ABdhPJwRu3yFYlwaq6c6uxX1murbAtN9dkyfAI+Nvy6JioXYxnORUo5QLsTP9WtxS2AzlGhk2RxgZA==
X-Received: by 2002:a17:907:766a:b0:6cf:bb20:70c with SMTP id kk10-20020a170907766a00b006cfbb20070cmr2346786ejc.94.1645019382745;
        Wed, 16 Feb 2022 05:49:42 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id o20sm1711996edc.84.2022.02.16.05.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:49:42 -0800 (PST)
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
Subject: [PATCH v7 1/9] spmi: add a helper to look up an SPMI device from a device node
Date:   Wed, 16 Feb 2022 13:49:12 +0000
Message-Id: <20220216134920.239989-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216134920.239989-1-caleb.connolly@linaro.org>
References: <20220216134920.239989-1-caleb.connolly@linaro.org>
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

