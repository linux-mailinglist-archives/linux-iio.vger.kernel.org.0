Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6245F4D3B9D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Mar 2022 22:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbiCIVBk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Mar 2022 16:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbiCIVBj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2022 16:01:39 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DD030F4A
        for <linux-iio@vger.kernel.org>; Wed,  9 Mar 2022 13:00:40 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m12so4421278edc.12
        for <linux-iio@vger.kernel.org>; Wed, 09 Mar 2022 13:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60je+LDflCDSpm+PbhIAk73PJa9MombVHWRyiPaaQWE=;
        b=B/SsSko0/xEOe0BScbcgOZHUGbhB1OsrlOPsnqrWEkSM2mkE1aouuwQjNsnIeY1z/r
         SL9gQ4Nn7hndmhotYsBkrCCvUf9TX2rt6bW4C2KAfJq62J+nFpk5Z9k+0kdKn0dC+FB0
         F9IjuR2fGdswMRSSqegNmW6N3XBnNIa2RC5bB+k67PVasaO9RE4/honB9ji4eb7va81/
         9Uegc8R/EFVlVJ6zBCa/92svNvXDjEDDv7e9h0G0xBKDP9lEXMgsddxHLRQ8aUtR/GHc
         jX+lF3BtjbuZUbRzJ1eWnYh5q7Er1Rs1TMtzUwxtOdFQr3b9RgjFwc2xHyzi42BFR6n9
         gNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60je+LDflCDSpm+PbhIAk73PJa9MombVHWRyiPaaQWE=;
        b=QJJ6UWxP7P0pVmHc1ApCuOf2PlSIMfaujPanrFlF4IL5AB5xL1laek00TNEor+Ym/3
         e9HW8d9yYasm1DFRgia/z+xchYMWs2xlGCrLPgp95SwrLAcWMXhj8sflCCjjpUPEmQAs
         oThMtRjnZv6MNsMioHY/A+FkX5nimAHHDqG3+3cqxrfGqeCnlnL8e5BM0l5fma1x5uSG
         8sr9WevF2LymNSHnWDK7SoUW1sD4q5aMGX/CwdQshMVOBIvrAUuFBE1N/+Xp0k0ptODI
         KgCsHdk+veNnEXDcyQQkybwEetGfONQ6ekPazlckhvCdCjzgexSBD82ZPeOJn86+JaZB
         SfWg==
X-Gm-Message-State: AOAM531Q3bXFyYdOaxtXJwAu3S74YX+T4x/oqrU0vpGm+T7Vt8A5KXrA
        lRsHwi7+LnjQigVpQB/Gp7epuA==
X-Google-Smtp-Source: ABdhPJw2CvIZhbOZesk0K8UFjnLQEilUX3nZUgdGlXHhsBE7dcCrIv0HEoXsjAU9yOpKWKGqMGDuVw==
X-Received: by 2002:a05:6402:51d3:b0:416:7503:f2e5 with SMTP id r19-20020a05640251d300b004167503f2e5mr1322404edd.51.1646859638611;
        Wed, 09 Mar 2022 13:00:38 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709061c5a00b006da815e14e2sm1114743ejg.37.2022.03.09.13.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:00:38 -0800 (PST)
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
Subject: [PATCH v11 9/9] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc
Date:   Wed,  9 Mar 2022 21:00:14 +0000
Message-Id: <20220309210014.352267-10-caleb.connolly@linaro.org>
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

