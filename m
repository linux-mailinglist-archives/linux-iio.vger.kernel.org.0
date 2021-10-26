Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA74C43B66C
	for <lists+linux-iio@lfdr.de>; Tue, 26 Oct 2021 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhJZQHu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Oct 2021 12:07:50 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:23519 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbhJZQHt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Oct 2021 12:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635264326; x=1666800326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tje8IEEvCcP9ar0S+SDdDQsnr/Zfk8KvTeqaAC5rzVU=;
  b=TwRpLPB7MrDJrz88ps3iR6RHfJYUKr8B0Wme9ZJMkYQN+RD6ysAEJ4DI
   8FofQKuDXJKkwZSazn0HrGgtUKqF8lcVyqoRj0ziWmvH9lJH6ZMHkjKv5
   dx2gcOwFYaYBVD/gjyc7yDAobLXWcRHlQMVtQRPXLYKKEVMP0HXSsGrFG
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 09:05:26 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 09:05:24 -0700
Received: from jprakash-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 26 Oct 2021 09:05:16 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <jic23@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <amitk@kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH V2 2/3] iio: adc: qcom-vadc-common: add reverse scaling for PMIC5 Gen2 ADC_TM
Date:   Tue, 26 Oct 2021 21:34:34 +0530
Message-ID: <1635264275-12530-3-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635264275-12530-1-git-send-email-quic_jprakash@quicinc.com>
References: <1635264275-12530-1-git-send-email-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add reverse scaling function for PMIC5 Gen2 ADC_TM, to convert
temperature to raw ADC code, for setting thresholds for
thermistor channels.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 drivers/iio/adc/qcom-vadc-common.c       | 11 +++++++++++
 include/linux/iio/adc/qcom-vadc-common.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 1472389..194d7c3 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -677,6 +677,17 @@ u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
 }
 EXPORT_SYMBOL(qcom_adc_tm5_temp_volt_scale);
 
+u16 qcom_adc_tm5_gen2_temp_res_scale(int temp)
+{
+	int64_t resistance;
+
+	resistance = qcom_vadc_map_temp_voltage(adcmap7_100k,
+		ARRAY_SIZE(adcmap7_100k), temp);
+
+	return div64_s64(resistance * RATIO_MAX_ADC7, resistance + R_PU_100K);
+}
+EXPORT_SYMBOL(qcom_adc_tm5_gen2_temp_res_scale);
+
 int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 		    unsigned int prescale_ratio,
 		    const struct adc5_data *data,
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index 33f60f4..598a5d2 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -161,6 +161,8 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
 				 u32 full_scale_code_volt, int temp);
 
+u16 qcom_adc_tm5_gen2_temp_res_scale(int temp);
+
 int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
 
 int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);
-- 
2.7.4

