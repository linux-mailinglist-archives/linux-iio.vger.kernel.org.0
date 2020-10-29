Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3670429E50B
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 08:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgJ2Hu6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 03:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730926AbgJ2Huz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 03:50:55 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC71EC0613CF;
        Thu, 29 Oct 2020 00:50:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so1672272pfd.3;
        Thu, 29 Oct 2020 00:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THrwcXVbjUvT+jPdEmUpbr/nwiN+BAsULiXndCP+bxY=;
        b=AHd+uqwc6YkRU/7Os7FqyGGstxrZ1bhXPSAduYSr+SDK99AaLWJkwzXvVtDfBoonMx
         tRvv/Iq0uGItt4pHNFwPEcLMLPe9OWCI8/TAwYI7KWsM8T/1qh7id97Wia8AXoCTVmJ/
         Pg9MtaKeO+Uu54ou+su3qEA+w85R1pzVXyNDlpco4yXtz2a/g3VzI8dSqaWcRIrAqJ2e
         4R2uoxxEP+vdC4PfeMYCNnKdjSAj34ey5msjrlsk4O6255MqJhTGeGd4susWYdVZ/wa5
         l3oEbi568XnSRSIMP4YkwYoEKQTXwo+v4rsnzxtss+jikdFQUk11tV7CZlLZfgrZ2Pnj
         D8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THrwcXVbjUvT+jPdEmUpbr/nwiN+BAsULiXndCP+bxY=;
        b=gqYaE7OgDZSgZo9ScBi1ZXYNfKg3Y9rHftVxB9EI78J0sJUQiWIltOhCaWIgD7sxuY
         5mh3AYW9cRt661fldxuYXcZQS8Xqo8QLYrteB1v/aR6AkArfTDAmXPrdwadrPMGKKqD2
         mwGHRStOaw2MKs3//Erpn6w6HHJ1MwgXJ0rTWntG9TPq1HjMjkxaU4nvI8X8PT1woxct
         5AZVPsXgGfX4DD29dlQYPP4eNXDkuwoJ0Zjv4dNAUpjprgYAKASbZgU1wby0Ty+Cxo86
         OY90NkZz4yykbm/6q+GT/+6VsON8W8gM38fCsQWgKWnk2nSrU8dxxQQN6cmv3vvMW0pd
         cvUg==
X-Gm-Message-State: AOAM531ndUav3ysVYi3MHOZnxmz8dPzLIASQVCahm3/zhoL7UX1DPqNq
        04Cu/6AEERgZpRHGocvuBElQZjpIKdP19Blz
X-Google-Smtp-Source: ABdhPJwsycZmyVlHUcOYG+/ytelpDr0JA32dwcWKC5Fdq8S3BI28UvFjhqgsbwXMdQfm3+EgqrSDTA==
X-Received: by 2002:a63:cb4f:: with SMTP id m15mr2958825pgi.281.1603957854518;
        Thu, 29 Oct 2020 00:50:54 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id d10sm1641975pgk.74.2020.10.29.00.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:50:54 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 08/15] iio: magnetometer: mmc35240: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:49:03 +0800
Message-Id: <20201029074910.227859-8-coiby.xu@gmail.com>
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
 drivers/iio/magnetometer/mmc35240.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 65f3d1ed0d59..37d330220433 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -521,7 +521,6 @@ static int mmc35240_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mmc35240_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -548,7 +547,6 @@ static int mmc35240_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops mmc35240_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mmc35240_suspend, mmc35240_resume)
-- 
2.28.0

