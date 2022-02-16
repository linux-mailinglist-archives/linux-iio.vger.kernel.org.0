Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C3F4B8AC3
	for <lists+linux-iio@lfdr.de>; Wed, 16 Feb 2022 14:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiBPNuR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Feb 2022 08:50:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiBPNuQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Feb 2022 08:50:16 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7532B2AB53F
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 05:49:52 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id h18so4013255edb.7
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 05:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=uYIZEc4lff6sxG9RjTKdqoiy9gva1Z/adRs/AQDDqymMZcDw2w/N2xj4kikbdVhr4V
         BEGXeTPGAblbgF7Zmeu15nndRAXkkf2xEYSyzFSJzXN8yxavwamSqgRwO0hoGsfuoyGS
         WNcbi20kb6Ezovq2cAAP32aWpL69krcdQIYUz8crMvmsifEuMTHp+we1zu3xUI1CnSds
         hNCah2FaqztK5C7KLayp9OQ7FS72pI1nJhPazOnzljhOBl6IoFyx7Sx6vn226jWysfPf
         ZdS23GM7Ik/G2BRIJ6J6JFfDfdHlt/aCnczj4gXyTtDUdq0TjN1LitTdXNDRN4h+/bZl
         S9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=R6aBR1UWwcwf9ZllwfC30ThCZcbky/40mrsAKxAqFvdeOOmkSGsXP4wmBoKmpgvSc4
         8Nc6mXyiqaLlQZIqibTYW8jLRKtMcZjBDsQx0512nRbxrIKYNKThBDFzQLX77at2UJm4
         3KMijiw+AxgACSRcFnadv2tERKj3yftyY0rxzt7jFyNduYY+Oee81MgKUOZf83cIuaIC
         8YDv1ypfTWQVBsQo8Iq5t35VoJeo5zJYwWrigDAulOtziX23UZNbzRlKHuuVNMNbfL1C
         DzK4w4eUMvXIhBtqTJ0YhHnTBmEAZD5hLInzB0iO52zOJhlzhmWBnVAwyraumxBJeRL2
         Z7kA==
X-Gm-Message-State: AOAM532W19RSnQkLdWvYBz86N9INsTKC6erMQtvGpmDtiW9U11pZEtxB
        ToE9EDyEf48vHCUPq59l6Q5/aQ==
X-Google-Smtp-Source: ABdhPJyOPnUoMWzdS9y/Yl5y47WQRLKakmJvGAxc1m40TTCfjeaddTUS71BL0pBRL/oiYjXJS9Q0cg==
X-Received: by 2002:a05:6402:144b:b0:410:b990:a68a with SMTP id d11-20020a056402144b00b00410b990a68amr3076594edx.25.1645019391054;
        Wed, 16 Feb 2022 05:49:51 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id o20sm1711996edc.84.2022.02.16.05.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:49:50 -0800 (PST)
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
Subject: [PATCH v7 8/9] arm64: dts: qcom: sdm845-db845c: enable rradc
Date:   Wed, 16 Feb 2022 13:49:19 +0000
Message-Id: <20220216134920.239989-9-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216134920.239989-1-caleb.connolly@linaro.org>
References: <20220216134920.239989-1-caleb.connolly@linaro.org>
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

Enable the Round Robin ADC for the db845c.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 13f80a0b6faa..1c452b458121 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -595,6 +595,10 @@ resin {
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
2.35.1

