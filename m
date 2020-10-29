Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C541229E533
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 08:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgJ2Hwy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 03:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731164AbgJ2Hwj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 03:52:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D862C0613DC;
        Thu, 29 Oct 2020 00:52:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y14so1639924pfp.13;
        Thu, 29 Oct 2020 00:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6QKT0uDPiR12AaND+XZJ9++tzKNk6nVLA6Y08gKrKNM=;
        b=X2eKfrxr1XpevgR1taGe1YeeLQW1y6aWkGVCUfn81sB5nS3ZSszSQ/Vlcrkyyimuit
         l88GKRHFsLq1hruSdmhoCU9MWBOtfD89wpUgfdTKfucCfS5H13XUCyV2b7YxG9NYKZrY
         PCfgxW49RzmhNA8yhZcIYbgDQuxasyX6pAUxibtKmk1SVJQN0Wd5yD4Y5hL+MKiyVErd
         ULyEaBCSAOgwNU2t8uMBgcXfO8faDtat1zVlH/bO//nxC3OhHyunejghPzyeB7Tp6hOz
         lywAZ4kHiCfe0Qb4EQCQgxgGTgu1vuVJZK8fKjG3bNmuHKlY9g7G7mcJ8azbIxDHLV/l
         K59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6QKT0uDPiR12AaND+XZJ9++tzKNk6nVLA6Y08gKrKNM=;
        b=aftjprGfhUIibbu581knBQY6F9Cc69hBErIrpFY5tuUfNfh+viwLIZ+5Ngg0BHI7ao
         +9BFoM7rEjSOifoFoqgxRbKmraWPxO3EMsy1Z0FfQz3VQwnk6VFS8rTkndNXqzVLOBkD
         3gwd66sF6zTiDWBo9db+snNeBfDh4NETdV/EifmDnm5zK5PPxu9eBcMM/fpa+cql+HY8
         /QxHE+b2WXGL5mXx1fbB6fSrg9jAMgraWLyz8nhCeFuaEWgQ6kqE6GKIPSTGmx/4pL/q
         64FskAP/V8NJFd96D+EyfFPrZE6FtBVy7ybuQeEQtBUoC8trrpBICrPtlmaV99X41JAA
         8TCw==
X-Gm-Message-State: AOAM530SX3pUOPv71/r+30WgNX22jfdsdO6cGVRBB5wfQ8WnTJS2jH0l
        nVnYW3s9xH9XWrQGzzLJIno=
X-Google-Smtp-Source: ABdhPJyR/vVNVZkgwQb9fbxcU230r0R0irNG6iyIzQ+N0rIkhxaZbxQjtX8zGTsnIhEKtqcKVP6jEA==
X-Received: by 2002:a65:5ace:: with SMTP id d14mr2946530pgt.323.1603957920912;
        Thu, 29 Oct 2020 00:52:00 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id j20sm2042396pfd.40.2020.10.29.00.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:52:00 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 14/15] iio: light: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:49:09 +0800
Message-Id: <20201029074910.227859-14-coiby.xu@gmail.com>
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
 drivers/iio/light/pa12203001.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index bfade6577a38..7737d2c8f0d5 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -417,14 +417,12 @@ static int pa12203001_suspend(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM_SLEEP
 static int pa12203001_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 
 	return pa12203001_power_chip(indio_dev, PA12203001_CHIP_ENABLE);
 }
-#endif
 
 #ifdef CONFIG_PM
 static int pa12203001_runtime_resume(struct device *dev)
-- 
2.28.0

