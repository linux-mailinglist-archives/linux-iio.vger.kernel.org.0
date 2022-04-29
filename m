Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF251582F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 00:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381408AbiD2WO3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Apr 2022 18:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381386AbiD2WOZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2022 18:14:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190BBDC982
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:11:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so5465415wmn.1
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0WEp4V6aZMyxWhcrxEKABYt19rBiXZcxvqKzE3SZIe0=;
        b=Keg2qgtxsT0PNgxhjstP7bYXmZKcqHZMFZ6OQJGAz4/VS7eA8idH/UxV3ZZJ0ZdE19
         aFKzPoA8oCSVmRyOjGcPEEKpK4XhyjrHZ7u7FzBWnRHoPfqJiAENT+FayNNe66CearY3
         kGfekX4RrHA3rhlvh7ZpdBnDrUUUEVNxWprtS37MvfNbVHpwgHVcgn83++PCWMXlJa/X
         lKKIzQmtKyfLylEBsr7GSuYv6LBI9JbI4BQI4RHn+dyS2OmYmfCu+1ospXcyL0dkBMy0
         QYpXNZbjIpQQAl7K1bxcAs7Cb/zOad3C0AraEAxRBz4AX4Y55gbWRXiuHOBW4Mttaptk
         ADAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0WEp4V6aZMyxWhcrxEKABYt19rBiXZcxvqKzE3SZIe0=;
        b=AQCCxIpx2S8yX/awZeLUateU6Yc85s7vPfXlAvsuURF3+caNitSyJmyHPmM1rll9fR
         kw4evSlmybxV2XGcKsMuyeJShS0QPLgYbKSpiCFh/05+xMod54sVPESyPW/pX+nBzZsX
         QBJAsqq/ScWE2xm00hSQBNvl4KKv5oBqhMy2B04L5hNW/NUnQUMr0ME1i1iM5+NuDTJ9
         M76cS7DecBYU11vDoTHs63Gg+RGmhkljQHkjw+4cpnK+kYrHFSL3ldFApI8YTXjxB/KX
         Vrulf517bv2p0sSZTAYgZ0m3MXvF/R1ATvODqbvG9Wr64TjX2sjLTi+toY7CYma1z5+Q
         Tmwg==
X-Gm-Message-State: AOAM531lgWFLVhSRCL6AL7JXT+7SUZqiF1QqOefzwZa85GajGZVBpRUR
        Rux/WNv7O/rctLMW1GDPN/T3oB+fvAEWaA==
X-Google-Smtp-Source: ABdhPJz08OJcXIZ9HOmIoOx8RtC+6enH4juHgqsBFwco6tpfuwvu9EuEHJWx7vowVSp6ol5iQ584dw==
X-Received: by 2002:a05:600c:4f90:b0:392:8de8:9deb with SMTP id n16-20020a05600c4f9000b003928de89debmr933061wmq.166.1651270264475;
        Fri, 29 Apr 2022 15:11:04 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003942a244ebfsm291985wmq.4.2022.04.29.15.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:11:03 -0700 (PDT)
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
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v14 08/10] arm64: dts: qcom: sdm845-db845c: enable rradc
Date:   Fri, 29 Apr 2022 23:09:03 +0100
Message-Id: <20220429220904.137297-9-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220429220904.137297-1-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable the Round Robin ADC for the db845c.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 28fe45c5d516..40a290b6d4f3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -599,6 +599,10 @@ resin {
 	};
 };
 
+&pmi8998_rradc {
+	status = "okay";
+};
+
 /* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
 &q6afedai {
 	qi2s@22 {
-- 
2.36.0

