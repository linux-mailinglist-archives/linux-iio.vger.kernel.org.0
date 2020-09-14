Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175CB2690CC
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgINP5T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 11:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgINPsi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2020 11:48:38 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4ABC06178B
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 08:48:36 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y11so13979006lfl.5
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 08:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btHk6QbobgU8CR1iug8dhO0BVhzD57z+OLRWCB8dwFQ=;
        b=BskFKmBpD3LBBSf5uwm6teu3RTCPExDq/qlffgXpv/7AEmFoHWRj+I325RoWH4OlOs
         5fiuoX4lgdyXdWT9KO51kTQRNCrXqb1lfop6iIvcAz6cIX71cWHqM8eVJnL51e9idnHy
         cvVejVH6txnrmQGAXhD199dPnjVqD4HffYoVi8CqJ0A/lQwBT3z69TIUYmhgkXTBaMYc
         lqdYxRxCjGlnFBfeKrfncPnUGai5zvoBt7iNUaie3n5D2XjHRX5Q9EYkOFVy87QKBH4i
         Jki0LHH9ukN0iRWMFzHX8aKpGE9t353PTRtPbADUlbmUG63pLVwsm/XGpmMqCpJ5fkmj
         eA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btHk6QbobgU8CR1iug8dhO0BVhzD57z+OLRWCB8dwFQ=;
        b=sUj7T6I2YWPt8MGRVIS28TFEsE6L3UI1YKY9X+PUOTahlUaFBhlnwacMf9XBLbRYUo
         9l5EwmAof4dmH3mE4N7wKSxYbng59UD1OLXRayZvizVKpG4bbjF/2O1JMIJtT2vDDGtR
         OGCbxaUKRRzRkLoXghO+vZ7w4rIXDVwQ9fKZIzntNMRYcNO6WjsZ8Njl+AY6f+ke10ZX
         fkrbhjLuc4qOTmaFZxPY9p+OgKp4K9AjfqZvWXZG1Qt+DRavw2vaaYPF5Yv6On5ZgX58
         Cnbnoh7ha8eiNpCZ1rRHzFJl/z621aPQjXdoEmLXu1LBy6PTb8vd3Gmre2pgzyQc4FZe
         HWaQ==
X-Gm-Message-State: AOAM531QPsT/q/rukTrOmYh6NMs78Sv0nk91GDVRyflmRP64gyoJm4D1
        8Er6NsC9EgATB46WTakqqydBjw==
X-Google-Smtp-Source: ABdhPJxbWCokRhT7qXb3pgU6zx2UAnwOWjVuUqoOw8PeFxTfQTh8PWDcDXIcWtSmx4J1AOsSgAhkQQ==
X-Received: by 2002:a19:7e8d:: with SMTP id z135mr5451322lfc.158.1600098515123;
        Mon, 14 Sep 2020 08:48:35 -0700 (PDT)
Received: from eriador.lan ([188.162.64.187])
        by smtp.gmail.com with ESMTPSA id f19sm3834650lfs.85.2020.09.14.08.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:48:34 -0700 (PDT)
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 5/9] iio: adc: qcom-spmi-adc5: use of_device_get_match_data
Date:   Mon, 14 Sep 2020 18:48:05 +0300
Message-Id: <20200914154809.192174-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
References: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use of_device_get_match_data() instead of hand-coding it manually.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index c2da8f068b87..ae27ed7a26ff 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -14,6 +14,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -807,8 +808,6 @@ static int adc5_get_dt_data(struct adc5_chip *adc, struct device_node *node)
 	struct adc5_channel_prop prop, *chan_props;
 	struct device_node *child;
 	unsigned int index = 0;
-	const struct of_device_id *id;
-	const struct adc5_data *data;
 	int ret;
 
 	adc->nchannels = of_get_available_child_count(node);
@@ -827,24 +826,21 @@ static int adc5_get_dt_data(struct adc5_chip *adc, struct device_node *node)
 
 	chan_props = adc->chan_props;
 	iio_chan = adc->iio_chans;
-	id = of_match_node(adc5_match_table, node);
-	if (id)
-		data = id->data;
-	else
-		data = &adc5_data_pmic;
-	adc->data = data;
+	adc->data = of_device_get_match_data(adc->dev);
+	if (!adc->data)
+		adc->data = &adc5_data_pmic;
 
 	for_each_available_child_of_node(node, child) {
-		ret = adc5_get_dt_channel_data(adc, &prop, child, data);
+		ret = adc5_get_dt_channel_data(adc, &prop, child, adc->data);
 		if (ret) {
 			of_node_put(child);
 			return ret;
 		}
 
 		prop.scale_fn_type =
-			data->adc_chans[prop.channel].scale_fn_type;
+			adc->data->adc_chans[prop.channel].scale_fn_type;
 		*chan_props = prop;
-		adc_chan = &data->adc_chans[prop.channel];
+		adc_chan = &adc->data->adc_chans[prop.channel];
 
 		iio_chan->channel = prop.channel;
 		iio_chan->datasheet_name = prop.datasheet_name;
-- 
2.28.0

