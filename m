Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1490C4BED04
	for <lists+linux-iio@lfdr.de>; Mon, 21 Feb 2022 23:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiBUWId (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Feb 2022 17:08:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiBUWIc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2022 17:08:32 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294AD22BED
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 14:08:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p14-20020a05600c1d8e00b0037f881182a8so304416wms.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 14:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60je+LDflCDSpm+PbhIAk73PJa9MombVHWRyiPaaQWE=;
        b=Xc+ttGq4R78QFtqn/s4XTJgEVdfnTa45KWY338EVWaVgUeKsd/3rzs+fljLfLy8hAQ
         ywWMhR2Cef3L70rleLY3XxSLO150C8Wot5CTouwd52Gtj1uJhB/b2iIgmJvpP2w0kLFM
         mihbHvkyKnJPifkH+8karxCKTZmcW7VoSXkUbPFhY5Nw9AysNrWDYEnqDpPfSnQVU6zT
         KGo1CqfO7RE7J2yaI2Bg3H1pgRXHh8A8wDw1QQkhVzpEc15sOc9/1ZykQQzm5aPwxh9L
         6qmL+OmU70hdvpnlqSo84pRS5CW+tnnrPWOyG1b/8wclFKf4ipsZBYOejtkoCKIRN6+R
         P/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60je+LDflCDSpm+PbhIAk73PJa9MombVHWRyiPaaQWE=;
        b=DfLKkB/tZBegXIatYClc2yLpBJGY2+aAYg2qJbPPuJIK/4AmMxbP3zL1Y37Haa9U/Z
         oJYOXgmaAIEs8Y57sBa8wY//KNp/9KOmPrEw+gaHmbRj48hwfscfeNtuv98GBT9sjKcB
         h+vG6NJuBSnjtyCH3FH1R8L4nNryQhnzYYslhA1pbdYtMO5znPkb+GvPm7sSWSYvazL4
         VGlRlIHfXSgVJNrYIcBSKE6WJ7bdDLrjS4v7qi0aLSYyTNOKK57xmg74ldWej3sjAYkD
         wKuF4zBG2t5jBCeaB+xNQiZFUD1nnVkzhjZ1M0POriHqPrYhPEQc8ezJe0+r6lAW8BA5
         1ZUg==
X-Gm-Message-State: AOAM533IWQjqOBsSCIkA1daPNsmZ5lerbSnb0zX7n+dJcRWjIrkTnbRV
        uxoi6BnKh1Ce3ru5tMhLWF8ajQ==
X-Google-Smtp-Source: ABdhPJySvP8m2Z4xEHLtT7V1pqg8A5o8lAHBN72Y7cEMji5QGaJrIVqIDM4jOtJiknnTHt3q4gAjOQ==
X-Received: by 2002:a05:600c:14c6:b0:37c:440:c0e with SMTP id i6-20020a05600c14c600b0037c04400c0emr817905wmh.87.1645481286698;
        Mon, 21 Feb 2022 14:08:06 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id w8sm51626093wre.83.2022.02.21.14.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 14:08:06 -0800 (PST)
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
Subject: [PATCH v8 9/9] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc
Date:   Mon, 21 Feb 2022 22:07:43 +0000
Message-Id: <20220221220743.541704-10-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221220743.541704-1-caleb.connolly@linaro.org>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
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

Enable the PMI8998 RRADC.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 367389526b41..b3b6aa4e0fa3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -312,6 +312,10 @@ resin {
 	};
 };
 
+&pmi8998_rradc {
+	status = "okay";
+};
+
 /* QUAT I2S Uses 1 I2S SD Line for audio on TAS2559/60 amplifiers */
 &q6afedai {
 	qi2s@22 {
-- 
2.35.1

