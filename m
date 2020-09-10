Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB44C2652E4
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 23:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgIJVZh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 17:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgIJOXK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 10:23:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7465C06138A
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2020 07:00:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a15so8360649ljk.2
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2020 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ykRgAbS1+NNh7dx3qxwh0Qb3QTBtyJsrNZlzRunA0I=;
        b=KKvbZN1SFa/gjwNr/RrbT87qA0xOk8yWGIRo8uaPv3RAMYNwYyc6lHZ2S5kNqtifAx
         4MnF4TwMDO7PwIeJODUbDfSWkBr11wDPGVPOBf/5S0W/i7wL50qD64gg7Waxhfhn0Ucv
         5bcSEM1yryJ5kfDnXKagqbM5ycL2xwC7Q7dLqLzi+41gBEbR+CH5IxksCG6Bx8dmkBrH
         20tluDoLGAH0vvXv4B1rwxvHMMlDC+nufQ6ZePa/veSX9uxFE/T08amnSKVUlwaFM4VF
         T8qzWTLFryfPfjElQljBlKBnGCw03jyhisH+lhFIzkyt6PlICMMk7YJ0rY+igM71c/vI
         zmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ykRgAbS1+NNh7dx3qxwh0Qb3QTBtyJsrNZlzRunA0I=;
        b=o1pCSKyI5HP1wBv4p+H5XWg3q7jgK3MSQZ+z69suLwMw7XSZkezVX8OCgMfiDLJZY0
         zprcr3cH6O2MlSS8as59XtBJ7lh++BS/GJp2YrbNztI1tJVesuK0CvIdertZ4TvAwUCL
         eyRswLOsCHdSo18V4SzNHN7iBVBh3aBvG3yQs72sveOmYnrNFyIGLEUcGpS3+ljzUejt
         8kWcFAojEUkzlUhANOPP1fGUVeVMwegFvtgVSeZg7zk+1wCE3b3NXo7dQI8iOqFzYnjW
         P61KqCvZsqdGZWnQC747TU8kgHdk/liMMsCNqAgIdVO6KTsU6h1DUWOQw0NWGFmlGWqH
         mkFg==
X-Gm-Message-State: AOAM532p689dhgk7zrxRpc9FxvFdtZ2a02CgOaxYqd/eK367etWY9VgX
        7pFMzYXRCA7IYGf2EnoSTx905Q==
X-Google-Smtp-Source: ABdhPJwRV5S3T/UDuAz7QQFMs8pIuYr3gM1oUEqk1kSQQUsDjQVsox7dUCn0RDBy0bgdNyVLSyhGwA==
X-Received: by 2002:a2e:b615:: with SMTP id r21mr4203124ljn.341.1599746421274;
        Thu, 10 Sep 2020 07:00:21 -0700 (PDT)
Received: from eriador.lan ([188.162.64.156])
        by smtp.gmail.com with ESMTPSA id t82sm1367646lff.43.2020.09.10.07.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 07:00:20 -0700 (PDT)
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
Subject: [PATCH v4 06/10] iio: adc: qcom-spmi-adc5: use of_device_get_match_data
Date:   Thu, 10 Sep 2020 16:59:56 +0300
Message-Id: <20200910140000.324091-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910140000.324091-1-dmitry.baryshkov@linaro.org>
References: <20200910140000.324091-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use of_device_get_match_data() instead of hand-coding it manually.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

