Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724E629E5B9
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 09:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgJ2IDT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 04:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgJ2IA6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 04:00:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8188C0613D4;
        Thu, 29 Oct 2020 00:51:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s22so1654460pga.9;
        Thu, 29 Oct 2020 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=37IRInXQBrHpwWyuXj6qxmh1TahkV1hoRBjQOKGXhq0=;
        b=YJPMOhTGBwSxNTy9wYJdd3nuCruJq8bno88m+BFzoLTenKC0k4ufnz9BPMa2wMpAKd
         xFdeVK7cyuNWMbQCk+ylDQr3tLhReVkp8WFPBdyGXunb/azzuheiK2YxQzhxK98EWGDh
         bCYU8PMRzK03VuOSZJGmmvb/7bq5wm5X1UUEVKF/JowMkbIZkijf9xmeFEZGu2U6msZH
         C3lzKtWdNykUtHVz0v21eTVcmMRI1K9e9KliAG7Q9QX1fTeysofwJybgncTmHLH6HHI2
         oMPAM8S3Q4g/jJepDT0ibZAOICyuIDFEHhgriIsOrot8g5R2epM2G9uNd+zb3NVQyl7y
         q1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=37IRInXQBrHpwWyuXj6qxmh1TahkV1hoRBjQOKGXhq0=;
        b=GuLayqN8iRQUceqQiataaAjKbqWCzrvN9W/FHVroifMksZwIcUj5uH/XftydBWKJFq
         A0JqoqlXieaJ6Qm7FzICwHL/y6jcl7z+310YbX5vmFwQGax1WQti4NEGhfHHcs2W9+20
         M1Qh8w35XcvxzD6K7qLLB5E/HQlPKpLiQi+obh/dR2hELxy3xHFJRmMYzrF8Bn+fPMUg
         hmkwCjrzrDV9l250e/FOdku5+Yd5Fxwa7FfySyFgESQc6f3wGcMxKFkNPXmmrofMe27c
         O+QP7qeeJE0pMxegqE+BLV0myAQOgnsj2IbOVqoo4hBNIgaAQI4GpDoYQpyCrVKNrupd
         eoxw==
X-Gm-Message-State: AOAM532WEUzrb4dfs9AX1G/AF4zd71tUTZVHrX4WePNzeoAFeXkehkBP
        gpiLzsl2bxmq32FnZX0rgFk=
X-Google-Smtp-Source: ABdhPJz+l0EJjs/nTIIfKLF3+mUQfVEdnj0u0jGOk7RF2NVfyeRZUWwbveWD7w7oXboCYE68pupaTA==
X-Received: by 2002:a17:90a:1501:: with SMTP id l1mr3163731pja.19.1603957894549;
        Thu, 29 Oct 2020 00:51:34 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id x2sm1818933pfc.133.2020.10.29.00.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:51:34 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 12/15] iio: imu: kmx61: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:49:07 +0800
Message-Id: <20201029074910.227859-12-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074910.227859-1-coiby.xu@gmail.com>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/iio/imu/kmx61.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 61885e99d3fc..3b3d44ea8d24 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1448,7 +1448,6 @@ static int kmx61_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int kmx61_suspend(struct device *dev)
 {
 	int ret;
@@ -1474,7 +1473,6 @@ static int kmx61_resume(struct device *dev)
 
 	return kmx61_set_mode(data, stby, KMX61_ACC | KMX61_MAG, true);
 }
-#endif
 
 #ifdef CONFIG_PM
 static int kmx61_runtime_suspend(struct device *dev)
-- 
2.28.0

