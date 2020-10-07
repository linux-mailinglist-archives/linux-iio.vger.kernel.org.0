Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59F52860A7
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgJGNy5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Oct 2020 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgJGNy5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Oct 2020 09:54:57 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3176C0613A8
        for <linux-iio@vger.kernel.org>; Wed,  7 Oct 2020 06:54:53 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g2so2367758lfr.10
        for <linux-iio@vger.kernel.org>; Wed, 07 Oct 2020 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0dKj6g81Qnwj432BHav6MjrRFfi+Md37xffdodCkkE=;
        b=qRbYQiBHcjjH2TflXzmSvGVGGeZI54McKn/KZO1JRw6R1Z7IilvB3Zi4PYLFER+FqJ
         n6b+C6yOjOD70hOX9Qt1mq2Gij0s5P1iy0fBHQ1aIYa81xp/nmfZDevL26nVgIWDybNX
         JB/iRVp79WI9CyNkbUAWJ0nDgTfQNtC/VP2uFngoygGlcs2h34PqurEL3RmqHYP8NnTf
         R8cPZeMHkKnVq5UISWwA4jr0AVxuRSYLOysiY4kVqkztJ+OrFSm8U2KIT2hJsFQyegwD
         FvOQIA7XacxuKhQoIdjQvQfZE3BGuI1mpSBIyFeJeWp2aJ9zmVJUqwuhhVWQ7Bqh61Qz
         sNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0dKj6g81Qnwj432BHav6MjrRFfi+Md37xffdodCkkE=;
        b=rhgS6eEnkvOUnjItsyCAPqO0dvB4+bjcVtMxIKlhpDB96r0bysosvaFgHWaEsPG+U1
         BK8Uqt5L7bZ+rWQiUsMWZYNJXAqc2L/X09QyQI1Toc07C5dl7EKADHUPEzU1Cu/FraJq
         SSoX1Khz/IQzE/DWRbKfu0IN0pND5XNDrsHcihh7/HX4oPtUWvA/i75946xZhOjnrlCh
         TVxDfvJPVrfRCVk+kczRORXJwIysGcr2KPkqmSIf48mZSW3zn/vFuEoisrTSNnwgv7iN
         1RsO8krFcx5ycb5i++mMxjE++4wo5CWdt7v3kM6q6zHGOmsYyEfh8naVnyPmnbTo96py
         bsew==
X-Gm-Message-State: AOAM531GtnxdMOrPhlJ2NvjLBcQMfvlvQr60LdN7F0buiMEIJXsCeVTZ
        ClhTNiBgmiSeD+6gIBzXLFGbTg==
X-Google-Smtp-Source: ABdhPJwA9zlaIhqeAMNQDa/8B9h+A8FVQVbLqZXmhGXoTcj+YC3HxhvEknF2hRlIyphz0T01S7Wksw==
X-Received: by 2002:a19:6911:: with SMTP id e17mr1026062lfc.479.1602078892050;
        Wed, 07 Oct 2020 06:54:52 -0700 (PDT)
Received: from localhost.localdomain ([188.162.65.250])
        by smtp.gmail.com with ESMTPSA id n3sm339768lfq.274.2020.10.07.06.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 06:54:51 -0700 (PDT)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 06/10] iio: provide of_iio_channel_get_by_name() and devm_ version it
Date:   Wed,  7 Oct 2020 16:54:29 +0300
Message-Id: <20201007135433.1041979-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
References: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There might be cases when the IIO channel is attached to the device
subnode instead of being attached to the main device node. Allow drivers
to query IIO channels by using device tree nodes.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/inkern.c         | 34 ++++++++++++++++++++++++++--------
 include/linux/iio/consumer.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index ede99e0d5371..8ff0ac472de3 100644
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
 
@@ -219,6 +219,7 @@ static struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
 
 	return chan;
 }
+EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name);
 
 static struct iio_channel *of_iio_channel_get_all(struct device *dev)
 {
@@ -261,12 +262,6 @@ static struct iio_channel *of_iio_channel_get_all(struct device *dev)
 
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
@@ -382,6 +377,29 @@ struct iio_channel *devm_iio_channel_get(struct device *dev,
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

