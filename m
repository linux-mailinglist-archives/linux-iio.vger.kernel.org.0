Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF812265308
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 23:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgIJV1w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 17:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbgIJOJf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 10:09:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03FEC061387
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2020 07:00:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s205so8314335lja.7
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2020 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyrNRlrzgocwFtm4m1D+vgyjZWlJZcz7p/Dz+/oWD3I=;
        b=WF0RXK6c8RUr2Gomx+JVCl+LBDxVEGYpbxBgRK8Gx0gn8zhmt3BN9srE7t8MhbR36t
         H7R4z8lqw02iAe7fQQl7pweGAvYqC3fPDjYtGI8e2ECcgpCdaB/1AKXbQKiMLsUopkTr
         7olOfskIpfCiUTYTTPob51oBFFRpjtg7JncF5hGhOSp9s2XtVjIFh8bwhevkxBps24P4
         tv0msa7ig32jl0QSDxoWT5ZNrZulNIKpnmO/IvQeXz1vRGqkLtKe5LddEJor6fQ9Bone
         5TpcKBzHslKPHz2C4xhDjmx+5SWWmvqLHZuIv3NN24XoWDFGfttsWxBYXtv4N6AhRV4D
         yVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyrNRlrzgocwFtm4m1D+vgyjZWlJZcz7p/Dz+/oWD3I=;
        b=QHN0ElDp2LaNoHl27Wym+M5UB90fSvFgQG74+Sry4HtNmP1ve/aEuSu1qsbYbnkd2Q
         VfWxJby7VE39vN1nkB0I3yL4b17+tugVdorkZ2PPxP11JxgFazTHlquTD9zB9FRJQKqs
         28uEJrjBPQqX8bAZ+bGck4rH4WKVm6DHZ+ZFey74NnyIJAaiw7bDQ39d/O2LupTrRvw3
         y39wbXGx6pSi35I2rZkSqGqQ5cowOwt+WBKnDswDzjH3vcEgA0fCTXfi6zRTzq/Qr9F5
         ZEpZScnkslvIeyfkBSwjiojz18QoF7ckaYIlX2DovgQVyeVyYT6f/QXJAl9dZNMLdio6
         N2xQ==
X-Gm-Message-State: AOAM530fu8FvIQJwZIm2XKcO6K0SNDi2b9W3XyMndWzHN7594GeZRTj8
        /MpRS2Xzug79IQY4eedH9gN1Dw==
X-Google-Smtp-Source: ABdhPJxgGEjVc/OkQUNiQgHV7aJ4mQW61K48I8OB1nai+9z6Hn0jDTNFqKlWVWIg9zxx3w/A1KjPyw==
X-Received: by 2002:a2e:b4ba:: with SMTP id q26mr4146902ljm.79.1599746418934;
        Thu, 10 Sep 2020 07:00:18 -0700 (PDT)
Received: from eriador.lan ([188.162.64.156])
        by smtp.gmail.com with ESMTPSA id t82sm1367646lff.43.2020.09.10.07.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 07:00:18 -0700 (PDT)
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 05/10] iio: adc: qcom-vadc-common: use fixp_linear_interpolate
Date:   Thu, 10 Sep 2020 16:59:55 +0300
Message-Id: <20200910140000.324091-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910140000.324091-1-dmitry.baryshkov@linaro.org>
References: <20200910140000.324091-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use new function fixp_linear_interpolate() instead of hand-coding the
linear interpolation.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-vadc-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index d11f3343ad52..40d77b3af1bb 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -2,6 +2,7 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/fixp-arith.h>
 #include <linux/math64.h>
 #include <linux/log2.h>
 #include <linux/err.h>
@@ -368,10 +369,9 @@ static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
 	} else {
 		/* result is between search_index and search_index-1 */
 		/* interpolate linearly */
-		*output = (((s32)((pts[i].y - pts[i - 1].y) *
-			(input - pts[i - 1].x)) /
-			(pts[i].x - pts[i - 1].x)) +
-			pts[i - 1].y);
+		*output = fixp_linear_interpolate(pts[i - 1].x, pts[i - 1].y,
+						  pts[i].x, pts[i].y,
+						  input);
 	}
 
 	return 0;
-- 
2.28.0

