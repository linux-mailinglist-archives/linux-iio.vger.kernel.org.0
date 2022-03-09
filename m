Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522F44D3B9A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Mar 2022 22:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbiCIVBj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Mar 2022 16:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbiCIVBi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2022 16:01:38 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1050F6E8E5
        for <linux-iio@vger.kernel.org>; Wed,  9 Mar 2022 13:00:38 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y22so4480784eds.2
        for <linux-iio@vger.kernel.org>; Wed, 09 Mar 2022 13:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qImSYxU2i/y/qV71r8EFW+LTWk9ZfhM4KeM2jcTcklQ=;
        b=PPQeOTn8mY8q0qfltNdi3YFQMcws1wVNpfmUm7e9iR6Y5Ft1uowkXpRaOgOEbXvM50
         YZiJgU5/W4YM8Q4WTnmdLV4HDiUhXry11f2Bzu1STHXIQAnfQrI15QHBvtHSuEIK1Fbv
         OGzgEZ6/0QtqU11MGKx11BsqH30pLMlBWVjokZP66lktWndl/+cqkiC2duUWGUdmoivu
         qxAilSVADgMkJQ2uXWeYXpC/unABu8HJ9Up5PXaylrDpq7XRAqYAcMnaaOKw5sZTSAe7
         e9Wpun06qT56SHuKlG31ZRFoU5CCEdyH51Tz3ORrPtFgx5usUeYQapgGXooVT8/p2NqE
         1qwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qImSYxU2i/y/qV71r8EFW+LTWk9ZfhM4KeM2jcTcklQ=;
        b=eV1nsmEu0V6I41Xv/jKWHIelbuavPmI3eicFEvloV/ME3KnNoaUXJQFVmloYDE9mpj
         390ARjMxfE6A65YxJ1knsoTWXRoT2xdg0dHNuWEW8CYsL1nE1nVTBKXDUF1gHZrxkaWD
         KJ/jdkGeMU3Ii8GybjDmK5veniC+NZtI8EcxZFEA4eu19bg3VBZoc5m5OL2Q4rB4cKJy
         bWsCl2UB2ht5/t9nnIWP8o2FjxxdLwArf3MXwC4f87a13JeXRpNkx6nCXLRu+xOZqeI4
         AY2QzpTmYKA+YTRepG73vXejM7YISrZTmUad3lOGpIsxTcjFVbArNYOOI0R+IlPBWb21
         WaAA==
X-Gm-Message-State: AOAM530Jj/x6vM5IAPBZcJ8P8927kiHdcWO54EYyLEsBTGzllgU6Sw1F
        R2xR31hUippgvw6RxAiAmc9FHw==
X-Google-Smtp-Source: ABdhPJxG7B4cEh19Cjd3RMEByu4nKsw3JVfcN0Z7/ViHtSMzkOUqg4+63VNcvNGtjvP/SMqse6QMqw==
X-Received: by 2002:a05:6402:268c:b0:411:e086:b7d1 with SMTP id w12-20020a056402268c00b00411e086b7d1mr1309625edd.111.1646859636468;
        Wed, 09 Mar 2022 13:00:36 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709061c5a00b006da815e14e2sm1114743ejg.37.2022.03.09.13.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:00:35 -0800 (PST)
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
Subject: [PATCH v11 7/9] arm64: dts: qcom: sdm845-oneplus: enable rradc
Date:   Wed,  9 Mar 2022 21:00:12 +0000
Message-Id: <20220309210014.352267-8-caleb.connolly@linaro.org>
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

