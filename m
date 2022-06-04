Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B6753D78A
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 17:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbiFDPoP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 11:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbiFDPoO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 11:44:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED4419C2D
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 08:44:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4318DB806A0
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 15:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D95C34119;
        Sat,  4 Jun 2022 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654357451;
        bh=WhP5+yG4rdIykK8aRzDv4rVYdTLb/IFOv+aB+1LnEXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghsl96wMGRjrD/kz48Ua9drQh1PKwp/eH5CjsPamfMwxvR6TLuKw+eeBazNKyBpQE
         56rX6A9RgLi4EFGCqF9VQD5eiu+9vLNEt6kfDFuNTaGWDzU8nZIri3HOBu2wIycqcv
         oTBsyRaA7JLzfzzz+PSuUc4LOg96zHpdv5ZTmVUy1MH1vt4odm1W8MZ4qD2to2dsL3
         BO1IeqrgIpDnfYmySvazYfCxODewivbiGBzunPQ1riBP4FOBl7OOzQueelWPYvJZNR
         LgoDE2LXP02gDCI8GKIlBu9r/caQaZI6uVYqkMl7J2zPRv1H2URfkVa0/TrIRbFT0T
         dTrDSHNqdmc2w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: [PATCH v2 4/4] iio: adc: qcom-vadc: Move symbol exports to IIO_QCOM_VADC namespace
Date:   Sat,  4 Jun 2022 16:53:06 +0100
Message-Id: <20220604155306.422937-5-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220604155306.422937-1-jic23@kernel.org>
References: <20220604155306.422937-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Link: https://lore.kernel.org/r/20220220173701.502331-6-jic23@kernel.org
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
index d5209f32adb3..7ca191ea1a65 100644
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
 
 u16 qcom_adc_tm5_gen2_temp_res_scale(int temp)
 {
@@ -704,7 +704,7 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 	return scale_adc5_fn[scaletype].scale_fn(prescale, data,
 					adc_code, result);
 }
-EXPORT_SYMBOL(qcom_adc5_hw_scale);
+EXPORT_SYMBOL_NS(qcom_adc5_hw_scale, IIO_QCOM_VADC);
 
 int qcom_adc5_prescaling_from_dt(u32 numerator, u32 denominator)
 {
@@ -720,7 +720,7 @@ int qcom_adc5_prescaling_from_dt(u32 numerator, u32 denominator)
 
 	return pre;
 }
-EXPORT_SYMBOL(qcom_adc5_prescaling_from_dt);
+EXPORT_SYMBOL_NS(qcom_adc5_prescaling_from_dt, IIO_QCOM_VADC);
 
 int qcom_adc5_hw_settle_time_from_dt(u32 value,
 				     const unsigned int *hw_settle)
@@ -734,7 +734,7 @@ int qcom_adc5_hw_settle_time_from_dt(u32 value,
 
 	return -EINVAL;
 }
-EXPORT_SYMBOL(qcom_adc5_hw_settle_time_from_dt);
+EXPORT_SYMBOL_NS(qcom_adc5_hw_settle_time_from_dt, IIO_QCOM_VADC);
 
 int qcom_adc5_avg_samples_from_dt(u32 value)
 {
@@ -743,7 +743,7 @@ int qcom_adc5_avg_samples_from_dt(u32 value)
 
 	return __ffs(value);
 }
-EXPORT_SYMBOL(qcom_adc5_avg_samples_from_dt);
+EXPORT_SYMBOL_NS(qcom_adc5_avg_samples_from_dt, IIO_QCOM_VADC);
 
 int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation)
 {
@@ -756,7 +756,7 @@ int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation)
 
 	return -EINVAL;
 }
-EXPORT_SYMBOL(qcom_adc5_decimation_from_dt);
+EXPORT_SYMBOL_NS(qcom_adc5_decimation_from_dt, IIO_QCOM_VADC);
 
 int qcom_vadc_decimation_from_dt(u32 value)
 {
@@ -766,7 +766,7 @@ int qcom_vadc_decimation_from_dt(u32 value)
 
 	return __ffs64(value / VADC_DECIMATION_MIN);
 }
-EXPORT_SYMBOL(qcom_vadc_decimation_from_dt);
+EXPORT_SYMBOL_NS(qcom_vadc_decimation_from_dt, IIO_QCOM_VADC);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Qualcomm ADC common functionality");
-- 
2.36.1

