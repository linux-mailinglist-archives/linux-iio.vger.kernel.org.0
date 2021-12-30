Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6D8481EBA
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241511AbhL3RoV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241509AbhL3RoV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:44:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78A0C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 09:44:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A44F6173B
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7843C36AE9;
        Thu, 30 Dec 2021 17:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886259;
        bh=CPWcE8bxseVIB5XafJFDwwVFa/mzsLzkQX08TUP8lN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vM/G1r9ew+uLRe4xT4mXz/vMeQHpPHcOUjTB6VF3E2voifqnOGUVEEYJ5tyal/gg7
         pd5QMYFV3l9It+mrbwdqdA9WO+naIyvo/777azUKIxGT/EfOTyxCuM2dfPV63rkP9M
         9QUWXOpTnz9P41tJt9zWb0clfnoCkNk88mBVouYeCxjXYQcTL4lmsFPgNPVfkrmi06
         mmat71t33ed449taym7AgY2LnQI+kst8hW1+WNZwx/9axrduK0LGdOXG29uNZSL2r7
         glU8U9x+XJajxwQNFYKMvj2i1O2e5YDUOFtrxLxgd6ZuIg3B7v4fxPbjBnrh6vhBCt
         KnyL9qEixyD7w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/16] iio:light:tsl2722: Fix inconsistent spacing before } in id table
Date:   Thu, 30 Dec 2021 17:49:09 +0000
Message-Id: <20211230174911.78291-15-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The final entry was missing a space. Tidy that up.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/tsl2772.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index d79205361dfa..729f14d9f2a4 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1902,7 +1902,7 @@ static const struct i2c_device_id tsl2772_idtable[] = {
 	{ "tmd2672", tmd2672 },
 	{ "tsl2772", tsl2772 },
 	{ "tmd2772", tmd2772 },
-	{ "apds9930", apds9930},
+	{ "apds9930", apds9930 },
 	{}
 };
 
-- 
2.34.1

