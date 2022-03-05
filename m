Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC114CE210
	for <lists+linux-iio@lfdr.de>; Sat,  5 Mar 2022 03:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiCECNx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Mar 2022 21:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiCECNw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Mar 2022 21:13:52 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D66D1C46AE
        for <linux-iio@vger.kernel.org>; Fri,  4 Mar 2022 18:13:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so6068946wms.4
        for <linux-iio@vger.kernel.org>; Fri, 04 Mar 2022 18:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46n4LaD4ZyMBoEv7QyqZkVx2QkFYWM4XtM2ZRYBTQAc=;
        b=YNhT1rC43mmkRlwydAFFepdxSERVaNkxX87fow+by9EHPb83YSXCR/B9MISkmRegNX
         ClIw8JaiErScHwWqF7KhMkyxhAhOZmf6taSF+Fad2xapIQazQbgTBJzD/W8Y9n3bDLlG
         H54exVT7wrijQqO2jmgZvwlTXSJckssLdc1kpjX5hKjAayRi/3uRa6+KW42M3JwW2Ug3
         704Ji1VslyXQZn4M72CllKZagzaFuezvkiUHaH/vFA/smsXQUUA2+SHG/s5ZkszCTsEe
         K9AmwgvxAJPmkl/SFLXeIY934IkWeySjIaHYY8SqZKNZvCXAP4p5smYWDgeuf39YvY3x
         4zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46n4LaD4ZyMBoEv7QyqZkVx2QkFYWM4XtM2ZRYBTQAc=;
        b=MkLDBcka8wvZftqBpZ1LB1iJrg17rEl95tUpUpg28D/Z7VJ2pPQnySmWfwiufeE4jW
         MB2BhPM1KaOK07UUK8sazlGA0zlmq7sc/8QLpYruGwnStGfu5TvaNFaTfprIfTFOlR2n
         uE1oyT//AroVOnkPuasrsY0q98j2ozuEPfmDziunpap8kR35zmTqSGP9F7AQUdnDql85
         UsRPZsv4AfePTAwVQ+Dp1tlSjQ7D1z/lfJ6q5/qQ5Ye2/rEhC8t7sd2p2rXcL1+pqN4z
         SMJQQAcQHNcPBfPkhsMWDd2PU/GtEJr5HFV1QQtykHYfnqAMEBEMyUKa8qqyujasP3Ff
         Wdhw==
X-Gm-Message-State: AOAM530fJW7wFwXsezYu0GykMocsgwH9DhPf9g8HV23pC9GAdF2c1WlQ
        uA13zQYrX6CDFwwtinhcaZyh9w==
X-Google-Smtp-Source: ABdhPJwYilD4Xt/kURetj4ZljWfKmJHZoL78irG+7JI3sgQEgbsd84fIhQ0QI9x428rsywEa4KrtpA==
X-Received: by 2002:a7b:c001:0:b0:381:1afd:5caa with SMTP id c1-20020a7bc001000000b003811afd5caamr832702wmb.35.1646446380141;
        Fri, 04 Mar 2022 18:13:00 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id k10-20020adfe3ca000000b001f0329ba94csm7932589wrm.18.2022.03.04.18.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 18:12:59 -0800 (PST)
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
Subject: [PATCH v10 1/9] spmi: add a helper to look up an SPMI device from a device node
Date:   Sat,  5 Mar 2022 02:12:39 +0000
Message-Id: <20220305021247.1020122-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305021247.1020122-1-caleb.connolly@linaro.org>
References: <20220305021247.1020122-1-caleb.connolly@linaro.org>
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

