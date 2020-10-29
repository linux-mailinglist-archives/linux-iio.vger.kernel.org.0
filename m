Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF0429E4EA
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 08:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbgJ2Htd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 03:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbgJ2Hta (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 03:49:30 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8CCC0613CF;
        Thu, 29 Oct 2020 00:49:29 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h6so1666744pgk.4;
        Thu, 29 Oct 2020 00:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CMlFtGrdeVtaOx7nt5ZPArRY2VyBCH0dW+8eWG0qLW4=;
        b=HvFCJ6arHGB/fbzycTvZdkLR6Xp9z2jfSltOBnO96Z18/92E6aFgxyuguq82Ti3+NK
         4k4bFP236wuKqrDH4WCE1n8+TxMiSg12mHN8EiNzvyXGclE2fejGINwDnzoXz2lzZKMB
         ZfCVsVXuhSn1xqtTOwpiTGEhHyCJcPAgNXbwfN0bEcjzrwwO4h+azi4V0WSRPZD3gh9x
         /aYOmFS4/u7SIbgJrvONi1XJMYXSB6fzv7waAAas2p6PQVL7IQ0ePmdvFIWPbP+2HDpr
         Al6q3bMnu4L+h7NiXPy2B10ohFfgPMlYRqFPwpWylW0ImRF5Dwv70uuEai+FqDTgZNeG
         1E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CMlFtGrdeVtaOx7nt5ZPArRY2VyBCH0dW+8eWG0qLW4=;
        b=GrIIp5AZm7Na59+K1mtENBvPRuNixLrSJBbtTGNwlZxfKZhyLN7ebDnbOoOfIFwCDW
         wPbk5QYSgWZ4dSe9h8IF6w4aG7xXAyG0K/4L/iN3EpcL1bbeYwX2DPN+5jnn/Rl9awcQ
         mqLO+CIo4WoY0WTm6sEUpZPR+J7egWFQF110xA9G7WbnHMCWgXS39aY0NjHfEglc5XPI
         Yyiu/8nBzgLs+lzLxSL5jpfs63EhyFLuzzNVN/WbintLnrzVt4x9DsF1fmpSg5rHU8/w
         vX7r/XpbHnyqhkaZsIMUnKh/98IJ1tDl96PXhEzwdXw796sAN/Ojqv/tXmMtvt/5yRy6
         an2Q==
X-Gm-Message-State: AOAM533lgL+p8cZ17zolzGl6Ua8AfkMFziZVHG3G7YtnUkR59Cic7EdS
        YCs0Tmt8U4v6dwIanBnbOJ4=
X-Google-Smtp-Source: ABdhPJzkt+a+hoR+OTQD3e8JDRRM7aCEAIYhmd/wEUueauxfJPE6sVr8v+gy77ie6RtQm5OU9+dR1Q==
X-Received: by 2002:a17:90a:d30a:: with SMTP id p10mr2972316pju.15.1603957769401;
        Thu, 29 Oct 2020 00:49:29 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id o65sm1684688pga.42.2020.10.29.00.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:49:28 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:48:56 +0800
Message-Id: <20201029074910.227859-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/iio/accel/da311.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index 3b3df620ba27..55d4891556ca 100644
--- a/drivers/iio/accel/da311.c
+++ b/drivers/iio/accel/da311.c
@@ -263,7 +263,6 @@ static int da311_remove(struct i2c_client *client)
 	return da311_enable(client, false);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int da311_suspend(struct device *dev)
 {
 	return da311_enable(to_i2c_client(dev), false);
@@ -273,7 +272,6 @@ static int da311_resume(struct device *dev)
 {
 	return da311_enable(to_i2c_client(dev), true);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
 
-- 
2.28.0

