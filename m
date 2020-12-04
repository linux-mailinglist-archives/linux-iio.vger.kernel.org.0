Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2613B2CE615
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 03:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgLDC5P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 21:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgLDC5P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 21:57:15 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A61C09425A
        for <linux-iio@vger.kernel.org>; Thu,  3 Dec 2020 18:55:38 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u9so184444lfm.1
        for <linux-iio@vger.kernel.org>; Thu, 03 Dec 2020 18:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZSgtsld/jErWqUbZ6AQEllOU8y9wlhXnzPgaFJHrUyg=;
        b=CFJXFKorX1v57fHzUaPjeI/66wq4W2kEMc672Dw8tjexqJqLVT3ImUJm3kAcbHe8m8
         akXngp4ulHCvjIUrNVIk4SsuHPPv/CbNrplb0Pq+1SHHt4of9kjuIJ9jiwhFq+FIWdb0
         6oEhC51GLZhMofQw/i79ZXK1NVXZtX9Uaoe4j/M76xYTVWLoZy/T7+e3OPM2G5YG0/Y9
         Kb7UARn0KIYJcuNYddrap/1ZerX1s6K4LsagsbdXIBVSJkSSvho2w2yK5UGZCRz6J+ym
         VemqSWQ1pqg6+DYj1UDMVpgMv2+R/AcB8gR+aLJp4ehSBLOyXkxOyEqiY44zIQnPggx4
         yZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZSgtsld/jErWqUbZ6AQEllOU8y9wlhXnzPgaFJHrUyg=;
        b=EFLyBcITOHGofHB2ymQb+4sPiHng/a9lAKzKzNwbLGaTWuZaztCRZcak8NfVcx07hT
         /uUc6lzRHvqomATLFKD/rkDCfnwdXj5QmXMAnNuief7m30dVrNfmCscOjTJCRSt6/BLe
         rJ1KTaueQwEPs6DVPZFxyV+jYhx8uBaAMmxD8atKLxkZRrD+mqu2CjfyFazuyFvlCmGe
         umQIlSNuN9EU+iEeWBVFI8PSCk15ezyDtF2tE98RX4h0zrsSkszB6nqIUNzDsiIqlJW1
         4/Uhj9yOI58U6kxYn2ibHABo5NvAVIAgJI10Qk/Vufb1OKBvkmMFFOQjXA//UaN5WGLR
         WzUw==
X-Gm-Message-State: AOAM532lRNl9/4u2nlOaiQgjRAG2K71DbjfQFBmANWwU8Lzd03DC/B/f
        WA8CFCois4HIk4Qoq8i2dotFo3eR1N9xqg==
X-Google-Smtp-Source: ABdhPJx2ULcZp88C/DFdKtUFZqlkK4dYWOlWjsMNQxzHfvjIp5wtM2z9UsKTSqlqitPrhvjHWgffSQ==
X-Received: by 2002:a19:e04c:: with SMTP id g12mr2496970lfj.261.1607050537378;
        Thu, 03 Dec 2020 18:55:37 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.64.117])
        by smtp.gmail.com with ESMTPSA id b8sm1131667ljo.68.2020.12.03.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 18:55:36 -0800 (PST)
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
Subject: [PATCH v10 09/15] iio: adc: qcom-vadc-common: rewrite vadc7 die temp calculation
Date:   Fri,  4 Dec 2020 05:55:03 +0300
Message-Id: <20201204025509.1075506-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
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
2.29.2

