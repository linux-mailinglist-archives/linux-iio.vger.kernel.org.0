Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C486D2A3227
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 18:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKBRuW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 12:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgKBRuW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 12:50:22 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89147C061A47
        for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2020 09:50:20 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 184so18533073lfd.6
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2020 09:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/8nUrtMEkOs+nNjTU7M7xtBvq6u2BtnvtGU1K8TBpfU=;
        b=SiQfg9doy1WOleW9vdZzg8I7sLDsFf8zbZcXiJfwAP9rrRPeESVD31+MP3JIqcjj7Y
         HhMSFQ/6eC8CfcwwPsrAHy9TrNuf/A845w8bD/1PWygKQN2O1TtB6+9c2TWnve1PWeOk
         MaGlCW+MdZXFzlZwM2zLOzPetzC61T/hfeQmPeHeCinKaXP5jSs3xQ/T2AuEJ4XxRwgZ
         j52qzWpOup9YeCAxmDjn/xIUXCm/uFt6C11Xxc2aeuSn0YtUNYhcU+WbiS6m5r0FsjAx
         DqOUcrdHtjtJePvLXgcuCs4D2IMiAvXDMx0BwhPujLvPt39KGY/tx1hAbR6IrI6yhnCU
         x/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8nUrtMEkOs+nNjTU7M7xtBvq6u2BtnvtGU1K8TBpfU=;
        b=gHbzmj1M1vdy1qDUJAZeihuOIde6RlZL6iU8Kbo2DCwTozLjMRAZUMFGGgk8JufG1n
         CL2F1WvQeK26FPpMIbPIihEXFAFNqDFE3PCkNHbtqyopjf99U3EaPLxu2ho6kGngDAAU
         4ZBxTtbMnIPa1X20HMMyuiNytW1QdlBAk6HlfzD/YuQBAJMeiDbgn45aUXvHX7ZctrfX
         bN6Q6vbff73X1u/UjZzxJ7wu24X1g2XLEHts+7OlrGLE/iEY5BdWwPGp+Q40c3XY5Cqh
         KPC8ZhJz12RFxy86Unc5PSCXLWsirHAiidolJH1+R1BpVQW61ydeBkszmyuWSv3ODBd0
         2fNg==
X-Gm-Message-State: AOAM532tQ00rd6/q5cohE92dUw/Tib6Eq2ZWWh7o2s81KdyXqmDVD2/1
        3H/4lmgSdj6LyZlGC7h9ZChtUQ==
X-Google-Smtp-Source: ABdhPJxvXBK3suAuAQAMHqFELbgGp6R0OpsDJio18AUiHzrdbgVwNBaV2w+h7KHynNTs/rL6rnNfNg==
X-Received: by 2002:a19:8a83:: with SMTP id m125mr6536962lfd.169.1604339419026;
        Mon, 02 Nov 2020 09:50:19 -0800 (PST)
Received: from eriador.lan ([94.25.229.254])
        by smtp.gmail.com with ESMTPSA id r7sm2516163lfc.206.2020.11.02.09.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:50:18 -0800 (PST)
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
Subject: [PATCH v9 09/15] iio: adc: qcom-vadc-common: rewrite vadc7 die temp calculation
Date:   Mon,  2 Nov 2020 20:49:44 +0300
Message-Id: <20201102174950.1148498-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
References: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

qcom_vadc7_scale_hw_calib_die_temp() uses a table format different from
the rest of volt/temp conversion functions in this file. Also the
conversion functions results in non-monothonic values conversion, which
seems wrong.

Rewrite qcom_vadc7_scale_hw_calib_die_temp() to use
qcom_vadc_map_voltage_temp() directly, like the rest of conversion
functions do.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iio/adc/qcom-vadc-common.c       | 50 +++++++-----------------
 include/linux/iio/adc/qcom-vadc-common.h |  5 ---
 2 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 45a38602f66a..0c705bb473fe 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -101,18 +101,18 @@ static const struct vadc_map_pt adcmap_100k_104ef_104fb_1875_vref[] = {
 };
 
 static const struct vadc_map_pt adcmap7_die_temp[] = {
-	{ 433700, 1967},
-	{ 473100, 1964},
-	{ 512400, 1957},
-	{ 551500, 1949},
-	{ 590500, 1940},
-	{ 629300, 1930},
-	{ 667900, 1921},
-	{ 706400, 1910},
-	{ 744600, 1896},
-	{ 782500, 1878},
-	{ 820100, 1859},
-	{ 857300, 0},
+	{ 857300, 160000 },
+	{ 820100, 140000 },
+	{ 782500, 120000 },
+	{ 744600, 100000 },
+	{ 706400, 80000 },
+	{ 667900, 60000 },
+	{ 629300, 40000 },
+	{ 590500, 20000 },
+	{ 551500, 0 },
+	{ 512400, -20000 },
+	{ 473100, -40000 },
+	{ 433700, -60000 },
 };
 
 /*
@@ -585,33 +585,13 @@ static int qcom_vadc7_scale_hw_calib_die_temp(
 				u16 adc_code, int *result_mdec)
 {
 
-	int voltage, vtemp0, temp, i;
+	int voltage;
 
 	voltage = qcom_vadc_scale_code_voltage_factor(adc_code,
 				prescale, data, 1);
 
-	if (adcmap7_die_temp[0].x > voltage) {
-		*result_mdec = DIE_TEMP_ADC7_SCALE_1;
-		return 0;
-	}
-
-	if (adcmap7_die_temp[ARRAY_SIZE(adcmap7_die_temp) - 1].x <= voltage) {
-		*result_mdec = DIE_TEMP_ADC7_MAX;
-		return 0;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(adcmap7_die_temp); i++)
-		if (adcmap7_die_temp[i].x > voltage)
-			break;
-
-	vtemp0 = adcmap7_die_temp[i - 1].x;
-	voltage = voltage - vtemp0;
-	temp = div64_s64(voltage * DIE_TEMP_ADC7_SCALE_FACTOR,
-		adcmap7_die_temp[i - 1].y);
-	temp += DIE_TEMP_ADC7_SCALE_1 + (DIE_TEMP_ADC7_SCALE_2 * (i - 1));
-	*result_mdec = temp;
-
-	return 0;
+	return qcom_vadc_map_voltage_temp(adcmap7_die_temp, ARRAY_SIZE(adcmap7_die_temp),
+			voltage, result_mdec);
 }
 
 static int qcom_vadc_scale_hw_smb_temp(
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index 1d337dd9e3dc..58216124d89d 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -54,11 +54,6 @@
 #define R_PU_100K				100000
 #define RATIO_MAX_ADC7				BIT(14)
 
-#define DIE_TEMP_ADC7_SCALE_1			-60000
-#define DIE_TEMP_ADC7_SCALE_2			20000
-#define DIE_TEMP_ADC7_SCALE_FACTOR		1000
-#define DIE_TEMP_ADC7_MAX			160000
-
 /*
  * VADC_CALIB_ABSOLUTE: uses the 625mV and 1.25V as reference channels.
  * VADC_CALIB_RATIOMETRIC: uses the reference voltage (1.8V) and GND for
-- 
2.28.0

