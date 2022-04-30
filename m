Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC18515812
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 00:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381368AbiD2WOY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Apr 2022 18:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378776AbiD2WOX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2022 18:14:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9444610DA
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:10:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e24so12398878wrc.9
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wk5ZJ9ZfaVp1BtGV8TGcSwxdYyvQ2YTWMvc9givEkmE=;
        b=p+K4F+Uoz0d58n8+mdSTf92x7NqRIQjCy/RiQ+hU7uOYoUVIq0sgWv7eR4wlG4hVFc
         WC6Tm3IIfcB1g28ljme5Tp0lxnvScnuU2YMLUs/+65+48k0oFFw4G5F+3y7O+zNfJd22
         NqkhTGzcSfBfljmdr1+Q6/R0q5Mujo9+QPlNkC+LT2t2CKsWofhDbWRjGcwmeSxkubK9
         ts6WJDJvOu5F1u1r3iXtPRZneQFYLmk8L4t7MpJIKm0BjFlYh+8y8HpIjTImOu3A6Fdm
         UDFmaBx7eaqZGntpYDlIarJSI0GvGevy8VfNgIyUwFCsaxIcNrVeTNLsyD6KSzv2nJvB
         VF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wk5ZJ9ZfaVp1BtGV8TGcSwxdYyvQ2YTWMvc9givEkmE=;
        b=D8KfhBppgqQRTIeXRfE1CnlhpjT0Qu9a6SdUg2YEjvsGTV7q11jp9ksEBd5GuiARND
         QLOMuT4/ssXXeZNRXGFbHPJjv+vJQzjOBXwYvrOC/mIaoE5CcrGRU7ycPjfTxtuZ+A7Q
         BOGY3jAm9ib4BYLjGn1QRw5uZLEcEjuqElA0kn2zV28M/2bhmIdux8fz95+2jaN4K8gQ
         kuhprK13qHgIMBDNyU01twVFMMwn59h7GTqWY8VBXraMR2xWbQZUjV92ZU85zA1OUEE/
         /TU6TZyZcThOXCOa8LrPgWPm6Q1YrQoDq9ILIRlEfA9gPZx+r2BLsddmjicENo0x3idb
         943g==
X-Gm-Message-State: AOAM530pzt3mlUcPg+RFMkh0tV14DR9WZMcyyK0yRwd5w3F6cYtVc3Gm
        pm7sqx2dh8fAp3tpMJDI6cO2vQ==
X-Google-Smtp-Source: ABdhPJxEzTmclDLrMlAvnt2cBDaLXpz7/qh3Cgon9JASDaxDbITV8F1SeYf7VkMUTePRtr+/p2xbkQ==
X-Received: by 2002:a5d:4882:0:b0:207:97dd:111c with SMTP id g2-20020a5d4882000000b0020797dd111cmr882437wrq.115.1651270257028;
        Fri, 29 Apr 2022 15:10:57 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003942a244ebfsm291985wmq.4.2022.04.29.15.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:10:56 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v14 02/10] mfd: qcom-spmi-pmic: expose the PMIC revid information to clients
Date:   Fri, 29 Apr 2022 23:08:57 +0100
Message-Id: <20220429220904.137297-3-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220429220904.137297-1-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some PMIC functions such as the RRADC need to be aware of the PMIC
chip revision information to implement errata or otherwise adjust
behaviour, export the PMIC information to enable this.

This is specifically required to enable the RRADC to adjust
coefficients based on which chip fab the PMIC was produced in,
this can vary per unique device and therefore has to be read at
runtime.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/mfd/qcom-spmi-pmic.c      | 265 ++++++++++++++++++++----------
 include/soc/qcom/qcom-spmi-pmic.h |  60 +++++++
 2 files changed, 235 insertions(+), 90 deletions(-)
 create mode 100644 include/soc/qcom/qcom-spmi-pmic.h

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index 1cacc00aa6c9..5403306b1863 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -3,11 +3,16 @@
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/spmi.h>
+#include <linux/types.h>
 #include <linux/regmap.h>
 #include <linux/of_platform.h>
+#include <soc/qcom/qcom-spmi-pmic.h>
 
 #define PMIC_REV2		0x101
 #define PMIC_REV3		0x102
@@ -17,106 +22,140 @@
 
 #define PMIC_TYPE_VALUE		0x51
 
-#define COMMON_SUBTYPE		0x00
-#define PM8941_SUBTYPE		0x01
-#define PM8841_SUBTYPE		0x02
-#define PM8019_SUBTYPE		0x03
-#define PM8226_SUBTYPE		0x04
-#define PM8110_SUBTYPE		0x05
-#define PMA8084_SUBTYPE		0x06
-#define PMI8962_SUBTYPE		0x07
-#define PMD9635_SUBTYPE		0x08
-#define PM8994_SUBTYPE		0x09
-#define PMI8994_SUBTYPE		0x0a
-#define PM8916_SUBTYPE		0x0b
-#define PM8004_SUBTYPE		0x0c
-#define PM8909_SUBTYPE		0x0d
-#define PM8028_SUBTYPE		0x0e
-#define PM8901_SUBTYPE		0x0f
-#define PM8950_SUBTYPE		0x10
-#define PMI8950_SUBTYPE		0x11
-#define PM8998_SUBTYPE		0x14
-#define PMI8998_SUBTYPE		0x15
-#define PM8005_SUBTYPE		0x18
-#define PM660L_SUBTYPE		0x1A
-#define PM660_SUBTYPE		0x1B
-#define PM8150_SUBTYPE		0x1E
-#define PM8150L_SUBTYPE		0x1f
-#define PM8150B_SUBTYPE		0x20
-#define PMK8002_SUBTYPE		0x21
-#define PM8009_SUBTYPE		0x24
-#define PM8150C_SUBTYPE		0x26
-#define SMB2351_SUBTYPE		0x29
+#define PMIC_REV4_V2		0x02
+
+struct qcom_spmi_dev {
+	int num_usids;
+	struct qcom_spmi_pmic pmic;
+};
+
+#define N_USIDS(n)		((void *)n)
 
 static const struct of_device_id pmic_spmi_id_table[] = {
-	{ .compatible = "qcom,pm660",     .data = (void *)PM660_SUBTYPE },
-	{ .compatible = "qcom,pm660l",    .data = (void *)PM660L_SUBTYPE },
-	{ .compatible = "qcom,pm8004",    .data = (void *)PM8004_SUBTYPE },
-	{ .compatible = "qcom,pm8005",    .data = (void *)PM8005_SUBTYPE },
-	{ .compatible = "qcom,pm8019",    .data = (void *)PM8019_SUBTYPE },
-	{ .compatible = "qcom,pm8028",    .data = (void *)PM8028_SUBTYPE },
-	{ .compatible = "qcom,pm8110",    .data = (void *)PM8110_SUBTYPE },
-	{ .compatible = "qcom,pm8150",    .data = (void *)PM8150_SUBTYPE },
-	{ .compatible = "qcom,pm8150b",   .data = (void *)PM8150B_SUBTYPE },
-	{ .compatible = "qcom,pm8150c",   .data = (void *)PM8150C_SUBTYPE },
-	{ .compatible = "qcom,pm8150l",   .data = (void *)PM8150L_SUBTYPE },
-	{ .compatible = "qcom,pm8226",    .data = (void *)PM8226_SUBTYPE },
-	{ .compatible = "qcom,pm8841",    .data = (void *)PM8841_SUBTYPE },
-	{ .compatible = "qcom,pm8901",    .data = (void *)PM8901_SUBTYPE },
-	{ .compatible = "qcom,pm8909",    .data = (void *)PM8909_SUBTYPE },
-	{ .compatible = "qcom,pm8916",    .data = (void *)PM8916_SUBTYPE },
-	{ .compatible = "qcom,pm8941",    .data = (void *)PM8941_SUBTYPE },
-	{ .compatible = "qcom,pm8950",    .data = (void *)PM8950_SUBTYPE },
-	{ .compatible = "qcom,pm8994",    .data = (void *)PM8994_SUBTYPE },
-	{ .compatible = "qcom,pm8998",    .data = (void *)PM8998_SUBTYPE },
-	{ .compatible = "qcom,pma8084",   .data = (void *)PMA8084_SUBTYPE },
-	{ .compatible = "qcom,pmd9635",   .data = (void *)PMD9635_SUBTYPE },
-	{ .compatible = "qcom,pmi8950",   .data = (void *)PMI8950_SUBTYPE },
-	{ .compatible = "qcom,pmi8962",   .data = (void *)PMI8962_SUBTYPE },
-	{ .compatible = "qcom,pmi8994",   .data = (void *)PMI8994_SUBTYPE },
-	{ .compatible = "qcom,pmi8998",   .data = (void *)PMI8998_SUBTYPE },
-	{ .compatible = "qcom,pmk8002",   .data = (void *)PMK8002_SUBTYPE },
-	{ .compatible = "qcom,smb2351",   .data = (void *)SMB2351_SUBTYPE },
-	{ .compatible = "qcom,spmi-pmic", .data = (void *)COMMON_SUBTYPE },
+	{ .compatible = "qcom,pm660", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm660l", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8004", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8005", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8019", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8028", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8110", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8150", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8150b", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8150c", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8150l", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8226", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8841", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8901", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8909", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8916", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8941", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8950", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8994", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pm8998", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pma8084", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pmd9635", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pmi8950", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pmi8962", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pmi8994", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pmi8998", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pmk8002", .data = N_USIDS(2) },
+	{ .compatible = "qcom,smb2351", .data = N_USIDS(2) },
+	{ .compatible = "qcom,spmi-pmic", .data = N_USIDS(1) },
 	{ }
 };
 
-static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
+/*
+ * A PMIC can be represented by multiple SPMI devices, but
+ * only the base PMIC device will contain a reference to
+ * the revision information.
+ *
+ * This function takes a pointer to a pmic device and
+ * returns a pointer to the base PMIC device.
+ *
+ * This only supports PMICs with 1 or 2 USIDs.
+ */
+static struct spmi_device *qcom_pmic_get_base_usid(struct device *dev)
 {
-	unsigned int rev2, minor, major, type, subtype;
-	const char *name = "unknown";
-	int ret, i;
+	struct spmi_device *sdev;
+	struct qcom_spmi_dev *ctx;
+	struct device_node *spmi_bus;
+	struct device_node *other_usid = NULL;
+	int function_parent_usid, ret;
+	u32 pmic_addr;
 
-	ret = regmap_read(map, PMIC_TYPE, &type);
-	if (ret < 0)
-		return;
+	sdev = to_spmi_device(dev);
+	ctx = dev_get_drvdata(&sdev->dev);
+
+	/*
+	 * Quick return if the function device is already in the base
+	 * USID. This will always be hit for PMICs with only 1 USID.
+	 */
+	if (sdev->usid % ctx->num_usids == 0)
+		return sdev;
 
-	if (type != PMIC_TYPE_VALUE)
-		return;
+	function_parent_usid = sdev->usid;
+
+	/*
+	 * Walk through the list of PMICs until we find the sibling USID.
+	 * The goal is to find the first USID which is less than the
+	 * number of USIDs in the PMIC array, e.g. for a PMIC with 2 USIDs
+	 * where the function device is under USID 3, we want to find the
+	 * device for USID 2.
+	 */
+	spmi_bus = of_get_parent(sdev->dev.of_node);
+	do {
+		other_usid = of_get_next_child(spmi_bus, other_usid);
+
+		ret = of_property_read_u32_index(other_usid, "reg", 0, &pmic_addr);
+		if (ret)
+			return ERR_PTR(ret);
+
+		sdev = spmi_device_from_of(other_usid);
+		if (pmic_addr == function_parent_usid - (ctx->num_usids - 1)) {
+			if (!sdev)
+				/*
+				 * If the base USID for this PMIC hasn't probed yet
+				 * but the secondary USID has, then we need to defer
+				 * the function driver so that it will attempt to
+				 * probe again when the base USID is ready.
+				 */
+				return ERR_PTR(-EPROBE_DEFER);
+			return sdev;
+		}
+	} while (other_usid->sibling);
+
+	return ERR_PTR(-ENODATA);
+}
+
+static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,
+				 struct qcom_spmi_pmic *pmic)
+{
+	int ret;
 
-	ret = regmap_read(map, PMIC_SUBTYPE, &subtype);
+	ret = regmap_read(map, PMIC_TYPE, &pmic->type);
 	if (ret < 0)
-		return;
+		return ret;
 
-	for (i = 0; i < ARRAY_SIZE(pmic_spmi_id_table); i++) {
-		if (subtype == (unsigned long)pmic_spmi_id_table[i].data)
-			break;
-	}
+	if (pmic->type != PMIC_TYPE_VALUE)
+		return ret;
+
+	ret = regmap_read(map, PMIC_SUBTYPE, &pmic->subtype);
+	if (ret < 0)
+		return ret;
 
-	if (i != ARRAY_SIZE(pmic_spmi_id_table))
-		name = pmic_spmi_id_table[i].compatible;
+	pmic->name = of_match_device(pmic_spmi_id_table, dev)->compatible;
 
-	ret = regmap_read(map, PMIC_REV2, &rev2);
+	ret = regmap_read(map, PMIC_REV2, &pmic->rev2);
 	if (ret < 0)
-		return;
+		return ret;
 
-	ret = regmap_read(map, PMIC_REV3, &minor);
+	ret = regmap_read(map, PMIC_REV3, &pmic->minor);
 	if (ret < 0)
-		return;
+		return ret;
 
-	ret = regmap_read(map, PMIC_REV4, &major);
+	ret = regmap_read(map, PMIC_REV4, &pmic->major);
 	if (ret < 0)
-		return;
+		return ret;
 
 	/*
 	 * In early versions of PM8941 and PM8226, the major revision number
@@ -124,15 +163,49 @@ static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
 	 * Increment the major revision number here if the chip is an early
 	 * version of PM8941 or PM8226.
 	 */
-	if ((subtype == PM8941_SUBTYPE || subtype == PM8226_SUBTYPE) &&
-	    major < 0x02)
-		major++;
+	if ((pmic->subtype == PM8941_SUBTYPE || pmic->subtype == PM8226_SUBTYPE) &&
+	    pmic->major < PMIC_REV4_V2)
+		pmic->major++;
+
+	if (pmic->subtype == PM8110_SUBTYPE)
+		pmic->minor = pmic->rev2;
+
+	dev_dbg(dev, "%x: %s v%d.%d\n",
+		pmic->subtype, pmic->name, pmic->major, pmic->minor);
+
+	return 0;
+}
+
+/**
+ * qcom_pmic_get() - Get a pointer to the base PMIC device
+ *
+ * This function takes a struct device for a driver which is a child of a PMIC.
+ * And locates the PMIC revision information for it.
+ *
+ * @dev: the pmic function device
+ * @return: the struct qcom_spmi_pmic* pointer associated with the function device
+ */
+inline const struct qcom_spmi_pmic *qcom_pmic_get(struct device *dev)
+{
+	struct spmi_device *sdev;
+	struct qcom_spmi_dev *spmi;
+
+	/*
+	 * Make sure the device is actually a child of a PMIC
+	 */
+	if (!of_match_device(pmic_spmi_id_table, dev->parent))
+		return ERR_PTR(-EINVAL);
+
+	sdev = qcom_pmic_get_base_usid(dev->parent);
 
-	if (subtype == PM8110_SUBTYPE)
-		minor = rev2;
+	if (IS_ERR(sdev))
+		return ERR_CAST(sdev);
 
-	dev_dbg(dev, "%x: %s v%d.%d\n", subtype, name, major, minor);
+	spmi = (struct qcom_spmi_dev *)dev_get_drvdata(&sdev->dev);
+
+	return &spmi->pmic;
 }
+EXPORT_SYMBOL(qcom_pmic_get);
 
 static const struct regmap_config spmi_regmap_config = {
 	.reg_bits	= 16,
@@ -144,14 +217,26 @@ static const struct regmap_config spmi_regmap_config = {
 static int pmic_spmi_probe(struct spmi_device *sdev)
 {
 	struct regmap *regmap;
+	struct qcom_spmi_dev *ctx;
+	int ret;
 
 	regmap = devm_regmap_init_spmi_ext(sdev, &spmi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	ctx = devm_kzalloc(&sdev->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->num_usids = (uintptr_t)of_device_get_match_data(&sdev->dev);
+
 	/* Only the first slave id for a PMIC contains this information */
-	if (sdev->usid % 2 == 0)
-		pmic_spmi_show_revid(regmap, &sdev->dev);
+	if (sdev->usid % ctx->num_usids == 0) {
+		ret = pmic_spmi_load_revid(regmap, &sdev->dev, &ctx->pmic);
+		if (ret < 0)
+			return ret;
+	}
+	spmi_device_set_drvdata(sdev, ctx);
 
 	return devm_of_platform_populate(&sdev->dev);
 }
diff --git a/include/soc/qcom/qcom-spmi-pmic.h b/include/soc/qcom/qcom-spmi-pmic.h
new file mode 100644
index 000000000000..440e94235bfc
--- /dev/null
+++ b/include/soc/qcom/qcom-spmi-pmic.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2022 Linaro. All rights reserved.
+ * Author: Caleb Connolly <caleb.connolly@linaro.org>
+ */
+
+#ifndef __QCOM_SPMI_PMIC_H__
+#define __QCOM_SPMI_PMIC_H__
+
+#include <linux/device.h>
+
+#define COMMON_SUBTYPE		0x00
+#define PM8941_SUBTYPE		0x01
+#define PM8841_SUBTYPE		0x02
+#define PM8019_SUBTYPE		0x03
+#define PM8226_SUBTYPE		0x04
+#define PM8110_SUBTYPE		0x05
+#define PMA8084_SUBTYPE		0x06
+#define PMI8962_SUBTYPE		0x07
+#define PMD9635_SUBTYPE		0x08
+#define PM8994_SUBTYPE		0x09
+#define PMI8994_SUBTYPE		0x0a
+#define PM8916_SUBTYPE		0x0b
+#define PM8004_SUBTYPE		0x0c
+#define PM8909_SUBTYPE		0x0d
+#define PM8028_SUBTYPE		0x0e
+#define PM8901_SUBTYPE		0x0f
+#define PM8950_SUBTYPE		0x10
+#define PMI8950_SUBTYPE		0x11
+#define PM8998_SUBTYPE		0x14
+#define PMI8998_SUBTYPE		0x15
+#define PM8005_SUBTYPE		0x18
+#define PM660L_SUBTYPE		0x1A
+#define PM660_SUBTYPE		0x1B
+#define PM8150_SUBTYPE		0x1E
+#define PM8150L_SUBTYPE		0x1f
+#define PM8150B_SUBTYPE		0x20
+#define PMK8002_SUBTYPE		0x21
+#define PM8009_SUBTYPE		0x24
+#define PM8150C_SUBTYPE		0x26
+#define SMB2351_SUBTYPE		0x29
+
+#define PMI8998_FAB_ID_SMIC	0x11
+#define PMI8998_FAB_ID_GF	0x30
+
+#define PM660_FAB_ID_GF		0x0
+#define PM660_FAB_ID_TSMC	0x2
+#define PM660_FAB_ID_MX		0x3
+
+struct qcom_spmi_pmic {
+	unsigned int type;
+	unsigned int subtype;
+	unsigned int major;
+	unsigned int minor;
+	unsigned int rev2;
+	const char *name;
+};
+
+inline const struct qcom_spmi_pmic *qcom_pmic_get(struct device *dev);
+
+#endif /* __QCOM_SPMI_PMIC_H__ */
-- 
2.36.0

