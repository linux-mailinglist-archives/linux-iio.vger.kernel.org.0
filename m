Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25EC3D5572
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 10:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhGZHkO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 03:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhGZHkL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 03:40:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8223BC061764;
        Mon, 26 Jul 2021 01:20:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e2so10001915wrq.6;
        Mon, 26 Jul 2021 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99+j87ssVKkJjrP2MT67L990hkIFSKz2mYjTZlRIVD0=;
        b=ghgdnGAxha8O5+nBbOIq8yWNqmGlit7NKrru11bJHUBSd9CUK62q5O86uVaabe/W41
         JPYznFQrvCJDP3pHhhwb59d6OymWKztvH32e2ZHBn7lhnzWveCmMbYWT8fZspzPQNVNY
         GT25B/jBCCsLjQ7vONy1h7tjAv7XFq9e2DHPQ/slD8Q5Vcqg0MQB25ZEJ73A1shRYTBS
         07YuyhEPlXUgTZZBii48PsgOd+A6JK6WJLbUEigmYcry0jxnNmkevMb+wteLE0oYHw7h
         rDvqY2caD2Rt4Dv8Ew1e2VuQ/7a3ycfYGcmjYfvdcAWbN2m9HsLtVSkY/q9HHAzPs+83
         jVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99+j87ssVKkJjrP2MT67L990hkIFSKz2mYjTZlRIVD0=;
        b=RXeTiney/ELUPTPmGW64YSUsJwh8Z5agFUH7+8nnJ4AoHLHMrmCRqQuJiAedLLcq2k
         zf5GJ7f+W1NJ/zILEALPbuoMUmtlVDlPstz2/Gf557VZoGVe8z6Upn/jaPzta+zrqkF8
         TPeBJ/fUBPzP6Pqo1VNgGQeMjaXbAK6bns0YFimk5NPS9PsMpkMaoGb0UvO+ap5BtBQI
         vgt/jlCJdRxeMSjdr9m8x6ArBwmmFrB0M4uM1ZkRGm35cjXOTksrJezxK9XGJBTg759p
         Uv+fCep5IxiF+d0RqUJq0o79pAZOV9dAvReQ4j4GVz4mhsYbL/oBJe23235AWG6uM/fo
         hAOg==
X-Gm-Message-State: AOAM530smBr07vfr2ywz3B7x0Fc+pZTIaak8N1AuC13pPRl6LO1KAvTA
        c0KX5ep/AI53R/R96HRFaGyOB1B6cirYvWO1QTM=
X-Google-Smtp-Source: ABdhPJwf78q8+fp8XqXzZYIObW5SihSRFjLCr2/vKd+/5P1VlK/R6SwtGXUzd0JtwjgBxvLQs4PQoQ==
X-Received: by 2002:adf:eccf:: with SMTP id s15mr17476084wro.176.1627287639063;
        Mon, 26 Jul 2021 01:20:39 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id w13sm4799464wru.72.2021.07.26.01.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:20:38 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v4 2/5]  dt-bindings: iio/adc: add an INGENIC_ADC_AUX0 entry
Date:   Mon, 26 Jul 2021 10:20:30 +0200
Message-Id: <20210726082033.351533-3-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726082033.351533-1-cbranchereau@gmail.com>
References: <20210726082033.351533-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The JZ4760(B) socs have 3 AUX inputs, add an entry to prepare including the one named AUX in the sadc driver.
Leaving the rest untouched as it's ABI.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>
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

