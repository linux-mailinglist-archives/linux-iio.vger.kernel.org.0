Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7CB4B2F42
	for <lists+linux-iio@lfdr.de>; Fri, 11 Feb 2022 22:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353544AbiBKVUX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Feb 2022 16:20:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352934AbiBKVUW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Feb 2022 16:20:22 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCF5C5E
        for <linux-iio@vger.kernel.org>; Fri, 11 Feb 2022 13:20:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v12so17320046wrv.2
        for <linux-iio@vger.kernel.org>; Fri, 11 Feb 2022 13:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ydVzqquU4q/bWYrhn+94me4Lj3peddSiUdmbeVAiITc=;
        b=eSsxeZ4orkbspSt5KyAoqc7J1G/ZVd50cU0CRQdOoyaUDUM2GyOsV5HrStc2X/sJiR
         reAHMUR+YEcXzGhuvA+YZtNBiI81wN7pJclpVCoZP+yB/13or87sp6PsYyAcFW8bEo5D
         ajsz5GOvDmg5hcIjS6cV3YqMaVrACl/tyCibGHXUTxBFWYUjXcRFmGRwpUMMJ7sMRf6J
         p4YsJ/3wbDI7VEdSQF1lPVVWbQKo7kv5gZyNku/H4yJGgWrkzIzhYJ7fjcPGbCkhk9lV
         5arye/KpxpBVL5j339xJyzXFKBtc4D7IGqnNaqRLzXdkDmfznNFPEng0uT/5SGiDC0ZB
         Ut/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydVzqquU4q/bWYrhn+94me4Lj3peddSiUdmbeVAiITc=;
        b=ihtHcGg8C9LISJ+YfyJxwpg2DCq7WQWU7c81nWO0xPqfInZ1Gza7nnrZUUlixHXSn3
         q0xesyCm9Qt03yvUROeWpdAT8kKXqjpD5+Q/s7evsHW3HCR1RbLRuUBZh6uJBq1BJ9Br
         Riyx4Ck9fGMzJjMa2mIfHeEJLg7mNIeETM+vhQSF/n4ts0wkWEFOY3VtquojYtx0uzCl
         zCk1ev3RxLyWQoY/sLVB6LqobUZ6596YPqoWrkkkJrclmsqcmlQ19bsDLqCoaO2nlV6a
         aDKvr8tEHeR6DJ/fNXx9PQXXB0By/CDCuaZvQZ2HOx2OAp9lrAD4IEHn+3s6NqtOJnk9
         OHPA==
X-Gm-Message-State: AOAM532M8fh/BHQOMbsp4+HWiGAmPRFg/dT/5d5EyUWRfq4fDn1odPSi
        pPFuU9QQKZbpw3XqQa4Gah5YCQ==
X-Google-Smtp-Source: ABdhPJzhZEYpbYwKubpWDwBWiROzAN94i5PS0Q4CpmndFnMgR0mcybs5TbwKfi0KKdJUUO/HtNQVZw==
X-Received: by 2002:a05:6000:1861:: with SMTP id d1mr2775461wri.92.1644614418738;
        Fri, 11 Feb 2022 13:20:18 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id x5sm14276017wrv.63.2022.02.11.13.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:20:18 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
Subject: [PATCH v4 2/8] mfd: qcom-spmi-pmic: read fab id on supported PMICs
Date:   Fri, 11 Feb 2022 21:19:53 +0000
Message-Id: <20220211211959.502514-3-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211211959.502514-1-caleb.connolly@linaro.org>
References: <20220211211959.502514-1-caleb.connolly@linaro.org>
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
index 4af88b8bb7d0..c77b4c82559e 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -19,6 +19,7 @@
 #define PMIC_REV4		0x103
 #define PMIC_TYPE		0x104
 #define PMIC_SUBTYPE		0x105
+#define PMIC_FAB_ID		0x1f2
 #define PMIC_TYPE_VALUE		0x51
 
 static const struct of_device_id pmic_spmi_id_table[] = {
@@ -145,6 +146,12 @@ static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,
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

