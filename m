Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E304B2F41
	for <lists+linux-iio@lfdr.de>; Fri, 11 Feb 2022 22:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353587AbiBKVU3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Feb 2022 16:20:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349534AbiBKVU3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Feb 2022 16:20:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B239EC67
        for <linux-iio@vger.kernel.org>; Fri, 11 Feb 2022 13:20:24 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o24so14596662wro.3
        for <linux-iio@vger.kernel.org>; Fri, 11 Feb 2022 13:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qImSYxU2i/y/qV71r8EFW+LTWk9ZfhM4KeM2jcTcklQ=;
        b=QxSLu+fdnas6QlKDy7hc1wCxmmCDCQi+UF54FoGDjT0/row5+zFN9h7vVwxtrRwgEb
         RsfLpn8W7cF5CJun/sXq2tSchnoPLFfOzWSuMXAyP2m1fhf4AA0iFuyA5CUaYNGYHi9f
         AKK5+Y3lFoZ/VCNbsyoLptA60yuRKPckAipE9+dzW+alA7ceSttMPnuzIXP5O4VHIDlT
         UMA7a2c8IBIJgyCU4wjbOT7k+qT0yluM35SUIWi4FoVFXUZMfiqboAzISXONTrr6XUbX
         qlmd3DL7VH8mFxttR5mgcKBo1dE8RYc8Nb2OWmowPk4wulvWt6VsirLWQgmH0uP5psUi
         A0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qImSYxU2i/y/qV71r8EFW+LTWk9ZfhM4KeM2jcTcklQ=;
        b=EiJsUQltCgNLRAxIejs6TXB4spAgqE6dWI1g/TNiX3lsnOofLfLnNvkzP1b06yId42
         TlCJeFSF1n0syMLTtVJm1qcFq2RpIQuu7Iw04PlH81QIijyFyzW9CIkHyLf8yBT6SHF5
         JKGGpewOnvpXXLONOnA92/DtCX+vcfpW0NIvAjmdoHgFn3LsNuxmIFPRQGO9ubEWmzql
         zsDdwk64iLhOkgyuX7uAXxKlmxjxhxz9GIAh5JVilG2O22nPRoa4w5wjAqNpINghUi5o
         FhX0weK8iddhnCteCmL6hdoRQyjfRU7D1hDr6aSHsJYLYThcssP7M4j+LOad9o4eo87C
         U0Rg==
X-Gm-Message-State: AOAM531evlGimg7LvI6ZOfve6T+qqf1r9g3FCnH+FdFI9lsfBA66bv5P
        5U+r03JyW6o6t1LY5uuRo5P7FA==
X-Google-Smtp-Source: ABdhPJwEMh8WUnv/93PC2BLzWSybKIbelfP/NotI4vBM1XGxq9G+upA/cpNaC5b5dt47h+SnBImeBw==
X-Received: by 2002:adf:e350:: with SMTP id n16mr2623926wrj.180.1644614423232;
        Fri, 11 Feb 2022 13:20:23 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id x5sm14276017wrv.63.2022.02.11.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:20:22 -0800 (PST)
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
Subject: [PATCH v4 6/8] arm64: dts: qcom: sdm845-oneplus: enable rradc
Date:   Fri, 11 Feb 2022 21:19:57 +0000
Message-Id: <20220211211959.502514-7-caleb.connolly@linaro.org>
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

Enable the RRADC for the OnePlus 6.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 7f42e5315ecb..e8287cf02511 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -450,6 +450,10 @@ pinconf {
 	};
 };
 
+&pmi8998_rradc {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
-- 
2.35.1

