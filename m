Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4252A3219
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 18:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgKBRuO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 12:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgKBRuN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 12:50:13 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1056AC061A48
        for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2020 09:50:13 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id j30so18555471lfp.4
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2020 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rs/lmUbls2+lr33cOkF5wTnejEIFAqou3Xfg7WIvltg=;
        b=AtUed3X2GLP53kZbub1Y8vSWzguouXA/gxJrcLu8HuotAdUz2lpJXfAsAuiPHTLg/C
         duvvn3gmqC9hcyazyXqLgnApvpo4cy6NKN1HKxO1tm3cnueFCBAo6Oua/sz4WhQDG8Xb
         GB0QlfTrhqIo0DD6dhny3gfAoefLF7SEpizyNze+4xoyr+ufPgShmhC1JMFdIemqSJPY
         kKmPvnBy7M+jc/QOaPVLRVl5t5z+Jq+S6onfI0qMeg81OqCX1OINHRu/hTDhGrmfl61F
         3PeGAvXILFmXN+EBBiL9FMRPJScZnQJtSM8eVeE8RI3iqWQwLXFBQG0uEG7FBYqJIOXz
         nwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rs/lmUbls2+lr33cOkF5wTnejEIFAqou3Xfg7WIvltg=;
        b=hEpbNd6ux9yM62O3LOMem/tNXOnBw+Y2j+/32FCfso6Vpyv8f+w6SnjdfRYeuYsyJw
         dFde90QwFg6NghPWYSX0Yxae5BTe+NrDHq0UOpr0fJaHJHYTe9u5DTrp1WXd+73FIUwW
         OrJLBOugN8ugVfuXF53QMh1bB1j39ZRJt/n5u4iDmskP2oItxf3BxqiGSSnwcwuql1br
         cLJsFADw2PqD1vkNHUTIalZBFpnxUYSgC3CWupKPPovzxhbKs3rLK31BctxN2VYgJbE4
         jzXQL1+nD9mqZ0LjEML3CJC7YOcAeCxCtiW7l+kSVEqdrWFi+DL4koIwdrwXBGzqnAmr
         BD5Q==
X-Gm-Message-State: AOAM530wCIjFghatVvUtEN25QwtmGudVGNZlLUNVJ94kFZzwKYcn2Upn
        /8jN11E31LbvLW9R/BRJ3BVF6g==
X-Google-Smtp-Source: ABdhPJzkSq0fbqmIX2KshqrZEa62v/ZUdJ4DTeEkL5VcS9LiC3PCGSZJ7MHTn1erkV5cz/8TAsiXqg==
X-Received: by 2002:a19:8c52:: with SMTP id i18mr6198143lfj.115.1604339411546;
        Mon, 02 Nov 2020 09:50:11 -0800 (PST)
Received: from eriador.lan ([94.25.229.254])
        by smtp.gmail.com with ESMTPSA id r7sm2516163lfc.206.2020.11.02.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:50:10 -0800 (PST)
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
Subject: [PATCH v9 06/15] iio: adc: qcom-spmi-adc5: use of_device_get_match_data
Date:   Mon,  2 Nov 2020 20:49:41 +0300
Message-Id: <20201102174950.1148498-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
References: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
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
index b10a0fcf09dc..87438d1e5c0b 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -15,6 +15,7 @@
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

