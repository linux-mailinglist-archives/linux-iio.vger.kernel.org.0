Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239174B8ABC
	for <lists+linux-iio@lfdr.de>; Wed, 16 Feb 2022 14:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiBPNuH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Feb 2022 08:50:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiBPNuH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Feb 2022 08:50:07 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3725B2A414F
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 05:49:50 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i11so2378644eda.9
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 05:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zozG4Oy5Pt0vWjsRDZ91928+qvWs4STBKU9M4pGg1h4=;
        b=QoFjoMeG7+RftmJsxTMAlfUkuoZlCqqvKR7llC6nNi1mHuak98r2mLaJx8rFd+9Tjg
         MPQ2vnbS6oQtQCUnGEEtJf988URbFDxjd1SUJxNy+kBJL/UDo27eJaNcJlK0iZEzevSc
         jjgq2eiUZQianObMTc8gY+i64ZCsUotiMUlBpNroLzLOUqRabIUZN55fVE2gD/x6CsCD
         ZV9NlUh7QJZzl/4DYdEOPeYvl7Wat7KfKD8kh3KubNXYAc54DxmRFxEOy7pC3K8d52T7
         KIgltVhUDbW2mIYo4AUw93V9/ZCVQvQbO6YXvCF5pwoLUAAwMHkYxUs/Sk41fCpmSDsl
         OGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zozG4Oy5Pt0vWjsRDZ91928+qvWs4STBKU9M4pGg1h4=;
        b=G/zVTSju9QKbqQhiRJOtUeqLnVLhCaqfND8oBt/9l99xOqNpWuGfLRrvu3lEwb4IJc
         34NFD/O71nWUFwfkW7mddIa+mzkEEUpkvQ8dVOOW/5LckpqNDSKsrwrA4L7Gc8mHCQXo
         i4jhbQR33zWzu2g6Ei6MnI2QKyOAu4nV0Qiu0nHah0IHO/8J8y5CKvJcORypk1KLBKwf
         FoEaEQP5ADQArrjo4pb/uu/AOtdEI5ezX4S63h2O8/UJ0mt1HKMTWOFWrcapcopG+9+T
         G+n8cNfAubMadUT7++ybq6LlwqOeTGUQUr66gRI3NE0+6GB+8EPvG2VrgSoJut6Ii5bh
         7Pew==
X-Gm-Message-State: AOAM533c5AOgrt0sxlAqcVAapv0nLFYWECc9xGzF2OsOxpOcqD3OCl90
        uBsU1Ck537Dn59H9F7gJ72ue/w==
X-Google-Smtp-Source: ABdhPJx3yCM0qzGCCShJICOBsovwzhEyf/OMU3d7kI6X/MoHQk0zs+oySrtsoTbRE0MJtDmxDyfvAQ==
X-Received: by 2002:a05:6402:2748:b0:408:c807:8db7 with SMTP id z8-20020a056402274800b00408c8078db7mr3164168edd.4.1645019388785;
        Wed, 16 Feb 2022 05:49:48 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id o20sm1711996edc.84.2022.02.16.05.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:49:48 -0800 (PST)
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
Subject: [PATCH v7 6/9] arm64: dts: qcom: pmi8998: add rradc node
Date:   Wed, 16 Feb 2022 13:49:17 +0000
Message-Id: <20220216134920.239989-7-caleb.connolly@linaro.org>
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

Add a DT node for the Round Robin ADC found in the PMI8998 PMIC.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index 0fef5f113f05..da10668c361d 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -18,6 +18,14 @@ pmi8998_gpio: gpios@c000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pmi8998_rradc: rradc@4500 {
+			compatible = "qcom,pmi8998-rradc";
+			reg = <0x4500>;
+			#io-channel-cells = <1>;
+
+			status = "disabled";
+		};
 	};
 
 	pmi8998_lsid1: pmic@3 {
-- 
2.35.1

