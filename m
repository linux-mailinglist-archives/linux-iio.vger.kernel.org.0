Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D03B4BD040
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 18:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbiBTRay (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 12:30:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbiBTRax (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 12:30:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AAE2409F
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 09:30:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF540B80DB0
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 17:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDB1C340EB;
        Sun, 20 Feb 2022 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645378229;
        bh=2Q1WQqPEb51EhppeKb6LMVPA5TBZs5WyqYWOwAtgUXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tm4BY2RYnPXbjzN9YORlQaQkSDxpL6DFHSwgaVeSFnHsPeSbWc+kWHcfLF01dwIAg
         FULqUI5HXneXc6ZhLOEvmDDGEpXg1u3kXGu/3J/+7lcuC+41A1EsrscIlr81IEg8Xf
         Pni4MrfOJOOEPGeuD1tD1Q/N/T0wlQ6AFhRh3Gjr/W7cB3a4RYa9xuIASm4AQuUaQ/
         F6SE4HGyHdY8lOB1NWkHft8A4cFQg++Gp22FJyvNiQBkvP/9Bf+0/271rxeHqXfTMe
         6AB+MMfZP21+YKIcfamVFoBXAUQrsCQh1/6kQgiSmisE2ZEbgNbjpgOE+j0ixBsrNI
         HwDPGFvaxxzeQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: [PATCH 5/5] iio: adc: qcom-vadc: Move symbol exports to IIO_QCOM_VADC namespace
Date:   Sun, 20 Feb 2022 17:37:01 +0000
Message-Id: <20220220173701.502331-6-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220173701.502331-1-jic23@kernel.org>
References: <20220220173701.502331-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Avoid unnecessary pollution of the global symbol namespace by
moving library functions in to a specific namespace and import
that into the drivers that make use of the functions.

For more info: https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c |  1 +
 drivers/iio/adc/qcom-spmi-adc5.c    |  1 +
 drivers/iio/adc/qcom-spmi-vadc.c    |  1 +
 drivers/iio/adc/qcom-vadc-common.c  | 16 ++++++++--------
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 5e9e56821075..e2ef89dcaa5e 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -1028,3 +1028,4 @@ module_platform_driver(pm8xxx_xoadc_driver);
 MODULE_DESCRIPTION("PM8xxx XOADC driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:pm8xxx-xoadc");
+MODULE_IMPORT_NS(IIO_QCOM_VADC);
diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 87438d1e5c0b..10bb51b648c1 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -925,3 +925,4 @@ module_platform_driver(adc5_driver);
 MODULE_ALIAS("platform:qcom-spmi-adc5");
 MODULE_DESCRIPTION("Qualcomm Technologies Inc. PMIC5 ADC driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_QCOM_VADC);
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 34202ba52469..cb0c6af091ac 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -935,3 +935,4 @@ MODULE_DESCRIPTION("Qualcomm SPMI PMIC voltage ADC driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Stanimir Varbanov <svarbanov@mm-sol.com>");
 MODULE_AUTHOR("Ivan T. Ivanov <iivanov@mm-sol.com>");
+MODULE_IMPORT_NS(IIO_QCOM_VADC);
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 6c6aec848f98..e1ff2ac309fd 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -662,7 +662,7 @@ int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
 		return -EINVAL;
 	}
 }
-EXPORT_SYMBOL(qcom_vadc_scale);
+EXPORT_SYMBOL_NS(qcom_vadc_scale, IIO_QCOM_VADC);
 
 u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
 				 u32 full_scale_code_volt, int temp)
@@ -675,7 +675,7 @@ u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
 					     temp);
 	return qcom_vadc_scale_voltage_code(voltage, prescale, full_scale_code_volt, 1000);
 }
-EXPORT_SYMBOL(qcom_adc_tm5_temp_volt_scale);
+EXPORT_SYMBOL_NS(qcom_adc_tm5_temp_volt_scale, IIO_QCOM_VADC);
 
 int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 		    unsigned int prescale_ratio,
@@ -693,7 +693,7 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 	return scale_adc5_fn[scaletype].scale_fn(prescale, data,
 					adc_code, result);
 }
-EXPORT_SYMBOL(qcom_adc5_hw_scale);
+EXPORT_SYMBOL_NS(qcom_adc5_hw_scale, IIO_QCOM_VADC);
 
 int qcom_adc5_prescaling_from_dt(u32 numerator, u32 denominator)
 {
@@ -709,7 +709,7 @@ int qcom_adc5_prescaling_from_dt(u32 numerator, u32 denominator)
 
 	return pre;
 }
-EXPORT_SYMBOL(qcom_adc5_prescaling_from_dt);
+EXPORT_SYMBOL_NS(qcom_adc5_prescaling_from_dt, IIO_QCOM_VADC);
 
 int qcom_adc5_hw_settle_time_from_dt(u32 value,
 				     const unsigned int *hw_settle)
@@ -723,7 +723,7 @@ int qcom_adc5_hw_settle_time_from_dt(u32 value,
 
 	return -EINVAL;
 }
-EXPORT_SYMBOL(qcom_adc5_hw_settle_time_from_dt);
+EXPORT_SYMBOL_NS(qcom_adc5_hw_settle_time_from_dt, IIO_QCOM_VADC);
 
 int qcom_adc5_avg_samples_from_dt(u32 value)
 {
@@ -732,7 +732,7 @@ int qcom_adc5_avg_samples_from_dt(u32 value)
 
 	return __ffs(value);
 }
-EXPORT_SYMBOL(qcom_adc5_avg_samples_from_dt);
+EXPORT_SYMBOL_NS(qcom_adc5_avg_samples_from_dt, IIO_QCOM_VADC);
 
 int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation)
 {
@@ -745,7 +745,7 @@ int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation)
 
 	return -EINVAL;
 }
-EXPORT_SYMBOL(qcom_adc5_decimation_from_dt);
+EXPORT_SYMBOL_NS(qcom_adc5_decimation_from_dt, IIO_QCOM_VADC);
 
 int qcom_vadc_decimation_from_dt(u32 value)
 {
@@ -755,7 +755,7 @@ int qcom_vadc_decimation_from_dt(u32 value)
 
 	return __ffs64(value / VADC_DECIMATION_MIN);
 }
-EXPORT_SYMBOL(qcom_vadc_decimation_from_dt);
+EXPORT_SYMBOL_NS(qcom_vadc_decimation_from_dt, IIO_QCOM_VADC);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Qualcomm ADC common functionality");
-- 
2.35.1

