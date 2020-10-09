Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21255288D0B
	for <lists+linux-iio@lfdr.de>; Fri,  9 Oct 2020 17:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbgJIPpM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Oct 2020 11:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389252AbgJIPpL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Oct 2020 11:45:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B7EC0613D2
        for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2020 08:45:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a5so10038227ljj.11
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2020 08:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+ec5e/iUjJ8qDBtGE9xKBCADcm1RI8srVHT5OLXlvU=;
        b=bwohXV3YZo5cTz0TyNBCL/bMBJIwuPprPvrhOn48oBFgGvgBiXBPol+T7jzXJBlYAA
         jUNORplCm8Wgt6R/yIDhzByfIanKQaRWKUsdeKHBlp9j7NJay5EhVgnn4OsBJuW8J5rT
         4jY1ipSBsKUbbkCAHXDVjb+xgwIl+w8giDNkvPSQH/N1orSMRnrH/odd77upToDSb/tZ
         C9bDTxulmJAh7cAMvpxWd8JWMXHySlcOgA90BBBcPtxqwOC2vrjeGvdHFEiwn/cJ+x5H
         pLGtSKf/BZvDTvSJ6pjLxBWYBYY0TaULkbUVShYJDXk5SqlJa8+bv3Sdc2ab16TnE7Em
         2sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+ec5e/iUjJ8qDBtGE9xKBCADcm1RI8srVHT5OLXlvU=;
        b=IH9l0HYtHaAGkQbZuVdWcUm7lQobgOtkRQ7mzpWrKMi0FGMrE5c3BgsNaY2adift2L
         zDF4WlCCzLT0K8+kQLRmt/CXiuZk/rLw5mtShuiuOv5aVQYzairbYIXfKkYRuKDN8Bup
         IyeE0VvaS/Cn4ETCG1Xt8mv8zvU7A9NOltSha/+VgpOxNPgsvSqGdwofQdyd3qmYogiV
         EpCydddNi3uLOdFOSqwjEdB8k27Nyr2TVq5vEYETPweq5NyHbbhlcmEqb8i/jPgXHrdv
         2Oq39B79cBC9hKtIXegx+x0neapMUY7dtVyIHgb8ltq7uMgbOIx/dsHiwBQAuJgWzwib
         UpOQ==
X-Gm-Message-State: AOAM530plfLX73dap+vVXEbn4gTdCgodilCXw2gRZ8SbETzWa/FVpcee
        o2jxG03xtJlDjwWgM17pcuTQiM3OpXe5XneH
X-Google-Smtp-Source: ABdhPJx4YT06cf8vN3nDNG3Uu3PKq6LBvxoVB37Y6nn3qXNuVpxuivte4YhuJX4KuTYrszCj94VHFw==
X-Received: by 2002:a2e:8042:: with SMTP id p2mr4336774ljg.90.1602258309858;
        Fri, 09 Oct 2020 08:45:09 -0700 (PDT)
Received: from eriador.lan ([188.162.65.231])
        by smtp.gmail.com with ESMTPSA id r4sm1505597lfc.162.2020.10.09.08.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:45:09 -0700 (PDT)
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
Subject: [PATCH v8 02/11] fixp-arith: add a linear interpolation function
Date:   Fri,  9 Oct 2020 18:44:50 +0300
Message-Id: <20201009154459.106189-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009154459.106189-1-dmitry.baryshkov@linaro.org>
References: <20201009154459.106189-1-dmitry.baryshkov@linaro.org>
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

