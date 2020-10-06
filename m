Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C45284486
	for <lists+linux-iio@lfdr.de>; Tue,  6 Oct 2020 06:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJFEMR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 00:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJFEMR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2020 00:12:17 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962EFC0613CE;
        Mon,  5 Oct 2020 21:12:17 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so180278pgb.10;
        Mon, 05 Oct 2020 21:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=HwUCVxLaOWReGj/++nkGikV+jRyqPV3oLYh82Dlr2Zo=;
        b=g1ZUY1XHEAer78d/G/a+EyY3prXdEq+o+f5KAImHzibvav6awCFOgLSxxGn06PpW2c
         osSTFChqonvGurbT/ylDaYobheGShjwCg8tdmiZe/eAcqJo06uNNjKhv0mhgFlPc+GHh
         j6Y47eGgVbkVmaWGi1m3QBdss5dFS5grEq+v+SYHAgdrUJnZYVjWn1/50yciX8JWrIju
         LdyKZshDQHzDh445mUMkoZyimWSgVTiZC56zCo+c1ixuyrBVNdc93Igj0lWJKmqKRUS0
         49VOCu9drvtSdQ6DnfLE5gPDMOswoVV8gFkF8uW8iJfsXHYdvhi2SOWy/FC3oh1VAhZQ
         HcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=HwUCVxLaOWReGj/++nkGikV+jRyqPV3oLYh82Dlr2Zo=;
        b=MqvMeFnVVoJklcAIjD+U5RcWJNxwMLKyOEVWuEE46kmDnJ6PFLoxxs0RM6ie39J05V
         /jNmTxswuUcAgtBW9sh6Q+SoOUr/ElY6OBD9S1O1jI2q/Q2RfvWdpkGyddS5pP+awTqh
         YzA3KJSStXSIZZz4bbckgVuC9l859FJNcJLNap6GyGvjVJM2STbyAe9zTQdgIwJU7N0z
         BzJHP2zCGlN+HnPKzhNNYa7qkuZQwPV8Ut6t7XNgGq7pixmHH9hbe97L3lKzW/Ow+UP0
         27j8ECV91LEqACTy2HQjMfq2xhO2/xJLBc40R729tF3YoYEPED0YL1ScXw59VGJmuSLA
         W3rw==
X-Gm-Message-State: AOAM533y6gPqhxwGxI78FLTy44/6m6BlYMHtdBRMtL8hz4hrwYJIk2lv
        GAGwqta/fp72OeekvGKNNHc=
X-Google-Smtp-Source: ABdhPJzw2Ms221Zj4/SbT46oKwh5Nx3E6AfFsIONc6DxNHFPkVu+HiW5rFl53MV5hurP76A2u1y6fA==
X-Received: by 2002:aa7:821a:0:b029:152:aa68:222d with SMTP id k26-20020aa7821a0000b0290152aa68222dmr2837484pfi.73.1601957536981;
        Mon, 05 Oct 2020 21:12:16 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id b16sm1573170pfp.195.2020.10.05.21.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 21:12:16 -0700 (PDT)
Date:   Mon, 5 Oct 2020 21:12:14 -0700
From:   dmitry.torokhov@gmail.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: exynos: do not rely on 'users' counter in ISR
Message-ID: <20201006041214.GA4145870@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The order in which 'users' counter is decremented vs calling drivers'
close() method is implementation specific, and we should not rely on
it. Let's introduce driver private flag and use it to signal ISR
to exit when device is being closed.

This has a side-effect of fixing issue of accessing inut->users
outside of input->mutex protection.

Reported-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: switched from ordinary read/write to READ_ONCE/WRITE_ONCE per Michał
Mirosław 

 drivers/iio/adc/exynos_adc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 22131a677445..6c705fe599a3 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -7,6 +7,7 @@
  *  Copyright (C) 2013 Naveen Krishna Chatradhi <ch.naveen@samsung.com>
  */
 
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
@@ -135,6 +136,8 @@ struct exynos_adc {
 	u32			value;
 	unsigned int            version;
 
+	bool			ts_enabled;
+
 	bool			read_ts;
 	u32			ts_x;
 	u32			ts_y;
@@ -633,7 +636,7 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
 	bool pressed;
 	int ret;
 
-	while (info->input->users) {
+	while (READ_ONCE(info->ts_enabled)) {
 		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
 		if (ret == -ETIMEDOUT)
 			break;
@@ -712,6 +715,7 @@ static int exynos_adc_ts_open(struct input_dev *dev)
 {
 	struct exynos_adc *info = input_get_drvdata(dev);
 
+	WRITE_ONCE(info->ts_enabled, true);
 	enable_irq(info->tsirq);
 
 	return 0;
@@ -721,6 +725,7 @@ static void exynos_adc_ts_close(struct input_dev *dev)
 {
 	struct exynos_adc *info = input_get_drvdata(dev);
 
+	WRITE_ONCE(info->ts_enabled, true);
 	disable_irq(info->tsirq);
 }
 
-- 
2.28.0.806.g8561365e88-goog


-- 
Dmitry
