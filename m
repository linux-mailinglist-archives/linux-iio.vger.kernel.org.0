Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520BF2A28E0
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 12:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgKBLRp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 06:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgKBLRl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 06:17:41 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F80C0617A6
        for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2020 03:17:39 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c16so9110928wmd.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2020 03:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/9TDBFkwsPImsBjfpGpaexi0rG7a4RAKhnLgFdi9lBU=;
        b=p9qFu0BpUJTlOVgEror2jkOfsxfrEAR1GhEgdZVoCEa/xyFB5doa11SpWC5MjIUy5X
         7hAL+0xX0QaOmktAUlVWjAVk59qSK8xzuC2lGkvaY1liDarKXC30cWslXAvX2QmENOck
         OTZmDBtfJOLwNSm/JUICZuTvv/JXM4OI8N/b+Yuwn1g/VoDTPmKLbDfWs3WvgFwOwVPk
         rjhLTVc6ewSDsfX1mo5jwp2BbKmM2ibAxRsYFVrXgfyOVdEwbKzvYp1tIkSfi2/jutAH
         4KYYJRN0ogK2Zj3NPYh9lYcJob8CAFCvUTB0uo0pQaTpC0zHSqfBZDtwU4qBg5chMTPX
         6ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/9TDBFkwsPImsBjfpGpaexi0rG7a4RAKhnLgFdi9lBU=;
        b=DTe2uOODMWOrtWm40z5jazUv06Fk3/WTWHrEI9yUaUmJsnt10/Da9FSLEAW1hh/K36
         D1RI95Q/OyPUfVdzKEwRYEYTKMQTx9X4tzDjZbha13gv+fvU1J62oat/o52nhTfOihIH
         SSSIgKqLKV6xVuxssWcXLjXrm+6wEQCXQ+t4aDqCSovLulglWusK5vbJExd0bbs2yRN/
         JmS+b0X2L1nFwP0WVhOz1PZ82mft+0Mj+dZ1InzZuxZIQuTMh/U//Fsu8AwmurDAw3J9
         +RMVA2mOZ3mQh7ZnkSGMGwk/ZATouIqu7LdtCYmQ33roCu0GUMkpFnY9o8GkgSqhPasT
         CqFQ==
X-Gm-Message-State: AOAM530UgPYSrqb7NgfNZ/diAP49UXl1qLDUrGlYAwBa7jrtHlCYkHYn
        rCSBb2aG+N49RDGABGLMTrrU2w==
X-Google-Smtp-Source: ABdhPJyT3GgYbCvTSQ33OIzdhQZTy3ZEKP0o6pmSgFuOwTCK8uxYIKEZAZWSYHK3OWq3k+CiuhsgsQ==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr16978857wmg.124.1604315853651;
        Mon, 02 Nov 2020 03:17:33 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t11sm11188509wmf.35.2020.11.02.03.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:17:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/1] iio: industrialio-trigger: Use 'gnu_printf' format notation
Date:   Mon,  2 Nov 2020 11:17:25 +0000
Message-Id: <20201102111725.1048562-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/industrialio-trigger.c: In function ‘iio_alloc_pollfunc’:
 drivers/iio/industrialio-trigger.c:338:2: warning: function ‘iio_alloc_pollfunc’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/industrialio-trigger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 583bb51f65a75..1d65c83439d84 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -320,6 +320,7 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p)
 }
 EXPORT_SYMBOL(iio_pollfunc_store_time);
 
+__printf(5, 6)
 struct iio_poll_func
 *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
 		    irqreturn_t (*thread)(int irq, void *p),
-- 
2.25.1

