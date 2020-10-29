Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0263929E5B8
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 09:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgJ2IDT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 04:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgJ2IBA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 04:01:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C053FC0613D3;
        Thu, 29 Oct 2020 00:51:26 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b19so923205pld.0;
        Thu, 29 Oct 2020 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZ5UHJU2k8+XmvcH/IvrsRU5Xn67KNu8TMpKLwowKVg=;
        b=DvqhbcjNnrs6ueCs8a1BmDbtqqE0qoULXOUahG0UTo2wUKeAt2R3YTs1Z361bm0W5q
         SBC4oh/uvWVwlfG84lemEgjF2uQ/DeT2/dCQt94dg34OaBHae5araLdtkdjLlPQ5x9p5
         DhTn1jn1PHyhXRcz7EOoSd/F0dDpnNri2fE0uLzQopWM14qrUUHWoJxITOuc2CyauKBi
         xH2AAbVdD+RVFdZ8XkIw4S8T9/IdnQ2M8/5XgWvz+o2Se0XSM7XbnZ1Fyy/E9u3iHTDm
         pMwhPrFNGO5mEY3wAi7UmL6GuL4fvaVPl+8CgykdG+EiRNwoPcM4SoKUzWccNIwWDG4m
         /bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wZ5UHJU2k8+XmvcH/IvrsRU5Xn67KNu8TMpKLwowKVg=;
        b=PDPqVxoSgFiZP0/2vhFmp358QgCIohQ/3Lz+yUao7IgXViEU0Rmrff0fe0PNTU39y9
         NTDhUwNCtRu2kjJVrb/ib0J1SjQxVSfaCbWBlHmBmbLuU+vU7gn2AKmI7vOaxkL5loeB
         vG13GvJnfY970B/QATT7u0ArmSzDYfW8DJRvZy9W95SnqRDuwnasBy2ACYXhYClY7zsT
         5/QggBO/ovJ5vc8HxqK/bt1md1m8QYFfG9nYP/cJiMLvnBp1G2woSMCSGoCqB+VwumXy
         NbqWYxDHrC1oKfI7gn3u++JeQS0RPb2FdfWgjqmY3FMwV0nblRB/fvfa7r5+pyzOzvbS
         8UXQ==
X-Gm-Message-State: AOAM533koEIsFnma07UaT1O41ZrluV6k6v8B1IwP+sSMg/NeuS0EZ+5N
        zvBzVAjYCtKmCEqTjOBvERY=
X-Google-Smtp-Source: ABdhPJxUd8hfu5jLHk8b3gLp8SIAvXM7u0B/XPH55zRwpKYA/OuaoOOEfJhbC5tysbGRkvrUXYfrzQ==
X-Received: by 2002:a17:902:9887:b029:d6:681b:baaf with SMTP id s7-20020a1709029887b02900d6681bbaafmr3027313plp.20.1603957886390;
        Thu, 29 Oct 2020 00:51:26 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id s4sm1755525pjp.17.2020.10.29.00.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:51:26 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 11/15] iio: adc: at91_adc: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:49:06 +0800
Message-Id: <20201029074910.227859-11-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074910.227859-1-coiby.xu@gmail.com>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 9b2c548fae95..445072b239a6 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1350,7 +1350,6 @@ static int at91_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int at91_adc_suspend(struct device *dev)
 {
 	struct iio_dev *idev = dev_get_drvdata(dev);
@@ -1372,7 +1371,6 @@ static int at91_adc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
 
-- 
2.28.0

