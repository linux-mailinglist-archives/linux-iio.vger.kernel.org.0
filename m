Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267EC44FD99
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 04:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhKODrB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 22:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbhKODqs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 22:46:48 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59E8C061207;
        Sun, 14 Nov 2021 19:43:48 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id d2so10428209qki.12;
        Sun, 14 Nov 2021 19:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzT5IZ5YlHRugGQyo3L+z7jU4ovJcZXhCyDbEZIDlM8=;
        b=EfkVu6bn+xzaOQ3sCe+bRdeu8GBPVHZNQHu/zuCGa3p5xr42GMYI2X8DjnHhJm30sL
         v3tuf2uVr8jwmxPVhujkOSMQyoJG6lYPwO/stOhraDTVYGNlqFmc1uwZXQl2GVKrBqVO
         5n/51NtEq/4lazGeOCCmh+yqJ4SyEC0mATgJt9+qZ2zL+uxHEmeL9zB8AES9Coy6bOea
         +pYwignEAZn0/YfRIRxpWCThnos+wWxN2N8R1PQTgUVG3U5IcR6AzJNS77n2g/B9oolW
         x/h9AxwIioWB5riWDXeAemGD2WFnQ107/l0pp1dXTj2AjNIBeptUzplH3aZKlNK7rAjX
         ohFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzT5IZ5YlHRugGQyo3L+z7jU4ovJcZXhCyDbEZIDlM8=;
        b=KfHX4JRtP4c5whRP7fMjNBA9HHf053KxgEhGBeCx7Ok7YA6U7OrakW6IYrhQK8Yln9
         Raui/E+BHr9jujYw34iJME6lLlYAoqBoAgpeCWE2xXICdYPiHXtLnYnQv8L3dk/5f035
         s89fFKqp05OSeTZQcYJnpvfD+BSw+Bd0G8REjcEAbHpbfFBdgZvqkxXGJ0gyePwB7+MM
         o/fcBJXsTJuWnTciG9fmO568Kq4tVyv58pZsE2r5X/QGWMBSmDmDK64YaBwGvpVXYdoG
         0SEhgu1pCT/WrDhnAzjwfjwZO0pf2Uy22P2m0CoOTxQWYiUmIlo2x8Txeg2B9JPUk35c
         NWaw==
X-Gm-Message-State: AOAM530iqqGOC8j1IejaIvoe0QzgAuG/GAftdc0Vi+VuUXH1by2u/NFw
        E0VhET/0QIUHazBKENAt6S8=
X-Google-Smtp-Source: ABdhPJyyTQGLHYrrcmZQ1LlRvRTAIqqcRJRsRKdZjFeCvA2CQQnpgYAY9uJN2Hsl/n4apD0Ak7231A==
X-Received: by 2002:a05:620a:16b9:: with SMTP id s25mr15457218qkj.409.1636947827967;
        Sun, 14 Nov 2021 19:43:47 -0800 (PST)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h5sm206519qkn.62.2021.11.14.19.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 19:43:47 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v9 07/14] iio: afe: rescale: use s64 for temporary scale calculations
Date:   Sun, 14 Nov 2021 22:43:27 -0500
Message-Id: <20211115034334.1713050-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20211115034334.1713050-1-liambeguin@gmail.com>
References: <20211115034334.1713050-1-liambeguin@gmail.com>
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
index da462e0910ff..394f8b16b29c 100644
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

