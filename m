Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE85D4B7749
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbiBORK3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 12:10:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbiBORK2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 12:10:28 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD01411C7CB
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so19501883wrg.11
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qImSYxU2i/y/qV71r8EFW+LTWk9ZfhM4KeM2jcTcklQ=;
        b=s0rSuUU6Vkr6353bMzfVha57JotEXp85WajSwF4FyFCjtniTreNTPck4uMqeP+U5Bc
         cK5IF4sEr7ey4Tif3CtRu+ufJFbbmN+5PGNXfXhhdMywo7TxYZsuZr4U70LSEEtAFTap
         aWPJ7HYVe8WP1t+hkwfLtARUt564rrltxFQOPHGwNbOpFqsJJaA1nC2mA7dfAjp4APp7
         uKoyBzSeHItBL0X3WRJTYxzy5Uwyx8Zk7zcIHy2WyQyIXiR0ZgOwRjEe2LNte7sPS7Fi
         scE99X3YjKTAceTW6XrMx20vQ7qTLihPkggsJ9bokjKCEozuehOi8eyMTQ2thhdbG0yb
         VX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qImSYxU2i/y/qV71r8EFW+LTWk9ZfhM4KeM2jcTcklQ=;
        b=YmiSp1B8/HWqjnuxrcHomAgZ9dISa+MFPncM9vDRE2pBRtfPRbbzt/rfACi65Ru4TX
         awBQCSXSg3C/5p2K5jLyb5zshdUiQdGGjBpG03YGrP973rTfQ7svU20GujV/rtboNnRy
         n00kxhR7lHjcXGvnKnDbTpGyNOIGj9wlAzhfKYEJYG2Fa8ycWswo6nQi0w4i4ABf1hAj
         ky1PbAbJqzy77HR31zrhOevYo1U7MOLzv13yPMaJkWykKv2Hs/wwl29WDtvma4ivNIFk
         ra1m0HbbttxPPsJfVQ+tidLnRiNORzCBnl1/KnaeKiN0m2X9ValsnKA6i8bzUAoLQnJu
         YCCw==
X-Gm-Message-State: AOAM532ltNkblKgrNfEEM/B90mUv7tETYEX0XTDwij7DGp9yHkWsh/u6
        XkMgkC2lwTc8I0m9WGe18wfqcA==
X-Google-Smtp-Source: ABdhPJzbxWlkLcv4dByszHQRrPpY/zwFZJP9TYlpUX/myYapLODWX3QwYfFYLzGTIWfXXlAJ38uSYw==
X-Received: by 2002:a05:6000:18a2:: with SMTP id b2mr4034851wri.645.1644945013380;
        Tue, 15 Feb 2022 09:10:13 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id g5sm15558474wmk.38.2022.02.15.09.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 09:10:12 -0800 (PST)
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
Subject: [PATCH v6 7/9] arm64: dts: qcom: sdm845-oneplus: enable rradc
Date:   Tue, 15 Feb 2022 17:09:49 +0000
Message-Id: <20220215170951.1233375-8-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215170951.1233375-1-caleb.connolly@linaro.org>
References: <20220215170951.1233375-1-caleb.connolly@linaro.org>
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

