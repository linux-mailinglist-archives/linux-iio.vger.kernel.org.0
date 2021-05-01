Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605C1370825
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhEARQ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEARQ1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:16:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09BD7614A7;
        Sat,  1 May 2021 17:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619889337;
        bh=5ueDYr0qt5lFLQGYzL/flyuvpjm0mo3gJVomR6JeEBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZpE6LXcCEhvv6H1E2v6ZqAMlItiwJHwnB7YybKmHNU+I7jZVDOqCoGSXdWiCz/6A
         KRA0QdZvJGnG0xzJGkjAdHShwmTd7yQu03QwSo8BbhbMfd7KyJGiid/kj8zShPsw4N
         EqkpC8zHgFeFpy+ZkIK0cIMz3pJJejsSXQVU/P06c7e935By5THzyg9+CPTCKXVuIK
         8tUZ+xwp2Jb8HfkUadB2yXsJv+Vavb/dok2CtTC9eR32rfaGvxyxx75F7izXNHW6cH
         9q19f7vyz4Hn2o5itOXSmxpAMQ8X+odTXMV0a0IkTgIiaqRpWQrPf5yMvBuvNBgdvJ
         rF2XHl8A21Q2g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH 10/11] iio: light: vcnl4035: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:13:51 +0100
Message-Id: <20210501171352.512953-11-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501171352.512953-1-jic23@kernel.org>
References: <20210501171352.512953-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add __aligned(8) to ensure the buffer passed to
iio_push_to_buffers_with_timestamp() is suitable for the naturally
aligned timestamp that will be inserted.

Here an explicit structure is not used, because the holes would
necessitate the addition of an explict memset(), to avoid a potential
kernel data leak, making for a less minimal fix.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl40352")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Parthiban Nallathambi <pn@denx.de>
---
 drivers/iio/light/vcnl4035.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index ae87740d9cef..bc0777411712 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -102,7 +102,8 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct vcnl4035_data *data = iio_priv(indio_dev);
-	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)];
+	/* Ensure naturally aligned timestamp */
+	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8);
 	int ret;
 
 	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, (int *)buffer);
-- 
2.31.1

