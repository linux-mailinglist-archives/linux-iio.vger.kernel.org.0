Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0D12A3229
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 18:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgKBRuX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 12:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgKBRuX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 12:50:23 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8AFC0617A6
        for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2020 09:50:22 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id m16so15990580ljo.6
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2020 09:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DRpprZ4tbXfA6U6lcH14beZQwE//DZQqeCLuljQcmow=;
        b=C0nQIBG+KxAvOOJxn3TdLY3FLFXyLpNt8AyQCsSm6Zpo43fK1d9m8wudva4spJqfKv
         9ir6uBFG1VqMF67yYTxo1/LRs0/o9aVm1pdlTeVpXieQi7wYT3//psqlYmvYeV7WQTyo
         0VZMYB3hrBk+hnz3YnaWQf4DDQsL40y88qA9qr7jdZ+ijJUFmNUq4VSHoC+oR8Dh7SU5
         uezs8W0T50VZv9HNA7g5T8qyh7QKr0y2fibEHxQfU3Zq1l4UtzjHTo0NdgdkceMuIj06
         pHDFnXwIESia+FImtZk6uF8nSBW4U/l6IRT53f4te9vWwwH+Ggy3lbHsV1PZk2isPNL6
         B/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DRpprZ4tbXfA6U6lcH14beZQwE//DZQqeCLuljQcmow=;
        b=SKJGgoV3vtFNj15s2N1w7k2Q3KQ/11ijjMeT91tCwmIik48N3O81WwLrABlyCLTN98
         gMTrDyoncM39T5sJ5NQMc+IwnuE55JK6FivKRFF0GBSYdaiNcJIthV5SZ1brKJAJBF5v
         o2H+cqAh7S4xWRefk1aba2WtuxlEOUluBRcKphIXhcV/Lmn5HUhApMHKAqTDafqogEK6
         l0DSJ4RnaZoVVkBDsI/OwNUp4ogaphGQZlZ+1Rd/RXvtA7eZaTLjXYDKwRFLBhtr2h+/
         8qmTabij5LmqJCeHBBegdUxFEKiGFjYtIbZSPAW1BwTjZbhtiXBaTOHI9hCpxSaMXvke
         kXUw==
X-Gm-Message-State: AOAM531Fp4Q59d0aKOclxtUhxlrKAGq9QEEGGEwI74qM3qXK3i1y2rlS
        CAD5iD/Mn/gfNM+r/EJmplYxJQ==
X-Google-Smtp-Source: ABdhPJz4Fwa4bU3uOGt92l5yfcjo1BY5fAwYnemzwmyiYV8E/HccMDSu8wj3nAuMhnsmR/NCVqgl0w==
X-Received: by 2002:a05:651c:484:: with SMTP id s4mr7364990ljc.272.1604339421423;
        Mon, 02 Nov 2020 09:50:21 -0800 (PST)
Received: from eriador.lan ([94.25.229.254])
        by smtp.gmail.com with ESMTPSA id r7sm2516163lfc.206.2020.11.02.09.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:50:20 -0800 (PST)
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
Subject: [PATCH v9 10/15] iio: adc: qcom-vadc-common: simplify qcom_vadc_map_voltage_temp
Date:   Mon,  2 Nov 2020 20:49:45 +0300
Message-Id: <20201102174950.1148498-11-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
References: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All volt-temp tables here are sorted in descending order. There is no
need to accout for (unused) ascending table sorting case, so simplify
the conversion function.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iio/adc/qcom-vadc-common.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 0c705bb473fe..441843827f05 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -346,38 +346,19 @@ static struct qcom_adc5_scale_type scale_adc5_fn[] = {
 static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
 				      u32 tablesize, s32 input, int *output)
 {
-	bool descending = 1;
 	u32 i = 0;
 
 	if (!pts)
 		return -EINVAL;
 
-	/* Check if table is descending or ascending */
-	if (tablesize > 1) {
-		if (pts[0].x < pts[1].x)
-			descending = 0;
-	}
-
-	while (i < tablesize) {
-		if ((descending) && (pts[i].x < input)) {
-			/* table entry is less than measured*/
-			 /* value and table is descending, stop */
-			break;
-		} else if ((!descending) &&
-				(pts[i].x > input)) {
-			/* table entry is greater than measured*/
-			/*value and table is ascending, stop */
-			break;
-		}
+	while (i < tablesize && pts[i].x > input)
 		i++;
-	}
 
 	if (i == 0) {
 		*output = pts[0].y;
 	} else if (i == tablesize) {
 		*output = pts[tablesize - 1].y;
 	} else {
-		/* result is between search_index and search_index-1 */
 		/* interpolate linearly */
 		*output = fixp_linear_interpolate(pts[i - 1].x, pts[i - 1].y,
 						  pts[i].x, pts[i].y,
-- 
2.28.0

