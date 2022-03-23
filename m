Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD614E5671
	for <lists+linux-iio@lfdr.de>; Wed, 23 Mar 2022 17:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245468AbiCWQaS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Mar 2022 12:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245496AbiCWQaQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2022 12:30:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4CB2613D
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 09:28:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r23so2543556edb.0
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3chBvQtaFpWsJXLbJK0rcXNgLO2O2TpZKBWBvHMiT5w=;
        b=hLuTsLqSWnP0GIRDCIJbx3Rfg4qTw75KEdF/BILRLUKmTYhh6oDsrFP6XOkCX1fugM
         ffqlLkWEmwS+LBGtYrQsnoXFJdbAyBe8TR0BlyyIH9NRJBG3hqmy97vtLOJaxFZY0isl
         cQqLoRt0IoXBrqsN3VuxJr27r8Gvb8hTB7S8b2Zxvq+wbcY6U+LWnuMHgpviIBdJ2qjK
         rLIIgt75q47TKnpCk0WIesQuNM+E6sj78NnnhyFAi+y30Gx26WySYALqA36ys/ls/6m9
         IfcOBFmTD/+4q40DoI+wR4dpaihcDp8bW9txmzRWAjSvUHW83v8KPowcuhSrFKId29R3
         SnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3chBvQtaFpWsJXLbJK0rcXNgLO2O2TpZKBWBvHMiT5w=;
        b=sFUtobTxIHo4pgeSLmAaNVZbXYzly3FXyqWeoUqpeQOxWrIOHILBFgnzfKqGaBnRIR
         o/4K/l23HwaAKU+wnhjycuStNfvwr5C4mRgzR05yFB/VOOfk7fmvswmhGk0B9SxUqQyd
         VL85CESOOcGrGOvTnVH6dVgtMlqhFXwReLPUZ38GCZRddTAoAARnh+mSAXdBbl0VX3HM
         tHSFjo3rtx2LJZyySTdZC+xfHvUJ0ImA2p84eArwRoV/cVOQdjK0+fCyH0J4pMt+zuG3
         OG9HXyrXpkmF7ydHWbEKwUzXDpf4IEjiUGJBKpKmr3BvQ8h8hPY1Ule12Q+n3M4AQwPt
         7YAw==
X-Gm-Message-State: AOAM533ZSHNgf0WRfVETPH0NrTKJi7rVTrWvQ1Gf0cNn1EjzHmi2Uf5a
        dYeu4pdutUp1JmMDxe6C3Vc67A==
X-Google-Smtp-Source: ABdhPJyS4CmVnHOMRi98HDn0UcrnntPzV8MX00y/WN0w+hqMRAnK2EgGw0p24adjq5iyI0U0sHRejw==
X-Received: by 2002:aa7:de96:0:b0:418:f9ca:67f6 with SMTP id j22-20020aa7de96000000b00418f9ca67f6mr1150242edv.25.1648052924476;
        Wed, 23 Mar 2022 09:28:44 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm173306edm.90.2022.03.23.09.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:28:43 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
X-Google-Original-From: Caleb Connolly <caleb@connolly.tech>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v13 8/9] arm64: dts: qcom: sdm845-db845c: enable rradc
Date:   Wed, 23 Mar 2022 16:28:19 +0000
Message-Id: <20220323162820.110806-9-caleb@connolly.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323162820.110806-1-caleb@connolly.tech>
References: <20220323162820.110806-1-caleb@connolly.tech>
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

From: Caleb Connolly <caleb.connolly@linaro.org>

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

