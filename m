Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921B94CB5C1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Mar 2022 05:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiCCECJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Mar 2022 23:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiCCECG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2022 23:02:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D776715D3B7
        for <linux-iio@vger.kernel.org>; Wed,  2 Mar 2022 20:01:19 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m6so5769977wrr.10
        for <linux-iio@vger.kernel.org>; Wed, 02 Mar 2022 20:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=VkutF0q0fOnvXI7kbebPEJC4CziHOovcJmxBUQDSOVoNT/TQpj2XLeeHdgFseQO4gT
         V+ZBcG7BNHaNE7EE473b5Vp+u+glVexg3UxEyqCHhapjJs87e/Bjh+6j/osdvZbceI0I
         1cVc8hICTRqkHpIo3V14UoGhCXwTIZWqH4bgEUO62RjpcIZ0pzZPrM39dyolDcf/6wgQ
         PHt7kqHVSPRwEiVcIq8BuUxXf2lR/S+LENwFt5gwKAepOKd+QT6qX7h73N8YavjOXTrN
         HXMwrnwf7L6HHaSmJQjiNwSGwm9utzUiBhrsNMAgWUqr6pGIIJm4oop2heszD+Na9wku
         ykXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=Ldx6uMJN+kfFwh3cG8eYZJDQLGvorJ282Iy9eUVt3S08BvUFIAIDnyIk4schItN4va
         RYBxN7MOIk+z9sJmyTD3BGUIrdsMdbU03Ad+9zRFSLsG6mVDiV3tNzUKkLFRSYmYf8+m
         OxnFYloeUa7zlGiUnPhPlJV8hKXb0C4HvZ7I19gjXcU6qTrxD+JwQhzN1hlPDczWVLHa
         r6dE6G7Drcsv5/9EIW4PwcoRSvVZ9abGaQ4iqLk1l0sQSHeIHjMP95lP0V39KLbYyY/o
         zfdWZDuVVgv9Q8AxkDzs9Xib7ZS7zSkyyx1OZbog7UNiCHP3i4CX/LJwoMUm2O8bOVb0
         3GEw==
X-Gm-Message-State: AOAM533PJt/IVHQwMAXL6V5Wgs1A7F/G5xrEwf2Gg5b8k1+6mMjjYNrP
        UB7yBc05cpnzjQtaWDTAOdJGQW+eRE0MUA==
X-Google-Smtp-Source: ABdhPJy6mifwCkcMePMaf4iKws53ggzWv0YohWJmH42BDUO2HCS7i7n9m2ZCK2UdLIPY32DaKBfq2Q==
X-Received: by 2002:adf:ef4d:0:b0:1ed:c131:8b4d with SMTP id c13-20020adfef4d000000b001edc1318b4dmr24635672wrp.102.1646280078486;
        Wed, 02 Mar 2022 20:01:18 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id r16-20020a5d4e50000000b001f0075f4ca1sm702615wrt.105.2022.03.02.20.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:01:18 -0800 (PST)
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
Subject: [PATCH v9 8/9] arm64: dts: qcom: sdm845-db845c: enable rradc
Date:   Thu,  3 Mar 2022 04:00:34 +0000
Message-Id: <20220303040035.1454103-9-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303040035.1454103-1-caleb.connolly@linaro.org>
References: <20220303040035.1454103-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

