Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A9C288D1E
	for <lists+linux-iio@lfdr.de>; Fri,  9 Oct 2020 17:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbgJIPpV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Oct 2020 11:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389442AbgJIPpT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Oct 2020 11:45:19 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D996AC0613D2
        for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2020 08:45:18 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a9so11156734lfc.7
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2020 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppiJR77c+oyF2YPqQViuqav70ajnTqRX4XIvZy2HLv8=;
        b=yqYEPrXtJyHyKi78NpIfgz5NJR/HgrPDcP6uMGuIC4u0TUtMT4AA7NoczlaHwwX7B+
         pYJkQ5KsqWfwbWrk2k8FosS4kEM3ogb1vLag84mjjvdf0z1htGRt/g+DqFiK4WHjIThJ
         StqYkJTnYYV/14APbiQylu0L9ucP1PA079pi9rF4qfixfaXbwgNvTpJ7zz2duL8pRkSn
         vcnc7ohe5rh7HbDCDZ3mO/5NvgFmKdA68ASpGulzI19MGJKWU2jPpCYzQIBAZPhM69yD
         CtQwCTD/ST2FPLV4qfVyiKgPntjmK2Z4zWtlzKFYOKZkdn0Ww5yb5A+/3NbM+lSyfMHM
         Fdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppiJR77c+oyF2YPqQViuqav70ajnTqRX4XIvZy2HLv8=;
        b=dsa/jWiNZs/0sRoR4ueCUDQehUz6xv/mmbWgYt12z9PMl/KjYryFIynbEroXPWFcX/
         1D7XyPuGnrqKrygrlobzGZwlE1hRhB9VZMT0TIF9nQHSChoJrwkz85hK9wNDIsKvMk1U
         c2EWJ9BTJSj7QalUvQqGXeJNWMhjU3SwCdUzxUDbjrl6pCGxGFfKW2+0WTRHrvBg/QLT
         l/PzWQ224SY2dzYPsmWb361goiJ9u2A6uQGF9A3ijS8K4f2V/ABNY1F2z8zod/0AuzL1
         X1abzvE06VtRHLHk1vqgygn3jD7sPlxIwPA4icYhvwZq29/yB3wa9PFRszJW+0WUDrd3
         xfWA==
X-Gm-Message-State: AOAM532JDkAEpYdO/WZtTGfFR2/AqdgY6F58Ly3wDgfx4+kIln+VpbEk
        Wvc5LJSUQY60Z90HDceU1bZ59w==
X-Google-Smtp-Source: ABdhPJzv6xde0hahyKDw5usEElwUcSIYhD7oBaPoeyTWik0BrSxwu6tuUQAYfGKITywwCTiMOdhtfw==
X-Received: by 2002:a19:f245:: with SMTP id d5mr4100476lfk.97.1602258317288;
        Fri, 09 Oct 2020 08:45:17 -0700 (PDT)
Received: from eriador.lan ([188.162.65.231])
        by smtp.gmail.com with ESMTPSA id r4sm1505597lfc.162.2020.10.09.08.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:45:16 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Subject: [PATCH v8 05/11] iio: adc: move qcom-vadc-common.h to include dir
Date:   Fri,  9 Oct 2020 18:44:53 +0300
Message-Id: <20201009154459.106189-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009154459.106189-1-dmitry.baryshkov@linaro.org>
References: <20201009154459.106189-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

qcom-vadc-common module will be used by ADC thermal monitoring driver,
so move it to global include dir.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                   | 3 +--
 drivers/iio/adc/qcom-spmi-adc5.c                      | 2 +-
 drivers/iio/adc/qcom-spmi-vadc.c                      | 3 +--
 drivers/iio/adc/qcom-vadc-common.c                    | 3 +--
 {drivers => include/linux}/iio/adc/qcom-vadc-common.h | 2 ++
 5 files changed, 6 insertions(+), 7 deletions(-)
 rename {drivers => include/linux}/iio/adc/qcom-vadc-common.h (99%)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 7e108da7d255..0610bf254771 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -10,6 +10,7 @@
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
 
+#include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/module.h>
@@ -21,8 +22,6 @@
 #include <linux/interrupt.h>
 #include <linux/regulator/consumer.h>
 
-#include "qcom-vadc-common.h"
-
 /*
  * Definitions for the "user processor" registers lifted from the v3.4
  * Qualcomm tree. Their kernel has two out-of-tree drivers for the ADC:
diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index c2da8f068b87..b10a0fcf09dc 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -7,6 +7,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -19,7 +20,6 @@
 #include <linux/slab.h>
 
 #include <dt-bindings/iio/qcom,spmi-vadc.h>
-#include "qcom-vadc-common.h"
 
 #define ADC5_USR_REVISION1			0x0
 #define ADC5_USR_STATUS1			0x8
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index b0388f8a69f4..05ff948372b3 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -7,6 +7,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -20,8 +21,6 @@
 
 #include <dt-bindings/iio/qcom,spmi-vadc.h>
 
-#include "qcom-vadc-common.h"
-
 /* VADC register and bit definitions */
 #define VADC_REVISION2				0x1
 #define VADC_REVISION2_SUPPORTED_VADC		1
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 40d77b3af1bb..ee94774b72e6 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -3,14 +3,13 @@
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/fixp-arith.h>
+#include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/math64.h>
 #include <linux/log2.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/units.h>
 
-#include "qcom-vadc-common.h"
-
 /* Voltage to temperature */
 static const struct vadc_map_pt adcmap_100k_104ef_104fb[] = {
 	{1758,	-40},
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
similarity index 99%
rename from drivers/iio/adc/qcom-vadc-common.h
rename to include/linux/iio/adc/qcom-vadc-common.h
index 7e5f6428e311..03a9119edc71 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -6,6 +6,8 @@
 #ifndef QCOM_VADC_COMMON_H
 #define QCOM_VADC_COMMON_H
 
+#include <linux/types.h>
+
 #define VADC_CONV_TIME_MIN_US			2000
 #define VADC_CONV_TIME_MAX_US			2100
 
-- 
2.28.0

