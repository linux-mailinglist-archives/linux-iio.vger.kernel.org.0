Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7433A279B46
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 19:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgIZRSn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 13:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgIZRSn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Sep 2020 13:18:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA13AC0613CE;
        Sat, 26 Sep 2020 10:18:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so7260434wrw.11;
        Sat, 26 Sep 2020 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bl53+IHBE7yXiOLq6WRfnfhUTBMnGEZtbf1LqSaqfOk=;
        b=MaueTk1yEtJ7GzSgrXw9tmwckv/94rigKyb+hYnwA4mrGQVzJNB5sjMe6y2xd4IBeT
         3zkQ9HbFbDy2HsnjEzWPRD0Y0WO7UoGKjIxD+WFa4PQoTYvzULDT06j5a3uoJ3DXDEuB
         kwBeb9FSSZOMVJb9QpJOm1IZ76qUyTUG04nCCPF74hjYkr7zD2KCdCnP9ID5ZmR8Nzmg
         C7MsQtBPYqbYzatYImp4itw+59MOMc+2ezR9fnuhOMJ3/LKjf0riQt/EiAWmQToz5Wcb
         rhdKstdxImdK1Ec5krm8r230l7kWzYOa0U20CsBBZOhjsabFERo9xzDUDPJXk0vj+k8p
         muuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bl53+IHBE7yXiOLq6WRfnfhUTBMnGEZtbf1LqSaqfOk=;
        b=GdxjOrt3qfc2NDShUkPm+FhikafObXAx2zB0+2hrT4kBCuBTuTvLLBHAbFkAKdB/Ku
         IZGOitadgmm6+WNFAVaT+RKwzM/lx0X4l4wegbDB4gyY/e7/KxRFXjLc1pvSR5JArkMb
         awTf/31Kr/WwJPfdxNzSryi/IjO+oxV1hLcmgAu6Ac/HkGCs0aJbbiqIO3jVcCCX1Dk0
         S+4MnZn7fBM+V3YfbuZ3jFboztl6A2uv9QQDh4v5JDiragvx51WLWHRU9Kno2ol7L4WK
         KA9rTIo0IITNo4X6n+AE1+RPMnYmgfXEDreQ5gczkca3K28s/USwexOzCIZicBMpAg6U
         66lg==
X-Gm-Message-State: AOAM531pXjsQZY//J/ZpDbxh4kk4Bpy7g/eE/zgeUanDyNxfN+ZI6jYN
        6O9r2WZZrPBI/C45AtSFAyA=
X-Google-Smtp-Source: ABdhPJyzlxbTOBiEV6UjiHZ8TzGIgyhnXIRMmB49mXLck6hVgqRUzmKf7TuHcYyH3cOFuQuh7oKS5Q==
X-Received: by 2002:adf:f903:: with SMTP id b3mr10611592wrr.142.1601140721323;
        Sat, 26 Sep 2020 10:18:41 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id l4sm7427125wrc.14.2020.09.26.10.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 10:18:40 -0700 (PDT)
From:   kholk11@gmail.com
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, jic23@kernel.org, robh+dt@kernel.org,
        kholk11@gmail.com, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [RESEND] [PATCH 1/2] iio: adc: qcom-spmi-vadc: Use right ratiometric range for 8998,660,845
Date:   Sat, 26 Sep 2020 19:18:34 +0200
Message-Id: <20200926171835.27154-1-kholk11@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

The ratiometric range for MSM8998, SDM630/636/660 and SDM845 is 1875mV
instead of the standard 1800mV: address this by adding a new compatible
"qcom,spmi-vadc-8998" and assigning the different range to the machines
declaring this one.

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 drivers/iio/adc/qcom-spmi-vadc.c   | 10 +++++++++-
 drivers/iio/adc/qcom-vadc-common.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index b0388f8a69f4..59a94ea7bf78 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -101,6 +101,7 @@ struct vadc_channel_prop {
  * @dev: pointer to struct device.
  * @base: base address for the ADC peripheral.
  * @nchannels: number of VADC channels.
+ * @ratio_range: ratiometric range for ref points.
  * @chan_props: array of VADC channel properties.
  * @iio_chans: array of IIO channels specification.
  * @are_ref_measured: are reference points measured.
@@ -114,6 +115,7 @@ struct vadc_priv {
 	struct device		 *dev;
 	u16			 base;
 	unsigned int		 nchannels;
+	unsigned int		 ratio_range;
 	struct vadc_channel_prop *chan_props;
 	struct iio_chan_spec	 *iio_chans;
 	bool			 are_ref_measured;
@@ -355,7 +357,7 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 	u16 read_1, read_2;
 	int ret;
 
-	vadc->graph[VADC_CALIB_RATIOMETRIC].dx = VADC_RATIOMETRIC_RANGE;
+	vadc->graph[VADC_CALIB_RATIOMETRIC].dx = vadc->ratio_range;
 	vadc->graph[VADC_CALIB_ABSOLUTE].dx = VADC_ABSOLUTE_RANGE_UV;
 
 	prop = vadc_get_channel(vadc, VADC_REF_1250MV);
@@ -885,6 +887,11 @@ static int vadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (of_device_is_compatible(node, "qcom,spmi-vadc-8998"))
+		vadc->ratio_range = VADC_RATIOMETRIC_RANGE_8998;
+	else
+		vadc->ratio_range = VADC_RATIOMETRIC_RANGE;
+
 	irq_eoc = platform_get_irq(pdev, 0);
 	if (irq_eoc < 0) {
 		if (irq_eoc == -EPROBE_DEFER || irq_eoc == -EINVAL)
@@ -918,6 +925,7 @@ static int vadc_probe(struct platform_device *pdev)
 
 static const struct of_device_id vadc_match_table[] = {
 	{ .compatible = "qcom,spmi-vadc" },
+	{ .compatible = "qcom-spmi-vadc-8998" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, vadc_match_table);
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
index 17b2fc4d8bf2..b10d5fd59034 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -16,6 +16,7 @@
 
 #define VADC_ABSOLUTE_RANGE_UV			625000
 #define VADC_RATIOMETRIC_RANGE			1800
+#define VADC_RATIOMETRIC_RANGE_8998		1875
 
 #define VADC_DEF_PRESCALING			0 /* 1:1 */
 #define VADC_DEF_DECIMATION			0 /* 512 */
-- 
2.28.0

