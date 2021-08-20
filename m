Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1833F347C
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbhHTTSr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbhHTTSm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:42 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E8CC0617AD;
        Fri, 20 Aug 2021 12:18:00 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id t190so11935526qke.7;
        Fri, 20 Aug 2021 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+zgKUXTnho1DuYnz2N4IQ26TfKFFIYe0e2gWK71jNo=;
        b=SVDHAG5esKb79+7OfCI/tq1W+FWERAgwfbL8+y1Rig9RZBLXFyO51oAqUpTaQ0iDuH
         oHnZioX1bwoVAPA5ZxnHt57dsncxgvevEcl/OXDkyXU3iKkqJxf2LCqq+vup/k+5B4XJ
         BhZdhlDXEu2I3nmBmi9r5nzXPr6+4uBf+F8jmAcoHaqs5ykiAu4kaF85HjNuEukz0T/1
         TTCUsWHKzZ0fG0strInWQu3nvTTyiSaYp4HcfleUMlE8nK/L280FAfHTzYA0ny6U3QQD
         WE6pIzb4SCMzT27CopxB2gRi8XwGJvw2xh7rZeQ6Nnx9t3Dpogx+afAS1GW30e8Ifssd
         bMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+zgKUXTnho1DuYnz2N4IQ26TfKFFIYe0e2gWK71jNo=;
        b=hpzbDTZT9M7A2kRj6xjdG+A/adMMUtTBpyupBMenxFrR+04F+fT9ZubpP7eDfPT9Uu
         EezD4WpJjLq5s1+uATBpB6SlYLyOTsrLFYt9mmkO3BQojeL1knJqx3Rll3tFdCNePlJM
         fiRtDDR0Ax0SC9nuWdAGNawg5W/TuWqZXJoN2slnHQVfn9J34QTayrFwzAze3TSclE46
         RcYtNYc1HcsSre6lz1oCUFJ3WDnPCT0EXWeZsZRjXO3zBI1xoL/PUT3F+YBdLqOnn7Rb
         EMEKzC6SlBmteVo8gOcNTlNAeVIZJC5EUUvmBckYpgbjKrGEmmENZ59FxwQCfnKGrlcQ
         rsNw==
X-Gm-Message-State: AOAM532+gdz4iFsaHApOtWjDNxFcmozpZ9NKVHte1zFPkOTL7ehRq4jB
        a+m2x7ofP/u3vZN6yLoK0RI=
X-Google-Smtp-Source: ABdhPJzlx/k+lLv0AhZ1tNdWtJNj/r3JQZ7JvAzfQXSFD2IOMvryS3kpiUHd1ZgBsXVNeu+QWSAECQ==
X-Received: by 2002:a37:6103:: with SMTP id v3mr10319950qkb.12.1629487079253;
        Fri, 20 Aug 2021 12:17:59 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:17:58 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 07/14] iio: afe: rescale: use s64 for temporary scale calculations
Date:   Fri, 20 Aug 2021 15:17:07 -0400
Message-Id: <20210820191714.69898-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210820191714.69898-1-liambeguin@gmail.com>
References: <20210820191714.69898-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

All four scaling coefficients can take signed values.
Make tmp a signed 64-bit integer and switch to div_s64() to preserve
signs during 64-bit divisions.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 48a8096f68ca..809e966f7058 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -21,7 +21,7 @@
 int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
-	unsigned long long tmp;
+	s64 tmp;
 	s32 rem;
 	u32 mult;
 	u32 neg;
@@ -38,10 +38,10 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		*val2 = rescale->denominator;
 		return IIO_VAL_FRACTIONAL;
 	case IIO_VAL_FRACTIONAL_LOG2:
-		tmp = *val * 1000000000LL;
-		do_div(tmp, rescale->denominator);
+		tmp = (s64)*val * 1000000000LL;
+		tmp = div_s64(tmp, rescale->denominator);
 		tmp *= rescale->numerator;
-		do_div(tmp, 1000000000LL);
+		tmp = div_s64(tmp, 1000000000LL);
 		*val = tmp;
 		return scale_type;
 	case IIO_VAL_INT_PLUS_NANO:
-- 
2.32.0.452.g940fe202adcb

