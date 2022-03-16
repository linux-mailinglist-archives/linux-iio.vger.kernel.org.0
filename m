Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0114F4DB31F
	for <lists+linux-iio@lfdr.de>; Wed, 16 Mar 2022 15:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiCPOZo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Mar 2022 10:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358049AbiCPOZL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Mar 2022 10:25:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BEE2A71A
        for <linux-iio@vger.kernel.org>; Wed, 16 Mar 2022 07:23:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so4543058ejc.7
        for <linux-iio@vger.kernel.org>; Wed, 16 Mar 2022 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zozG4Oy5Pt0vWjsRDZ91928+qvWs4STBKU9M4pGg1h4=;
        b=RbjMwbGNcb6c7RugdkdNCGXYneVvcDAeDIhPykZ6vgz7dqzrC5/Ym5DOMhYh/UhIsT
         u6mfVhyX/RYSV3NuKNzBF2aUeAj8gl2qBxyjZFYacHuQ+FuzgLkEJY+eZiTmiLp7SpTW
         eUkYmArUZQboS36zotOggDfw8PRGNus05l6GEWCFgwu1m44P4yNH5ZZsCKAM9xQKdfaH
         dPG3U8x4I7VA0EyBiclyh2jf8QDe/AvJYfVJK1nngKpgP/o+dFbc5oYDd0HOEX7lY74F
         2MtOflM3sc6kMwnzY/44PM3LamZK8HkgcbKquL4XVO0iDh4KS3eyoPNerzNn/GA6J8d4
         Db9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zozG4Oy5Pt0vWjsRDZ91928+qvWs4STBKU9M4pGg1h4=;
        b=vjP2/b/Y0ketd/9A75swcPymlVGDIGUvRDNsa22H/v8nRrgHLl2jnOh/DT0rI4XKic
         AlNdXWGxq483Gqi81yIZ0W+xa2Gz8pfB7yOkFVbLZpH+LrG4gvV15fJsy42NKtqLqAhP
         Ht9P/74OwBPIO5Ld/GXw+E9XZELwD14j0KT9akfay4o2S2WwX5iC2xmIUDN7W0BC8ROz
         nTq+vURET44mlHmH1maMsmLQkcrZrmN1rf14WXSI8CF41TFTDgnaYGcFopu/3a5y+aSX
         b700tCCgR9LIsnLVfIvjBQJ1O5wTCGfRTvK0twmdV+szTujtOnwHuMvgFpJVeL4jzlat
         nSRA==
X-Gm-Message-State: AOAM532IqVNHph3MUh/JMZfuI+hlaOmIr5U/nyYM0i5wA/3kpgi1DDnq
        ZfC2bbFyT2ZA5IWf1dlaIjQWAg==
X-Google-Smtp-Source: ABdhPJzkmnfQv+KGzD/5H6vEZs5TCSzFF2d+13jj+C/PyFd6SVmkfLGA5pGkLGVyzCJ3CktKRNSAEw==
X-Received: by 2002:a17:906:53c3:b0:6cf:742d:84de with SMTP id p3-20020a17090653c300b006cf742d84demr196982ejo.576.1647440631994;
        Wed, 16 Mar 2022 07:23:51 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm952263ejc.42.2022.03.16.07.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 07:23:51 -0700 (PDT)
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
Subject: [PATCH v12 6/9] arm64: dts: qcom: pmi8998: add rradc node
Date:   Wed, 16 Mar 2022 14:23:10 +0000
Message-Id: <20220316142313.92371-7-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316142313.92371-1-caleb.connolly@linaro.org>
References: <20220316142313.92371-1-caleb.connolly@linaro.org>
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

