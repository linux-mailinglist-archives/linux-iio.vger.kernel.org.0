Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7024B77C2
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbiBOQzk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 11:55:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242018AbiBOQzh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 11:55:37 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF63D119F7D
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k41so10541344wms.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=V4/Sf/pWyJIfM4oBWOZsm4m/eUsUJ9ON7zBnf+QEEYKKVRfdJdLomZ95EVeEHC9rKH
         exN9uxhMeCEOQdqeswq5QjfErDB6zhhQbP98GUUvnRDgxVhNE2xv7n6xdGaSedrvFZfO
         OiK+kWOFU2DbrnfUwdd6V+01leWY0FmOWMc/WJSfnoPJlEcSTuSV/wVltIYndzzWJ9J8
         BQVhhSsEMJ2nvQfW97tb9Szy8hkA4GA/2TVxxPEl1RrxFBB3c94uexORmpvWzX8txL7V
         D4fk1yhaVFVPg6xzCrWoOMQasMTy/6C5HXDDY9aXBIih4LK1coOYpLjIB0v0ZYpL98y2
         YwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=fgqlDlrIOmRj+VnvtMcZGfqTA+ehHcRl/DpOXdczr8pbGb6P+du1VaebgbU1ORllg+
         oY4IrQoc8558tRhlDGoqDjjn563c99GbUH5iD9BzQgSry2XJ3AlYOkszh8MM7in3dufy
         zsUQz1bejFgtvxKDz2msdf0eUbIKacyptEIK6pwM3nvxoqY6eXk6t2kBHqO5vyIJxNPC
         O3HBL+l/MsQ+Auemm8rxUKVIY/jqOS7naZbaOsbE4uGrE1EKarIgYH6ElKAVrNg9qNPV
         GsN7Sn12MaphMBM4mlz9ImOJNmGCHmsO3IkoiegZ2m/hvvqbc9jhN7yZQitnkXeVn8cf
         v36g==
X-Gm-Message-State: AOAM530zBUuPeBzcC58M+KkMvAvaUFhNytP9yTTR/UZEFfwLp6VLMsiY
        xNb9TRhP+4AgKxBiA2WNKCiONw==
X-Google-Smtp-Source: ABdhPJxTp1UnFsjcJVJIQaOFRqD6U8WXXFFrNNaozdVmj5KC8ett1BIy80cHIkSF16+0UtodW+I4AA==
X-Received: by 2002:a05:600c:1e8e:b0:37b:e97a:d4c8 with SMTP id be14-20020a05600c1e8e00b0037be97ad4c8mr3755611wmb.189.1644944121598;
        Tue, 15 Feb 2022 08:55:21 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id f14sm15373652wmq.3.2022.02.15.08.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:55:21 -0800 (PST)
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
Subject: [PATCH v5 8/9] arm64: dts: qcom: sdm845-db845c: enable rradc
Date:   Tue, 15 Feb 2022 16:54:55 +0000
Message-Id: <20220215165456.1205583-9-caleb.connolly@linaro.org>
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

