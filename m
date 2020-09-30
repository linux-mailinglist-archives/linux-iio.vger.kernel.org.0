Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B8127E5F7
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 12:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgI3KCZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 06:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbgI3KCY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 06:02:24 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0196BC061755
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 03:02:24 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z19so1410849lfr.4
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+ec5e/iUjJ8qDBtGE9xKBCADcm1RI8srVHT5OLXlvU=;
        b=L7JpW8e41pdQIDs7XVntiDjzE5Whj9TdpeqexPl106qK8irLfsBgPwN+J/IgEe/GWB
         8CvCZf6TL20ekgQj5nkrKaJQN9Scd8FnmVP0FlvOHGD3ZMp1WZVPCAstpY1i3ejR2Ow/
         RUGykcuatohUzP5y8wZA7Hh4EvItbSX3bc+wJfw9+KLldbCWOOc1H0I2/w53H1DSLlks
         kLCF9lZUFdpCHrk04/77Pto7W1TUf1IhMqJnighA1lIn+PilH9NXLam0F085MiAwSNuH
         MilmtAaB5f0ibptA12QDDQ1J+hz38YKS9dHqV7Wrvq5sGAZaMO6I6yb2utuP/s9ObxGX
         z4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+ec5e/iUjJ8qDBtGE9xKBCADcm1RI8srVHT5OLXlvU=;
        b=REfpJpa496Ove3pG8FQkvRnmrkdbhIqJVfoB4gQWo0css8ZZpBq/13jyKJWEj3ehME
         5Dkq4JWGRBZF+2bxKV8/Eb+OQrPHNtavk7UfyVkFvpRADGTSRRt+cP1OjdLWNU/DJTkg
         K+VdemSe0nHgyMBrFZgJNXjngAuAkKyTzDylT4JUWGUarv18Y0uWxsFJiiO2YzRq8rcp
         kkD2RAYejiq6ZxHGKWERct8q3N7Xle1YEflAel7VO33560SSJk2ajmzWMAu2rpc/Fmsc
         FP9zX1T/6IdQ85FzsrRoDTkiR9ryyocujRu94jFUVzDXMaHO4QRFeH5beFxHC6YR9zaZ
         u/Wg==
X-Gm-Message-State: AOAM531k6BICnvbpNmjxgYEUW0bcTpd16KPuRhoJWJ5xn1CURcOfnfWa
        SsV2T0N+TKfy1TwBXte1zgx7Cw==
X-Google-Smtp-Source: ABdhPJzwwTX5w1ZQGgCsH5flM1GdwUDPzLgUTf5zIUJ76ZzgPt5znCt8OgR/hp2NsMNJkCGhBPk5Cg==
X-Received: by 2002:ac2:418c:: with SMTP id z12mr645897lfh.231.1601460142445;
        Wed, 30 Sep 2020 03:02:22 -0700 (PDT)
Received: from eriador.lan ([188.162.64.138])
        by smtp.gmail.com with ESMTPSA id w4sm132479lff.231.2020.09.30.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 03:02:21 -0700 (PDT)
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
Subject: [PATCH v6 02/10] fixp-arith: add a linear interpolation function
Date:   Wed, 30 Sep 2020 13:01:55 +0300
Message-Id: <20200930100203.1988374-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930100203.1988374-1-dmitry.baryshkov@linaro.org>
References: <20200930100203.1988374-1-dmitry.baryshkov@linaro.org>
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

