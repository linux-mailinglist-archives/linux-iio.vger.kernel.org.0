Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D0E2860AD
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgJGNzQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Oct 2020 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgJGNyz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Oct 2020 09:54:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A7EC0613DC
        for <linux-iio@vger.kernel.org>; Wed,  7 Oct 2020 06:54:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l13so2046405ljg.10
        for <linux-iio@vger.kernel.org>; Wed, 07 Oct 2020 06:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btHk6QbobgU8CR1iug8dhO0BVhzD57z+OLRWCB8dwFQ=;
        b=T/VTm/YSF3Ij54vKWClKvbN9oElgubXicQB23+l5C6HTL1wsTOOYy+Nt9oZx7WEE6f
         V5PnpJOsjslYhfCOaUFKVsdz7e8ztvruWLIdqz1VBytpMIH/j0C1OAr1BmMv0ZwK4VXl
         NaDwhUsmF7EKNmRiPy6HXjtt9lan2abS+m6fUOEczN/OKuCOEncapvMHbZW+QA1ybTDD
         nxlPwyeqRrSUIZhMsF1JkojQ9yuiFMB8UnyWSJmqJF3CDDJXfU8A51jtLG5bcgitCU2o
         6DpwObP66eMla1w0ihgtHxPViYVKsBwe1IuJ36hV1xgcve2BBqhFjEnwkhr1UGCIGpJI
         gQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btHk6QbobgU8CR1iug8dhO0BVhzD57z+OLRWCB8dwFQ=;
        b=BodTVykzTL74uSh0aCuEGZT1LS4EzhlwZ1O1GMT6BKT1dM+v2h4mCjocIoTmEj6xd+
         zvstiul5+to8U3+i2ui/FgJevQt5+SLF+T03HsVsxEvQz7Vlxfo00DG41rfNgzXzwuYD
         PLwaRPucRD2MEHO4iOENQc/woih6qHVEhrjvgIkywYWcM0uFyFo8ky09vNqcDy+PxTCj
         GbGHEftoK/O95PUgXuHkMhIdmIrS60+Lv2Y6zIf9MvCaZmVGQ489gUn1Scgx1eiA/+N7
         Wf/fL8Xgx3uAFyNEj7ZWoCEzYnhnAcn7Ia4/yWRv1IYS34yq+ZzHoH3icWZgT1Z+E39T
         r3jQ==
X-Gm-Message-State: AOAM5338Yv2jhyrmyc7lhPQp7cmZaRIvHKLFX1EFaxaPL2JkKG6ODcw7
        /icLF4IbuFoDlugoiNKizcCDiA==
X-Google-Smtp-Source: ABdhPJx8vFPJquBB9BTaM2vnVuT+ddeA1rnSrBsjJTXQsaoeo/Jma+J2Mv70+u3FZ+i7p8+QMn6vqA==
X-Received: by 2002:a2e:86d2:: with SMTP id n18mr1137220ljj.400.1602078889485;
        Wed, 07 Oct 2020 06:54:49 -0700 (PDT)
Received: from localhost.localdomain ([188.162.65.250])
        by smtp.gmail.com with ESMTPSA id n3sm339768lfq.274.2020.10.07.06.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 06:54:48 -0700 (PDT)
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
Subject: [PATCH v7 05/10] iio: adc: qcom-spmi-adc5: use of_device_get_match_data
Date:   Wed,  7 Oct 2020 16:54:28 +0300
Message-Id: <20201007135433.1041979-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
References: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

