Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA94A4B76F9
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbiBOQz3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 11:55:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241993AbiBOQz2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 11:55:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B664F117C84
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j26so22333572wrb.7
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNxZnQWwG3AA+5zjZr6bjMk+OGB5iWm30KygedH2/Bk=;
        b=mNhvqKQ1juVFDZ9s3Fm2DhsfOjfwPzSRZXqcIsuHO9Pq6ry4NXLaKqOA2eQQFLN1dy
         AY0qZQPeD5P13AWw6dwz2MLvB1f1sjgFjwFAhfoBl+9thtFbWedQ9Jkl5rrTSojoqe+1
         9zd/qt++AnsTo+GWd5V+nL4f86yueR8skI+rYt5BGg4thGboZtJZ61ZJAmLghKZyQCU7
         LUuFwdo26sBJnE7vzcAsxXJ6d0O6zzixFz+Km3MsoRkoV3QgFkR2PPuYFkzZmzA0uhL5
         Hj1RvNANCWIbC3S2VAt98AL7vNKc68WkmJ6Xv63oRMs8W5Ne+Y0JAVQnX4TytM5/ZxH0
         XShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNxZnQWwG3AA+5zjZr6bjMk+OGB5iWm30KygedH2/Bk=;
        b=nkYMI0STuKjmUuiQFwQZo0U4zd75/7EAuQjssFv+lqZtheOjO7neudm5I7COHXyRYp
         dlp2W2l16lZ99lwV5JcKwKwsxJdEP9Hte8m21CtppMgEK8OCre4uY3TmioHvbi4o+OaF
         22dRF+MCkBBHV3BDkdFs2jIgQnkhBPLGnRkGPg/J41eQZw9IbmFv1pyVr01I5Bvj64Bs
         lqhxDtKali+rJYNEWwOwz+5HREY1t7UgvXwTPloRsP+8lYq8iBy2SYbUG0oiFdLgcDHV
         Q8EFz4tnG1v/C7p6cujZxZuWYLl8GLPVEfqpDnlgKGv3AGytEz1aKAPncZeeqFQjF4TV
         01eg==
X-Gm-Message-State: AOAM533dHvhaxwlZiyGNRN5xzsNNObxANt4twcjOLJr0+9zBxSQ9Qt4Z
        j3juAU4qZfWxjXvhRfeaZxyYsQ==
X-Google-Smtp-Source: ABdhPJyDGP3paBPyhUBqt/g2V8rppqyEEkJbuuwFLiyfq5JDF0MAntwvWnleg+yX+l9VR/Uy3sD5ig==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr4071695wrs.133.1644944116360;
        Tue, 15 Feb 2022 08:55:16 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id f14sm15373652wmq.3.2022.02.15.08.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:55:15 -0800 (PST)
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
Subject: [PATCH v5 3/9] mfd: qcom-spmi-pmic: read fab id on supported PMICs
Date:   Tue, 15 Feb 2022 16:54:50 +0000
Message-Id: <20220215165456.1205583-4-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215165456.1205583-1-caleb.connolly@linaro.org>
References: <20220215165456.1205583-1-caleb.connolly@linaro.org>
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

