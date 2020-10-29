Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A203C29E4EE
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 08:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbgJ2Ht4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 03:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732050AbgJ2Hty (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 03:49:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3428C0613CF;
        Thu, 29 Oct 2020 00:49:53 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o7so1667059pgv.6;
        Thu, 29 Oct 2020 00:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0pJyw5e2uVCaJHwgv8O5wRSAVHlgce7tiNX5svglHsI=;
        b=Ix2lmQl+DWYLKLA5is7LbnytJ0ADzwrgbCCN0XUD6Ufr2BzUCcTw5cpeujwfjaAs6J
         EJw+5iOFVfEBp1FclITejeT0AHVB2r8TcoQrzdYn956WgfLXmN7vPc9M77rCwHcfO5pH
         Fq3ePKfGkQTwcCnEwdyCdgrKcCLr/2xZ6WWiC8wujgufIHoeUWN4WyyW2+4SpSNsqj02
         jRSym5jsnpgpw6JaQWwwhPhtyh9q64Fk8lPKC1x/pWR8tQukiHqRzCWdobhplCZaXRRz
         1pw8QMGykw3fi6Atelwxb8PJwj8bhrjOdwimXM93Xtg61jcVeSKzm5V1RJ6FFX1W33gx
         3j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0pJyw5e2uVCaJHwgv8O5wRSAVHlgce7tiNX5svglHsI=;
        b=GHmnBA5tp3bUpQeE5X2funpoVR178YjaRVAWfgf5fE1ranb/cuTlwsV4OOTIYey7XL
         vvs6rJfS9xVbXcejxm6x90IzIt2Nr7SN2ufLmg1P9aHnr/2vBnos+r2m4vTQkP6ZI0Uq
         kU2IO16AlllGvFYSk5oLOn811UcrmbgPWog/yklBpVdboQNSMQ1Vw0pNsfh7HwfBlqIl
         wlIXfPn9Dy7HCNyNbX9UsipsMmjeR72ssvsQ9Jjd8V7cx+DpBFZEtj+Ka0L6OZXg/yTQ
         jw2sCMB0HkwNTWRNgGsae2R2D+xJiICizoXBwHkCD5rorUw55+sejbX7kJMZLHv5Ev84
         ZOPQ==
X-Gm-Message-State: AOAM533ANgUZyNi3mIp8m9D7VN9WYkR8tg3GNkeOTJnJAF0l0NNd+Fxi
        GnhOYTCaLqmua3L02EBBLvM=
X-Google-Smtp-Source: ABdhPJyKozwZeTEYEB7sGwKwE9Yj80kKs0aun5z7ovTUm/3VkWT8z8w3TGILmWrop7s/FZR0944VvQ==
X-Received: by 2002:a17:90a:dc85:: with SMTP id j5mr3007974pjv.38.1603957793539;
        Thu, 29 Oct 2020 00:49:53 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id m23sm1619046pgk.84.2020.10.29.00.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:49:53 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:48:59 +0800
Message-Id: <20201029074910.227859-4-coiby.xu@gmail.com>
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
 drivers/iio/accel/mc3230.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 46e4283fc037..b966922b9899 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -160,7 +160,6 @@ static int mc3230_remove(struct i2c_client *client)
 	return mc3230_set_opcon(iio_priv(indio_dev), MC3230_MODE_OPCON_STANDBY);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mc3230_suspend(struct device *dev)
 {
 	struct mc3230_data *data;
@@ -178,7 +177,6 @@ static int mc3230_resume(struct device *dev)
 
 	return mc3230_set_opcon(data, MC3230_MODE_OPCON_WAKE);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
 
-- 
2.28.0

