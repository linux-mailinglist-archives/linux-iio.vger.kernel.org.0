Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2164D3B87
	for <lists+linux-iio@lfdr.de>; Wed,  9 Mar 2022 22:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiCIVBc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Mar 2022 16:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbiCIVBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2022 16:01:30 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D87454F98
        for <linux-iio@vger.kernel.org>; Wed,  9 Mar 2022 13:00:30 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qa43so7697129ejc.12
        for <linux-iio@vger.kernel.org>; Wed, 09 Mar 2022 13:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9odFb1lebTlJ8kEafI46I2InRLxGgcRnodujuq66jtI=;
        b=nA4EoPs5nIQpECO+1PJ5soOGUb8nxwmkuGyMDF98AAXQYrXUfNv+QSKp16tlHCggWk
         MVJn+LyGP8Bx8Sxzn2t7aIszhfLlrOL53iRougVF2oYZkOgvbTjgCf4FvxgUMA9crK0F
         wQUSE/pImwhmvgcUq0DARAatpNUYfLlPFkvbYckKoUhdWqvFHxVBy9paHUqRDYDxRVfc
         HGX3zqrBDfiXhwgfgY0Xsp6fv6deob0S4bkEwkQlr1TMahWWp0ERcujAHEYOOeWigvCl
         knwYcIQGKN0aLSXV9yFyXL+xG+Oe66HNYOTJ7vCmlATp4LwJSwd/Raw+Fw0RKolAoj37
         fsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9odFb1lebTlJ8kEafI46I2InRLxGgcRnodujuq66jtI=;
        b=v9LYZCVO96aK+Jsx0wOcIfGxhObBqmWkh/LY0k0jDGwEGv+/hLHd3k3O/E6LSxP8CJ
         oZzb6XpOwY3fCTlbu+Zz+ZjbKzt9dTFNyCLd1/yQsB4Ni3lmoQu3NNueNnhSwbfDMlk+
         mNhp8w3KXhMVR1ZburKqwaeeBeXu9UBSdZ5HVXxnGGZycWmTtDuQJJUT/oWPo3t2OLJ3
         PiZCQgWNNyGPiz4u+KglNuN5PxCFvhAORd3DYC1erSbvqYE2ut/J3y7k2H1eOMqR4Jk2
         HHfRZSEMO5lGmYe6umW4nkIQvfenbh7ciwxClKHsVvZWSuat1Ui0d6vMHTdePBLJAkcq
         6R5w==
X-Gm-Message-State: AOAM531z+XTGbmxeF9yS+7/R1+Iel1gY0qzZpS+TnW3BzoubwxVNqO23
        oWJgHMn9yujCcedm0xdTj4Lxag==
X-Google-Smtp-Source: ABdhPJz//n7Pij5V62RXMynDYtJSqLodltfMPCfNYM52JkjDDYjFzQVKrXKhdJL2TNkAby+TCk+NUw==
X-Received: by 2002:a17:906:d555:b0:6db:148e:5cc with SMTP id cr21-20020a170906d55500b006db148e05ccmr1492395ejc.63.1646859628997;
        Wed, 09 Mar 2022 13:00:28 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709061c5a00b006da815e14e2sm1114743ejg.37.2022.03.09.13.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:00:28 -0800 (PST)
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
Subject: [PATCH v11 1/9] spmi: add a helper to look up an SPMI device from a device node
Date:   Wed,  9 Mar 2022 21:00:06 +0000
Message-Id: <20220309210014.352267-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309210014.352267-1-caleb.connolly@linaro.org>
References: <20220309210014.352267-1-caleb.connolly@linaro.org>
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
 include/linux/spmi.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index b37ead9e2fad..a456ce5141e1 100644
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
+struct spmi_device *spmi_device_from_of(struct device_node *np)
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
index 729bcbf9f5ad..eac1956a8727 100644
--- a/include/linux/spmi.h
+++ b/include/linux/spmi.h
@@ -164,6 +164,9 @@ static inline void spmi_driver_unregister(struct spmi_driver *sdrv)
 	module_driver(__spmi_driver, spmi_driver_register, \
 			spmi_driver_unregister)
 
+struct device_node;
+
+struct spmi_device *spmi_device_from_of(struct device_node *np);
 int spmi_register_read(struct spmi_device *sdev, u8 addr, u8 *buf);
 int spmi_ext_register_read(struct spmi_device *sdev, u8 addr, u8 *buf,
 			   size_t len);
-- 
2.35.1

