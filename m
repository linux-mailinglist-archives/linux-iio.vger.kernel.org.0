Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8DE4BECF9
	for <lists+linux-iio@lfdr.de>; Mon, 21 Feb 2022 23:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiBUWIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Feb 2022 17:08:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiBUWI3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2022 17:08:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3FE22BDD
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 14:08:04 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o24so29377752wro.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 14:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zozG4Oy5Pt0vWjsRDZ91928+qvWs4STBKU9M4pGg1h4=;
        b=q/RFWKpEMo4qOlDj2TrTaK3CqFw+/dYPX/SKR9vqhsLXehYTh+plZUaqPaFmOZ3pIH
         QJhVTeWzPnIqlVuir/olF4EgjrZ1uoaOc/u7GDssBR/uGI58rQy3sKZtbaynZ/lp8pSX
         LbmJ8fw9vkM3Ug2ZxBVymq8PvjSuRhKkRaOGGLdslmz11cZkkhHnotu8pgZo/o3QoxwP
         yl3tCjcnBJ1jZhBHiYTZqTilpxqzo0VhHFAMsvd/aBcQsxaHgcod7h+kfbOUseU7zHZV
         bRjjNNzrAIPcJKalHrVFkb/cmjJLqKeCGhmEN70jT5ABooQ3UaZmM+kBNc9/Kug+GAgr
         vmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zozG4Oy5Pt0vWjsRDZ91928+qvWs4STBKU9M4pGg1h4=;
        b=tDsPdTYxQGZMjnfvUxX+I1rY+umpYRrnvL/VcvvTCw2+peh5n8SKbD5iBGhdFfj8wZ
         yem7RcZIUrzeaslu6eLkSDgZjdgXYZIHoK7/UhuHiCA+vCDEmfjpextTeew5vl12LkIl
         dkA6OK+aAS2Ak479fTfRQvPm+ADlwLJspdIqdJwzHz2+MICJCN0voKoo9wYHJapOOb0z
         ix5Z2iuREneY8Aif5o33zPryuKUetg8U8iKQ2hcpv0+Erjw5ZyPBCyltgv8n7pkfSExx
         Zjyeui/t3uZZWwkzanQ/mG9KRKg0VSZsLcT5P6zgQrJ219hoV9G56ik13c4d9g26VGmD
         XTHA==
X-Gm-Message-State: AOAM532UuZjfQIFnRE1u0hwDa3g2Y1UV9IV4ZgKV6NzbP3QzDq8zP0ZY
        ei9j6jDrh5m2xF1fBOv2asCfyw==
X-Google-Smtp-Source: ABdhPJyK9n9XH2SxUzlXtF5IRK1v3XwLYrAJR4CGhkKl0Wyq/KVtq75s3wsRJlS8JkJI0A6f1+132Q==
X-Received: by 2002:a05:6000:15c4:b0:1ea:7fec:3d84 with SMTP id y4-20020a05600015c400b001ea7fec3d84mr1383906wry.33.1645481283488;
        Mon, 21 Feb 2022 14:08:03 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id w8sm51626093wre.83.2022.02.21.14.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 14:08:02 -0800 (PST)
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
Subject: [PATCH v8 6/9] arm64: dts: qcom: pmi8998: add rradc node
Date:   Mon, 21 Feb 2022 22:07:40 +0000
Message-Id: <20220221220743.541704-7-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221220743.541704-1-caleb.connolly@linaro.org>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
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

