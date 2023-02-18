Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A543D69BA4D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 14:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBRNv0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 08:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRNvZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 08:51:25 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D1D18B1F
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 05:51:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id dm15so4003684edb.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 05:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ugOwILDItGqnWXeCELKZi6BjF2LHUvgiL0Us3IpRLMg=;
        b=P6YJafHTR1j+Ko5ukRn/98uaX9nmvZxyR5YvRwLNLabFl92CqaULnc1DkSYUaicVIB
         6Ihxr5X8wsV8CE1i72TQJvN6OFV8IHipi3YzhNxYyLuq7wHa35kfSM2yaiqKuz1zQUFe
         D3p+cFdSKg+uO8s4t9N/UkeC0xvXSsaE2K8FLtYLTldFk0YVLA0KBK02kw+i8Wkk+Wz2
         i4OHQfba1hrncyH3bKftSjbYKivDK11cR/z6HXODBHak5weaeWrk+Z+wOlvsqXwRVLIm
         m7u/AQ5h6CRz6nF6J0AXOw5M14yd2gIyevTEqgnBJaXCVYvSRz+Q/lRUzcLYwg9u4wG7
         XR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugOwILDItGqnWXeCELKZi6BjF2LHUvgiL0Us3IpRLMg=;
        b=v0G8lSdhUw1rM87/RbhvEgdy3/SQz8IxS1AjzI8AfJZ2o4Ua3+jFBC0S08RVBQClL5
         GdaC9xl6zb9LIzecnRNEmsTseaHHYOx9zaEP3uGn0zOQmMV/Ms8nDhZl7NPLZOF3d7ew
         1uvmlG2VqyMWOszy4JOBIP+CYyxyPCy+HULBPTzKJOG+ZXvr4fIN+Dmznp2JxArSEYvj
         o7Rj2icHOh9l1jn4IrrEcvMyVzbVI0xS7nKZ6ym4P+t51goPoHVRDVORVRQ1ZiMxlC0P
         xE5mhP0buqx2EXpChuQZl//tGy6phd2lsX5Cg1Lw47NSaJGyFWP7OGshthQ1Mw4sEh9K
         j2Eg==
X-Gm-Message-State: AO0yUKUmBC05jPwoAwbu3iM5anryFbVkhyGhMzGnvce2HUDYh0fDV5D6
        j5VQLpa89iLm12vqAGiF++s=
X-Google-Smtp-Source: AK7set+nMmE5Idz72LBUO/OpoKTtbdymDJ0h5AmwnCZdaqQ8Bee4ZYBTAlmn2nXedSUVX1yXTaeurQ==
X-Received: by 2002:a05:6402:6ca:b0:4ad:a70c:f9d8 with SMTP id n10-20020a05640206ca00b004ada70cf9d8mr238193edy.16.1676728282576;
        Sat, 18 Feb 2023 05:51:22 -0800 (PST)
Received: from carbian.fritz.box (dynamic-2a01-0c23-5c09-8a00-f386-7b22-bb9a-becb.c23.pool.telefonica.de. [2a01:c23:5c09:8a00:f386:7b22:bb9a:becb])
        by smtp.gmail.com with ESMTPSA id y12-20020a50bb0c000000b004ad15d5ef08sm3616589ede.58.2023.02.18.05.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 05:51:22 -0800 (PST)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     mazziesaccount@gmail.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v2] iio: accel: kionix-kx022a: Get the timestamp from the driver's private data in the trigger_handler
Date:   Sat, 18 Feb 2023 14:51:11 +0100
Message-Id: <20230218135111.90061-1-mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The trigger_handler gets called from the IRQ thread handler using
iio_trigger_poll_chained() which will only call the bottom half of the
pollfunc and therefore pf->timestamp will not get set.

Use instead the timestamp from the driver's private data which is always
set in the IRQ handler.

Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
Changes since v1:
- Add Fixes tag 

Relevant discussion: https://lore.kernel.org/linux-iio/Y+%2FLpcc0Wa2VGsGO@carbian/T/#mec923c14d1324ffabfa88dde225eeb227005b48f 

 drivers/iio/accel/kionix-kx022a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index f866859855cd..1c3a72380fb8 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -864,7 +864,7 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(idev, data->buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(idev, data->buffer, data->timestamp);
 err_read:
 	iio_trigger_notify_done(idev->trig);
 
-- 
2.30.2

