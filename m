Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB913D495C
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 21:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhGXSZA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 14:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhGXSY7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Jul 2021 14:24:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF3AC06175F;
        Sat, 24 Jul 2021 12:05:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z7so5927205wrn.11;
        Sat, 24 Jul 2021 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1b99s+XXzyVlqy4K1XF76TB2BwMPkK6Mrt1v3Z/4H7k=;
        b=ZMHxb5tboNRSUMfTtguKTiQZSvX5fwU2InXfxx2j/f+rSB+oRtGQZ+7CiHrIu4QEXy
         K+ijq/Vs0Ge1wYr+ffRIb180VGme0wxE07tiVItLED2wByNVriO9hkw+8KMOupVYXeGc
         UrjzGYWB7dXJggMzuypaG1SWQt+wJnkJCFN8teDBGdhzQZYThHGqp9WKhAv/nL3+vviL
         hlyHvNpDVCzCNFpSUeNwWB/na5gov9355uNbIluPc6xmj++ORTC6JDReuAp7AnUqAai9
         t41lFADh7LATAd0yTuiilsvQFq1uLaiYLdALmtAZcqzyKY7VkY/guZhzO7wQg84WJK1w
         5XqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1b99s+XXzyVlqy4K1XF76TB2BwMPkK6Mrt1v3Z/4H7k=;
        b=dZM/oEdnMsEj/DymjqW2Zu4vNBfnHkHnxY/q+ravXuSrMqD+B8U2MfHvo1HTkg2vXN
         E1UTG4VhjAYNTcEIvhhy0xBf0mIA4bsaoYhQhXot4ARqXLTtDb7J5FndmONtjxtdE3cp
         uVZi9BcSjhGoCK31FKoyeF5s/4WYKQK1bdOd0JedGNA2letx+T0SWMLixv1MpNd+/ZIv
         wnDbfHLC9JlGLpkdDZDyU2g91QWbb9lQfiEzUll545Q34lfSrKVkyx0XWOm4Ew2UCvQj
         F0nOJKnDt2f/9Te8aeWvePJIj61l0wyZ8nzK9k9YCFyThvfvle8IL9STXUMOqmjmL/+X
         Ch1A==
X-Gm-Message-State: AOAM532AwIARaMkTTX/SLmgIkh4Pp1slV3uxTE+y3+DXIwoAuPX+GVf0
        F+k0XkooTdgbmbI7wk/QhwA=
X-Google-Smtp-Source: ABdhPJzYJ0XEV7X4OHDBuKxkQBv0XNclWfpmKF57dB0MkBDhEMfiQaFYfOcZsxuLoO0W9EPU3N4dCQ==
X-Received: by 2002:adf:c409:: with SMTP id v9mr11160020wrf.102.1627153528189;
        Sat, 24 Jul 2021 12:05:28 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id j15sm1117798wms.20.2021.07.24.12.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 12:05:27 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v3 2/5]  dt-bindings: iio/adc: add an INGENIC_ADC_AUX0 entry
Date:   Sat, 24 Jul 2021 21:04:46 +0200
Message-Id: <20210724190449.221894-3-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724190449.221894-1-cbranchereau@gmail.com>
References: <20210724190449.221894-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The JZ4760(B) socs have 3 AUX inputs, add an entry to prepare including the one named AUX in the sadc driver.
Leaving the rest untouched as it's ABI.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
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

