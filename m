Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8B485876
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jan 2022 19:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbiAESe1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Jan 2022 13:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243052AbiAESeZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jan 2022 13:34:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE69C0611FD
        for <linux-iio@vger.kernel.org>; Wed,  5 Jan 2022 10:34:24 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r17so62782wrc.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Jan 2022 10:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6owdUrWnsMJbv4dtPOTN1GhRqLZCzET0ZErU0fw/VVw=;
        b=umyUYyPj8Y8dGWViGQ53lLOC1QgwFrSDaCbaCBHetou6It3/5RZzFXGgS/2MGb1/ke
         lAGl5C4vkr5el7oFdBXMQ2BFIq3GFcOotddpplp26eaICa7yi2DPzDXuhV4G/lbdSlGy
         2aGOY95iyaV4GStJLekVb3u3Lg1n6LreebBEthtB8YpRESs8/MkQ1+gyYOW5eK1mdwxC
         LkZ5ADQzDUbW0cFUbW7kT4OBkNRY/y2sZOun7Uai4j3UzFl0Otetrvn+C4M0NPfw5RgB
         AqRr6Rkehvs4uXq14WpZmPQ0iQ32Ob4eMoCzvYh6bfnmTQDaFxQzdr1J8orNeSSqfgPk
         H4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6owdUrWnsMJbv4dtPOTN1GhRqLZCzET0ZErU0fw/VVw=;
        b=40z7mRmE96dbJJv266w3fItgyKtL4Huz24dQ3+PPOMpQTe1g3NUyQKfWnzcQ7FsJux
         c/1HU4ggiQkKAO5/VWb7H75jEvgmKZRf5mcZHf2fNQeK/UHSgd03E6uljE9jvry6ueJ7
         4cRv3qiu0FuqNBo1o5LyIu0DiAslx9CwFW0aNBOZPJ1yaSoces2ASYKZQlUqvH6WW2pT
         FMo3ruRIhGtYIAEIbqpzkg6LX65AHx+kY+Wa4EI6gtJNHTsK865WpXgZPgzQoAXo8NlJ
         S4OVIltpn5h9mn54XBIlEbMu3FEcNGPL0mFUVuEs23CVKsTVD8ym3nVRSCMbxzVJA7hb
         Ya5A==
X-Gm-Message-State: AOAM531SXTSmMw3jBJgZsnQ3lzlYggwS0yWZoAXTH9BTdN9U/gA0Tb6p
        KbIVco3oQk4Hgm5jIgSFRVTz3w==
X-Google-Smtp-Source: ABdhPJyxfDPsbnxdNzdjwnjvGaaXfGJUwL/J85bz0M2Bs9NvtNlOzt0qitd4HXxs0OakcL+q2ZpagA==
X-Received: by 2002:a5d:4c48:: with SMTP id n8mr47008816wrt.25.1641407663486;
        Wed, 05 Jan 2022 10:34:23 -0800 (PST)
Received: from localhost.localdomain ([81.178.195.252])
        by smtp.gmail.com with ESMTPSA id o1sm3272215wmc.38.2022.01.05.10.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 10:34:22 -0800 (PST)
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
Subject: [PATCH v2 5/7] arm64: dts: qcom: sdm845-oneplus: enable rradc
Date:   Wed,  5 Jan 2022 18:33:51 +0000
Message-Id: <20220105183353.2505744-6-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105183353.2505744-1-caleb.connolly@linaro.org>
References: <20220105183353.2505744-1-caleb.connolly@linaro.org>
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

