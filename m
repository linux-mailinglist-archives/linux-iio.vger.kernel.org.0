Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CF74DB323
	for <lists+linux-iio@lfdr.de>; Wed, 16 Mar 2022 15:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244292AbiCPOZp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Mar 2022 10:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358069AbiCPOZM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Mar 2022 10:25:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF61E2A737
        for <linux-iio@vger.kernel.org>; Wed, 16 Mar 2022 07:23:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id d10so4501477eje.10
        for <linux-iio@vger.kernel.org>; Wed, 16 Mar 2022 07:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60je+LDflCDSpm+PbhIAk73PJa9MombVHWRyiPaaQWE=;
        b=oNMzzvPvDHW2uRJHt3qIdpSZgAeuwLDFE+x5tjM7lmMQ4jHjKKNIGzWBC4+FQzJmN5
         BrlhZPMo+Xus6o1vmKpbqj61itrBjnUGP6oNoU9ojY9VpbcHx0WsjDfd060bG8FRCL/2
         DIztpPRLDmON/yew7TratkzmeI6aPwE+CauzZDxrlC3psiOE8J/ez5kQLpm1yo2Ir8Si
         ZFntmScxnH+ECOfD5FIfsvki8GWUJA6xEvrwQiDkVWWQtnSi0xD2hFVW+JKUfj58yGsz
         Hg4lsSUAjGMG7FmBo6LeD22AmhIulr+XrQN4hchBsLkTaaXu895KNYCGeRdtr81Ok4TV
         MPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60je+LDflCDSpm+PbhIAk73PJa9MombVHWRyiPaaQWE=;
        b=2ioRaTINnAjsR2qLTn0ry/GG5xa60PcnZRmPOiFeooBNMgS+a9IfEAkpPoFscm2SZA
         aieBge+eRRum1FuT+5/1gZ5Lg6Y0uTYVfoTc8LeljbTsKQvlfHTaq+MNKAQJ9200QrkO
         YXvvqCPCQu9VX2HULeQXizgw9Sndt10/9mwMH+HrSeUQ1LPftqklGl5DzGHhlPZzxn/7
         EyAA4TSTjIHo2ToA7KvGE+sa/3TkrZcxRp3QxRFKf4i2CyTX3WsSNA9vPStQVl/xCyNp
         +8UV5WGgvXVTXA/1LlhpnF6wkgCrDhUE3F7Ubutt1q54VDoPKkISM0QXpt1LfRncHNw7
         WDfw==
X-Gm-Message-State: AOAM5306nbgJhTRJZTD5uif+4S0HvdcRKlMyepZhf2QfYyZGJszWaisL
        pM59LfdIdrhb2ycdSLqYDT987A==
X-Google-Smtp-Source: ABdhPJwWsZsQ3dkab910lILVMYqGsWWDH0/cbWpRqjaFCC9K1Bfwl/1y/TmXOcMyKAdlTUVTENgumA==
X-Received: by 2002:a17:907:7d93:b0:6da:8f57:68fa with SMTP id oz19-20020a1709077d9300b006da8f5768famr246070ejc.42.1647440635393;
        Wed, 16 Mar 2022 07:23:55 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm952263ejc.42.2022.03.16.07.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 07:23:54 -0700 (PDT)
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
Subject: [PATCH v12 9/9] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc
Date:   Wed, 16 Mar 2022 14:23:13 +0000
Message-Id: <20220316142313.92371-10-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316142313.92371-1-caleb.connolly@linaro.org>
References: <20220316142313.92371-1-caleb.connolly@linaro.org>
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

