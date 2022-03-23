Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487F74E5659
	for <lists+linux-iio@lfdr.de>; Wed, 23 Mar 2022 17:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245486AbiCWQaM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Mar 2022 12:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245461AbiCWQaL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2022 12:30:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC3325EAD
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 09:28:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g20so2488969edw.6
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47sx6XYQlSDDD844R0Ueg8RsLnNdO0mtHIaMLPwwe0s=;
        b=MlBgc2N2LUJKH9PcMJndXfPI32G30xbQNz43mtah1xilJza0eyYFJ7F1srJJeqY+Im
         Y4+s3UKOyoclwFgX16N7WcrJscJo6h08RrYMzMuzIAnrplPLUXQ4gfeZLusOZz16Og37
         ZPhioCxOcPETHGIdkgVcCl3nvFOU/CqH4L0YOQ0GLJkYPLag46hwz8oz1h42vwC4uIOc
         pwPC41F6hWFCdjvzMVONkyKabL6cMwnAvl3PL6EZY0RQDiX8uZsrXjV3ky2R5S50rjHx
         2r7QL9q1j1dJhmMbBEb9a/w5/G/MwvkzKgrrz5OzfrS8k/WL8l6DloML8XQ9oJE0UOyk
         arRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47sx6XYQlSDDD844R0Ueg8RsLnNdO0mtHIaMLPwwe0s=;
        b=BtR0uDjY4ZyZ3MDCSsfDqwWNiU3l2kHPvYH6iCxDN2p6TnRa39RNGxRL4/imtA+8tZ
         56/egQ4VIXvvSLRqFuqpJ+jU5z61i3I/v+5VbwBYQs8QZii/B5sfJN2Xuhj/SGA2cggC
         XggPE90xA0HXOWKm86wFFArNCoa82BfhyO67FtHCGqNt3pGEBn9MF/j9S3kXzSzuIo0f
         gvJ5qHszfkktbaqlLG+mj4tFaQ8xkjlNVoTJPaR8fvG8Id9P+peuDW39JmhJDeKYsu9s
         fFN7MYBqIlBLyn3oX3+gwohR1jJIToTtP3HKTIqoderqIzFzjj7zc4PiQ5yClEPjYWAF
         HNyw==
X-Gm-Message-State: AOAM533dahGaJ8tQK8siIGoT/Zdk/2MRwavvCZI+CgeeLYQnK/xcAYUL
        6AwVgjn9c75G3ZrwaJY/NXHNoQ==
X-Google-Smtp-Source: ABdhPJy0XwdfHEEKZA7wMIe0PNbU/Fg9Iw+0pqrcRktSeWlP5LL1BhEyuBSkrG5mEbs6zgHSZN1bEQ==
X-Received: by 2002:a05:6402:190a:b0:419:50e4:9f39 with SMTP id e10-20020a056402190a00b0041950e49f39mr1204262edz.24.1648052915380;
        Wed, 23 Mar 2022 09:28:35 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm173306edm.90.2022.03.23.09.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:28:34 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
X-Google-Original-From: Caleb Connolly <caleb@connolly.tech>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v13 1/9] spmi: add a helper to look up an SPMI device from a device node
Date:   Wed, 23 Mar 2022 16:28:12 +0000
Message-Id: <20220323162820.110806-2-caleb@connolly.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323162820.110806-1-caleb@connolly.tech>
References: <20220323162820.110806-1-caleb@connolly.tech>
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

From: Caleb Connolly <caleb.connolly@linaro.org>

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

