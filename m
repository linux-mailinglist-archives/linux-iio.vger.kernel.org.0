Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9062A322F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 18:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgKBRu0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 12:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgKBRuZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 12:50:25 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FBDC0617A6
        for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2020 09:50:25 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id v6so18482216lfa.13
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2020 09:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECutAzXkedFfL8hCzDuYv52+qxzpsq+qvKIomKmfXGU=;
        b=tI4XiscH8uwlQaTRkICeTzAuztdG+4oJhjPnFrhDIhIoJSz6DWDn1/yuzgnY6mkgdc
         eSX3h6ip9VhZOAd/uaVPPE+AbieeIv7HwW6O2WRp3oQIqPsjKpI68ncVwoFXsEXDDzBe
         G5VM0T1vz4Df+T2GwKrP7iIlYFDm4OoTv14dGBxdR7yDFivKrBudENSEwfc2tMDUwgIA
         Fqf9aVZJ4Ehj6NDxZpb28L/080hY69KVd6Le7zquAcU7OLoooe7tfK9hSvHQthJTbHk+
         FipH7v10wIPu3nQpjUrULN8OjpHqDgwLlF6n57PRSuHUcoYz5W7jqaRCCeS7yJGA9pSx
         4YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECutAzXkedFfL8hCzDuYv52+qxzpsq+qvKIomKmfXGU=;
        b=DLDWPGelV66QcocK15TGC7sVox8fBbBRH5eJRArZKjdpvwB9O2BTlK0OpVsqWTyNIg
         VvH3+LZyZbgaXdEldeyZBy28OI61HsEx1Ngz74UJRc1LVov8ETZUhbgYmD2KPKbnXtLP
         DVgVV411sKyyE6ENtBhafISGQzqkTgLPdk3Al/r+cyazvvujoIV8GFaLALTqun0MDmpB
         ijpMvD5+whgG+7R8+aFLjrdBa0wVtcyZTi3rjY217I+ND49pq2SdVviRmUh62RLGQfav
         Rioim/NR3Zfs6M11clN1QqIy47EK2JvbAFz8Mm2knJpbecdq2PYZPalPjDbW+eMZb4ui
         pL3g==
X-Gm-Message-State: AOAM532fZrBGvTK8DY7cboKtPCQS5NTQyuSRBS52C0J5MwB/8K53iCng
        TVYdMhQbtQoxrVZHB1lB1Oacaw==
X-Google-Smtp-Source: ABdhPJxE31yxdoqClUUBXZa7PQYazoc0cUeGQIMMZ91hwO7Rf0PQmPXGXIrwdzxm2Up6A+N7G5c8cw==
X-Received: by 2002:ac2:4566:: with SMTP id k6mr6827126lfm.161.1604339423820;
        Mon, 02 Nov 2020 09:50:23 -0800 (PST)
Received: from eriador.lan ([94.25.229.254])
        by smtp.gmail.com with ESMTPSA id r7sm2516163lfc.206.2020.11.02.09.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:50:23 -0800 (PST)
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
Subject: [PATCH v9 11/15] iio: adc: qcom-vadc-common: scale adcmap_100k_104ef_104fb
Date:   Mon,  2 Nov 2020 20:49:46 +0300
Message-Id: <20201102174950.1148498-12-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
References: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Scale adcmap_100k_104ef_104fb temp values by the factor of 1000 to
remove extra multiplication in qcom_vadc_scale_therm().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iio/adc/qcom-vadc-common.c | 70 +++++++++++++++---------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 441843827f05..8682cf1e213f 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -23,40 +23,40 @@ struct vadc_map_pt {
 
 /* Voltage to temperature */
 static const struct vadc_map_pt adcmap_100k_104ef_104fb[] = {
-	{1758,	-40},
-	{1742,	-35},
-	{1719,	-30},
-	{1691,	-25},
-	{1654,	-20},
-	{1608,	-15},
-	{1551,	-10},
-	{1483,	-5},
-	{1404,	0},
-	{1315,	5},
-	{1218,	10},
-	{1114,	15},
-	{1007,	20},
-	{900,	25},
-	{795,	30},
-	{696,	35},
-	{605,	40},
-	{522,	45},
-	{448,	50},
-	{383,	55},
-	{327,	60},
-	{278,	65},
-	{237,	70},
-	{202,	75},
-	{172,	80},
-	{146,	85},
-	{125,	90},
-	{107,	95},
-	{92,	100},
-	{79,	105},
-	{68,	110},
-	{59,	115},
-	{51,	120},
-	{44,	125}
+	{1758,	-40000 },
+	{1742,	-35000 },
+	{1719,	-30000 },
+	{1691,	-25000 },
+	{1654,	-20000 },
+	{1608,	-15000 },
+	{1551,	-10000 },
+	{1483,	-5000 },
+	{1404,	0 },
+	{1315,	5000 },
+	{1218,	10000 },
+	{1114,	15000 },
+	{1007,	20000 },
+	{900,	25000 },
+	{795,	30000 },
+	{696,	35000 },
+	{605,	40000 },
+	{522,	45000 },
+	{448,	50000 },
+	{383,	55000 },
+	{327,	60000 },
+	{278,	65000 },
+	{237,	70000 },
+	{202,	75000 },
+	{172,	80000 },
+	{146,	85000 },
+	{125,	90000 },
+	{107,	95000 },
+	{92,	100000 },
+	{79,	105000 },
+	{68,	110000 },
+	{59,	115000 },
+	{51,	120000 },
+	{44,	125000 }
 };
 
 /*
@@ -418,8 +418,6 @@ static int qcom_vadc_scale_therm(const struct vadc_linear_graph *calib_graph,
 	if (ret)
 		return ret;
 
-	*result_mdec *= 1000;
-
 	return 0;
 }
 
-- 
2.28.0

