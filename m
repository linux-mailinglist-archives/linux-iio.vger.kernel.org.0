Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4810244502F
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKDI1M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhKDI1L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:11 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4EEC061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g18so343927pfk.5
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lc8uPyEyzTKLweKdBJnTSpt9yRwuF15SqjA0MLF4iFg=;
        b=Vx0H17Sh9q0td9Jy4ofevsf4Mj5MEhDGTLbCEUAVX5duv6VDEA9i68gPyfwAuhWdJ8
         jVyo2R92ZBu/ZiONrVcn3H8RqhYxuy06+Rz8lClp3MkPAENeUzfmY1jtQd1AeOLurCgG
         izxiHrU4hGB5SgX6sX9zcwMNtGGIxMRK0SFTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lc8uPyEyzTKLweKdBJnTSpt9yRwuF15SqjA0MLF4iFg=;
        b=l8aVEdChLEksPJoeq1OA/0i6BD/2Jk5gACnIPyOjdCHqd2mXxinL/J0MFOoXhfgY2N
         XxaNeGSxGrSQGFdESd6tHCMWHSPQ1Q1su00PfrgEHAaeKAMxfYvNZnplGLT9F2FPV2LF
         gp1JpkXRxeCCeVAVdDqCgRuemvW24eOVArM+Y9mPdm/KQ9rPBsYdYS/9we7zdHjl4kWi
         gUZ0usERnJmmXWrtvcsyqL+0/lPGERnn3tXKZgSn2VinhiK8Gzr8UiaA6yYufW7aUq/d
         ZtPf7BeR3y3gZW1n1LcQznLzyAUIsU75H9ONPCtVCIMJPBnfqE5KY75OicniXiCZIzIk
         fEqA==
X-Gm-Message-State: AOAM5304WcfVNskmSPhaFhP12osXP1SBFi9JLLtxlbUyWxZefW8JyomK
        RmuxicJDyOn2GcelEheFqKu5iQ==
X-Google-Smtp-Source: ABdhPJzp58s7+oItIKw5Ejd+TF6/4zMxlAhKAGVBdu3DMF+hgwXn4kPHevj2jBiq/0iJjbrFdf+dgQ==
X-Received: by 2002:a63:874a:: with SMTP id i71mr24106957pge.81.1636014273552;
        Thu, 04 Nov 2021 01:24:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id p9sm4266718pfn.7.2021.11.04.01.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:33 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 09/13] iio: ti-adc12138: Use scan_type when processing raw data
Date:   Thu,  4 Nov 2021 01:24:09 -0700
Message-Id: <20211104082413.3681212-10-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211104082413.3681212-1-gwendal@chromium.org>
References: <20211104082413.3681212-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use channel definition as root of trust and replace constant
when reading elements directly using the raw sysfs attributes.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/adc/ti-adc12138.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index fcd5d39dd03ea..5b5d452105393 100644
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -239,7 +239,8 @@ static int adc12138_read_raw(struct iio_dev *iio,
 		if (ret)
 			return ret;
 
-		*value = sign_extend32(be16_to_cpu(data) >> 3, 12);
+		*value = sign_extend32(be16_to_cpu(data) >> channel->scan_type.shift,
+				       channel->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.33.1.1089.g2158813163f-goog

