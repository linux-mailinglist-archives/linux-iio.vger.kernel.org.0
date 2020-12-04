Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9042CE610
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 03:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgLDC5J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 21:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLDC5J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 21:57:09 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5605EC094258
        for <linux-iio@vger.kernel.org>; Thu,  3 Dec 2020 18:55:36 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id q13so5708789lfr.10
        for <linux-iio@vger.kernel.org>; Thu, 03 Dec 2020 18:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TWDLud9pksRg9HazTAZv15V734bI01T2Ycit6ziYb2Y=;
        b=LWgQGT9gwFAhiUltNIB3UaJlXzNe24yhRqXaSgwz9KmOyj9dMStWph5NO/Ay9L7Sfz
         YOugXj1f3n3H7CiDk3629wNruxOE+QUMRxgd0QA1Q5uRocA9ncPWJhp843AwO0d30DEs
         NfACj5Ki62es8b7B3Y3jUIA/eprunRWuySkzqqxc5cKMrvGXAbg27OKixruCfbVnX20r
         DdJRURWDMPCLle/4WSvrOM58qF4RZYxdtj4QZbqxUB7JXA+aQvhId6OtmRZ6YWC5Ogek
         hDKZ+IiXj4lWIur1AZt1uXHpGONpRvbXlnBpYpoO6yZddnVF/FxBYiNjWigwGKycuYsk
         8fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TWDLud9pksRg9HazTAZv15V734bI01T2Ycit6ziYb2Y=;
        b=nmTnSSV+54dR3qpOJxtSv3G78UTCsmjCytWxorwKUB9yjHiKbZTHdBRyRKqmod/3zM
         5T+QoQTksou1VVKib3McHtkS653llNLq6OR0QF4VnlglRHP51cnoeM6WhiB9lmoVlJqr
         rVDkLj2h1nBx/UnEXytLBOrga5L4AInaSixi8UWcsB+1qYktlWbYOKe3/4LFCwZFiQdP
         r1lDGxYiiDLFFm4w0SfbBWP0Gf0QTKCWOEfojFdgvOoqMzCVdDTH6I9JSkFtvwPH9gF7
         hDqU1Y6ekx+PWY4U5/mySAmFQLpo7b91nIXutiMdFLh/xgViLwG5XSusWAOcz5+eL1+0
         UxfA==
X-Gm-Message-State: AOAM531htRnCItL5svr6ZQ/80vFP/hpMdiggnyfneWjhtJP+Y2MUXbHj
        wiGAv8emR9L2vEE6Sm6JNPoKZg==
X-Google-Smtp-Source: ABdhPJz921qUVfZaQWKaA0aJ8EMgr+akoEG6gjaINvBRK8PttaOsNaV+x5312bcho3WcypquqrM3dw==
X-Received: by 2002:a05:6512:3453:: with SMTP id j19mr2446184lfr.182.1607050534867;
        Thu, 03 Dec 2020 18:55:34 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.64.117])
        by smtp.gmail.com with ESMTPSA id b8sm1131667ljo.68.2020.12.03.18.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 18:55:34 -0800 (PST)
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
Subject: [PATCH v10 08/15] iio: adc: move vadc_map_pt from header to the source file
Date:   Fri,  4 Dec 2020 05:55:02 +0300
Message-Id: <20201204025509.1075506-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

struct vadc_map_pt is not used outside of qcom-vadc-common.c, so move it
there from the global header file.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iio/adc/qcom-vadc-common.c       | 11 +++++++++++
 include/linux/iio/adc/qcom-vadc-common.h | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index ee94774b72e6..45a38602f66a 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -10,6 +10,17 @@
 #include <linux/module.h>
 #include <linux/units.h>
 
+/**
+ * struct vadc_map_pt - Map the graph representation for ADC channel
+ * @x: Represent the ADC digitized code.
+ * @y: Represent the physical data which can be temperature, voltage,
+ *     resistance.
+ */
+struct vadc_map_pt {
+	s32 x;
+	s32 y;
+};
+
 /* Voltage to temperature */
 static const struct vadc_map_pt adcmap_100k_104ef_104fb[] = {
 	{1758,	-40},
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index 03a9119edc71..1d337dd9e3dc 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -59,17 +59,6 @@
 #define DIE_TEMP_ADC7_SCALE_FACTOR		1000
 #define DIE_TEMP_ADC7_MAX			160000
 
-/**
- * struct vadc_map_pt - Map the graph representation for ADC channel
- * @x: Represent the ADC digitized code.
- * @y: Represent the physical data which can be temperature, voltage,
- *     resistance.
- */
-struct vadc_map_pt {
-	s32 x;
-	s32 y;
-};
-
 /*
  * VADC_CALIB_ABSOLUTE: uses the 625mV and 1.25V as reference channels.
  * VADC_CALIB_RATIOMETRIC: uses the reference voltage (1.8V) and GND for
-- 
2.29.2

