Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA3D263271
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 18:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgIIQni (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730992AbgIIQMs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2020 12:12:48 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D537C06124F
        for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2020 07:43:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w3so3895956ljo.5
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2020 07:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w8xJywszUviG8IlaqXvca0F9+J7Th0C+yfpGZ/wtGyc=;
        b=lUSkWeyIUec2i/cBga+S8HrTxW+ryKchb0HdSyWyFjDQ3a1DoOKagtRL/bhDjM8XEB
         r/4WoPAur60pdcxmZyRCeDipW2BURPTCj5tCd6EGuV1TF4figfLkSntz/JcYVGqHXuNO
         fUOKzOkZzywnmRyJhMo4IT4Y/iYwh+3RmTxZqJQXd6MT/i1TZqxnpf6DhBCeryADhfgW
         ClUaTJltGTwPRxN7YwpjD8ExFaQ21n+EyNoG3J0uCANCYZGIkNvTkK29cX+R5MCS5Xag
         o160tnnuvAMm8tOdTs5eKduTghR0WswwGygkIWGKIH5m1j63pO0OlN0aKTVArNRwcNqK
         OR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w8xJywszUviG8IlaqXvca0F9+J7Th0C+yfpGZ/wtGyc=;
        b=cUjW98ywJu3ZMP0SI1TS9/SqFNSZMsO4UR9OfXS6ntCde3YA2FUE4Tuh/SAqCQNFjF
         Mf2L2LDFs0hX/99rdlEVKGWBnST+FdnPuc73Xchph+ymZ/CQYiK4Tx9KcbTqc041cOaG
         Bx+dY9cZUKF+aVilPiaIg9tYbq6FlsKCldPDdsjlocCZr9wSbUynN+ETfezpBCSZq1mu
         aPcfwVc64oIVC1wBHNUp/FLPzPdtq2MQYLoqht/VzHZ/+C5QNytAph+Wq+vjPdv6A2va
         hVcV5DldiQA1KscnrD/rJ8Xul3R8NQfciCLoyuxBrUEZM3AExWjC9g2Hv4KalP2ux58Y
         4G0g==
X-Gm-Message-State: AOAM532ZgS+nLBuHxs+XQs3PC5tH/2KH+xAIny5pKa+kfjyst6qVhRyt
        9xc1yedAFMg+39VTlhqfAc9orA==
X-Google-Smtp-Source: ABdhPJy7Lm4n8uPvYsm6+724Esh0DNoPvYm4lbou2WBs4gB+mNKGDPZN+zRhRKpTUwch3oJT9CNOZw==
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr1895466ljc.119.1599662600908;
        Wed, 09 Sep 2020 07:43:20 -0700 (PDT)
Received: from eriador.lan ([188.162.64.155])
        by smtp.gmail.com with ESMTPSA id t12sm621665lfk.26.2020.09.09.07.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:43:20 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 07/10] iio: provide of_iio_channel_get_by_name() and devm_ version it
Date:   Wed,  9 Sep 2020 17:42:45 +0300
Message-Id: <20200909144248.54327-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909144248.54327-1-dmitry.baryshkov@linaro.org>
References: <20200909144248.54327-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There might be cases when the IIO channel is attached to the device
subnode instead of being attached to the main device node. Allow drivers
to query IIO channels by using device tree nodes.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iio/inkern.c         | 33 +++++++++++++++++++++++++--------
 include/linux/iio/consumer.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index ede99e0d5371..3083f886d3da 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -180,8 +180,8 @@ static struct iio_channel *of_iio_channel_get(struct device_node *np, int index)
 	return ERR_PTR(err);
 }
 
-static struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
-						      const char *name)
+struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
+					       const char *name)
 {
 	struct iio_channel *chan = NULL;
 
@@ -261,12 +261,6 @@ static struct iio_channel *of_iio_channel_get_all(struct device *dev)
 
 #else /* CONFIG_OF */
 
-static inline struct iio_channel *
-of_iio_channel_get_by_name(struct device_node *np, const char *name)
-{
-	return NULL;
-}
-
 static inline struct iio_channel *of_iio_channel_get_all(struct device *dev)
 {
 	return NULL;
@@ -382,6 +376,29 @@ struct iio_channel *devm_iio_channel_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_iio_channel_get);
 
+struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
+						    struct device_node *np,
+						    const char *channel_name)
+{
+	struct iio_channel **ptr, *channel;
+
+	ptr = devres_alloc(devm_iio_channel_free, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	channel = of_iio_channel_get_by_name(np, channel_name);
+	if (IS_ERR(channel)) {
+		devres_free(ptr);
+		return channel;
+	}
+
+	*ptr = channel;
+	devres_add(dev, ptr);
+
+	return channel;
+}
+EXPORT_SYMBOL_GPL(devm_of_iio_channel_get_by_name);
+
 struct iio_channel *iio_channel_get_all(struct device *dev)
 {
 	const char *name;
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index c4118dcb8e05..0a90ba8fa1bb 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -13,6 +13,7 @@
 struct iio_dev;
 struct iio_chan_spec;
 struct device;
+struct device_node;
 
 /**
  * struct iio_channel - everything needed for a consumer to use a channel
@@ -97,6 +98,41 @@ void iio_channel_release_all(struct iio_channel *chan);
  */
 struct iio_channel *devm_iio_channel_get_all(struct device *dev);
 
+/**
+ * of_iio_channel_get_by_name() - get description of all that is needed to access channel.
+ * @np:			Pointer to consumer device tree node
+ * @consumer_channel:	Unique name to identify the channel on the consumer
+ *			side. This typically describes the channels use within
+ *			the consumer. E.g. 'battery_voltage'
+ */
+#ifdef CONFIG_OF
+struct iio_channel *of_iio_channel_get_by_name(struct device_node *np, const char *name);
+#else
+static inline struct iio_channel *
+of_iio_channel_get_by_name(struct device_node *np, const char *name)
+{
+	return NULL;
+}
+#endif
+
+/**
+ * devm_of_iio_channel_get_by_name() - Resource managed version of of_iio_channel_get_by_name().
+ * @dev:		Pointer to consumer device.
+ * @np:			Pointer to consumer device tree node
+ * @consumer_channel:	Unique name to identify the channel on the consumer
+ *			side. This typically describes the channels use within
+ *			the consumer. E.g. 'battery_voltage'
+ *
+ * Returns a pointer to negative errno if it is not able to get the iio channel
+ * otherwise returns valid pointer for iio channel.
+ *
+ * The allocated iio channel is automatically released when the device is
+ * unbound.
+ */
+struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
+						    struct device_node *np,
+						    const char *consumer_channel);
+
 struct iio_cb_buffer;
 /**
  * iio_channel_get_all_cb() - register callback for triggered capture
-- 
2.28.0

