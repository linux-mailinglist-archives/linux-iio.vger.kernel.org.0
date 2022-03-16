Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494C14DB30F
	for <lists+linux-iio@lfdr.de>; Wed, 16 Mar 2022 15:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351780AbiCPOZf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Mar 2022 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357989AbiCPOZE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Mar 2022 10:25:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6552A71A
        for <linux-iio@vger.kernel.org>; Wed, 16 Mar 2022 07:23:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gb39so4575698ejc.1
        for <linux-iio@vger.kernel.org>; Wed, 16 Mar 2022 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DvO26pAKzW0vaTz16Nc3OyGWe78LCYAxLDV9ILkuIU=;
        b=BQ892oEO4Gu26OGpdoB2kMt6EFoyTi6eD+wKEYq9ZjpglPQP7D70or7zurachbT+mB
         f3sWvjii5aglBwT6zRiuPRh29Bg2wHlmHa3ypoonTKRvMMBGJC9jHQZZlRM69TeeWFGp
         L5Wti2ZLqEPNO5tomMkc8jrbB6dUYT9NyeevzrFZFZKzuIUnTN/TRUfYwXtYmmE9N5jm
         S6ZJTdEIox2Nq2aJKEzIHBZcjWxrq/l1VuZta6FPG7k9UJ9xjXd5CnoEO56pAJq86+Qj
         9TF5qvzXgGjq5/Xp73FWDYzOmmunKQSCqGIJtRBCwZxl/yH+la0It1YXb4rfo/Ju4pGf
         04nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DvO26pAKzW0vaTz16Nc3OyGWe78LCYAxLDV9ILkuIU=;
        b=EdFyiS4yTo3mEXziHmO1LlQYcx+DneAJ+RPj5PyHIX4v+ofNV5qSr5QdXQk+eNNOxL
         o9u1oKzev47IvLCWCmcahk6eXkydrNSsi43gl0fsM2BZzJLQp2CldjbIAD+qocb5Sa2B
         l1EqIy46M93+wDhVet8MNFjd11RYO5r/zMj9m6iQA7bPTzR3HuOZk3qV7M9wyw6COY2P
         srieRV18bZ8fN/6Y5jsl72zrihyFflnSCw0rR535Sh1u25eT7iEgHZnxQwQreSLhJCKj
         1eEoLjhwzTI/eWnGUAOsq63kv6Azlzr1xCKn4kQ+AVkraxIGByvgJlbCoJjEbaPSsJ1L
         38rw==
X-Gm-Message-State: AOAM5321L7NyL6mplrpl3HHWS7rZ2ohAapR/A0hv+bDfRSrB8/OBaegG
        3iFzxqNuWiwtZaFCi9zhVt1U6Q==
X-Google-Smtp-Source: ABdhPJw+2qfHenUAf4aiIMoOKf/gP936639lyr31KAZ7/lrnoYhhi8nyO2PyRMrb4FCV4Z/xvO2GGg==
X-Received: by 2002:a17:907:3dab:b0:6d6:a9a8:be4b with SMTP id he43-20020a1709073dab00b006d6a9a8be4bmr241949ejc.34.1647440627960;
        Wed, 16 Mar 2022 07:23:47 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm952263ejc.42.2022.03.16.07.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 07:23:47 -0700 (PDT)
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
        john.stultz@linaro.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v12 3/9] mfd: qcom-spmi-pmic: read fab id on supported PMICs
Date:   Wed, 16 Mar 2022 14:23:07 +0000
Message-Id: <20220316142313.92371-4-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316142313.92371-1-caleb.connolly@linaro.org>
References: <20220316142313.92371-1-caleb.connolly@linaro.org>
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

The PMI8998 and PM660 expose the fab_id, this is needed by drivers like
the RRADC to calibrate ADC values.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/mfd/qcom-spmi-pmic.c      | 7 +++++++
 include/soc/qcom/qcom-spmi-pmic.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index d8e54d9d3448..43e0c55696c7 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -19,6 +19,7 @@
 #define PMIC_REV4		0x103
 #define PMIC_TYPE		0x104
 #define PMIC_SUBTYPE		0x105
+#define PMIC_FAB_ID		0x1f2
 
 #define PMIC_TYPE_VALUE		0x51
 
@@ -168,6 +169,12 @@ static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (pmic->subtype == PMI8998_SUBTYPE || pmic->subtype == PM660_SUBTYPE) {
+		ret = regmap_read(map, PMIC_FAB_ID, &pmic->fab_id);
+		if (ret < 0)
+			return ret;
+	}
+
 	/*
 	 * In early versions of PM8941 and PM8226, the major revision number
 	 * started incrementing from 0 (eg 0 = v1.0, 1 = v2.0).
diff --git a/include/soc/qcom/qcom-spmi-pmic.h b/include/soc/qcom/qcom-spmi-pmic.h
index 5400e6509fe8..ff839b230e62 100644
--- a/include/soc/qcom/qcom-spmi-pmic.h
+++ b/include/soc/qcom/qcom-spmi-pmic.h
@@ -50,6 +50,7 @@ struct qcom_spmi_pmic {
 	unsigned int major;
 	unsigned int minor;
 	unsigned int rev2;
+	unsigned int fab_id;
 	const char *name;
 };
 
-- 
2.35.1

