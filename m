Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBFC74B0E6
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jul 2023 14:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjGGMal (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jul 2023 08:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjGGMak (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jul 2023 08:30:40 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15042126
        for <linux-iio@vger.kernel.org>; Fri,  7 Jul 2023 05:30:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b5c2433134so23147781fa.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Jul 2023 05:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688733029; x=1691325029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpAMg+24gjcAFQPQ3fePL7rvs7CVIrlc1R67zh+wIgU=;
        b=gRDXL5lRZ9O1cQyCJTJ5kd8kWhQqQNXJ0eB7cws6Gfzv/pfSj98HZwyLa4v6sTF14Y
         82q1suVyTl0w9hTyrewO1PJiHPl2iE6H6/k6lPa77JBhRjgvzAeA7aLEE2rMcf9WAPGw
         LLh956dZWP5jb1JoHb4NJROcy1TYYuHQeQk/6HIYhFCL5RHzV+yIp8TStWdskdl5sBp+
         v68r/r0Sp9d7BdZtsgkDZ0pHkK/k3mhyUdA8NgR2yfvebJF6TC9z4aNnqEqImHmt82P7
         0+BH0niw3tUZ5/kI/LpdCQaryBvWFlTIsWr1IzCt0HviLoaxSe3G8wXaG/5I1EVDzW8B
         Uq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688733029; x=1691325029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpAMg+24gjcAFQPQ3fePL7rvs7CVIrlc1R67zh+wIgU=;
        b=Z8gQaKrxy+Uk07f69MyRLxoHLRlExMld4dwc9FAcU3eh7oFue9Ip40Dv2x4+bzehqx
         3f6QC4s/0jX2gtBGqcFhNkZkEKuCj9yTdjKeqK+bCRibNw+faUc/62I3ujJr+85zIwFG
         TE3VYo2qNfKNaJtLFZNVKEmtvVFig9dh4u39UFKOb4fdzloAn91TV6k8gwj01kppoIoZ
         5R0WHOGxKqmE5JndD0EjqdwRrl/woRSXAYvs6Vq+SxHoZhS9z8p3N8Rp9ZNbHDGuRenm
         xfscln2kpvJ0TM+6VAICxQDnAAK6TfE6T/b+AuUQ7fpIFnhI0y3dkxPQ9b2f2vwfZjlT
         nh4A==
X-Gm-Message-State: ABy/qLaqV6oA+G5zSSCNt+sp9vXc3bQ5xFtbYzp1i96Up9TXPpExjwB0
        ADSkneBQgCT0SWpzDymRhUiUEA==
X-Google-Smtp-Source: APBJJlELG0tX1UdOziVYck/CMpWhS7BVaOFkxP6XBwk/l9WoOygaaE+Gv/SI9qKbVbuwImEdwcAicQ==
X-Received: by 2002:a2e:97d1:0:b0:2b6:cb3f:97e2 with SMTP id m17-20020a2e97d1000000b002b6cb3f97e2mr1952449ljj.16.1688733029103;
        Fri, 07 Jul 2023 05:30:29 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8685000000b002b6ee99fff2sm756803lji.34.2023.07.07.05.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:30:28 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH v2 1/8] dt-bindings: iio: adc: qcom,spmi-adc7: use predefined channel ids
Date:   Fri,  7 Jul 2023 15:30:20 +0300
Message-Id: <20230707123027.1510723-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230707123027.1510723-1-dmitry.baryshkov@linaro.org>
References: <20230707123027.1510723-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Each of qcom,spmi-adc7-pm*.h headers define a set of ADC channels that
can be used for monitoring on thie particular chip. Switch them to use
channel IDs defined in the dt-bindings/iio/qcom,spmi-vadc.h header
instead of specifying the numeric IDs.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../dt-bindings/iio/qcom,spmi-adc7-pm8350.h   |  88 +++++++------
 .../dt-bindings/iio/qcom,spmi-adc7-pm8350b.h  | 124 +++++++++---------
 .../dt-bindings/iio/qcom,spmi-adc7-pmk8350.h  |  50 +++----
 .../dt-bindings/iio/qcom,spmi-adc7-pmr735a.h  |  22 ++--
 .../dt-bindings/iio/qcom,spmi-adc7-pmr735b.h  |  22 ++--
 5 files changed, 158 insertions(+), 148 deletions(-)

diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
index 09fd169ad18e..5d98f7d48a1e 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
@@ -6,58 +6,60 @@
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
 #define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
 
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+
 /* ADC channels for PM8350_ADC for PMIC7 */
-#define PM8350_ADC7_REF_GND(sid)			((sid) << 8 | 0x0)
-#define PM8350_ADC7_1P25VREF(sid)			((sid) << 8 | 0x01)
-#define PM8350_ADC7_VREF_VADC(sid)			((sid) << 8 | 0x02)
-#define PM8350_ADC7_DIE_TEMP(sid)			((sid) << 8 | 0x03)
-
-#define PM8350_ADC7_AMUX_THM1(sid)			((sid) << 8 | 0x04)
-#define PM8350_ADC7_AMUX_THM2(sid)			((sid) << 8 | 0x05)
-#define PM8350_ADC7_AMUX_THM3(sid)			((sid) << 8 | 0x06)
-#define PM8350_ADC7_AMUX_THM4(sid)			((sid) << 8 | 0x07)
-#define PM8350_ADC7_AMUX_THM5(sid)			((sid) << 8 | 0x08)
-#define PM8350_ADC7_GPIO1(sid)				((sid) << 8 | 0x0a)
-#define PM8350_ADC7_GPIO2(sid)				((sid) << 8 | 0x0b)
-#define PM8350_ADC7_GPIO3(sid)				((sid) << 8 | 0x0c)
-#define PM8350_ADC7_GPIO4(sid)				((sid) << 8 | 0x0d)
+#define PM8350_ADC7_REF_GND(sid)			((sid) << 8 | ADC7_REF_GND)
+#define PM8350_ADC7_1P25VREF(sid)			((sid) << 8 | ADC7_1P25VREF)
+#define PM8350_ADC7_VREF_VADC(sid)			((sid) << 8 | ADC7_VREF_VADC)
+#define PM8350_ADC7_DIE_TEMP(sid)			((sid) << 8 | ADC7_DIE_TEMP)
+
+#define PM8350_ADC7_AMUX_THM1(sid)			((sid) << 8 | ADC7_AMUX_THM1)
+#define PM8350_ADC7_AMUX_THM2(sid)			((sid) << 8 | ADC7_AMUX_THM2)
+#define PM8350_ADC7_AMUX_THM3(sid)			((sid) << 8 | ADC7_AMUX_THM3)
+#define PM8350_ADC7_AMUX_THM4(sid)			((sid) << 8 | ADC7_AMUX_THM4)
+#define PM8350_ADC7_AMUX_THM5(sid)			((sid) << 8 | ADC7_AMUX_THM5)
+#define PM8350_ADC7_GPIO1(sid)				((sid) << 8 | ADC7_GPIO1)
+#define PM8350_ADC7_GPIO2(sid)				((sid) << 8 | ADC7_GPIO2)
+#define PM8350_ADC7_GPIO3(sid)				((sid) << 8 | ADC7_GPIO3)
+#define PM8350_ADC7_GPIO4(sid)				((sid) << 8 | ADC7_GPIO4)
 
 /* 30k pull-up1 */
-#define PM8350_ADC7_AMUX_THM1_30K_PU(sid)		((sid) << 8 | 0x24)
-#define PM8350_ADC7_AMUX_THM2_30K_PU(sid)		((sid) << 8 | 0x25)
-#define PM8350_ADC7_AMUX_THM3_30K_PU(sid)		((sid) << 8 | 0x26)
-#define PM8350_ADC7_AMUX_THM4_30K_PU(sid)		((sid) << 8 | 0x27)
-#define PM8350_ADC7_AMUX_THM5_30K_PU(sid)		((sid) << 8 | 0x28)
-#define PM8350_ADC7_GPIO1_30K_PU(sid)			((sid) << 8 | 0x2a)
-#define PM8350_ADC7_GPIO2_30K_PU(sid)			((sid) << 8 | 0x2b)
-#define PM8350_ADC7_GPIO3_30K_PU(sid)			((sid) << 8 | 0x2c)
-#define PM8350_ADC7_GPIO4_30K_PU(sid)			((sid) << 8 | 0x2d)
+#define PM8350_ADC7_AMUX_THM1_30K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM1_30K_PU)
+#define PM8350_ADC7_AMUX_THM2_30K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM2_30K_PU)
+#define PM8350_ADC7_AMUX_THM3_30K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM3_30K_PU)
+#define PM8350_ADC7_AMUX_THM4_30K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM4_30K_PU)
+#define PM8350_ADC7_AMUX_THM5_30K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM5_30K_PU)
+#define PM8350_ADC7_GPIO1_30K_PU(sid)			((sid) << 8 | ADC7_GPIO1_30K_PU)
+#define PM8350_ADC7_GPIO2_30K_PU(sid)			((sid) << 8 | ADC7_GPIO2_30K_PU)
+#define PM8350_ADC7_GPIO3_30K_PU(sid)			((sid) << 8 | ADC7_GPIO3_30K_PU)
+#define PM8350_ADC7_GPIO4_30K_PU(sid)			((sid) << 8 | ADC7_GPIO4_30K_PU)
 
 /* 100k pull-up2 */
-#define PM8350_ADC7_AMUX_THM1_100K_PU(sid)		((sid) << 8 | 0x44)
-#define PM8350_ADC7_AMUX_THM2_100K_PU(sid)		((sid) << 8 | 0x45)
-#define PM8350_ADC7_AMUX_THM3_100K_PU(sid)		((sid) << 8 | 0x46)
-#define PM8350_ADC7_AMUX_THM4_100K_PU(sid)		((sid) << 8 | 0x47)
-#define PM8350_ADC7_AMUX_THM5_100K_PU(sid)		((sid) << 8 | 0x48)
-#define PM8350_ADC7_GPIO1_100K_PU(sid)			((sid) << 8 | 0x4a)
-#define PM8350_ADC7_GPIO2_100K_PU(sid)			((sid) << 8 | 0x4b)
-#define PM8350_ADC7_GPIO3_100K_PU(sid)			((sid) << 8 | 0x4c)
-#define PM8350_ADC7_GPIO4_100K_PU(sid)			((sid) << 8 | 0x4d)
+#define PM8350_ADC7_AMUX_THM1_100K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM1_100K_PU)
+#define PM8350_ADC7_AMUX_THM2_100K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM2_100K_PU)
+#define PM8350_ADC7_AMUX_THM3_100K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM3_100K_PU)
+#define PM8350_ADC7_AMUX_THM4_100K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM4_100K_PU)
+#define PM8350_ADC7_AMUX_THM5_100K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM5_100K_PU)
+#define PM8350_ADC7_GPIO1_100K_PU(sid)			((sid) << 8 | ADC7_GPIO1_100K_PU)
+#define PM8350_ADC7_GPIO2_100K_PU(sid)			((sid) << 8 | ADC7_GPIO2_100K_PU)
+#define PM8350_ADC7_GPIO3_100K_PU(sid)			((sid) << 8 | ADC7_GPIO3_100K_PU)
+#define PM8350_ADC7_GPIO4_100K_PU(sid)			((sid) << 8 | ADC7_GPIO4_100K_PU)
 
 /* 400k pull-up3 */
-#define PM8350_ADC7_AMUX_THM1_400K_PU(sid)		((sid) << 8 | 0x64)
-#define PM8350_ADC7_AMUX_THM2_400K_PU(sid)		((sid) << 8 | 0x65)
-#define PM8350_ADC7_AMUX_THM3_400K_PU(sid)		((sid) << 8 | 0x66)
-#define PM8350_ADC7_AMUX_THM4_400K_PU(sid)		((sid) << 8 | 0x67)
-#define PM8350_ADC7_AMUX_THM5_400K_PU(sid)		((sid) << 8 | 0x68)
-#define PM8350_ADC7_GPIO1_400K_PU(sid)			((sid) << 8 | 0x6a)
-#define PM8350_ADC7_GPIO2_400K_PU(sid)			((sid) << 8 | 0x6b)
-#define PM8350_ADC7_GPIO3_400K_PU(sid)			((sid) << 8 | 0x6c)
-#define PM8350_ADC7_GPIO4_400K_PU(sid)			((sid) << 8 | 0x6d)
+#define PM8350_ADC7_AMUX_THM1_400K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM1_400K_PU)
+#define PM8350_ADC7_AMUX_THM2_400K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM2_400K_PU)
+#define PM8350_ADC7_AMUX_THM3_400K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM3_400K_PU)
+#define PM8350_ADC7_AMUX_THM4_400K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM4_400K_PU)
+#define PM8350_ADC7_AMUX_THM5_400K_PU(sid)		((sid) << 8 | ADC7_AMUX_THM5_400K_PU)
+#define PM8350_ADC7_GPIO1_400K_PU(sid)			((sid) << 8 | ADC7_GPIO1_400K_PU)
+#define PM8350_ADC7_GPIO2_400K_PU(sid)			((sid) << 8 | ADC7_GPIO2_400K_PU)
+#define PM8350_ADC7_GPIO3_400K_PU(sid)			((sid) << 8 | ADC7_GPIO3_400K_PU)
+#define PM8350_ADC7_GPIO4_400K_PU(sid)			((sid) << 8 | ADC7_GPIO4_400K_PU)
 
 /* 1/3 Divider */
-#define PM8350_ADC7_GPIO4_DIV3(sid)			((sid) << 8 | 0x8d)
+#define PM8350_ADC7_GPIO4_DIV3(sid)			((sid) << 8 | ADC7_GPIO4_DIV3)
 
-#define PM8350_ADC7_VPH_PWR(sid)			((sid) << 8 | 0x8e)
+#define PM8350_ADC7_VPH_PWR(sid)			((sid) << 8 | ADC7_VPH_PWR)
 
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
index dc2497c27e16..57c7977666d3 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
@@ -10,79 +10,81 @@
 #define PM8350B_SID					3
 #endif
 
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+
 /* ADC channels for PM8350B_ADC for PMIC7 */
-#define PM8350B_ADC7_REF_GND			(PM8350B_SID << 8 | 0x0)
-#define PM8350B_ADC7_1P25VREF			(PM8350B_SID << 8 | 0x01)
-#define PM8350B_ADC7_VREF_VADC			(PM8350B_SID << 8 | 0x02)
-#define PM8350B_ADC7_DIE_TEMP			(PM8350B_SID << 8 | 0x03)
+#define PM8350B_ADC7_REF_GND			(PM8350B_SID << 8 | ADC7_REF_GND)
+#define PM8350B_ADC7_1P25VREF			(PM8350B_SID << 8 | ADC7_1P25VREF)
+#define PM8350B_ADC7_VREF_VADC			(PM8350B_SID << 8 | ADC7_VREF_VADC)
+#define PM8350B_ADC7_DIE_TEMP			(PM8350B_SID << 8 | ADC7_DIE_TEMP)
 
-#define PM8350B_ADC7_AMUX_THM1			(PM8350B_SID << 8 | 0x04)
-#define PM8350B_ADC7_AMUX_THM2			(PM8350B_SID << 8 | 0x05)
-#define PM8350B_ADC7_AMUX_THM3			(PM8350B_SID << 8 | 0x06)
-#define PM8350B_ADC7_AMUX_THM4			(PM8350B_SID << 8 | 0x07)
-#define PM8350B_ADC7_AMUX_THM5			(PM8350B_SID << 8 | 0x08)
-#define PM8350B_ADC7_AMUX_THM6			(PM8350B_SID << 8 | 0x09)
-#define PM8350B_ADC7_GPIO1			(PM8350B_SID << 8 | 0x0a)
-#define PM8350B_ADC7_GPIO2			(PM8350B_SID << 8 | 0x0b)
-#define PM8350B_ADC7_GPIO3			(PM8350B_SID << 8 | 0x0c)
-#define PM8350B_ADC7_GPIO4			(PM8350B_SID << 8 | 0x0d)
+#define PM8350B_ADC7_AMUX_THM1			(PM8350B_SID << 8 | ADC7_AMUX_THM1)
+#define PM8350B_ADC7_AMUX_THM2			(PM8350B_SID << 8 | ADC7_AMUX_THM2)
+#define PM8350B_ADC7_AMUX_THM3			(PM8350B_SID << 8 | ADC7_AMUX_THM3)
+#define PM8350B_ADC7_AMUX_THM4			(PM8350B_SID << 8 | ADC7_AMUX_THM4)
+#define PM8350B_ADC7_AMUX_THM5			(PM8350B_SID << 8 | ADC7_AMUX_THM5)
+#define PM8350B_ADC7_AMUX_THM6			(PM8350B_SID << 8 | ADC7_AMUX_THM6)
+#define PM8350B_ADC7_GPIO1			(PM8350B_SID << 8 | ADC7_GPIO1)
+#define PM8350B_ADC7_GPIO2			(PM8350B_SID << 8 | ADC7_GPIO2)
+#define PM8350B_ADC7_GPIO3			(PM8350B_SID << 8 | ADC7_GPIO3)
+#define PM8350B_ADC7_GPIO4			(PM8350B_SID << 8 | ADC7_GPIO4)
 
-#define PM8350B_ADC7_CHG_TEMP			(PM8350B_SID << 8 | 0x10)
-#define PM8350B_ADC7_USB_IN_V_16		(PM8350B_SID << 8 | 0x11)
-#define PM8350B_ADC7_VDC_16			(PM8350B_SID << 8 | 0x12)
-#define PM8350B_ADC7_CC1_ID			(PM8350B_SID << 8 | 0x13)
-#define PM8350B_ADC7_VREF_BAT_THERM		(PM8350B_SID << 8 | 0x15)
-#define PM8350B_ADC7_IIN_FB			(PM8350B_SID << 8 | 0x17)
+#define PM8350B_ADC7_CHG_TEMP			(PM8350B_SID << 8 | ADC7_CHG_TEMP)
+#define PM8350B_ADC7_USB_IN_V_16		(PM8350B_SID << 8 | ADC7_USB_IN_V_16)
+#define PM8350B_ADC7_VDC_16			(PM8350B_SID << 8 | ADC7_VDC_16)
+#define PM8350B_ADC7_CC1_ID			(PM8350B_SID << 8 | ADC7_CC1_ID)
+#define PM8350B_ADC7_VREF_BAT_THERM		(PM8350B_SID << 8 | ADC7_VREF_BAT_THERM)
+#define PM8350B_ADC7_IIN_FB			(PM8350B_SID << 8 | ADC7_IIN_FB)
 
 /* 30k pull-up1 */
-#define PM8350B_ADC7_AMUX_THM1_30K_PU		(PM8350B_SID << 8 | 0x24)
-#define PM8350B_ADC7_AMUX_THM2_30K_PU		(PM8350B_SID << 8 | 0x25)
-#define PM8350B_ADC7_AMUX_THM3_30K_PU		(PM8350B_SID << 8 | 0x26)
-#define PM8350B_ADC7_AMUX_THM4_30K_PU		(PM8350B_SID << 8 | 0x27)
-#define PM8350B_ADC7_AMUX_THM5_30K_PU		(PM8350B_SID << 8 | 0x28)
-#define PM8350B_ADC7_AMUX_THM6_30K_PU		(PM8350B_SID << 8 | 0x29)
-#define PM8350B_ADC7_GPIO1_30K_PU		(PM8350B_SID << 8 | 0x2a)
-#define PM8350B_ADC7_GPIO2_30K_PU		(PM8350B_SID << 8 | 0x2b)
-#define PM8350B_ADC7_GPIO3_30K_PU		(PM8350B_SID << 8 | 0x2c)
-#define PM8350B_ADC7_GPIO4_30K_PU		(PM8350B_SID << 8 | 0x2d)
-#define PM8350B_ADC7_CC1_ID_30K_PU		(PM8350B_SID << 8 | 0x33)
+#define PM8350B_ADC7_AMUX_THM1_30K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM1_30K_PU)
+#define PM8350B_ADC7_AMUX_THM2_30K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM2_30K_PU)
+#define PM8350B_ADC7_AMUX_THM3_30K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM3_30K_PU)
+#define PM8350B_ADC7_AMUX_THM4_30K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM4_30K_PU)
+#define PM8350B_ADC7_AMUX_THM5_30K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM5_30K_PU)
+#define PM8350B_ADC7_AMUX_THM6_30K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM6_30K_PU)
+#define PM8350B_ADC7_GPIO1_30K_PU		(PM8350B_SID << 8 | ADC7_GPIO1_30K_PU)
+#define PM8350B_ADC7_GPIO2_30K_PU		(PM8350B_SID << 8 | ADC7_GPIO2_30K_PU)
+#define PM8350B_ADC7_GPIO3_30K_PU		(PM8350B_SID << 8 | ADC7_GPIO3_30K_PU)
+#define PM8350B_ADC7_GPIO4_30K_PU		(PM8350B_SID << 8 | ADC7_GPIO4_30K_PU)
+#define PM8350B_ADC7_CC1_ID_30K_PU		(PM8350B_SID << 8 | ADC7_CC1_ID_30K_PU)
 
 /* 100k pull-up2 */
-#define PM8350B_ADC7_AMUX_THM1_100K_PU		(PM8350B_SID << 8 | 0x44)
-#define PM8350B_ADC7_AMUX_THM2_100K_PU		(PM8350B_SID << 8 | 0x45)
-#define PM8350B_ADC7_AMUX_THM3_100K_PU		(PM8350B_SID << 8 | 0x46)
-#define PM8350B_ADC7_AMUX_THM4_100K_PU		(PM8350B_SID << 8 | 0x47)
-#define PM8350B_ADC7_AMUX_THM5_100K_PU		(PM8350B_SID << 8 | 0x48)
-#define PM8350B_ADC7_AMUX_THM6_100K_PU		(PM8350B_SID << 8 | 0x49)
-#define PM8350B_ADC7_GPIO1_100K_PU		(PM8350B_SID << 8 | 0x4a)
-#define PM8350B_ADC7_GPIO2_100K_PU		(PM8350B_SID << 8 | 0x4b)
-#define PM8350B_ADC7_GPIO3_100K_PU		(PM8350B_SID << 8 | 0x4c)
-#define PM8350B_ADC7_GPIO4_100K_PU		(PM8350B_SID << 8 | 0x4d)
-#define PM8350B_ADC7_CC1_ID_100K_PU		(PM8350B_SID << 8 | 0x53)
+#define PM8350B_ADC7_AMUX_THM1_100K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM1_100K_PU)
+#define PM8350B_ADC7_AMUX_THM2_100K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM2_100K_PU)
+#define PM8350B_ADC7_AMUX_THM3_100K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM3_100K_PU)
+#define PM8350B_ADC7_AMUX_THM4_100K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM4_100K_PU)
+#define PM8350B_ADC7_AMUX_THM5_100K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM5_100K_PU)
+#define PM8350B_ADC7_AMUX_THM6_100K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM6_100K_PU)
+#define PM8350B_ADC7_GPIO1_100K_PU		(PM8350B_SID << 8 | ADC7_GPIO1_100K_PU)
+#define PM8350B_ADC7_GPIO2_100K_PU		(PM8350B_SID << 8 | ADC7_GPIO2_100K_PU)
+#define PM8350B_ADC7_GPIO3_100K_PU		(PM8350B_SID << 8 | ADC7_GPIO3_100K_PU)
+#define PM8350B_ADC7_GPIO4_100K_PU		(PM8350B_SID << 8 | ADC7_GPIO4_100K_PU)
+#define PM8350B_ADC7_CC1_ID_100K_PU		(PM8350B_SID << 8 | ADC7_CC1_ID_100K_PU)
 
 /* 400k pull-up3 */
-#define PM8350B_ADC7_AMUX_THM1_400K_PU		(PM8350B_SID << 8 | 0x64)
-#define PM8350B_ADC7_AMUX_THM2_400K_PU		(PM8350B_SID << 8 | 0x65)
-#define PM8350B_ADC7_AMUX_THM3_400K_PU		(PM8350B_SID << 8 | 0x66)
-#define PM8350B_ADC7_AMUX_THM4_400K_PU		(PM8350B_SID << 8 | 0x67)
-#define PM8350B_ADC7_AMUX_THM5_400K_PU		(PM8350B_SID << 8 | 0x68)
-#define PM8350B_ADC7_AMUX_THM6_400K_PU		(PM8350B_SID << 8 | 0x69)
-#define PM8350B_ADC7_GPIO1_400K_PU		(PM8350B_SID << 8 | 0x6a)
-#define PM8350B_ADC7_GPIO2_400K_PU		(PM8350B_SID << 8 | 0x6b)
-#define PM8350B_ADC7_GPIO3_400K_PU		(PM8350B_SID << 8 | 0x6c)
-#define PM8350B_ADC7_GPIO4_400K_PU		(PM8350B_SID << 8 | 0x6d)
-#define PM8350B_ADC7_CC1_ID_400K_PU		(PM8350B_SID << 8 | 0x73)
+#define PM8350B_ADC7_AMUX_THM1_400K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM1_400K_PU)
+#define PM8350B_ADC7_AMUX_THM2_400K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM2_400K_PU)
+#define PM8350B_ADC7_AMUX_THM3_400K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM3_400K_PU)
+#define PM8350B_ADC7_AMUX_THM4_400K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM4_400K_PU)
+#define PM8350B_ADC7_AMUX_THM5_400K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM5_400K_PU)
+#define PM8350B_ADC7_AMUX_THM6_400K_PU		(PM8350B_SID << 8 | ADC7_AMUX_THM6_400K_PU)
+#define PM8350B_ADC7_GPIO1_400K_PU		(PM8350B_SID << 8 | ADC7_GPIO1_400K_PU)
+#define PM8350B_ADC7_GPIO2_400K_PU		(PM8350B_SID << 8 | ADC7_GPIO2_400K_PU)
+#define PM8350B_ADC7_GPIO3_400K_PU		(PM8350B_SID << 8 | ADC7_GPIO3_400K_PU)
+#define PM8350B_ADC7_GPIO4_400K_PU		(PM8350B_SID << 8 | ADC7_GPIO4_400K_PU)
+#define PM8350B_ADC7_CC1_ID_400K_PU		(PM8350B_SID << 8 | ADC7_CC1_ID_400K_PU)
 
 /* 1/3 Divider */
-#define PM8350B_ADC7_GPIO1_DIV3			(PM8350B_SID << 8 | 0x8a)
-#define PM8350B_ADC7_GPIO2_DIV3			(PM8350B_SID << 8 | 0x8b)
-#define PM8350B_ADC7_GPIO3_DIV3			(PM8350B_SID << 8 | 0x8c)
-#define PM8350B_ADC7_GPIO4_DIV3			(PM8350B_SID << 8 | 0x8d)
+#define PM8350B_ADC7_GPIO1_DIV3			(PM8350B_SID << 8 | ADC7_GPIO1_DIV3)
+#define PM8350B_ADC7_GPIO2_DIV3			(PM8350B_SID << 8 | ADC7_GPIO2_DIV3)
+#define PM8350B_ADC7_GPIO3_DIV3			(PM8350B_SID << 8 | ADC7_GPIO3_DIV3)
+#define PM8350B_ADC7_GPIO4_DIV3			(PM8350B_SID << 8 | ADC7_GPIO4_DIV3)
 
-#define PM8350B_ADC7_VPH_PWR			(PM8350B_SID << 8 | 0x8e)
-#define PM8350B_ADC7_VBAT_SNS			(PM8350B_SID << 8 | 0x8f)
+#define PM8350B_ADC7_VPH_PWR			(PM8350B_SID << 8 | ADC7_VPH_PWR)
+#define PM8350B_ADC7_VBAT_SNS			(PM8350B_SID << 8 | ADC7_VBAT_SNS)
 
-#define PM8350B_ADC7_SBUx			(PM8350B_SID << 8 | 0x94)
-#define PM8350B_ADC7_VBAT_2S_MID		(PM8350B_SID << 8 | 0x96)
+#define PM8350B_ADC7_SBUx			(PM8350B_SID << 8 | ADC7_SBU)
+#define PM8350B_ADC7_VBAT_2S_MID		(PM8350B_SID << 8 | ADC7_VBAT_2S_MID)
 
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8350B_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
index 6c296870e95b..3d1a41a22cef 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
@@ -10,37 +10,39 @@
 #define PMK8350_SID					0
 #endif
 
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+
 /* ADC channels for PMK8350_ADC for PMIC7 */
-#define PMK8350_ADC7_REF_GND			(PMK8350_SID << 8 | 0x0)
-#define PMK8350_ADC7_1P25VREF			(PMK8350_SID << 8 | 0x01)
-#define PMK8350_ADC7_VREF_VADC			(PMK8350_SID << 8 | 0x02)
-#define PMK8350_ADC7_DIE_TEMP			(PMK8350_SID << 8 | 0x03)
+#define PMK8350_ADC7_REF_GND			(PMK8350_SID << 8 | ADC7_REF_GND)
+#define PMK8350_ADC7_1P25VREF			(PMK8350_SID << 8 | ADC7_1P25VREF)
+#define PMK8350_ADC7_VREF_VADC			(PMK8350_SID << 8 | ADC7_VREF_VADC)
+#define PMK8350_ADC7_DIE_TEMP			(PMK8350_SID << 8 | ADC7_DIE_TEMP)
 
-#define PMK8350_ADC7_AMUX_THM1			(PMK8350_SID << 8 | 0x04)
-#define PMK8350_ADC7_AMUX_THM2			(PMK8350_SID << 8 | 0x05)
-#define PMK8350_ADC7_AMUX_THM3			(PMK8350_SID << 8 | 0x06)
-#define PMK8350_ADC7_AMUX_THM4			(PMK8350_SID << 8 | 0x07)
-#define PMK8350_ADC7_AMUX_THM5			(PMK8350_SID << 8 | 0x08)
+#define PMK8350_ADC7_AMUX_THM1			(PMK8350_SID << 8 | ADC7_AMUX_THM1)
+#define PMK8350_ADC7_AMUX_THM2			(PMK8350_SID << 8 | ADC7_AMUX_THM2)
+#define PMK8350_ADC7_AMUX_THM3			(PMK8350_SID << 8 | ADC7_AMUX_THM3)
+#define PMK8350_ADC7_AMUX_THM4			(PMK8350_SID << 8 | ADC7_AMUX_THM4)
+#define PMK8350_ADC7_AMUX_THM5			(PMK8350_SID << 8 | ADC7_AMUX_THM5)
 
 /* 30k pull-up1 */
-#define PMK8350_ADC7_AMUX_THM1_30K_PU		(PMK8350_SID << 8 | 0x24)
-#define PMK8350_ADC7_AMUX_THM2_30K_PU		(PMK8350_SID << 8 | 0x25)
-#define PMK8350_ADC7_AMUX_THM3_30K_PU		(PMK8350_SID << 8 | 0x26)
-#define PMK8350_ADC7_AMUX_THM4_30K_PU		(PMK8350_SID << 8 | 0x27)
-#define PMK8350_ADC7_AMUX_THM5_30K_PU		(PMK8350_SID << 8 | 0x28)
+#define PMK8350_ADC7_AMUX_THM1_30K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM1_30K_PU)
+#define PMK8350_ADC7_AMUX_THM2_30K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM2_30K_PU)
+#define PMK8350_ADC7_AMUX_THM3_30K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM3_30K_PU)
+#define PMK8350_ADC7_AMUX_THM4_30K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM4_30K_PU)
+#define PMK8350_ADC7_AMUX_THM5_30K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM5_30K_PU)
 
 /* 100k pull-up2 */
-#define PMK8350_ADC7_AMUX_THM1_100K_PU		(PMK8350_SID << 8 | 0x44)
-#define PMK8350_ADC7_AMUX_THM2_100K_PU		(PMK8350_SID << 8 | 0x45)
-#define PMK8350_ADC7_AMUX_THM3_100K_PU		(PMK8350_SID << 8 | 0x46)
-#define PMK8350_ADC7_AMUX_THM4_100K_PU		(PMK8350_SID << 8 | 0x47)
-#define PMK8350_ADC7_AMUX_THM5_100K_PU		(PMK8350_SID << 8 | 0x48)
+#define PMK8350_ADC7_AMUX_THM1_100K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM1_100K_PU)
+#define PMK8350_ADC7_AMUX_THM2_100K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM2_100K_PU)
+#define PMK8350_ADC7_AMUX_THM3_100K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM3_100K_PU)
+#define PMK8350_ADC7_AMUX_THM4_100K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM4_100K_PU)
+#define PMK8350_ADC7_AMUX_THM5_100K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM5_100K_PU)
 
 /* 400k pull-up3 */
-#define PMK8350_ADC7_AMUX_THM1_400K_PU		(PMK8350_SID << 8 | 0x64)
-#define PMK8350_ADC7_AMUX_THM2_400K_PU		(PMK8350_SID << 8 | 0x65)
-#define PMK8350_ADC7_AMUX_THM3_400K_PU		(PMK8350_SID << 8 | 0x66)
-#define PMK8350_ADC7_AMUX_THM4_400K_PU		(PMK8350_SID << 8 | 0x67)
-#define PMK8350_ADC7_AMUX_THM5_400K_PU		(PMK8350_SID << 8 | 0x68)
+#define PMK8350_ADC7_AMUX_THM1_400K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM1_400K_PU)
+#define PMK8350_ADC7_AMUX_THM2_400K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM2_400K_PU)
+#define PMK8350_ADC7_AMUX_THM3_400K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM3_400K_PU)
+#define PMK8350_ADC7_AMUX_THM4_400K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM4_400K_PU)
+#define PMK8350_ADC7_AMUX_THM5_400K_PU		(PMK8350_SID << 8 | ADC7_AMUX_THM5_400K_PU)
 
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
index d6df1b19e5ff..c5adfa82b20d 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
@@ -10,19 +10,21 @@
 #define PMR735A_SID					4
 #endif
 
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+
 /* ADC channels for PMR735A_ADC for PMIC7 */
-#define PMR735A_ADC7_REF_GND			(PMR735A_SID << 8 | 0x0)
-#define PMR735A_ADC7_1P25VREF			(PMR735A_SID << 8 | 0x01)
-#define PMR735A_ADC7_VREF_VADC			(PMR735A_SID << 8 | 0x02)
-#define PMR735A_ADC7_DIE_TEMP			(PMR735A_SID << 8 | 0x03)
+#define PMR735A_ADC7_REF_GND			(PMR735A_SID << 8 | ADC7_REF_GND)
+#define PMR735A_ADC7_1P25VREF			(PMR735A_SID << 8 | ADC7_1P25VREF)
+#define PMR735A_ADC7_VREF_VADC			(PMR735A_SID << 8 | ADC7_VREF_VADC)
+#define PMR735A_ADC7_DIE_TEMP			(PMR735A_SID << 8 | ADC7_DIE_TEMP)
 
-#define PMR735A_ADC7_GPIO1			(PMR735A_SID << 8 | 0x0a)
-#define PMR735A_ADC7_GPIO2			(PMR735A_SID << 8 | 0x0b)
-#define PMR735A_ADC7_GPIO3			(PMR735A_SID << 8 | 0x0c)
+#define PMR735A_ADC7_GPIO1			(PMR735A_SID << 8 | ADC7_GPIO1)
+#define PMR735A_ADC7_GPIO2			(PMR735A_SID << 8 | ADC7_GPIO2)
+#define PMR735A_ADC7_GPIO3			(PMR735A_SID << 8 | ADC7_GPIO3)
 
 /* 100k pull-up2 */
-#define PMR735A_ADC7_GPIO1_100K_PU		(PMR735A_SID << 8 | 0x4a)
-#define PMR735A_ADC7_GPIO2_100K_PU		(PMR735A_SID << 8 | 0x4b)
-#define PMR735A_ADC7_GPIO3_100K_PU		(PMR735A_SID << 8 | 0x4c)
+#define PMR735A_ADC7_GPIO1_100K_PU		(PMR735A_SID << 8 | ADC7_GPIO1_100K_PU)
+#define PMR735A_ADC7_GPIO2_100K_PU		(PMR735A_SID << 8 | ADC7_GPIO2_100K_PU)
+#define PMR735A_ADC7_GPIO3_100K_PU		(PMR735A_SID << 8 | ADC7_GPIO3_100K_PU)
 
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMR735A_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
index 8da0e7dab315..fdb8dd9ae541 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
@@ -10,19 +10,21 @@
 #define PMR735B_SID					5
 #endif
 
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+
 /* ADC channels for PMR735B_ADC for PMIC7 */
-#define PMR735B_ADC7_REF_GND			(PMR735B_SID << 8 | 0x0)
-#define PMR735B_ADC7_1P25VREF			(PMR735B_SID << 8 | 0x01)
-#define PMR735B_ADC7_VREF_VADC			(PMR735B_SID << 8 | 0x02)
-#define PMR735B_ADC7_DIE_TEMP			(PMR735B_SID << 8 | 0x03)
+#define PMR735B_ADC7_REF_GND			(PMR735B_SID << 8 | ADC7_REF_GND)
+#define PMR735B_ADC7_1P25VREF			(PMR735B_SID << 8 | ADC7_1P25VREF)
+#define PMR735B_ADC7_VREF_VADC			(PMR735B_SID << 8 | ADC7_VREF_VADC)
+#define PMR735B_ADC7_DIE_TEMP			(PMR735B_SID << 8 | ADC7_DIE_TEMP)
 
-#define PMR735B_ADC7_GPIO1			(PMR735B_SID << 8 | 0x0a)
-#define PMR735B_ADC7_GPIO2			(PMR735B_SID << 8 | 0x0b)
-#define PMR735B_ADC7_GPIO3			(PMR735B_SID << 8 | 0x0c)
+#define PMR735B_ADC7_GPIO1			(PMR735B_SID << 8 | ADC7_GPIO1)
+#define PMR735B_ADC7_GPIO2			(PMR735B_SID << 8 | ADC7_GPIO2)
+#define PMR735B_ADC7_GPIO3			(PMR735B_SID << 8 | ADC7_GPIO3)
 
 /* 100k pull-up2 */
-#define PMR735B_ADC7_GPIO1_100K_PU		(PMR735B_SID << 8 | 0x4a)
-#define PMR735B_ADC7_GPIO2_100K_PU		(PMR735B_SID << 8 | 0x4b)
-#define PMR735B_ADC7_GPIO3_100K_PU		(PMR735B_SID << 8 | 0x4c)
+#define PMR735B_ADC7_GPIO1_100K_PU		(PMR735B_SID << 8 | ADC7_GPIO1_100K_PU)
+#define PMR735B_ADC7_GPIO2_100K_PU		(PMR735B_SID << 8 | ADC7_GPIO2_100K_PU)
+#define PMR735B_ADC7_GPIO3_100K_PU		(PMR735B_SID << 8 | ADC7_GPIO3_100K_PU)
 
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H */
-- 
2.40.1

