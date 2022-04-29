Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8839E515811
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 00:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381389AbiD2WOc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Apr 2022 18:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381397AbiD2WO1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2022 18:14:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49139DCA9F
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:11:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c11so2592404wrn.8
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=57engup4j45HnL7iURERsQ9bmMAMFdlq2bnMX7taFcM=;
        b=KMXgwq1kT4vpGqXVn6WjiTOVMNVqDXTTrwGtMvopzf8LUXavFlq16ADBbLzVjTTiOO
         S80A+O5TSD/4favz/l325p0RuFQVv388Nn8goDchum0+CM+q8+vDd0ydLYOGTcOnulCo
         UqHeyoL5HxMVRhdgv2gtKGhuYrRmWHfYIdD7Ea2xMkVT7W+KVhhqKXoMs+oR5BWlG2EG
         pSsZUlRg2Qzrm2CTV2yilbR5Cs+mRB3xBAPGsTaLFJLZu7c0m0H7awkLPrTBX0PK6jtP
         2WOmrgZlB5b5qwiTJp//3iHNTLH5BFfgJkF8rYeTkKDR89Rhul6gvCZlAj7oBGh2QpHx
         PIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=57engup4j45HnL7iURERsQ9bmMAMFdlq2bnMX7taFcM=;
        b=OV/BN1k3ywfCA0XxGJRE5Q9jkahdjBfLPE++S+z+Dx2U1N+bf6D10XHvQ2xJwCatTa
         FLlB1EZ+urWgEIM1bV2oKqeNeZW4dqcn2kObyIi8FyvY0oC9VhciVdxyU14QDPhv3sm1
         RtSwwmdov89CK5xqFyrTCRwoHeX6MFfmRk4PJSGvXXkv/Q34cyxWgJEtiP94B5vpFqj/
         Y/cDo3w8Jlydel+5uo1sLxF13m9iz724gvBz+9HY3ttN7/EKdrkmf4MQyZMekgwCDP5g
         bKKAxp7wemytJyievZXjYQoHzdfD8PnwyGTr3zDWYMR4mUZHln/emkTT0QegXwfYR32Y
         0AJQ==
X-Gm-Message-State: AOAM5333G5mCTIfAbgrK+W77UQN2wltdL4eN/YwKD7leTIqjbvRRj/z7
        iekRU879uvsgxC0oHFbRj0tkvw==
X-Google-Smtp-Source: ABdhPJxxf4Y9z8bowzImAap497E8RuioUTq7E3SZ8AirFC/uZaKYONIF7e4s3jdC60OW704ZIVQ7TQ==
X-Received: by 2002:a05:6000:1a4f:b0:20a:ccdd:c70e with SMTP id t15-20020a0560001a4f00b0020accddc70emr850284wry.444.1651270266909;
        Fri, 29 Apr 2022 15:11:06 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003942a244ebfsm291985wmq.4.2022.04.29.15.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:11:06 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v14 10/10] arm64: dts: qcom: msm8998-oneplus-common: enable RRADC
Date:   Fri, 29 Apr 2022 23:09:05 +0100
Message-Id: <20220429220904.137297-11-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220429220904.137297-1-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jami Kettunen <jami.kettunen@somainline.org>

Enable the Round Robin ADC for the OnePlus 5/5T.

Signed-off-by: Jami Kettunen <jami.kettunen@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index 9823d48a91b1..d9fff1beaf03 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -257,6 +257,10 @@ pinconf {
 	};
 };
 
+&pmi8998_rradc {
+	status = "okay";
+};
+
 &qusb2phy {
 	status = "okay";
 
-- 
2.36.0

