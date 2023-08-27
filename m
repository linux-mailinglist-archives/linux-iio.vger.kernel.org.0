Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F7E789A31
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjH0BAF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjH0A7f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 20:59:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E3A1A6
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-500b3f7f336so688531e87.1
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693097970; x=1693702770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8FEcjdA8iNcOHwEq2cMCs8CLCGe5ZixaPNnhBx5vqg=;
        b=f6uwGQ4hDFi0Pmdlijpa8lFzm34nqUAU13nt6hfDeixzRv6HQ4SiVWoqBGveHAuqCB
         CpI+qE6yceK3ktlCCmFiLyeAsIHpASiGkCNVmsD499UynxpDHGTfcAbcoKHd6R7PLXA5
         JzEfdTmGpfKMRv00SPAxCOhWDhWI4L+0TeSmPYofxEucP3F5mmrSyyLLH4K/p9rRaoYJ
         YVjd8Wupre30Yx9X2BM1hjSwxAAD/67hsvxNCNaxB7uc03VhzyKDBFpIoyCP7ixDh3Ax
         XNmcwd8Lq2jebU9KpEmi61hQO6olRMMqA8i9/nJqidPMCTZP705BEzjJRlKj8B35gzuD
         L2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097970; x=1693702770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8FEcjdA8iNcOHwEq2cMCs8CLCGe5ZixaPNnhBx5vqg=;
        b=HD0G/DR3fduo4t25rTT8R1hi6GziEPIkkZ5uKS8c7VhuAIGMtCJRG1y9IJ6F+RPI5o
         Pv6myEiZ2F1ojRtqqy2I2LufOUb4l9zTBe43ejXrOgY8hkKAehr2Dl/hEts3bNKHTS7z
         6se+2EzQeOL1F5zLjP3MQQpkPK21dFJR3IlgUMsnYOWfkN3V22E4SkTdS/cththDmxQ6
         ZNeHi8/gd2mjGRJizvRn5pAKDZ3z9HLvY1fc1yhFv5HTuI/eTFNmxkmPZCM516UpxEsC
         Fs/+cH/4ditpk5/6wljNTyoFssV1S1l1AmCk9gLSJltP/mrSi8rKtHz2Xo8c/TBmSIaI
         sHsQ==
X-Gm-Message-State: AOJu0Yya3bLYyijQLSqTqUODCI5X2lYOklf0wgbeBsvFxeCoO6pT2u6M
        dTJXo1PI6zeCOjTxZNVirc2UBg==
X-Google-Smtp-Source: AGHT+IHPwuOqaomRjZv1/FFJmVE/kG09cahHy/NAvBPioUivIyhATL5M6ZMba3DIqb2lfuAHIjCCog==
X-Received: by 2002:ac2:562f:0:b0:4f8:4512:c844 with SMTP id b15-20020ac2562f000000b004f84512c844mr14804211lff.48.1693097970343;
        Sat, 26 Aug 2023 17:59:30 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.17.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:59:29 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
Subject: [PATCH v4 09/38] ARM: dts: qcom: strip prefix from PMIC files
Date:   Sun, 27 Aug 2023 03:58:51 +0300
Message-Id: <20230827005920.898719-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
References: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As the vendor DTS files were moved to per-vendor subdirs, there no need
to use common prefixes. Drop the `qcom-' prefix from PMIC dtsi file.
This makes 32-bit qcom/ dts files closer to arm64 ones.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/{qcom-pm8226.dtsi => pm8226.dtsi}      | 0
 arch/arm/boot/dts/qcom/{qcom-pm8841.dtsi => pm8841.dtsi}      | 0
 arch/arm/boot/dts/qcom/{qcom-pm8941.dtsi => pm8941.dtsi}      | 0
 arch/arm/boot/dts/qcom/{qcom-pma8084.dtsi => pma8084.dtsi}    | 0
 arch/arm/boot/dts/qcom/{qcom-pmx55.dtsi => pmx55.dtsi}        | 0
 arch/arm/boot/dts/qcom/{qcom-pmx65.dtsi => pmx65.dtsi}        | 0
 arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts          | 2 +-
 arch/arm/boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts       | 2 +-
 arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts              | 2 +-
 arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts  | 2 +-
 arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts           | 4 ++--
 arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts               | 2 +-
 arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts                   | 2 +-
 arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts | 4 ++--
 arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi    | 4 ++--
 arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts      | 4 ++--
 arch/arm/boot/dts/qcom/qcom-msm8974pro-oneplus-bacon.dts      | 4 ++--
 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts       | 2 +-
 .../dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts   | 4 ++--
 arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts                     | 2 +-
 arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts                     | 2 +-
 arch/arm/boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts         | 2 +-
 arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts                     | 2 +-
 23 files changed, 23 insertions(+), 23 deletions(-)
 rename arch/arm/boot/dts/qcom/{qcom-pm8226.dtsi => pm8226.dtsi} (100%)
 rename arch/arm/boot/dts/qcom/{qcom-pm8841.dtsi => pm8841.dtsi} (100%)
 rename arch/arm/boot/dts/qcom/{qcom-pm8941.dtsi => pm8941.dtsi} (100%)
 rename arch/arm/boot/dts/qcom/{qcom-pma8084.dtsi => pma8084.dtsi} (100%)
 rename arch/arm/boot/dts/qcom/{qcom-pmx55.dtsi => pmx55.dtsi} (100%)
 rename arch/arm/boot/dts/qcom/{qcom-pmx65.dtsi => pmx65.dtsi} (100%)

diff --git a/arch/arm/boot/dts/qcom/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom/pm8226.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom/qcom-pm8226.dtsi
rename to arch/arm/boot/dts/qcom/pm8226.dtsi
diff --git a/arch/arm/boot/dts/qcom/qcom-pm8841.dtsi b/arch/arm/boot/dts/qcom/pm8841.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom/qcom-pm8841.dtsi
rename to arch/arm/boot/dts/qcom/pm8841.dtsi
diff --git a/arch/arm/boot/dts/qcom/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom/pm8941.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom/qcom-pm8941.dtsi
rename to arch/arm/boot/dts/qcom/pm8941.dtsi
diff --git a/arch/arm/boot/dts/qcom/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom/pma8084.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom/qcom-pma8084.dtsi
rename to arch/arm/boot/dts/qcom/pma8084.dtsi
diff --git a/arch/arm/boot/dts/qcom/qcom-pmx55.dtsi b/arch/arm/boot/dts/qcom/pmx55.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom/qcom-pmx55.dtsi
rename to arch/arm/boot/dts/qcom/pmx55.dtsi
diff --git a/arch/arm/boot/dts/qcom/qcom-pmx65.dtsi b/arch/arm/boot/dts/qcom/pmx65.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom/qcom-pmx65.dtsi
rename to arch/arm/boot/dts/qcom/pmx65.dtsi
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts
index aa0e0e8d2a97..a39f5a161b03 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts
@@ -6,7 +6,7 @@
 /dts-v1/;
 
 #include "qcom-msm8226.dtsi"
-#include "qcom-pm8226.dtsi"
+#include "pm8226.dtsi"
 
 /delete-node/ &adsp_region;
 
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts
index de19640efe55..59b218042d32 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts
@@ -6,7 +6,7 @@
 /dts-v1/;
 
 #include "qcom-msm8226.dtsi"
-#include "qcom-pm8226.dtsi"
+#include "pm8226.dtsi"
 #include <dt-bindings/input/ti-drv260x.h>
 
 /delete-node/ &adsp_region;
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts
index b887e5361ec3..feb78afef3a6 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts
@@ -6,7 +6,7 @@
 /dts-v1/;
 
 #include "qcom-msm8226.dtsi"
-#include "qcom-pm8226.dtsi"
+#include "pm8226.dtsi"
 
 /delete-node/ &adsp_region;
 
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
index 884d99297d4c..42d3867dca42 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
@@ -7,7 +7,7 @@
 
 #include <dt-bindings/input/input.h>
 #include "qcom-msm8226.dtsi"
-#include "qcom-pm8226.dtsi"
+#include "pm8226.dtsi"
 
 /delete-node/ &adsp_region;
 /delete-node/ &smem_region;
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts
index 6d1b2439ae3a..950fa652f985 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts
@@ -4,8 +4,8 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include "qcom-msm8974.dtsi"
-#include "qcom-pm8841.dtsi"
-#include "qcom-pm8941.dtsi"
+#include "pm8841.dtsi"
+#include "pm8941.dtsi"
 
 /delete-node/ &mpss_region;
 
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts b/arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts
index 116e59a3b76d..1df24c922be9 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-apq8084.dtsi"
-#include "qcom-pma8084.dtsi"
+#include "pma8084.dtsi"
 
 / {
 	model = "Qualcomm APQ8084/IFC6540";
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts b/arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts
index c6b6680248a6..d4e6aee034af 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-apq8084.dtsi"
-#include "qcom-pma8084.dtsi"
+#include "pma8084.dtsi"
 
 / {
 	model = "Qualcomm APQ 8084-MTP";
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
index 60bdfddeae69..da99f770d4f5 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-msm8974.dtsi"
-#include "qcom-pm8841.dtsi"
-#include "qcom-pm8941.dtsi"
+#include "pm8841.dtsi"
+#include "pm8941.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi
index 68a2f9094e53..23ae474698aa 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-msm8974.dtsi"
-#include "qcom-pm8841.dtsi"
-#include "qcom-pm8941.dtsi"
+#include "pm8841.dtsi"
+#include "pm8941.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts
index 42d253b75dad..6c4153689b39 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-msm8974pro.dtsi"
-#include "qcom-pm8841.dtsi"
-#include "qcom-pm8941.dtsi"
+#include "pm8841.dtsi"
+#include "pm8941.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-oneplus-bacon.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-oneplus-bacon.dts
index 8230d0e1d95d..c0ca264d8140 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-oneplus-bacon.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-oneplus-bacon.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-msm8974pro.dtsi"
-#include "qcom-pm8841.dtsi"
-#include "qcom-pm8941.dtsi"
+#include "pm8841.dtsi"
+#include "pm8941.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
index 3e2c86591ee2..325feb89b343 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-msm8974pro.dtsi"
-#include "qcom-pma8084.dtsi"
+#include "pma8084.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/leds/common.h>
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 11468d1409f7..0798cce3dbea 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-msm8974pro.dtsi"
-#include "qcom-pm8841.dtsi"
-#include "qcom-pm8941.dtsi"
+#include "pm8841.dtsi"
+#include "pm8941.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts b/arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts
index 7e97ad5803d8..247069361909 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts
@@ -9,7 +9,7 @@
 #include "qcom-sdx55.dtsi"
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <arm64/qcom/pm8150b.dtsi>
-#include "qcom-pmx55.dtsi"
+#include "pmx55.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SDX55 MTP";
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts b/arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts
index 51058b065279..082f7ed1a01f 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts
@@ -8,7 +8,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "qcom-sdx55.dtsi"
-#include "qcom-pmx55.dtsi"
+#include "pmx55.dtsi"
 
 / {
 	model = "Thundercomm T55 Development Kit";
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts b/arch/arm/boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts
index 8fadc6e70692..e336a15b45c4 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts
@@ -8,7 +8,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "qcom-sdx55.dtsi"
-#include "qcom-pmx55.dtsi"
+#include "pmx55.dtsi"
 
 / {
 	model = "Telit FN980 TLB";
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
index fcf1c51c5e7a..b87c5434cc29 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
@@ -8,7 +8,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <arm64/qcom/pmk8350.dtsi>
 #include <arm64/qcom/pm7250b.dtsi>
-#include "qcom-pmx65.dtsi"
+#include "pmx65.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SDX65 MTP";
-- 
2.39.2

