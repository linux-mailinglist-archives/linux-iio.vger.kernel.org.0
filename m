Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EF24E566A
	for <lists+linux-iio@lfdr.de>; Wed, 23 Mar 2022 17:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245477AbiCWQaP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Mar 2022 12:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245459AbiCWQaN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2022 12:30:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A644A26AD3
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 09:28:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r22so3895425ejs.11
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuS0GFyMkF49fojOT7289HMEh2erdlNdJcyK6aLYL2U=;
        b=S94TOVpK+xO0ajQUHWO32NF7EMpklO/9MMBruSRWwCYayBm5bGeDIM7aFicgFGje3v
         1OS48MLgsdaN9d6bT0jzJczAVI/H6jqz9caJVgkF+CdL9T8XSrSRBy9n2XSKxqdBqA6U
         suuGCFHo+qIfTgx3C34FrqQAsoGBLxuKI1SlOsMqcwvqC9ORUuA16bsgiPdSBoFPmYpY
         yVN50bTcPT6M3Ea4xV7eRuqstiLCUTtmm9BGXgX/zfAJFN6gJ5+sxOZJopL9WEIKqwSz
         nDmcQz/aYDZ7rr+bj4BOdQHJTBQve9uEeabCHNO/E38MgCNp2+xqGEUWsCp0qbkSjyu3
         5t7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuS0GFyMkF49fojOT7289HMEh2erdlNdJcyK6aLYL2U=;
        b=mqL9w+lI1Mq4p4WBe8SN6GkEJyZ87ZV5v9ZYX9qLuxfBXas1nxCNrC95YU8FuopPjO
         Zk+vMvEDlWpRSEmTtRMVLo8dd/09OUIe8mAYrXO9xMov3yGZHtKZrxun0rk8sDEx3Qbu
         mBAjkRryRWmYphDUtjRuthVkLLZME25fgvy2fd3b6dRoMWAwB4a5WyIzz3BSZbJ92Cfe
         HUsmlxLLltweK4kvV9qHfV03EXRx618RDpjo4cOucWikIAZZdQAF7usajOiOEXw1YRF5
         dDJ5EDoXyJQW07QV9IH6NAyCEnbFu7tnNUTur6MVXdjqtNDH3ECJQsQ7+LX/xrX9s4zp
         eobw==
X-Gm-Message-State: AOAM533vMo8XKHS4P8/q4cZ4+QHNVReENVPm5n/e4ZVu4ODF26p0+WZj
        frs2c6U3hJeKBt9dWSwv7UgEfA==
X-Google-Smtp-Source: ABdhPJw0ju3QeaJlsfcyfL9x/ksPhIAUTg7cbMlu1CpvfH7Fi/EEZh3AAqt9t/p5kcQhTVcqR4pwfQ==
X-Received: by 2002:a17:907:6297:b0:6da:6388:dc58 with SMTP id nd23-20020a170907629700b006da6388dc58mr929026ejc.472.1648052922090;
        Wed, 23 Mar 2022 09:28:42 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm173306edm.90.2022.03.23.09.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:28:41 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v13 6/9] arm64: dts: qcom: pmi8998: add rradc node
Date:   Wed, 23 Mar 2022 16:28:17 +0000
Message-Id: <20220323162820.110806-7-caleb@connolly.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323162820.110806-1-caleb@connolly.tech>
References: <20220323162820.110806-1-caleb@connolly.tech>
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

From: Caleb Connolly <caleb.connolly@linaro.org>

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

