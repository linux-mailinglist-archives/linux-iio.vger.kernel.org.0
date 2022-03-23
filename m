Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40B44E5668
	for <lists+linux-iio@lfdr.de>; Wed, 23 Mar 2022 17:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245463AbiCWQaO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Mar 2022 12:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245471AbiCWQaL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2022 12:30:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C0D27176
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 09:28:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w25so2477069edi.11
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 09:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q7ALBpa1H7J5Znnyp0NyfPTGDXom5l350vD6rFfpZxQ=;
        b=ou1L1ttEEFQpeiGCHRYAYAEn1Fyts5i/IAKTXahAD/BDnz5cfdlna9oihAcGUOCTiH
         Fid0D+lWnfBkfXbfXAwO69xSBGcodvvckQs5+dIfIs4d/brF/LZFSRAfowXShcBjwFlw
         QBX9fC0ORl/tBmHlYYO2m17xONFnllWkfqMC05IAkLVjT8dVXAABtdSF7QE3tWT6qjCB
         S9hwHau1pMKtelff+63ayzkuHVsZs9xlEHON9shOBEzM3ZF7YZasAbSgBOAfnqoYgiy2
         Ivgtxq5yTujZwS3BrKguBrNdvVchCMxz+3A5ssbupNBs8i83I7tzTxq31JoOoEijcUVa
         +F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q7ALBpa1H7J5Znnyp0NyfPTGDXom5l350vD6rFfpZxQ=;
        b=2FjAPQ9WQXVR3AjYzPIgI5VL26xFUoO3dP1iqPoREA08vfUU0PMdCplRYPc9cg95YG
         W87ey75zad5PN1r1vwRXwhQVpDQ9NIGxRx6rxTuJRVDo+DQwVNOScM+Bj2qgbHl0L2Z1
         LizfMK5rpKYA1hCr/BYDOtkV4hY8XA4SGlx4QnfLeWj5AItCrDkC2aEgQ4RW5Yyza9yX
         4jy4905Rg0pxVmuLzPZSOHL3nfVaD+U0wSvARlvj/YAdX5QO9KlnnKHQuoCS4vb3k+0v
         MXprUTPs9QFymHataB6KeNoph2sU2qFx3m0Wk/nsEffNEcgQJfVBEQX5wkdBLB6eMRBV
         kiwQ==
X-Gm-Message-State: AOAM532BP5VZ3fL1ZnazCOZNV9yazO1yOHJCu5REI9xq4ZiQlIkMgrIE
        kQtKZEu2dxBHchJZXV6Z9/m1Mw==
X-Google-Smtp-Source: ABdhPJz3gXtd2L4EOC+4OwmQe6yPxILb6Ms3UBzrlL8LxSmkC6vCIYdQb6t09qhKJuWId9xpGtU9gg==
X-Received: by 2002:a50:c344:0:b0:418:e53f:f19b with SMTP id q4-20020a50c344000000b00418e53ff19bmr1179275edb.222.1648052918240;
        Wed, 23 Mar 2022 09:28:38 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm173306edm.90.2022.03.23.09.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:28:37 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v13 3/9] mfd: qcom-spmi-pmic: read fab id on supported PMICs
Date:   Wed, 23 Mar 2022 16:28:14 +0000
Message-Id: <20220323162820.110806-4-caleb@connolly.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323162820.110806-1-caleb@connolly.tech>
References: <20220323162820.110806-1-caleb@connolly.tech>
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

From: Caleb Connolly <caleb.connolly@linaro.org>

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

