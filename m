Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BD82CE60D
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 03:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgLDC5A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 21:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgLDC5A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 21:57:00 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BB8C094240
        for <linux-iio@vger.kernel.org>; Thu,  3 Dec 2020 18:55:26 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u9so183986lfm.1
        for <linux-iio@vger.kernel.org>; Thu, 03 Dec 2020 18:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kheJmCyDI4R5PgXqJsIVVX5lZh86mdMPpHXrUUt/fHo=;
        b=R6XRhBdoGrWXkV8N/DwEVhvjyVxFDq+6j6z5pACnCc3ycb0afXDbJdE91idETZGXcx
         JOko52r78Mtq601o7nd1Jo+lvMLQ9+4GOtKcgjNSY+1Isa7bC2jPVqSGNh/azmH43wT+
         qnD1jOZpwFaUHQGuo4zFi8EUGQQAzbrE1PN/b4XCPpXWFL1dsbR8BL40v1Q6ynlsmnbc
         xwvrosg0BXiK5dBOYGZIjsIHinrOIkGPXhdZLfEdI/0ddTkUPeDoKqERIWzWhGEASrgU
         2ByUHhMrFcPjKpycb5Iy8TtFALbEGk0YgO3pcoOA8QePnX6n5ZTBSlOhmpJPx5EPbLlG
         3eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kheJmCyDI4R5PgXqJsIVVX5lZh86mdMPpHXrUUt/fHo=;
        b=N04PVegG0U8dS+6QlOU3ZOwdYqGMVUdZc0B6jjLuFruVVKo/DqhaXa5ybtNDZaqYQa
         BzVB0hX4haNhHAmfDJi6edQoeGp0PhHW5LkJz19V9eNCiA4gmpCzgJTYLCNgVjwuVakW
         Rp6CwJEuzpRA3oITaJNEJieLrnpfal4nBTn56Z5URwhZi6Uf+XUbqoB/PaZhVMmsfFy3
         Gqb1l4NoyuJ4kpI46NnWG86s/6HfwK/nwPqCwX+uSpkM/yWBUjyxHUE6x7AOyH2GfK5E
         Sg6J8U0fxtwNWv8/4D/RnN2P9ibSNw+8ZgkoA0l8qFrAvHr6v1+mQ8YooKltCRP534mj
         zKCg==
X-Gm-Message-State: AOAM531G1M/uYEBU+Aqu+aq5S5P8xrjzcbTtzwVLWMSwIzQhM5ju6t/x
        pGic1adRppIgFOac6CoNelZcZg==
X-Google-Smtp-Source: ABdhPJx2LLD1xrVQw9UHOJUHWQjRe+ecZMZn3p8IuVU8NUEu3Ag4M+HZWGtJ3FhhvjRa2kMKy2yP8w==
X-Received: by 2002:a05:6512:36c7:: with SMTP id e7mr2696179lfs.79.1607050524841;
        Thu, 03 Dec 2020 18:55:24 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.64.117])
        by smtp.gmail.com with ESMTPSA id b8sm1131667ljo.68.2020.12.03.18.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 18:55:24 -0800 (PST)
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
        Jishnu Prakash <jprakash@qti.qualcomm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v10 04/15] iio: adc: qcom-vadc-common: use fixp_linear_interpolate
Date:   Fri,  4 Dec 2020 05:54:58 +0300
Message-Id: <20201204025509.1075506-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.29.2

