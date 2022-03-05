Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814A54CE226
	for <lists+linux-iio@lfdr.de>; Sat,  5 Mar 2022 03:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiCECOA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Mar 2022 21:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiCECN6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Mar 2022 21:13:58 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674391C8852
        for <linux-iio@vger.kernel.org>; Fri,  4 Mar 2022 18:13:09 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 19so5734810wmy.3
        for <linux-iio@vger.kernel.org>; Fri, 04 Mar 2022 18:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=oTlV0iNlHqaGC2VFPFqInEY5gDuzfrfhklHFGgpfQ88/ZgDTBesbLDynLkeJN3sgjz
         ERBQQAgP3qFPrXAmWswuUPZMtW7iZZdAUWaVTiXH/5w5qe+Fx6m+25Zia0TmHR3HbbQL
         DIxyMzWvuWd3Oxjzob6+tQMkDoSq+1sYBXGXl4jlOpMZm7H4qpyGQYWDxVt1VnJXCQe4
         0guiLkqHaEOxV1rhq7R8L9j28+EnPMeXmhV/5v33jIIFwwbPe6PN6I7nfhr3ccKiXqay
         FhShJkYggyVnVrJ64exIL14Tvj+eXrJp1Fp1bE82xKDIBzoCF8YThUjBSl3Iu8wvstTh
         exVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=z/A1rs/iYOfDtmSFEe0quaYNk0RE0pWsVxknp2KrMowowUhmT8CWKIOo8YM/R1hVMl
         KQ7ecK9XvBVxxfQto8GFsf1AKmA831CB2OdNdm/RRJf+pp2nZ0eqX2I7mGHTynbqYJGa
         FteSLn/7Lbk6TtcU2oZO5i39yU6BB9NbnewNj5HT2iz4g6+hAKrqz+cSoSvjwIXZqaJ2
         LswcM9UdcFKt2hjhOjrc0fGl/yM0v6f+7m0x5QgDadjRLfvJG6LEV3QyF/E+WqoYiIvQ
         jz5LHVQ6BMZXs1GwO2dgy43TY7KHVEizRwutIS35mn408zMXnPJ35oJThGYg9CoYFMa3
         A4pw==
X-Gm-Message-State: AOAM531/kWaUEnDm+d1s2Rjr6SmpeMKPZhvsEf5JU3cx596hlv2dV7yi
        WG66O3EHTbHIP8BzRVse8miqxw==
X-Google-Smtp-Source: ABdhPJwe8kJNmHKlUsT0cxlKhTdi2UvNRBLK686PoLR+14ZU7F4vYDY//SuZp+xnYzjlQuIY5G+zQQ==
X-Received: by 2002:a05:600c:2101:b0:381:2275:1d71 with SMTP id u1-20020a05600c210100b0038122751d71mr9580186wml.90.1646446388014;
        Fri, 04 Mar 2022 18:13:08 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id k10-20020adfe3ca000000b001f0329ba94csm7932589wrm.18.2022.03.04.18.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 18:13:07 -0800 (PST)
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
Subject: [PATCH v10 8/9] arm64: dts: qcom: sdm845-db845c: enable rradc
Date:   Sat,  5 Mar 2022 02:12:46 +0000
Message-Id: <20220305021247.1020122-9-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305021247.1020122-1-caleb.connolly@linaro.org>
References: <20220305021247.1020122-1-caleb.connolly@linaro.org>
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

