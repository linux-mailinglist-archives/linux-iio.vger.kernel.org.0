Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D942CE602
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 03:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgLDC4p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 21:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgLDC4o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 21:56:44 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BACC08E860
        for <linux-iio@vger.kernel.org>; Thu,  3 Dec 2020 18:55:21 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id f24so4885542ljk.13
        for <linux-iio@vger.kernel.org>; Thu, 03 Dec 2020 18:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4MAQUsN9uWY5ajUEroZxi+OKqjFgmfYZZ4/Px2YZkiI=;
        b=qQ92WvbLHygA9tYFlW/qVMiJlnWK1Okf7PjhTjzbbiNH8IuTFRwQkmHVZNHzoBywFz
         SbqTzuqyPUkNO5jGVBicTIQ+VJ0+PYpVbQtPeQRwm6vLgJCH66/gg/lwr+GUOogiGL7G
         bhKNRn1+/hq2u4CntZ7xKj+Y9/jC3W0x0VLbMrFgiwBIFimYsJKLdXXaAG8swhyAADOt
         0ruXuZRs5uGuJOZlN8t6PHIe2P5OQh8iZ9QTRhTNQQAx3JhsNJWO762LHND9Zd3z/k/I
         6SdZFaVZHuHG4Yq6SL1FpypMyIFW+zDiq7tf5HClBe7lqWHO65/1CbvEEW3TX+azVzGS
         HL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4MAQUsN9uWY5ajUEroZxi+OKqjFgmfYZZ4/Px2YZkiI=;
        b=ifzEvE11kf7Pg8sP88WrqZTr9fv+t3K0dp6qDIAn67NZ333l4PWmcF8ksOXYKaUhqc
         aJGhpsLKzs8Fcw8/HcKDM5/jDvT92BycpOWVORNs1XoEybvGqj4oQoVt7yediLa9OG/R
         jFOJB6E/9PUqlBEQT0GVqYtsoO+ZOqS/YS5D5TXVD3Dp9489JTDA8Z4rOHspFO4BC8iT
         gRcq6KncAPSapPfupeZJSwpV4Du5VMjacknR1CeVuD/a8cOhydjg8yVh2NkJetHaIkvB
         CJpZu9ZbNgAeifdgGoJAEIoaEEskdw6xdgnAGIBZWrAyKcU6vAttH3TkGEVG4fkIPoEC
         xhww==
X-Gm-Message-State: AOAM532VkujZzw1kb7eGd9TkzvsNDfim1/EDkwJ0XIezMbeB/HS6569q
        2AId11Wf7KuJIrDOlqBaQklioA==
X-Google-Smtp-Source: ABdhPJzhROS7VX4f30wwhjmSfuiX+tj6hkBERlUAa04UXeta/A5TNU+d8/z2jLiqKbzKPJiKLFFmdQ==
X-Received: by 2002:a2e:2286:: with SMTP id i128mr2446984lji.396.1607050519844;
        Thu, 03 Dec 2020 18:55:19 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.64.117])
        by smtp.gmail.com with ESMTPSA id b8sm1131667ljo.68.2020.12.03.18.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 18:55:19 -0800 (PST)
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
Subject: [PATCH v10 02/15] fixp-arith: add a linear interpolation function
Date:   Fri,  4 Dec 2020 05:54:56 +0300
Message-Id: <20201204025509.1075506-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
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
2.29.2

