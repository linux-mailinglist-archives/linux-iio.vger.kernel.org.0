Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63270418AC3
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 21:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhIZT2a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 15:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhIZT22 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Sep 2021 15:28:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22D3C061575
        for <linux-iio@vger.kernel.org>; Sun, 26 Sep 2021 12:26:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x7so45128100edd.6
        for <linux-iio@vger.kernel.org>; Sun, 26 Sep 2021 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5GrBVYKyGe3R4WdYLhUpWL5eCxBj8V0aX1OyU1mgO6s=;
        b=eGWlTFMYyBzQ8KGJEy8oBccT7qiz60OJL/J6hXnLpZGOgWs3dxBDIfJUnzJGF+WKuD
         sVY8Jb6ICIrKiyoAdPKRHuUVAkxeQ8HSXLU6g67Z+Z/fJvVzk1mYHUT52mcUl9EJBJ+t
         jWPwbxHAWHJ1w/PayA8e5SJUry5H1q3rZadSoNuoRJ1L3n+RW72NjfaQTLQOmBnu5msw
         rU63bng1pS9KO8JfqJGS31SMefCAcDNNye0Y9qHwkt43uyn8tU8N0zlVJXf+b34JbeLT
         SDKpzmYwGIzcjxIpQB4jgq8A6O4YmIYLvzLFZHBxaAoWbHACfHI8+n0L6+fHQKZ3f/aT
         F6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5GrBVYKyGe3R4WdYLhUpWL5eCxBj8V0aX1OyU1mgO6s=;
        b=5tJ7e0j8EUqMLaEsPJSJ2hNnUyIKuIu47O60RW3qqqifFG5pfhG02Ab7iPSXV9ULYi
         ch630119BSQ8KNsFvaAR41eE6rcx0UdF2zE2wX7bb+qOu9GbP5XHAitCRcZQwzFBMmqr
         4rTb1hE+Muc+Yec/eKiF75V2/MVzTWlkyfE6/37T9KWe6PPNpOCi3xR5WuDyQd5jF90R
         uAbC9uDDy7f02ZQRDCifPLAWs/grM5N8Y8nWsVnnKk5+pGruHKQtnmp3wJFqTyiEPohY
         RcovzJZuI3UtVLWnCu44WQyHdebIxaVB4YIFs2/8mFIzD2YJ47c8oQoYMoe0W8bC/QF0
         fRdw==
X-Gm-Message-State: AOAM5318GZDo5gSawh3iBdBubh4YxPScCt31k6j6erzldbWiQtvfTDTu
        Ph6NCponv+dabZwQmy3W2PLjTDL4cnpjpA==
X-Google-Smtp-Source: ABdhPJzQ5pDL00oTPKYzM/A/GVu1jizKhJ0cRgwq7Oy2UYI29DA+H6TdRU3E9pKqYZ1FJnZTe2Lstg==
X-Received: by 2002:a17:907:7848:: with SMTP id lb8mr23056281ejc.494.1632684410181;
        Sun, 26 Sep 2021 12:26:50 -0700 (PDT)
Received: from neptune.. ([188.27.128.17])
        by smtp.gmail.com with ESMTPSA id z18sm9183078edq.29.2021.09.26.12.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:26:49 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 2/2] iio: adc: Kconfig: add COMPILE_TEST dep for berlin2-adc
Date:   Sun, 26 Sep 2021 22:26:42 +0300
Message-Id: <20210926192642.4051329-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210926192642.4051329-1-aardelean@deviqon.com>
References: <20210926192642.4051329-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Otherwise most build checks will omit this driver from a compile-test due
to it's dependency only on the BERLIN_ARCH symbol.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 0ceea8e69e3c..8bf5b62a73f4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -354,7 +354,7 @@ config BCM_IPROC_ADC
 
 config BERLIN2_ADC
 	tristate "Marvell Berlin2 ADC driver"
-	depends on ARCH_BERLIN
+	depends on ARCH_BERLIN || COMPILE_TEST
 	help
 	  Marvell Berlin2 ADC driver. This ADC has 8 channels, with one used for
 	  temperature measurement.
-- 
2.31.1

