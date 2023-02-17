Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2454469B2FA
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 20:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBQTTx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 14:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQTTw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 14:19:52 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A34498BF
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 11:19:51 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cn2so8107313edb.4
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ag3P3yBndpo1b8YaaLj425xFun53YpUB79EK1lEriuc=;
        b=l6a+F5k0uAsw7E7SetlydY8vQFPUlCZCmMx0UFEBRTDoAnMTLkvHTHROU9LbaGnHrY
         jTh+XuSP9fCGRWnwA19PHtmZcHaizva0jqkdW4T9sR/gaj0wODi7/4o6KHm5aGTRlkNG
         gm9ZVdy64JoS4xu+QX60V3kPMBSJNTF5dDIJ5YDveoMAF33b1tE2y8nM3EWMyeSghuwY
         VXMZY0g0zOdCDQ6Mtl0KaJ74q13dhjSllgm4ZGUH/2PB9v3Y6xJgDQMEDmWykmptonP4
         bfgrOtPA3W87cXbxFh4vPCr88+a0FwrElw38C5WnIJ72r3hzszIpimq/A9klI2FS5ozK
         j7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ag3P3yBndpo1b8YaaLj425xFun53YpUB79EK1lEriuc=;
        b=xoW78brdlNK0H2vIgI1pT2G13mllzrTeudqktRA1dw+xS7+CDkfQIwsZ2UNb+z2qX1
         flF23OUdPiS6Wy4HwqPjKEzDv++HJ0zLMYvLgF5tDECFgW9IdrvdYvSK0ro6Lx8uEQuM
         f4ynkN/7nNCNM01cl5Vmnd6mqbqwf4wWJV8vKOYKnqYnuwHMjlNmuVxiCuH0vp/9nElN
         xraopuREGg0+MJoiglehYXrQuVN7Ur/wT37x4L8aW5b73CwZ3E7YMWElqktrSElPtYG6
         sMm1WdBRqD+nk4cwX5y7X3TWv/UbCwqLjJzb7Z00QpIDp/5Ut9ZivQNwvdLRyda4iCNj
         hI2g==
X-Gm-Message-State: AO0yUKX61aKfUcfv+q5bsB3XZzg3zwJ3WbHo6Nzw3n45grUbmcXL4PhX
        ryAKXfavXVw55GGTilvtaieZgeTBnZs=
X-Google-Smtp-Source: AK7set9pl3kyW1BcqUe+UQzoSxINt8UGIWL5R7KeND8D32qnJlWOO7Jv664QxvTY6mRQ60aUbh4KyA==
X-Received: by 2002:a17:906:90c9:b0:8aa:502c:44d3 with SMTP id v9-20020a17090690c900b008aa502c44d3mr11459048ejw.41.1676661589576;
        Fri, 17 Feb 2023 11:19:49 -0800 (PST)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::af9d])
        by smtp.gmail.com with ESMTPSA id h18-20020a17090619d200b008b9d2da5343sm253708ejd.210.2023.02.17.11.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 11:19:49 -0800 (PST)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     mazziesaccount@gmail.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH 1/1] iio: accel: kionix-kx022a: Get the timestamp from the driver's private data in the trigger_handler
Date:   Fri, 17 Feb 2023 20:19:21 +0100
Message-Id: <d81610c45af55b1c5eab5d0597f71650ff908203.1676661174.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1676661174.git.mehdi.djait.k@gmail.com>
References: <cover.1676661174.git.mehdi.djait.k@gmail.com>
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

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
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

