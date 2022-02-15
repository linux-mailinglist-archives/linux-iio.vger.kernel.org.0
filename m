Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3314B7883
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242015AbiBOQzk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 11:55:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242001AbiBOQzh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 11:55:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD1C119F60
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:21 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so1380971wmb.1
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qImSYxU2i/y/qV71r8EFW+LTWk9ZfhM4KeM2jcTcklQ=;
        b=QyN+krO1vGGqYNynGXD3QnwvYk1OZeN+h1hNRMTQ8THbgMDDvcH4tQdr0YLlcCNtDH
         LzQHiO4OYw+jkBfuOGZXHTXciZnpJb2X4aESenzid82VRqC5Lwuk4Ob68bJrF1nutx5w
         Uwjko4VF6yPfsbId2SLAUqN8JVUAcMqN55TQem5u57uVEccWbF7nzmZodKr+WRylsty9
         yoN3paZVAXADEtZEz51uL+PidUMi5J+2OSukZ+8t7PNHzgJXgTFCmU85CTfU1o05biAd
         LhytQ9G6HVWbubuNlXogb4Gsc+6BaMlVP3mAA2AWmEQraBsWwWydSsbRgjMcH6S1abRx
         ccgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qImSYxU2i/y/qV71r8EFW+LTWk9ZfhM4KeM2jcTcklQ=;
        b=GNkvmuvMfQIY3S4gMZclkziVn5Cr703IJtbX3LSo7Wdffi/wJNUeWTkEcQdvsUpprM
         Ld8CPCBBe1sSktsqiHZxOyfysb3xZtB03562BVwQvF6QHxB3lTTc7kMIeL6zb1HfeSEE
         g6wkrbk3yZBynelVC7SiSPoWTBl0EUE7UCqZ7JnSwiJw4coeQ8FEqE6KAkrgp/frprCJ
         LwSR+hYrBH+JEawPv3N2MZNTH5oHPQ2Z0KZdiodIvna9H7TmsuV6P+MvZ0ruSTSVVsI9
         1bgb82+1RXGujpWMwf5oO26vomZbedzGD5rYdfNCNOhiVyOmqZgc+PpGR8siVtc2fKZA
         FvKg==
X-Gm-Message-State: AOAM532rJI+zgWfLWGUCqyHuCXfOFVMUHODdy7zQ3YjToOjTMI+/Hluw
        mcg5HvJi0NOIoA6+IgOyvzICSQ==
X-Google-Smtp-Source: ABdhPJwmAJpol9TqUBgbmkJr4kKdjSEONwdF/OUGTfIPNB61y78v4fFccx9LHfBaPh2jDixkBlSFKg==
X-Received: by 2002:a05:600c:21ce:b0:37c:526:4793 with SMTP id x14-20020a05600c21ce00b0037c05264793mr3869705wmj.120.1644944120566;
        Tue, 15 Feb 2022 08:55:20 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id f14sm15373652wmq.3.2022.02.15.08.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:55:20 -0800 (PST)
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
Subject: [PATCH v5 7/9] arm64: dts: qcom: sdm845-oneplus: enable rradc
Date:   Tue, 15 Feb 2022 16:54:54 +0000
Message-Id: <20220215165456.1205583-8-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215165456.1205583-1-caleb.connolly@linaro.org>
References: <20220215165456.1205583-1-caleb.connolly@linaro.org>
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

