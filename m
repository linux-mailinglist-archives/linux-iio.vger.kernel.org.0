Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E248C1B822B
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 00:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgDXWow (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 18:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgDXWow (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 18:44:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B2C09B049;
        Fri, 24 Apr 2020 15:44:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d184so5519348pfd.4;
        Fri, 24 Apr 2020 15:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrRqQizheOvH/qCAN4bWl/aYIkfBy7BwNmyYYA+VSq0=;
        b=Pfm40cwQQa63jKELU9lOW7PJCoNTyl0E8w5sdQ1CuTjeOJZyD0RI5cnj9rg5Btr/4B
         2edJFrJ3aBHXYYJtLEClj4T3psb+xI4VxTuVcCm+Oh9XQXv3NL4k4Tss+olVf2lDevBt
         ObUCV+ysDRjyrDbe3IpBFM1QUT7YqV8fAX4OYsWbthAr1WTeHfrLaa+atZiBCDxtDUc1
         C1LGEaVvt4ITBl4XcHzvg/B6ZMetQookwqlU6qgv6behxD0u0BVhejOU0NqIFYYyQhSH
         lriOU1joqplLCvz8HtkE+1mZjyEJaiWt9G9G976q8qPuZNxoLAnmtmtCezzz1h43+wC1
         /0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrRqQizheOvH/qCAN4bWl/aYIkfBy7BwNmyYYA+VSq0=;
        b=to9+GIvOguJj+xWbfj8RmguVFNNUMJYEAl/0NYxOaIU9Eh7VqYBimt2yPvjSVooEO6
         +6MDeed2oLCWCcsWaKkVrDDGiLRaWIRXFBFbJLVITiHyIRpnWepA9HJ2Z1YV9+HOA0X+
         NF9y25kAwH9fOHSoXa+CP2+KvK4+J+IL6QoQ2HmhGHMTqWlEz945qVbA2OLe/gU2T9ot
         XmK+EbouP05zKFJiBnp/0FNUbWgQVC3858Clv81slQ7t5XykmASkPXKjVHhqcEhGo7iJ
         l/N0QFlnB+0rX0FwMkFIh6Ipy0H/PVfk3h2430a8Ku3hSgDcW3U1fDs90F70Ytr+nmqy
         D03A==
X-Gm-Message-State: AGi0PuZKk4T9NyXZhIVxl9poSQHe42mq37oO5YvKwY73ipNyzhS4IL98
        dKc7ELKR3R6BxvNgrJgTTGU=
X-Google-Smtp-Source: APiQypIi+aOGN27ANQd4v5eD2ENubFefk3H/q/LT7LN8MJKY3ahIMxAcbfaGpOcQyuLIp3E6PukwbQ==
X-Received: by 2002:a63:e54a:: with SMTP id z10mr11306654pgj.346.1587768291654;
        Fri, 24 Apr 2020 15:44:51 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:610b:e3c6:8c8d:27b8:7b5b:c4d9])
        by smtp.gmail.com with ESMTPSA id 82sm6441002pfv.214.2020.04.24.15.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 15:44:51 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, alexandru.Ardelean@analog.com,
        nish.malpani25@gmail.com
Subject: [PATCH 1/3] iio: accel: dmard06: Use mod_devicetable.h and drop of_match_ptr macro
Date:   Sat, 25 Apr 2020 04:14:37 +0530
Message-Id: <20200424224439.5601-2-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424224439.5601-1-nish.malpani25@gmail.com>
References: <20200424224439.5601-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enables ACPI DSDT to probe via PRP0001 and the compatible property.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---
 drivers/iio/accel/dmard06.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
index 2bf210fa4ba6..ef89bded7390 100644
--- a/drivers/iio/accel/dmard06.c
+++ b/drivers/iio/accel/dmard06.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
@@ -226,7 +227,7 @@ static struct i2c_driver dmard06_driver = {
 	.id_table = dmard06_id,
 	.driver = {
 		.name = DMARD06_DRV_NAME,
-		.of_match_table = of_match_ptr(dmard06_of_match),
+		.of_match_table = dmard06_of_match,
 		.pm = DMARD06_PM_OPS,
 	},
 };
-- 
2.20.1

