Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FD54710DD
	for <lists+linux-iio@lfdr.de>; Sat, 11 Dec 2021 03:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244373AbhLKC0W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Dec 2021 21:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244455AbhLKC0P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Dec 2021 21:26:15 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2AEC061A72
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 18:22:39 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v1so35728265edx.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 18:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8ojrHbxmE5FLDRKKp3KpbiDMf6SbWlM17imhKOU9dU=;
        b=GGhHo7Jaw+QBGgFqFkRY24G6A4g++chkvJbb/x0riVF6m5htIK8gG/aXczb8WCMCJz
         GnaSaaodRoqcbIXyjnLXNwiZJS1i3ZhdPvKh1S0rMPy9bX7DWUI/+Fh9aKFRQJlWzEhx
         A+JJA1BMWfsAWuOiPdpyauhfITDjyLL4dV1yw0pbsWZGstp89/j6GBOiW9RHIJctAoue
         staSiN2hPj0KuM2YuX6HFmsyjIo/9K0XxHA0hljIzl80czEBBEal3RrdaJLC4KgEM4m7
         8S2idMYZcxrDvJBn1p7o5nozCklCN/JK2JIrlWcJis3jpjhTreRD6Kj1rxmn3d5s9Qsa
         s2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8ojrHbxmE5FLDRKKp3KpbiDMf6SbWlM17imhKOU9dU=;
        b=o718yJoWzxjI3TQf7fVWfqV5IElKvvo/gJ4pKJsgveK3b+C10rvFRKtGn8WQx+OS6G
         B74YSG0N1IDA5EJcrwFrHuKJRO9EZoLqE5hkUzt0CJbo2W9Z0s0GtXZQCdJYifbdbifk
         GIHBBqbugXLteG52V8kovApS3bs+la/uAfVJFOU6wkfaORpPEdUDwdk79w1+KPdRgmV/
         /OCmr6L2LaOo7sY7S9lSJ8MofAlR+Q+aRQN/P4SCRF7tfjcVVE8YgXOFn2cXe4Psw5xS
         K9NiJ93PwKJP9PlLPBZ0aqKrx0BTv5rKRCDuAIgMqobUlLj+7MfjmFmF19Do2iLZNcJl
         yMwg==
X-Gm-Message-State: AOAM530gR27rcmhuhtEsPne8Fgsad/zrIthRaMB+1qXxvdLDo+rpxfc/
        tK441hgwVCS0vWdfuB41CXovVg==
X-Google-Smtp-Source: ABdhPJxdU3ie2HHClJoOFIOZRKZ05PscJB9zK+SiPPLZWZNmDvZKIzzv2ksLTK7o6fKIX0jB+xHlMQ==
X-Received: by 2002:a50:c34d:: with SMTP id q13mr43984159edb.65.1639189358272;
        Fri, 10 Dec 2021 18:22:38 -0800 (PST)
Received: from lion.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id s2sm2449424ejn.96.2021.12.10.18.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:22:37 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
X-Google-Original-From: Caleb Connolly <caleb@connolly.tech>
To:     caleb.connolly@linaro.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/7] arm64: dts: qcom: pmi8998: add rradc node
Date:   Sat, 11 Dec 2021 02:22:21 +0000
Message-Id: <20211211022224.3488860-5-caleb@connolly.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211211022224.3488860-1-caleb@connolly.tech>
References: <20211211022224.3488860-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Caleb Connolly <caleb.connolly@linaro.org>

Add a DT node for the Round Robin ADC found in the PMI8998 PMIC.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index 0fef5f113f05..da10668c361d 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -18,6 +18,14 @@ pmi8998_gpio: gpios@c000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pmi8998_rradc: rradc@4500 {
+			compatible = "qcom,pmi8998-rradc";
+			reg = <0x4500>;
+			#io-channel-cells = <1>;
+
+			status = "disabled";
+		};
 	};
 
 	pmi8998_lsid1: pmic@3 {
-- 
2.34.1

