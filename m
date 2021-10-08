Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405704265F4
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 10:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhJHIeZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 04:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhJHIeZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2021 04:34:25 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B3EC061570
        for <linux-iio@vger.kernel.org>; Fri,  8 Oct 2021 01:32:30 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d8so8809936qtd.5
        for <linux-iio@vger.kernel.org>; Fri, 08 Oct 2021 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegavinli.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CuQc43TsflIOCAYBelU1TeQkoJRI6u+Uowu+amwKiDo=;
        b=ayUCJhkMVIxGb3t8TApIVUsDW2pAU5ptYceyCEulLCKVSsrFECTrbhTHZ/PSbL/Qr6
         AI05GPqn/vyH83tANZaDeyL5iNfpskPJeQ/bLGhErfEQYQ3BO7ROmMVDrNQCUrkpyiYR
         DWhEDJnIeOFyvBbgpLpcOMIzfME5VaCqkzX2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CuQc43TsflIOCAYBelU1TeQkoJRI6u+Uowu+amwKiDo=;
        b=15g98PsU1yBe1X0JIWYpNj16uxpe5L6A5JNZCsVugQGL0GGNA7n8tMNkfu7847Vkhh
         vu4gWALXoH89Z8BN3onW8pOz3aryLb218UQFU81jDRLcbFHGre5ow5ch0jtKsf9UkqFC
         oBT8Uem61H2drbP101rFhBm675iqEX04jSuICxYE6+1INfbItjBhGOGhWYRnRSZlqY28
         iVNtISXtuc8sVW6wD6beKVQ/zxUWKPf3dr42mbi76BanrO+6k/KMJmPO1U8E4WMZH4q3
         AIU3swomB2LsYUV13pfTTZnbr1Meft54PCxoL+2zoQd3nZpYecGXx3d4I7nBghFpPt8F
         qIPg==
X-Gm-Message-State: AOAM530KRNQ97TMKPIoORQ01VwNrfgDk6sK+q0P2sq+lJAVDEnhyXlSY
        0CH1eZ1Q8Nq1LHnKm+dfNlnDl0IKHoe/+g==
X-Google-Smtp-Source: ABdhPJxe+YR++Z4iBDJuJLTGDNEK0WZp+wEc/gCAW0R4vqSWySfkI0UkUBNk8M2sb0Bdb/D7vtjGfA==
X-Received: by 2002:ac8:6158:: with SMTP id d24mr10501207qtm.115.1633681949240;
        Fri, 08 Oct 2021 01:32:29 -0700 (PDT)
Received: from mtgav.corp.matician.com ([38.88.246.146])
        by smtp.gmail.com with ESMTPSA id c6sm1726398qtx.72.2021.10.08.01.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 01:32:28 -0700 (PDT)
From:   gavinli@thegavinli.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gavin Li <gavin@matician.com>
Subject: [PATCH] iio: trigger: fix iio_trigger reference leak
Date:   Fri,  8 Oct 2021 01:32:20 -0700
Message-Id: <20211008083220.3713926-1-gavinli@thegavinli.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Gavin Li <gavin@matician.com>

viio_trigger_alloc() includes a get_device() call added in commit
5f9c035cae back in 2011. While I wasn't able to ascertain why it was
added, I've noticed that it does cause a memory leak, especially when
rmmod'ing iio modules. Here is a simple module that replicates this
issue:

    #include <linux/module.h>
    #include <linux/iio/iio.h>
    #include <linux/iio/trigger.h>

    int my_init(void) {
        struct iio_trigger *trig = iio_trigger_alloc("leak-trig");
        if (!trig)
            return -ENOMEM;

        printk("iio-leak: %u uses at A\n", kref_read(&trig->dev.kobj.kref));
        iio_trigger_free(trig);
        printk("iio-leak: %u uses at B\n", kref_read(&trig->dev.kobj.kref));

        return 0;
    }

    void my_exit(void) {}

    module_init(my_init);
    module_exit(my_exit);
    MODULE_LICENSE("GPL v2");

It prints the following in the kernel log:

    iio-leak: 2 uses at A
    iio-leak: 1 uses at B

This patch removes the get_device() call. This shouldn't break
subirqs with iio_trigger_attach_poll_func() because a reference should
already exist via indio_dev->trig.
---
 drivers/iio/industrialio-trigger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index b23caa2f2aa1f..93990ff1dfe39 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -556,7 +556,6 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 		irq_modify_status(trig->subirq_base + i,
 				  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
 	}
-	get_device(&trig->dev);
 
 	return trig;
 
-- 
2.33.0

