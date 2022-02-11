Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0744B2F32
	for <lists+linux-iio@lfdr.de>; Fri, 11 Feb 2022 22:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353582AbiBKVUa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Feb 2022 16:20:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353556AbiBKVU3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Feb 2022 16:20:29 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC9AC5B
        for <linux-iio@vger.kernel.org>; Fri, 11 Feb 2022 13:20:25 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h6so17235611wrb.9
        for <linux-iio@vger.kernel.org>; Fri, 11 Feb 2022 13:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=MbgOlo5spfEC8hCE/EOFxOS2ueJMFq4HKxYCjwdtVmnelMXcnzpLW2NrAhaYmrgWey
         bJczkKEOn8ytNuZ8PsRDkR0QW/LDeD7e4N/u+qRHh00cW9uXtXplcVrMFfqguoLd5TlI
         lOFvwLGGLsFCWuqR4/aNUR/oh7rnHSDHfNDenAyQgKheud8B9j+u0daw3TG+hofMmLRo
         JY6DzswkszG8CV38N2KK4Y++aMNg35LKm+fUxySbFWVg8cZnYfxf8c5O2xNbdoQv7r9p
         TJOKbFXYaVcL5A+O7IjKQSV1+x40fJ1UB84H0Kj16osJRxSJiqOCkZX3B3ninGoya7R3
         R+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/d166yo9TtkM4+c7x0I89HNNMPO2K1Na/pBqagV1Y0=;
        b=1nI4cy4N0GIYs48NbB+q6G+ksKHF+dFegjzI4Ar7dMWRf4HR0oz+qcCrw+Rb9H4wDu
         bXWbdUfFbBgWqb+tc0dwFTPup8XA5AqY5bSMQxmKdyFUxQ1KVCleD16rcpyNoeCy8rOo
         0mnZ/P1cTi2rJkuswCE6vcHMEPZ3B+PhK7VIL9wRfZOR6HQlt+59xHB39NSCUc+ynquG
         igR4/9KcAsBpcc0aTyBwbz1jGqwen8hI9zMN0i3Ui6esrS0eG1GsZYluWtkuCeWVnKeE
         dmO9PfVbiDsTMw6b30F2RvebES8HTJpcypoqR5z4zIyf2D2fji7f5BKMGU4RLjyLf4bL
         gUqg==
X-Gm-Message-State: AOAM530MTSkNrWAM7teI+TZQ9AYpTTwYnoAca3GYXlYvZku4P/Dkz7Vq
        MwV7UeZT8N9QtXfv5rU1P8wGcA==
X-Google-Smtp-Source: ABdhPJziSJsedjC6g3EGZpOd6xSdkDK2oGv9uEK65oxUBGa3mTJzU2KatuQnr6TNOXXP4Ax51gl13A==
X-Received: by 2002:adf:e409:: with SMTP id g9mr2812714wrm.496.1644614424204;
        Fri, 11 Feb 2022 13:20:24 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id x5sm14276017wrv.63.2022.02.11.13.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:20:23 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
Subject: [PATCH v4 7/8] arm64: dts: qcom: sdm845-db845c: enable rradc
Date:   Fri, 11 Feb 2022 21:19:58 +0000
Message-Id: <20220211211959.502514-8-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211211959.502514-1-caleb.connolly@linaro.org>
References: <20220211211959.502514-1-caleb.connolly@linaro.org>
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

