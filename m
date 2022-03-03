Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0514CB5AF
	for <lists+linux-iio@lfdr.de>; Thu,  3 Mar 2022 05:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiCCECF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Mar 2022 23:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCCECD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2022 23:02:03 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD68C15D3A0
        for <linux-iio@vger.kernel.org>; Wed,  2 Mar 2022 20:01:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j17so5847382wrc.0
        for <linux-iio@vger.kernel.org>; Wed, 02 Mar 2022 20:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78gNKgWiy0CQ87WA98rgoolaf4MxcOEltw1vanlXH7U=;
        b=CdH1Uh1DdfoZv0vBwhq4SpTqi17GiFS+aWxcR6aOA5t/wJvD0dT01haxj0xzX8wJOQ
         Sz/JNyC/v9HK6Fux7mols8l8VY6FfLc7hjMI+LVcA56MPIJEthzfTT1n3rsu/gdk2tbd
         /YV6Q8lTqerj7JMtWXI9rI+e9zcIa+ebIY5YZ1Z5CnFd4CsaLHI2NvP9k/TiEST2X72f
         kt69pq6wqi0NmlzPGAL1k1vBkYorjmZOWn3WH/nlcfsmWDNXYr4ac+RfB/RMRpkCyHZO
         b34zoMdrE4FynVUnjp0xQkeB2P1CtPUW9ksgcs48QemRH49KHH/j61B2iQ2mQcoRkQoi
         GvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78gNKgWiy0CQ87WA98rgoolaf4MxcOEltw1vanlXH7U=;
        b=BfL1QQvhya0gICwaA/+VUx0wI8BRb7w3EItObmZSCoW5/IrG5A/r3c8WdusgKpGL5K
         GUh+wXQxXPN8GFhYs+mJJrtV2np6Vq7rl4m2ZEmBn4Vx7hy++pVSM2Y2z82eG9p+lm8B
         V5CmpO+CPjPKyQxqkTvaPxoofOF6lEIZy+znqhPHK4GMFTBp5ls/YFrWWcJB1iWSXPXQ
         g+2uuK2NHWq2q0ITpJ7iEDfbHnnijKMQKSlbOTl9KMDX0GoC5zdRPFOHY/sHsTkpyr6q
         TaVKxHNa0O193w3u/R6H/KRJC0NtApI9bt5csc1UqxmH5B/Ln5eRk6+n4LI4qWpIwnS6
         Ku0A==
X-Gm-Message-State: AOAM530MzMJJV+XLpvPC1/26E86biYG2sAsy763mti+CGmFfxXgBU6vP
        fsM8Kdgvih3fX4ozT2lWMIVGKg==
X-Google-Smtp-Source: ABdhPJxoEuv47gn1t6cXSg2MKUIwNTZywdi4TZAf2Oo/LmaWRE1956EmhaBeYt/W+5bUb65+zGp0rg==
X-Received: by 2002:a5d:5887:0:b0:1d7:36e4:e40f with SMTP id n7-20020a5d5887000000b001d736e4e40fmr25801628wrf.298.1646280072313;
        Wed, 02 Mar 2022 20:01:12 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id r16-20020a5d4e50000000b001f0075f4ca1sm702615wrt.105.2022.03.02.20.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:01:11 -0800 (PST)
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
Subject: [PATCH v9 3/9] mfd: qcom-spmi-pmic: read fab id on supported PMICs
Date:   Thu,  3 Mar 2022 04:00:29 +0000
Message-Id: <20220303040035.1454103-4-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303040035.1454103-1-caleb.connolly@linaro.org>
References: <20220303040035.1454103-1-caleb.connolly@linaro.org>
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
index bfe1304aee1b..b12a07da6183 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -19,6 +19,7 @@
 #define PMIC_REV4		0x103
 #define PMIC_TYPE		0x104
 #define PMIC_SUBTYPE		0x105
+#define PMIC_FAB_ID		0x1f2
 
 #define PMIC_TYPE_VALUE		0x51
 
@@ -175,6 +176,12 @@ static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,
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

