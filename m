Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0B048689C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jan 2022 18:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbiAFRcE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jan 2022 12:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242030AbiAFRb7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jan 2022 12:31:59 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76713C034006
        for <linux-iio@vger.kernel.org>; Thu,  6 Jan 2022 09:31:58 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s1so6220019wra.6
        for <linux-iio@vger.kernel.org>; Thu, 06 Jan 2022 09:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VD8BhFQsi1gAqizHlVU3fMYSmPUmL03WAYruvW0snE=;
        b=m0HegGbWAjKeIsRoARzohUa1OFMBWmXZPnpb5wapIM9mm6FBTq1HEOGWlGenaN3qdn
         TvWeF9SIpEDEC5m9jk5Kp9vi1+dvoGcUPJgdxkFcFmhdle1fNu+aEc5p9h1nShqrcPr9
         cuHbe9jDYKohD+V842KPRBr2Nb5OtDaemIUGCatFdFOslDRAjkL4HblA+hNxDcKNuAHO
         LXfQ1zU2ZPkOf0SsV4iTWTKHlU+3kgzp5gxCXxiZcnAzaWwY1vdjk+tTYHN2MZ9tMz0b
         O28XacDMJHSYjxjiu7EjHdJ6QMQTFZ93yg2mNQzGXvgLBqR1OwAWiBV8/Sf3GpKubiF8
         /fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VD8BhFQsi1gAqizHlVU3fMYSmPUmL03WAYruvW0snE=;
        b=oyQpz8T2YsKnZ3LaUkZRerbpeO60Y8weHrSMOom5xecFX1YL00EuyTDarvuFh1E/TL
         DFNI8Crnpksbrngd3tPgK/NzD7ZH2DN9uar4yyzb1FP1xXZbVY7m0rw1gsRK/pTY1pcb
         qr2eqnONIkYeY2Svm9T/0M1IxOJXAxwhJfiT7BOjrtXWQLciBEUm0kIuc8psEB0nHx+j
         RiUhKTFV3sjCrfmS5OY/ya9+yeMvA4+kDoe8JyO3Q5RLO4udalzM5+N+YZRRTB6Zv6IP
         Ls2qmmMrtQ/WYki0YruJw0BTl5+m5/O7uVub0cEhr0nezV+m+w4lKUS1UcRNj5jdWWyZ
         8OoQ==
X-Gm-Message-State: AOAM533hU2rvNWm8Mda39kE094olyE0ZFFmfT4KwPux/4zaED85UN4ef
        iC3GJSuq7hxvK3tDk+I/qmOOsw==
X-Google-Smtp-Source: ABdhPJy11EzN1DwExZ7UdzsyYAs7SBnwijjhuNVuuoC9cCSTKSH3NTcmkInYclaSjfV1HMK9sX5vSA==
X-Received: by 2002:a5d:6f02:: with SMTP id ay2mr14004127wrb.269.1641490317063;
        Thu, 06 Jan 2022 09:31:57 -0800 (PST)
Received: from localhost.localdomain ([81.178.195.252])
        by smtp.gmail.com with ESMTPSA id b16sm2575594wmq.41.2022.01.06.09.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:31:56 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
Subject: [PATCH v3 7/7] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable RRADC
Date:   Thu,  6 Jan 2022 17:31:31 +0000
Message-Id: <20220106173131.3279580-8-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106173131.3279580-1-caleb.connolly@linaro.org>
References: <20220106173131.3279580-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable the PMI8998 RRADC.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 580d4cc1296f..481132b0cee4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -312,6 +312,10 @@ resin {
 	};
 };
 
+&pmi8998_rradc {
+	status = "okay";
+};
+
 /* QUAT I2S Uses 1 I2S SD Line for audio on TAS2559/60 amplifiers */
 &q6afedai {
 	qi2s@22 {
-- 
2.34.1

