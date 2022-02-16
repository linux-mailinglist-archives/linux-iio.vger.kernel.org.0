Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E654B8AB3
	for <lists+linux-iio@lfdr.de>; Wed, 16 Feb 2022 14:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiBPNuA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Feb 2022 08:50:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiBPNt7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Feb 2022 08:49:59 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652602A39E8
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 05:49:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id q17so4049498edd.4
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 05:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNxZnQWwG3AA+5zjZr6bjMk+OGB5iWm30KygedH2/Bk=;
        b=nXXKiUGFrOFcLVSZ6SO9Gg9jxXz1BG4paYxeJX11UxydSzgBZPcNAtFdn2/zdyBMdb
         UiyVD1iSxdMvgjXCVFAugFsReabH+cA52VHZCrRUbwWi2x3kZ/8dQObAtuXMLpwXSOOh
         jSfXvRjskF0fQxtbakDr3y8UI6g+e+IrsJfOtiWkO6E8dlMi/U7nAyA0Y2i/HFeGVJ0a
         woNfK/Ysj46rvFg2EJhORRjUoZ0VhxQuYtQp1NLLCaKDd9546+RrU0hkcazLI/osoJlX
         rwAdiUn6CefrsXFLlmursRiYW1OivYsl2WlZhu1ggP3txIh6WYzKK3IxwVRp4CFPRegb
         4wRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNxZnQWwG3AA+5zjZr6bjMk+OGB5iWm30KygedH2/Bk=;
        b=i4cEvPuZfco2aHGIPeBW4QJKjPjUxDX9jpeKIuTC945wf80T/jT4CfmHRfNC9LB9+5
         6c5V9vS4XtcIjNP/B/ZXicp0k6tBDf936V1vB0jqKWOcdsjA7yhQTv+OF+RyDQdTroa+
         XZPVmBe4axS1eFQZj1lZHxmnt/F1FAqN9ZNNRhqQtNndVo5buEVyhruQaHWj7aMhl4uQ
         RlSHjTQ0M9qih3Ct0lvVGXL9FG1MrdiwOEJHqfz+jls2Z/nEEjYK4BdqZBko3oY5dFOL
         atjhZx3CmBT/UwR5WZG5Miryjcp++R0DnnAw8hCSqNlZbrjlInNMJy88UyADDNNnAtEc
         Wldw==
X-Gm-Message-State: AOAM533jnBQaT3WhVcs+Sqxvs+t6p/5jmgbekfUEqvikSiJ4tp5ehO21
        d0F5/Rpcjlt2m8LPCwjlvqVymQ==
X-Google-Smtp-Source: ABdhPJxE+x90FKHVnvvKlo3q5mQUipJ1lCcEh26NzaiJEfBTbJJn29uIU1o5r5n9pM+eilfmfjkAtg==
X-Received: by 2002:a05:6402:5191:b0:40f:b9e0:4d1b with SMTP id q17-20020a056402519100b0040fb9e04d1bmr3166531edd.149.1645019385008;
        Wed, 16 Feb 2022 05:49:45 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id o20sm1711996edc.84.2022.02.16.05.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:49:44 -0800 (PST)
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
Subject: [PATCH v7 3/9] mfd: qcom-spmi-pmic: read fab id on supported PMICs
Date:   Wed, 16 Feb 2022 13:49:14 +0000
Message-Id: <20220216134920.239989-4-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216134920.239989-1-caleb.connolly@linaro.org>
References: <20220216134920.239989-1-caleb.connolly@linaro.org>
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

The PMI8998 and PM660 expose the fab_id, this is needed by drivers like
the RRADC to calibrate ADC values.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mfd/qcom-spmi-pmic.c      | 7 +++++++
 include/soc/qcom/qcom-spmi-pmic.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index 5e656485cd55..28600e5899bc 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -21,6 +21,7 @@
 #define PMIC_REV4		0x103
 #define PMIC_TYPE		0x104
 #define PMIC_SUBTYPE		0x105
+#define PMIC_FAB_ID		0x1f2
 #define PMIC_TYPE_VALUE		0x51
 
 static const struct of_device_id pmic_spmi_id_table[] = {
@@ -169,6 +170,12 @@ static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,
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
index a8a77be22cfc..c821f6c6c8a8 100644
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

