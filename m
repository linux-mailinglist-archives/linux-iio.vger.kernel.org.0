Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2502CE60A
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 03:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgLDC5A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 21:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgLDC47 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 21:56:59 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AC4C09424B
        for <linux-iio@vger.kernel.org>; Thu,  3 Dec 2020 18:55:28 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id o24so4933929ljj.6
        for <linux-iio@vger.kernel.org>; Thu, 03 Dec 2020 18:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TbaxkWpjDpXPcM4gWvdtbC6B2mUw4BwoNFySwAXVJoY=;
        b=MUN2KlBKwE/ZFqcY6YY86naBlLvOWN/xB4JONLIIXntfi+nuLMqGUvMP3ZyL9i0CHM
         m4I685Cov7CYlu60rF2y5QfcOP4s5UlgfT0Aoqn0esvFA0Of4e8XpKRue7b1Nd/nWj44
         3I3mNLhjCIpYwLqwwwc/nwm1GgTcToH2DDRY+F6ZJb7v/Zf5aYzHIdrSV8rut7iFmAv1
         LxIxWheiNQ0jY4JZfQeXptOvjgbQ+iOr9lpOwlK1g21QMw1oty9vXnAg6dSDHOg+PHn/
         CMvfQfkzltMhwLhmLy3Ij/zKeUWsWlakKgnKMg4godjpee7XwteUqY4bvNwvXCA2c6D3
         ErkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbaxkWpjDpXPcM4gWvdtbC6B2mUw4BwoNFySwAXVJoY=;
        b=OI0BZQ4KvnVLOTsB7r1yYrGloQHdcgBLnn7TV5PsiQRpKNZyd/8rNEbK+/X98w3hRO
         XGU5xcPuX7sMMOuMh/CgVuKtBAuu0Zm0ovgT0UAclTMEZ24fk4oyXhOHqWTmsgLS523k
         5Hl+XfoUAdpts+liGdXNyKa+JaIyYyJuKjCjfTpTsBAluBFk2zEdQLO4+yIH4y/uw8Ve
         ku46IRA5A3oxO8Ndvy2TN3bMMNmEkqdmHbgMab4qoVsw7cly03VomkUL/o0jadWHP4DP
         V0KddeFQtw6lmSldYcvJm7z+PYdaGc9S7RNWObLOIjmGxRB+p7AMHapctXvMh14j6s2x
         oQOg==
X-Gm-Message-State: AOAM532tyJgeIy94WVnUshOQ1cAkAEaZNluUPPi6SIncg4UPfqWHTfV1
        OBi/sDYfkauPM4Gj9b+7qovH4Q==
X-Google-Smtp-Source: ABdhPJy8wPELFRN6MlxCWi9UeLIegz/PTKwO1d5YIGJ0Gb5TPfRtq+zu6p7sA8wO2ASpOcaXbr6CZg==
X-Received: by 2002:a2e:9743:: with SMTP id f3mr209897ljj.110.1607050527226;
        Thu, 03 Dec 2020 18:55:27 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.64.117])
        by smtp.gmail.com with ESMTPSA id b8sm1131667ljo.68.2020.12.03.18.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 18:55:26 -0800 (PST)
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
Subject: [PATCH v10 05/15] iio: adc: move qcom-vadc-common.h to include dir
Date:   Fri,  4 Dec 2020 05:54:59 +0300
Message-Id: <20201204025509.1075506-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
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
2.29.2

