Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB5F4D3B97
	for <lists+linux-iio@lfdr.de>; Wed,  9 Mar 2022 22:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbiCIVBi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Mar 2022 16:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiCIVBh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2022 16:01:37 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF44A3C9
        for <linux-iio@vger.kernel.org>; Wed,  9 Mar 2022 13:00:36 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id r13so7820023ejd.5
        for <linux-iio@vger.kernel.org>; Wed, 09 Mar 2022 13:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zozG4Oy5Pt0vWjsRDZ91928+qvWs4STBKU9M4pGg1h4=;
        b=hiaFscqfNthX5u8u5hIP2J6nGbojCaeIDru25jt2Jos0I26L1g1B9OXWMTb2HwD/AT
         qrwv4w8jz58HpATMm+50WRlKf7gGyRogIho7CYM+odqwxdUpYRCeOK5MEBNADz5OBO0t
         mE5kTXqs1I5MWRsK815CvlSVqLyZzNxnv3Y0gRusO1lyhMWuIPhhhIj1EzAipKLCOZ7u
         3fljIXOihAUESa2nKXcauzX1T9SNNd5YOw9WsScX5CQMe3c5oIgrxPmhd9QZHjx/3A8X
         GQXCQSOIbthfgYELN3pgnhx5WPS+WjXx3AIbEalU2ELkpRCOHYAfGfG0tTz1xJAAX9qZ
         74GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zozG4Oy5Pt0vWjsRDZ91928+qvWs4STBKU9M4pGg1h4=;
        b=0hqfJfHWU387yFQDSy2udqu2tO3Aas7aN8mLEv50KPOHHRS3CBDjIx1llkY7LAdVJY
         cYkFSgHJYPeu01QVb+HwEuwIBpsMqJ6HE7NzNuYvTjzUEMrK6PDU2fglzxquibpVqu7p
         CgAnV/VVovHxIrX9V9spWAmbj1ayiP89I7R40Iu1U4oDRgRWtMPJ4J9VOojG4WcDl8R/
         ZLbFER/Ak7fq7HbYof/k1cG0yMI/hgplks7GT11C/0v6b2h+9AigIriqe8Di+GL50YAf
         8fE3kfxsoFvtecRoGPeqUINj0JDP/+nGoaWWJLq9L4SbP0FFxnB58ulK+w0tEDZ6zD3E
         5LLA==
X-Gm-Message-State: AOAM531GUjY6OmhSfPt+SvCotfRSUQC2RVF2UO29uZbQJVJS+CZgyBW7
        ngowIGf2qPbCWGmxVlztgr95bQ==
X-Google-Smtp-Source: ABdhPJyYvcg4GbQsjDdgi3vP0gS33LBUjVeZzJW5ufYkEkS/C5awFHN9ageJk+p8FCPIApMr3MzySw==
X-Received: by 2002:a17:906:a210:b0:6d5:9fa:11ce with SMTP id r16-20020a170906a21000b006d509fa11cemr1617726ejy.172.1646859635190;
        Wed, 09 Mar 2022 13:00:35 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709061c5a00b006da815e14e2sm1114743ejg.37.2022.03.09.13.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:00:34 -0800 (PST)
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
Subject: [PATCH v11 6/9] arm64: dts: qcom: pmi8998: add rradc node
Date:   Wed,  9 Mar 2022 21:00:11 +0000
Message-Id: <20220309210014.352267-7-caleb.connolly@linaro.org>
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

Add a DT node for the Round Robin ADC found in the PMI8998 PMIC.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index 0fef5f113f05..da10668c361d 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -18,6 +18,14 @@ pmi8998_gpio: gpios@c000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pmi8998_rradc: rradc@4500 {
+			compatible = "qcom,pmi8998-rradc";
+			reg = <0x4500>;
+			#io-channel-cells = <1>;
+
+			status = "disabled";
+		};
 	};
 
 	pmi8998_lsid1: pmic@3 {
-- 
2.35.1

