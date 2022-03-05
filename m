Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257774CE222
	for <lists+linux-iio@lfdr.de>; Sat,  5 Mar 2022 03:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiCECN7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Mar 2022 21:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiCECN5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Mar 2022 21:13:57 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0891C947A
        for <linux-iio@vger.kernel.org>; Fri,  4 Mar 2022 18:13:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r65so6013052wma.2
        for <linux-iio@vger.kernel.org>; Fri, 04 Mar 2022 18:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zozG4Oy5Pt0vWjsRDZ91928+qvWs4STBKU9M4pGg1h4=;
        b=uNRtyAzfKZk14qzM1batj5nvP+iQvPUNDegJJQK83K1IgweksKvchgSWmLgO2BZzQp
         ClO3l7Fy3HeW7MgDBELGwm9csWHHvEDzGZBo/r0BhVARGnXGsLQ8t+AJxvJDZ3CFx2eB
         ZkUc+aMau5yNYCYl15qhVm9vgm8aaWVFcD6lXuVeH9E7p7fzkZ2WKh9ZdCpjnSaYVYzA
         gy7x7vQjt8Kp4UGHbdFOWzIubp31PQWpji35WBPmNESSdOAUpqqXWDFNpla7z5AoCZFv
         v3GYmki/Yq3agBY1ywJ4/KQ4e/a8TMrI99oOge12BxniPS1tvPZYy+buDeENdVXP//tZ
         O36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zozG4Oy5Pt0vWjsRDZ91928+qvWs4STBKU9M4pGg1h4=;
        b=IIXYv5wGT9/Zf90PYFUnXk4ZA/BRjsVm2CB2MQv1miTVkEXcZ4rvcdtUtXw3Kywoxd
         DiL94pTqsyFjFAGUPoLP1n7vRdCjE+jADNCcANw29o/6bNYYKD1n+GdMFfTkhXXVyFWc
         MgXtep1+QSG1FJ8hGyi7/CRjgSaUqVNCvE9SkYU0iC9NPAv5/udwXV6BxxmT1Nlxz655
         sm0qgjSnA+E14LtNRf9tmq94GUgci4oENCgBbc0GL2I3RadJRxDkJwb9rHTq1d4As/+3
         hnoaC9lHQv6swPs5QVpVhKkppy/OJRsS2WvR9iNf2NjvC9X6CSSSVm/PrZ4IR5hk1jJQ
         tJcA==
X-Gm-Message-State: AOAM533mFFULYH0FTxAjgGUEqOa2R+ouUSV24PJUliLOZq5ZQUCG4isc
        s5HSav82Ks7wnns/J+11FP+RBw==
X-Google-Smtp-Source: ABdhPJyQlL/v7fgTy9ZWrRRl6L7c1rpHSOz/MoFG4kl2f8XD/xuim/aY9pTifCrovr98IxCunVe9sA==
X-Received: by 2002:a05:600c:795:b0:381:87d9:e566 with SMTP id z21-20020a05600c079500b0038187d9e566mr9969267wmo.100.1646446385974;
        Fri, 04 Mar 2022 18:13:05 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id k10-20020adfe3ca000000b001f0329ba94csm7932589wrm.18.2022.03.04.18.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 18:13:05 -0800 (PST)
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
Subject: [PATCH v10 6/9] arm64: dts: qcom: pmi8998: add rradc node
Date:   Sat,  5 Mar 2022 02:12:44 +0000
Message-Id: <20220305021247.1020122-7-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305021247.1020122-1-caleb.connolly@linaro.org>
References: <20220305021247.1020122-1-caleb.connolly@linaro.org>
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

