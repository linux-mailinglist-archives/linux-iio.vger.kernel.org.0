Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856672860B3
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 15:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgJGNzT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Oct 2020 09:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbgJGNys (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Oct 2020 09:54:48 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C77AC061755
        for <linux-iio@vger.kernel.org>; Wed,  7 Oct 2020 06:54:46 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r127so2357806lff.12
        for <linux-iio@vger.kernel.org>; Wed, 07 Oct 2020 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+ec5e/iUjJ8qDBtGE9xKBCADcm1RI8srVHT5OLXlvU=;
        b=J0HrgTP+bdsiziFzBLAU3bFhSgcehD3IjjAumE61noLFhq70j+LNfR4NnX9nqFCeYT
         9UzC/oIh1asAvqg3J1HbStk6aoQvGIml1fTYox6KJwNkqPYffm9bRoXCmhtTWRaPGKn2
         frh2vEiA+bp3euj+YWZkmRgGB3eWHDrQm4rz/v2xTKxMaQqFVTGc/dOpqkHfLjTinLrP
         P/vBvbdIKr7GsDQcujkJcb6C8lJGAjyDtTT3+825JbMEi55QG6E3PlO4k7A+OQDiaLXK
         wnWF0Kv61acAbziZX7YQ8cbcIX9o1MKNT5k5C8bNeBtt8mJC9nCLMSlXJ6nYEW+au3Io
         oc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+ec5e/iUjJ8qDBtGE9xKBCADcm1RI8srVHT5OLXlvU=;
        b=Crq4plFrgO0XF+9ktVzd6dzozcOxdyNSIW626IGvjwG4ndKbBWA3F8iHDSQP7kyb13
         UBaFnjd9wqwHY9o7rq7CRh0batzbKu82Hvn+mS24jtoEAIW6sVWHVj4jqC5c19jCuuCI
         apHIU1HgBZ6WoShdMDGBeft7GnK2qRlWpXv15e5NsWizOQiZoR6NOR5yLqCknu63kpaD
         pH01T4vERnwKs96MrRl0jTcO7sCIWx0p+8XZ0ClXee8EQDg2wANyxxXdPWbjEJ63iIBo
         Ff1vV2h1acyuUZ9UV6hqGtTEHGZAPsrHdyKn5V1LVuejpJREng/zQiDkQS5AHUeKlOKb
         S4QQ==
X-Gm-Message-State: AOAM530xOYJgMC1O0qm37t+j2+ad9u9WX1rCl+1Jucm9mVEn5N/7cHbp
        MfP6NB7yFi5JSVodGsMsBewaGQ==
X-Google-Smtp-Source: ABdhPJzbdFLj0KVV5TfCbDkOYOXQF8BsCmIn/MeBPuzERCQJAPmCUR3WfIMSzkUI75efgUaNtyDVRg==
X-Received: by 2002:ac2:53a5:: with SMTP id j5mr922652lfh.253.1602078884614;
        Wed, 07 Oct 2020 06:54:44 -0700 (PDT)
Received: from localhost.localdomain ([188.162.65.250])
        by smtp.gmail.com with ESMTPSA id n3sm339768lfq.274.2020.10.07.06.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 06:54:43 -0700 (PDT)
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
        Craig Tatlor <ctatlor97@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 02/10] fixp-arith: add a linear interpolation function
Date:   Wed,  7 Oct 2020 16:54:25 +0300
Message-Id: <20201007135433.1041979-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
References: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Craig Tatlor <ctatlor97@gmail.com>

Adds a function to interpolate against two points,
this is carried arount as a helper function by tons of drivers.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/fixp-arith.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/fixp-arith.h b/include/linux/fixp-arith.h
index 8396013785ef..281cb4f83dbe 100644
--- a/include/linux/fixp-arith.h
+++ b/include/linux/fixp-arith.h
@@ -141,4 +141,23 @@ static inline s32 fixp_sin32_rad(u32 radians, u32 twopi)
 #define fixp_cos32_rad(rad, twopi)	\
 	fixp_sin32_rad(rad + twopi / 4, twopi)
 
+/**
+ * fixp_linear_interpolate() - interpolates a value from two known points
+ *
+ * @x0: x value of point 0
+ * @y0: y value of point 0
+ * @x1: x value of point 1
+ * @y1: y value of point 1
+ * @x: the linear interpolant
+ */
+static inline int fixp_linear_interpolate(int x0, int y0, int x1, int y1, int x)
+{
+	if (y0 == y1 || x == x0)
+		return y0;
+	if (x1 == x0 || x == x1)
+		return y1;
+
+	return y0 + ((y1 - y0) * (x - x0) / (x1 - x0));
+}
+
 #endif
-- 
2.28.0

