Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093CA4B75DD
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbiBORK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 12:10:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242262AbiBORK1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 12:10:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4E11B30C
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:13 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e3so33340607wra.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zozG4Oy5Pt0vWjsRDZ91928+qvWs4STBKU9M4pGg1h4=;
        b=lVkTvMgQPsqrJCQtPPDXQgcW7K3t9DbrRxmJ/F5mRenChxSDfpn3bKxniuWfoN2oMY
         efTmYjV6Tu8RJIx0R0Uun9KHBm2olY1sucGxQBiP5tgEwSw/7tDUjhG5/NVesjZrWKtY
         fP4Ib0XFMCb4vzT0kJDg2qBrWADb5wVzsQuhih78HEHLIskceLy5loNvyOPaQDy3Adok
         AGsVVBWiXFrR9K3XPMuuKGYNIKgEdNZP06jcRdke0fmZ6YvK3jDr/rG0NZYmj2FONAUO
         2+uXzQW65jKUmAoCA5fgs963dg+rpG9pZkTIu5i0C5hHrUsBNhtLusl/QxiSxLAwemi4
         l8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zozG4Oy5Pt0vWjsRDZ91928+qvWs4STBKU9M4pGg1h4=;
        b=yZw519KGNFz7kbUyhQwadpoUu/E3m3eBswvPJwdbJXKzBJPJat2EctNbn9SspqacEe
         nk3VwQcnNrj9YXwc5x3pyi/9QZEtkFzVmDVpzP0oQd19rRspktJNNuQJffyZXufeVjWj
         J7axdAi8I0IdrmicqIwSFWpvBMpkVDS8Mdg0DR5zLnltBdb5KzLA3uQkypWA9/Ol3lK1
         C+M9fs8Vnyfd54fqF+UZnYE7cLMb+INt3EFmq/1H/L0El4tCIdQFVYpxBy/hqPwAhyqP
         Nhgmuxws/4MiA3Rtascd+cOeE627baWSnxE+20Hz1ThKieG+EPOibkgjARGAbRA9l4VM
         Kmgg==
X-Gm-Message-State: AOAM5305FtJQB/TkYkT4+RL3CoBwBBggvR0uXEEY1szjxf+/Spq8K8qZ
        wLbRikcgNlEXvWAshf+DzlnWJw==
X-Google-Smtp-Source: ABdhPJxHrs5s8N8cASBSzyUzu7uLEQCyXvBgddCkQVMrpi8/yirWAcTxyq7P2uKqn3G0Sl1rot2RhA==
X-Received: by 2002:a5d:5589:: with SMTP id i9mr4302986wrv.389.1644945011998;
        Tue, 15 Feb 2022 09:10:11 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id g5sm15558474wmk.38.2022.02.15.09.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 09:10:11 -0800 (PST)
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
Subject: [PATCH v6 6/9] arm64: dts: qcom: pmi8998: add rradc node
Date:   Tue, 15 Feb 2022 17:09:48 +0000
Message-Id: <20220215170951.1233375-7-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215170951.1233375-1-caleb.connolly@linaro.org>
References: <20220215170951.1233375-1-caleb.connolly@linaro.org>
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

