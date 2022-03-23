Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFBD4E566E
	for <lists+linux-iio@lfdr.de>; Wed, 23 Mar 2022 17:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245475AbiCWQaR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Mar 2022 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245490AbiCWQaP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2022 12:30:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A526AC2
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 09:28:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b24so2470987edu.10
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6sZ9TrpMbSuqw2lSukP8mYcJ/MBczjmWfHRwtht0/k=;
        b=KTMMAKFdqzkMrR4PM5BD8W6BjPPR+FxT6cJH2XjB0aZrO1rYfJyhQXQa66UteJBC9c
         CW+/I1B8J9Qgc24TuWXzCAbptqJIzZSeZ5I/d5Dqxgw1p+qy9JpE2XA4+D3Yh4K4baQs
         KnPUwHBbS2vVT2G1y6OSVcqrgHYiKzbX8n7EZE/s3welCPfcU2hHv13D7f8tmEe023kF
         i5uV7IFVOGWUpZRhE5xNuOFuuP7fPcvFKXpwIryU548uDkEfakkGxp0SqZDX3tHnAM+E
         BtweXKBn+mBcOY1Mpf62GDyo0Ou7CQsECPvsZOM+cj+Y+OJ4Uf25Go3oL2ZX1ahm5OgA
         6rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6sZ9TrpMbSuqw2lSukP8mYcJ/MBczjmWfHRwtht0/k=;
        b=nK92jwBA0UGEQitDemsZCULDGcr8q1OS5HW4xq9OAx4i8KJG/2VpfCCV+vHYWO/jhF
         OhVOnJ8C4/+LJUzVpPVmra46u/B/CHEjxF7agwwtHd9padLQTYKKvoE2StPhnX2VkNxW
         ivmo2X9Ztdoaq32EfuHOsBM2xAhPqD9FL1pB/gYKPx3HHZFncrQGMrn0LVMOOvn3sQdC
         DW01WDV1oqplMtlROIIezfYNcvre0VduBhObW19zDqSVXB/K+GWGWCz3IXUS0zZh/sPf
         QmJpjhYm5dQdw/gYWxhcTtETzoH7NHMpNTfqMeale+HMdqVb90yDNOKTsA1wgit8LSch
         /WpQ==
X-Gm-Message-State: AOAM533h4O7PuoTtoyRiU1AA68Q8hS4PXPxPCddxikrLwlb97bxNkaVf
        vN/ShmeaCm65PMtmdTiL19mKHQ==
X-Google-Smtp-Source: ABdhPJzIIhcR01QY6OTpji/DDtEmb+IsLv7EGx8u37LtKNAXeQLlYXkNAvDaIdZ5lDXuHULQX2w0lw==
X-Received: by 2002:a05:6402:3495:b0:419:1ff6:95d9 with SMTP id v21-20020a056402349500b004191ff695d9mr1112414edc.249.1648052923158;
        Wed, 23 Mar 2022 09:28:43 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm173306edm.90.2022.03.23.09.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:28:42 -0700 (PDT)
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
Subject: [PATCH v13 7/9] arm64: dts: qcom: sdm845-oneplus: enable rradc
Date:   Wed, 23 Mar 2022 16:28:18 +0000
Message-Id: <20220323162820.110806-8-caleb@connolly.tech>
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

