Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD9411ADE6
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfLKOjv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:39:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45798 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbfLKOjv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 09:39:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so10465357pgk.12;
        Wed, 11 Dec 2019 06:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3VEcdWQti206JWCDW3qI0BTxZ1lYQXCJ5XH3cd981NQ=;
        b=jH82xtrYMxhgUcHQRPKqjw7ZKlvPgF+xBtcnxGsL7fh4pjdfao/pZu4Q6upvCNHIh1
         a+G4WLTV+T+1yx2XyKqc1y8xCv1StbbjpoaBkIg8NeB3ZaZgozkM7fploPXJ9z4wTfQ+
         Ee3DwRsSc0ZQHdjw5TCUYZzZjT/bppcgvXa+XIdYMuUnfrK1g7Ezy9pFVmVYZ5xkzhyz
         fcFVbP3jXuwNeaeDXX7CkGxikmhPQRcLVgS21AwByB3NK8Gi6kZ+6aaemxXGyHfeFQBX
         Jt2PbVWKRidv9CFTbWklTCKJjHPNRfVDQKtXDW3IQIf1C5PkhEmElEAQpjPQPl7rnVYf
         OMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3VEcdWQti206JWCDW3qI0BTxZ1lYQXCJ5XH3cd981NQ=;
        b=jxfQBdxD65GdbDlQPpTYmT5nPdbaT9leMn5bX8Ou7FwB727x1WduhZuu8W0YzPbr+a
         Q7yz5E2xPtzzb0zHKuGklOVOb+BGsDn6Q7NPZY1By3xIXEk8P+DuixcDPcgFP1EW+n8S
         ARi+T99RAP3BYWirbZrjewXMRdvjNlowhjh2F9TSqcbUy9NsGrYnFH4bOXLU5ODoYra+
         k5uqLeqjV19HSI1XFUEQx8wL6kBhDSR1u2aPn+7BA5BrOdZUj8alvZ2+xkPeokXUMpkv
         ZqF+4hhuanH0y0Q68yM80+8DbxgU5go/zDGJ/KorTY05Gj5UzEQNl2HwO+UTKiI+JAN5
         W6Nw==
X-Gm-Message-State: APjAAAXPB2U3z38ghY8H5GjgbiqxOCwKLniDFE2e08h6F2vTnH3Y5b5G
        aaNfdmTV71MbwQ3ihvlj+HQ=
X-Google-Smtp-Source: APXvYqwgEvnp2ndBwiIE94Wh4cRVzfCw2QFRf/3PG5eerLtk1/YgeA2uxE8wypG49aWWT3GbeFUcFg==
X-Received: by 2002:a63:fd43:: with SMTP id m3mr4566724pgj.164.1576075190151;
        Wed, 11 Dec 2019 06:39:50 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 06:39:49 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v3 12/12] iio: adc: qcom-vadc-common: use <linux/units.h> helpers
Date:   Wed, 11 Dec 2019 23:38:19 +0900
Message-Id: <1576075099-3441-13-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the qcom-vadc-common to use milli_kelvin_to_millicelsius()
in <linux/units.h>.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* New patch from v3

 drivers/iio/adc/qcom-vadc-common.c | 6 +++---
 drivers/iio/adc/qcom-vadc-common.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index dcd7fb5..2bb78d1 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -6,6 +6,7 @@
 #include <linux/log2.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/units.h>
 
 #include "qcom-vadc-common.h"
 
@@ -236,8 +237,7 @@ static int qcom_vadc_scale_die_temp(const struct vadc_linear_graph *calib_graph,
 		voltage = 0;
 	}
 
-	voltage -= KELVINMIL_CELSIUSMIL;
-	*result_mdec = voltage;
+	*result_mdec = milli_kelvin_to_millicelsius(voltage);
 
 	return 0;
 }
@@ -325,7 +325,7 @@ static int qcom_vadc_scale_hw_calib_die_temp(
 {
 	*result_mdec = qcom_vadc_scale_code_voltage_factor(adc_code,
 				prescale, data, 2);
-	*result_mdec -= KELVINMIL_CELSIUSMIL;
+	*result_mdec = milli_kelvin_to_millicelsius(*result_mdec);
 
 	return 0;
 }
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
index bbb1fa0..e074902a 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -38,7 +38,6 @@
 #define VADC_AVG_SAMPLES_MAX			512
 #define ADC5_AVG_SAMPLES_MAX			16
 
-#define KELVINMIL_CELSIUSMIL			273150
 #define PMIC5_CHG_TEMP_SCALE_FACTOR		377500
 #define PMIC5_SMB_TEMP_CONSTANT			419400
 #define PMIC5_SMB_TEMP_SCALE_FACTOR		356
-- 
2.7.4

