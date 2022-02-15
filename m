Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5D84B7622
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbiBORK3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 12:10:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242280AbiBORK2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 12:10:28 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA5611ADE0
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d27so33255360wrc.6
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=QoFM+JEJRo1n40Gs+30ZhFnhZ809XZ1cgbfP+82WqnCj4zoq8y+4OhcRl87QDpBAu4
         ZwXQtIBqFDw8mKER1ZR5t0Rfo5mQWALPCOCxUhYKTdwhIQV44EXFGgObYG097WN6R+sq
         s6IqwSfuEdDkEvwECoXAR//SX7OOW16igt07XU8K/lMrsI2Muf6btKNGYuWNvMfP8/KN
         TKI/NKo3QE0O5gUzrB1O3s0+Mad42MXyIBKgTarVV+7qrvbWAe6bWo0M0iCFUETfDsuB
         ELNcpFtTEb/AK/hRfB+h4NyILMYBIRS2mZAI9kLELKka1rcop0prUjXA4AWqHqbDik59
         P/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=HghzEjl2ELhhfh9IAjVBOl1Nhi8C/7YK1N1MPk29WwXOTEQUX02QP8I7sUsjC/XGA+
         A0FK/vhxsvwLxT9h/KFoBdySzpD/POXG6qfdRaj0INzgoN6UhotqUn64AiFiElK9Qasj
         FUF0RqCkcOZL0cOiUHnax+KlB3wQn2ewf4Tbn6JmVt73SFMDweZ2eyb4SVjnHlZtNiJR
         Tmgr609AhdBsxC4jexuy3/l32OQC2Yo0xL9Iat4tpC2YvvglM8nI0VpiFxKop7P3Rtsp
         LVbRPj2YZpuMALI9ppJ8oVpmRxuFZHMFcpdZcGu6Ps0GIWKKjQtZrCXc02/Zde9IyMlK
         S88g==
X-Gm-Message-State: AOAM533sd0h+SfXqSctrVk8aAJLviZUdgKUFSJ06yAa1tdkGmTpaMjEj
        ujHEyvJN/XAm0/Tc2rujynfx1g==
X-Google-Smtp-Source: ABdhPJxpimJ06Abn5eYnoOzxEfhvXTIC4eKQeyyYzzqyti1G1VXk2/31zNMjP7CnPaCeY4nZsFTNUg==
X-Received: by 2002:adf:ea50:: with SMTP id j16mr4017342wrn.213.1644945014592;
        Tue, 15 Feb 2022 09:10:14 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id g5sm15558474wmk.38.2022.02.15.09.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 09:10:14 -0800 (PST)
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
Subject: [PATCH v6 8/9] arm64: dts: qcom: sdm845-db845c: enable rradc
Date:   Tue, 15 Feb 2022 17:09:50 +0000
Message-Id: <20220215170951.1233375-9-caleb.connolly@linaro.org>
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

