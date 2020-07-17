Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9DD224123
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgGQQ5z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgGQQ4F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AEFC0619D2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 88so1607530wrh.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dnBtmSOMI3qCFo9FmJWl9WfxHjSJK5KQqVLRraKU05I=;
        b=upRwI5gMeGvdCbgPj9Hbz2zOy3eA+/cM1dWqW4XaF8zVm1a/FK+TCaV2C0+85l3dlo
         Xhhscxuy1lIt4yUbirxN3IkC3t/t1umvWhZkXmccs6CG5EHwXYsQGPurvMgCK+ZNpF80
         Ggmfa+5tbctui2lwO4pl42VaoSS7xt6YaY4jQAtlAzBemaUl3t4znnhATvkfFEvPWc1v
         Z6Tkx/Q4qD56HI9w8YKnZoJwIVhYKKkjPiFCgJZdvsYuS5WnyM0pCP/4yVkew1pUHA8p
         Sl7kfF2E0kkyBw8Lr6gDxebP4MvXkkRTzPPJUu145D1vAWp22creWVT6dvf50LY296bo
         LQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dnBtmSOMI3qCFo9FmJWl9WfxHjSJK5KQqVLRraKU05I=;
        b=iEadjqU7p8/GRQr+Vd0zKZOTtSOjpLilcT7qfL6EJ3474cYcmgIRwfEcRdrSO7dIN6
         vmJKAzap8imz6XqGNW524BiMM4DkMavHQ0NsdDhLg03y1h9CVDVeLRPZImJ+ze5rXhEb
         EPXbo+4+f/DVLgS2Zm5YDRZCQiA3tGFlzRvHHUovU3zBqFp665PEcEzRATfjF5w8BkFw
         a1GgFKS/hHNOIyaQu7jbZna0uK4pJnr3eQWAI9eIH8JQfRWrfFTVv75O9rlyL+LvpybL
         j5+QeIz6FAI1W3x3a8BOvQPJ76qLLbwokaNBN3XeugRyhyAMPhuOUr+RrZYp/OeFNjiL
         gR8Q==
X-Gm-Message-State: AOAM530cDL7HglxsUf7kn1iIdSQ6shYa0Wh8Qed16vbMgMEqCxqDeJkZ
        zocETxFjA72QHEVuyKlMnFEXgQ==
X-Google-Smtp-Source: ABdhPJw78hm6xyry1788msKvDaJiA9KH6AqlvKTZo56vyvYluhOxS8hz+N6ckrFwd9dGFHPH4WvFyw==
X-Received: by 2002:adf:e50a:: with SMTP id j10mr12017980wrm.71.1595004963587;
        Fri, 17 Jul 2020 09:56:03 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nishant Kamat <nskamat@ti.com>, Balaji T K <balajitk@ti.com>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Girish S Ghongdemath <girishsg@ti.com>,
        Ambresh K <ambresh@ti.com>,
        Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>,
        Mikko Ylinen <mikko.k.ylinen@nokia.com>
Subject: [PATCH 05/30] iio: adc: twl6030-gpadc: Fix some misdocumentation and formatting issues
Date:   Fri, 17 Jul 2020 17:55:13 +0100
Message-Id: <20200717165538.3275050-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/twl6030-gpadc.c:110: warning: Function parameter or member 'ideal' not described in 'twl6030_gpadc_platform_data'
 drivers/iio/adc/twl6030-gpadc.c:110: warning: Function parameter or member 'channel_to_reg' not described in 'twl6030_gpadc_platform_data'

Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Nishant Kamat <nskamat@ti.com>
Cc: Balaji T K <balajitk@ti.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Girish S Ghongdemath <girishsg@ti.com>
Cc: Ambresh K <ambresh@ti.com>
Cc: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
Cc: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/twl6030-gpadc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index f24148bd15de4..a19a6ce65e390 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -94,9 +94,9 @@ struct twl6030_gpadc_data;
  * struct twl6030_gpadc_platform_data - platform specific data
  * @nchannels:		number of GPADC channels
  * @iio_channels:	iio channels
- * @twl6030_ideal:	pointer to calibration parameters
+ * @ideal:		pointer to calibration parameters
  * @start_conversion:	pointer to ADC start conversion function
- * @channel_to_reg	pointer to ADC function to convert channel to
+ * @channel_to_reg:	pointer to ADC function to convert channel to
  *			register address for reading conversion result
  * @calibrate:		pointer to calibration function
  */
-- 
2.25.1

