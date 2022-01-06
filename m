Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42C2486896
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jan 2022 18:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbiAFRcC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jan 2022 12:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241958AbiAFRb6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jan 2022 12:31:58 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93076C033268
        for <linux-iio@vger.kernel.org>; Thu,  6 Jan 2022 09:31:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso1591126wme.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Jan 2022 09:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6owdUrWnsMJbv4dtPOTN1GhRqLZCzET0ZErU0fw/VVw=;
        b=LYrMz7mY+dnmAeSQGk4VEVrSwLq3fbq5WKJ8TaIGQlkgf14SWt4wA8bgP6VqEKzMNt
         pbOLZ5xXSF0+bNyDSQ5l/jnWvIJpTMXvXQ7hJkSxv3fs65LRCvs4qE5ZZX0HXhNiQBLi
         xs1fOyImB5Nq6KjCbrlmUI3wsN3YEuDH9gq6V7ftYHvE8PBIvSlQuR+ufZQItJwDCC1z
         6Yhfk4ahxOQgq4JmEkcDVZR5/DoyU5JxKKFFNgF0UvgPeUMxTh6ETna048ol+b9Wm6iE
         LXMlbZbycaP5Hy15/fQl7ZPhLwZ+DfXfNVxGq+wYHhHP08BquZITm+4ugqLNPp14mvCm
         rh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6owdUrWnsMJbv4dtPOTN1GhRqLZCzET0ZErU0fw/VVw=;
        b=OXDgUFqDlWaWid4XErv1rSQAfFeUWCbmU1BW2Cvxe5NSDY2jrcaejllLqq/A6Ov/bm
         L3ZzTv9kY21tjRPDVPFm+BlEXVqG1R/zUn82pbreZ/GW3srKX93J6Stiq9GoeONxjQcP
         SIy4/1t0mye4vR4v9R0Hpz3/Sh2b2E+PZh7BxOxytbf2M2zpP3I+XcRmVJpme6ubaU2O
         Lf/wlPK99cML5855DlocNWihlewb9pmACJ1L1xP9NRHnpCFDXx7TOlD6fT6LXEycJF6L
         fmfxeJiX/LD0yavOHSNGz04UqQxuVpNR1pxRsjbUUY5Mo1cy1ebv8Q2uR74qeV2lF7DX
         g5Eg==
X-Gm-Message-State: AOAM531mkPHfLlPJp9I2edba1+UW0a4LvEolO2OWqSCgdBdSvx1eVQgY
        g/FlPcGcdI1htl/zE4eZ2DNzUw==
X-Google-Smtp-Source: ABdhPJwStHeb45F64zudZhTtE4SVnuzh76jgqxrVqZ/SoO8ntdl8lnXNmDjH+hS27LpZEpr9aE6CJA==
X-Received: by 2002:a1c:1dd0:: with SMTP id d199mr7977135wmd.150.1641490315047;
        Thu, 06 Jan 2022 09:31:55 -0800 (PST)
Received: from localhost.localdomain ([81.178.195.252])
        by smtp.gmail.com with ESMTPSA id b16sm2575594wmq.41.2022.01.06.09.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:31:54 -0800 (PST)
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
Subject: [PATCH v3 5/7] arm64: dts: qcom: sdm845-oneplus: enable rradc
Date:   Thu,  6 Jan 2022 17:31:29 +0000
Message-Id: <20220106173131.3279580-6-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106173131.3279580-1-caleb.connolly@linaro.org>
References: <20220106173131.3279580-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable the RRADC for the OnePlus 6.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 3e04aeb479d1..9feda49b2f12 100644
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
2.34.1

