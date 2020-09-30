Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E97527E600
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgI3KCa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 06:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgI3KC3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 06:02:29 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599E1C0613D1
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 03:02:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z17so1382085lfi.12
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 03:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyrNRlrzgocwFtm4m1D+vgyjZWlJZcz7p/Dz+/oWD3I=;
        b=m0zpqotBVnmz/7C8jVSYyhqZBMEXJh33+flGjkdUOMwY+pgk0H+RmC2MBTAIFR3JRo
         CHWqmgecP0Qv0I/S7mtJLJxoNK91cr33eDtF7KO75/f1K0vuwtuZ5SwyGmGa7GsMqYgY
         hjaNrynyfZ42TSGgRaiM+UkCOAUcKWJVa+Pud+OZjbay3TBKBmTpp2/JkUXaCGykRORG
         VwSIcFz25PnTj8FkpIhrWtXpwV0djWXXs/MNnS85wSy7h8gyFyTlVqno1b7/XqcukJea
         uJOG7J2FiJZK+qd4mwUM71jT9a6Ezn99yPMBzge7LSFhrD+pLrSUq4MiKAwpNAOzQQuM
         zZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyrNRlrzgocwFtm4m1D+vgyjZWlJZcz7p/Dz+/oWD3I=;
        b=rWJUbUbTru8X8fjgm2umC/1IAtv99sbO9zPrgjHGwKFuRPCTUwx5uXpEY/IPkT8gPT
         8grH+aezOjfAGY4MIRMqUzjnPfwJEnnaV9pH8EP8olTMEALYwpgEWtrGw42XSiUIxoLF
         g53ua50iPtS0qgNEhUPvXwurO/Hjsf71up+TqPkLJhy5Id1xdtgXj0g1/ANKBeetDZUv
         ByuBb/XghJ/mNp/3eiaGgtrK4usJvp/0zpF3lLC1V34qNbjdjc7CRBMRPqjf726iuqo1
         sYhIkhNDM6EVy/lH3uz2pm7zcYlsoOKg957z+Vrmgos3UPlXZ9+y9yVt+ItzMxCD2Wdh
         X+Cg==
X-Gm-Message-State: AOAM531VbfFfO4+BcQdetdvr4yQln2tw5gmWjE4qkh3H/SGGIzmkSQXu
        S+wc2bqw8q5L92SOUr2UP8Y1Sg==
X-Google-Smtp-Source: ABdhPJwddXc4gkJLT7lTD9hdiCEYhG7SQmgB2Cj8256KwRtnod2YQUHDzOCUT1H2Gg/oNINWXTFqGQ==
X-Received: by 2002:a19:8c03:: with SMTP id o3mr550531lfd.349.1601460147807;
        Wed, 30 Sep 2020 03:02:27 -0700 (PDT)
Received: from eriador.lan ([188.162.64.138])
        by smtp.gmail.com with ESMTPSA id w4sm132479lff.231.2020.09.30.03.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 03:02:27 -0700 (PDT)
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
Subject: [PATCH v6 04/10] iio: adc: qcom-vadc-common: use fixp_linear_interpolate
Date:   Wed, 30 Sep 2020 13:01:57 +0300
Message-Id: <20200930100203.1988374-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930100203.1988374-1-dmitry.baryshkov@linaro.org>
References: <20200930100203.1988374-1-dmitry.baryshkov@linaro.org>
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
2.28.0

