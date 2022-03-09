Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1193E4D3B8D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Mar 2022 22:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiCIVBf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Mar 2022 16:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiCIVBd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2022 16:01:33 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B52E50453
        for <linux-iio@vger.kernel.org>; Wed,  9 Mar 2022 13:00:32 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id r13so7819744ejd.5
        for <linux-iio@vger.kernel.org>; Wed, 09 Mar 2022 13:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78gNKgWiy0CQ87WA98rgoolaf4MxcOEltw1vanlXH7U=;
        b=YbIsSSHvOwDSGIYBhXCzuqYXUDy0PJ6SyhyDN2+eu4VBJ9/G8d6p7dUH2b1T598wHC
         KwWbM8tOrRc4IRIZayRrmFtL3ypUDhKt8d2cbDLWiBTah6gFTrBoNhD9odAwR1U96dtk
         eWxFY0BMP2lv4OV3MAgJSoXCi5IpwbHheogbIZzv6yvTVLbANtbmMviZ4mDkUWJj+7Hn
         1WsFfq/oDyhH0EpsSyRHRbGyxlgwJeN5lMa1IjkjVx8Ghr+eppyfTZG1CNBqKejrZIWA
         t6fWIRMvSNIq1NA0uf9VL5auIStyZ345lOaPitemdNQY2BjI5u6BXPoCehI3ccJaEXkJ
         Bu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78gNKgWiy0CQ87WA98rgoolaf4MxcOEltw1vanlXH7U=;
        b=lF3Xu2eAAe0fYCbxdhkqYTkLEEW6uQyKKW88jjLx2HvnnLfKG3uJzqbN543TIwYp83
         gIZchuJTWQcWBKzA9/ni85d/ufitDGFneVh8Oj73HH8Qw+ybKdaPZMLUgg7njntUQrV3
         lVKVuLP0A/qsvooBEZnEsDHe6upS3W/sUOUVzUzZlDkktXAdBbMzujE/iIlnmNgdLOu5
         YHW2xX+JCEKI7NJh9Y+bvbLY8DdExVIyjhUF2knXf7FIJbdyLX62VD6unpdpguDGjolS
         gTLlPo1ENXkEgG3qSsCjpAyaFYb0xpoozoieFrhd5RxIOEUQNecp4X7wMxpFsrPCL2Eb
         j5hg==
X-Gm-Message-State: AOAM530kPjybmVJycxVfix6Pm3vgN420QjaeVUgqZKyHN9l3VtA3dx+1
        shYyu8M//t2W3nLdP8OBp/J1wA==
X-Google-Smtp-Source: ABdhPJzuAXi/heRBaT8VpOtzZ1vP8b14JYcHpddF+nuvvKj7lBXWnwMZBHeYtW3Z1jKvUvLWIwa95A==
X-Received: by 2002:a17:907:6d1d:b0:6cf:3fa:4d80 with SMTP id sa29-20020a1709076d1d00b006cf03fa4d80mr1460505ejc.544.1646859631446;
        Wed, 09 Mar 2022 13:00:31 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709061c5a00b006da815e14e2sm1114743ejg.37.2022.03.09.13.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:00:31 -0800 (PST)
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
Subject: [PATCH v11 3/9] mfd: qcom-spmi-pmic: read fab id on supported PMICs
Date:   Wed,  9 Mar 2022 21:00:08 +0000
Message-Id: <20220309210014.352267-4-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309210014.352267-1-caleb.connolly@linaro.org>
References: <20220309210014.352267-1-caleb.connolly@linaro.org>
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

