Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D272F3D0DC9
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 13:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbhGUKxK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 06:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbhGUKNV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 06:13:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8EDC0613F0;
        Wed, 21 Jul 2021 03:53:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d12so1650454wre.13;
        Wed, 21 Jul 2021 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xr5vBGSfKtR59JcUDGAzhuQpXNTtDCNuuVQpRWcSTmg=;
        b=sbl0aE/uj/hK00bL+GpbLDUCnCXsJwK02oIeTPyqY1BxpApFp+FQfAL3Xc3iKB4eyP
         smrqqRC7P0S4nw2RenPH/LEzk40vbrEJLD9/mP/PAYUbsyaIBiN8ZLZSDOsr5uMpEkSS
         yuqi6/5cujW13kP1p0K+ihZ+mPqztgo2xhWTJZbT1OiIYJQQz1Gveng9fNVGG7vSWpWe
         4EvD5vZbsThV84jGZIYSDyBC0S9xPnSGvtGU4kVlRWtKhvX7Wtc92rhHYXIWhvJkKfCe
         ZIv2NvmQzO/4Toa4dSVOEt/72MStCjyohulW99w9raeVz8DH/P6esoR0etQNDG5jb7LR
         c0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xr5vBGSfKtR59JcUDGAzhuQpXNTtDCNuuVQpRWcSTmg=;
        b=oPTmrNluECKgp9iDvJoXZrQdt/PPGAYyBWSbjPu4qAfTT4LUnKik+SS2uu6mXzdn57
         v7edu9Mps2VzVNptTpIZTk9LEt+N8IYf/husJBsmZKkoQKdO89GruokLeLLghXxEbWZb
         oTSYwT2UXYdwSDnV6MBCsPEtGOkn0J2bInq1mtV9s4MyKHY/rPnYQn/RIQm9dZBLxOhO
         Xep//SCmrT7Yq2cPpj3m+ZoFLCYc3B5kOGg7FQ/j3SWqiJd91G+eVZYX2gtaVs4kVSC6
         iGkbbZUxdlUHNlcJ9+cXOSb7BjeFOpsLIswkHxJJJ5rlv7eqhrnvROYJYpEtdjs1vA+j
         +npQ==
X-Gm-Message-State: AOAM5334E31ZkM0M0XQOJzYKeAoDX1L52Ol9PXcb9WrNIFIoa1wP7ysq
        ixPYE+MSibXnnEeEFPQMLzk=
X-Google-Smtp-Source: ABdhPJzP7HOY7wXtJfBa/S1DWS7WnL8KWgHRmu7ijVeIV4nt2HE9GE20PzQWvNgwt/0pkc5/Rzde8A==
X-Received: by 2002:a5d:4392:: with SMTP id i18mr41406144wrq.231.1626864814075;
        Wed, 21 Jul 2021 03:53:34 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id o14sm26933641wrj.66.2021.07.21.03.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 03:53:33 -0700 (PDT)
From:   citral23 <cbranchereau@gmail.com>
To:     paul@crapouillou.net
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, citral23 <cbranchereau@gmail.com>
Subject: [PATCH 2/6] dt-bindings: iio/adc: add an INGENIC_ADC_AUX0 entry
Date:   Wed, 21 Jul 2021 12:53:13 +0200
Message-Id: <20210721105317.36742-3-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721105317.36742-1-cbranchereau@gmail.com>
References: <20210721105317.36742-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The JZ4760(B) socs have 3 AUX inputs, add an entry to prepare including the one named AUX in the sadc driver.
Leaving the rest untouched as it's ABI.

Signed-off-by: citral23 <cbranchereau@gmail.com>
---
 include/dt-bindings/iio/adc/ingenic,adc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/iio/adc/ingenic,adc.h b/include/dt-bindings/iio/adc/ingenic,adc.h
index 4627a00e369e..a6ccc031635b 100644
--- a/include/dt-bindings/iio/adc/ingenic,adc.h
+++ b/include/dt-bindings/iio/adc/ingenic,adc.h
@@ -13,5 +13,6 @@
 #define INGENIC_ADC_TOUCH_YN	6
 #define INGENIC_ADC_TOUCH_XD	7
 #define INGENIC_ADC_TOUCH_YD	8
+#define INGENIC_ADC_AUX0	9
 
 #endif
-- 
2.30.2

