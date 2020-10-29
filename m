Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8920A29E4F9
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 08:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbgJ2Hu2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 03:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731174AbgJ2Hu1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 03:50:27 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A7BC0613CF;
        Thu, 29 Oct 2020 00:50:26 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x23so911926plr.6;
        Thu, 29 Oct 2020 00:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zJxq5YLLINBrPbpy8t/40KrlWt7azYyE3vRsbR5ndcY=;
        b=a9k9AMCZPcGplPT+JSsKE0EjCAqn1XU0wCFloQ8CurFVYrbQavZaccf89Elj+ysGl2
         24dJ92UYW8lScNs7J7VqGYw5ZoXIHyQ78kJ27dyQpmMWIiHazw0Mjbcxo/oRXGJ3DKvB
         EpdZrxHjQwRTnca72V7UbMtOnHOKdbA1g5HKyJ3ytKGt+Q51uv5hML09i9NgIoQ6xzUG
         i2Btz1mkojCaIIqI/hx+A1Ms6bJ7tsl/EcKie4lzBBty2w/8lALJ6clXGTn1RwpQ69Dd
         GgZuP+wHgetS5KWe4xhd/LN0Ep4AhYlSO+sqDBJmC/eHjbVkTgSHBJq0BgeoqyUNcyaA
         Ou7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zJxq5YLLINBrPbpy8t/40KrlWt7azYyE3vRsbR5ndcY=;
        b=dP51h0u/GPjAhTXFkpEpfn7cCK/5apSCoFOmZOdcn72EzAX8SpjmdXinSNVuhT7EJV
         aUC+D+gC12Akii2r2eX5F5V6pGHmB9Wz9hBoxzBmH3iDjAcu92uyZyZ0WwaZr4uE5n5x
         P2i5EGikmU6R7u8hjGngqLUswtXwOiY+WjoCQSW/7loTDxYBrJIxMnUiLxx+sHTArfA8
         gPuNG8w6W78ZmqR/lG2JbOW5DjUTjj2y8JbIiUP9gsblRYNJbXD+bqwnSeMJuns76ach
         a/TvzSwI5S5gX6psk2weefNuqZDvgRRPXc1F2prKT5P2Gd7PEHUlclOvjvpX3scq7QKZ
         H98A==
X-Gm-Message-State: AOAM533ma9IywGxf1QnUPf6WUxo+PRtEqPJKpiYgWXeDKLKhiDD+4d0T
        fiQWHYcnwZPMHdo249XP6JQ=
X-Google-Smtp-Source: ABdhPJz1fWfIIOU7sm75x3JVIEtzYhq6AxzBzUGK4Hg3dlsk2mTx/X7/K9r7pTog6bQPVlMhiC0qqA==
X-Received: by 2002:a17:902:9890:b029:d2:2f2a:584e with SMTP id s16-20020a1709029890b02900d22f2a584emr2840332plp.29.1603957826017;
        Thu, 29 Oct 2020 00:50:26 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id d190sm1865105pfc.185.2020.10.29.00.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:50:25 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 05/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:49:00 +0800
Message-Id: <20201029074910.227859-5-coiby.xu@gmail.com>
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
 drivers/iio/accel/mma9551.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 08a2303cc9df..c3b7a1633907 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -558,7 +558,6 @@ static int mma9551_runtime_resume(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM_SLEEP
 static int mma9551_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -584,7 +583,6 @@ static int mma9551_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops mma9551_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mma9551_suspend, mma9551_resume)
-- 
2.28.0

