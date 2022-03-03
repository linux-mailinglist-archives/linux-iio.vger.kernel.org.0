Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF91B4CB5BF
	for <lists+linux-iio@lfdr.de>; Thu,  3 Mar 2022 05:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiCCECJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Mar 2022 23:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiCCECG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2022 23:02:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1599A15D3B3
        for <linux-iio@vger.kernel.org>; Wed,  2 Mar 2022 20:01:19 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u10so4155183wra.9
        for <linux-iio@vger.kernel.org>; Wed, 02 Mar 2022 20:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qImSYxU2i/y/qV71r8EFW+LTWk9ZfhM4KeM2jcTcklQ=;
        b=Yh1eogp3N1ugymSzZK9htzlenKX8GfJBQ9WV7MDTL5SUK10yARpdHoeVUgk6PpVSGD
         itB9HWNjMmE0UIyS25ruimsyNA5jLEt8KXRLcvsQXq0h1mKctbuvbzc/OXeFNo1t/YEs
         uhTYrVsfcSMrd6uUo8U5xp4aSNEPiggU/1k1+pk+iKBsADEiG17Fb9/8U0TALT1Fai0p
         CxSbYiSBHt7aMncd5hmNum8la3++zH4xlz8vZCCgwB5DTRVWA1kMDrb8UEBzgAkahZwq
         iO0cv7c9ugGQD54Rl9s5/ZXBCaqfP8h8cQvE5tWrmNf01dIQnazyd6icRNP1T6LrfeRn
         CMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qImSYxU2i/y/qV71r8EFW+LTWk9ZfhM4KeM2jcTcklQ=;
        b=ftxpiMuor8Odv30Qk21kjcbilsS+3TW9DjzPvvmlrBT+7DK1RePGjoK2VepKUNvGxl
         OaJYtA6jWwyfWLSCi4Ge7foifBqqeWOsseJ2TVNRXgVkt4TTb0Z6kwNdAfyoeAW89+qZ
         RIzSxwivYV42ngumMewX5gmI9K8oVlCX2JzopQEWxE1XqKu4B+JLoYJSm7TJlMB/964Z
         6z+njI0vHdAu9eY1PrnxgP50j+xi3/LMNqppF8hQJ2QcssQeGgq/y83MRTzU0Lvlk4Q9
         fKD6uczkpoZZFEuHdHy1fXT/gAQ4Gg/UXqDYfl1WLTI7Ds5+prH+4gqftd40XFwC5uhJ
         OXPg==
X-Gm-Message-State: AOAM533KNINk0N2P0r7bxzVpjKq0ohzq/tSoJtEjq3xmO+zZvBh2gBhh
        52O3ECtu4jVLn5/p65uODAdXKw==
X-Google-Smtp-Source: ABdhPJz9ghxh9GXiWJH62ZkCnE2MDHsoxw49C7l0LPpn1fBD2fGCSAhWi5yQacKDitsyq229QNEKNw==
X-Received: by 2002:a05:6000:1aca:b0:1ef:b7c5:896d with SMTP id i10-20020a0560001aca00b001efb7c5896dmr14693398wry.572.1646280077465;
        Wed, 02 Mar 2022 20:01:17 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id r16-20020a5d4e50000000b001f0075f4ca1sm702615wrt.105.2022.03.02.20.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:01:16 -0800 (PST)
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
Subject: [PATCH v9 7/9] arm64: dts: qcom: sdm845-oneplus: enable rradc
Date:   Thu,  3 Mar 2022 04:00:33 +0000
Message-Id: <20220303040035.1454103-8-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303040035.1454103-1-caleb.connolly@linaro.org>
References: <20220303040035.1454103-1-caleb.connolly@linaro.org>
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

