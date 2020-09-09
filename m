Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7B426347C
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 19:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgIIRVV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 13:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgIIPXP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2020 11:23:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88700C061245
        for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2020 07:43:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n25so3900834ljj.4
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2020 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9XrjFGnoRqCSCs6cVjFrMjJIwNqM5369XpR4oYmLeI=;
        b=H1EFJNoINXeMhsVKKzpJRq7znAYFNKIgq0IhqKPYBXMSmX4BKAV0/pJ/cNeTJywuXt
         NDYEppk2e18cu6HBoBdQpC3rBGWGm30QKY9OjONC+KeVdm74HBDnDq0q3r/m2PezLICV
         sNDq5incZhdjcAsTHZewqdAB2zN0WRFcb82CrjSonqm7+q35GI+JDMxULqMR9+zoNBVa
         7Pk8kV8pA6Q/LRnRA+tMcHqiWES9LxCNxxlIX2IvIvfc7dYEOTssPOG4vkrsQQXeDeIO
         EqUPADOa/BoBjbq3euBr48pST7ecsicXJUAdDxJ4LmR3oMezgJ5eTC9o0zWhq0cos67z
         WYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9XrjFGnoRqCSCs6cVjFrMjJIwNqM5369XpR4oYmLeI=;
        b=AjsAq/0h6t+tM92t39RW206pJKYQXC0pslewCwTU6L+gCRV3vi5XACQgsykdr+qObY
         rl97+We+GbY6sDR4w3BZqi9O0iNGqPZ9Ak5AJc2XUgW7h4t9EqqMAspBKgzUnw6FYXKV
         j2ayCbBByr74M/eAxUg7SYJfv1Jxc/KVdmReM2278vk1lTDMI0m2JoipoGr4HSMdtkpp
         ZFL+Cv/pfa8lt1Uhz4MY9hTl4EAklt8b34rDGLOSyCacmgwTOlutCLeI2QlZUsHgNGOl
         k/1JI4s0HGQkBjT5YqatX2wDrIfXY30bNVy03UxKXYksewiCId+/WJTvebkidiuJN2eE
         Z1ig==
X-Gm-Message-State: AOAM531IYE/mF88Zlj6pzsk5kb3FDV8Y3M/2vfAitIBKzmCHHZbyGS3D
        JJaDtdE9s6HtjODhWV3wmwpFAA==
X-Google-Smtp-Source: ABdhPJy9V5KQ5/i9QrXxhIvtTTtWeMz1irShOM5AJKlbXC6Dg30DG1DFFQLgJnhMH5QcB7xDaY5HZg==
X-Received: by 2002:a2e:9690:: with SMTP id q16mr1939107lji.401.1599662596623;
        Wed, 09 Sep 2020 07:43:16 -0700 (PDT)
Received: from eriador.lan ([188.162.64.155])
        by smtp.gmail.com with ESMTPSA id t12sm621665lfk.26.2020.09.09.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:43:16 -0700 (PDT)
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
Subject: [PATCH v3 06/10] iio: adc: qcom-spmi-adc5: use of_device_get_match_data
Date:   Wed,  9 Sep 2020 17:42:44 +0300
Message-Id: <20200909144248.54327-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909144248.54327-1-dmitry.baryshkov@linaro.org>
References: <20200909144248.54327-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use of_device_get_match_data() instead of hand-coding it manually.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

